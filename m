Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D0E75B6AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjGTSY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjGTSY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:24:26 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE2D30C1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:24:06 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b743161832so16512411fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689877444; x=1690482244;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XeINWhFf2RFRccfua9ehIM44ZCWOB8o2UI3oarjPfas=;
        b=dcnoeItgOAhaSwXI+HvvTzFoa8U8PHMTaFO9yCuvx4LDc4VONRm4C5MDI+fOl+VtGk
         UPLYr2VGI8BVoZFOLQSVubZvT9b+DXdq8/TUBzMB0veZTmWtx71o7J1eOJDOqmoMx+7G
         W7TRGYOSxkOGyfJ8ZrsUuZAPudyHrjDPil8wzIPKAFys/u5MKSEa9LXPOaVtqAxA/PwQ
         wdWLy9OcCHA+PDf1Xm0Co4T17gigOQZqWDrV1NLYlBgjt/P4CnwKvaZXx+QMk9KpTC+S
         g9FTlnLJ3y19xR2KfUK/mGve3JFro/CyRGveT34J0dyUs2drVUEI6Ovrx2jsvOTFQ5tZ
         KAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689877444; x=1690482244;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeINWhFf2RFRccfua9ehIM44ZCWOB8o2UI3oarjPfas=;
        b=To/BGbrMCEGqdlKI5XGUNhyl1YPgDy9b/eoQPczosbupfvukOmZ8oPWzDd+kDmLo9h
         sAyPYZLBTsO7oUXA+o4a8bvk2DlFjAM8Oz2Xw7Fu5gkvbsiBDnnQW8n20Vt9h7oS2Zgc
         kbDKDwoflbCuOcIqOSGqf1cPxFYvzIFxrOBZVCnIpvjn6ZiK7L+LqFuPW3AmnPQMPc6V
         +S+I2ncMhBnTtYC0QH98EE12E2Z/M+zQV3vMbYSwbITPdb15Oh8qSjAHnys20hHGGgnG
         VFJ3Y4ZNaj3gfDhWBAx8hxSXtUAphya/dQGmaSPnKhQdIKd27pVVeMYCJ/ZQUTGbJR8T
         57Dg==
X-Gm-Message-State: ABy/qLYf/Q8UHlVPoTuuYyGZfWxnQsrJBAyQo+73B/vslSbbVLkZg83s
        hu5Hwt4NCACicxcnfW5C3eacDYL/ie72rrQzIz4mLA==
X-Google-Smtp-Source: APBJJlGIW4w5YklsB+5905H+uevQCN+KXhanw5tPf2D5QLU6UQc42Eg/FvKNfiFalp5+Mq0AP230Ag==
X-Received: by 2002:a2e:81c8:0:b0:2b7:b9ca:3eda with SMTP id s8-20020a2e81c8000000b002b7b9ca3edamr3301779ljg.34.1689877444344;
        Thu, 20 Jul 2023 11:24:04 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id g23-20020a2e9397000000b002b31ec01c97sm428304ljh.15.2023.07.20.11.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 11:24:04 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] QCM2290 icc fixes
Date:   Thu, 20 Jul 2023 20:23:59 +0200
Message-Id: <20230720-topic-qcm2290_icc-v1-0-7f67f2e259c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL97uWQC/x2NWwqDQAwAryL5bmA3pfi4SimyxqgBXe1uWwri3
 Q1+zsAwO2RJKhmaYockP826RgN/K4CnEEdB7Y2BHN1dSQ4/66aMb16IatcqM5L3Pdf0YJIKrOt
 CFuxSiDxZGb/zbHJLMuj/Gj1fx3ECGcMyLXgAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689877443; l=546;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=z/pSw9F0hi5UliEIx3O2Z/+ful20We0HuGTyRN5xWgk=;
 b=Ihky1qdtAg09oi3bfsVg4s7VeAUYfvGJDLUjmqIfRAFIwC2YTc7xch2v98qn8szIQJhCGfYNv
 ySb6qGFrM1OC+bmcdJgnfkVt0LMgs70NDigKrvTrAFtAOyVGFQUbA6H
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains fixes necessary for icc to behave correctly on
QCM2290.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      interconnect: qcom: qcm2290: Enable keep_alive on all buses
      interconnect: qcom: qcm2290: Enable sync state

 drivers/interconnect/qcom/qcm2290.c | 7 +++++++
 1 file changed, 7 insertions(+)
---
base-commit: c58c49dd89324b18a812762a2bfa5a0458e4f252
change-id: 20230720-topic-qcm2290_icc-211dc925c2e8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

