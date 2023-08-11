Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7AE779B3E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbjHKXVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbjHKXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:21:13 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B829E2717
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:21:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so39286821fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691796065; x=1692400865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBBULFtJIjgzV/+g1Yu/If4645jApYjaOUQ0btSC4wU=;
        b=vur3vEuf52fGLsfAkey6kX5hfQPrucgPzj/BwKr2+6dhKfwAKcrbM4g9FYqZN4E8mO
         xBtvNLUpH2EsRcmhjS5IhrbUkrFslKNf0+UE74r2A4QugBcNYNPky2k7Cf6O47Ea+Mdb
         fIfO7s9X8VuNRxhUidnmT686J7DR+tM73dWrHUkU711ae6n+tqaR9P6zGjeFJp6mk2Tn
         SQSA1sWvYuI8ZZZUF3j+jwWDZdjGyk1K33rO98NiA6cUeScqZscKH6yCt86nvqd+DqJq
         +0D1O3v78NkeOTXAAp8a7eGL3EroGOIRz0h79Plc04qlho2GQTDgNWtrZEPCbygB8sSl
         lkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796065; x=1692400865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBBULFtJIjgzV/+g1Yu/If4645jApYjaOUQ0btSC4wU=;
        b=jo474o4mfp02U6Np46DWU1/P7vX0FBS9QPGBEtL4idAeNZ6GqUsigzlW8560ZvN37T
         FKqqdOa8DqOLnMWzn7PHp/0sUTR6POteecaNshNu7fimWtsBTaUIOBmqBZ0N1WnjxEmi
         54/nuCEGEwbDn6c/fBclTVDiKlbTZ/7kC9K9K69mb/SN5fEL9godJ2tT+PxHUrdZJgQq
         GlkYSpVJ4qHRax+iZULK1S4MDDtrYBKrpVd1gX7nviwDZ+jNDVhx4uDm3/bggPSt7Qqm
         95ytbqkitErf0kW2Y12fRCp2Ejfj7ioItAQEUNmkdwMvzw6u2rjhJ/zN59ZdcUFjES1Z
         1nLg==
X-Gm-Message-State: AOJu0YwRnCpWEiLDZbbn+I3ZRNBwMtLBi2UERwW+4wT8UouyqfWLtcNu
        +FjvyL+y8sNv4JNN8gErcGQH4A==
X-Google-Smtp-Source: AGHT+IEQou8mJyo7LJd/8CwRbykiQlMKhGx1Lsj9PqAwtw2VanBnf6UsUZ8yWm0rkg/k9zVMS8boVw==
X-Received: by 2002:a05:651c:1028:b0:2b9:44c5:ac15 with SMTP id w8-20020a05651c102800b002b944c5ac15mr2629419ljm.41.1691796065072;
        Fri, 11 Aug 2023 16:21:05 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e965a000000b002b9ea00a7bbsm1038210ljh.60.2023.08.11.16.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:21:04 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 12 Aug 2023 01:20:54 +0200
Subject: [PATCH v2 11/11] interconnect: qcom: sm8350: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v2-11-765ad70e539a@linaro.org>
References: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
In-Reply-To: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Richard Acayan <mailingradian@gmail.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691796047; l=751;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=425YgmglD3uyovRsDcuV0bL7ZpvbcYQFx116oPIXrh8=;
 b=3vEJuPI9guDuDBDJY/ontSaw+6V+T+G12Jajt4Q/zEbhR1P3zYADYE7LzizsWynSIFr0FFXDC
 oB1F/gDvkGKCA3yKWhZnwSsZRAM6YKSCQLJpKS6BA6/wmYUIl/KGcSE
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: d26a56674497 ("interconnect: qcom: Add SM8350 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8350.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index bdf75839e6d1..562322d4fc3c 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -1356,6 +1356,7 @@ static struct qcom_icc_node qns_mem_noc_sf_disp = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },

-- 
2.41.0

