Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5298C799A63
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbjIISUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbjIISUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:20:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6F210F3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:19:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe4f3b5f25so8896865e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694283590; x=1694888390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GpwmshN/SnkxoMv0hgadPL0UXh7rR+Fy3DtPmnciQb0=;
        b=VPa5MSphjh++SdAtit7iu3Awzeqd/iCCJHCeF0aanPN2vJJ571CXfF2YjBgKtJrZIj
         uvMaZwguc5dE3WO6hptDKJOo/rpXsrmNFRUbkTSgdwQnEmYLYb+VssNumtfOIdGUFSTN
         gpqjDAkVZ+V7YzdZFp6z54zya8cYM5vm3C+8GNzdLVLXOoVH9nDhiH3GvSxZ62fJRufs
         rYK7GQJWZ/5Bq0PPCLBlUlmJuctEPMbnHyuMrKNjAYfhmNaTn96CBzPko5ylbmYtsLNa
         lBUBTtHMWzA1VjftzDpjHA2fA8KQmgi+x13nOaVa2uQP968cn2t+1AVKvhXmQI2oSwlW
         WF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694283590; x=1694888390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpwmshN/SnkxoMv0hgadPL0UXh7rR+Fy3DtPmnciQb0=;
        b=YDSw6kIcEWHMd7HPVmH+dprPxRXrTNFKeRxaQ8nxA38UF3nSpZ/7Nu5eoxaVdUU9Ye
         B2qk35+OimQfncBBMPq99wzND2gC12WlDGNo1hQNCw0ZCfq0uUQ1Z6RucmssgEP+k6Er
         4AHUPB6NgvsnDLcTitP12b7EhlVabr2IvslwIG+vDWquqdtMPJ5jp2rjfrt4OuAjq6bt
         Qngo7VFr9Z0zE/fcRnvXdRlO2N3JFcU/g5xo5GaRWlIfMvMX8mf7zt1WpQBypCG9w/bN
         BJiVIMqSd2CctnPJ+O/ORx6qFFphfr4x6lDXZmE8KagaN/UK/RVao6fYOktagE3CPLsO
         U9ug==
X-Gm-Message-State: AOJu0YzJvCivLSZ8jGns5B4jsFJ8OI8kyYE85rDj6WoDuJFhu7jZCHty
        LdYMtgWhXMlN2BKXKTjZ2Fk=
X-Google-Smtp-Source: AGHT+IHLt3smwCNceCgJThJzA35FlMq7WPqfvXc8OO+RfHKvxUVXmcgCPYlMvVJBJCWColdkWAkbzQ==
X-Received: by 2002:a05:600c:1d0a:b0:401:c6a2:3cd5 with SMTP id l10-20020a05600c1d0a00b00401c6a23cd5mr4916064wms.2.1694283589687;
        Sat, 09 Sep 2023 11:19:49 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id l10-20020a1c790a000000b003fed70fb09dsm5232607wme.26.2023.09.09.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:19:49 -0700 (PDT)
Date:   Sat, 9 Sep 2023 20:19:47 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: rtl8192e: Use standard function in
 rtllib_rx_check_duplicate()
Message-ID: <c636aadd4cf4898c57c348a1d789790c5a459749.1694282907.git.philipp.g.hortmann@gmail.com>
References: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694282907.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use standard function ieee80211_is_beacon() to avoid proprietary code and
to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 89c8d66765fe..80eee43ee444 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -904,11 +904,8 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 {
 	struct rtllib_hdr_4addr *hdr = (struct rtllib_hdr_4addr *)skb->data;
 	u16 fc, sc;
-	u8 frag, type, stype;
+	u8 frag;
 
-	fc = le16_to_cpu(hdr->frame_ctl);
-	type = WLAN_FC_GET_TYPE(fc);
-	stype = WLAN_FC_GET_STYPE(fc);
 	sc = le16_to_cpu(hdr->seq_ctl);
 	frag = WLAN_GET_SEQ_FRAG(sc);
 
@@ -916,8 +913,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 		!ieee->current_network.qos_data.active ||
 		!IsDataFrame(skb->data) ||
 		IsLegacyDataFrame(skb->data)) {
-		if (!((type == RTLLIB_FTYPE_MGMT) &&
-		      (stype == RTLLIB_STYPE_BEACON))) {
+		if (!ieee80211_is_beacon(hdr->frame_ctl)) {
 			if (is_duplicate_packet(ieee, hdr))
 				return -1;
 		}
-- 
2.41.0

