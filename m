Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5048767CF2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjG2Hxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjG2Hxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:53:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54BE4227
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:53:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bd67facffso77496066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690617198; x=1691221998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z67sNb2ca9lHFDIHurmdit1dilARScJ78IbTHBwj2o=;
        b=JoAMObnuHO/2LNJ6xIuJ89HH9EW+jUz5zpp1GKfmrK4Wsp2Xk1yJq9dRyyYVjMjHW4
         /U6QqsFzDGsjuo9pbb2+dQXHhDLcRbEigBe6tcTmYN++TrM6t0FP8ZlhKOTfl43YoMvf
         0Rv+hthKNOdIanzQh2EOZ/pxGJjdKN/7mE0G/7P3vg0yRJ/g2Scp+PK6E4+zMub5WAyZ
         iJY6qJXRdNHoYXf14Hz73LKAEYqVeToTGICm7wf65oAIzeLnrzuxO8yUV9r0t1NZ40jx
         o5a6v4pNOz/pIjs584ukuUk0BDQXjnAAJah2VF+ID2Ff89SAOY6Kehy/2hjgeG3LW01y
         ny4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690617198; x=1691221998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Z67sNb2ca9lHFDIHurmdit1dilARScJ78IbTHBwj2o=;
        b=SzYsg9jA+A/SfLsaL/8wAvoAicCHh4YLO69gkweUCaK4hBUx5kGjx34NfLXK9NU7s5
         fG/2XtqmPnokcerx507DMLObgfwKI8bXde7GpTCKNDYiMxXkCNKOPA+ypKwgIyW3G8Gv
         N5sHI9LynYqDc3J40cA3l9lv5Bowm+rbafm2UtdfYfbFGU1ZgOPK5wqkijwdt5EqoxCQ
         YP8OUjxe7c6u7cYla+PY6+jlG6wpu9jj7q5wncioQBZO0q4GCziNG3THS6GZ2DCTA9Vp
         CRpRKRlyZwWtCkocxNgxDMMJ0WFqqTIYZUsCWsfgA0XJpPEuDRJNsjEEvmDFc/OrLdsL
         7Z3g==
X-Gm-Message-State: ABy/qLY4DFl2BdPmpcm1nRWYvpeUDsgGTd3CfejGd9bfohTQT6TdVIFd
        StToz3w3LC7Qf9i/9XYqH0cpy54/2lA=
X-Google-Smtp-Source: APBJJlEHiNukjkWDySoFY2Jcu0Co64zuCrz4VCeELVb5MMsnneo1ivRg9/tHI0Ut/PR8xhHi1PG4og==
X-Received: by 2002:a17:906:64c9:b0:994:33b2:c32d with SMTP id p9-20020a17090664c900b0099433b2c32dmr1197040ejn.5.1690617198132;
        Sat, 29 Jul 2023 00:53:18 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id a26-20020a17090640da00b009829dc0f2a0sm2992359ejk.111.2023.07.29.00.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 00:53:17 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:53:14 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] staging: rtl8192e: Remove unused variable is_mesh from
 rtllib_send_probe
Message-ID: <5b1f4b9d8f81790c151adc7f9b6611f0b5cd94a5.1690615475.git.philipp.g.hortmann@gmail.com>
References: <cover.1690615475.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690615475.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtllib_send_probe() has unused parameter is_mesh. Remove dead
code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 584371f0ce57..06b872c1ad68 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -449,7 +449,7 @@ void rtllib_DisableIntelPromiscuousMode(struct net_device *dev,
 }
 EXPORT_SYMBOL(rtllib_DisableIntelPromiscuousMode);
 
-static void rtllib_send_probe(struct rtllib_device *ieee, u8 is_mesh)
+static void rtllib_send_probe(struct rtllib_device *ieee)
 {
 	struct sk_buff *skb;
 
@@ -464,8 +464,8 @@ static void rtllib_send_probe_requests(struct rtllib_device *ieee, u8 is_mesh)
 {
 	if (ieee->active_scan && (ieee->softmac_features &
 	    IEEE_SOFTMAC_PROBERQ)) {
-		rtllib_send_probe(ieee, 0);
-		rtllib_send_probe(ieee, 0);
+		rtllib_send_probe(ieee);
+		rtllib_send_probe(ieee);
 	}
 }
 
-- 
2.41.0

