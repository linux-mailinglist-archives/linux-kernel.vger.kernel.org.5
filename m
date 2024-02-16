Return-Path: <linux-kernel+bounces-68636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E17E857D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CFB1F26DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7424712A145;
	Fri, 16 Feb 2024 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="eHKPBkH2"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA81B966
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089764; cv=none; b=sE6P1OwQ+wT0F50+Mvvly9nyktLBlIvm7gyCs0kx6cjT9eiKH7VBOK8YEZ5cQP8O2CSICVIWjX3SdVUlBUou4AcOFMGCzyV/oHJE1jXne2iq3OAGPBRfreD2JtHpm0VUNwgHiMQicumwLOJHdrmrbM6cW2mycuEeikbAWvEFtXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089764; c=relaxed/simple;
	bh=FsNmchVQuTTQMH/B9KKVO168bioDU6bYqSApofTtot0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XYYGBDbopif4Cyg7E1K1VWPOP7uSXRYGbdRNt0nKehXpuzmfX25VzxG4SVGkklDWiKj9xlCKSuE1Mp9ahYQ5iutNi7yLmXD1rcmxZUmapg2bT0LduBZAj1iEfTEMuRyN7Vi5tbCREU0GHugxH5eFVVmn4KMWpBlVWvcW0W1KTyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=eHKPBkH2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3de25186fbso70706066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1708089761; x=1708694561; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aFDoU4DI8sHTODaC/giqLy7tDcjeeFmno8f2AA/diI4=;
        b=eHKPBkH2tMIilq4kf2bVe+e/ZL9zguR1zfgq62EbyiN37NgFkoS/11M03mJw672bWS
         N+P9UTArMHbk1D44BdD/JHqriApONz5nIgW9qpKwOQYfz0AG/svStcyI5Cjrq2P13vwX
         cqjI2PyXoc/Xg72bkkJnbAWPa2Slh58QfB7dqNTWSJQqwIE6YorRYd6GLcsgf05bdsIm
         CsQLyUWenYGxwKiaNJXNpcT0rl2YNd2KmO/7YqDe6sWvKlBWegDJZC6hvyyP3mjv+OSX
         O51xxt5BCR06A6WIQdz8gQ5B7AZl3AXxZsaLBs7pmkiYiZWYy7heieT0AtKX3QrrIpxN
         Dnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708089761; x=1708694561;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFDoU4DI8sHTODaC/giqLy7tDcjeeFmno8f2AA/diI4=;
        b=tauOt41htKvLIZA2ZzE9FpxMGff8Zh/BtWg9BwzlPJL/Gu92XeELsJe7gWGpJkprmH
         zgvr9E1yfE33yO8lB3eg90FhCq06Dbb9vh7HWoQagOBpHc8d53kheRETQW477IyIcCuC
         u0pxHk6ClvINwwqZ3WpM4f6sqpaHBRaCUTfUBM5Fyrn2u7P5WHD+HkSviSvjGHEoD8DK
         T1/sBkau6xepCsRI8Rm/upJXoc6st1NGXrV6wmIFkEYPvRn0pOoyoIq4622ouK3OJemq
         rBXOrSQbQdVG0SiKJrjeVhUi6+bjWOuBkSY57c5/rWYf0+Vkc0wv8a0Tnrz9YHA0JAQO
         bZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOE4LrX43NNm5W6VvWfvp/0tieRP00AN+5JSk//u9JzdOs1Y6L83OiOkJGjprAFav+iSURK02Cw4I3dISoAsOpPZkJK48zoplPGCK/
X-Gm-Message-State: AOJu0Yzn7ZQigi08TuThZKfB1btjn+//DONkd/BsUmOrr3clDJBozRYG
	+e0w+hBuH3VXjn9cfEef+Fxmz3/RCssj2zOoi7l++z9Jn6id7/KAXJggsSeMyi4=
X-Google-Smtp-Source: AGHT+IHMkALfGXBfUoxsJpAiTgK6gRswQPXjfjP645gXjCyLE3nug2dYR+7QvReh0nh5hW3kChm2/w==
X-Received: by 2002:a17:907:382:b0:a3d:841e:3d75 with SMTP id ss2-20020a170907038200b00a3d841e3d75mr3286997ejb.61.1708089761265;
        Fri, 16 Feb 2024 05:22:41 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id gz15-20020a170906f2cf00b00a38103ab710sm1553060ejb.125.2024.02.16.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:22:41 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 16 Feb 2024 14:22:38 +0100
Subject: [PATCH] Bluetooth: Add more Bluetooth version defines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-bluetooth-defines-v1-1-6c39aacc66a8@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAJ1hz2UC/x2MWwqAIBAAryL7neDag+oq0UfWlguhoRZBdPekz
 2GYeSBSYIrQiwcCXRzZuwxYCJjt5DaSvGQGrXSlNDbS7Ccl75OVC63sKErTopqprkrsEHJ3hCz
 u/zmM7/sBiaEz5WMAAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4

Add the various Bluetooth version identifiers found in the "Assigned
Numbers" document[0] from the Bluetooth SIG.

[0] https://www.bluetooth.com/specifications/assigned-numbers/

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
To be clear, I don't have a use case for these extra defines myself but
some time ago when working on Bluetooth I came across this and thought
it would be interesting to have the list complete. No other motives.
---
 include/net/bluetooth/bluetooth.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7ffa8c192c3f..818eb142eda3 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -39,11 +39,20 @@
 #endif
 
 /* Bluetooth versions */
+#define BLUETOOTH_VER_1_0B	0
 #define BLUETOOTH_VER_1_1	1
 #define BLUETOOTH_VER_1_2	2
 #define BLUETOOTH_VER_2_0	3
 #define BLUETOOTH_VER_2_1	4
+#define BLUETOOTH_VER_3_0	5
 #define BLUETOOTH_VER_4_0	6
+#define BLUETOOTH_VER_4_1	7
+#define BLUETOOTH_VER_4_2	8
+#define BLUETOOTH_VER_5_0	9
+#define BLUETOOTH_VER_5_1	10
+#define BLUETOOTH_VER_5_2	11
+#define BLUETOOTH_VER_5_3	12
+#define BLUETOOTH_VER_5_4	13
 
 /* Reserv for core and drivers use */
 #define BT_SKB_RESERVE	8

---
base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
change-id: 20240216-bluetooth-defines-b810ce543191

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


