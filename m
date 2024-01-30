Return-Path: <linux-kernel+bounces-44760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABEE842706
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F29D1C21B30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236C7C08A;
	Tue, 30 Jan 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RC8VsFKk"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEFD7A72B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625415; cv=none; b=Pma9ykDgO95X4z2yR62HM0nf7NCAesUTVKY/ITAk72eS2EETIIJkBenjacUjzY+pkcFc/FUF9wllN2VAom9Fgc6Y79V0yHTBLnabSoAfrAx75osSuS9h/Db9Z5YJm2iKznsaJVAAgjkL8EJsKCai0SEyaW2vGoU2Ddmhzgiyc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625415; c=relaxed/simple;
	bh=UFPIndjlEpbSA1phZiuT08Izlqf5JHkeSnMoSCerdqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+ZioO/Lx1dquaFqkJbRAslhyB0tidfjQCOqkACVTHbzKRmSKZpoGUEmJpNOgWu0UJ/Hs3yTWVmdrSbhfKaMaEHU8OebsGPahROq5LkyWk8XdxNIEYSFF5zdwyB9cCejt27zoKxAYSYgMWG/mKOc9mEDlcQ1Yh5LiPp12VBjaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RC8VsFKk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a35385da5bbso501254566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706625410; x=1707230210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OyBsuFwntGApk9FVAb57MEiGG6UlPgpNzf4isPZoRS4=;
        b=RC8VsFKk3Raw6Eus4V6vfm1/97npgMMxZmbex/IpHTyxlaeJAd+mfJ1ZXVYin/08bP
         6A2GcqBN/+YkKSp/nBq9iPGGO+D/FXIuq5yid0otaVM1mykGq42xhHMwmQRVlqB5XIeK
         5qHN0Zp0Mvx1G4Qr+6+FuIklza+F37HCxGNxRWATTcG+MbvijoLw09Oaab1Pym9rsxAF
         lPglzuStBeQYaITFw4+NVPt4qfMpCF0NVa65owI+U+WZ14A3zsF4+Z19QIw9NcoutJ1N
         zwATWqbKWY5fMVDv6ZRc+BUZJwFmbLyKlqG0bTxF3YvRnnipvWBFfoBPHJGVYRlG9DGV
         0Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706625410; x=1707230210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyBsuFwntGApk9FVAb57MEiGG6UlPgpNzf4isPZoRS4=;
        b=FTwjzmAGmvBpAypP5tlELYvdrBg1YAylXpPKMT+0ZtbRGVjTB+fs9B+rkX01KG0Rf2
         pAr225UY5W1hvsM869KGg7lyqr/j7aIubJlUrZ2UyXywjpqlNMBgGd9aygxNeuaAtd7I
         d4TawIneQ9uz/PMMxdqRA6aR5Bst+g5euGEOlVrniRueojVCwAxO8nCr2PViPQqeeXns
         YGqN+RreVxFtvlgvMw5sR7i3+ExvhZy+5Sjm+1jRybMimBW97hY/ttI6k4dzfk4wV1yz
         /D3K8DpMbuO71oTIlQW7MUYNlx0vkIKa8Vy9ps9TwmpaFBmtukp1bu2FO/kInMabHUSd
         0N4Q==
X-Gm-Message-State: AOJu0YwFCALPvYVSYSwAjoKB3uAPzYwQ5hSKXnCkXkzslAT2qtg9IAyp
	oAXfYg1Qfda+8VUeMM5UHD+9gZogIa3/otJgg/RbKCQfe9795S3KGMW9kIeD0MK6i/lwsGX1f+E
	g
X-Google-Smtp-Source: AGHT+IFDtxYS0RJOkGvWecNW55YT0nOrULZ8HKFwps/Dxalwwxw/Np8Tz9yr4xXD1Nr8xJBFQlV10A==
X-Received: by 2002:a17:906:b29a:b0:a35:e197:c94f with SMTP id q26-20020a170906b29a00b00a35e197c94fmr3257511ejz.69.1706625410518;
        Tue, 30 Jan 2024 06:36:50 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id s6-20020a170906bc4600b00a35512c7fa7sm3811071ejv.216.2024.01.30.06.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 06:36:50 -0800 (PST)
Date: Tue, 30 Jan 2024 15:36:48 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 08/14] printk: ringbuffer: Cleanup reader
 terminology
Message-ID: <ZbkJgMOjfSU4cg4K@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-9-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214214201.499426-9-john.ogness@linutronix.de>

On Thu 2023-12-14 22:47:55, John Ogness wrote:
> With the lockless ringbuffer, it is allowed that multiple
> CPUs/contexts write simultaneously into the buffer. This creates
> an ambiguity as some writers will finalize sooner.
> 
> The documentation for the prb_read functions is not clear as it
> refers to "not yet written" and "no data available". Clarify the
> return values and language to be in terms of the reader: records
> available for reading.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

