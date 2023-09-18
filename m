Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046887A5328
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjIRTf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjIRTf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:35:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8400A8F;
        Mon, 18 Sep 2023 12:35:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf7423ef3eso35697885ad.3;
        Mon, 18 Sep 2023 12:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695065751; x=1695670551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NVaQmA2LhT7dn8cne4eMfEhfPLLr6K6HA82d5u2PJzw=;
        b=jY/kNih26N0M/imLrXvEGvz5aoQl9b0CkrGejo0/xd5WuK8Jr/vDA8Zwa8wp3ETvFG
         k5PwLNlY+ggA3wzfrK+qp7j2hYEuc2fQdUGBUeyarKOtGHa57bnkNA15uVfXxmPHqCU4
         pyklZoJAk4GDCZOIUjuVk9ihN3vMI8U226gslNqvXY2K25OhYq2xVTDFA4zKFW34P1ES
         tzpqdt2cQyBfbiHuBCdL36LJsR92ltRxWNOG6hjs4FNlnuTDb6b5AgAur0S294FkrAM8
         37LaTt0kskU0b/KLqQdLsPkjKfgALbAYCMUM6+YfvYCvZewWlQz7Ye3DuPCzr5O7Hkqc
         j1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695065751; x=1695670551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVaQmA2LhT7dn8cne4eMfEhfPLLr6K6HA82d5u2PJzw=;
        b=iH2P5KjyczOm9YDtBYiWXVFPpCUuTUQg7QwYUDZdFGPEdAwZRjIPq7N4ehq+hnrU7I
         qqPYSlqqHwPhAtIPaJzmoZUfInQqgo9aadCYRe3BPHy7FNYjAbKCjbTFlFwagxEt/OjZ
         bcgAn60sm8N3MBjFciz1IsOegyLkzeWcaceGuIi75AzepVeskF/FByZRvmfFVx1AGWRw
         JP04+zZ7sBXtraPbZ5llIJsVk4J9a44mwuSLb+mfQ8DqipQumK9VNCo/3IIOidLAJZno
         9EvAluvRpV0qKZmRERSYKoN98Ulj/GrxG0IsNFnj+Ak6ZTJ0D2tUdKUzH7Rc5s3MOFU0
         ap6g==
X-Gm-Message-State: AOJu0YxEtfBFArMV2Kxyi6g8AVPB5Y4u605xseq/L4fnMuKb3WLrLfFT
        E7vRSgABWI/QF6iaTXcvh4EUDEE0ppJKYdgd
X-Google-Smtp-Source: AGHT+IFAQ8y6vwskWBz+ZyVbgackyibWf6YMx1p2aw0coDBfIZWQGAKolBLnHAdbUrp0ZedKdV1Edg==
X-Received: by 2002:a17:903:24e:b0:1c4:abc:b85a with SMTP id j14-20020a170903024e00b001c40abcb85amr9799862plh.9.1695065750965;
        Mon, 18 Sep 2023 12:35:50 -0700 (PDT)
Received: from swarup-virtual-machine.localdomain ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b001bde65894c8sm8602032plh.268.2023.09.18.12.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:35:50 -0700 (PDT)
From:   Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Subject: [PATCH] usb: fix kernel-doc warning
Date:   Tue, 19 Sep 2023 01:05:05 +0530
Message-Id: <20230918193505.7046-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings discovered in usb driver.
Fixes this warning:
warning: Function parameter or member 'gfladj_refclk_lpm_sel'
         not described in 'dwc3'

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
---
 drivers/usb/dwc3/core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a69ac67d89fe..078edfe0f88e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1106,6 +1106,8 @@ struct dwc3_scratchpad_array {
  *			instances in park mode.
  * @parkmode_disable_hs_quirk: set if we need to disable all HishSpeed
  *			instances in park mode.
+ * @gfladj_refclk_lpm_sel: set if we need to enable reference clock for LPM in
+ *                         Global Frame Length Adjustment register
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  *	0	- -6dB de-emphasis
-- 
2.34.1

