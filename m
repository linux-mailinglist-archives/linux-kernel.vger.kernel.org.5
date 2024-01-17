Return-Path: <linux-kernel+bounces-29381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60FE830D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0FE1C21BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A379224B26;
	Wed, 17 Jan 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ev3d8dSQ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0324B20
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521474; cv=none; b=NUdje8CYEOYbjyxI3oBNU0/y/U3AkQ6FBY/frSG4CWpljkRmIdwSFOD7X3J0/vOBU1/0ai7NQMj0C2VlJJ9tQMizud3oTXWnpcVXo1fcK69gaOm3ZIi9hsZuGTxBkzs2Cs1JylNU///hrT2ynKAA6MQh14dXqpRJA/wgZPVpsys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521474; c=relaxed/simple;
	bh=smggzj2XY8xCbSB+BhVhq+M4oW8/2Hw7UcZ9tnl76rU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=aV9jiDpyi3IkdCS/QggpPBYxZ085jO6M4L1OMxTrcF1JEgMPj3pLbchHIrxNhoFJX8nMfkyLeZckyRdVKdb25pZPf17SxI4CgSkEgvbQnaX7SxDyPaF3jQz0r9wVF7YUwdtkV6WRNswUCBxpj5Kq2ldtr3WsLIV9Bms64RWU8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ev3d8dSQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e76626170so38011235e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705521471; x=1706126271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4waHk4rPmL0zhRklQDdQP442m/73aDCDPB9DqO34yq0=;
        b=Ev3d8dSQRwP/Chco9XTjrgDh4KtmJzrH/cNeiPhRpF9+f5LU81FVkIivwFciRvnM4k
         b48cfzy6KlI0hLtiyM8/MxA6Xfr/w4y8QGR3bEwTgqdy1r9wFagM3aGorzIkbRIdv+Pz
         ZplB2+PPOg8xpjv6p5oY/2iRXpGGC4+BEHbt3GGt2lnU+egShXUrclApZpnlTI/AW/+i
         Vyfa0auyAQRaI9p+dnHj6TFaQ46TswpsPyDktYPgC5rgEW9rlg/gLp3Vpt/o0GrN6S5e
         PLzgM1CuAn05H1qGRtTBoAUP4t9Fh+jD+fv079iqcJKOR/co9WTn9i0Xsw5urd38lR/0
         DAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521471; x=1706126271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4waHk4rPmL0zhRklQDdQP442m/73aDCDPB9DqO34yq0=;
        b=wv6J1tfqSKOtLDPLSjCoXtwb0+KuNGNgbv1An3s72f2EoP61uum9xgl0Ps8/U35h/c
         5TsZ3QhgS2PtadBCYAEC/EXVe5DN4+1HHdpdKippbUo3wOvjOnbQi6vm7EJtIZulwh3K
         lt4Z6rems1Kxi/y9T1KtAGdt968gJWIQBMESUY1kBE+aa+9QXRH0uNpfsfGJF6XsYPFr
         Ui2i9S1xGU+30lw8gFGqaiVaSSFDpjDLZ9jzvkJcbOsc2RZqNK1I5AX0EQWjcYpXXjw1
         SCg19DBJ3I2yb0WLe9mGsfZdGKROLizaH2vIVinKlN09AWJPgle1ypXIl16Ar6XvobKt
         jagQ==
X-Gm-Message-State: AOJu0Yx6bIZsObJTI02jg7y1p6+bYi3uyv90U2J+zP5/BnESmCgvfYwH
	gRbb7uzVNmLbIEUSceJbrRaHWf1uFOfGRA==
X-Google-Smtp-Source: AGHT+IGewKH6iXQvqW/gNXe71KbxVjxmyFIysE2mQ5oQ2US6/f8tzsBa65eObcHKVN6wt2V1gcOMGg==
X-Received: by 2002:a7b:ce16:0:b0:40e:4618:d9d0 with SMTP id m22-20020a7bce16000000b0040e4618d9d0mr5236201wmc.77.1705521470046;
        Wed, 17 Jan 2024 11:57:50 -0800 (PST)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm27064749wmq.29.2024.01.17.11.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:57:49 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 0/2] svnapot fixes
Date: Wed, 17 Jan 2024 20:57:39 +0100
Message-Id: <20240117195741.1926459-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While merging riscv napot and arm64 contpte support, I noticed we did
not abide by the specification which states that we should clear a
napot mapping before setting a new one, called "break before make" in
arm64 (patch 1). And also that we did not add the new hugetlb page size
added by napot in hugetlb_mask_last_page() (patch 2).

Alexandre Ghiti (2):
  riscv: Fix set_huge_pte_at() for NAPOT mapping
  riscv: Fix hugetlb_mask_last_page() when NAPOT is enabled

 arch/riscv/mm/hugetlbpage.c | 62 +++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

-- 
2.39.2


