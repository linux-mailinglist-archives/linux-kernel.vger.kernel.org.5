Return-Path: <linux-kernel+bounces-92426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3235E872000
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE881F21CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82ED85C46;
	Tue,  5 Mar 2024 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h93a51GN"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0DD85939
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644988; cv=none; b=ckU6zLtNN6gAyV5Z3hJeNnULgiD8x81yfPEZ1jjKApqyi95HdxYdMbhOBTE/jcBDC1wmxdOjkSk9rP3XuPn3ILGQmCGNXRPmhQjufucjaYYb0XdIyTsO/2+eauRzA+8krXBSf0w5OGMRWvXc6xqRctM6IUSw9zzReWsyZufQa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644988; c=relaxed/simple;
	bh=cED5HjnC7g7JyUtXb+osJjJOkCvVB2fjNwEhn+2BT9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f733Ufl+aiVQBS2XW5qbDJj4A42EybBUWtSJ4qn8PYeOIhdiAdkIv0me3w+VngN5+gGm4n+r5YasAagyuDEMfwCc6n993vxAVxFKFekgcFDNs7nYsIJO3prI0mw8z2RncvAXNRo7ivKQqYmTHpy8Zr77fBcvnz6COBk1D1ypd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h93a51GN; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36517375cc6so15658625ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709644985; x=1710249785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjX01WCP90W/l7pfrR9bOKQ3PAKnBAJRUzQuiATziOw=;
        b=h93a51GNBdjyLHAVWDj0ri8c/GPVK3KkJ6gU1sBfeuDcLfx4VjIYBDyPBfdbmTdpEl
         FFt9bX01WSZwITluvAkTAxxON03GBMklvdolqr1RkpUQ1Y8zwfmn4oAnID4BEBZOwzxu
         t7XF751snK16c+OnP5OpJnuSrhtiCWWdlLkpA5mdRxELmnF9B66vxDjD29yvH4D+lEQs
         Dg4AhuwTSSAY5ctEQM+qk7z1+1pb+b0O6MBHd151muZ6fLSUv4X7PtVGLaTk+gL72Ynn
         RAfZ1lR77EwBu4SwS/1eAnjeTU4CRhYDgpsOYOrQFYeRFv1OrF7WNe5awwp9KJBhfrCk
         Ihvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709644985; x=1710249785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjX01WCP90W/l7pfrR9bOKQ3PAKnBAJRUzQuiATziOw=;
        b=E4fh78B8KuxVCWBuJvFVF6+rJEipwSrl+tjeyKd4uOWbukJYjrSGXApXTKw9J1/77o
         vhKvkSdVLbSeZcb2FN/WCtO9Ls7ljun3TD20VBYw36r8vizdsIWMIfwJ+eOIdp0xodG2
         /G45BefV+MzEgr4Dyi9YyTz1jXF54bt03y+P8L3B0vZ9ZMBvyQ3Z1Mt+eHYnxw2I/Dgw
         P7yX1WuomdJY4jbw7R8Mx3KFJIk5t2bI1sjcHg0Gyh+sD8dpr2snSRtN1AZSd/dC7Lw3
         lkGDubfmBVBRs1w+UGOYyFr1ToQ2uaQr2p3BN5xZ+5zlyb8gyn7SSs0p0XBfTKf7nm9X
         RiFA==
X-Forwarded-Encrypted: i=1; AJvYcCWHjxK6BH3QyA4ToQLthhevgVyYjUVTobhaYSMKkftsS70Nvz+UGReTHsPYB96twbmUMTmlBwOtl9D9MRdbE1MhxOTcG6baUWNiQd90
X-Gm-Message-State: AOJu0Yyt3vZbErQuOe4tI8Qdhx/pkMWCyp5CxZ+rs+fY6a9x4ZcZvuJo
	PDQmjNAFeEe8sZ9SA4y3pgGCZAqkqCrjoL9THMPgT5KUoMbbjlECT12Su7lbZRM=
X-Google-Smtp-Source: AGHT+IG/knXJ7T9xFlaVocsJ+R34uVbYqcAGUadgZXjQaWVCnb+oitowDdNVzrmcplKooD46QXyR4A==
X-Received: by 2002:a05:6e02:152b:b0:365:4004:83bc with SMTP id i11-20020a056e02152b00b00365400483bcmr14668251ilu.14.1709644985671;
        Tue, 05 Mar 2024 05:23:05 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id l3-20020a056e020dc300b0036287013d01sm3084242ilj.36.2024.03.05.05.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 05:23:05 -0800 (PST)
Message-ID: <4e0adf8e-4434-4ead-9d8b-491aeb7e49c9@linaro.org>
Date: Tue, 5 Mar 2024 07:23:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the net-next tree with the pm tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20240305112641.6248c6fd@canb.auug.org.au>
From: Alex Elder <elder@linaro.org>
In-Reply-To: <20240305112641.6248c6fd@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 6:26 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>    drivers/net/ipa/ipa_smp2p.c
> 
> between commit:
> 
>    c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usage")
> 
> from the pm tree and commit:
> 
>    5245f4fd28d1 ("net: ipa: don't save the platform device")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.


Your fixup is correct.  It exactly matches the change in
c0ef3df8dbaef ("PM: runtime: Simplify pm_runtime_get_if_active()
usage"), which is in linux-next but not net-next.

Thank you!  And if you need it:

Reviewed-by: Alex Elder <elder@linaro.org>

					-Alex



