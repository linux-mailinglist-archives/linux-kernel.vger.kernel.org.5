Return-Path: <linux-kernel+bounces-15530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F84822D6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B101C232EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1030519452;
	Wed,  3 Jan 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="37mFj8qz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M18QOB3l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AF18EC7;
	Wed,  3 Jan 2024 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 11E363200B01;
	Wed,  3 Jan 2024 07:46:01 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Jan 2024 07:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704285961; x=1704372361; bh=/YviPdGLiP
	zVy+UBu96lnyvudyBzhXETVuOdEEmoVnY=; b=37mFj8qzThYf0OHLiNiNt6+Kzr
	fs/DrSxWzwL3K5Zm55mjG5r1SlI4Kztn+D+/fVWNzAutasVCBUFt4HzZDArPtZpd
	0mG5VkTZbcjkQE2TPIZ9FBIquoyGUs0B5IidqiQcp0nGqXA9EB9mE4BHmenkXhYW
	L/Po8v1oDWV78D1R+r+3Uy+KlbBILYUYn2V3z44y//MesGLes8DdzbYeFalHjGLN
	3QivW+N5kU72Na9yCGpL4ce0vjxThyiJVZmJmpflqQWyXYlTNDU3jk527nGhhL2b
	kybcJxlhQzd6eBi1iRoD0lv7XlT9C3Wdy5yeIppeP1awCnJYg/tulms/Gg+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704285961; x=1704372361; bh=/YviPdGLiPzVy+UBu96lnyvudyBz
	hXETVuOdEEmoVnY=; b=M18QOB3lpnuX7UIIPcUOnkESWrGWNpytFQtFOLTUo2xg
	HyO/FJVU8jOrqsIRrddXqJYfmk+GwT9GiI6eJguV+z9gYljk+a8WLo43ZEH3NCGK
	kXRAmjD/w4jLqqQNiJ/X0T8PpTOKNFhQ4BgfZOPwEjRJB+EoLManx8xe87gI4cFH
	RYu/2eAok0flIb/9XrCAEDLtbNvKFIuPmWRsUypEZUh89jp6+oH8c8NwkXqsscbC
	/QLj3SYi3y5mKMh9pfEEHD9BT9fMSd5vAHbmtTorj+XYObOfTCNIzIiH2M+abR2G
	sozfLm3n4X7QEzU5f3MIxDHDcORsdT9J5/9yOVRcZQ==
X-ME-Sender: <xms:CVeVZfGYMXBBwbIMGbb5vRoqJ8lWfmXo9MRAm0wDNA529q8Dd_ZoTA>
    <xme:CVeVZcXAqJiANhx0xZbvWHPCcrPQEQNANrfdGNDOK11Hko4Np40ncrOrw0_kVdUDA
    bJeZ8VlKXoyhrdaylY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:CVeVZRJqByB2XxDf71DssllxMxQiBDWsn1vpCIGKZmUhP4wqPlUOhA>
    <xmx:CVeVZdHB7_XE_La-qJ0L-7eUQemP9mvO2zXkxt36QwUvQ2aoCVsHBQ>
    <xmx:CVeVZVUQJ0bb_XCOl5c_84SfC1uJl7RRLkQZNBStE6h689DH06BaXA>
    <xmx:CVeVZUEGCEBjlTkjGs_BECuaU81YWSXgTL0YzbZiYxHWNEaUDuq7Aw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 397AAB6008D; Wed,  3 Jan 2024 07:46:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b310230b-f20b-489a-97ed-908df193a942@app.fastmail.com>
In-Reply-To: <5b0a6150-8043-4de7-980f-54020a3e7981@gmail.com>
References: <20240103102630.3770242-1-arnd@kernel.org>
 <5b0a6150-8043-4de7-980f-54020a3e7981@gmail.com>
Date: Wed, 03 Jan 2024 13:45:40 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
 "Lee Jones" <lee@kernel.org>
Subject: Re: [PATCH] r8169: fix building with CONFIG_LEDS_CLASS=m
Content-Type: text/plain

On Wed, Jan 3, 2024, at 12:33, Heiner Kallweit wrote:
> On 03.01.2024 11:26, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> When r8169 is built-in but the LED support is a loadable module, the
>> new code to drive the LED now causes a link failure:
>> 
>> ld: drivers/net/ethernet/realtek/r8169_leds.o: in function `rtl8168_init_leds':
>> r8169_leds.c:(.text+0x36c): undefined reference to `devm_led_classdev_register_ext'
>> 
>> Add a Kconfig dependency to prevent the broken configuration but still
>> allow having the network code built-in as long as CONFIG_LEDS_TRIGGER_NETDEV
>> is disabled, regardless of CONFIG_LEDS_CLASS.
>> 
> The proposed change is more of a workaround IMO. A proper fix (in LED 
> subsystem)
> has been submitted, but it's not reviewed/applied yet. And I don't 
> think building
> r8169 should depend on support for an optional feature.
> This fix would also allow to remove Kconfig dependencies similar to the 
> one
> proposed here from other drivers. Link to submitted fix:
>
> https://lore.kernel.org/linux-leds/0f6f432b-c650-4bb8-a1b5-fe3372804d52@gmail.com/T/#u

I think that is a much worse workaround, as this just leads to
a feature silently not working even when it is enabled (as loadable
module), and hiding other dependency problems where drivers
actually require the LED support to do something useful.

IS_REACHABLE() is pretty much always a bad idea because of this.

If you want the LED support in r8169_leds to be optional, I would
suggest adding a separate Kconfig symbol for that, either user
visible or hidden, and have the correct Kconfig dependencies
for the new symbol, something like the change below (untested).

     Arnd

8<---
diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index fd3f18b328de..b54aae30b3c1 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -114,4 +114,9 @@ config R8169
          To compile this driver as a module, choose M here: the module
          will be called r8169.  This is recommended.
 
+config R8169_LEDS
+       def_bool y
+       depends on LEDS_TRIGGER_NETDEV && R8169
+       depends on !(R8169=y && LEDS_CLASS=m)
+
 endif # NET_VENDOR_REALTEK
diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
index adff9ebfbf2c..635491d8826e 100644
--- a/drivers/net/ethernet/realtek/Makefile
+++ b/drivers/net/ethernet/realtek/Makefile
@@ -6,8 +6,6 @@
 obj-$(CONFIG_8139CP) += 8139cp.o
 obj-$(CONFIG_8139TOO) += 8139too.o
 obj-$(CONFIG_ATP) += atp.o
-r8169-objs += r8169_main.o r8169_firmware.o r8169_phy_config.o
-ifdef CONFIG_LEDS_TRIGGER_NETDEV
-r8169-objs += r8169_leds.o
-endif
+r8169-y += r8169_main.o r8169_firmware.o r8169_phy_config.o
+r8169-$(CONFIG_R8169_LEDS) += r8169_leds.o
 obj-$(CONFIG_R8169) += r8169.o
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 05ba5f743af2..f3321299b2fa 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5356,11 +5356,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
        if (rc)
                return rc;
 
-#if IS_REACHABLE(CONFIG_LEDS_CLASS) && IS_ENABLED(CONFIG_LEDS_TRIGGER_NETDEV)
-       if (tp->mac_version > RTL_GIGA_MAC_VER_06 &&
+       if (IS_ENABLED(CONFIG_R8169_LEDS) &&
+           tp->mac_version > RTL_GIGA_MAC_VER_06 &&
            tp->mac_version < RTL_GIGA_MAC_VER_61)
                rtl8168_init_leds(dev);
-#endif
 
        netdev_info(dev, "%s, %pM, XID %03x, IRQ %d\n",
                    rtl_chip_infos[chipset].name, dev->dev_addr, xid, tp->irq);

