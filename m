Return-Path: <linux-kernel+bounces-50185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1245847572
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E99928EA77
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EBD148318;
	Fri,  2 Feb 2024 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arSuH0au"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837423BE;
	Fri,  2 Feb 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892992; cv=none; b=eXWKSUigGoJG6g/+PTUKYo3+mUpcFdkOt5FKTNARo5casbGaDsgSRvk7pQ5x+ryOoqHnc2mwFd0m2H/kBgVbDe5byKa2G8NCdXaH2qcDrzbiPIuoTxF72S+PvWEH3Lx10o5NYzO1KQ06idCIObm1VqYTdyFSQDXDDOIUYeUmBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892992; c=relaxed/simple;
	bh=wyOnNF8B4sb0b8JsxsVpaFTlI4g0+8evOPxcQxS/teA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDVlpsB9msgJj4NQfZpMLof5mKv8bBnhwvj/sXuIdtrFWJq7UNtvOcytqPawB5On17lP2oNHdxX8A9LGGrCJYU1wk82kyux0ZfYjJ9QB3/8JhSFoBqCGgMrHj8isyURxrP3RXELB2kIOlfJCMIkf9HpLyoYVu4lhLW9hFm3MTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arSuH0au; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7858a469aso17802295ad.2;
        Fri, 02 Feb 2024 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706892991; x=1707497791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qe+TOmLaJxk957V8jGDLQ7fu9VgTnLFu/zh4WfVuOvY=;
        b=arSuH0aupyVXAcxPsfa5xCg0wRgnYYOlROEDjxw0BKJKu7tYR0arckcqU2ImluJWHw
         SHOPOibETWbrHVLo0h1LwTgnrbowU6V2s6nUjWNduXFBYcjebghL1UOcyyZm9rDrC0Qc
         OKbGeLtpwJqoIYYzPO9l9AQA/XfPNoi3tCKOnO0qsTiQaOL3Yax62GlY8lbU0CUwpJbl
         5QxXzVDl1IFESmZmYpno05aDz8dpkGxWUbV26g3hFmHjHajl6nl+LQF/F/3DlDWlvE2Q
         8vDLNsk7LatHll7URRZOkb0qfE97p9gI2mgrhN2ALyzFagUMt3qUdxEh+QsqbFHC00Qh
         U4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706892991; x=1707497791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qe+TOmLaJxk957V8jGDLQ7fu9VgTnLFu/zh4WfVuOvY=;
        b=kEc5HUBnjFRzM7eLmLdY8sWCJPMbbId/bxW9/pweOGsSkUm6+VR0HJqOViMRJVJTHT
         qUy+p+l3zd3of4ahse1CbsolXgTjBl6d8LJOdqxsEar5g767ye7Rs7Zlfq2eAuLmaohm
         p4hVvt6hFt13xXiS/CCM8e0oAwo+mwhejCZ4vxemdutWC2JIbtLYcAeMzdrRjcE8TRPe
         hCfAz6bhSud6YcFiryFcp0KRLKW5ZeAAFkNEnzUpTEnO9vK7LcmhWG1zPA6m52kVpqA5
         jyeHV5W0vZe1Re0KRsaA8sPTw7CDnZcuCalvPpa9de4BwfDB8IyWf7fWIs7Uz9gRMcXq
         N4nQ==
X-Gm-Message-State: AOJu0Ywyx5amIcPcxGDdxEWujBZLW+BKRsq0m9m9LIn1mE86tUe922Yc
	ZrAkUkh0QcnLMWLjFZK2MSIIMllA6YMxIxsW8lO5xuZ4XtY6i9zY
X-Google-Smtp-Source: AGHT+IFVOr4HiW+sp+gB5p4t5//6Q+a6RWUzdnlakeWeXaYtXvRGKZLk/l5K6ixwFCQHdokYgLGmgw==
X-Received: by 2002:a17:902:a5ca:b0:1d7:5eef:4d5 with SMTP id t10-20020a170902a5ca00b001d75eef04d5mr8048054plq.49.1706892990560;
        Fri, 02 Feb 2024 08:56:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWEvERrDXE50CB9dVnuBFPPBoUo//KQRkoRGwT9G+p4eA1JV3u4GbJlx+aGCB5ZeW/L4vYD3wW8CNHIxN+segWas+rZ8ZWQOfhAuphaNXlMPNimAQrp34e/RrVfl3/XSz+iETWf0sAwyNeMifdeV0LRP0QP+c+l1F7JcWpfRgLmtzJPUbWumr5UMElgdgYy7gO1ZA9skITpIDT3oaYAFqvKRVO7zxxGpqpoFr2ARYVEiF1CM7/C4ofVk4+ib8fMVQdCMEht4tAAUIqXW17ACJ40ODl68+dvc/Pe9JtB3gU7cw37zeeNc2SaPv9rpEAc9bAfwFItHocSQazhE3ZH
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id kt5-20020a170903088500b001d8d1a2e5f2sm1806897plb.216.2024.02.02.08.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:56:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 2 Feb 2024 06:56:28 -1000
From: Tejun Heo <tj@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <Zb0evDquygkDI_8P@slm.duckdns.org>
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <c6ce8816-c4ff-4668-8cbb-88285330057d@huaweicloud.com>
 <25fd8537-5a27-4b62-9bf9-1ee7ca59b5b8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25fd8537-5a27-4b62-9bf9-1ee7ca59b5b8@paulmck-laptop>

Hello,

On Fri, Feb 02, 2024 at 08:35:51AM -0800, Paul E. McKenney wrote:
> Good point, and if this sort of thing happens frequently, perhaps there
> should be an easy way of doing this.  One crude hack that might come
> pretty close would be to redefine the barrier() macro to be smp_mb().
> 
> But as noted earlier, -ENOREPRODUCE on today's -next.  I will try the
> next several -next releases.  But if they all get -ENOREPRODUCE, I owe
> everyone on CC an apology for having sent this report out before trying
> next-20240202.  :-/

I think I saw that problem too but could reproduce it with or without the
workqueue changes, so I did the lazy thing "oh well, somebody is gonna fix
that" and just tested as-is. It's a bit worrying that ppl don't seem to
already know what the culprit is. Hmm... I can't reproduce it anymore
either.

So, there is some chance that this may really be a subtle breakage. If you
ever see it happening again, triggering sysrq-t and capturing the dmesg
output (network should still work fine, so these shouldn't be too difficult)
may help. sysrq-t has workqueue state dump at the end which should clearly
indicate if anything is stalled in workqueue.

That said, another data point. In my test setup, I use the earlyprintk boot
option which enables console output way before than workqueue becomes
operational, so having on console output at all is highly unlikely to be
indicative of workqueue problem. My memory is hazy but it seems like I can
no longer reproduce the problem on the same git commit. Maybe it was a
problem on the qemu side?

Thanks.

-- 
tejun

