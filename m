Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459047F095C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjKSWPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjKSWPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:15:39 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6837C186
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c6f0530929so95634966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432123; x=1701036923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h3E7eDhKdrSTOA+gUQqkBTD8PxWTKFR6HSert4WMZEI=;
        b=Atfzavi3TCIWYBrHuz2mmRiKxPIeVKEG3LeqPF2ruMGhCAmUY0D+CgHn93n6CDHKYO
         MznJWFfbYayKjciU9rZSPCggX+tgPRMEH/14RH+OW3zDd2LTYEIsWlbPls/HR/RNCW3P
         G8GTu8Brj/G/i+yy4Rmpws1d4Q8zRSIwKtcyyboQwTiU8nD3T+/gbd1VmRkDQBXokVDQ
         hN62UpqmWbexTe1zl+vUK0vCGK7ci34TQv3p1S3IrW7jHrWiRZOf8XqjS92mKu5Lxu6J
         3Kp4h3tHqgOFJ4iBL8zOZ7JtEGkCLe/eVOiwQDsX7blf54BVPYQhzkje6RFnOPdbYYPj
         ywJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432123; x=1701036923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3E7eDhKdrSTOA+gUQqkBTD8PxWTKFR6HSert4WMZEI=;
        b=MUIamAp2hFOo3W/F4Oc4WfntZTO7okRTA8roBSNnV6Lp2uQVXFdzQsJZQ7RJUjaaxC
         89PRB+Az/UBMotcZkwfE/MuJmW+I1GAd7ec245F6aZtePdjn0t8boqPKwqVrCKpbNoRt
         vvTNtqulatJyYpc2XaSDhAahTSIwfip79QmsvcZA57KiQE1QLuvDR6+mV2W4bemKqQWu
         bWZvolsXX1/Yz42/WtM+ct7Mc4jy7LgQdldP702IVj+b7M2IJlYHWsKG+eiNi3uR8mVT
         BwckKXofTFtg9sRfFnvi5TPrz5AcLKAGdr61TYN5FLlfkaqh05Bcr3mcXeQeHhgF+PdA
         OA1g==
X-Gm-Message-State: AOJu0Yxrt9++nyLEu890ZwnomKRxYtH9QK9ny/7MTSywbP+uvjfQziW3
        StzyD/qLyQnuw4l83fv+JdI=
X-Google-Smtp-Source: AGHT+IF8WM/tjO7bGMlVgk4LjdiUb2HDfQgKkQzIG/MIlrpTrVsN6ZgqZqzhMEzDCcBfh8JzZwjtSw==
X-Received: by 2002:a17:906:10cf:b0:9cb:b737:e469 with SMTP id v15-20020a17090610cf00b009cbb737e469mr3933899ejv.4.1700432123425;
        Sun, 19 Nov 2023 14:15:23 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906354800b0099ddc81903asm3251330eja.221.2023.11.19.14.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:15:23 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:15:21 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] staging: rtl8192e: Remove unused variable
 dot11d_info->state
Message-ID: <2f1d4851a7a370c5ef367568c2b098bb9fbf0ce7.1700431464.git.philipp.g.hortmann@gmail.com>
References: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable dot11d_info->state. Remove unused enum
dot11d_state as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 1 -
 drivers/staging/rtl8192e/dot11d.h | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index f0241982c7a8..08cf95d26911 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -18,7 +18,6 @@ void dot11d_init(struct rtllib_device *ieee)
 {
 	struct rt_dot11d_info *dot11d_info = GET_DOT11D_INFO(ieee);
 
-	dot11d_info->state = DOT11D_STATE_NONE;
 	dot11d_info->country_len = 0;
 	memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
 	memset(dot11d_info->max_tx_power_list, 0xFF, MAX_CHANNEL_NUMBER + 1);
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index d3da4af4a16b..c7d35ec86aae 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -16,12 +16,6 @@ struct chnl_txpow_triple {
 	u8  max_tx_power;
 };
 
-enum dot11d_state {
-	DOT11D_STATE_NONE = 0,
-	DOT11D_STATE_LEARNED,
-	DOT11D_STATE_DONE,
-};
-
 /**
  * struct rt_dot11d_info * @country_len: value greater than 0 if
  *		  @country_buffer contains valid country information element.
@@ -40,8 +34,6 @@ struct rt_dot11d_info {
 
 	u8  channel_map[MAX_CHANNEL_NUMBER + 1];
 	u8  max_tx_power_list[MAX_CHANNEL_NUMBER + 1];
-
-	enum dot11d_state state;
 };
 
 #define GET_DOT11D_INFO(__ieee_dev)			\
-- 
2.42.0

