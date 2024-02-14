Return-Path: <linux-kernel+bounces-65419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4739854CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D11EB254B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361E95A0FB;
	Wed, 14 Feb 2024 15:29:02 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103F5C910;
	Wed, 14 Feb 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924541; cv=none; b=WC3rFiXOVLWfXPHGVCyMPw6uej+gNHBxr+8W/8mcK+zhb14S+1tikNBucb/brfp00nsH9g9YHznNYujHTyMTHAQ9Sslsvk8PIbzJy1OevwkP35TKLXOzVH7B2cEpbslXF1mO6fIJuIC9gHqBzFrGK38+2ieNUvuwPCMJ7AbZZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924541; c=relaxed/simple;
	bh=MR2tDz58h5uN2h6U5uYjVm4rc0y8gK7g0+5ZDc1FeJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4uK20LF8WsNlz1mxt2sc07h91AKRsl+Gn+/NMrGhxrhvEK5qWaLv/p5ofLzuS6ya+8vQwyGyGNCLbDfOLHz4k9fZWfwu7U1FNnUwU+egY6ksC74zrii0H2HYtlN5nbGvkfLJRA2mlR4PaBxTw3wOhpSRbdcJmztBQXINmApb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so762977566b.1;
        Wed, 14 Feb 2024 07:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924538; x=1708529338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ywgijd0AB1UdEP/G8o0p2+lNq+pzPJZCGntMh1zrtqQ=;
        b=wohFmSko9TFD94+cnI+4YRUAnIL5m/wWIHKyKOpr5lLm/jstxFRszxBtn6DYwf4ILk
         IE/ozSb1WHoyTD4W+xhqbURJM/WqoFiSiM7ONrXX1X8mcQgHPShwGWbwqCKEkrDea61p
         0jCtxwO2bNnZoQHkpVCD2QjuHRKLTbJhs12vpIqY54k11Jem+CNOmf7DAPU0q0qlb8N4
         /+giXDs7eu+Ak46UgxY30zaZMsX4clJVCCDGXp+bdLH3dRyMUMLLafntN+xHSwRldc9a
         MPlgvIoBP3pNuTv8g0Em5MQ7/+EdbpAsWwW02WsFP7qm8nnrcILDYVfbekF/fI4cwuL5
         mXAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm6jXfIcw5tZ5WFTFqdM1B5G17Ae5sB3PY/czMvehQE0DNj1HDFkbgWZTGxgT34+olX6AEPaiceHoOAuTTdBxXy2PKDGS4kzC3LrCL
X-Gm-Message-State: AOJu0YyWxvBhQGJYigOjprvXrm6aNvx3hmVpWjpOIYaVr4v+B0/IGdVF
	+GCvsbrapbwdmG0E0+Qcdj7MsOT3eSACvcLkwjTVTTDF/i4Qb7tRboTTFz2A
X-Google-Smtp-Source: AGHT+IFtJU0LK8XMLjaJSuQ2WCKqrywmYokSm2MZ7f9DhVf79vcqxli9RGGYxwNOsedtO8MxADI7CQ==
X-Received: by 2002:a17:906:bc59:b0:a38:916e:a4fe with SMTP id s25-20020a170906bc5900b00a38916ea4femr2111177ejv.39.1707924538262;
        Wed, 14 Feb 2024 07:28:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfMLVUFkbuHzQC2OC9s91+gjpxuK1mhdiXAmM1GCwrXLwkEtoLQ/eAjQgNpnuenBaafZecJiI+fj5O3FrEWMo0RdLIhaRBa7Gbwp0QJMtysEWtRtMjhGoi78wZDfEfd6cEWMKtsajM97m0ienpP+djQBkIXcvGXSudvpg3bh519cHjBM3u//oK/24GkJejh+fTi9dUaiVhQMEz3DsLuY0YCPDocCexAJA50AtvWEgi0O6d5eyyQjOviJzqjcuAHP3vSiov30OMzy57ODllVpl5L5sQz5oWHB7SBaPP9g==
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id kt19-20020a1709079d1300b00a3d6b13c4efsm189745ejc.180.2024.02.14.07.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:28:57 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Wei Liu <wei.liu@kernel.org>,
	Paul Durrant <paul@xen.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	xen-devel@lists.xenproject.org (moderated list:XEN NETWORK BACKEND DRIVER)
Subject: [PATCH net v2 1/7] net: fill in MODULE_DESCRIPTION()s for xen-netback
Date: Wed, 14 Feb 2024 07:27:35 -0800
Message-Id: <20240214152741.670178-2-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240214152741.670178-1-leitao@debian.org>
References: <20240214152741.670178-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Xen backend network module.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Paul Durrant <paul@xen.org>
---
 drivers/net/xen-netback/netback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index fab361a250d6..ef76850d9bcd 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1778,5 +1778,6 @@ static void __exit netback_fini(void)
 }
 module_exit(netback_fini);
 
+MODULE_DESCRIPTION("Xen backend network device module");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("xen-backend:vif");
-- 
2.39.3


