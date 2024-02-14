Return-Path: <linux-kernel+bounces-65334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E493854B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131ACB23058
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D607555E40;
	Wed, 14 Feb 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fihP7WJY"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672C91A58B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920728; cv=none; b=oedYLTUeJpVUDNDQVat0ZAjDZStFVsYnC2LzXma2tZ6l0DPPGSiZpSYwCTnXdfl9Mv9L1UeP5Wnh9z3meFMuHetHek9cWEqJEZ01BSv0+Xi7GeKNGoKcJh4YJmbITAdekkPIWJZlDB/OhKuQ+BalYrKIw3nH7m5LtxBKOoKwf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920728; c=relaxed/simple;
	bh=Jtunily3ID2ggNdumWrfsLh05PSLNGzlYQIE52GtrB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faOCK5EGJoKOnG1ifkEapslFIig0awBsvy+5erNkKva2uJAUZsxeuaBAFxJo4Ovu906a4ellpwOCbGwnkjELP8R5joAExNOCZXb507cY7xw3ZJzyBeUvY8oZ8g94x3tj3E5t3ipo7phOfcTJOwFBWSfp1McjSbdxhpNM7ruKd9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fihP7WJY; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511972043c3so2602774e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707920724; x=1708525524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jtunily3ID2ggNdumWrfsLh05PSLNGzlYQIE52GtrB4=;
        b=fihP7WJYP5duAvCreRHw+ki6E7fsPsa41Zo4SJrZT6SrcmteU1kuAAdw33iIlaoxu6
         poy+RyW06g92QmJGGiONXvPgy+hJyByzsfwyyVAN9d1lrPAOXEC0yB9gCXK0AOdx+GfZ
         IiCTkmb3RVx2/N+ugxYExkpygXKCT4zDLanokC01MlC/Xxv0oMPIVLiorfhZ23RtG6lH
         8G2vl8lZdW5egFCece5a2CztSMnG9lBhhiKqIbbEbdB2I21hs2Rg68viFm0NSkBcIUrd
         ZtNSqqKMsysheb9dASLjNBNdTuIn2IViBA1svYY0NnPP7mg8NWI2ULAr/G5ZmHweROyd
         0RPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707920724; x=1708525524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtunily3ID2ggNdumWrfsLh05PSLNGzlYQIE52GtrB4=;
        b=DGviFZSjHTdLMvaMgxkZHEP0j3b1Eflp0B6/WThbca4lT6d/COLTV9NCuPorfzlJCB
         paGhuNudSsGRYOpfEilR0kpKVsh1acZW/p4penLRVTFq253LRFrOTZz5iM9WY9Gy4881
         +F5fggV4g/GxKmV5ClKb+6cn4awoxaIWN2vli8h2n2BsTzSdQaMf6eNcp0yohIktzuGq
         7njTKRx9yzwrDqaVpycQk61wFq++61TRKSQDsXYAPk1g5mJdW0szWDKCsyeb78uOUyEF
         u1HxJYRm2CcIvhTM3GCNR0iBrCHE4Saxn5OzMXmrTYzfAE1ZwT3ghIJpYEeDYd9P+gQ3
         Hrog==
X-Forwarded-Encrypted: i=1; AJvYcCVpTITWdFSKPMyHCCBlWp4wOJ+j7B9JBf6caDg8fTqIBOFtxk0lLiYgEpoc1V8hdKI+0p3itYQJCgUsiCLuE/A4jpZQH1I5XvQZXU3G
X-Gm-Message-State: AOJu0Yz4yWKyDdvZyOOLot6fa8mudFq9e0G0e0QyP3vIAOIsrST3hl7W
	2Kb795kPtkjVs+AJyUrANXHMJ4LaHsTbl73GxKigWGkHO1ggaS9RpL7/kw/Ht6TzUZtnETWi+xk
	fF1lP92mlbvf028Io4/rokfotRl0NSEJrxzk5nQ==
X-Google-Smtp-Source: AGHT+IGj5b9s7j1rq/u5e3Ei42FYaZcMYl/f1nxg2/Z2HDUJLX6SaB3gN62Pg16uiForO3e0uH6cCc+u4sPccjA4aOI=
X-Received: by 2002:ac2:4c2e:0:b0:511:48aa:d621 with SMTP id
 u14-20020ac24c2e000000b0051148aad621mr2053788lfq.66.1707920723938; Wed, 14
 Feb 2024 06:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-disable_misaligned_probe_config-v3-0-c44f91f03bb6@rivosinc.com>
 <20240202-disable_misaligned_probe_config-v3-1-c44f91f03bb6@rivosinc.com>
In-Reply-To: <20240202-disable_misaligned_probe_config-v3-1-c44f91f03bb6@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Wed, 14 Feb 2024 09:24:47 -0500
Message-ID: <CALs-HsvLH_QYUViSBuBgF4vW_X4CJ3M8tgOVfAHi5WdVXx54fQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] riscv: lib: Introduce has_fast_misaligned_access function
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Eric Biggers <ebiggers@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 6:54=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> Create has_fast_misaligned_access to avoid needing to explicitly check
> the fast_misaligned_access_speed_key static key.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

