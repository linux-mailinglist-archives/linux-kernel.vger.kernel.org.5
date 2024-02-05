Return-Path: <linux-kernel+bounces-52399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8685D849790
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433D528D3CA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990CB1AAD2;
	Mon,  5 Feb 2024 10:14:31 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954481A28C;
	Mon,  5 Feb 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128071; cv=none; b=gALknU3pOLjmb+JwKTXaQINyezMIGcqja7/pft38RW1NT1hnRSgfO34Hf9Ot5hpd73k5z6a91O3XN46SBR5QxEjx40q3Ze3E3yakth5sh0/dx0WGIgQtFpKwRwTRr0lKXyHuEIwBlCRWNxmMzCcVPSfzxG/V9o8nDVILoExKhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128071; c=relaxed/simple;
	bh=kTipcvln+EVFZhPdY2sRGGExTejqwAm0zYzxNgcQiCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVSeCAKoer3dJ5x03lAg2UC/otgQTSBDF0FcgS8+leTYcq9KLCTIGr6V3Hao8sznQVTwWlf1h8EMZ7bw3nV6vwwmZUVwAulszEbY0DDbu4MDs48E35eBxqlKtOv/ri+w34mPdPDX+1qqSvq3aPio5yKz+5zOnQg8L1RdZN6feVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so5934874a12.2;
        Mon, 05 Feb 2024 02:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128068; x=1707732868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyrTVeg8VkhwoX9oeILNq8yjbD6EKV2tgaLB2i1nF2U=;
        b=eGurriju3ZmXn42TWIr1fVIBC+0obScTcDONyyVnpHMkAQq4gHCAXVp5BCzP1RAHtg
         IYTKkJV4Xrf38AXGA12vNfDGFTSu1EFq6xS0AlJHlx52cY0XPAbRzb7zvmI8exWuEvE/
         gph0P0vF7GsOK8K4T13B40zkl2lQR4+oiUOiO63PnB7H/4cA5dLIqZs2IU+AHGA9GxTO
         mFcVuY7yHQwLgjrNidawpGvsW+PqAfqMGkrK54qLd7r4LNqw/forpQcSU4SYuF77QFoN
         +IZknwKnF/QhQ/vgbKmjTWnxxPDAcLOFc8lxshmgDqdjkszJnwu6wOHsEmwC5iIURl8W
         YxkQ==
X-Gm-Message-State: AOJu0Yyo9z77i9gQ4h4BCNoXscKRl8mKfmCEJszOyJ0Jr5Ybsu4pdYz6
	64NBYC57988HtEEpBU32N6TVBo4nNVSkEQ2/7lC0aK3YtEmR6i4l
X-Google-Smtp-Source: AGHT+IFFoo1bicgUxJRU6yudtS0kn+98FE/ubRwj8ruPDcdsbnfXLFwsnbWhG95PggJRGJoSUqQWfQ==
X-Received: by 2002:a17:906:304e:b0:a30:4189:4e10 with SMTP id d14-20020a170906304e00b00a3041894e10mr5981958ejd.53.1707128067838;
        Mon, 05 Feb 2024 02:14:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWs2Hr8vLGGE/d2DoB6woVRkJZ570evwi+DciUEPtUYjMi4eR95zM53Hymb7EL7nN8H3MtiX8XFllbfP6rUkjuw8JN7g1j7qFvpDglnI5V3Hzn3LZsZ1UA7MEotaqEnkc9W6prQC4tESNFGrELL8EJ2WcrclKfEItBoJjCxkZP7Sx2Ar0KeBRUFomGdorwgIegiPP95P85gtWy0HbRcHcGKeza7LUpFL1iQx5UWbK4iDdpLIQbOPDoK2Y4S7TqOv/joA8JSq/EWo3f70lZ2xx21+pSCTkkGEsx9pxdYgrfeNRgxLIIBopV/hbR8ob3981VLUuKfr+av8TkA1MF4fUBnChpeYcV7VL4NJuSM+LNAsxIU+Q==
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709063b4800b00a369b47996esm4158576ejf.80.2024.02.05.02.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:14:27 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	linux-wpan@vger.kernel.org (open list:IEEE 802.15.4 SUBSYSTEM)
Subject: [PATCH net 08/10] net: fill in MODULE_DESCRIPTION()s for ieee802154
Date: Mon,  5 Feb 2024 02:13:57 -0800
Message-Id: <20240205101400.1480521-9-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205101400.1480521-1-leitao@debian.org>
References: <20240205101400.1480521-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the IEEE 802.15.4 socket and 6lowpan modules.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ieee802154/6lowpan/core.c | 1 +
 net/ieee802154/socket.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 2c087b7f17c5..d19bc9314374 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -280,5 +280,6 @@ static void __exit lowpan_cleanup_module(void)
 
 module_init(lowpan_init_module);
 module_exit(lowpan_cleanup_module);
+MODULE_DESCRIPTION("IEEE 802.15.4 IPv6 over Low-Power Wireless Personal Area Network module");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_RTNL_LINK("lowpan");
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 00302e8b9615..a93b592c2f83 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1136,5 +1136,6 @@ static void __exit af_ieee802154_remove(void)
 module_init(af_ieee802154_init);
 module_exit(af_ieee802154_remove);
 
+MODULE_DESCRIPTION("IEEE 802.15.4 socket interface");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_IEEE802154);
-- 
2.39.3


