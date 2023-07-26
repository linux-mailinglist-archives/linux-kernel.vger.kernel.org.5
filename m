Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E32763B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjGZP3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjGZP3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:29:45 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C742136
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:29:44 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-565f3881cbeso4668719eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690385383; x=1690990183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U6AGl6EJ9ojfwoIPkx72Nb+mtQBvhnepwNiGsBvw4D0=;
        b=o2lRCoF8UiW4g2FvhAfGcHRAWarVH1BVZr1TRiXK/HguesFgB+xKw7VvS1aovlHwYp
         btM0bh5TIHLSfJTKNMemFYfpvPepO4KeteDn3QXnHvXtkx2AVd8F842l8VTteoD6aNa3
         W2No7UR1sANH9yQS2q9/XldQaX3WZKEtPsdTHNOmYcAUeLjYJ988VKB6lnlKHk1/OtwF
         24g0TgUN1/wMfPYWD0VIqbFQiYahiGwlWwrh9KB3vccu6rAqpn184sEjlu3dJKnXN2gf
         w0qWpk6HWDTfSSTofgWsKEU6gsaNr5kquhTnOnvYxYi/6ITjfNo9Sk23AKIVpcmDvbzF
         EqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690385383; x=1690990183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6AGl6EJ9ojfwoIPkx72Nb+mtQBvhnepwNiGsBvw4D0=;
        b=VArNQ4+VI3LlI85yVjVyXZgRGYsKbX17y6GJePToabE1ED0UgN6wHkBc2tFCAmrQYr
         VYlfHRMFgFt/e3BYQ359+5LWInVUXhww9LBj4mROtyLC6pK7JoEQoKUhmsnOG8dTUanJ
         ScWVLZiTeUFByvTE3aqX+kDOQQHNAWmTNEinUCM+eEB0IrhCeT+aBrKMFmfYpY1uh5yP
         2oZJpmlUixt+D5p5okbZbt//Kzhxu4rhLvU5Ph0dC2z6l93clx4cUwMw6L6RoW/j3RqE
         OS4AVxsaUg+yD9J8DI4tlwKY52sAT14frg0IwGlVILsN+BaUKdQ4Y8SeB/AAYjuoqtOi
         lO4A==
X-Gm-Message-State: ABy/qLaN7n6CzpF1SQHk/PZKtqBAIkW9yJraH8K9iG4hDJSLYbR73Yd7
        CwRewL/y47/A5n+1ctR2W5sK
X-Google-Smtp-Source: APBJJlGTcKYWeISBmDCN0aDKSXjg/bNNvDOKZoF6gCXICknVsGl/EaEkWIvL8cSGJJy86LKI8Jxf9Q==
X-Received: by 2002:a05:6358:2607:b0:134:c279:c825 with SMTP id l7-20020a056358260700b00134c279c825mr2799666rwc.12.1690385383248;
        Wed, 26 Jul 2023 08:29:43 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.53])
        by smtp.gmail.com with ESMTPSA id k186-20020a636fc3000000b00553dcfc2179sm12886092pgc.52.2023.07.26.08.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:29:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: qcom-ep: Treat unknown irq events as an error
Date:   Wed, 26 Jul 2023 20:59:31 +0530
Message-Id: <20230726152931.18134-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, the Qcom PCIe EP controller can receive some interrupts that are
not known to the driver like safety interrupts in newer SoCs. In those
cases, if the driver doesn't clear the interrupts, then it will end up in
interrupt storm. But the users won't have any idea about it due to the log
being treated as a debug message.

So let's treat the unknown event log as an error, so that it at least makes
the user aware, thereby getting fixed eventually.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 267e1247d548..802dedcc929c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -593,7 +593,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 		dw_pcie_ep_linkup(&pci->ep);
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_UP;
 	} else {
-		dev_dbg(dev, "Received unknown event: %d\n", status);
+		dev_err(dev, "Received unknown event: %d\n", status);
 	}
 
 	return IRQ_HANDLED;
-- 
2.25.1

