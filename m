Return-Path: <linux-kernel+bounces-50293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC873847711
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7AE1F225DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673D14C59B;
	Fri,  2 Feb 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z4c1jWNV"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8133614AD1B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897233; cv=none; b=DtR0+2fIMvVfWjCXv9/fJpwOGTHHWGlX2pas9DoJ9I1RH2JfIKCBNAQmeubeC+Le9TjMJPl/1ApeAS+3pN+TDrpm099UyfEyIDE7VfH7vjgB3yxmOhzw9Hh5+8O4BYe85PLoyuRbziKJkUGWe710CMSDE5KxDx3h/KVMML4Agv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897233; c=relaxed/simple;
	bh=Tnhv8sNX/QnVZcJ58iesaELBYEexgiSK1O7CkAZ6Cnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FTo13qA9io3QVrlLib6P+Kdz1nw4H/qA88+7Oy1uuscC37kM+TjiwVSlsn6jbozKSIU6Wxnx/dPFfgoSSezbVdLy4pqlB8TxytQDlIGUguaPrJ1WYyB8Z0BBac3VDK6jv275Q7O7xMVRVR/p+loZjJdi/YWycIS74R7xLm7gZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z4c1jWNV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dfeb8e70d5so953668b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706897231; x=1707502031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVRplVyrc9nYcvh+2WwM6XgSY33Nf8X5Ft1+PR+SGLM=;
        b=z4c1jWNVM2WV3H/qQ9Ajl2op3jSmkqVUgppdaFrmzOCQaCueHb3+czFsUYXXy7t4VV
         GzImGD7TF9zdDYoLfDBYyPIDp24tX2oCeoB1XpjPALVs0zfG6pOqYHCaJ6dzWTXBDETV
         V9bomfwt8OJv2bXf15wVP/EZVdyac7eBgi7z88vkAu0xWefu1YETCSXAsF3kFXDf4QYJ
         RPfUQ+wd24Qq2yTq2UgZVv19557Pa4cehILC2VsO5Ut3J7Snfoat0ZWx6c6DX/k7kqkn
         Rwi0ga2UwzpjLBO5fzpdUxXrQbX8s0aUDGQYNwed4DoSwFopZS/9JoYpbllq4LTT3Clo
         g22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706897231; x=1707502031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVRplVyrc9nYcvh+2WwM6XgSY33Nf8X5Ft1+PR+SGLM=;
        b=Uw5VUST68lrxdD5/ZHsp5fd43H4aDQxdmn5FProH1igE+4aDy1Ifu3HYW4gnjO6ZOD
         X048izQTjaZdLDsR4jb5wz3mKEkHG/LrOKmaiV4c+YHow5BhS5VdG2QeSXivMrD7LPet
         G1Ut1Ofy2/R3aTxW2SkeNqsN41v0sdj8RIJG6z4KM8ePmac713xYhfzBy9cRJT+22diL
         QJeSDUySgMuy5V6x84sOP47yOcV8Eqyy4pscgyMv32TWI+/d68W2efMPClYLLNZkxFDe
         d1cAG9M2vmiqBHyYC0qXygPF1Pq5ZgNrss8r99QFZoNsk/ovPHWH1xDEoKDWcgaesCHo
         YpkA==
X-Gm-Message-State: AOJu0YzKeJg7e0Jt4QWG1qhDcH4r0wwB53cSGqkxmDGsz/6iLjnn0XIi
	QDhMgBkUI91/q5os60QJf2kmhLSdpAk6oJ6FIfdUsY8VLEz/qvfis3elyyGrUB8=
X-Google-Smtp-Source: AGHT+IE+O4aRjNZAkR4CFJssXFXmF1HqZuyzjr1MfJIhR3KvlZdvvP0MmdCf6x/znHNOwFk7h6HKPw==
X-Received: by 2002:aa7:8895:0:b0:6dd:8891:c4 with SMTP id z21-20020aa78895000000b006dd889100c4mr10813749pfe.25.1706897230894;
        Fri, 02 Feb 2024 10:07:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV5IZ51+bmx0aGfXOAVxSYK/DIV7nwJoXATKClGG9L55mbhsg0f2xhaPbM5gDVgWuvaSDmKn0b8kOFbrtm4RnU2XbBlR8L/qiFduUki1lgDESJzNlNH57tXCv0N0ylOqjMvYeakFqb9CRxWqDhSXbbu7ZT5W38mJVsH5UZAmZfUY/IF7uwD0n7aPGNH6cmaj5qsfLMYix37h8yGxZUtRW/zg+Z0ykChA6kFdHB6au4p8DQiEzPsZg5BtsDXHcuHCd8KpNFzQlgpL7pN
Received: from abrestic.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b006ddd31a701esm1989267pfe.19.2024.02.02.10.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:07:10 -0800 (PST)
From: Andrew Bresticker <abrestic@rivosinc.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH v2 0/2] efi: Fixes for EFI_MEMORY_SP memory on RISC-V and ARM64
Date: Fri,  2 Feb 2024 10:07:02 -0800
Message-Id: <20240202180704.808766-1-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small fixes to enable the use soft-reserved/special-purpose memory
(EFI_MEMORY_SP) with dax_kmem on RISC-V (and ARM64, I think, though I
don't have a platform to test it on).

Patch 1 fixes a trivial integer narrowing bug. Patch 2 prevents adding
memblocks for soft-reserved memory so that it can later be hotplugged by
dax_kmem.

Tested on a RISC-V platform that presents a range of EFI_MEMORY_SP with
Bjorn's MEMORY_HOTPLUG series[0] applied.

[0]: https://lore.kernel.org/lkml/20230512145737.985671-1-bjorn@kernel.org/

v1->v2: address comments from Ard

Andrew Bresticker (2):
  efi: runtime: Fix potential overflow of soft-reserved region size
  efi: Don't add memblocks for soft-reserved memory

 drivers/firmware/efi/arm-runtime.c   |  2 +-
 drivers/firmware/efi/efi-init.c      | 19 ++++++++++---------
 drivers/firmware/efi/riscv-runtime.c |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.34.1


