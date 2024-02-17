Return-Path: <linux-kernel+bounces-70057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D66859276
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9765C1C21A38
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A0680607;
	Sat, 17 Feb 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="LvJD02uW"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1B80049;
	Sat, 17 Feb 2024 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200796; cv=none; b=BarT/dop92aGEwSHi3kZEkacFWltT0FCQ7DphEs/OryMV0u6qhydDmuGcp30HjHTh8Q62poi1nmNLZgfpOrjwNcEFRomBgkXkkaSEnXQLdGxajOHubCJNkfid91fQQuFC/8706f05m0FXdyy8nUFz5dXgD7Hs2WZOOT21pRNprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200796; c=relaxed/simple;
	bh=YOg8kzVQDwjf4Bq7kKhd7VeOutfQ0nCyul1OGYb2N1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NL9we+zT1b6DLg5HX7Ph1PvqHr927qeHrBCvJcMWYln52wgeckTh4GVOILRsqh7AmR9foLYAlu7ywD678pMB9W69Qm2AQ2Vqt29AqdL1+xVNMPThbwVW9ZbbLRGBYBHQ6fTFOTCzlxoyVWioqEyLiT+Tzo8nDLDPo5Yb6hDT69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=LvJD02uW; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so2595075a12.1;
        Sat, 17 Feb 2024 12:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200794; x=1708805594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCWx4XGyppekyhLkQZEpGjtegnjXjHw0zMannEoZGZM=;
        b=AzmZD8mnJqe4YxQoHo4vvfzrHKPhrXEjMCIRtc2DYYKtdxox4em2v+eVfufGD7Whbm
         x5TTtws+u9ddfJ0Y4eGsAyFaMQVK2lnQRVLhMwwNHrZTzM1udERxXMSQw2w7e5thZmeu
         1YXtj2feODlqG+tF+8MZFEwZ3cxQKeCM+d66coCK4vyedDMnQ4g7Od85kdRSUZqj+I30
         P4u8FKbmupTO28ykqO9S/h9RJW8i5tophcuxdU5feGUf1dZPXa0xlCpgieP8mYubuTlN
         rW95zRKrTUdpJ75/HpjrnwZEJuGkBRJdjrtgCJv6a34Y7yKV4b4gHnz53uRKlgd0K7XC
         sVsA==
X-Forwarded-Encrypted: i=1; AJvYcCVisFqZVrID4kD7SLUh5pl9RQMrXIgFGh71um8sA7FS6lxZrKA7fla7SRTOyEKxsqjWzJYQY4wPddZrtHlfyIaRlYjEhOLfHcBToE66n+XB0l30FoxpeWZuuoIbLwHYW+8+S5d4rNqkSbFDpjKaHoCzWKlxRuf5TQqnqCBPkRflPFCU
X-Gm-Message-State: AOJu0Yy5qjxBr32Ou1M2dWIzeHfikf34FoE8DXUH5fauMqUxCngYon0I
	ydkxoSnIej0QN/lntArubjod61rlE53aqzwaKgAD11lJxUyu42n0
X-Google-Smtp-Source: AGHT+IE4hSfNSmmELalct0I9YR0J6e+q9Mspk8ruDuaB7ft9GHU35clTQuhdcdisWurlEqC2wsid/A==
X-Received: by 2002:a17:902:7802:b0:1db:c407:c2dd with SMTP id p2-20020a170902780200b001dbc407c2ddmr2001054pll.18.1708200794578;
        Sat, 17 Feb 2024 12:13:14 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001da27cbcf60sm1784564plb.236.2024.02.17.12.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:14 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCWx4XGyppekyhLkQZEpGjtegnjXjHw0zMannEoZGZM=;
	b=LvJD02uWj3k+Nr08+LjoZQ4U7zHCX5o/x5xf8cTMehEuoendWssKo7jsK3Y3dIbmqY27bO
	HVZwSMo0j8JE1cIHlW+yxmTt/cttr5H/6zkgwZZSJwJSMZVHEPvVfa9kWlVAGOv7nB8Y0l
	/NYIgRISInQs5VMHhYeD748dVhOyZwaK1ksQwbma1qk/BGUgrLkcpRCSu+d8OBDV7L/sS7
	ZAaAkQvOT4VVK6TebZmLAtyTQQE+0w4wZnw325LDS8IRpcMN8oSWvESk16yz6aTozA6APA
	nvw8LlQvlNe23sOWVmii54uxj8rJ+JL7Rocsd+1BuJRkPaIz4LZxTXCbVrBjoQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:28 -0300
Subject: [PATCH 06/12] net: geneve: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-6-1eb31fb689f7@marliere.net>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
In-Reply-To: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
To: Oliver Neukum <oneukum@suse.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev, 
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=YOg8kzVQDwjf4Bq7kKhd7VeOutfQ0nCyul1OGYb2N1k=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNsrHlscC/Pn9bzC2NTQXqUj6ySs9nByifKi
 Ccg3q013BKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbAAKCRDJC4p8Y4ZY
 piy+EAChCqwWchqM6ZpXCLcRkuV6P3qJl4sCOXUzQ4bhSoNfWUXQiTyMHFwVnEdNFKRDIaKYeYk
 U5iUFdSNy5AtfAslyF/33sONfDbXEw6rC03PEWcuUW6mOl4xSuqnY7zqoKkFd86g9Yb8vVdqmUs
 TeFGPKd0qrUT0WpJQJI3XJ9wf4QLnkwJ9EQzUfai8SCDzKmQf7H3MS0FdUxdzDy6djgYRm1MZ0r
 4Mv2WDB6N4uDnxkizopad3qg+jKPVNDMAXRh9/Nh10Wx6azjN26ZrPIhkCinLObvpv1TFppx4Ly
 DTsGFIEvwLHORp6rBzzLC4z1+zzCf2vj7eXO5D3WIsMjHp1+xx0Bm2MvnHIOoJsp71P0Mu3a6ZZ
 4vPNQujw7d9a8rGJqTOUwaeaamj94SpFMjRn4rDeItrOGVVsw3fwqS9Sz61NqVS33XgkLykI8sm
 AwASMJSANRsleN1X3J9+o5mgSCMgMu1GmolcH1rEaXwYuO6wcbieCos8jnyWB/3LsOpZiEbALfX
 dzgiJiAicO2OW2TpD7s9UitbToW9uTUECq4SDHa8pAcvkVtGY+ELdfqVfUZ3LQU9DrSgIy+qiV2
 yryHWLG2/fQTBIraubqEub3LrZW4PVmCQ7AzimX/Aon0FL5NAcqIar65NMJq3GKN7gqoJoQRwKL
 +uVTULqhpNK+LmQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the geneve_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 256602a72356..6f3f9b446b1d 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1142,7 +1142,7 @@ static const struct ethtool_ops geneve_ethtool_ops = {
 };
 
 /* Info for udev, that this is a virtual tunnel endpoint */
-static struct device_type geneve_type = {
+static const struct device_type geneve_type = {
 	.name = "geneve",
 };
 

-- 
2.43.0


