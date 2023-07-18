Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A18D757AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjGRLlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjGRLl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:41:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5CA1BCB;
        Tue, 18 Jul 2023 04:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689680437; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XrUxc4tN3AEMjQ8WNc7/u/QDkgIlwO7XY/SN9uzZz0GcZi4Ql/hjzW4U1pbzq1j6UC
    ISggJq1ohkzxEbbB9nR4KC8drFsA+9AZP31gka0cEqUg8Ad+i5UCSlXBFoPGFfScgkJj
    6zOItKTyyjoO0EAVPDP4TaPV9h2/lwcc3kId4RvVBNBhm15nOILdeQ1vprvWCz51YdTv
    FP60ewdVvkYYKpAkF5f7e0xMFlIKF8dOaiYRrcf+LpX7ftw12o+valewEXVUwhwwpwsF
    VZN/yHbdh1cCO+pVoi+uE76ObAudf+iEGxsBF7ljkXK8adQVzMy2p7WLB9RKDdGN2Gkw
    0q2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680437;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=sK/bMIayWR/eIaIWMCJ3yB3H0xpavoQPeZ0tqsYM7t4=;
    b=kiSsWTcl+xSOZA3gHS6/9lLk1PCHycnJjSR6Mf1Zx9aGqI7vTKSY9dgFo0RXiis0aB
    aABIwMn46OQlw+6rUlQsNAY2szCryBkrIv1hGsvIB/oaM3PgZSnB5salYFj6PT+c6A4k
    GrNdWd3RDnVdsWmHrKWu1SGCSN+qDP/XKWiVCeJovy2XUbBspjmKdsOlxi65y9hZcF1F
    RBJLlw2ESkN5EJFUhOKaA7J096pEBXBJuFsoVkXd5d4/zRAfbsaaiPkGVS/yMhiOAiiM
    xevOH+J/smxHKk7edk3cyWRbLKmzTLomXOmwaNoke9zwiJd8FRiVWhhARRcAyZEbEsll
    kzBw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680437;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=sK/bMIayWR/eIaIWMCJ3yB3H0xpavoQPeZ0tqsYM7t4=;
    b=iUGNDL5jC3ufjlCgm5k5SHWfzXysbyyr5344sKE0RbCvB5QLMhAAKn8iXBPVxc+u+j
    R/fc+Afn7liuJlq9Raq/03KuJN4Q0jjwwZqECVFzsOvMY28oa+xqvL1lkUBqaY+NZ4Qo
    79Glng8RqCrixPZV9JNkSr6ZFJE21Mi5YwWGno2bocWmmHxcbyCn/JczmhrO29KiAXNK
    dF4sKptnY5fbt5xmnnx7hU2PcW9qZnSwMPeGWFhIZAsOTgAMuIuCLNAYHbOI7suF3W3j
    ANEQKm63VKr1ZodQvuS52drqmSg4OhYFvQoQ47996h5IHFrToJzhA3sKi9/sRPSgPcRF
    2oRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689680437;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=sK/bMIayWR/eIaIWMCJ3yB3H0xpavoQPeZ0tqsYM7t4=;
    b=ayBkrkMEbt7KJWw2wvCkQci6INdWNF50gF/nefwYHc5cUFTI1EMPGiSEqBRnr910Kg
    nMO61MF8uzgMv7oWxHCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u45/mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6IBeabpI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 18 Jul 2023 13:40:36 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/6] ASoC: codecs: msm8916-wcd-analog: Cleanup DT bindings
Date:   Tue, 18 Jul 2023 13:40:12 +0200
Message-Id: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABx6tmQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0Mj3YJcC0tDM93c5Jxs3ZSkZENzQzPLZFNLCyWgjoKi1LTMCrBp0bG
 1tQAFvBI4XQAAAA==
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the redundant reg-names and mclk from the PM8916 analog codec. 
Having the mclk on the analog codec is incorrect because only the 
digital codec consumes it directly.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Stephan Gerhold (6):
      ASoC: dt-bindings: pm8916-analog-codec: Fix misleading example
      ASoC: dt-bindings: pm8916-analog-codec: Drop pointless reg-names
      ASoC: dt-bindings: pm8916-analog-codec: Drop invalid mclk
      ASoC: codecs: msm8916-wcd-analog: Drop invalid mclk
      ASoC: codecs: msm8916-wcd-analog: Properly handle probe errors
      arm64: dts: qcom: pm8916: Drop codec reg-names and mclk

 .../sound/qcom,pm8916-wcd-analog-codec.yaml        | 101 ++++++++++-----------
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |   2 -
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |   3 -
 sound/soc/codecs/msm8916-wcd-analog.c              |  56 +++---------
 4 files changed, 62 insertions(+), 100 deletions(-)
---
base-commit: 78b31c16983bb9e540d5a14540417275e6f3f4a5
change-id: 20230712-pm8916-mclk-dbc17169c598

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

