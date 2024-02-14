Return-Path: <linux-kernel+bounces-65200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF885494F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2D91C227A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5886252F62;
	Wed, 14 Feb 2024 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="J5vCms/x"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D911524C2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914287; cv=none; b=KH64ebO1jjC7UYzp1K8/myn3k8xh9nTVKxxrFnsus6dipFJOPOYSYvOLyiu8ELxveQOpDu7I3WXqdQOHnMPZURh14d1AfYEB548pD8TbBIdpW8VgYoTER1cSrH2jsZ/WocPR6sUtrS3pqZIoAufahhx97ZCQ6RmBHMGWB+NXw0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914287; c=relaxed/simple;
	bh=GHIKKRztgebLOU2yPqOocqGMjoQf8XX4AABKk8X4ihk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mtVSsek1Tkrwaxd+ykwar6w+nAtBFHvOXuW3ywtQlkVx8zv3pHoM6MFfEGyCBRKpJJi02KVqPUuwZ22nKhRat2lo1PevJ1DWGd7T4XnTSaJfWmMvN1IZCYTjYqLzn2+u1c8eMKrGIq1frosqmlXNruFm+EIFHJ4xokp28rBxgyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=J5vCms/x; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1db51e55023so5967015ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707914285; x=1708519085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iD3cuXtEG7eHzyqCNYQgPp1hH9CYhg6P7cRdMsq1rYY=;
        b=J5vCms/xAZROytW1VcdyvEza5RWGo0+J9jQbdvTYYAIiq0BMVplIA/Rv+QdCd64KkU
         1jh9Eb+K54X/lqFfptsizNOKVmlWqGBFoEMPj+oX0QTynNQwTzb701I1hvHMctZ5/bPV
         3Ns97yMYOxneFic98wUsVDZ04QgqJyus1Ts9h7TN2gzSjxQSrX9qi+nOFSa8TqYiawKm
         H2Cwu6u9Bwrid2LNpLE3df4KqUbl49LdEOdftIVVcV/PmwHK1OiToFjDjztx2wB4HIUI
         f55i6z7XmP/+2h2qZUdcrmYl6A+mtBbiac6UM94LKZcF4HOzgguYPl9SWtaULt+thqEp
         8FBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914285; x=1708519085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iD3cuXtEG7eHzyqCNYQgPp1hH9CYhg6P7cRdMsq1rYY=;
        b=AWfOzzG9lDj+Wgi39PAiBm/IWNiD1ZBJPWpu6iYpzFAcpLw571kEgiUmgQ937o1OVY
         kHupzx5FKR4yIludPcvwsOIzKlhoGQ1zLOj/RMT3uWZIudpgVIiXNkWxKrlAZ47MjmaV
         nH38wyuL/77/5gqesgzLhmCg8YV3pOhI/BKOvifAvcmJpoUMaWL42/jT1J8f6+ZynC9U
         NHNbRnAagZisMB5vEwlWsDXJ6jZIwTd0uQlMDbprYH7dOS/W850bMJjbJr8QXLWcHzgH
         vX9J/6lA6y8WSC2YDIBdB9KD/o0bOsQKTe179vqHRj+6agoYcMJkyq6V+CJMoj6ta/1D
         aHtw==
X-Forwarded-Encrypted: i=1; AJvYcCXEg4KTp2lwFGMC6gSKzU7ydQptt3asdv2+/kSSYf/qMbUI56fe2ki0kdXCrEz+CKEepn0oI3K7hxUxP++FGot3kK9mLyDp1vUjAlCn
X-Gm-Message-State: AOJu0YxU6oObkPJH08R0FC62kKza0S8Cyqq8PbChfrJpI+Oyg+6lzIVO
	N900Ibqz8hJ0Rd/T+0QKcAcMe4TpffxwQgApjkVGn5FXzjHrN1GUwlI0eWUwLdA=
X-Google-Smtp-Source: AGHT+IFTw5RXXW6Nviw3HgBB2tAXtXFmyAmPUcr6f2y5ZPZmWt6NKLCHnP/2J5spjEjEEYGaO/fojg==
X-Received: by 2002:a17:902:dad2:b0:1db:299e:2409 with SMTP id q18-20020a170902dad200b001db299e2409mr2740913plx.22.1707914285501;
        Wed, 14 Feb 2024 04:38:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5cE4cGphxkpfqoHCDjRDQGwH9kyBOGqRNO8ol/US87I9xoe50dsAFuGlj4hxA0+kAZf5pPJWDqNEkeC2RIj3Vvt2KJcYCbWMysCaqHa5OwJh7GiVKlFO37WlvSiT/srsA4NwiCgOfjMlt8HDufJOraEaEttR9Owkusc6QvBL2JhtrHkgZup/cXkyIGWGjprYtxQoHfxCezRAtyXJEGyTDSMeKJd4F4t3HuwNTiFJ6AvmIt3uO7rSFwiY12zIOneCAodd5/6Ti/S5czsPooP91jZHSND8cl0vaSaVU1cbyKG3jx7CSUoq1us3gpQAs+7CQlbXfZl+IfEk1ibVJBOLvwFWkfETK414IR/DrGdnOtUwQQS0kDztcTKFOZQg095iz1hX5LOowJ0Pu+F3y3NEoPxVUbesMl2OIALDao83ElpDxCX4HG6WVyvJp5w==
Received: from anup-ubuntu-vm.localdomain ([171.76.87.178])
        by smtp.gmail.com with ESMTPSA id o20-20020a170902e29400b001d9b749d281sm3041419plc.53.2024.02.14.04.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:38:05 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/5] KVM RISC-V report few more ISA extensions through ONE_REG
Date: Wed, 14 Feb 2024 18:07:52 +0530
Message-Id: <20240214123757.305347-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the KVM RISC-V ONE_REG interface to report few more
ISA extensions namely: Ztso and Zacas. These extensions are already
supported by the HWPROBE interface in Linux-6.8 kernel.

To test these patches, use KVMTOOL from the riscv_more_exts_round2_v1
branch at: https://github.com/avpatel/kvmtool.git

These patches can also be found in the riscv_kvm_more_exts_round2_v1
branch at: https://github.com/avpatel/linux.git

Anup Patel (5):
  RISC-V: KVM: Forward SEED CSR access to user space
  RISC-V: KVM: Allow Ztso extension for Guest/VM
  KVM: riscv: selftests: Add Ztso extension to get-reg-list test
  RISC-V: KVM: Allow Zacas extension for Guest/VM
  KVM: riscv: selftests: Add Zacas extension to get-reg-list test

 arch/riscv/include/uapi/asm/kvm.h                |  2 ++
 arch/riscv/kvm/vcpu_insn.c                       | 13 +++++++++++++
 arch/riscv/kvm/vcpu_onereg.c                     |  4 ++++
 tools/testing/selftests/kvm/riscv/get-reg-list.c |  8 ++++++++
 4 files changed, 27 insertions(+)

-- 
2.34.1


