Return-Path: <linux-kernel+bounces-40717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C483E49E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FD41F22DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A051558AB5;
	Fri, 26 Jan 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="b6ZfJQPE"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590658204
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306740; cv=none; b=qc/SU6dKkEGm0bhn8ys4ottI4vrrWA6uGmJqwfha4uLqpMKS24z+egGDuUHX8xAzF7tMkSF1MER+8oq6dbCb1YqLu3c4RvsiQuqGVkCtH9nQ4zorcJoUNwtJl6z33O/plWVwEw3f8e5u3uQ2i1PMDMq7hKTkmVtLkwaS3CDG+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306740; c=relaxed/simple;
	bh=NjzHxkwFiRux9mikDPOe6otV64eagfv0IasTUR7XscM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdNTbgv2jXmQF6Gomla0MukRraitAy2LcUI0+WCX3mZNMHNtwIH0EmbzgE3vdl0l/zfsg3KIlpMvEUWeGj/GGlDCYbVgOS+5SfnRoL4kDejnMHhRMQDR5SyCqLTPytaNNxskqv2kfVSGtqnScijQFMQBuZQ1hvcEmhTQj1dOEdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=b6ZfJQPE; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd562d17dcso611922b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706306738; x=1706911538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/VNi32mgg+yaX8sJi0wYiHkUmSSEvhk85dc77SV0vE=;
        b=b6ZfJQPE2RD8XAdjlOQNLId8Q0ljeIvxHfLHFLNyrg0ngM11SgrP7Vsexn1Zg3Tq3w
         FMb/oPNDDyNtrxsne0BljAt0ABBDVPgKbMWWaxJJmh6j5J5hqkN1GCxmyM3ocue89QCs
         Ne00D+C6z+0nOKBRDBlJnOwl7OihBr0YMf7UvyOtzBXSM5A+T83TwhbyLiTopT02yri6
         AzyyfO6j8EhrOyLEPzkbgwTsHroKJRuvl9T+YZhyr716MSncoxvr3Scfyni2EfccMG30
         DT5O/pdbS+H8rtxXf8ZJ3OkE5axQAILIvIbqE0fLFsRaBmOCJoH9vzdBh7NpD3pCYVS6
         RifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706306738; x=1706911538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/VNi32mgg+yaX8sJi0wYiHkUmSSEvhk85dc77SV0vE=;
        b=bS42C2mG0xGJDoJGb/0KluYfbxUntysPzT+c1cEqTfJncKUvEXICqYZbD39g0VKY3M
         M28lNHc8stPdpswdfSYqIAuwHVJh233h5Aa95/sIGcftzMpnk16QuRtT8qc6gngFO5K+
         kso4k3dfAqwqWvaIMS47Ls4WczlDxwVC5Rj9ryKSuQDR29WTFtXHesFAM80VAcoPFZGx
         8MEhyQBe8fQTKiQmCmZATnrXlk76v3Yw6Iky/i8+g3ADbjaEbMAmY/XMKZxSLbPKja4H
         JrkzspmikCxF1G1YMTDNe3EHBqGTKel5gq5kymyI6jysaTGC5wsT/gYLniohKoe81ZFK
         sp7w==
X-Gm-Message-State: AOJu0Yz1Oi3MzMzkfRgHmwShXpQaYNVIyZ0AWwmKDQ3o78TQAuxZ6aJv
	X4loxpBCqZGWvegX3cZCqx0qaYbGiEsuDc1I3pwmhX66mpqINH2LWSkvxpu4TfU=
X-Google-Smtp-Source: AGHT+IEwJCrhx+MQIyoLzKnEzHD/N8+lNTGWSq5rKg0iFkAmLUSyqtlpDBnwIfkqhUOWwgdDnujh6A==
X-Received: by 2002:a05:6808:b2e:b0:3bd:58c5:8ca2 with SMTP id t14-20020a0568080b2e00b003bd58c58ca2mr430747oij.41.1706306737870;
        Fri, 26 Jan 2024 14:05:37 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id r7-20020aa78447000000b006dd7b08b336sm1583869pfn.20.2024.01.26.14.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:05:37 -0800 (PST)
From: "<Tree Davies" <tdavies@darkphysics.net>
X-Google-Original-From: "<Tree Davies" <tdavies@gmail.com>
Date: Fri, 26 Jan 2024 14:05:35 -0800
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
	anjan@momi.ca, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] Staging: rtl8192e: 18 Additional checkpatch fixes
 for rtllib_softmac.c
Message-ID: <ZbQsr1OKNwlcTUSl@oatmeal.darkphysics>
References: <20240124224452.968724-1-tdavies@darkphysics.net>
 <500c7df9-7347-4ec7-8952-5f221cc83ef8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500c7df9-7347-4ec7-8952-5f221cc83ef8@gmail.com>

On Fri, Jan 26, 2024 at 07:23:35PM +0100, Philipp Hortmann wrote:
> On 1/24/24 23:44, Tree Davies wrote:
> > Another checkpatch fix series to be applied after the series titled:
> > 'checkpatch fixes for rtllib_softmac.c' submitted by me, to the list,
> > on 1/5/2024
> > 
> 
> On Patch 2, 5, 6, 17
> WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit
> description?)
> 
> On Patch 13
> WARNING: 'unecessary' may be misspelled - perhaps 'unnecessary'?
> 
> Is working fine on hardware.
> 
> Bye Philipp

Ah, Thank you. Will send a v2.
~Tree


