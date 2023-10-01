Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEF47B47AC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjJANpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjJANpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:45:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0B7E5
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:45:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5334f8a40e2so4097124a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167901; x=1696772701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsEg8H7d6fgrWJRtj3vP63E33mgGkOeEm3YkuheUnaU=;
        b=J5zAMPBtHmhAeR7pBlKR9uu7wUSVLCLQbicC/q2t0CWXRaGPHub785MwOweRwTu2Vr
         8WHK+pjBr8ayoKh37zbImxkmfPys775ZS9LixBgD7y6YzUb96iILITOeBHGmnFdvo/TW
         wQBjNnP43ww80SrYzSUoNcXv2kXylNWVfRHE6sZN3eCZXouF59n+j0iryd9oPA9yDVw4
         DYSULgp+9vogY3YDJO1iZFc0qmtenL38nE9FvtHevak79VxbSDYyZGx9eOl2pbXlpa2u
         BBFhMAOFGBMz/Pz8dcSQi6aUsOd+53Ya5ixlhM1ER2UUVghc6CmiazC5+grTEXuhOLjs
         4BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167901; x=1696772701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsEg8H7d6fgrWJRtj3vP63E33mgGkOeEm3YkuheUnaU=;
        b=dfLGjQzHdP4S8shwQ4sS22MZkTFlxyakyo6qwxAJJsL1Ow2pbsjVMU74NhZJWkMYks
         VZKYyE5yZ44OFSgftG1R4If/nRf88OR8ufw1X7nCmv8gtgrRlCetTfJ4x2c88+KiVmr4
         Q211pL/vbxNVe62O7PgTiu9Zo7DMNnVRqqcoLjs+NeShEdPWUVW2PslQ8qmQclzPz0Cn
         KBfmBal3jqYERW/6Z3h6QzRq72QUuw892mtrNyMdrn8PKsFw6ND3doKIMBMOAQThfl3+
         3oZZtirY6batq+G/mYHeL89ASEd/Eu/JNHPaIyBytOek3CydJKzeoPkE/kF+hjpAX6U2
         HNfA==
X-Gm-Message-State: AOJu0Yxmwr7e8v6OVSq757U1PXWQGfJ/HHF+wAr6rtRtuoYHoAouVIP7
        pee5nkBZ1py+Kzq2WCaQodI=
X-Google-Smtp-Source: AGHT+IGxP2K/34ynK04IRN9ZJtAvrHaYasGn81qD0BfShuuharbUUq9C3XyGoopLntj41nhu3xDzJA==
X-Received: by 2002:a05:6402:2792:b0:51a:4d46:4026 with SMTP id b18-20020a056402279200b0051a4d464026mr7106424ede.0.1696167901402;
        Sun, 01 Oct 2023 06:45:01 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id f5-20020aa7d845000000b005364b54a4basm4297223eds.80.2023.10.01.06.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:45:01 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:44:59 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] staging: rtl8192e: Remove unused parameter from
 _rtl92e_sta_up()
Message-ID: <105beac3b04bd73267b3e30e6b944b381dcfa8a1.1696165351.git.philipp.g.hortmann@gmail.com>
References: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused parameter is_silent_reset from _rtl92e_sta_up().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 9da858510211..94a73f9cf888 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -588,7 +588,7 @@ void rtl92e_set_wireless_mode(struct net_device *dev, u8 wireless_mode)
 	_rtl92e_refresh_support_rate(priv);
 }
 
-static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
+static int _rtl92e_sta_up(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *psc = (struct rt_pwr_save_ctrl *)
@@ -1709,7 +1709,7 @@ static void _rtl92e_cancel_deferred_work(struct r8192_priv *priv)
 
 static int _rtl92e_up(struct net_device *dev, bool is_silent_reset)
 {
-	if (_rtl92e_sta_up(dev, is_silent_reset) == -1)
+	if (_rtl92e_sta_up(dev) == -1)
 		return -1;
 	return 0;
 }
-- 
2.42.0

