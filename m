Return-Path: <linux-kernel+bounces-39202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A5383CC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB5A1C232F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463713D4F2;
	Thu, 25 Jan 2024 19:35:10 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D513BEB3;
	Thu, 25 Jan 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211310; cv=none; b=EVyKtvVNTtdEOZCT21Tf2TzVNd7N3n1JpRxXeOQINvRhGeigl1ApoXevbiXYUYpD2LNsdyfDRqVODiXTshH8Ev714ezOYm43zoPJbCribiKa9yI/gSORoo/lLgzAwuKOPWw14RU9VNoe4daxLlyNVYu9Qe3FGacKLIDOIlaCuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211310; c=relaxed/simple;
	bh=iaNON04PFPW8cbzh3PqExj/Jn5dsPdrdtv89hq7wOX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDIVzoCD2o6bcXI90MtNMZNz4L8BFc6xphQkstbxwsgj1tHSrPzBixG2NSdsGT/VmCOqHYoIVVIUt9Slhilq2+ZtvlCSfoKeZUJIb5wTZgf9sviPiMhR0csqQj9fPwDf0Q0sNaePXLRQZcUeTM72vah3oCCdHX7dlsoa6BzZkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso740443266b.2;
        Thu, 25 Jan 2024 11:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211307; x=1706816107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tSkiI7cDySn6RqiOrCnsVqnV97RvzjBiN6Vpdxs8xs=;
        b=n7W5BinqPZ8BPSbvAkQRoONhncERhoxLGWoGJG56wEoFV9hUbBrgaCy+XRR4Jc3qN5
         qxxifAUvYZH90N8Qhs5CsgTlB2qbhqm5bG4sLVsNXWOpRDZKw5FX5ujQUdOZRopkrbRW
         ORt8ys7NfPf5P0HXH3JMIUDERCEqYcQBg0xbgRqQoGUbW4dJw5KM5DViMOxGAYwBBCEC
         yBlnYqwHvN8i1/q7RDl8okVwar5bN8BEY/QEOYPqeU9oVKwGPkQ0OvTzGvY8erFR8Byi
         ybhpS9wL2Ofrs5asjoAZ8pT2jMoIFrUcOMJsDLtr9+YHhnH3as2L9GNSBCVQmVtsiWc+
         X2Ag==
X-Gm-Message-State: AOJu0Yx401kprtZVIvZeVTD174dpPVysc37jpXa+prLmrc5C8OJdVzvR
	JAThIUOXgI7zpUIYaQGzBs1eYYG4Gr4xtv7m1BlIiX+Z5YghXiAN
X-Google-Smtp-Source: AGHT+IHsHDy4fInlNSMwOR4TQiWdCqh+5mMGgYZydp5jSSp2Ot02GZ2CbrNuyxJzthz0SFZ8098TSg==
X-Received: by 2002:a17:906:6bd5:b0:a31:818e:c98a with SMTP id t21-20020a1709066bd500b00a31818ec98amr58515ejs.19.1706211306725;
        Thu, 25 Jan 2024 11:35:06 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a3385892e7csm411203ejc.183.2024.01.25.11.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:35:06 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Timur Tabi <timur@kernel.org>,
	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
	Sean Tranchetti <quic_stranche@quicinc.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 04/10] net: fill in MODULE_DESCRIPTION()s for Qualcom drivers
Date: Thu, 25 Jan 2024 11:34:14 -0800
Message-Id: <20240125193420.533604-5-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240125193420.533604-1-leitao@debian.org>
References: <20240125193420.533604-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Qualcom rmnet and emac drivers.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
---
 drivers/net/ethernet/qualcomm/emac/emac.c          | 1 +
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index 3270df72541b..4c06f55878de 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -771,5 +771,6 @@ static struct platform_driver emac_platform_driver = {
 
 module_platform_driver(emac_platform_driver);
 
+MODULE_DESCRIPTION("Qualcomm EMAC Gigabit Ethernet driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:qcom-emac");
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 5b69b9268c75..f3bea196a8f9 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -520,4 +520,5 @@ static void __exit rmnet_exit(void)
 module_init(rmnet_init)
 module_exit(rmnet_exit)
 MODULE_ALIAS_RTNL_LINK("rmnet");
+MODULE_DESCRIPTION("Qualcomm RmNet MAP driver");
 MODULE_LICENSE("GPL v2");
-- 
2.39.3


