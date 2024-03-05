Return-Path: <linux-kernel+bounces-92431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7FB872011
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287AC1F229E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D0B85C51;
	Tue,  5 Mar 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="eVt2T5xM"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3185953;
	Tue,  5 Mar 2024 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645195; cv=none; b=q/C7EiaESYH0/XozHCkqdznBNZsWCPEw5h1VvjXmboKt/DsRhaOiB8AfS9QQOREjFloc6GGC6Q570kFlo5krS5EZJuaoFnyKqW/lEVuYrZuS0oL0ldXpmfonWH//czgyHtlO3Rpx9H6qb8Zux6UkyergAbOdnGBhlx9euEwlKHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645195; c=relaxed/simple;
	bh=FoEk45ceFiqKQNtaPUFaNdU0fgwbZR9BlNv6CwAZiPc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=itBRCjBBY+XwWG97sSBE3nafQTZ+AqRoyb8B8SHS6D4f80yaLrx2n1SRUzouKngsioX4+UloprVHSlLMz8wow4gRxK5ikusUBlasaYJGMtzKdBxRceEDlgVl0pQN/OEEcwCbdhUB59Yo3a8SrTQH1Vzjs7Wqt18z5J96y8xwYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=eVt2T5xM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e58d259601so3588970b3a.3;
        Tue, 05 Mar 2024 05:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645193; x=1710249993;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7vv6ZrTKPXVMDA5O97eXfvb/0f70NPtfMZMwVWIvNLQ=;
        b=i6MKShb1UjniDLbc4+m2d2jtFYuM7dtXuB8AcCBF/6/PcCwShRnT70JRpJEZeeGf5p
         12RYkyt0p4mijRMsf+N87Lkm22LPrS9osERNCBWryI/2vNaxR5tIg3oyvzSVpEhmZefb
         SwoZQHqZWxk/HROXto+q3/SOK53GxZzhkiDV2DNxCNhFOAifFSz7UMOFfRjqiLwtRJTL
         hhidrX3X8ubFkraRQEQ3kzM37qBm1ykC0jgBNE/c8pyuDGdD1wVPXWrwI6WOq0+zjXkq
         NVj7XVqUI6tUCQ6SVLG4/zFUyTZX4QjoK9jM0HNG3BqxabCe6ljdb5UCf+jo/+m7cBQO
         KuDw==
X-Forwarded-Encrypted: i=1; AJvYcCU9OzPUbnbD9cehiXmKMuaQ4PjmSfNtebBrn8QhURv4rQD5V1+UgCYynteumwLcctmAqWikKCrL0AVMgavofRc7lD2z4ORvjHjlSkOsF/b4caeIab0ITifCawUYoigd3nxpITFwmO2C3y8=
X-Gm-Message-State: AOJu0YxijVTe9tRo5HL0pgTh6GRRSZv7/7AQF2hcsolESCEcMuxHYGb5
	smx6nZeSXR3co5kWDN9rEHF7fhzjHZgOM1gnSQJQf/Uu0sX+XHiZ
X-Google-Smtp-Source: AGHT+IH//H+Sctm5ByVdm9O1Jwl8BgiUNB0Tn6WvkraAC9/mKC2LC6EnH2y9uejrjW06w7f9HHc7Dw==
X-Received: by 2002:a05:6a20:9151:b0:1a1:511b:edb2 with SMTP id x17-20020a056a20915100b001a1511bedb2mr1978657pzc.29.1709645192710;
        Tue, 05 Mar 2024 05:26:32 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006e4432027d1sm9170385pfh.142.2024.03.05.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:26:32 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709645190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7vv6ZrTKPXVMDA5O97eXfvb/0f70NPtfMZMwVWIvNLQ=;
	b=eVt2T5xMIHkkDiSvCvtphWe2I/JeEsrga9skQZxxhcNt2NEQZPLtx6AsZQhzHPk1yh1Hz+
	+hIZaBg6B4G2W8Cn68lGOns2cJULpA1JbjmbybF1RLf320wUZ7sP41M+q1nU5p11Dx30UJ
	cUcsplciZiqDb+N/1UtyEq5jE1ER53NOKidKCYyZ9h2CTPtEYHRuEPhtZEHZ/3+1IYOYgR
	NrepAPSGy816eW0yHyEcS6jFT/MgHPU3GRQeEoxvjnQVCSDHX1LoKl9IvMyq/cjjzmd+vP
	KdHeS6Rri2Uuy1FG3Dgv1MP/in6wwLUEv/+21TxTFUjJ43H9f+771qLgu1dUCw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] media: constify struct class usage
Date: Tue, 05 Mar 2024 10:26:24 -0300
Message-Id: <20240305-class_cleanup-media-v1-0-53e1538973cd@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIAd52UC/x3MQQqAIBBA0avErBNMLaKrRITpVANl4lAE0d2Tl
 m/x/wOMiZChKx5IeBHTETKqsgC32rCgIJ8NSiojtayF2yzz6Da04YxiR09WGDnpxqBWbTtBLmP
 Cme7/2g/v+wEaaJOMZQAAAA==
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Young <sean@mess.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=773; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=FoEk45ceFiqKQNtaPUFaNdU0fgwbZR9BlNv6CwAZiPc=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5x2DMB1pifgg/IzA/MaErvw+tt3MyZiPU6rGh
 pebqyh1u4KJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecdgwAKCRDJC4p8Y4ZY
 pjQmEACeW8pJfLenjzpsCW9LbQK7sAmwcGmnrg6NFevBc/ksThhD9+4GlrjKUNMC4dMWwRqWh7c
 wpVzbb5VDDiVa2WmvgGsE0OYFlZC8Sy9PFLVfzNKNpKq9CAxLMApNdrI8MB9W1oUxN5k/TzXJa5
 +GyGEy7kFE43dRX0imOHcQ9zDQF68X+v+IO/N0Ty5PhADMgt5t5YyIafKhmhuBgqS6u8RPNqz+X
 ocyK7ULVg+8lKq4eTnIG4AZe5NtQnHLZDmSElM5VFEOtdx7PXBOEM7iNdhqSBCOi/MP56Q60cWW
 YDdVFuZ+LaPfZk2+fX7z56dFYn/Pe4tggNBBAQ0zrAFqxr+VDjNG7HX7SDheF9csD9ghzYReA2H
 VtlFRLWa/4ZvrRcRKQdo4BZm7A7WzqVFVhBKeC0eDWxT15KXhMo/dRostO0dyIiNIciCdKEYDhN
 ktgtkW+Y8TVbCR6sSLi4D7uxYwWEDNy8VjNB/Irt5Vxrrc8wkMph3LmJ0o5J4qVX1mvm0fd/5Cb
 C2uUaMaiVpsiL6j+1whtRAi6624Z7bjXjZu7x5XirCL7R6sI1/Gx8bw6+LthBKtm/mBBA/Cl0As
 aJdBiUju2jhtdBZUOydmUm8yA1uf/J1fruXQx8O60Lc6acqr2iDed2B70P+wSdGgarrhauXTww6
 rImjVfj1yk9RQ0w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This is a simple and straight forward cleanup series that aims to make the
class structures in media constant. This has been possible since 2023 [1].

[1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Ricardo B. Marliere (2):
      media: dvbdev: make dvb_class constant
      media: lirc_dev: make lirc_class constant

 drivers/media/dvb-core/dvbdev.c | 23 +++++++++++++----------
 drivers/media/rc/lirc_dev.c     | 18 +++++++++---------
 2 files changed, 22 insertions(+), 19 deletions(-)
---
base-commit: 8c64f4cdf4e6cc5682c52523713af8c39c94e6d5
change-id: 20240305-class_cleanup-media-40b364e3288b

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


