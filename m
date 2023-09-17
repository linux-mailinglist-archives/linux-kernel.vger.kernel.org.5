Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118997A35A6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjIQNRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 09:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjIQNRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 09:17:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3B912F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 06:17:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-404539209ffso36559575e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aceart.de; s=google; t=1694956629; x=1695561429; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mgpgf51WlJtHJV0Rp4UXo+NI5qfPAJ/I7UubaP6q1W0=;
        b=HSAn/xV3NFP79uUDNIRz1ybJZCEfgQKNnYdZKck835lpjI3KWZFAKgCi/ES2ivJEOO
         bIbzPUPQSsPlwIDTN1ysE53v3V3/2rGqBCNb+JDQsfikQoS6TNgiuTOuX1viX/jSUSDk
         czmARCwXjXJ9dOaSPwUI5IGl0ZBTP5gEo2xvW45NPRF6FA4DGGbI3goCs5FZXcxifyKB
         CyfjxoDA7T2eNtbaoD1j7iXAWSYNSp6LR5p++35HRjSji2ClbU30z4pttcR3FVsIvs3H
         2MEVf5/Tz8d+iKHNM8UjH1ZTLtE/p+vlwKmMiAokwG5DSvmlsORiM+JrLHiwO5WT8TE6
         8bTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694956629; x=1695561429;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mgpgf51WlJtHJV0Rp4UXo+NI5qfPAJ/I7UubaP6q1W0=;
        b=WzKltm4IiSwBiCKgtjwV2QTy3eXL3W6S0khsIbvOoWE8pTM7zLefCem9zSynJEoo/y
         kmr5waS5N0+XBKHx68ctY5Gae2GfTa5RFoqcH+gV2JSSy58yAQjCdMTur2PBzd9JMhDy
         6LimF3esEb7uNdrRww/7zZTWylF7UE2dlv1gkL7UbNkoK4ULAUWCMqdnLsf6Hczag3u1
         QIHVhHFuKrFEjCoFABRV4mLRy72iTaUyFZOhtk7E5zDF22jx6AaK2z3qcQtNcH+FXBaF
         bomLhZI1whhV+dqGzSYNTCmpW/OpWv5LOEFZQeZOUkRcaXO3zrfJD4MKgoNC7ej+z6AL
         q/Uw==
X-Gm-Message-State: AOJu0YwqdvqwMknYqLZz15w3XaVd3nUd7wHxEavKvEb0PF2EWe+pdY+h
        NyMFAgsXBcFqbX2mcpS3GaWFkQ==
X-Google-Smtp-Source: AGHT+IHbddY4ACq7Zaot0S6FIVRIu0s/oobjuCpymDfmDT0A3OCnmkbaFe1yKVSrYn7lFvxvXBA0gw==
X-Received: by 2002:a1c:f30a:0:b0:402:ea96:c09a with SMTP id q10-20020a1cf30a000000b00402ea96c09amr5889645wmq.16.1694956629493;
        Sun, 17 Sep 2023 06:17:09 -0700 (PDT)
Received: from ?IPv6:2a02:8070:d84:9160:acd3:26fc:724e:a2dd? ([2a02:8070:d84:9160:acd3:26fc:724e:a2dd])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b0031c5dda3aedsm9779189wrs.95.2023.09.17.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 06:17:09 -0700 (PDT)
Message-ID: <c8168e781f3fc55f594f0c85501c480db5176497.camel@aceart.de>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8939-huawei-kiwi: Add initial
 device tree
From:   lukas walter <lukas.walter@aceart.de>
To:     krzysztof.kozlowski@linaro.org
Cc:     agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas.walter@aceart.de,
        phone-devel@vger.kernel.org, raymondhackley@protonmail.com,
        robh+dt@kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Date:   Sun, 17 Sep 2023 15:17:08 +0200
In-Reply-To: <bd833cee-2349-368d-93a4-9465ebc8a0e9@linaro.org>
Organization: aceArt GmbH
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


>Order of SoB is unusual. Who did what here?

I created the dts and they update the model name. So it should be the
other way around
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEi1ngOOsyNO1iyMXiY16HCsLx2zUFAmUG/FQACgkQY16HCsLx
2zXbug//cFZNScSBr6k1I4tHuthR2+CFhTqOO0x0EqMa6W+l96s7ZimJA8UGq2jJ
F+4BZHujtBlpd1p4bE/GMDERy6MMHmAW7/N8kl3dEfwErwvjwML4nvDLRSC2Movd
93MNJ+4tncTndMLUEyARUUg5sP6Idgc/83pMRzKn4toFxWMHfWPFHy5XlNLDjJT5
/BuvYlbAFpme9ZavTLMGtalOp6ovsS1qNRrNk/CZecV+I5tCVFs4ZbzMHf8vKi3/
B7yObHRsZEdy80KE77kedgyBlGWu0/Tvu7xrK2qZxawkbraLBn+qE76wCmgk91qg
7EheFFr30v1LuudZbA+5fOE3qC13u3LbmCaRwwKAC8S7C6OgMM8Vcg08rPdaaV10
m1MDSPgxddA/TitQNz3epvFahpm1WWuGhR2xihDP/r345kogUYcRiLw4eqIkYKjb
64Wgalclq8XByymGLndYuoBaR31wauOjCtShiHByRTp86XTWh9C+KJ2wVGdE2UWL
ok+qs1hrao328+FtgtZn7FxnmO2yLA9I6xLeEPgTSt5VSZ9NWpRNQ5h61AYDEaZV
YPy3cTJV5VN5Mrp6dul7bT/Ti5rp8tCH5zk6D62WTSq2xEzkDtjnE1DKzr2+0KNt
c2VZQGmquTiTotnQF2c4E2M9ONd+TxN9sn0dYqwwZa0BLEI1JBk=3D
=3DF2cY
-----END PGP SIGNATURE-----
