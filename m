Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063607B4BF7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjJBHAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbjJBHAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:00:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D818FBF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:00:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99357737980so2237858666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1696230017; x=1696834817; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4mI7wPjfIFJjRgS4m9j0vBzf0bhNyvH1PWkrNn+YUw=;
        b=KNhAsxmL87TmGWjswS8Q41/DmigVAE4iZak/ipzI/ysf6WxNXOLgZ0txZLG9x6Mke+
         SjvQMv3FjAsZGfWP5J4L6bZyHHJSlhsdELtr2OcEaJUbi8+fyCHDZD7v/t2vOHH4Qlm6
         tQLWabA7cOcYK/sSz69VcHWkh+GkignjqbuyIhp+ZwXscx+iGEomGn68DYqIV9Mp/7N7
         vYZSXrzEqGyERtvdZIZgsipgSMV0Q1Fkez5q9hD48xJbrMuf0Gjzk5XprmzhrtuBLjs3
         HHHh+Rf72qoV3Vl1duKMhnoStvYCU3RGL/+vdFAr9TC5uFOG27NMxutOqhQoN0AgySsc
         AqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230017; x=1696834817;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4mI7wPjfIFJjRgS4m9j0vBzf0bhNyvH1PWkrNn+YUw=;
        b=kEunI/jMy+/OUI1K1sDZcbVIJPDtkIZLengzP05FmfTjvwo1BPmppPVhNDqUnD7t4q
         ctCqYT9DKAS1lD5lLcJT4xVmc6UQGTJVJ+L5QhMHax7uAQTMoIrhAsP/0ZMl/fdGc1sK
         w16WWr+MXUIP9145SPol0O2hDoND/dee430vyQTiFJhvLp2aU4jFWspnGLV4y6zHji+8
         qfwgtjSoBErJAxbv7Wfnk0VbNcnjMV53EkAI1OPmFeVzrxSwFZyP0erzySmFqqBshT7K
         D/efiyCCc3KCMwZSy+EcPPKG7TncUysLtBVlC8ETfcSnUBNY1nfVQ441kF7oznEWBeGW
         kRVg==
X-Gm-Message-State: AOJu0YyTYXW+C+snhengX6JDoY9xWEuKT+wk/85lx7tNgpdJcyGchBge
        Q/a36zGSQlykCrI72GCx8sWT1A==
X-Google-Smtp-Source: AGHT+IGHstSSOjwQORJoy/Ro5XBc08vqCnp7VSvvKVm9VrTRh96OXqE6aYHnx6tEAm9+uPnY2S3fOA==
X-Received: by 2002:a17:906:3116:b0:9a2:16e2:353 with SMTP id 22-20020a170906311600b009a216e20353mr9427422ejx.6.1696230017331;
        Mon, 02 Oct 2023 00:00:17 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id z10-20020a170906714a00b0098ce63e36e9sm16692013ejj.16.2023.10.02.00.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:00:17 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/2] Small updates / fixups for PMIC spmi-gpio
Date:   Mon, 02 Oct 2023 09:00:10 +0200
Message-Id: <20231002-pm7250b-gpio-fixup-v2-0-debb8b599989@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHpqGmUC/32NOw6DMBBEr4K2zkbGmPCpco+IAswabwG27MRKh
 Lh7HA6Q8s1o3uwQKTBF6IsdAiWO7LYM8lKAtuO2EPKcGaSQlehkh35tZC0mXDw7NPx+eTRKNER
 dq2Q9Qh76QLk4pY8hs+X4dOFzfqTyl/7VpRIFkrm1tap0OVfT3YwcvHUbXbVbYTiO4wvnuraNu
 AAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the schema to use plural _gpios label in the example. And fix a
dtbs_check warning in pm7250b.dtsi.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Remove labels instead of updating them in documentation patch
- Link to v1: https://lore.kernel.org/r/20230929-pm7250b-gpio-fixup-v1-0-ef68543c1d3b@fairphone.com

---
Luca Weiss (2):
      dt-bindings: mfd: qcom,spmi-pmic: Drop unused labels from examples
      arm64: dts: qcom: pm7250b: Use correct node name for gpios

 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 +++---
 arch/arm64/boot/dts/qcom/pm7250b.dtsi                     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
change-id: 20230929-pm7250b-gpio-fixup-f407ee98425a

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

