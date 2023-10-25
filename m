Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6577D62E5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjJYHcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbjJYHcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:32:14 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A87010D9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:32:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c59a4dcdacso17013261fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219129; x=1698823929; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tC6JJTUdgNgXsjFp/FZzs/b7hvPtFbIGwQfQl3rDMI=;
        b=T8s9W9U3izON7HinZWTeJxaeLlIS13In3dGKKNC8aehVg7GgcXNBHqugoOTKZhKn/u
         Zb0tNpqP37MKp4Oy7fih7dWSqXvF4RNqIXWDT7jlpI+0wt2H3B21E2+Ea373j8HocK3z
         wr4EM/eKH+CKlzlYwqZ1EhdTNpc/3XPHglUNjp78cyw0LLIBSSM3EK0brgGNzxINq6A4
         4nxLhv9M+4mXXwCBZ1nPsx0TVubkdE5XmUNHuZspnphE8tG71mt9fvLG0h8F81JD5NZU
         rrAnCXkvdj3cx1c+UHWlzetcHDWa0L7CCqeRYemlzwG1j5ACAKuofdojrTCAeW9rROUX
         1lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219129; x=1698823929;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tC6JJTUdgNgXsjFp/FZzs/b7hvPtFbIGwQfQl3rDMI=;
        b=b12XtEhKdfRF2f+VauJX8Z1J0f7j53RUelDOxvxCjxt0yeNEXwf98pI+aGG6ylk2tl
         bDEPSrbMipITyCGb5Aoq1HzX5t7TZADtj2VCI51ujQ/DOk7oJQslkT45kkelYIlbvTpM
         szqzSZ8IqVZEb1itR730zDVfuhFNRps0Y+YmT+CIFZaY3u/4QnBD1GoJnf57slN+nlea
         xshY4wIQ3GfJqcHJAECaIA/V6ynn2XuNioJIOjdLBQvNYzEO0RrEuj1M4JyFQua3AeLC
         wfl9pXJuDlsOjAshJlgKoF0dJBFJBsAqIyDaR4QZS47l61Y4IXlFTL1Ghabj5vssceVm
         Hy/A==
X-Gm-Message-State: AOJu0YzVcqCCoeKJZdJdFpHl9670UM2zw7eP5gnQj5FyTQElvF31dWPZ
        AKtwTF93dhnKi0ExZZA9gisHYw==
X-Google-Smtp-Source: AGHT+IHV4C0uj5utoNwVjIbvugZqScUNEjbulP1A0yJeHSAbdpOzFPDZneIRIV/WWO1kfY194WV4SQ==
X-Received: by 2002:a05:651c:152:b0:2b9:ecab:d924 with SMTP id c18-20020a05651c015200b002b9ecabd924mr10943814ljd.18.1698219129202;
        Wed, 25 Oct 2023 00:32:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0040841e79715sm14036237wmq.27.2023.10.25.00.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:32:08 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] pmdomain: qcom: rpmhpd: Introduce Power Domains
 support for SM8650
Date:   Wed, 25 Oct 2023 09:32:01 +0200
Message-Id: <20231025-topic-sm8650-upstream-rpmpd-v1-0-f25d313104c6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHEOGUC/x3MQQqDQAwAwK9Izg1sbKttvyIeZM3WHFZDoiKIf
 +/S41zmBGcTdvhUJxjv4rLMBXSrIE7D/GWUsRjqUN8pUIProhLR86t5BtzUV+Mho2nWER8phsR
 E7TtFKIMaJzn+e9df1w8mGpfvbQAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=972;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=cGaLWTQO6nJhBxUsHrUG8AyvDT+o4s7oByi/6V8mpCo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMR2FdB9iMly/tS4axw7w/12HTQ2uO9/MeDHojbF
 E8rv7lSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjEdgAKCRB33NvayMhJ0WEnD/
 9fBiWQ1PZiMgNJCIvhhuUxByqbO8PYZhciYu8bzJwC4n/b13HXBQc82cIsAdDV4QnNk2ZhJEfk+oBR
 tiEje27oUCle6aHmPEPVOhoROg4Db2WhIzVOJ1hbIRoqD8MhW2di7Zzvd3ePybUqmtMkVVlmti/fT+
 bILzVPaGjRbMVii/HmlCuupX1ba7nAS+hjB0lZn0qI96TkhtYBSmZJI9Ut/5RQEg+uG0BpyKN2bZ09
 W2o4icnRRLqPRfZOJ7/OZtTqegzjhzWLfXZuAvlrSEzq+yW63ZJEv4N44Vj34IZurH0VmHQH2Ajckz
 VjAZYdVZSrVRC3q+BI++NvBiQxCd9PV/6ZBRbhF7f72pktZit1n4MZH4wJaxLGpOmJmnmWWYYBr1YQ
 zrmrtvslJLsDUpdBiIlp8fzYgt9FulTT1MBay4OdTR1rwFgb4qNXJut0UESKZEd55pFN4g+f3lCI4Y
 uOS00Fp/p1ffXP6XCXoFp84zFbCvqRJ3i60Tl8y2/B/jkTSHrXdLJGg99qIGVgzXLKnrK5FiSj+yj0
 q5FHeOtrEZ5uo8Vdks6icefAaPLrhwg2hdMz9SXJ+LRVuORSO2FAhzqUnVrAVHHdHwONwWDc3Opq+0
 LuQmWr1mvxAgPunqNMVd4/vE9rLqFuLk9e9QXJnL5xnEG8PQrI3TsG+WBUTw==
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

Add Power Domains and Bindings for SM8650 platform, it uses
a new NSP2 power domain.

Dependencies: None

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      dt-bindings: power: qcom,rpmpd: document the SM8650 RPMh Power Domains
      pmdomain: qcom: rpmhpd: Add SM8650 RPMh Power Domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                     | 30 ++++++++++++++++++++++
 include/dt-bindings/power/qcom,rpmhpd.h            |  1 +
 3 files changed, 32 insertions(+)
---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-rpmpd-4fc0fe1179fc

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

