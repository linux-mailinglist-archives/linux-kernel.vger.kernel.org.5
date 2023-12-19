Return-Path: <linux-kernel+bounces-5549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 903CB818C17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082A91F25817
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9340A208B7;
	Tue, 19 Dec 2023 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fgaOUzZI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A79200DB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ba084395d9so3290489b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703002985; x=1703607785; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lewFzn9SrDI+/fbG+W+6O1u8PWoajh2/Xolpgh8p6II=;
        b=fgaOUzZI3n/FSz8HwLY6aATLHkLwQ7cF0QIRBE1/07iRlQHbYoW7bxH9wh6fQy74IJ
         8Z0vEcGX3kHSm4czJ3c4hS/Tuoak0uueicNlqEto+PbOdQoGKvSegyj0IsOgZY713pQA
         aftvcLJmzvsrRyBe8w0OzbCiHGEIkgqRq1VlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002985; x=1703607785;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lewFzn9SrDI+/fbG+W+6O1u8PWoajh2/Xolpgh8p6II=;
        b=R+usYR6u5vKydAv5Lr4mSHWHIEEpCUIHVgqODUa0Vs146pAbJwQcJuNxhvDhwmKTh4
         tMVX3v2zo8Z3KOVETJWzYz5NZqMCGJBnmQJn0orAov7jV2x0+ZwasBUYGrUMeZxefoJ1
         yuW3hp11VV59YYJ3+kZSF9nIJ+kqyy4hN7UPzoI00eo32NX0Cm+RWkVeznOwyThJAO5b
         p0L5ShaMSKG+y28hi7uxxpD2L8dAqgmu4kZy65B13EgZZl3Tbye3h3BACgrD3kae3843
         ZIBAZhN5TzLSmYHKruryWLEcRdSsTt/deQLvu+Mcoe3TBFUjbzk2rRKqMsJ+qDs1+RGf
         /DnQ==
X-Gm-Message-State: AOJu0Yy/yDTRCC7kuKE4gm9erFi5ulVcCZvvU7x2NZOK2KLeEgtAFDsn
	qbTGPosoO3A33iXrAMMDUgg5yVBe0r5ALru5Ly6RrQ==
X-Google-Smtp-Source: AGHT+IEQZ3cByE9AALVT8PBlVU2YFmcnCMtSpN0KVWfSxLTtkh09nO4cE9C5U5BZfhz+FN2po+A7RQ==
X-Received: by 2002:a05:6359:6f15:b0:173:24:b27c with SMTP id tk21-20020a0563596f1500b001730024b27cmr360852rwb.32.1703002985239;
        Tue, 19 Dec 2023 08:23:05 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id o15-20020ac8698f000000b0042388bce404sm10363166qtq.57.2023.12.19.08.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:23:04 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	alcooperx@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: f.fainelli@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	Kamal Dasu <kdasu@broadcom.com>
Subject: [PATCH v5 2/2] mmc: add new sdhci reset sequence for brcm 74165b0
Date: Tue, 19 Dec 2023 11:22:36 -0500
Message-Id: <20231219162236.36609-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231219162236.36609-1-kamal.dasu@broadcom.com>
References: <20231219162236.36609-1-kamal.dasu@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000003fcdc060cdf4896"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--00000000000003fcdc060cdf4896

From: Kamal Dasu <kdasu@broadcom.com>

74165b0 shall use a new sdio controller core version which
requires a different reset sequence. For core reset we use
sdhci_reset. For CMD and/or DATA reset added a new function
to also enable SDHCI clocks SDHCI_CLOCK_CARD_EN
SDHCI_CLOCK_INT_EN along with the SDHCI_RESET_CMD and/or
SDHCI_RESET_DATA fields.

Signed-off-by: Kamal Dasu <kdasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 67 +++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index c23251bb95f3..7c5d04be93b3 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/mmc/host.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -44,8 +45,13 @@ struct brcmstb_match_priv {
 
 static inline void enable_clock_gating(struct sdhci_host *host)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	u32 reg;
 
+	if (!(priv->flags & BRCMSTB_PRIV_FLAGS_GATE_CLOCK))
+		return;
+
 	reg = sdhci_readl(host, SDHCI_VENDOR);
 	reg |= SDHCI_VENDOR_GATE_SDCLK_EN;
 	sdhci_writel(host, reg, SDHCI_VENDOR);
@@ -53,14 +59,51 @@ static inline void enable_clock_gating(struct sdhci_host *host)
 
 static void brcmstb_reset(struct sdhci_host *host, u8 mask)
 {
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
-
 	sdhci_and_cqhci_reset(host, mask);
 
 	/* Reset will clear this, so re-enable it */
-	if (priv->flags & BRCMSTB_PRIV_FLAGS_GATE_CLOCK)
-		enable_clock_gating(host);
+	enable_clock_gating(host);
+}
+
+static void brcmstb_sdhci_reset_cmd_data(struct sdhci_host *host, u8 mask)
+{
+	int ret;
+	u32 reg;
+	u32 new_mask = (mask &  (SDHCI_RESET_CMD | SDHCI_RESET_DATA)) << 24;
+
+	/*
+	 * SDHCI_CLOCK_CONTROL register CARD_EN and CLOCK_INT_EN bits shall
+	 * be set along with SOFTWARE_RESET register RESET_CMD or RESET_DATA
+	 * bits, hence access SDHCI_CLOCK_CONTROL register as 32-bit register
+	 */
+	new_mask |= SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN;
+	reg = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
+	sdhci_writel(host, reg | new_mask, SDHCI_CLOCK_CONTROL);
+
+	reg = sdhci_readb(host, SDHCI_SOFTWARE_RESET);
+	ret = readb_poll_timeout(host->ioaddr + SDHCI_SOFTWARE_RESET,
+				 reg, reg & mask, 10, 10000);
+
+	if (ret) {
+		pr_err("%s: Reset 0x%x never completed.\n",
+		       mmc_hostname(host->mmc), (int)mask);
+		sdhci_err_stats_inc(host, CTRL_TIMEOUT);
+		sdhci_dumpregs(host);
+	}
+}
+
+static void brcmstb_reset_74165b0(struct sdhci_host *host, u8 mask)
+{
+	/* take care of RESET_ALL as usual */
+	if (mask & SDHCI_RESET_ALL)
+		sdhci_and_cqhci_reset(host, SDHCI_RESET_ALL);
+
+	/* cmd and/or data treated differently on this core */
+	if (mask & (SDHCI_RESET_CMD | SDHCI_RESET_DATA))
+		brcmstb_sdhci_reset_cmd_data(host, mask);
+
+	/* Reset will clear this, so re-enable it */
+	enable_clock_gating(host);
 }
 
 static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -162,6 +205,13 @@ static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
 	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
 };
 
+static struct sdhci_ops sdhci_brcmstb_ops_74165b0 = {
+	.set_clock = sdhci_brcmstb_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = brcmstb_reset_74165b0,
+	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
+};
+
 static struct brcmstb_match_priv match_priv_7425 = {
 	.flags = BRCMSTB_MATCH_FLAGS_NO_64BIT |
 	BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
@@ -179,10 +229,17 @@ static const struct brcmstb_match_priv match_priv_7216 = {
 	.ops = &sdhci_brcmstb_ops_7216,
 };
 
+static struct brcmstb_match_priv match_priv_74165b0 = {
+	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
+	.hs400es = sdhci_brcmstb_hs400es,
+	.ops = &sdhci_brcmstb_ops_74165b0,
+};
+
 static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
+	{ .compatible = "brcm,bcm74165b0-sdhci", .data = &match_priv_74165b0 },
 	{},
 };
 
-- 
2.17.1


--00000000000003fcdc060cdf4896
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DxuNuBlySpn/GYqPcDcRZd8EENWqnZrjtjHMk0j7ZfrPGXq8sQkbG3OX+DOwSaefPRq1pLGWBZaZ
YuUo5O7CNHo7h7Hc9GgjiW+6X9BjKAzSaDy8jwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdrYW1hbC5kYXN1QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUcRYSWvAVyA3hgTrQ2c4AFquBsG0wDQYJ
KoZIhvcNAQELBQADggEBAIKB2IOweF2sIYGBZTDm+Hwmhga+sjekM167Sk/KwxxvQFwZYP6i0SnR
7aR59vbfVQVaAiZH/a+35EYxP/sXaIM4+E3bFykBuXwcGEnYyEn6MceiOCkjkWQq1Co2JyOdNvkP
nAxyPoWlsJtr+N/MF1EYKGpYMdPM7S2T/gujjO9N56BCGu9yJElszWcXHmBl5IsaQqMS36vhsV0b
NxffjNkeAdgfN/SS9S9Rj4WXD7pF1M0Xq8gPLCLyXrx1i2KkYOYJsj0PWlC6VRg6E1xXkYDte0VL
fAAG4QsETU27E1HBNQyp5zF1PoPCPvq3EnWQnbLgYk+Jz2iwIUwiqwr/bDgxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw89WX2Pp7ue922QVkwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIE3FESb/ip1KsDp6MGq3fr+4U1AqHrWUE+Td9Pw2
2OQhMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIxOTE2MjMw
NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQAaFxqmMuBxwqpbOjqgPTdel73Jyp2UC7QpysIUhtGSAaa/oVjBkh8Mt6G8
midG2QuT+OINL6h5d5kQCu0IuuUh9Pcekp5m2F8Lr8OkoWOySjWl1/u/rdoA31QSxVlcAXX7QNfx
XxCG1zoMPviMLH1iKDKsjlvM/QPgLy63EGOLJt4HQ7zG8IoHpZD21X91hYa/TlPb5jHqkPH6+zNP
1OveN5bXVY0qN8CG5dKOgo79xImVQFVoAMotyz0tVXNkfa9DZwMUNKhUChQs1Zc6eIYhV1oi2j9H
3sW6h9keyrF+SrQXNoNy/n5o6Yqa3RJiEWv8tZZrse9W+0Ucwl2/LNNf
--00000000000003fcdc060cdf4896--

