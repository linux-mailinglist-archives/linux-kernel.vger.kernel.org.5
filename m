Return-Path: <linux-kernel+bounces-17347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F344824C03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D23B1C22481
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220DF2114;
	Fri,  5 Jan 2024 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNUcjAqj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376891FCA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c65e666609so952533a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 16:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704413222; x=1705018022; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZCm4qbqYLKL0X2tawwVQnjcJ74n/29xH0+vMdcngW8c=;
        b=mNUcjAqjjvGF5xpDOMseDVfN7pidAvcDn8p7kxy/x5Bdu8hGrAxDFUyALF3G9VVPt9
         7A9UOgTMNICN4XfcSibsZJFqevzeUebtcwSQ54z76f8/QKtXF2mOdUx63kXLWtH5jzMj
         G9jnxMyzXf5LzCBZJqoSpSqXjboQAZS8JqOq1E8dShtX2JiCwUhEK83omsumSpSquATp
         oTWHipD7KjgO1ox5zJ7Nu1SY0K4iQ37eQjuXVjutPMc4WpsAHED/BNMkfb+OvfIr9vxN
         t5picz7zohze/dJNHm+bs3Q0ebLtvvc0On42MA5jbOQEEzHtug7dYGni8aclLLSaZLl0
         mpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704413222; x=1705018022;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCm4qbqYLKL0X2tawwVQnjcJ74n/29xH0+vMdcngW8c=;
        b=jsaOutFVka3yQnJDNMYSN9Rmqsg4CwZb2IZLijhD495BZuFZ86Tl7O110vACBT82IN
         jzycmyTX2l/dwB5AzOzX3/h2pCaejbNddUf5jN0Yy2AvhQR+Ry/xxZ5T0CDY7UY33p8U
         WrUATot48LD/7T3L0VKKF8vNiC6TVC3uGLjDXarUbC6/CYYQ2xFiw5DbecNlc3l4MKcx
         BfMZixKcqkUTjFIkAUYoERVndYtmu2Fgi2Pj1gnPdWTYfiqWoDzzTm++S/uc+aHdoUau
         lG5Wj2TkDkhUROz0enVe9fYzub8TG0iYuelhjFMI8nzupS4VXspznobtHeZbCx/M9KdL
         FhYg==
X-Gm-Message-State: AOJu0YxryDxTXEfsAgbi8TCV6ZUzo3C43rceqf0C/QiBNXiIbnstrT6F
	9dgdE8UW1wuips/rWpr7wAddnDbtJrO9v7KQUQ==
X-Google-Smtp-Source: AGHT+IHb6FEqMS6VkQV6gQcy0yPlOOWrS8GMaw7PQjYywVfcrON/vGn0KJ+AFDUgAAOp00kXqWKj3DYnRYM=
X-Received: from aahila.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2f3])
 (user=aahila job=sendgmr) by 2002:a05:6a02:491:b0:5ce:474:352b with SMTP id
 bw17-20020a056a02049100b005ce0474352bmr7789pgb.5.1704413222131; Thu, 04 Jan
 2024 16:07:02 -0800 (PST)
Date: Fri,  5 Jan 2024 00:06:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240105000632.2484182-1-aahila@google.com>
Subject: [PATCH 1/2 net-next v2] bonding: Extending LACP MUX State Machine to
 include a Collecting State.
From: Aahil Awatramani <aahila@google.com>
To: Aahil Awatramani <aahila@google.com>, David Dillow <dave@thedillows.org>, 
	Mahesh Bandewar <maheshb@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
the LACP MUX state machine for separated handling of an initial
Collecting state before the Collecting and Distributing state. This
enables a port to be in a state where it can receive incoming packets
while not still distributing. This is useful for reducing packet loss when
a port begins distributing before its partner is able to collect.
Additionally this also brings the 802.3ad bonding driver's implementation
closer to the LACP specification which already predefined this behaviour,
that is currently the implementation only supports coupled control.

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
 Documentation/networking/bonding.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index f7a73421eb76..cb3e6013605d 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -444,6 +444,14 @@ arp_missed_max
 
 	The default value is 2, and the allowable range is 1 - 255.
 
+coupled_control
+
+    Specifies whether the LACP state machine's MUX in the 802.3ad mode
+    should have separate Collecting and Distributing states.
+
+    The default value is 1. This setting does not separate the Collecting
+    and Distributing states, maintaining the bond in coupled control.
+
 downdelay
 
 	Specifies the time, in milliseconds, to wait before disabling
-- 
2.43.0.472.g3155946c3a-goog


