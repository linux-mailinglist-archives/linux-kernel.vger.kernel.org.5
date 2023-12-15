Return-Path: <linux-kernel+bounces-796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C02814643
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E5F1F23801
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839342575D;
	Fri, 15 Dec 2023 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="pi6WclaX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2570250E4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3333074512bso928428f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1702638432; x=1703243232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glgMvtXI6KkmHIaNgJkuNjVnZkyLK3+FNQI0ug3e7hI=;
        b=pi6WclaXebaRIiVqzsP8HuqnES18cTXikmJfA+8KRMFSXCOVsKPbMsWzq44YEqrRZJ
         pqMPawBszjLxmNwx/MXGsbk60srt6opJqe6H5r0v1dzoWRJni+MCAnfKz6X5QjclaqGY
         GEUIvUxu3OiHR3O8spWkEcJCYv3sHWS5FGqyzsk5A2Ausn7oK+OucW6es+83oI1T3fis
         LclhWIxrDdYxzrOz4VTfqZx+srUeRCA4rpUnPBoILOjhTlY4rNG2dA9l/fDRF7xUBcdA
         L+v2NXtkAXtpXRCpcR+PX6ZPfkqv/+8JCiqEhFYUfQmSnalbNK027/t5tkgfR51ZGAlC
         2E0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638432; x=1703243232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glgMvtXI6KkmHIaNgJkuNjVnZkyLK3+FNQI0ug3e7hI=;
        b=FWpBDHlozMSlItCoBqxHCJ7MFi7C2QvToQ/OGedZcJoWzOiocUvAwLhOJ2kV62mpaR
         ShazI7SLJqejaU1cWKb+oeLZBdl0lrOUyd4PdDiY9gzuJurJCU4rKRMy/VL+T3TOzjIN
         f2TQWWv5noZP9c/9oSz9NvUJ2G3blqIYdyxT/TzVx0k09Ow7XycLX0P7B1DJxSIxTheO
         9UeThHLSu8UaYnOPwNaZSs9AQy+viwr8pKLGAwb/SwujJAVphpPPirM0pZJvMPpknRlV
         Y6alt0LQSZea6vkLw+xch/uBs4pXyKqbxwHAy+lRHottmBpCwJVARjnZxttnyBRzkL6N
         XH+w==
X-Gm-Message-State: AOJu0YwtdjFgRcLdL9iKkkfxzxheGZ1ktGNqXYTBohyYgqbbaj1TWY/7
	PPTs4PKjwsoGxZdcJBQtwQpoww==
X-Google-Smtp-Source: AGHT+IFvQkMHaxRZA5Zs8mkotuWDtp+T3hyCKoTiMu/ivavbVlHMH2icSqyklYImwQNURYB9+KWiSw==
X-Received: by 2002:a05:600c:4311:b0:40c:2788:2903 with SMTP id p17-20020a05600c431100b0040c27882903mr5823244wme.125.1702638432281;
        Fri, 15 Dec 2023 03:07:12 -0800 (PST)
Received: from localhost (clnet-p106-198.ikbnet.co.at. [83.175.106.198])
        by smtp.gmail.com with UTF8SMTPSA id p8-20020a05600c358800b0040b40468c98sm30050771wmq.10.2023.12.15.03.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 03:07:12 -0800 (PST)
From: David Gstir <david@sigma-star.at>
To: Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <jejb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Gstir <david@sigma-star.at>,
	Shawn Guo <shawnguo@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	David Howells <dhowells@redhat.com>,
	Li Yang <leoyang.li@nxp.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 2/6] KEYS: trusted: improve scalability of trust source config
Date: Fri, 15 Dec 2023 12:06:29 +0100
Message-ID: <20231215110639.45522-3-david@sigma-star.at>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215110639.45522-1-david@sigma-star.at>
References: <20231215110639.45522-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking if at least one valid trust source is selected does not scale
and becomes hard to read. This improves this in preparation for the DCP
trust source.

Signed-off-by: David Gstir <david@sigma-star.at>
---
 security/keys/trusted-keys/Kconfig | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
index dbfdd8536468..553dc117f385 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -1,3 +1,6 @@
+config HAVE_TRUSTED_KEYS
+	bool
+
 config TRUSTED_KEYS_TPM
 	bool "TPM-based trusted keys"
 	depends on TCG_TPM >= TRUSTED_KEYS
@@ -9,6 +12,7 @@ config TRUSTED_KEYS_TPM
 	select ASN1_ENCODER
 	select OID_REGISTRY
 	select ASN1
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Platform Module (TPM) as trusted key
 	  backend. Trusted keys are random number symmetric keys,
@@ -20,6 +24,7 @@ config TRUSTED_KEYS_TEE
 	bool "TEE-based trusted keys"
 	depends on TEE >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Execution Environment (TEE) as trusted
 	  key backend.
@@ -29,10 +34,11 @@ config TRUSTED_KEYS_CAAM
 	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
 	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
 	default y
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of NXP's Cryptographic Accelerator and Assurance Module
 	  (CAAM) as trusted key backend.
 
-if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE && !TRUSTED_KEYS_CAAM
-comment "No trust source selected!"
+if !HAVE_TRUSTED_KEYS
+	comment "No trust source selected!"
 endif
-- 
2.35.3


