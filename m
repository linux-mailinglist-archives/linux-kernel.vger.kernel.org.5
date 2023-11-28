Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0BF7FB453
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbjK1Ig4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjK1Igx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:36:53 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C3F10A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:36:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bba1dd05fso518778e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701160617; x=1701765417; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndvlHffn+v+7jRpIhr2PQ0zOxK49/EI25GTkz7n0JYg=;
        b=rzXrRXwMse+hL/IS8rQXfGsWgbtnROBLXA4udvTw97XvZ51PlMDzMUsgrAAagcHs1Z
         BJOlD/DBYM7MNeRaAQH68h+nIUzioiQ1ia1NPsPSPkQEaiZETC/oOJlQOlb0Uvhf6ujO
         zGmZf9JUGhW94ju1PuOqygpmPfc3dB9KM4b/joI17QWAEUyV534ftf+y1SKxmjFNF+Pi
         RGKkMBWpsUW62r0tNWl+ukriDUqhkcxsn+B7fzmQY0nzyfNFR+W7x+SLRCbK6J57wRAT
         vBbMH9YWw6PtGtW9OVszzX5i8hVfb1mN9RP9eXSkM+YRZgQbUGm0YF5vFGH6qvmVdw2S
         /ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701160617; x=1701765417;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndvlHffn+v+7jRpIhr2PQ0zOxK49/EI25GTkz7n0JYg=;
        b=Jfq8KpFYj7EfMAuKEUlBxQ7i76LNkqTkrX13bhyw/JfLcn4Xgk9Pjx/ODqCGRyKige
         k90x84Ixb3DhjNGIajwfYgWp/3ALcs+9R52sPei7ZS5iOyAKvavhbsvT3IGUkVMEZe5C
         2nCcIPfqekCj0ViLo32dtNBAK/eiwBxiLNMPIkOky+nYtXx/cGqhCbQGPTRPHt1X0xpp
         GteSlFVK5ZK8jbaJZXGZo80cFYxKpz7sQC9e8f31QlCk+xStcg4z6wUZXUZxgdZz9d75
         /26Cfs/gergIb5+p01dEFXp3RQCBd3w7AjoNNIowkMdabRF2HK+yXId016X13Y1mEJZc
         Ls4g==
X-Gm-Message-State: AOJu0Yzf7ZLG8yZM7ThuiQETRLuwbT50IFNOs8R8a22Xg0omfI7hm/TD
        D9uNJ7TCIIeqndEBF4AVP7ZnpQ==
X-Google-Smtp-Source: AGHT+IH3naDiSAvMe65JEiUJ41gZDSqerHZJlISGg2SLDjWoDzje6LCP07SmqxC7BoqRB9JB0du7gw==
X-Received: by 2002:a05:6512:1386:b0:507:a9b7:f071 with SMTP id fc6-20020a056512138600b00507a9b7f071mr13195200lfb.1.1701160617415;
        Tue, 28 Nov 2023 00:36:57 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ay12-20020a05600c1e0c00b0040588d85b3asm17390529wmb.15.2023.11.28.00.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:36:56 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 28 Nov 2023 09:36:50 +0100
Subject: [PATCH RESEND] dt-bindings: PCI: qcom: document the SM8650 PCIe
 Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-topic-sm8650-upstream-bindings-pcie-v1-1-9c803b439952@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9202tyaMMRdGcdJf/JRZ0vhX+oG3wOQczHTXpC7CSu8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlZaanrPZ4eB3vQ9G+ZXaEF6naExHNnSvlxOAbGMkH
 JuEn2W+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWWmpwAKCRB33NvayMhJ0fpFD/
 9ajTKwAHyrK3169CtWuLrK2jizVnpbTvGTMo4pbUyk8yDZCKUGP7aDtHj6kLD1vSZR/Y49MnBeiMba
 /Hwx9wXRqLL/R7Exd+ZF0YcjZsy/hNe+CUE/AcR19pcRwQfHW4E0D0V3sn23kRalKDJOeR+SHJGH2a
 fyOptO+FdjrAvZ0Tnn004/6hdbrIflbupjpkcCLZCjIliitzz9lxLZz86+umD1FxLn2tKixtdcyjN5
 kuy4uTh+5a2hPG0VB9/Zay9kU5nEruocuf87H/llQBVdk4YxHNxV9TeCN12tlWlFIkBkqiWE3JvGYM
 dvm54f4jD0pFg+IvwRrGScHnTmbl53H1q3lgiG18q8zswlrt7Dyp3ItImxXiAwKV9JWMZDE3/4QeC2
 71s2+NOYy4Q7Gfwj6t5P89TTsBXvj0/8/r4CQCVirQNfwx9n2HgC6uYQKCQmVRE06gwDlLQAoE5JqL
 NEyMuOaQRIvzQM4ZVtiTtv3WYETpVSCWdG421PMYv6o6PoNdN/VN69+4gO2mgYYi3GGRQqu06hlIr2
 /8j/UItWEKdZVi3GkSeCHyXSd7VdshNfNYZe8D3Sca0sGe6UU++h2KjjgrKsRnvqInZbCQMR4cYAkB
 RDBR2Jf7syf26uPh7QIxZJw6g4PHjz+04DOjNkZ1kfuKYw7bVP7mNX7wpDpg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the PCIe Controller on the SM8650 platform by using the
SM8550 bindings as a fallback.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index eadba38171e1..af537732ded6 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -41,6 +41,10 @@ properties:
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
           - qcom,pcie-sm8550
+      - items:
+          - enum:
+              - qcom,pcie-sm8650
+          - const: qcom,pcie-sm8550
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-pcie-56e90536c258

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

