Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5364A77BCC0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjHNPNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjHNPMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:12:53 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460B8E6A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:12:52 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso68809821fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692025970; x=1692630770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqmcrIOgwT4P/m/Qo0pGRwGzeNac3H+8rfjS3Os1OQE=;
        b=za+f3pRtJG0rthDi5azffRqi/A06+IPasCTBle2NC/Bm/aznOXiFyp9Ig7FB9wMQxW
         TVlgFlEZtqhAA5Jf4UCYqw7VStHHj0SDJHU1PMjBz3NqVbeAi5KoRuigXQEJupNeVzuD
         P7/nQ4N+kyQSJNaHr9MxtKXMrxbeC9334qc4rP45XDFQPyrrhQ/pRIbXECzcM0RzHc7R
         /SSA9W+LVG7KRObt37zdGiO6zrdGI1HyG+avmDmCjyRoBjtgaLhIcXNOauMNYMLYMCkD
         e4XT2XaPSLloQ5c97fgAkHLpCQiqzU8mp285sjxs/aMrswG+Bul+CF9769pD29lj/5vj
         wwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025970; x=1692630770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqmcrIOgwT4P/m/Qo0pGRwGzeNac3H+8rfjS3Os1OQE=;
        b=bl4j41TLxKkGk16tSQHz6VOyPq+ZMz0o/IHJfumyKcXKRXbKjcO7AT75GrOoShpnAB
         7sZQhG+DUCEuPNCH+DuNq6gXmYlkpbiHQVnG/uC8Z3C3aWRmaaHKvLMnesHkqKk9EIvi
         EelotD9z89m2bKotf9xwk1IWFvU3rCVxZfAmmXkFATvsjDZR2sjfnevWTTkMYvDF+2m1
         V9TietaTaq01BSzFef0SeAez1Uu050B/DQgIIC2PcZ1/p/m2CQHw6z7Viij8ccOTmzjq
         nxn6c0QiJAPyExROB200SjD6MADijBYaIwD7pRoqO/QMty7Om30XkRdNlL2e3SyrF5uo
         n3vQ==
X-Gm-Message-State: AOJu0YyDID30PNEZ6LLHHK8axZiWfzVVHwxsdK6LUWN4Mmab+1O6a7Tm
        NJVVqTNuHqM5FS5l0TKprDT6TQ==
X-Google-Smtp-Source: AGHT+IFP2/JfYkQLXDXM6RMvej5FYQ0Il9A4TqLJszbuZPWvX9l59q1ZFCk4VaLKQg7n15XSrxrKsQ==
X-Received: by 2002:a2e:a174:0:b0:2b0:297c:cbdf with SMTP id u20-20020a2ea174000000b002b0297ccbdfmr7452279ljl.1.1692025970497;
        Mon, 14 Aug 2023 08:12:50 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003fe1c332810sm17644572wmi.33.2023.08.14.08.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:12:49 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 03/13] media: qcom: camss: Drop useless NULL assignment for ispif resources
Date:   Mon, 14 Aug 2023 16:12:33 +0100
Message-ID: <20230814151243.3801456-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
References: <20230814151243.3801456-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NULL pointer assignement is a redundant step our compiler will
initialize unpopulated fields as zero. We check for logical ! later on
in the code as opposed to NULL anyway.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index d9e1672b74bd7..68eb45b2c0aaa 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1729,14 +1729,12 @@ static const struct camss_resources sdm660_resources = {
 static const struct camss_resources sdm845_resources = {
 	.csiphy_res = csiphy_res_845,
 	.csid_res = csid_res_845,
-	.ispif_res = NULL,
 	.vfe_res = vfe_res_845,
 };
 
 static const struct camss_resources sm8250_resources = {
 	.csiphy_res = csiphy_res_8250,
 	.csid_res = csid_res_8250,
-	.ispif_res = NULL,
 	.vfe_res = vfe_res_8250,
 };
 
-- 
2.41.0

