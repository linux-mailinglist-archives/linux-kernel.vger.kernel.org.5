Return-Path: <linux-kernel+bounces-145235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979668A513B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D1028099B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F012C71759;
	Mon, 15 Apr 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eNS5mRTl"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723271B4F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187021; cv=none; b=cKEVVIJ+IEfyLQ1X0gRATQgArhLOh2ZCfURkhnQOfebqZ+62xyc6y339bdlk5p6k85RZEN7thS+IGwiQ6Nrt/It7kWD6K8iIRjm1HDPElSNrtQ6+t52fuSXJI0nO8+FVPU9KOvekyr8G+EYbC73lIhOjJ8U5XJKkaG3BR5H4rAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187021; c=relaxed/simple;
	bh=9WDoRP12mCrhG/JJodeTzIDnTJvG+PCJ0drbH8pC6zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Agf58KSShPMFu2tGBDTepExqr9/oErdYQpuAd0R6Ced1ltCBFdGMW1hOjCZxpgH8lQnzpigRSjvdgi4+s+63Rih306xXsdsUPv3wteNlwxQkgUacLGTG1E5H35aFdakY1xPyEymaMRuWuTJccq2rtoT4v4qv8un23YyS7VmmeGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eNS5mRTl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41864cf2f5aso3161145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713187017; x=1713791817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIgZuQiUxtL+LSaIjv53hZCmjifx7JqgeYSmna6+gBo=;
        b=eNS5mRTlpnjsp8WUUDtUQBi2Fn04nAsgoYWPfhxCC+gqS6d9BIJ1Q+Ic+u/oQVEzc+
         HuTvEsKYB222qtqljGxVUO5dRoJeqVz6edd9DIYXLL9S28xq2zt/TpxXNrbvm5lCkYYZ
         1ffpgzOoHDq5BxF6cdxer0e/5qBvC2rsujZfJQ2ZT9kkmTp1iF+JfNBjCsNsT3wJNSq3
         MuXI/E6LYm/MExU60fzLRji2EdxgYtwVEka40rsSmfz8NZtQyGkYMxYKScUcfbrG8ziT
         aTAMafayCwMUuimB9G6ywyYYBhs+2xUeWGxFXulEvcmjklg+x+Z7w2ScF1icZHmmTxR+
         zbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187017; x=1713791817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIgZuQiUxtL+LSaIjv53hZCmjifx7JqgeYSmna6+gBo=;
        b=uLZyla77WyaxeiI8RclOqqBsMsGpzTWLks8+wWzgcdreRxAIlC88ARFFssoVsnrUYB
         8sAqJOGbtDOP3yFsWF3oH0+6wF9FlMThOi4YpUKYda68sFP9scpHvDbS9RVh+W3m1sBK
         DLx4aulBAdnStGj99hzKC+RdDKiCVMWg2fQUQNITFxM47bvbEc4zB4GeMbX8AHdBudVO
         nTG7LP+sOoicKC8ZgXoOvmf7rgsTF65m5wsqnSS2wFmNhtTAIMOXBXlCNCoh5k8JBgfa
         97zgCxMmaLzUNqtNTRRNx5M3af3wNRH8JlO/gKBDciyxefnuM5Zeziak+t+vY9V1pSXn
         Sf+w==
X-Forwarded-Encrypted: i=1; AJvYcCXvS/feAwLTIBunrQJBQBALLXp4n3LGmN0nvKQ6KNbF/sb73H3p06/xCZKCpvz/rXR6rbo2cyZwybYBAn1SrL5i7drnbmAT/pdgJ9Po
X-Gm-Message-State: AOJu0YyOMCY3/D5nT8HUXX1RKqzECdV6azuqltu5s8xQisjdNf9mSM7j
	ClsXRAh8EqYFgPgRVBgxNMJdNCf0L7IiBIvI+07HefXta5PW062B1QDMbklkYZ8=
X-Google-Smtp-Source: AGHT+IGVZaUfUDSuVWA4yGZDCRNEVJaK4+GASHu2k63H2Raml+5NO97O6eNCHFdJMaWivNRDeUtLXg==
X-Received: by 2002:a05:600c:3491:b0:418:2323:e87 with SMTP id a17-20020a05600c349100b0041823230e87mr4226564wmq.25.1713187017422;
        Mon, 15 Apr 2024 06:16:57 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id fm15-20020a05600c0c0f00b004186f979543sm2508778wmb.33.2024.04.15.06.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:16:57 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:16:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lukas Wunner <lukas@wunner.de>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH printk v4 24/27] panic: Mark emergency section in warn
Message-ID: <Zh0oXiu7dMUL4PuY@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-25-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-25-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:26, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Mark the full contents of __warn() as an emergency section. In
> this section, the CPU will not perform console output for the
> printk() calls. Instead, a flushing of the console output is
> triggered when exiting the emergency section.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Ok, let's try it:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

