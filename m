Return-Path: <linux-kernel+bounces-36021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612AA839A40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D671F293AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE20485C67;
	Tue, 23 Jan 2024 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwOZBhww"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684A85C50
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041617; cv=none; b=gW6O6Z+PWy+oEatYWrhhdWXrUJlA9n/JrsJ+YeLbDzXc7FQvGgiY2ejCiPRbgffyOfi2nDPy0MBNPsyeRBHadZ/zxMmJDjRcWmcjOKA72/QQ7X8Ex0x98PFSHPG1+niciGdechTZOuzwTnGF9Pl93tDD1PB2YnIQjmC1HCX4cCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041617; c=relaxed/simple;
	bh=Cp+ymBvg/0BHYvFzHxqF4DKgxRgzwB/sWXRqtG8txJY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=hhpsx9tZxS8CXBDOfy/kmWyvbDt5FQEqXkH0gyL7/Icw4AMhGyXSiQaWmHkWZTriKetPvCEmKwlLbZJHQ7tmOwU8u9YAu1RpPzUgW5eKVglv+iTCxpoU/IA87/5TkFDk0PQgb8Al8tBagfcF1wiIWFwasR8aHsJJwt9HoWptyfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwOZBhww; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cda0492c8eso5300590a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706041615; x=1706646415; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c0U7M+lCiUNoRWYnkx7E5J9oeIbMrbKijEVU8nWAyc0=;
        b=NwOZBhwwqRGkDWl6RqptZcaaXqbF/XTC6UfYQ7/qdsK5wWIK85dxL65R+TByHINU1x
         DfbsqP03vLkqnBJR0ujsRn2ZEs4BnqFH06kHDQxXVpZ9JXbP+4GzoCcFBOd2AsQfTbF/
         yZlThgKWCf5MSqgF4WtlB+Y2J/Jhkp02WgJbqSUOjU17fZFW8v2Yfp2Y7PW3zyB7VwvG
         WHQN0+nVNy5CSJ97+iqP4vbi0r8dDlnKW2EH1ndBfkcBX5BiVowZGYzJIdrXwlYGvIqu
         qztmBf0zD4/L4gMzZ234+83sTl+UF1eMMPpM2hZYQDaKkdydpd0Ui1cCu675wbiHZLSN
         u1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706041615; x=1706646415;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0U7M+lCiUNoRWYnkx7E5J9oeIbMrbKijEVU8nWAyc0=;
        b=JeSJ9wXA5gWYa91Sow87euI7RUNIsgFRrfEZFqDpzGU9ICUloi7miiOWMatA/KO4Gy
         oF3CAOZuzrO2ESJh4ZXq4MZM4JFE6qUOntgbvHBU76sSSc4thwblFevhuwPuMOua7wkK
         QxxLbYnZCcBAWqkd1J4rdUdetwMQ5yR5EMNAfDfnhc5cq7kR58qG+oMljG8Fi030ZqEB
         VwddA0L/1TghGEv19XbIGfYbXNGq85imx7NkHGlU59cfECeTbVXaG6WDHjOGZ8nbccWy
         cIcDc4veiZH5gJ/V4cr+li6OE78kHK+xEqgDqoTagDtRFfjsIG2ZeeXZZKDm89qb0w7u
         thNg==
X-Gm-Message-State: AOJu0Yz0u1ezuRVqG6L29bKSLtivhyKkyG79u0XPhgRsDUIZPBQHJhHQ
	1tHViGMXb5KGGpCprzMgL6s5MS0GbnvPoj1CyNrOKRpMdWxdZYGMRm5tpkhVe1r/UG36O526TrR
	W6w==
X-Google-Smtp-Source: AGHT+IHdN+SZZs5oEAHmcrkZZmRemBImoRFGAgG+gYZW4A2y8GsnkYoKaLaHs7+ljoxTcFm3ZnySdpH8pkg=
X-Received: from aahila.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2f3])
 (user=aahila job=sendgmr) by 2002:a63:d0:0:b0:5c7:c00:29cd with SMTP id
 199-20020a6300d0000000b005c70c0029cdmr33581pga.12.1706041615116; Tue, 23 Jan
 2024 12:26:55 -0800 (PST)
Date: Tue, 23 Jan 2024 20:26:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123202638.1498449-1-aahila@google.com>
Subject: [PATCH net-next v4 1/2] bonding: Add independent control state machine
From: Aahil Awatramani <aahila@google.com>
To: Aahil Awatramani <aahila@google.com>, David Dillow <dave@thedillows.org>, 
	Mahesh Bandewar <maheshb@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
2.43.0.429.g432eaa2c6b-goog


