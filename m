Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4951A7870E6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbjHXNyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241300AbjHXNx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:53:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D2FA8;
        Thu, 24 Aug 2023 06:53:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so102953251fa.1;
        Thu, 24 Aug 2023 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692885230; x=1693490030;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5LYpTKXg3FZey1/Sx1CuzIbt0+XrBzCQETNfbb8Zj50=;
        b=DN73H0Au+zeKlQ/SNDV6ZPc9sqSdbcTrTVKA8EKfKm1iaxY21dA8TKMPEEgoQPsmyX
         ig615V4/j0biqjWMjKwPqgSkX/hKeLZdweth/uoPv1vxxBq32yCeyAvs7Y5D5JvPD+de
         MUCcahsaMShuJhkfkiJJfP5dWt06dHMsrADe2y0ivjjotIm7U3HK+rysIGclcNVVZPo2
         fb04lQ83XwNLhKMBbW6qZqkXFseYHFZPsN1AyKT9kTSQmeXbhvR+ADeCToIW7KQ8VYvA
         07F2q9EtxikWELTtXf9eBqroKysJaUIpkB0WoeqQBmJO+NwN+WS2IXZFn698DsRPrz1K
         Y2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692885230; x=1693490030;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LYpTKXg3FZey1/Sx1CuzIbt0+XrBzCQETNfbb8Zj50=;
        b=H86wPFmqHYlsC1y6p4aR2/tI0WEe/HkMutPr6RN8lKO8aI/c9npQSrIwYMIzGJaJld
         79Mi2WcVKG4sFN2qdQ2N1DkYqkJS7QK8FS/cSur81ZeNZPc4pVVLJvW7c3C8/SnNkWSY
         XiZg6NR3aCDkCbzkFVoSXkUXeaZuDrXvmRxJTxTUSeQJ7Rj7/cnEKJXDVE88DbDAFSeZ
         c8OfTOhrXjs20lJxNMOcE/kpieRenoxYYfveciMF/hZfOBKHwFdWITD3FPELEnV52PZu
         8upSBjKIIugyzpiF8kcuBN1oVH2kMO8bCs9I0jEJvX+qukzgImhYRxlRCDw3OO2t4tfy
         gj0g==
X-Gm-Message-State: AOJu0YwBZOvFOsJaydj0l+niHMUyigU4xoYQ9DsREfLloKD3EgvqVZBz
        cw8L9NoB1ekVZZ2OE+0Yb+wX76X0MD9kLmT4
X-Google-Smtp-Source: AGHT+IEefotIFfjeuslW/NyPnOv1al/whlGKNiU+Okhol05ME3LSn5l6OfI7GK7mwS6vyDa9APZYrw==
X-Received: by 2002:a2e:b164:0:b0:2bb:bfa5:b72c with SMTP id a4-20020a2eb164000000b002bbbfa5b72cmr10493041ljm.15.1692885229450;
        Thu, 24 Aug 2023 06:53:49 -0700 (PDT)
Received: from [192.168.20.89] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e9a8f000000b002bcdbfe36a1sm857498lji.84.2023.08.24.06.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:53:48 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
Date:   Thu, 24 Aug 2023 15:55:50 +0200
Subject: [PATCH] input: docs: pxrc: remove reference to phoenix-sim
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-pxrc-doc-v1-1-038b75a2ef05@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGVh52QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyMT3YKKomTdlPxkXcPElJSkxEQjI1ODNCWg8oKi1LTMCrBR0bG1tQA
 AEEX8WgAAAA==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=gfPdoZJ8VqVP1ME7IqsQu+o/zRkAyUXKN51ex5LYZ+Q=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBk52F/TGpSKHPMSR+AnOnRcktJokJeDTpjV6ckL
 nJMFaco50aJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZOdhfwAKCRCIgE5vWV1S
 MqnFD/0Wa8toMqQSoAU20Ebtgi6FPbWgY+nmcCod45Y0sQM9+oGlCQ0pGBeNDo2YwX3Flu6aDla
 JvnBoki8hIEWlXk0cR5rsXk9Zz4u1P0lb/3IDZjRRtZadK6HbDVnU3WzaLGwgDnNxSs3SL/eMTy
 CRZ/NtGu9QeXLhqSpqZjzkPozE1iDk5Bhx4pWyyjEbEA9uRH8kC0tOVSClcbSk0+ZlAmtrnpRgL
 b1yw5D/vAjOpJXtIBF5SYo5Any4uMzkipkWf1ac9tOtRfPEYLPmPn/yaeghuMIIDsVFpfWitxiX
 sXjl+shem38L6AwEQIBnGu0cxNHz74Of6uDHmDOXopphbs6t4kML9kXP9+3IRu6tivlwg83p3em
 qYp4PdzNQsIw42tP42d+NO9quZHP0jkBc75MDe6y1ZbrrHZ/xRbJxziOb7VSD96N9AnZ27ZJdO1
 YyVqKS3LlKp9pUR6gjJzOGyiOH/0zxgIHAHbxFUrwMt1PLOhY1TM0mruC+jyirxnwElMUIZ7egz
 IMmLNV+alFNxiLJLUHihfpPDrSIBBxJCDy2R2TuA5KMFrr/gmwjOVudXwLLHi7UoutxdNAIAHTc
 bK0Jx6x5uXoCV5LkPBSOYJdp0cmsZFRMRTKW09610TDkRKZpOmOYNqqNEf4qa9YvrKRcV6XWBZc
 TC7m10qXXPTrl7w==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference undeniably points to something unrelated nowadays.
Remove it.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/input/devices/pxrc.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/input/devices/pxrc.rst b/Documentation/input/devices/pxrc.rst
index ca11f646bae8..5a86df4ad079 100644
--- a/Documentation/input/devices/pxrc.rst
+++ b/Documentation/input/devices/pxrc.rst
@@ -5,7 +5,7 @@ pxrc - PhoenixRC Flight Controller Adapter
 :Author: Marcus Folkesson <marcus.folkesson@gmail.com>
 
 This driver let you use your own RC controller plugged into the
-adapter that comes with PhoenixRC [1]_ or other compatible adapters.
+adapter that comes with PhoenixRC or other compatible adapters.
 
 The adapter supports 7 analog channels and 1 digital input switch.
 
@@ -41,7 +41,7 @@ Manual Testing
 ==============
 
 To test this driver's functionality you may use `input-event` which is part of
-the `input layer utilities` suite [2]_.
+the `input layer utilities` suite [1]_.
 
 For example::
 
@@ -53,5 +53,4 @@ To print all input events from input `devnr`.
 References
 ==========
 
-.. [1] http://www.phoenix-sim.com/
-.. [2] https://www.kraxel.org/cgit/input/
+.. [1] https://www.kraxel.org/cgit/input/

---
base-commit: 7214161111af87aeee721ab1b2808fcb4421aff7
change-id: 20230824-pxrc-doc-1addbaa2250f

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>

