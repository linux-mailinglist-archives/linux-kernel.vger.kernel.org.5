Return-Path: <linux-kernel+bounces-90299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4DA86FD1D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A862834E8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6380320310;
	Mon,  4 Mar 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCG5E6xp"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39C12E73;
	Mon,  4 Mar 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544078; cv=none; b=Ozhpf8DsmoOi3B+tAa4RjXYrByaxf3Dq9lBRCoZjF9PmJ4RN/Xv586CIZRPa6O3OkuvZZIvFCcpXHp6jHEYeTHFEuhGPvjweshivHYTfGCHo+smnqtD9AnLw2Fcj4u1kwSXCMRlUB1Bj8e5n1D2UpALH79fEx1CE5gqYRbbNSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544078; c=relaxed/simple;
	bh=qRumvw5r0fBe4cXijShx0jyie3b5Thf1Qym7Ach5dco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9ZnPwnwakI7ib+vmpkg7J5a0gQ+QamGRuW4gqRVrpAORwx7dDqE9UnDtEpSa1E7zfYU1kn/fMHx3yGzOwghOWbqdPOsuFSPMdw29M/ZblUE+cIzFMkkU2cdK5H7LHyriuntpFuvPrEww9Tknx5QxA3KRyYAY5/DCi54onw1ugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCG5E6xp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56454c695e6so6982706a12.0;
        Mon, 04 Mar 2024 01:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709544075; x=1710148875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQ3u5q2nv0ZE5qO0688fu4cC+VQcvGJyrmp0bnKgjzQ=;
        b=PCG5E6xpH2frePv9C9aBinp54qqx9HRZtfxa8eNOD0kDkEhKH0K/2wlLmvlwIFQioh
         n02dAqqPpIJ4P/c3K4st3gwdl0+zhLBpz1MfatUzYSHcPaPg0MVVtSNULkMs2KmNgUth
         Il2Wa0twMq83n0RNehUS/sXLwsiL9CU0Y7Z6nF9992b1FNolawU/aIE/LPEhhzuNsPJp
         /Xh617BVgCXi1sT7qRjXDnU/JYZfMzIRJaCZyjFaw+Y2/VN7sWYi9E1wgN0dlV0ztjFq
         F62INg5+U80TuzBB8GSzpXWe2QP7gxybGry9SeLN3Gm1bW170MBYucMcGR98L9SOvAJU
         lWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544075; x=1710148875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ3u5q2nv0ZE5qO0688fu4cC+VQcvGJyrmp0bnKgjzQ=;
        b=NwkzF+daS63ah4ojJ+zVmpYECPIfe0XcMQI0RAWzAgRlh5J6+IRNodBHJA7qqCMDWo
         +E1ckg0uJQpu3qA4vtLGUn41RUqetcE1jrw9YWMcYY26Qz87sjAHOVcltKgE3D8iZR4G
         QFJIrArLYzjeklQDCP0JFd5EDsuBacS7Y8mDcffRd3CaVGlvukXivWe1NErtzr12xc1Q
         H8xfQrSbc/8TqTx1cuCI5D47rGlImiNqeS+tzo4EpRGt7Ol3XpFyj4+f1RDMMaFhdT3d
         1Eubwr7q4MYJrZMeM+cHWegjOjiT3s4MVC9p5iqipCHo2F96uBqH0F9YdaLRC/3mWozA
         1xNg==
X-Forwarded-Encrypted: i=1; AJvYcCUpYpQxbORNVsXm8H/Tufg7eikgZ9PcxgbaZtL228t0eJh54gF4awIqhLenfLPNz++fhwNTKVgRy1SRYNvc75Cy5Bs1Qph/yzLb6rsi/FiE1W6+DcVGPMLr55jIiN/0y7dBvZZzkhJUMw==
X-Gm-Message-State: AOJu0YzbMybb9rxHB3kmQzvFivkmIeebZ7yRWPrZE69fLPPhmtpgl26X
	27BIlLkvbPIVpqOuSXHxiEdSKZ6Tb07Hwnk4OV6Czlo1pSZk12R4
X-Google-Smtp-Source: AGHT+IEelsGlsw0Kh3DhH6d/QbArK0mkW5NdrPbf1vYlzlDJBMAGVF44/JYRgXkX3kBj57E4njT8aQ==
X-Received: by 2002:a50:8d8b:0:b0:566:624a:9e3f with SMTP id r11-20020a508d8b000000b00566624a9e3fmr7710597edh.3.1709544075006;
        Mon, 04 Mar 2024 01:21:15 -0800 (PST)
Received: from gmail.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7d34d000000b0056486eaa669sm4374872edr.50.2024.03.04.01.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:21:14 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 4 Mar 2024 10:21:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Re: linux-next: duplicate patches in the tip tree
Message-ID: <ZeWSiIKiL+8H2LqO@gmail.com>
References: <20240304092140.0adb0f26@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304092140.0adb0f26@canb.auug.org.au>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   9e1daa3bfccc ("x86/e820: Don't reserve SETUP_RNG_SEED in e820")
> 
> This is commit
> 
>   7fd817c90650 ("x86/e820: Don't reserve SETUP_RNG_SEED in e820")
> 
> in Linus' tree.

This was only temporary, should be resolved in the next -next integration.

Thanks,

	Ingo

