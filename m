Return-Path: <linux-kernel+bounces-40120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87883DA8D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6881C21804
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467331B809;
	Fri, 26 Jan 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZOs3q7Q"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AEFD272;
	Fri, 26 Jan 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706274712; cv=none; b=bFXtM/UPYxv1UzKszy10uo5XZTRL3HDvz+oNvFQRKjHRz5sqj/Bc+8ObZoaFcRqoSKMWSRkhLBfcgBlk1GdBjO7j00SyaPXKtBJg2YyTf7X5YVciNFKn+YltRSPiij7+DJ//d0BRo4DPHa3PU9+lcvHAkLXz1DE/wp8d9k8MHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706274712; c=relaxed/simple;
	bh=51m1LJOwmAVT8P7jtqAIAy8q2qI34X4aXAJCobfZW1s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oVRdL/5yJwaESH3/oex0AqLhxmzhKOVHem9Ylr+rAoY9vTOT6/gPWTLmka3ALyGqPtoSZ6g9by0rXR0qJIr/xXDCUh+DuskxPrMowi6GgLPIDh3x2IgtFqpiQNZv1IAyNX5ExyjQPP6fMQbrTWot/S0YsH/gWJLqF8z087pvijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZOs3q7Q; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fa455cd94so193741a12.2;
        Fri, 26 Jan 2024 05:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706274710; x=1706879510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=51m1LJOwmAVT8P7jtqAIAy8q2qI34X4aXAJCobfZW1s=;
        b=KZOs3q7QmvVN0JQqm2Y1y215NBXghjM4XvzKOBzHY94s+AENobITsum3pIJG4Z7UuK
         zcJ9+J77wld879Pg6bjn67kZaR1AnC2oQQE7JA1Uu7R5+QVC721Prs4UDHUk8Mk8g1gh
         KYlUzp2w/yHXpYwuN7b4YCfJhW6A5hEi4Gogg5x9dnBbuGijkLpPdtWiUJQuQZmPxu2E
         2a/vaJakpmyWpH19gEbNwtKsrHkhGBFGBF3Rj+q3pdIQfadTijqKxWuGNpaKrwJAMUMt
         jFrQhcMYXgC7DKlKoVZlRF0p6GASvm6cHLLEcENileVJbYQKurgsE2GVMPELmgPClllv
         M0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706274710; x=1706879510;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51m1LJOwmAVT8P7jtqAIAy8q2qI34X4aXAJCobfZW1s=;
        b=QWSBidNOKmAFwAhhCMfZBs/dE0XOa3obWZpy1/KhfZD6mqNxvDrhQPQ+HRlwwi1cQu
         EG68v2amzmLOEzhsOeACSs8RttdSLAu6cIYJ0ULSJ41a3oyTt2juiZvt7i+UIH4hI4sq
         iVwliI29lh1YvKH/F0udJM9L5Dm3q5w52jK5Z68m3zMwN1gCyzZwChT4YroNicaMmdIR
         zjYkEOscHlaoWfJFce4NLEDvGID9z1V6B9vflCacLFfutWBEVY9wa1udUchH2fLDYnjX
         sNILiBoIZbq1OtUokwCEmEafaWeM+U3bjd0XincHEQND5sDDj1Tj+ri3IOHiXkHiDHZf
         Z66A==
X-Gm-Message-State: AOJu0YxMEwmUV2QwhsJPJGSxyzstrAoeQNPVX8V4w/0XfcVbFMUmqy2E
	FOfW+CYhM9UV+JXTtV7BbBQDBQYU3BgYqDda5NSu4kqNfMQ2Hpq9wiYkEu7dg6OPKbJdEGe9AL2
	p5mmuISU/+SLoA33iCNkEqauRCas=
X-Google-Smtp-Source: AGHT+IGC0ej4MM6Phy0BizOFADpCvoogJdF/46LfI+ywJbSzCpgUsY23k/61/MlQ3VJLf4m7+/v067gbPFDrsM/x+UU=
X-Received: by 2002:a17:90a:7449:b0:293:951f:5a1a with SMTP id
 o9-20020a17090a744900b00293951f5a1amr1486307pjk.38.1706274710435; Fri, 26 Jan
 2024 05:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Fri, 26 Jan 2024 21:11:39 +0800
Message-ID: <CABOYnLx_8_TpFHS-nkrvF5dG_Ev6tgMi1dj_+4sSydM1wmD1XA@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in af_alg_free_sg (2)
To: syzbot+3266db0c26d1fbbe3abb@syzkaller.appspotmail.com
Cc: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello.
This bug is the same bug that is mentioned in
https://lore.kernel.org/all/20231211135949.689204-1-syoshida@redhat.com/.
And I also reproduced it with repro.c in
https://lore.kernel.org/all/CABOYnLxaHBEaSRaEU+kDsHF8a=9AokO1ZUEVtpeT9ddL8giw3A@mail.gmail.com/
also see in https://gist.github.com/xrivendell7/b10745f297bd2d12a2e48155920996d2
and also a simple root cause analysis.

The incorrect logic of unlock_free label can really cause security issue like
KASAN: double-free in af_alg_free_sg
KASAN: slab-use-after-free in af_alg_free_sg
KASAN: slab-use-after-free Read in hash_sock_destruct

and it needs a quick fix.

I hope it helps.

Best regards.
xingwei Lee

