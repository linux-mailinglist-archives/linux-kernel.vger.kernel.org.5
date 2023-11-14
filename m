Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3037EADC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjKNKPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjKNKPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:15:00 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B420F1999
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:14:50 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083f61322fso42364585e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699956889; x=1700561689; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lP4pwuRhYTWCh+6fGIMGYIpMuMAg/mVMsSJit6b5kb8=;
        b=oLtoOWIXAw3FMxU0H0pzUAmInplyB6DGTep3pwcdOw18QhdoMNgz5QUhwGw7hEpt8n
         K7FoEa0Wcwrprj3g7R5605eC2LHAR06w4XuUWM6RAJAxFzmegrsMYwdjJM2IfMFq1/qe
         AR+K6bdDQ+U/kx2gVMny27Cg5pfuGIc6SK87F1lo1w4QhDoyZE2UGwyDwGm/LsHddwqI
         y8Uvx0Xojd1VNE7d9V7cST6sr1YesPkbcEoYzslyuoGHB4FPD9gAWbN4aPz9VdgEe9mE
         TpaMOR7xi+KeMnAJQqORI7xO3vU5iqo84Tb4P6ARoB4gR6ibukfRZpM21OvLZNN7yMhL
         90+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699956889; x=1700561689;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lP4pwuRhYTWCh+6fGIMGYIpMuMAg/mVMsSJit6b5kb8=;
        b=kPUWnWvOUeWE8M8E262MM23MtDznA33PCSBCgRcBOkJczAwiq8Q3bpZDhPPs2na4B5
         dIO6lkLbtmNjEmLItNXfUI1da9cNb3Kh2zUV0a9qrFpj3o86j6ZFx3rAI+I128vWdS9+
         Tlaee1W8CcRERyHJzy1HfJfyt34V91vFQHxtkax5EJVTwl873umGdYdg2TYfl+2J7JP1
         5SQPckdc/upFD4dDbqwBlHtZ37IfJs9oZJRkixSBZznqtMVeDQAyTadrHYFrtGiCJDso
         snn68VWyHLpSagcLlNIl2zaQn1Yq8IsO+eHMSJd+iCoUEX4V0oWL5u4piJ/khY+haMxf
         ehsA==
X-Gm-Message-State: AOJu0YxTwm0Xj5VwaD7NU5ER69U6muuyW8/25juz+gl9EfXlIwBxN6V8
        xVosFzr3Ob/+mAqwvFz1J/pN5A==
X-Google-Smtp-Source: AGHT+IGjhN6RX4rBNlnSxxeTha7OzGItl9ZV7rvJ03XS0hXAK5QeQ/02Q4ADuftfGRyfvnxSbKrlPw==
X-Received: by 2002:a5d:4dcd:0:b0:32d:aabf:1db3 with SMTP id f13-20020a5d4dcd000000b0032daabf1db3mr6480680wru.24.1699956889056;
        Tue, 14 Nov 2023 02:14:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4202000000b0032d886039easm7335585wrq.14.2023.11.14.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:14:48 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] clk: meson: add MIPI ISP & CSI PHY clocks
Date:   Tue, 14 Nov 2023 11:14:42 +0100
Message-Id: <20231114-topic-amlogic-upstream-isp-clocks-v1-0-223958791501@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJJIU2UC/x2NQQqDMBAAvyJ7dsEkbal+RTws6WqXqgnZKIL4d
 0NPw1xmTlBOwgpddULiXVTCWsTUFfgvrROjfIqDbawzxjwwhygeaZnDVLhFzYlpQdGIfg7+p0h
 k38+WXs6NDZROTDzK8X/0w3XdoJthzHMAAAA=
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=904;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PwjQ/DLZqY7Bxq2AfQoR8M0lM8zWRFZSzmKQH+USBu0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlU0iWvHW+Rz3HPpK51JzL56QxmMmGAg9A3MUNWjOQ
 APjxiOCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZVNIlgAKCRB33NvayMhJ0bXRD/
 4l5mSNoYLtkeq1lLfw7E9Ryvnyt5Tg3UaBv10vi18Bi7AZYtmC2+stFD0tdIY4km6Yy8lQlte0W30z
 Z0EoD2SavQ7+Z39dhPXQYeufPMBhDiAvXAIokLI7AZ78Y31GRSK1J26AOkRHrYualoa+MCJo6zpKTU
 AcBHwUpT+QYIHue2dC/XnNMB5xKeHfMF245eGfcAE+CaCKG46BmdNwcgRn+36esq7l398kxAug+U8f
 /m2gRnXEtpktrflsqrnjm0c3ZCInq+nAVA2bMydBBslDs3NjTnzoxFIbL4n4ZJyqn9lK8KDz7uflql
 l1qA4uC6rbi1FSXF4aUGp5JO7U9fM9IVAPQ8epuIus+DT+OkuDhq+qkF9vSGNplKBvm6RM8qb2/r26
 PwNKxDJMrV8foZE8utygOT8hclPcJMbblh3sF6aLklWIvXSxjYVN4+fr5Cj43A26dSICZJG2gomlN7
 Z0z70S72g6lSjcBwr5vmVOe4US+MJitfAGaw+rlA9NZawz1+PzNLoq2sFxhWe/IwCWp+21Rk+H5S/4
 G4wQAtE1H19tA49SyQ/YgFXPEfhkt7XEdP+F1kgyEEK4mww2VlTFYMvx+xcYfWzYi+1D3xOmu37EAC
 XqzReZ3CuG/YJhJl+l3SJq80dVDcgvIub+ItE2KqS8Ml44txcX63tNuv4RNw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIPI ISP & CSI PHY clock bindings and entries for
the Amlogic G12B SoC.

Based on the CTS_ENCL clock bindings patch at [1]

[1] https://lore.kernel.org/all/20231109-amlogic-v6-4-upstream-dsi-ccf-vim3-v8-1-81e4aeeda193@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      dt-bindings: clock: g12a-clkc: add MIPI ISP & CSI PHY clock ids
      clk: meson: g12a: add MIPI ISP clocks
      clk: meson: g12a: add CSI & ISP gates clocks

 drivers/clk/meson/g12a.c              | 75 +++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |  1 +
 include/dt-bindings/clock/g12a-clkc.h |  6 +++
 3 files changed, 82 insertions(+)
---
base-commit: 71ea46af56818a97cb5ea5d6554a0f10ea624d6d
change-id: 20231114-topic-amlogic-upstream-isp-clocks-aa2859a633f0

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

