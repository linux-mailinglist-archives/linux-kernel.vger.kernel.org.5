Return-Path: <linux-kernel+bounces-34015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1548371E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494061C2A66D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5775FDA7;
	Mon, 22 Jan 2024 18:46:48 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81444F884;
	Mon, 22 Jan 2024 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949208; cv=none; b=MmEaFamCMQPSofNDHqDGgP+eFaKrZYukiFsKIdfg8dtnHVFhSTGNhaRhyCSxzjudNFQOLmYVo42Z2GgfpEZxIMWWcFiPfGBZXzgyL0UH0RkQCkKjQxcDHk/NxDY9WODIdPPrG2mhLMAxJZkIObZDpbzHvPnRI4dJHZOsobcFLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949208; c=relaxed/simple;
	bh=qZMHWN3tY8M/tCU8vuNcFATxB9kwnnXqOlGQ1TlEoPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5mpfFC2TVtr0YeA9PFnXZWdwxWnOxg3jc6GW2xPOT+Xs+d/q/Ia2YzMh9IzBavQPfqLGW4W7k5PL+UH/nHzf0zJ3HebCLfuRNOQ5xBgxEYMFFu4TDQZ4uBoZjZ+oFP468iaqZBkodWfJHepvdsgzpV95/p3rJftLyXjfylQfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so598118466b.1;
        Mon, 22 Jan 2024 10:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949205; x=1706554005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2bvNOsBAKo0J4P3SNjD6LEHrFlzjCm53u7x45ZhuUU=;
        b=h+SkxYZ2hjijPzP4Sw5RRUxUKhW9oGW1dj8axAYH5UcSLGmyKBcc89Ed9og869Buc9
         8NP0PFdMhsqSMWtqhVdpRtUJ43mJvzZAOPs396V+7uiD0ONYup5GaC6m0UgeXRUzNsVh
         61m8zJP/w21w/Jp41XALiX+kcWKh5g+e3FIC0M5Jm+/2UxtrMObDWltHXwjldUJ21aIp
         r2g7ceDloDxIFmcnsU29aWAuLNHuZDporMWapFEdDz2Alm/k36GcTCrkpKmjAysGtUJB
         zOQviiBP+Yl30Xdl78h/XEpvdn32ne6BVi20dLnJbd0hpFVJB19PEudXtIQuFSCWnoFI
         +8WA==
X-Gm-Message-State: AOJu0YzB33FxP9uShg6wzpoRC3jcs8LtZXD+RbSliuANEHhX2t9bp0rZ
	yJ7tQeDqFEBotGm8NdJ0E+h5H2SApaTChI4+MkilnjgyX/p1eknI
X-Google-Smtp-Source: AGHT+IGklv9VxvUKZlT/YNy1WGHxHhxQksp9dg0pDNawTeavac2oxdF8rT/vpKf2mETPmcK/oO8k6A==
X-Received: by 2002:a17:906:2e8f:b0:a2e:cf58:f411 with SMTP id o15-20020a1709062e8f00b00a2ecf58f411mr4845238eji.7.1705949205065;
        Mon, 22 Jan 2024 10:46:45 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id l16-20020a1709067d5000b00a26f6b8be1csm13543130ejp.75.2024.01.22.10.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:44 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Timur Tabi <timur@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
	Sean Tranchetti <quic_stranche@quicinc.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org (open list:QUALCOMM EMAC GIGABIT ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 16/22] net: fill in MODULE_DESCRIPTION()s for Qualcom drivers
Date: Mon, 22 Jan 2024 10:45:37 -0800
Message-Id: <20240122184543.2501493-17-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
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


