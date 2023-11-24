Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8F47F8581
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbjKXVbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjKXVbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:31:06 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC771BE7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:31:11 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c99593d13aso314961fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700861470; x=1701466270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lucCRVdFyECgtyRqDncojEzhqXxZuxdPkU1gxZh8Hdk=;
        b=LOnPrhxf97KA8njuQyb4D3o7Jj3FvjANsXmW/2m5EukFafvtxrAzbNOiv+wD01gUJT
         O/hBR6zQqe4h2VKow35CtqRx7sRVrHd0aKGUxl+39XJQfSqh9MZtsv9c2MeRanjs+i1M
         h7SWL2inVvgnUMXLMlkBCXhNKtoBTQjYN5uUtj+TxMMsJWNjqVfGjAEN0eo9AQ4BSr+b
         6F/sXqIE3GZGQ7URfwcsLypntKjtyOAk7fqEV6Vfr2WJoNmaOeUMs8oss6wBG2OMDHPd
         poUCn96ehf31EqbCyhQyNxgUJgpfh9TToNws/Rk0KcBOufH6Clp3A91Aba7Ie9QNGhS/
         n1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861470; x=1701466270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lucCRVdFyECgtyRqDncojEzhqXxZuxdPkU1gxZh8Hdk=;
        b=iyQ2ZgYUAdwO38MchEkGUp8QEf6Eodn3nXYduwtXedA9rt8NrTJt/lca4ul+r77HGO
         j767YS3G3he5e0DXs6iP+MhDzFzoLBI13OWUR0zzMUCoBrJd9OcDccm1T9gTVWmOjQS+
         15fnjlSEfO4FmZJ/EUGK6RVP9h3ygrLo+eAdD6qKvw2KeT85NK2vSBaCpA2eJO3apHeX
         MxgsKioNShV8PTBIufwWKOIao67GGP+pEjlHOu5ILPr0lJPAedxNWc9MOHZ/B/HMTuqu
         6vGYSwGQmSYcN5tXeDGRsoJz4yM6t+Uy+iFZpExuiSriWbybIU8Uf47bs0E3HwWKEYGb
         lwFw==
X-Gm-Message-State: AOJu0YxCk43J9UTrT6SklziMB4hguOe3LN1Qo6lLJlvAtXmRQMEXr4cm
        u7qi4pzZo1wtd5p2pUz2tQ0=
X-Google-Smtp-Source: AGHT+IEGC+FkWool5xrxMKIxPHFJxPbScb7nXCa1f+4jiux3ltzhvrqQmA0uEENYkpc9LpAwkhCweQ==
X-Received: by 2002:a2e:150e:0:b0:2c8:3406:6641 with SMTP id s14-20020a2e150e000000b002c834066641mr2393867ljd.1.1700861469951;
        Fri, 24 Nov 2023 13:31:09 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id si12-20020a170906cecc00b009fca9f39e98sm2538605ejb.26.2023.11.24.13.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:31:09 -0800 (PST)
Date:   Fri, 24 Nov 2023 22:31:08 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: rtl8192e: Remove unused function
 rtllib_get_beacon_()
Message-ID: <ed825d5fb1946530c310afca1d3f27e46da35f06.1700860759.git.philipp.g.hortmann@gmail.com>
References: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtllib_get_beacon_().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 4e33a453f86e..8c7ad56d4402 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2130,25 +2130,6 @@ static void rtllib_associate_retry_wq(void *data)
 	mutex_unlock(&ieee->wx_mutex);
 }
 
-static struct sk_buff *rtllib_get_beacon_(struct rtllib_device *ieee)
-{
-	static const u8 broadcast_addr[] = {
-		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
-	};
-	struct sk_buff *skb;
-	struct rtllib_probe_response *b;
-
-	skb = rtllib_probe_resp(ieee, broadcast_addr);
-
-	if (!skb)
-		return NULL;
-
-	b = (struct rtllib_probe_response *)skb->data;
-	b->header.frame_control = cpu_to_le16(IEEE80211_STYPE_BEACON);
-
-	return skb;
-}
-
 void rtllib_softmac_stop_protocol(struct rtllib_device *ieee)
 {
 	rtllib_stop_scan_syncro(ieee);
-- 
2.42.0

