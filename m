Return-Path: <linux-kernel+bounces-25877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D0782D729
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F691C21771
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607AB101C8;
	Mon, 15 Jan 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biefZFFw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E83F9F5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705314127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K4+D1x6d473u1B/OH3x1vFCMppzL+VsC3/Prb9EM8Ro=;
	b=biefZFFwM2sHHUaUwSnyeR7ExGOe358glOSFtWJr84wEgkTbme+s77gvgd0ZreAXXwanVg
	UUCcaogtnpaTIm+uKBFMh8YeNn96V2DpxkxvflxhVSuyh6ifagiBnWIR2hotJfLDtIpQrr
	oTvsJJKMySdcSXiAMQg5TUBgkqiptzQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-4FkQHVEHNc-PznCFBskzPA-1; Mon, 15 Jan 2024 05:22:06 -0500
X-MC-Unique: 4FkQHVEHNc-PznCFBskzPA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a2c20945b80so586532166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705314124; x=1705918924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4+D1x6d473u1B/OH3x1vFCMppzL+VsC3/Prb9EM8Ro=;
        b=pMyp/od68/Dpnf8Ynyeq+Io+4dYfi+/7DlTKWoFyC3uZKdzH4UDXZ5j1YwllkE/5SA
         pzkHuNd7h7eeSueUN6P0MI6Q+D5583bO82dVI3vkjRFWAmMMjwT5vTCaIFcVnE3wB/Bm
         ezF57YAHPJuYHWb23sHDPmyOTiRwV4oekJYUqLIVHg6Nq7Whc0qUane6wyj2S9OQ7XUK
         1OTQGPXBwRJ9S8SeRm7oWJ54+lTRWAPY86dKmGVzaw2nEKIKiNV4nsFTw1xuibWtrr1H
         /Skyw2gO4wwgGRqru3JKbQoDArFzPCRW4tmnpBDc4A648DiuHGgYvv9AkKGvipYREryR
         3CaA==
X-Gm-Message-State: AOJu0YyMkFkZCrwt04vVCppQuHoL5MjiofPFTn0YyAkQXlg56NLEXPi5
	fPOfWme90XfoCEMx4c64IKpOiBUvJ+3yGD04iOKFnTsurRitF6C9HfpTsuL0Blv2HAKLnCKtCTf
	QeLzdE9zIcDUlRERWflqUI9RebeHRYajJ4w4RM/8DB5pGkW+aWF5elqxKvkS6T5kLNLydMgQ91j
	5uoCWzk4vGow7gzZ/P
X-Received: by 2002:a17:906:2304:b0:a29:905d:1815 with SMTP id l4-20020a170906230400b00a29905d1815mr5191195eja.60.1705314124095;
        Mon, 15 Jan 2024 02:22:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOqbjQ332BDbGcd20NfCd7fMuM6DUwLFuPXHwpfw8JH8XhdeGykcj3xaokj37ZrmlwciADbw==
X-Received: by 2002:a17:906:2304:b0:a29:905d:1815 with SMTP id l4-20020a170906230400b00a29905d1815mr5191179eja.60.1705314123650;
        Mon, 15 Jan 2024 02:22:03 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id f11-20020a170906084b00b00a2c32b6053dsm5110933ejd.166.2024.01.15.02.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:22:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	x86@kernel.org,
	Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH stable] x86/microcode: do not cache microcode if it will not be used
Date: Mon, 15 Jan 2024 11:22:02 +0100
Message-ID: <20240115102202.1321115-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit a7939f01672034a58ad3fdbce69bb6c665ce0024 ]

Builtin/initrd microcode will not be used the ucode loader is disabled.
But currently, save_microcode_in_initrd is always performed and it
accesses MSR_IA32_UCODE_REV even if dis_ucode_ldr is true, and in
particular even if X86_FEATURE_HYPERVISOR is set; the TDX module does not
implement the MSR and the result is a call trace at boot for TDX guests.

Mainline Linux fixed this as part of a more complex rework of microcode
caching that went into 6.7 (see in particular commits dd5e3e3ca6,
"x86/microcode/intel: Simplify early loading"; and a7939f0167203,
"x86/microcode/amd: Cache builtin/initrd microcode early").  Do the bare
minimum in stable kernels, setting initrd_gone just like mainline Linux
does in mark_initrd_gone().

Note that save_microcode_in_initrd() is not in the microcode application
path, which runs with paging disabled on 32-bit systems, so it can (and
has to) use dis_ucode_ldr instead of check_loader_disabled_ap().

Cc: stable@vger.kernel.org # v6.6+
Cc: x86@kernel.org # v6.6+
Cc: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 35d39a13dc90..503b5da56685 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -214,6 +214,11 @@ static int __init save_microcode_in_initrd(void)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	int ret = -EINVAL;
 
+	if (dis_ucode_ldr) {
+		ret = 0;
+		goto out;
+	}
+
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
 		if (c->x86 >= 6)
@@ -227,6 +230,7 @@ static int __init save_microcode_in_initrd(void)
 		break;
 	}
 
+out:
 	initrd_gone = true;
 
 	return ret;
-- 
2.43.0


