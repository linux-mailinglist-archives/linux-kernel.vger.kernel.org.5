Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC477F267
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349081AbjHQIrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349114AbjHQIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:47:17 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CF22D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:47:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so68970015e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692262034; x=1692866834;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3fJBKichbcUJaUeGuGGVi5uOpWmIO39Fx8xDfL4HHr0=;
        b=bD2O9X36wqMFMPrap8rY+/KUTwFsiPgaF7Gd0AlTyejgR9fjMhakei0V4k7Bg42EGl
         2eFzVyyRuMn/PQTHL4FWUlQ4ElHnzTsC9/qkd+hp8pyrnmEMLpYm9AK5NZU/NrGyPOFn
         TG/zD+ZjAxlbdsw5ni4xjNXqPeT9Xf03MW7dXuh8z+BSQMPO/ZP1LMmWH/wpgVbTsP7Z
         9o4oAHkEnD3q3i+8JQFrkxMO0BoS/guye9z/g1zDseKaveA/+WCxQlZ6Yl7vZ1li57Oo
         Jh3iWgjmpN2ug6poTj7DmmD3j8la3LTd6TyrYj0XUD0ZWdb+K7wBhKeLwNOgTDPKB94i
         zotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262034; x=1692866834;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fJBKichbcUJaUeGuGGVi5uOpWmIO39Fx8xDfL4HHr0=;
        b=TRjrVmWyJTGwkj64g32mSPDDY3PyTqGGE0gYAXN9w+QOJ2vVxTWxfMeCRnL2tzELyw
         aM5bH5U22UDdSmztdEPlTV6/A+b6v3LovB/hoOSjREWCvue6Y+GJPX6mx8uNCJQdeZZY
         GOC0v1wp/8yZqKvNAYKC08SJHGpbvBJ2Ux+2mfU+nXmT6qTDRM05IivCXk86w4Ta955c
         hxxOnZ2Et7D8Ys7J+zWlFyqkR5Ei1vO3YCZsfvqn6ZAcFUQOnC+PkOdpYIlb/Vnldpd+
         4pAHU8pVrqUxGUhsG1pNWnJZgeY7XCEg4UlkT2HdVO6pW0OUruXuDD03odXzBQCt/H5N
         HqlQ==
X-Gm-Message-State: AOJu0YxT8pNNb3Ro1jDN5E2C2qidiJr8LaOjgbRICka6/xEF2B7M7vd9
        LGdFCPejlAmiJ/Q3EpHgKJZXoAanhXpFvSe1vgb3rg==
X-Google-Smtp-Source: AGHT+IGT8x4c6zQIFNUyxxR3dpkayg723Mjmd9l+9co8A8XnKbuXyyMxlZ0ZKj6sJixUXZ5ulMIRjg==
X-Received: by 2002:a05:600c:3b23:b0:3fe:2b60:b24e with SMTP id m35-20020a05600c3b2300b003fe2b60b24emr4583739wms.29.1692262034496;
        Thu, 17 Aug 2023 01:47:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c280900b003fe539b83f2sm2117285wmb.42.2023.08.17.01.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 01:47:13 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/2] arm64: dts: qcom: enable BT on SM8550-QRD
Date:   Thu, 17 Aug 2023 10:47:05 +0200
Message-Id: <20230817-topic-sm8550-upstream-bt-v3-0-33f386e7b461@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIne3WQC/42NTQ6DIBgFr2JY92v4Veyq92i6QAQlUTCgpo3x7
 kV33bmcl7yZDSUTnUnoUWwomtUlF3wGdiuQ7pXvDLg2M6KYMlxSDHOYnIY0SiEwLFOao1EjNDO
 0VnOGha014SjfG5UMNFF53WeBX4Yhj1M01n3O3uuduXdpDvF75ldyrBdKKwEMvKJSlNxKWdHn4
 LyK4R5ihw7rSq+aaDbVssGYs5YRxf9M+77/AGQ1//kgAQAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3MIYSeYKIkzNTWMQi9UAASSfKFViulJz76XyoneyY7A=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk3d6Qo1cA05Afq+jv47MR7TKY3YBiYClr8xIBBWpB
 pXzr3WeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZN3ekAAKCRB33NvayMhJ0QBXD/
 9RTANCKRGJgcwHXFeJWFNF7X28mQL4UyUGPCWKZ21wJBepPWRSvcOldIyPpBiQRLOn4/emy/MOzakk
 JcvIQOP13jzFn2tGZzyuH4rEV0ppBuY2JW5GDts6tcEca5NgRFPx9DsknGN0AXnfeKdzvBLnYzda4r
 85vA/8BEeJGBg9aXZFvL7m/y8uQlI6ghZFFwc0JI+wOFW6oZc9LvLiC9NfAUgJpo6JMEAmrm4/N1St
 7h4UqdHZ/Ip4rtsLen0UJnxpSYyhYBucmClNOmh7BcbA/+ZbCzmxvJUWxtX5bYAQHd4JPRL+gT66LF
 3NPR0A7greRkftW2V3ZUKJtNWk7j59MWqISK36kzrTGDmJYixKfO/PseDCyy5lBThOTAcE18qKUuNf
 BJCYilXuBfh9CMzrn1OXVVMk4XNXgq4h82V54hyLYpGBsBJ82mze70Z2WvAT9v+GSjsgL3bNvTLwU1
 N4m3aHSLSjMDpmTFyva4XsxiEXDyeecv7AtN7p5ueMbX6+sPKvvny7hfz/rmkpD6XoFIDgAuNtVD3o
 b7AyDP03RnJtfnhI1ZeuB5m7BZXhaCB0T1MtZfF0y6t+cSObLSSFE4Pwhj+3DZFmFoaSjRVlt1HgSS
 H6aIt01q8UK8vX2SGzNJ3h0GMFGShNAqKRyDuGgStDKXyObJmD0n2qE1+90Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie enables WCN7850 on the Qualcomm SM8550 QRD
reference platform.

The WCN7850 is close to the WCN6855 but uses different
firmware names.

This patchset is the followup of https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org
with only the DT patches.

---
Changes in v3:
- Dropped applied BT patches, on DT patches remains
- Link to v2: https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org

Changes in v2:
- Convert if/else and qca_is_*() macros by switch/case to simplify adding now BT SoCs
- Add bindings reviewed-by
- Link to v1: https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org

---
Neil Armstrong (2):
      arm64: dts: qcom: sm8550: add UART14 nodes
      arm64: dts: qcom: sm8550-qrd: add bluetooth support

 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 43 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 30 +++++++++++++++++++++++
 2 files changed, 73 insertions(+)
---
base-commit: ef66bf8aeb91fd331cf8f5dca8f9d7bca9ab2849
change-id: 20230620-topic-sm8550-upstream-bt-dfc4305f9c14

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

