Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0442A811A18
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379162AbjLMQwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379150AbjLMQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:52:03 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F411F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:07 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1b6524f24fso224797366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486326; x=1703091126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V24N0myd3yrAHQ5oXdaUpmt08W779GgLxB9a3K2nYC4=;
        b=d2nKf6dS5cUG0Y036FOb4keqBk+nOAgSgRWxLQp9w9zZ2k8S+KZGjOFotfbc6Dyowi
         OcEbRLqtXDdIqBrtQH4uLFezolRulKsFH2CiWV0HdEvTrziDiSFZgs8LeGWMm0wQZ4h6
         AyBx56cKhtl9l2KzpF5p7EPvhlYaD2y0jv3jfnwG464LNXgo3gfS1zowgYMrzQUnLdSv
         IXw2WbEA16enI1CY1uv8LozqS7Agj8shLkaeCA3QUv2VnIugDMTIk8P33dTIfMrgy3Dd
         iWdCm014Hhr2L0NaSQfjPSqZvqst8nuhM+hZFsJEzn6m7MYttk23SSQMViaGtHZifq6l
         UZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486326; x=1703091126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V24N0myd3yrAHQ5oXdaUpmt08W779GgLxB9a3K2nYC4=;
        b=NaTGfa8G6YsftBh9lVkQevvyRKlXbltcTcfPXOHD0hhdsm+iEVJJNVHHJmCuKE+Wfj
         d23lltncdIEWFVyUgIcHDpGzvzQvLnLw0WqGfQjy9+R/twpPFB9SRw/5tdTZttx3vb3a
         HSLdXx+cmiQQv9/a6yxCQRD5FcFeioG4l6Ouup6r8tluWa+IzZRqMuEUR2wdyAzt8Tbu
         UZ6q+aX7mMtKbTCNVrbj5WnIn/rfOTjR1U5IMB4v/xBvMtJJe6bdHxDk21dUCoq1WpB+
         0N2esg3yknuGOqAU5ty69WucEPTEbwRdnKkOvJw1nIc0BY8a3GsRvwYkHoJyF0WWf11A
         1eGg==
X-Gm-Message-State: AOJu0Yzt7Ym5Ocw/v6eycOWG5WSAEgPbHrm2fon9v0JroCeClMJB37k3
        52LGx4a5j/xsUFOIn48nPYE=
X-Google-Smtp-Source: AGHT+IGRBQ0A+eaO9nkYVYRpK2dgpNPQhl+tc8bFjCGMjWcg5m3VG4en0D8a54eiU15YIN64PYsPhg==
X-Received: by 2002:a17:907:c705:b0:9cf:7c60:47b9 with SMTP id ty5-20020a170907c70500b009cf7c6047b9mr8673247ejc.1.1702486326023;
        Wed, 13 Dec 2023 08:52:06 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id tb19-20020a1709078b9300b00a1cd30d06d1sm8245382ejc.14.2023.12.13.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:52:05 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:52:04 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] staging: rtl8192e: Remove constant variable
 peer_mimo_ps
Message-ID: <7b2ccccde769133db9365c693fdd0c42e9dc75f9.1702406712.git.philipp.g.hortmann@gmail.com>
References: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MimoPwrSave is set to 3 and not changed. peer_mimo_ps is set to
MimoPwrSave and not changed. All evaluations of peer_mimo_ps with 0 will
have a constant result and can be removed.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 5 +----
 drivers/staging/rtl8192e/rtl819x_HT.h          | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c      | 6 +-----
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e6d51abd0d01..763ecaad6652 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1753,10 +1753,7 @@ void rtl92e_update_ratr_table(struct net_device *dev)
 		ratr_value &= 0x00000FF7;
 		break;
 	case WIRELESS_MODE_N_24G:
-		if (ieee->ht_info->peer_mimo_ps == 0)
-			ratr_value &= 0x0007F007;
-		else
-			ratr_value &= 0x000FF007;
+		ratr_value &= 0x000FF007;
 		break;
 	default:
 		break;
diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index eb2cfeab97d6..43472b2250c2 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -112,7 +112,6 @@ struct rt_hi_throughput {
 	u8 forced_mpdu_density;
 	u8 forced_short_gi;
 	u8 current_op_mode;
-	u8 peer_mimo_ps;
 	enum ht_extchnl_offset CurSTAExtChnlOffset;
 	u8 cur_tx_bw40mhz;
 	u8 sw_bw_in_progress;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 71d5b6f32869..d424b7729a01 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -507,11 +507,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 
 	HTFilterMCSRate(ieee, pPeerHTCap->MCS, ieee->dot11ht_oper_rate_set);
 
-	ht_info->peer_mimo_ps = pPeerHTCap->MimoPwrSave;
-	if (ht_info->peer_mimo_ps == MIMO_PS_STATIC)
-		pMcsFilter = MCS_FILTER_1SS;
-	else
-		pMcsFilter = MCS_FILTER_ALL;
+	pMcsFilter = MCS_FILTER_ALL;
 	ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee,
 						       ieee->dot11ht_oper_rate_set,
 						       pMcsFilter);
-- 
2.43.0

