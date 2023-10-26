Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02517D7C65
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343976AbjJZFoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343915AbjJZFn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:43:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBC4192
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:43:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9cc6c92d1e9so14158266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698299034; x=1698903834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5wSndwTs4wiNAVHEpPnvhlAlU5Xl5PBQkAHjBg9fFq4=;
        b=NSwEvlMBC59w/uNvoXU5LSjTSDgmsIRCMzhO7DNvtUiBF7IX7irMmVhXcm01/gYQkD
         G4RcJCAGeVSU5IW5GAMK1eXPOCMPTy5oPxT6YF7nTsrbG8DQboJzIFw0Dfw0Jriv+sug
         nOfwT4oy+3iTIqigASFZ9CLJSL5NbafXpbb86gtMuZuwMsqOChaCaOeDIlNuzBnn9Ryg
         QiHZWML175PaHlAbWqtX2zAKy0vDy9SdPBoQSNyDTQw76NHvtP3C1rpKTekbb4BwGkyh
         tNydGxXLZV2mBWYl8QhZWDUId1BZ13z5mYzzletdAIx6qxYbX2B3yvvwkaAGIoxDyczG
         QWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299034; x=1698903834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wSndwTs4wiNAVHEpPnvhlAlU5Xl5PBQkAHjBg9fFq4=;
        b=wZam6GstlyYeS1hLtI/LTrMqznBKwkAeH4WdnRAP8nBounCeE6vLL70uP31r58y7Q1
         CRpy3lFUizzvXH1hUCcytEWwV1UQkR2LeRgFH7Dck+/DT0fXHlSLGy7DlN5zXh8iDUaq
         OQwJM4Bkp8glJ4cyAKsgGq6g+SvSywdqhxC03kVavnbiVr3hhOeaAVeRyDaXjBQb5tk2
         vNbT+rgWhCz0PqpFPN6OrcRLdlpc4VPj8xxGygYWwz23jfllBTQ6cKQTa4fe6R4iUiNe
         Gfsl8EsfUcchVe1eCOM4ulU1w21ZkIaC3k2rEJxjBwk5VsVuYieSw3nWcDCVsj6FE4Ed
         cI1g==
X-Gm-Message-State: AOJu0Yxdm2/0TH2wda5LyYW20t4Row2UCXm49SwmbxjS/cGZZQumnUo4
        UQ1e7h5svvtX6+LWvnNIYUAK3IR0dmQ=
X-Google-Smtp-Source: AGHT+IEe+xOHM3zlfZ8mNcB/5o4ogMmrnmdS0Fh0YR9k8gUEIMdrwfRwVljfLqBwQFHFCiANPCFG2w==
X-Received: by 2002:a17:906:5198:b0:9be:4cf4:d62e with SMTP id y24-20020a170906519800b009be4cf4d62emr6373890ejk.5.1698299033757;
        Wed, 25 Oct 2023 22:43:53 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id do6-20020a170906c10600b009ad7fc17b2asm11101621ejc.224.2023.10.25.22.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:43:53 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:43:52 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] staging: rtl8192e: Remove HTIOTActIsDisableEDCATurbo()
Message-ID: <904ca224c6a0a1968012e131c0197a71e5b67f81.1698295861.git.philipp.g.hortmann@gmail.com>
References: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698295861.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove HTIOTActIsDisableEDCATurbo() as it always returns false which
leads to one evaluation that is always false. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 3cbadd6a0aef..e607bccc079a 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -207,12 +207,6 @@ static void HTIOTPeerDetermine(struct rtllib_device *ieee)
 	netdev_dbg(ieee->dev, "IOTPEER: %x\n", ht_info->IOTPeer);
 }
 
-static u8 HTIOTActIsDisableEDCATurbo(struct rtllib_device *ieee,
-				     u8 *PeerMacAddr)
-{
-	return false;
-}
-
 static u8 HTIOTActIsMgntUseCCK6M(struct rtllib_device *ieee,
 				 struct rtllib_network *network)
 {
@@ -681,10 +675,6 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 		HTIOTPeerDetermine(ieee);
 
 		ht_info->iot_action = 0;
-		bIOTAction = HTIOTActIsDisableEDCATurbo(ieee, pNetwork->bssid);
-		if (bIOTAction)
-			ht_info->iot_action |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
-
 		bIOTAction = HTIOTActIsMgntUseCCK6M(ieee, pNetwork);
 		if (bIOTAction)
 			ht_info->iot_action |= HT_IOT_ACT_MGNT_USE_CCK_6M;
-- 
2.42.0

