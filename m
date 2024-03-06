Return-Path: <linux-kernel+bounces-93607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE787324D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7271F2836D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08085D903;
	Wed,  6 Mar 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQHgjgIP"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5288914F7F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716620; cv=none; b=Dq/SJu9YuiVSjGyJK/drHnuP5z1PLwIONcM6D+YI8FxG9odhruwKHcRuio2nz2mOrPz391mpANP2ljr8VIutae0lMiTBoaNZWgxeRxQVn0bx7mAOi30GkcH/GZR0Z/0SCE7QkS3QPW82WXUkwbsb3eivwiiuVXjq80F1YLt5RZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716620; c=relaxed/simple;
	bh=O/uagpH1J2ovFBUYOloLfOGN60s6T8qshy3/cRcREIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtR3nZ5pvFv9/cKvX3wdEWN4Ib7eC1qawvUCGW/YLkUuV6PkW+0T0G6tzfDrTA6QEfK1jYdK/+0rHrn15CBBaKjT3OsAWzlAXZ41vR8qv3KzyHV3/Km83SHHXm82DsVQ1Sh2bpV3qicaNTZ6x2BANL4e2f626hJ+0nOSigKjA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQHgjgIP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56759dc7ea6so4101795a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709716617; x=1710321417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bsi/FoHj6ShlQY8qXSzOurtSi457MXtNJ96Ob2I9GjQ=;
        b=OQHgjgIPj6aC4i1k1j3dKDefYYFOd0ePjPevLVPTrR0O8ZwQYxJ9npr24ZX5CUD15K
         iXjWF2Mrl6JWebHb6DPmvrEFu8KJgBq7ZoAS0rCAkPM5pAMcFiUcX14mvLmM7rIkcfJ1
         Gqr4R/cSt99qROs1LOLaZiDUdLDi9r5BNZr6f3csDn0Iz1DDvZMkWzaVMmMEPRatE02b
         2HP0V6acWT7CG1KRjy/9SkO0x6P8bVQhh3BkRUihhL0KA8rRn3LML5WxHx0DLZSdT6nI
         XpBaUe1+4Yu2DNtleLMNN/XmL+W01tZbalk/n/sAIV103k4k967iZFMfvK3P0R/2mke0
         DtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709716617; x=1710321417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bsi/FoHj6ShlQY8qXSzOurtSi457MXtNJ96Ob2I9GjQ=;
        b=aVH8m8P99zTQqICKQWvZrde67a4xvrHYQpBxJ6tugT2J65VyorjlfQAJrFtc1p9SiU
         9qO6M2GbLFVZW0KIpF0G7+AWeUImoBwxPNlhNBBt20FnI/bczTYBZ51hn+l2COFE3k+D
         fD+o6844z0b0eVsmkawhPDDoJwJHDM2KHln/VEzDbG3EtYFDmgOR4VvEz1XFMwYbtjKE
         f6Cul+0veFIAeRSn7Jmw2ic3S5FjKtcUp6t0xmu326m/v7VSqbjdtVO9rllzYtLLhBKB
         ZOrs01HXey3BONRxYfK04MGA189MRFRkK+0xBXi0f/A4tHj4qitlzylzGe7mosdPH4IP
         iCIg==
X-Gm-Message-State: AOJu0YzUMh4EhYSdaivJQTg8MDQclxurbkCFuq99acAjVgqM4cnOlbvf
	oaofQsh64WXeTtw+NraEtcCxK0I3HVnKbuthIyXlHpGM2vBqLLj4
X-Google-Smtp-Source: AGHT+IHMEriM1V1S/rHkOG+u1hX2eaAYg/Mb9sMSIRPWAU5KTUXIItClzgGjKpyENv7M5zkBZlSmgA==
X-Received: by 2002:a50:85cc:0:b0:565:ec92:bec8 with SMTP id q12-20020a5085cc000000b00565ec92bec8mr9268292edh.7.1709716617053;
        Wed, 06 Mar 2024 01:16:57 -0800 (PST)
Received: from gmail.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id be27-20020a0564021a3b00b0056650031d94sm6713057edb.90.2024.03.06.01.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 01:16:56 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 6 Mar 2024 10:16:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] x86: disable non-instrumented version of copy_mc when
 KMSAN is enabled
Message-ID: <Zeg0hpElT3TSZcNW@gmail.com>
References: <3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp>
 <06c11112-db64-40ed-bb96-fa02b590a432@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c11112-db64-40ed-bb96-fa02b590a432@I-love.SAKURA.ne.jp>


* Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> Ping?
> 
> This is current top crasher.
> I hope this patch is applied before the merge window opens.

1) A false positive is not a 'crasher', it's a bug in instrumentation.

2) A false positive in intrusive instrumentation that top distributions do 
   not enable in their kernels has no immediate relevance to the timing of 
   the merge window.

Thanks,

	Ingo

