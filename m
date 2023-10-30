Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6427DB64F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjJ3JpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJ3JpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:45:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B75FB7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:45:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so35327755e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698659118; x=1699263918; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gyJ2ZfoiIf2gRHUoNqUiIgzX2BQ6a7wrCVaYe3M0lbk=;
        b=zr5se/dkqHJ50N01XgQRgbhJHTrM0d68DVqa6npRkV8QAI+uXSx8jghtvBThqOBeMx
         ZgN8VT0cXinkO75G1QOgnvQXJmK8YhB4Jj2z9NHqC48I+TvEX5eFkCTb9lJreBxzThi8
         u3edSmzyeqJZV9KQz98dxuxJPSkgOpjSs4+B0WXk0ZY7D5h/ACHlhEKG3cN70z2SPD//
         dBoKknN8BW8ANVXwpPeWPk++SX7gyjLTExPlFA8JSpoRyIo+V1291/1i5zQPNAoRcuR+
         ivIwuXhEokm/5fkaJDJY4OpM1lkwkLfKmH6BZH5J+VdVV1MST/JsPl6NGvN3EQdcF2KB
         VsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659118; x=1699263918;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyJ2ZfoiIf2gRHUoNqUiIgzX2BQ6a7wrCVaYe3M0lbk=;
        b=xMuuaCn0tlRtIkymbADXlHlkY1nP8ppaioAHh0a2Lw+uES3a3kS5tSiIXEGWyCLHUC
         2YhV5696fhETVvLQyBdX5qRceTyyfh4vZncJn/75cDkPyGGy9GpJTbYJ5oVwlAqid5Np
         BairfgfMgH+iv5nNyH45aFqjOeSrhGnpNOTrmsDX20IUxRPBvY4GGz4ecJY4a+nImxJH
         ZdI8NyzEbOpaTeQjt2DnEz0dcc3+FlAW2OanbpAj+BPDzU13pKkVjj/Hefjd2XytQDdH
         etM70OK+azU4kklqh6hUn92ufOcGm8+LjvMRc3KLtdHj0lo20SY9DPMuxIAjfwntUwir
         Kn0w==
X-Gm-Message-State: AOJu0YyjuIwZ1MAYoWmEtB30p3nPRMuZGdw4yiApsM36EvKSL7+ETYjG
        kGorSWZwVPly827VtD7WTQOP8w==
X-Google-Smtp-Source: AGHT+IGK/ro2NJZsePhHY/ctJ5495WaH0j6Yl4ZTn9nkxVBImG5nHYWWFXH/Zq+B93iF2rMi+m847w==
X-Received: by 2002:a05:600c:45c3:b0:409:400f:25bb with SMTP id s3-20020a05600c45c300b00409400f25bbmr2804430wmo.31.1698659117744;
        Mon, 30 Oct 2023 02:45:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a10-20020adfe5ca000000b0032f7cfac0fesm5069446wrn.51.2023.10.30.02.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:45:17 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] soc: qcom: llcc: Introduce support for SM8650
Date:   Mon, 30 Oct 2023 10:45:13 +0100
Message-Id: <20231030-topic-sm8650-upstream-llcc-v2-0-f281cec608e2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACl7P2UC/33NQQ6CMBCF4auYWTumHWlFV97DsKilwiRAyRSJh
 nB3K3Ht8n+L7y2QgnBIcNktIGHmxHHIQfsd+NYNTUCucwMpOmqlLU5xZI+pL61R+BzTJMH12HX
 e47mm0vqTMVYbyMAo4cGvDb9VuVtOU5T39jXr7/pjyfxjZ40K764w1hKZgoprx4OTeIjSQLWu6
 wduTmjwxQAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=In1y6EYqhqqG7srFnzaQ7nv0zveGUp4wFkeC/74fokY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP3srtC54isacuvty+dUeCoKME9aOPRjR6xfwYlFK
 gVyDkkSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT97KwAKCRB33NvayMhJ0bJvD/
 9w0amRv2M6R0VIt49IbgRVX+/585TcbKPdzbiEyW1FCSHpeD4LgavxDbn3bIhtiSoiLW6yCSM6CokS
 JJrq5rSN37QCqVEYQb6u6cy2naugQMI9CSfYlG64U1YXbrwXgSo7wCh3oGLlkguco9x4MUCn4R2gK0
 pZG4/mwLXvU3u+2KqhiHrTzl2LZa22tzET98fx488YezBsbPFS5KHhTHYFKdLBmWWLQT/+/WLG0Qtw
 KR93Eh0kwp6KmU2DTXY0/KxbZ3VZ/D8eY+HvXE0fsy3C6zUeBwVTnPF36C+P+QsxTaPBX0eTUjca5k
 fshdPsOL3wtpkXYIyjSxYhk9xD6YE/ZVBSfB5a3piPRDd+rrue782DRaWbz9FMY8fUzwhDo0LsJ7zk
 16mZxgiVq5M6DOSFJgT2lzNWDZg+B/UTg4IpADnpLNKX/G0SnUUxLLkVhDT6l9cOnia8/ootkIMS0h
 W1wsb/HY82m3zMID4nNwRbG2IZxD5cuN6It7s996y9GL5LlsldE4ZdGURPSvx7bwj1eIVerNsV8ijI
 kDFmgE93phTXDoe6Yl3guQRrrxFJfTqVcLn9B879fpViFCAt6GSIZtk7cDH2+3TRpW9pLlNqR0ZdhL
 6mK8UnXFtP7UGVt4K3ODo2Oz170ZcVz7AuVjC85h3uzZ1xloP00bkPJ8Vdaw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC tables and Bindings for SM8650 platform.

Dependencies: None

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Updated LLCC table values with latest vendor changes
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-llcc-v1-0-ba4566225424@linaro.org

---
Neil Armstrong (2):
      dt-bindings: cache: qcom,llcc: Document the SM8650 Last Level Cache Controller
      soc: qcom: llcc: Add configuration data for SM8650

 .../devicetree/bindings/cache/qcom,llcc.yaml       |  1 +
 drivers/soc/qcom/llcc-qcom.c                       | 43 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-llcc-9d286c755615

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

