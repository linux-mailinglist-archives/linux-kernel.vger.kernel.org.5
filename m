Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5479B7F1CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjKTS4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKTS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:56:33 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA04CCD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:56:29 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507962561adso6908699e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700506588; x=1701111388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ujELrVFY4be6CUqKjNRUfHmySKN0sInkgu1RJGqy2s=;
        b=nNQC3xNuCqSNUX0YNlBSs1tFk8utgux8aIvTLJCjHzbJkBqbB053Nlc2OJ+dlVZLMe
         Mr/bIPiHVN++ViaXsuatzZo6O0pqmjcfJ3JNpIFb7HzJNpRF6GkVrgKrj89VqfHK9MX6
         PzO34hwm4kibjGnnUfYDvx9drqx7qMNntKScZnqyLHzBf7c+jVIok2Uqe9qkW/xh8DhS
         164XwRKOqTKeENbrGUkniy36xrNizFEK8FmIDNDPPgVT6KAWJE0UTzx1eyn6J2cNYSYw
         DSvWo3rqMGgRX2ktjkYXJHE+n6ueFRLsk9YFqEykMFO78pK5XRnU9z9hMLlgUBylWLey
         zfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700506588; x=1701111388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ujELrVFY4be6CUqKjNRUfHmySKN0sInkgu1RJGqy2s=;
        b=TExM0o9dRxBRZYabSC7mbJ0GIFewgRK3w8ajmoIRvlrXzw9Uh2vMdLFxu2KLR0f6ul
         5pfJqt/3hvBelzac1fRVJTOs2qPj9hok/Vhqh+NnDHbl+V3WV9/D/ZCFKqjYVjzoNjqk
         VjIDljGom6ra+A+4zPL2a8SwCzX/f4IAqc0j7x/1KFwGEidJzXk/aY8R3QWA1ZQetUjP
         PCABQANKgjNFuLSSzfph6zOmvEr+lCBMwE1w6G0DDBXVgn9Tr76ilDu3uytDa5KBEv5D
         mZUd10QzJJYjOqP6I5wee/c9lvCqswx/TGFUS2W6GkiYqIRAuKUlgfZVvZ3mPj/Xj6gQ
         MCnw==
X-Gm-Message-State: AOJu0YwYRIkuL+GsqWP74IgxXNfiDIRJpyXXbio+2OwtAF8K0OWxLls2
        Smn54PUh3vm1jir6sYqdwBvt1Q==
X-Google-Smtp-Source: AGHT+IFWrMIJTDr7hYj1W0XiATUl7zuhTf4gh9X6ymwQzjZQ8RX9HAXJSPQR+7zZ3Kac/ke905vXiQ==
X-Received: by 2002:ac2:5159:0:b0:509:38df:1e77 with SMTP id q25-20020ac25159000000b0050938df1e77mr5924245lfd.10.1700506588031;
        Mon, 20 Nov 2023 10:56:28 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7c05a000000b005485282a520sm3412520edo.75.2023.11.20.10.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 10:56:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] firmware: qcom: qcm: fix unused qcom_scm_qseecom_allowlist
Date:   Mon, 20 Nov 2023 19:56:23 +0100
Message-Id: <20231120185623.338608-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

For !OF builds, the qcom_scm_qseecom_allowlist is unused:

  drivers/firmware/qcom/qcom_scm.c:1652:34: error: ‘qcom_scm_qseecom_allowlist’ defined but not used [-Werror=unused-const-variable=]

Fixes: 00b1248606ba ("firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311191654.S4wlVUrz-lkp@intel.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 520de9b5633a..ecdb367dc9b8 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1649,7 +1649,7 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
  * We do not yet support re-entrant calls via the qseecom interface. To prevent
  + any potential issues with this, only allow validated machines for now.
  */
-static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
+static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "lenovo,thinkpad-x13s", },
 	{ }
 };
-- 
2.34.1

