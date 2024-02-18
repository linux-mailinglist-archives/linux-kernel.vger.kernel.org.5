Return-Path: <linux-kernel+bounces-70546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6D85990B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50ECE1F2137E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205C474274;
	Sun, 18 Feb 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="AoXU6+2m"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF907318A;
	Sun, 18 Feb 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283864; cv=none; b=eCKXZSLRapFk7H4Vm6Yi/HXaDcuKiDQFsQ2woLrtQ+5rO9md7KmTFpdRvuunP9JgZDebvPK9NXUuP1RcHqSKV3z9ibG0v5KeWjWu08ybQDDmJpgUsleFAWdGfnO6Wn/eGuLlG4Z1XAwrdhlpsBf13zZj56tpqkKwfsXfyGCALhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283864; c=relaxed/simple;
	bh=+OReJk//Vhg4+WPQN5USvzq0O8yv2ebv4GQcKRlzh/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=skoDyEaSRYGMQx3PCWV39QeHkEA7lccckN9uVYN3ERJ2Pvgfj3khTDpUP0nZwFZ0g4jooSETe8x8tE4fRBGy5dqTCOocH9YIuqpXQwuOw92StZxk9YwEgB5ZPALw5U+PyalL7z0YLEZ/xBbIrxlHovNzyk105fJxSWBOV15/rxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=AoXU6+2m; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e4560664b5so382224b3a.1;
        Sun, 18 Feb 2024 11:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708283862; x=1708888662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNj6ussvD5KRxU3ePwBAngKM9ROKdohi9c97Bm1e8SM=;
        b=dF+d+hUGthi4Tb8S/1sEtpglkRH51aysgI1xctTDxnlxPwzsyaPWRqFwSMOmARIfhy
         QfYyT12vvv5dWtH0lvD4aho957FP10djyrc6mEIzUKdoOn2te6W/mGO94U97AYRKWdR+
         oEkQKht3Nb6VRcbm7HfOqbXlg6nHPH68DXZByeWfueEtmXfigKdxuWm4tF0CmRsL+/js
         OK4wfvT/iNxwS4Of74/V8/mz43BiilnshY4M5xhKlMOsw55v9ILlvbXLe3kqKYQ250Nf
         4i1SlTqsrMkzZmItI8USMLSNbhQD6Vs31AcwFCm+bt14rwcb4loM+oTGRmo84kZCjxQ+
         xWTA==
X-Forwarded-Encrypted: i=1; AJvYcCWsazori90eN/YXuocSZSPBhAoBkOflcmslpADHv9vA/u+D8CteEM8npqS3rhZWrReMnHkuxocKAdJDhhgxcS9u0PWhV+Le4jt9Hwb5
X-Gm-Message-State: AOJu0Yxt+lgueXCUBXnuah0xwiixvONNK1HM/i678A69XhEXfW9BJ2dZ
	wtMwGbVwhAgde0Nbg8ikD1WkjdeW7Ixs82hIpTAskGClYcyTE5rl
X-Google-Smtp-Source: AGHT+IHLwDIKU1H3Sd+YUfcgMikRMIhjUw3+YTiTAWgiT2DkvTPmP1BcYjB2EKCeydKb7hGqGE6QPA==
X-Received: by 2002:a05:6a20:6f07:b0:1a0:a1f6:19a8 with SMTP id gt7-20020a056a206f0700b001a0a1f619a8mr2454439pzb.27.1708283862310;
        Sun, 18 Feb 2024 11:17:42 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id gx11-20020a056a001e0b00b006e35764f9a6sm2608375pfb.213.2024.02.18.11.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:17:41 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708283860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNj6ussvD5KRxU3ePwBAngKM9ROKdohi9c97Bm1e8SM=;
	b=AoXU6+2miNwusGTw4Z2eI/vNuZr2ZGOj752zEcXTLmIa1e6OFynTd2v9EfvlsTkdOgg/0J
	kwVsGl/vzXkdJpvcgl0o+C2CvPpQ/+dfMcdjEatMViwLBoV/Ehlv/6Ur0B0Lj7mzPOnQdm
	eZiH7qbmzE/YIgi2mzc6rj/KCEVG79aBhl3M2WGwTnPUKG3I2mWIBNxQqIR51dCanveITm
	iQPKhxTUUE2jjfVssoneqfpMsDEPLMB7odeNrWZsLzyxTvh6dz/KjKuACs6/Xka77Aw0Gc
	C7GkvmNai8AufvUXeWei7cw+rdB5f7JIeKUR4qqBcUw9jzfx/u3YAYJIuwMe1Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 18 Feb 2024 16:18:11 -0300
Subject: [PATCH 3/4] usb: gadget: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-device_cleanup-usb-v1-3-77423c4da262@marliere.net>
References: <20240218-device_cleanup-usb-v1-0-77423c4da262@marliere.net>
In-Reply-To: <20240218-device_cleanup-usb-v1-0-77423c4da262@marliere.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=+OReJk//Vhg4+WPQN5USvzq0O8yv2ebv4GQcKRlzh/k=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0lf1+iYwfgu+86WLxZG8BHmYAkm8/QVRBluKr
 b4UsMuhCKWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdJX9QAKCRDJC4p8Y4ZY
 pil0D/9eehHQG23b3RVySLh7vtmA8hP1BUl9Rr1KAn++zfbsTAEQ+v/aauYlA+EgUSUzsxTAKb6
 4KO2zaE6v9plqDxAJ22XFj1eYsJ5Zx/yWNIg3W1uHe3b5XmkTFZfm24h2o8fxY93dsq2Q/iRCyg
 gtT0JJucC0WmW/3pXMgjOpheurhrjIhn3Wa6SeA8c5zUn25ppBNK/7kWj3+G9WXON2+oObPatgH
 D05N1Wb3l8prCkl8mnMifGBJZlUNaZEs5oURYD1HBDEVA9vSb04cAVZSGiPIHpEQkRH17X+M5Ni
 LWb1jYdIf3IDIcRg/TVcHH4jT2THBaut0Awdwr7Gmlc9P2yj9wS76rUoe0lBnMhQLrvOY/paYs7
 aIetCnbKCOwPiXSiT+OskDPj+ibvAjNGqvXmKi646f3TankpUQSQPvo+z7QlaZ8agE54dKTQ5rD
 qIatCofkTWSdG//5cz4cGV+t8uWl70ITyDhN4/faTUWUgMuaqUe0wgClZZJqqsNSzR0/a09Okd3
 +D+JBFM4V+z0xeOIi2R3GZFJ0oTT0R8dJNH80Zgt+2AoEwzGh2LUymfKNkkEf2wv8Uig6MNFRL6
 o5jYGtNpApEMjigcvXuwgiLQW+xGkFCcBe+0FJAyyUrenrIC40TEEreuJRuAmG2HTzEbzuzSCSa
 2X5sMIFbBkUsXMg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the gadget_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/usb/gadget/function/u_ether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 3c5a6f6ac341..444212c0b5a9 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -718,7 +718,7 @@ static const struct net_device_ops eth_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 };
 
-static struct device_type gadget_type = {
+static const struct device_type gadget_type = {
 	.name	= "gadget",
 };
 

-- 
2.43.0


