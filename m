Return-Path: <linux-kernel+bounces-65422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9306854CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B341F245D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FB66027F;
	Wed, 14 Feb 2024 15:29:13 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B9160273;
	Wed, 14 Feb 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924553; cv=none; b=gb9K8wNOUOJ2GHkoLMMFTWHEzkrUnHRXXuNg6XReRpsjbxVB4tx7Laj5yrXQoTTf1trbT1lq2a9O69vjwzP3DG2/wBB3b/a3bOC3lxYjiMBg6XaNgRmdDuz0+3dvxeYUruAOBQQ79FjGUMsKxLIfwES9J6hhyQcXiqK0FVlyokQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924553; c=relaxed/simple;
	bh=irRQ/m90YekOG71Qw6BtrTc5Gvq0DSqk8L96juNCHcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Br4ovItzXMlYop85x+jobAuEs9WNNpUP/RLn4krLDxhbib4RVYaU/x3/T7dfym1HX3uge0ZFReI0LqFRhbTwKyi6l+un7BBy+5+fyTqhxR3n/1yQqmtrDH0c/QnSfECAC/PH4lVPVT9U8d4qG7IzHKXwYBLl+UmEupxpVs2aDrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0e5212559so53890491fa.0;
        Wed, 14 Feb 2024 07:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924549; x=1708529349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2fi7YzH+StJmNwBMeEGpiocT0DtpILeZR/6wF23oBc=;
        b=u+Yyz5IC9qz9iH1bjqkpBs6YPE3V62es//kTSWdVCiioMv4GyYw9og4zF2pMNlcVDc
         KRPS0o5oiZSIzgsCUVzc3giDPdV5d3ipa5gMlowzSqsqlfdc7hVI2Zk1eoJofjqaawtW
         hHwaZPP5VuTO6nVwM77PJqbyznddq9KcdgtY5ualGCsOf4GrPm7ElLZ+VvU1XLxeAePU
         LEyDWAAQifSMsABv1AfxDuxlIMOK1Tzp1Y1GOHJttSTb6wn4xo0LSSsu3ZWu9Scgbrge
         3aHJ9nhnOVJqqbLkIwW+ZBCp34rM5yZNs8cNgaIl5Cia2ILiuhmx/LzrpatELazCBcAy
         g+wA==
X-Forwarded-Encrypted: i=1; AJvYcCXdGjiIHtVXMrkBXWwH44U4sh/ARzcNk7ov3EVN7Fs4basnFZMj8tyJ2/4Ny8Ii8nFoqJ9StGLnZII9BXCEIraRp0rqc6LwPFeReuai
X-Gm-Message-State: AOJu0YySvIBNoL1PD3XEBYQ2ZHNAKRv9EeFRJVkQagxK3MKHNlIMXjhn
	lRwbHUGRddlsGVcDc+n6MDKsAgpN9J0DrE5cwN8W1CmufhREokNJ
X-Google-Smtp-Source: AGHT+IHFH9me6/jnRBPLrXtv4UobMdbWLe6fDU9zE4CI9eH6dSnSBa322QSP7vxfzemaPEgeAxiINA==
X-Received: by 2002:a2e:9799:0:b0:2d0:adde:cb6c with SMTP id y25-20020a2e9799000000b002d0addecb6cmr2257473lji.22.1707924547140;
        Wed, 14 Feb 2024 07:29:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZHhj2eGRrNszLqtIi7Ofs6XmCMyLXx+f/Z7PmEMJi0FynWRsfBDznZTAw2S2GdZbzEVCYz1/zOmZNMf9WXm2TEdxsDTyVgsqalAUihDLV50zL4oLpouxQHprYSgzYMxTCtW3yDKi7cb5rt9MVYub/GzYBI43AkPEnZbw1wIC80GnrGH9qczfVYCpbcosepcWfw9WEP5FEnAW9MA==
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id es20-20020a056402381400b0056394d0e989sm85512edb.76.2024.02.14.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:29:06 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net v2 4/7] net: fill in MODULE_DESCRIPTION()s for fddik/skfp
Date: Wed, 14 Feb 2024 07:27:38 -0800
Message-Id: <20240214152741.670178-5-leitao@debian.org>
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
Add descriptions to the SysKonnect FDDI PCI module.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/fddi/skfp/skfddi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/fddi/skfp/skfddi.c b/drivers/net/fddi/skfp/skfddi.c
index 2b6a607ac0b7..a273362c9e70 100644
--- a/drivers/net/fddi/skfp/skfddi.c
+++ b/drivers/net/fddi/skfp/skfddi.c
@@ -153,6 +153,7 @@ static const struct pci_device_id skfddi_pci_tbl[] = {
 	{ }			/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, skfddi_pci_tbl);
+MODULE_DESCRIPTION("SysKonnect FDDI PCI driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mirko Lindner <mlindner@syskonnect.de>");
 
-- 
2.39.3


