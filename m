Return-Path: <linux-kernel+bounces-73518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E5085C3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7509DB2260D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BAD12AAD7;
	Tue, 20 Feb 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4p3fRaQ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D57602B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454285; cv=none; b=WmD6Tr+ddPxOaHhr6nR9y9STNOzWBr+pNUe+y6RrzblMG1XnODcIqWFXDd4xWKO7qz/iWLGSr+YPLBSbJgwvbOl/VYHxk5LJ92TEkpCfMnOITYnbftutv0XBjfTvk4NrYtpxn9WCq0K0SGWzFh7L9Px1ZxabD5+7vX0se9/XiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454285; c=relaxed/simple;
	bh=dkcc7WbUz3rMcn5nXsHMhiJprUjk/fF2t87GgeJOXRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFfSNcSR2zqfCmKZ+3gWWV5hASpsHU6lhKiz2xwKh2Cp3lmNaRVRJRL6KP0+9mSAhSm3N8Lc1kfqfFdP/kFJWKDEKJ0IkcuA5ntibRMaVbiTuLXrStndYPC4JuIwzIVN19iNP3GEFjiC6HUIIgxbyPfNjOUIA1tronXNVW+x3mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4p3fRaQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc139ed11fso8298105ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708454284; x=1709059084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JX/Yj1kCnJbyVsPRdkM1nK7I97FCu/16cjZAl/ISHXQ=;
        b=N4p3fRaQ0Qxxyws2MTNbZktT+9LfO6ptHreSnb7S9yyP118U5dEgKUb/th4gAXOiP2
         NmfZuoB4Wh43S/KeXe2O4nQO8jFv2KdTyAY56GPPM7uTeIkiFYHmPUBxES+RUXqkUcYo
         X3bW1jWFLAJbgt7rHaZ8JYVfY2yy1dNo8OPtfyJD/BCxtxFR1sTeENuA8vknc2lBvFg3
         81ZjeO3e0i806WvEjA9SwLDk0SxyJarPntajnPEUiaXXjBrvz2rpfplrMC++Jy00aRJE
         3TB6n8HY0BtorxyxCOkzdDfJZf+bgAg/mtdi8GVx3hyu8FDem1hAm6OVkls7mZ3wYztd
         VhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708454284; x=1709059084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JX/Yj1kCnJbyVsPRdkM1nK7I97FCu/16cjZAl/ISHXQ=;
        b=xMELCDmh+UVi9Ry1gXctEnY8vVNTcwo2mJEg8A5hr5BF5xXu7paK3k78icN5g+FnAx
         ysVgOoW4tY6VBMnLjMApBdDucQ9CENK5ADJN5piaolM2T74Of7CdE102jPKA8Xhnu9eY
         6oUCbZe1tWUOE3641adqq84cV8bzUh44B3engh9TiFe+SPq1mv65Yz37ystVByw6CDGA
         igmC/5c5VfxsQNREFBQLvRxpfAesgkk1No3MjpTxMVZ6aYUv7sIniUU5Xr819Y/tYctO
         SjtO5S3ovP9T9AzRm34yYPGMB/xypnUwdDWeP6zwOqX5CYe+MJDyY9reQTFjLycoXylA
         Zd6A==
X-Forwarded-Encrypted: i=1; AJvYcCWPY96ZPPJ5ukdWpTZndt2A+rI6KUaewuhJhmhguDMsQqlc3xIKsyEqU8equ4GZ9vBMEz/62ScSZGvvrBwBYTqsdDG1WfEbQfj8N4Of
X-Gm-Message-State: AOJu0YwgHWgUXgkoK5fRILIiihS0/kOLkvLObnR65m/4kVRsaJbsAuJ+
	Kr3ALlv+raQiNdYwbBlZYT7MZarjtAzegYsefxTfxIYBdO2rMTHpA2Y+z5QnaBo=
X-Google-Smtp-Source: AGHT+IFVZqLGiBAKHk41zN6Bl8H4zq7JOnrKd9cFAS1w9wfBN2y0g3TaaG4lwIwR/6UI9zJB4tUyrQ==
X-Received: by 2002:a17:902:e5d1:b0:1dc:11f:d941 with SMTP id u17-20020a170902e5d100b001dc011fd941mr7153206plf.26.1708454283537;
        Tue, 20 Feb 2024 10:38:03 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id kv8-20020a17090328c800b001d9641003cfsm6551869plb.142.2024.02.20.10.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:38:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Feb 2024 08:38:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH 12/17] workqueue: Implement disable/enable for (delayed)
 work items
Message-ID: <ZdTxisk3zp_eXDVb@slm.duckdns.org>
References: <20240216180559.208276-1-tj@kernel.org>
 <20240216180559.208276-13-tj@kernel.org>
 <CAJhGHyCOgrU9TC9o97LpvAEL2p+Dgt=uN0mo01Gr7HadVSD-Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyCOgrU9TC9o97LpvAEL2p+Dgt=uN0mo01Gr7HadVSD-Ag@mail.gmail.com>

Hello,

On Tue, Feb 20, 2024 at 03:22:26PM +0800, Lai Jiangshan wrote:
> > - A work item carries 10bit disable count in work->data while not queued.
> >   The access to the count is synchronized by the PENDING bit like all other
> >   parts of work->data.
> 
> It is 16bit disable count in the code.

Fixed.

> It misses the same handling  at queue_work_node() and queue_rcu_work().

Oops, fixed queued_work_node() but I don't think the latter is an issue
given that calling work interface functions in the embedded work is not
supported and rcu_work can't even be canceled.

I'm not quite sure flush_delayed_work() is safe. Will think more about that.

> But it is bad idea to cancel or disable rcu work since it can be possibly
> in the rcu's waiting list.

Yeah, this isn't currently supported. If we want to add this, we'd have to
have a mechanism to shoot it down from RCU's pending list.

Thanks.

-- 
tejun

