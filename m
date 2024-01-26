Return-Path: <linux-kernel+bounces-40481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22D83E139
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF76E1F25E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDEC20DC9;
	Fri, 26 Jan 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awaCOpmY"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9720DC3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293420; cv=none; b=RdZwIXt9oBdgU7m3gjABCbWTIQpCREhtGYlSMGMS5tpg63T+z182+FtoNQZqjRgChHxm60BJT1BeDhAcEk/8P8S28hHISiyX9STct460FsP7K3dfwFQ1TuuNhWHjRlPUimGrM8m3SoQ7TMdEqDnOuZ122blMNbFKuN3cgIvtA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293420; c=relaxed/simple;
	bh=FKCzDr97iAmkrHekBXaL9AjNcDpyQUn4O75gsCDkIp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3zbEm7OkwzrxYAv4RKwJIFSpiKJTU62QaZOZ8QURqK169n/QHzQ9Lqa63rHHLDup525DBCPJqMSIP81YpZEKR8zGVr3gPvgZsaapYcg1N9uCyKlX6bwSwofjo5R7fgB0kR/vV0n+KgWkVFFZK9X5ZxY3k64jCt96SOSPpvFPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awaCOpmY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a30e90ba9dcso23085366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706293417; x=1706898217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfoCcWxXC+R7fi3WcxdiBA3r0bGMrkof+3fOLFkaCYM=;
        b=awaCOpmYLdA7UGvBYXuGJ6IZvZ2jmyEzfio1uslHGjNY/6Wfeu5x+xc355J1VP9/Nj
         fE2yUbQF2myVzXp0dDZEquPBFrUK4Uu5qTsrMgFziAjaPcDYX/HefQ6HObd6hQFv2XlI
         t91QmVdjrojbkTDX4DipyhhlE5DGNRlAiNzkT44+i/OIQHkwA3qFaIVt8aEwIfgp6fbR
         bUgkoL/ehk6nepzfGon8XZlEffsNa4RuxsxuZ4BpTmIbChmfwkVtxYcDYnpSeUgMw/G1
         5slyg7tIDHBd7MW4Ng0EmHtuoGr3yGQmRVB0StcD1fexVTcTeVcvnLTZ8bKa4zKBNzwB
         9qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293417; x=1706898217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfoCcWxXC+R7fi3WcxdiBA3r0bGMrkof+3fOLFkaCYM=;
        b=m+ytw1/p+3F67v2QlsfvJKmKUelnz/JsPoVxBSbZo3R4rqnXh/d9q7QyKVAbpSFrHv
         Zcj69Nci2VeXupsuXsH5IHVhRZyz75SL9NuCc0m90tGuJf4oxygrm7e/nRWtO2cFzJW6
         gddM2s3A8OJYM1sH3UFnNhivkWoiXF0K3ZTIb4GLnwKcNw9ig2i0l3AlxsDScc8jfvXn
         Fw1ze4JtEZ+EOogx6m7affhOkHBVugGcYu0PAUn5iwn//ajwWo/yIgZUeRwA5F0sf9lO
         O2E1+GtZdmS8JFh+6aE3BW0jJ3GPIMguQDpYgcQXcR8AvsJ2FtvMjOvqKuHlySVzkdNT
         K6FA==
X-Gm-Message-State: AOJu0YxqQokmVchkwOBQYm8NWX82sesCQXt2mtvRpyzACBs5deEd+Px4
	ukan16kC+Wky2Gjni4NaD8NHkAFVMYIVCZTjcixoagIiTHEPIbdn
X-Google-Smtp-Source: AGHT+IG+zQxEY2KWn4VUD5POw2+2aLCecdEJX5ES89tBZ6te8upAb6n8/132MiKvdYBeOQllPAl1GA==
X-Received: by 2002:a17:907:9485:b0:a30:d454:58a0 with SMTP id dm5-20020a170907948500b00a30d45458a0mr60003ejc.5.1706293416634;
        Fri, 26 Jan 2024 10:23:36 -0800 (PST)
Received: from [192.168.0.103] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id g13-20020a1709063b0d00b00a34ace86850sm882090ejf.207.2024.01.26.10.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:23:36 -0800 (PST)
Message-ID: <500c7df9-7347-4ec7-8952-5f221cc83ef8@gmail.com>
Date: Fri, 26 Jan 2024 19:23:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] Staging: rtl8192e: 18 Additional checkpatch fixes
 for rtllib_softmac.c
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240124224452.968724-1-tdavies@darkphysics.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240124224452.968724-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/24 23:44, Tree Davies wrote:
> Another checkpatch fix series to be applied after the series titled:
> 'checkpatch fixes for rtllib_softmac.c' submitted by me, to the list,
> on 1/5/2024
> 

On Patch 2, 5, 6, 17
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit 
description?)

On Patch 13
WARNING: 'unecessary' may be misspelled - perhaps 'unnecessary'?

Is working fine on hardware.

Bye Philipp

