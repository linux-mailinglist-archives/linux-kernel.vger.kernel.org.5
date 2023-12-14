Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130B581389E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444070AbjLNRgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjLNRf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:35:59 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B668CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:36:05 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a22f2a28c16so371620766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702575364; x=1703180164; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mne296aPJtU4QgTaZarV9zfnR0z7R06yN21F5bc4Dts=;
        b=CjfBQl2wcqcyZ1n8uat/93pazT4dUGZJ4uB5iCYppKV/LsCIZzpphxxCfoKK7sCxm6
         VAe7eueUH5uYB8EScXXqeieAyibAyVTzaFneJG5UThHBgw7rdmIuG1iWWHMDg2M8v9/F
         2wrOhJo2vfSDkAsm3oOZDOHj0B3rjk9z3v6Iz+pM7YxWaSsFZ71lfsPgmVM5cLgjIob2
         /MUb/Fc6e61uT8byNyF00oZWlU4fkXesl/73AOw9W/e37t8YF6T7OiQCh+SbpG1yLLA7
         THTOaCn6mQU+px45QYGB2jZdwD6u6WlDshLgPz/qex+eK2EJB2PK11kwS8JQUJg7UBoQ
         d+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702575364; x=1703180164;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mne296aPJtU4QgTaZarV9zfnR0z7R06yN21F5bc4Dts=;
        b=A2pxUlRaYTeE/skgmNFwJ9P3DRqpknl2Upi6LO/h4Jn98dxuoi5DMtCHwmjUj3hK61
         0+e7sxkQzJb+BmpjMW5NZ5/NaBepoTnInYlWnv5rW9BLoWR49NnZknieV7Qr8C3V7h2r
         O8ldizEVcWZSXlxxLKYOPeHOGkSXEc4GqMWnbzREzqtV86EpTdfVSr0DZ+nIyh5Q1S9p
         7FCU4izJ47GuGZ45kTYAp7XbFpty8ZPEaayKP0gR9lioHq6FzVYDjBAhsKciukxyE9dB
         LZvlUI8iYc7Ymx+CZRTM5Q41XNIafiZQ3/+BIKwKNe1BuKuM+zhrnGh+EXA6QteVm231
         exEA==
X-Gm-Message-State: AOJu0YwJkcGhNSiK0zPkR0K8Egpfq5SO1hehsqcGaP6UEm8fvdVFzu4B
        9p6FTUKtOxQPMDBDHvL94XOlcw==
X-Google-Smtp-Source: AGHT+IFeRbq/P0rFVY/jZj2F38qeGhn7vCHi5uvfFQGtWJNc8iTb9zwtG5dTkEQUc16IMLebQlhOtg==
X-Received: by 2002:a17:907:94c9:b0:a18:eb7d:9424 with SMTP id dn9-20020a17090794c900b00a18eb7d9424mr3783906ejc.27.1702575364125;
        Thu, 14 Dec 2023 09:36:04 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id vw15-20020a170907a70f00b00a22ff4994e9sm2725086ejc.214.2023.12.14.09.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:36:03 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Thu, 14 Dec 2023 19:35:50 +0200
Subject: [PATCH] dt-bindings: soc: qcom,aoss-qmp: document the X1E80100
 Always-On Subsystem side channel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-x1e80100-soc-qcom-aoss-v1-1-94c46c5182fd@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPU8e2UC/x3MMQqAMAxA0atIZgNNKyheRRxqGzWDVhsQQby7x
 fEN/z+gnIUV+uqBzJeopL2A6grC6veFUWIxWGMdWWrwJu4MGYOaAp4hbeiTKlK03jXd1DoXocR
 H5lnufzyM7/sBmbM+L2gAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Hep+DHPXJuUzQ7KO0AE21Mq91lRuEtDe6OG3PuWcLSo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlezz+VP8l5zwR6k4mCNsMqm2+p7ow3ZpLhK8vb
 wo0TGrWMReJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXs8/gAKCRAbX0TJAJUV
 Vu6qEAC5PCwBaBNdR2gtdLVYHZK9mnqofbsxDHQm1mYOhy+7E7Plmt2GrSqc96eJikFLjJhLLFd
 J8NnqJfnZh12udrLCGlT8hqb+ayjxqxW6zQpC/3IqIxsqPgBwMYop9/mS4lW5EDLYce1y/3SCM1
 gsmOrWJA0LC4/4aYg7+t9BEGJsCvJGRaK12gA+yVVcAxoYiDwM2t2wCciVRrovr/AkDC9bSvH5u
 Dn8phCPODJOroOge5GdS/00IHEJdstjfy/hQteELbbgATiJoWVhwolDll3Zc/6uX4U6dFge4XB+
 dBjSHDe0VhlrCmgRcdhOF1TSQvpKmx0WOdYs9FN/C5IueIV6HufQ/uRTyVCe3HvYHz6CitsmD3e
 /IIdMocyIfX8ztyt9uhESYvZGW962h8AIbBLyxFyOGNqrxLmSCh8V1G9rvtbjmfACC45Iw4ONCm
 zkFywPmqgr7XIU+ytR0WZ0vZ1+V9+WjjOrJUzkthdHIND9HFo3BEQLCZ9LqSL7hNTzc6iO95rfp
 tiuXjkGk859D/r6Qk2w13pymo9U+fl2epmf2Hmx0NvLShTMtUNTko4zVDsDNYUqG03A3z2q7nAa
 iLuhux5nNkK6WPrvBxVKp3Q2kAEUHU7gRJjejLiwBY/XNuYDBmy9iWpbGq5l31oEnue7AJ37tjF
 jfZ9vXVVMAq/M9g==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Always-On Subsystem side channel on the X1E80100 Platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 109f52a0b524..b4478f417edc 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -39,6 +39,7 @@ properties:
           - qcom,sm8450-aoss-qmp
           - qcom,sm8550-aoss-qmp
           - qcom,sm8650-aoss-qmp
+          - qcom,x1e80100-aoss-qmp
       - const: qcom,aoss-qmp
 
   reg:

---
base-commit: 48e8992e33abf054bcc0bb2e77b2d43bb899212e
change-id: 20231214-x1e80100-soc-qcom-aoss-1d2a348b733d

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

