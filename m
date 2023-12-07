Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1625808613
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjLGKxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjLGKw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:52:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A948D59
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:53:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40bd5eaa66cso11004625e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 02:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701946382; x=1702551182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzAkdCe8GmigS9meJGB6RLFDC8CgmK6hEzQqiVyayPM=;
        b=WIFpfyPfJxZp7EzuHYsbL/8Cuffv8AteYGwTv0eQkEewXhqBEVPJm9U1ng1Xanzipj
         SXfup3xW3emIXT2ZCuD6ErkrmWcSuNhKfNY9gGmS+5vcpRG7AFSRy9cc+dmk8qMMBkYd
         2Sn8JquW7hRuDbKhoLZeUrlrs11y4OKWxJvNfMbbT3M7FWAh7FRokR3Ed7wCDBtuwyyu
         D2Q+Q8o4ni10SoZeYnKq3poqgZc/xeRSBTy2sE8l6cf+RyhzIW+5+0QCp4pQefbzW5M+
         ifikXRlzqRWEsKqIjVqx0waaWmbkvcAfnsYedrKEWbopedGn6h4b0ZkQKhpzSP4ZQFem
         XQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701946382; x=1702551182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzAkdCe8GmigS9meJGB6RLFDC8CgmK6hEzQqiVyayPM=;
        b=SVn9bBNJTLaWIkanQk53YWFveK9PCRoYDZGMPzZZcaVcWIbjMJ2JP5swS+G6CyoJ3p
         6/3fLV730NTbxVmLz+nv+obGSkn5nkrJOcjtL+W4rfqHpF6HJI/HucWPt+6nb3OhJSVG
         1VCYzqD/YkjSXEOzNBrMtG4QjiXpD//nu5Iqb+4gcPM1f9Fjd4Qlp4HhUT8YrAal87kj
         GM/aV8D8o2gl6ixAcdPBihhDrv/GDKVEnE6alUB2iKOlL74lzSgHz5RBlDYw6O5UMh1I
         Lpa2RsbHKRUQYDoWRwHjQXvz7lRR2mjAAwgitUD7vuc2X+Hw1FQoiUFVI8ksKiKomhRZ
         OO6g==
X-Gm-Message-State: AOJu0YwM5RXzvkr6GM8x/hlfsbvm94gnad5S+8+9/3fb71VyrQH8/yWU
        ePNA1nhSpWXSdqUlPp1Ro/M5ng==
X-Google-Smtp-Source: AGHT+IHRtGdot/NsE2L3XoU8qXrI4IhdWzOZdCj+ecTyhBAvaBVisMbzzrPQ2/3t11cv8c68fwqI2A==
X-Received: by 2002:a05:600c:2901:b0:40c:2699:b625 with SMTP id i1-20020a05600c290100b0040c2699b625mr795852wmd.138.1701946381938;
        Thu, 07 Dec 2023 02:53:01 -0800 (PST)
Received: from [127.0.1.1] ([82.79.186.233])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709063e1700b00a1db8b08610sm668700eji.148.2023.12.07.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:53:01 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Thu, 07 Dec 2023 12:52:48 +0200
Subject: [PATCH v3 1/3] dt-bindings: phy: Add PHY_TYPE_EDP definition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-edp-x1e80100-v3-1-576fc4e9559d@linaro.org>
References: <20231122-phy-qualcomm-edp-x1e80100-v3-0-576fc4e9559d@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-edp-x1e80100-v3-0-576fc4e9559d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=559; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Hwpu6tM6RD/JKvU7jn8nmPGWlA4+6aqHXvdwplMfgcU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlcaQHvtNBoyFoDqGxYZdSuJ7V9rS3o4tMgMa/L
 /rsakNygxiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXGkBwAKCRAbX0TJAJUV
 Vj/ZEACqcEFqs4X3nCWLQ3UkvPUu21OX6QLZgnucuhOQy2j5+YN5KcFbAopZrh2tFu72hZV0YhZ
 BKH00j7k1sah0JalC5y+NP4CVfJiptouXa70dSe5DHUDEgsrV4FBEvsL0cuIs9zx2zFyCTF//7A
 Qzn0quAZeGog51ywahMduGZObO8YbAjMsaBtloLS8bQw7ghNRB8RgihW20v5wjmHGlIJdXuauhM
 7umWswF85EQzZ/yQrXRLRnDjomUWC8R6aRsZiJ3e7oeD3MWzki9bniGavuNXJ+fX/6nJyfbx3vs
 mXbJwTInK/4+jcnb01svlQhMOUf32EMxS9gQH+UWvgZ1VLL4u7WwPa/cu9TnT9p0DGdZUyEg0uj
 OUMXkD0hRL3yyBGFPV1a51r1huH0+JENQqbnCZHHb4hjtz9AfocmZeTB7XKcLv+mhSGLPT6HRCl
 BuMeaGdSNmgBV2YKu7BkUEde2flczzvN4tT7+8LH00alp8aoJLaF8GaQ49GCrStIhQ6/S2x0bao
 tNgQWBYfQQEntMS2UV3o9iBO3w7jVceHxr7gYlCbRuSvrYjcF8lgc+QUMjUq+xnVN/OJBl+9K0O
 OP3hxaTXJzb0vXwlsWm0enJTJtZfhbm2wbK7V3gMlrd613LJ3FfEl+aDOnTBgYwwkuBp3hrOPZt
 m/shR67U6aGSMDw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition for Embedded DisplayPort (eDP) phy type.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 include/dt-bindings/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 6b901b342348..b1a64508d937 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -23,5 +23,6 @@
 #define PHY_TYPE_DPHY		10
 #define PHY_TYPE_CPHY		11
 #define PHY_TYPE_USXGMII	12
+#define PHY_TYPE_EDP		13
 
 #endif /* _DT_BINDINGS_PHY */

-- 
2.34.1

