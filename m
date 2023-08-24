Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2E786C70
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbjHXJ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240692AbjHXJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:59:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79088198B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:58:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so10424107e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692871136; x=1693475936;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+rgGXJccAfkTrnZz6NIgq7I9ljKkcGeoshX/sfo7ve8=;
        b=O+z9N81X1nCXDBq77cUhSfXaGs/bib5UnA/uiRXY5P+b0MDCRujTaeq2j5ZP22Tsfw
         1dXJnMLhDQM8TPXtlJ4xnqDHuF8tOLkYP8pxIon0nPXLNRwxWE+LWTXc0cZK6rNalU+j
         0MAUF2zSfK9VbJX8XsQtNvS5rQQzDL27H3AA/TdxvEJKZ/51XgJFRs5nxaH4LtJfaUJ1
         Q1poXKzo+ifYp1mev1PvilWrxIU4HdILrqyNhfDdhANj93AX4gtNWWqUzOj5+hkJcMe8
         kdG3eFfASoXzmw81O9e+geeG+4HIj6RIHpMoqEINaSYcyQAyCa1vVRthmXpPvMh/eMUF
         aXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692871136; x=1693475936;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rgGXJccAfkTrnZz6NIgq7I9ljKkcGeoshX/sfo7ve8=;
        b=a9ptRqxjB3BDTITNkq+ygwpXiL1cj4o1RtfhjlgYUrLv4z+hyN4bDcNQ88AU/0DCvM
         ss8Ao4MbxmnBG8iMYCsoL72vcfWKJnI58w+3iC7BtCEvLmYIthB2i3cX5APVVJnCsQAo
         aZifPdQz+teOF+XusvW+ypKrZngom/ApIu4IEuszCiBzf3Ews9aMAgc5vav5VW661diW
         vSGImcwOL7IterIphdSuEY+VX4pB8A2nuGstm24Bh5JJLuu5cl3U95BgfwKRveQqvYmk
         I4Gn8YhDZdZNkEnH8j8dQJv76ZOnT7/h4j87oNRxcbjULzkCxnr571WwDzEzh1S64S6C
         FOsA==
X-Gm-Message-State: AOJu0YxVEVgbvMR9WyTBAc+frjkdJtcD/3/BLkd2BE8AmZ2uTyHH1kT1
        5C3U+ETaVIdKmDw5izpfOd39ik0o1GqQmd2DPePHNg==
X-Google-Smtp-Source: AGHT+IHiEtzPRzEqtzTr3QMxhsTvinjjaVpctIY0pcsZrD5AxaMvrORiBuYQNGt4RjSIZR6bcSemUA==
X-Received: by 2002:a05:6512:2354:b0:4fb:9168:1fce with SMTP id p20-20020a056512235400b004fb91681fcemr11352216lfu.59.1692871135696;
        Thu, 24 Aug 2023 02:58:55 -0700 (PDT)
Received: from [10.167.154.1] ([2a00:f41:4882:ba34:4490:938b:eab4:c5ef])
        by smtp.gmail.com with ESMTPSA id y2-20020a197502000000b0050096712dc8sm712301lfe.277.2023.08.24.02.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 02:58:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] SDM845 Xperia GPIO names
Date:   Thu, 24 Aug 2023 11:58:51 +0200
Message-Id: <20230824-topic-tama_gpio-v1-0-014e9d198dce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANsp52QC/x2N0QqDMAwAf0XybKCtCrJfEZHYRQ24trRuCOK/L
 /h4B8ddUDgLF3hVF2T+SZEYFGxdgd8orIzyVgZnXGN61+IRk3g86EPTmiSiI7K2W2xPnQGtZiq
 Mc6bgN+3Cd99VpsyLnM9mGO/7D0Ce6Lx2AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692871134; l=941;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2YbtpY8jgHbBjLwLVzQhDKpuyuDuG/PyOKpPMHiNpck=;
 b=iZmM5iLrEn4rbcMeTkbrqtPzoBCozJ4pa6AOAUeN1cuOYzlemr7PsJygaEmvEvoTE5iUdyB9O
 9gELL6YjX18Dmp15XH1MgQn+Vz+VJ0UfsoLlOK+xqqOXdxv6BgyDHoy
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony provides the actual GPIO line names for most of the pins.
Use them!

(and prepare camera GPIO regulators as a bonus)

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      arm64: dts: qcom: sdm845-tama: Add GPIO line names for TLMM
      arm64: dts: qcom: sdm845-tama: Add GPIO line names for PMIC GPIOs
      arm64: dts: qcom: sdm845-tama: Add camera GPIO regulators

 .../dts/qcom/sdm845-sony-xperia-tama-akari.dts     | 170 +++++++++++++++++++++
 .../dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts  | 168 ++++++++++++++++++++
 .../dts/qcom/sdm845-sony-xperia-tama-apollo.dts    | 170 +++++++++++++++++++++
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     |  91 +++++++++++
 4 files changed, 599 insertions(+)
---
base-commit: 2b3bd393093b04d4882152398019cbb96b0440ff
change-id: 20230824-topic-tama_gpio-2aa115f18a50

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

