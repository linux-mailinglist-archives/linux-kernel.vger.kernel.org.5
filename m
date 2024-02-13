Return-Path: <linux-kernel+bounces-63426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A362852F14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D869D28233C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982650268;
	Tue, 13 Feb 2024 11:21:37 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7650246;
	Tue, 13 Feb 2024 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823297; cv=none; b=Zh+3Tgg252Es2d8q4aPGrSdZRzT/c0yV3cZtYjihYMDEsaizb+D/8ApxNNcoJpvqJAZ++cGgV9MompdwXIyzktCtM8UgCxogqxvOeiYTvcTmlqHMNwZ0Oj+Tk+wgQlNUxJlqpBCgPeGIWp/0EngMIobQAmj0Hmao3zTcTib4GGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823297; c=relaxed/simple;
	bh=WGgUbWFXqt1+hnChW0htysn/em3pt1kCfi+u4sWi1cE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FaMrmUWSrm/WxBJmKuPJUIDgzZEpfb2cXxjW8C/TN0T4rPZnX0lczcfE78GIxoxdooKHZ8KsE/st+XFYTW40Enadd2PV8FzaqOzw6lh8H91YIv+ScXT3Ev00RN0UgFxPz8fKPJWyujXcbTI19cR1twkospcLnPgsV82f7TWTlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a271a28aeb4so534505766b.2;
        Tue, 13 Feb 2024 03:21:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823294; x=1708428094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuiaVQ6xHYwzgr9cteCqN0D6TVSa51dvKVi3pXWKJaE=;
        b=VT/c8hQ72WkeowxtVFnDqwGYqi3pyxa2D1LLI8pNcnnGaDpu3rdxwapcy6n3JH4Yc6
         OUiQH50YcPglJJxLorV1NCDXqgTkVoHtuph2SZwjQ4xm69skp3xpg+mY6L/TA+J4Ppwd
         +I3ezFPLGOMiTytHpcMqL8ijhNLr5fn0FO1iLngHvzj+9BQ3BUJHNOiKh6NXGlvQ3tgj
         GzjLvqKy2k+5O+7vTUaK456M1pJ1voHyBCtbQfJ9wP9q8sYC4qndfiBe/goOBFVlt5xq
         eTTio2OuaRBhkLk9CyMsMcPGl20TMd/Scz3EkeZRc2WuMfMnFdnEm/GEWb3fsqEz+evb
         p+ww==
X-Gm-Message-State: AOJu0YztQaXfae2Hcuuuolqv7go1KpZBiWA4P11xLysP+/3bkNHX65id
	xmHb8XkquAwvmegwdEDK4jElmrhI3Gpya1lH2gV7Ynxbrz0Dm5Tj797tmw5F
X-Google-Smtp-Source: AGHT+IEv53qb/jU/q9VIX3Gx9EPG0zlDnaS4y/im5dQM+F2RnxQvedrUeNJK514EezeM/+8URcxAEw==
X-Received: by 2002:a17:906:4144:b0:a3c:82ed:5b46 with SMTP id l4-20020a170906414400b00a3c82ed5b46mr5065767ejk.59.1707823293939;
        Tue, 13 Feb 2024 03:21:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUz0v9+Mi6zmFUyJoPQn8nNZKJnBjRetK0SFlIJ9CNm4LQ1UNy0UiKtLBlEEtGLEbzUxs3YRg/JptpG2rh0DJINfUNyx2noHYPNlsDiQmwFHDXWKoZSgsnQ4RZtu7I6wjLW58bcNXhXpRMADteqtr+y93bZTemChK1U2JwCroTv22PFl2FuYECkpkBvL7i0HoO2Ut3SJY1eF7os1cD1p9uRly8yNiU0MyAMaMNhc1e7QX9TrPkHGBrPIq/r0sV6P1rBiw2HpoB8NIQE0rfgYl/BO201iAj6M7U5m2OsRA==
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id vw3-20020a170907a70300b00a3c66ac512asm1191224ejc.214.2024.02.13.03.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:21:33 -0800 (PST)
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
Subject: [PATCH net 1/7] net: fill in MODULE_DESCRIPTION()s for xen-netback
Date: Tue, 13 Feb 2024 03:21:16 -0800
Message-Id: <20240213112122.404045-2-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240213112122.404045-1-leitao@debian.org>
References: <20240213112122.404045-1-leitao@debian.org>
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


