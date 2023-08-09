Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FC27769D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjHIUXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbjHIUXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:23:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E552103
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:23:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso1599535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691612629; x=1692217429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2DximsJWOMVIoGnB96qhZq1Yh39vcR2POpMx/oQPi2M=;
        b=gPgp6IDHHjbSuuyMk5QrE7vOdsBlr/T+vduXsYhapHHZITIDvxDFh0BEm3+tdI8Gjq
         YeQ7BREykq+P/QGFNFXM3Jj0RkML2bDHNuVPQP4QFF1OXNQorxZoUCkcLeHQmk8UGHuM
         J5HTWpWh+aN/Iesp4RtordniiPPZgQ7VLzqjkYweJKXTMWQ6vrEu29XQkflKf6uzV0wd
         d88ojICUuQ8DmO4Q67Lkx5+NbHQvvZmtpFxNAsojPiwa/tzrPhPHHDPy82hsdgcrSGJM
         pKuMwTML9AgH+8sPzWRWz9Qv1voMchmOFRgXdEvuj1HBA0K78yKErs+oKX6Fi90W8pkn
         ZZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691612629; x=1692217429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DximsJWOMVIoGnB96qhZq1Yh39vcR2POpMx/oQPi2M=;
        b=PZjVwlo7g3+R/XLJe/JOY+womleyJ82vekpvkOZs0zhVmS/tdTvFh5g0ODZskQ1P/E
         +hZlFlQDIi3/YW+wiSvAcVJgxugI/Ifnslu6wKCVHaPl77445TEe9Be5OGxQjEgyDhiV
         SuEms6tMTWIhs2YnJeCjK8/Ihhw6pnAX5mr0fjpMaubNSYtHk1hm2Ct6Bbzpa366GDf+
         bksK7hWDOky0n0wscfxsL491ZodamEkuZ97ST/WuVZeAm0DuuDWUXxfToGHdjAMeuAOq
         v2lbUAaVdUDMQwraKSqp6721LWp8WuOj3GENxmYGar7wIudOTOiw67ksCWq0l9vTDDfW
         jm+w==
X-Gm-Message-State: AOJu0YzKjW2kd6o85/w6GF9F+Ysad2eq8yllzIxqrRQQ7WNAM+rTHo8c
        wps+kguQLKo5gdtg3HJt0DjDxw==
X-Google-Smtp-Source: AGHT+IGzp+md8YZSNVNfxErMWy63hUNjXxvGD0YgUJ7giJITYGUt7XI0MaArI1OKYf1wcRcsCFpabQ==
X-Received: by 2002:a05:600c:260c:b0:3f6:91c:4e86 with SMTP id h12-20020a05600c260c00b003f6091c4e86mr151830wma.3.1691612629090;
        Wed, 09 Aug 2023 13:23:49 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c22ce00b003fba2734f1esm2927509wmg.1.2023.08.09.13.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:23:48 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, loic.poulain@linaro.org, rfoss@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v2 0/6] apq8016: camss: Update dts with various fixes
Date:   Wed,  9 Aug 2023 21:23:37 +0100
Message-Id: <20230809202343.1098425-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2:
- Adds R/B - Konrad
- Adds newline as flagged - Konrad
- Squashes patch#6 into patch#5 ammends commit log
- Following up on TPG comentary:
  The CAMSS would not have populated device nodes prior to this series
  save for the case a user had a D3 Engineering board.
  Splitting out the sensor from the core board is correct w/r/t the
  hardware/dts since few db410c have the mezzanine.
  Once split we can enable the basic camss node by default and thus get the
  TPG going for both the mezzanine and non-mezzanine cases.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts-v2

V1:
This is a series which updates the apq8016-sbc to fixup CAMSS support.

The first four patches fixup the current state of the ov5640 bindings for
the apq8016.

Following on from that we move the ov5640 sensor from the main apq8016-sbc
into a standalone mezzanine dts with an accompanying patch to enable the
sensor by default in the mezzaine. This makes sense since the D3
Engineering camera mezzanine is but one of a slew of camera mezzanines we
can attach here.

The final patch switches on CAMSS in the core apq8016-sbc allowing us to use
the test-pattern-generator TPG on apq8016-sbc with or without a camera mezzaine
attached. This to me is a good idea since it means we can test out and
verify the CAMSS on this board absent a camera mezzaine on the main apq8016
board.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts

Bryan O'Donoghue (6):
  arm64: dts: qcom: apq8016-sbc: Fix ov5640 regulator supply names
  arm64: dts: qcom: apq8016-sbc: Fix ov5640 data-lanes declaration
  arm64: dts: qcom: apq8016-sbc: Set ov5640 assigned-clock
  arm64: dts: qcom: apq8016-sbc: Rename ov5640 enable-gpios to
    powerdown-gpios
  arm64: dts: qcom: apq8016-sbc-d3-camera-mezzanine: Move default ov5640
    to a standalone dts
  arm64: dts: qcom: apq8016-sbc: Enable camss for non-mezzanine cases

 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../qcom/apq8016-sbc-d3-camera-mezzanine.dts  | 55 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 40 +-------------
 3 files changed, 57 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts

-- 
2.39.2

