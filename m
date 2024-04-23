Return-Path: <linux-kernel+bounces-155825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 465158AF79C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A2AB270A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5288E1422BA;
	Tue, 23 Apr 2024 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Akwd+cD7"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FA1422A4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901908; cv=none; b=L/xL+wE7XifxcaUmRk8BFzxOWcrhWzfAKA04vMAXD9Zn+vcTP4XjAA9mK2/zyITW3nyyDvrRr/4qzYNHZ38Kp2CQY9Aun8zqbZHi+Cz6haDPDYV8wIcSi4uPjdb+HK98uG2VCt+spBWQLsTsmBlcgKEC64uglWkTuAvUiISAl5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901908; c=relaxed/simple;
	bh=gq+M5+aw9OIwsIvmlprx0D/Z2qv8fXXfSa4VfSXwCr4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=pR9uLx+pisowCQLe1L8kWiXJJIyfxvKDLfKF+45qBycc2Hfgx4JvJoXxwXzVNNKnDfp0wV7uU0VbIfy9WC2dEdYmUOa6zeaKfi+rYK1byEKZCGm41ZSul2I2KwAGmGoPDZlDwl8wbItBZX4p4n52iMm1fQQ71NmZLyeppCqV+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Akwd+cD7; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f0593f45dso421481385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713901906; x=1714506706; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V34zl+LCQdGU9TsNKJvDa6HZ3KMm8IzHGaGUrzvEbv4=;
        b=Akwd+cD7mCxpxkUDjhgMDpHNB66SNa9NmuQbVQUMoXJuU3qmaDJ4IJTCIqG/jm1yBh
         CL3LwzNVY4IYJ/1A9NldqzhS/svNKGUwaqoEeEvEWj/6HC1xoERQGfJIXSz6wRKD1VN8
         SipoyBhG2S3K/HQRLOy3PxuW3V1jNiJJhyRhRBhjtCspf7mwRmQJ7ugDYonh9dEp9lt6
         APqGtONOYfXmaDQbzaEywS3h0JIi9YJo8l/q1CXmQBY5pTLReiSRofWp7lcIiBIY5TAV
         FkN5XlDXRyNOHUckDUKKpjA8IwzZLRx9YIQHhwPhY6WBigilichsUcWQ9QnZaDE4xYVB
         EALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713901906; x=1714506706;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V34zl+LCQdGU9TsNKJvDa6HZ3KMm8IzHGaGUrzvEbv4=;
        b=oSvLDCXqfTqSgWgL2Jg8Fe+3FcYnMaPbxjjA608uDkIlK1zrrNPtLCpzGz5xGsuUco
         FhnODgFAD01u9WIHQ8Q83y5qpAmwbRbmxl2h+oPKDRc2q1ZwS1EWEHkyIp3pimgWCqtT
         jdzMJtsZRsWmNs9ydFd1zErUwXsde7WZZiQQgJm+kuPvFe3/SiM7DFC3EgXazdtmgyek
         lsi+W31tnmqzDzf9jmi4FZap7LuMB+83Ns1PWkN0ksoZLb/S96Q6F+oOaHj12kzbPEJx
         xLusyWAiWyirKuPi1fozVi7t5HwbT6Vx/nNoOiL4nlr75houQWwSeUSUfvCR+LH4uPFt
         TAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXdhUQg7gjdrP1tXPirCf3k9KZVAnins8Tb2Dy65YCME5aynL1xrWUu7GmDSX+Dcx7C04E+0wVQrx0CdFj3FFW7WX/F+78o2D3Q8xi
X-Gm-Message-State: AOJu0YwIzpcqFTvwnpLFBdoMt1geMW9gNnTeEcDXxGgGzegfFeofP6rF
	Nmo9yPkXFXZsC5qOYmxQv0DNd+SW1EG4rB/JZrUyAQyWiZyxsNl7
X-Google-Smtp-Source: AGHT+IGuf9fLbBwxxwrqS2HmoJCIuqYmeIVLF5O8lXwUJqj3z9vU4JdJcMjFinDn7wiO2dozYlq/nw==
X-Received: by 2002:a05:620a:4fc:b0:78e:c836:605a with SMTP id b28-20020a05620a04fc00b0078ec836605amr502819qkh.34.1713901905954;
        Tue, 23 Apr 2024 12:51:45 -0700 (PDT)
Received: from [10.104.51.83] ([67.146.146.223])
        by smtp.gmail.com with ESMTPSA id wh13-20020a05620a56cd00b007906ab7b0b5sm2980032qkn.11.2024.04.23.12.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 12:51:45 -0700 (PDT)
Message-ID: <8ce1e1cc351153a890b65e62fed93b54ccd43f6a.camel@gmail.com>
Subject: After suspend/resume cycle ASPEED VGA monitor suffers with "No
 Signal" state.
From: Cary Garrett <cogarre@gmail.com>
To: airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Apr 2024 14:51:44 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

An Aspeed VGA monitor, in my case AST 2400, after a suspend/resume=20
cycle suffers with a "No Signal" state. This is also true of a=20
IPMI/BMC remote console. To restore the "Signal" state requires
a reboot or the following workaround.

To restore the "Signal" state without rebooting issue the
following commands from a SSH session or serial console
after every suspend/resume cycle:

  sudo modprobe -r ast
  sudo modprobe ast
 =20
This a home media server which is updated infrequently, so
I am unable offer any guidance as to when this issue started=20
occurring.

Regards, Cary Garrett



Current environment:

uname -a:
Linux xxxxxx-server 6.8.7-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 17 Apr 2024 1=
5:20:28 +0000 x86_64
GNU/Linux

modinfo:
filename:       /lib/modules/6.8.7-arch1-1/kernel/drivers/gpu/drm/ast/ast.k=
o.zst
license:        GPL and additional rights
description:    AST
author:         Dave Airlie
firmware:       ast_dp501_fw.bin
srcversion:     7E39455BCA2D11E968D8B2B
alias:          pci:v00001A03d00002010sv*sd*bc03sc*i*
alias:          pci:v00001A03d00002000sv*sd*bc03sc*i*
depends:        i2c-algo-bit
retpoline:      Y
intree:         Y
name:           ast
vermagic:       6.8.7-arch1-1 SMP preempt mod_unload=20
sig_id:         PKCS#7
signer:         Build time autogenerated kernel key
sig_key:        76:06:C7:84:BC:2F:C6:38:38:61:C1:6F:32:D5:6A:03:88:22:68:1C
sig_hashalgo:   sha512
signature:      30:66:02:31:00:AD:83:EB:D2:9B:91:E6:C3:9B:52:89:51:4B:BB:06=
:
		DE:D7:44:A6:6B:07:92:AA:75:2A:0B:20:26:73:58:09:DF:C3:86:C6:
		FC:B7:D4:13:5F:5D:35:4D:67:89:73:0E:C2:02:31:00:C3:98:99:67:
		B4:74:02:5C:6D:D3:81:13:D4:9F:B4:F4:CF:37:8A:7C:84:8C:73:BF:
		DF:4D:D5:34:B0:0A:CE:0E:59:67:28:98:07:BF:D7:FA:68:B3:37:43:
		02:1C:59:3E
parm:           modeset:Disable/Enable modesetting (int)

lspci:
04:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics =
Family (rev 30) (prog-if
00 [VGA controller])
	DeviceName: Onboard VGA
	Subsystem: Super Micro Computer Inc Device 0804
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR-
FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR-
<PERR- INTx-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: Memory at f7000000 (32-bit, non-prefetchable) [size=3D128K]
	Region 2: I/O ports at d000 [size=3D128]
	Expansion ROM at 000c0000 [virtual] [disabled] [size=3D128K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [50] MSI: Enable- Count=3D1/4 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: ast
	Kernel modules: ast


