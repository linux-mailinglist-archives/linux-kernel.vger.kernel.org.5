Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2F77F9FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjK0MrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjK0Mqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:46:39 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A36F183
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:46:25 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67a47104064so4146506d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089184; x=1701693984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+E40YbuoBKmAjqkT6wNa06Lpu/e8RsvW8Aa+FgX6YU=;
        b=Kv8XsuqFwPw+PendwGLsbOjgoUZwmmT3PNk1mxw2t3U3kn4cdhjOHOB3kVmNQwXRAk
         FwLl9+lrIHbOTprVKPx7LVmilDBdEK2cryucwPqkRQGBp7Lg95NKTJlpq+/WSAv06VnZ
         4O0SK9Ve9coWk5MEVF2+fDbj3Oqi1buONg1E7Z8jg7AJ7WB5NTSHkoRUhC4CeB+Rlnfp
         OkNF0U8pLmkJqPOCRN0i7xURl6HMX3h6VAL8BM7k3bMwMj1Y1hO1Bn1wQNv7AjshEKdq
         3ZciFLgMMhz9goS2FCBdIIWhw14c/Z1E9FscQE65HBNiJgEmyXlwNLNghmjQ2+63MhvB
         VYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089184; x=1701693984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+E40YbuoBKmAjqkT6wNa06Lpu/e8RsvW8Aa+FgX6YU=;
        b=N7Sg05hmMaV1RhreJULStwjmmuPMVMnQAJMHHO4ChGPMfBkBN1g1ScFmGzLRa9ktg4
         +Dk+L1xs6VynYPFbh06e78v/kTEndtBGdcY5upctdWzkirQhnXVwXgk7grOUcbFcrFK7
         /JZepxSaw4odSMup7Dn5ll0GfkWQPdHHDFCrPc9XdQpPumRIOqjLUFMVJ/Yrl7YUM3wD
         9/nwV+7YW77pShFhleqW6UhqIU97pZwhz1rfbWjuL3zc+0XbsEs4s4gh92jU2iXZj7Z0
         MDwrvhPOgXrPRStk6zpsGTXirg+aTOZ+WWj2OSdgC6fg2oghvENevMjh3zaaJ9GKjMo2
         2RwA==
X-Gm-Message-State: AOJu0Yz971G9PYWK6IoCVn4BOvdfhiTAUj2unZROU7DBX5MSj1Lbne7o
        cFQb+3oH3J8X3NraUYpyV4N+
X-Google-Smtp-Source: AGHT+IGjJ2kzkE/6gacJvEqAeEjIAyBT1VNMtpx4NnbwGuihBYTTMBLfyUdv0rtU06YkX96BCpwzXQ==
X-Received: by 2002:a0c:edcd:0:b0:67a:49c5:8cc3 with SMTP id i13-20020a0cedcd000000b0067a49c58cc3mr1827133qvr.32.1701089184590;
        Mon, 27 Nov 2023 04:46:24 -0800 (PST)
Received: from localhost.localdomain ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id er10-20020a056214190a00b0067a204b4688sm2832231qvb.18.2023.11.27.04.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:46:24 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 9/9] bus: mhi: ep: Add checks for read/write callbacks while registering controllers
Date:   Mon, 27 Nov 2023 18:15:29 +0530
Message-Id: <20231127124529.78203-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MHI EP controller drivers has to support both sync and async read/write
callbacks. Hence, add a check for it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 3e599d9640f5..6b84aeeb247a 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1471,6 +1471,10 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->mmio || !mhi_cntrl->irq)
 		return -EINVAL;
 
+	if (!mhi_cntrl->read_sync || !mhi_cntrl->write_sync ||
+	    !mhi_cntrl->read_async || !mhi_cntrl->write_async)
+		return -EINVAL;
+
 	ret = mhi_ep_chan_init(mhi_cntrl, config);
 	if (ret)
 		return ret;
-- 
2.25.1

