Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48137D3CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjJWQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjJWQyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:54:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24189E5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:54:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32dd70c5401so2461896f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698080056; x=1698684856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LzNpmNp+fktKwDMwK/gxOQWv1rtKi9BTRrCYzOlHcaE=;
        b=A7AV2tFv7ot3ee9gcjpx3TlBlJSO91PYfoWf/ZdnEF2ofTzElWXG4keTd1RKZftTQP
         tfwj8yiXiQiQ7WEN4zdPzljsejXaBd1YODNMJ2MR4Kun7fbuQRtk2cAoPJyaOtKC7xAw
         q7d6wdS4+Ldiivem3qb/WhqBQptWpkrqYz8VLEQNTWfPeH8zd5zM6S5e1EKyhnVxlLAZ
         nW6D570f+OYwfrqMhuSuT0sPMEAyvBUQz6EfqltJ4oc7l24qxbFDIVachFH+npOGlm2r
         USMVLy3yeK659FEYe9epvsJ0BsVwPL0kw+ELi10r2lEvpExivkALeabB/b159olXjiH4
         uxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698080056; x=1698684856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzNpmNp+fktKwDMwK/gxOQWv1rtKi9BTRrCYzOlHcaE=;
        b=sjgHB8EOzbqulmvvUdrcAfLZfDD+/j8eo1Kwf4QVbruC9I4hZrD3ngMznCWxqPcP7L
         r+BH2ziDbC7wqlbyXH/mtgQgDZoMwGYIydeH9IMKCNQ5j37ICI07Cc9okqPCJZYQQJ3e
         u8x3G9vrd2nvzEROMeottuXRIs5dMJuBauHx/yqlRwtG4Tn3KDEZEK1lZG1TtDBy8AKu
         xiN8TRiwOy5MbKwq+obYhtc8LR2fdlGq/7xFk6gNmMyytGph7ggW+AAzszMacBs8N89w
         dt4Y2MkgJ0KgzFwoviYFcq46sgWdMYisNYFbjtR5VKnCDUHZEsfvOaV+v79VxiPSMHjS
         ztdg==
X-Gm-Message-State: AOJu0YyAzQp7GEVLeHNCrKWE0B/Pw9sCrsSQqqy29KdVe7rMor1TAcXI
        /VdR6t2BV8csNG/MQlYQQm/ntXQXF9BUJ7bLtQE=
X-Google-Smtp-Source: AGHT+IES5Wh57HTX5V9DwQtvZnwriBUWvgP62B1LNyPFJZdJp0f2V2qI1D3EsrezWHIvfB2Wc7zBQA==
X-Received: by 2002:adf:db48:0:b0:32d:9d80:4038 with SMTP id f8-20020adfdb48000000b0032d9d804038mr7071732wrj.49.1698080056571;
        Mon, 23 Oct 2023 09:54:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4c87000000b0031980294e9fsm8097709wrs.116.2023.10.23.09.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 09:54:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] arm64: dts: samsung: second pull for v6.7
Date:   Mon, 23 Oct 2023 18:54:12 +0200
Message-Id: <20231023165412.529762-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just one more patch on top of previous pull request.

Best regards,
Krzysztof


The following changes since commit f28dde395937e000585ac87c0d1c18885661161d:

  arm64: dts: exynos: remove unused TMU alias (2023-09-14 10:03:47 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-6.7-2

for you to fetch changes up to 23e4a49943624dd83199989c852565a3ff760fa7:

  arm64: dts: exynos: Add reserved memory for pstore on E850-96 (2023-10-12 22:01:49 +0200)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v6.7, part two

Add ramoops reserved memory region to E850-96 board for debugging
purposes.

----------------------------------------------------------------
Sam Protsenko (1):
      arm64: dts: exynos: Add reserved memory for pstore on E850-96

 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
