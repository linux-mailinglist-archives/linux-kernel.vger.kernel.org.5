Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BEA77B644
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbjHNKOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbjHNKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:14:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0003810D5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:14:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991c786369cso555698166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1692008058; x=1692612858;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OaliXMOmH9SU1C2DkaplWarCzA0RpYIWvO0eSAY4J5I=;
        b=vhCN3qS28z+GMKAMta2CsJCod5E7MyhhhaMf8cj9l8nCIRSTLPjLvlnMVZEAmZkgZC
         yKZrsq0jgS11wzSOqKQh1GTzxApFlOVH/VwbQ32oInbjMF6eDt8eC6pH0Z72biW/Bnid
         aHu5GAx8MzjyGI0j8xBURqGZyfYML1egsi2pHUNiDqqBHm/Zka0fL6Bya2jjdbGuKZb0
         KR6hRXDM+ZaSXYLvb5jkxxYHE892EGSjXnxtoTMYwwi5s2KqFzbplyidMBAY8v/xkY5z
         tzwOTnhRjdDlrRGRU+iSYJFhzv2KbqrgFh2zsNlv3Z/dCiDdrcX3yp10SJkf2DswHOEQ
         1IxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692008058; x=1692612858;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaliXMOmH9SU1C2DkaplWarCzA0RpYIWvO0eSAY4J5I=;
        b=jhPy8F64fmsqEjOXRhOKftdQQJWALtejtWc9ChITAtCXgOMZL6hCaCsV4K4Ftc89Q7
         EV+BCONO8r1Hy58SDsZTSlx0U2EAVzyISJzEhIMJt5RyWgcriODMJyBmwi1WCp0+gWkv
         tl+QgqlSUZVrxr+nY/jcCoo+TZHYwwJpiShF/ZSr6AxkW64cF1gF0XPXexWWuI5Yupil
         cI5a3CY4jg6mGPARlFLlBVzctikI8kenX7AtYos0D99HhFL6u4oFhkCTkgOx+Jjd/8Kq
         qsczi76x9/dAAQXWDgkCny3xdRp1eglLrtzGBzWuyiyTE2H8fwqg5N/aYeu4onRL+wFq
         Pb+g==
X-Gm-Message-State: AOJu0Yx3r33wU9jyMFiAbGfC/pGxa29W0NR26AtZIipqPDeKhgoQi3W0
        im9bxbCF5sHrnVzc8p/MZnpipg==
X-Google-Smtp-Source: AGHT+IFAjrefQcQM3SmBv83W2ILzm+6amDEF8zNjt221YcLaHgS5StgoYPz3Ya4i5UynFBXurtVucw==
X-Received: by 2002:a17:906:2ce:b0:99c:aa43:b20c with SMTP id 14-20020a17090602ce00b0099caa43b20cmr7183610ejk.33.1692008058483;
        Mon, 14 Aug 2023 03:14:18 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (212095005216.public.telering.at. [212.95.5.216])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b00993a37aebc5sm5472870ejb.50.2023.08.14.03.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:14:18 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v6 0/4] Fix some issues in QCOM UFS bindings
Date:   Mon, 14 Aug 2023 12:14:12 +0200
Message-Id: <20230814-dt-binding-ufs-v6-0-fd94845adeda@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHT+2WQC/33QzW7DIAwA4FepOJfJGAilp77HtAPB0CC1pII20
 lTl3Wftuiwn/0j+LPstemoldXE+vEVLS+llrlwMx4OIU6jXJAtxLRAQFYKX9JRjqVTqVb5yl0g
 uD8Z5lzMKHhpDT3JsocaJx+rrduPmVPpzbt+/SxbF4fNfb1ES5IksYIakOLnkUNpjmmv6iPNdf
 DG34D6BTFB0AczgvXV+i9D7hGbCeE98lQ6g4xZh9gnDhDIx0QBZkxq3CLtPWCaiD/YUIVid//x
 iXdcf5L0meMEBAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Rob Herring <robh@kernel.org>, Iskren Chernev <me@iskren.info>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to solve the dtbs_check errors from the qcom ufs
bindings. It has changed in scope a bit since v1, so it may be a bit all
over the place.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v6:
- Rebase on linux-next
- Drop applied dts patch
- Pick up tags
- Link to v5: https://lore.kernel.org/r/20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com

Changes in v5:
- Convert sm8450.dtsi to use qcom,ice property, so stop modifying schema
  for sm8450 and only add qcom,ice property.
- Move reg-names names to top-level with only minItems/maxItems in the
  'if'
- Link to v4: https://lore.kernel.org/r/20221209-dt-binding-ufs-v4-0-14ced60f3d1b@fairphone.com

Changes in v4:
- Pick up tags
- Rebase on linux-next (again)
- Link to v3: https://lore.kernel.org/r/20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com

Changes in v3:
- Drop applied patch
- Pick up sm6115 patch from v5 https://lore.kernel.org/all/20221030094258.486428-2-iskren.chernev@gmail.com/
- Rebase on linux-next
- Link to v2: https://lore.kernel.org/r/20221209-dt-binding-ufs-v2-0-dc7a04699579@fairphone.com

Changes in v2:
- Add new patch adding reg-names to sm6115 & rebase series on top of sm6115
  addition
- Fix binding example after sm8450 move, split this patch from original patch
  since it became too big
- Move reg-names definition to top-level
- Link to v1: https://lore.kernel.org/r/20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com

---
Iskren Chernev (1):
      dt-bindings: ufs: qcom: Add sm6115 binding

Luca Weiss (3):
      dt-bindings: ufs: qcom: Add reg-names property for ICE
      dt-bindings: ufs: qcom: Add ICE to sm8450 example
      dt-bindings: crypto: ice: Document sm8450 inline crypto engine

 .../bindings/crypto/qcom,inline-crypto-engine.yaml |  1 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml          | 44 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)
---
base-commit: 13055cce6d3df0a2704721d6e2fd9011e973f53d
change-id: 20221209-dt-binding-ufs-2d7f64797ff2

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

