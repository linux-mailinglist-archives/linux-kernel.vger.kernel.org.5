Return-Path: <linux-kernel+bounces-24048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E682B5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F551F259C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915D558101;
	Thu, 11 Jan 2024 20:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMMbnpF+"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D85788E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d50e74183fso33018125ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705005186; x=1705609986; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S42orU1ihCUS+k0y1H/3lg3nrFnf+J6Z4OBgyaukGS4=;
        b=OMMbnpF+qSrzOHxl7MebnFoMeQ16q26JlMOl7XURR3CervC3aGAR/vmov0AGdmldvR
         WE6F8nr7aiBIdQd31UjvqOOONJXCHTC92GOXU9U9Nn4kLNexnmfzF2vqMyFhzw2BRDYt
         RnnAyYzs0oG5yPY23x0+hp0watQ7GLaC9EM4F5aV0/5a1ekmXOIY70Ky2vBgoXqRiUbG
         gOgYIZw7LG/Pgb3Q3/eId+Yc2pDX1+xKICgkm5JN0uwBpb/FWS6I3tvgCLSQX7wHsys9
         qckX/x1Y5k9dm+4uIJ576mm88RMYzoCLAbhiK5zmocn5zvtlX8vm1a7BpdxjFLduelZ8
         SS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705005186; x=1705609986;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S42orU1ihCUS+k0y1H/3lg3nrFnf+J6Z4OBgyaukGS4=;
        b=Q6GNalf7OtE2MUEcCEy5gXUYnviB0thgQpLFl4xsqCgLCJoyZS1Od2V2xH4s0jovS9
         GfC4fjgp3v/DQVHmIqG/wkxqPMOFFxh8j5XSz6CObKHffIzcJlkqQCtczu/Pvni+ISLv
         itlA8UNsXFFeoi/frmCUm69HcIR/nVe1ZcG3MD67BHPOBOxfgez0CkmGPRNyk5Pn7zSY
         HWObQxQVBzNc8qEHVfJ5vMRcGr+sxFM3LzZw+rc4ZSb8aqczZgB0TOvYQ5lPHN/XLNH+
         p8XGFvsXExiwVbgJehorylnURCB8V4W27UlLsKDZzwu+X3DXtxIHKdSRrr7TsACe4UCe
         wAfA==
X-Gm-Message-State: AOJu0YzSQ0091mcmgFb4XbF94H0jJoo+AUQLG32jdIGcLkx4r5+Sbvsa
	FTDXB60huoLzzQZOs/lBpE+gGGhLb7ke/yq+dw==
X-Google-Smtp-Source: AGHT+IHCdMcgToRAjwzPttCJK2d7JEgLATb9uZc0NhgAr0xmQAp6cYA4pujwhNvuobg6GBYLfKlYrli9BYE=
X-Received: from aahila.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2f3])
 (user=aahila job=sendgmr) by 2002:a17:903:708:b0:1d3:be6b:5296 with SMTP id
 kk8-20020a170903070800b001d3be6b5296mr1335plb.8.1705005185754; Thu, 11 Jan
 2024 12:33:05 -0800 (PST)
Date: Thu, 11 Jan 2024 20:32:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111203244.1712804-1-aahila@google.com>
Subject: [PATCH net-next v3 1/2] bonding: Add independent control state machine
From: Aahil Awatramani <aahila@google.com>
To: Aahil Awatramani <aahila@google.com>, David Dillow <dave@thedillows.org>, 
	Mahesh Bandewar <maheshb@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for the independent control state machine per IEEE
802.1AX-2008 5.4.15 in addition to the existing implementation of the
coupled control state machine.

Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
the LACP MUX state machine for separated handling of an initial
Collecting state before the Collecting and Distributing state. This
enables a port to be in a state where it can receive incoming packets
while not still distributing. This is useful for reducing packet loss when
a port begins distributing before its partner is able to collect.

Added new functions such as bond_set_slave_tx_disabled_flags and
bond_set_slave_rx_enabled_flags to precisely manage the port's collecting
and distributing states. Previously, there was no dedicated method to
disable TX while keeping RX enabled, which this patch addresses.

Note that the regular flow process in the kernel's bonding driver remains
unaffected by this patch. The extension requires explicit opt-in by the
user (in order to ensure no disruptions for existing setups) via netlink
support using the new bonding parameter coupled_control. The default value
for coupled_control is set to 1 so as to preserve existing behaviour.

Signed-off-by: Aahil Awatramani <aahila@google.com>
---
 Documentation/networking/bonding.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index f7a73421eb76..e774b48de9f5 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -444,6 +444,18 @@ arp_missed_max
 
 	The default value is 2, and the allowable range is 1 - 255.
 
+coupled_control
+
+    Specifies whether the LACP state machine's MUX in the 802.3ad mode
+    should have separate Collecting and Distributing states.
+
+    This is by implementing the independent control state machine per
+    IEEE 802.1AX-2008 5.4.15 in addition to the existing coupled control
+    state machine.
+
+    The default value is 1. This setting does not separate the Collecting
+    and Distributing states, maintaining the bond in coupled control.
+
 downdelay
 
 	Specifies the time, in milliseconds, to wait before disabling
-- 
2.43.0.275.g3460e3d667-goog


