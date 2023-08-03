Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF61576E996
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbjHCNJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbjHCNIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:08:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806933AAF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:07:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe216edaf7so2588138e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691067934; x=1691672734;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWYA704UWyrCuVl2IVzrHz3n0S97k5VTTL5u48g6ZTA=;
        b=e3geX4m1ZZORMkJo5JTDAM+hn3WhVYbMmVHOQ05ESi/RbDn63S6kae8cPpi585t1dh
         3CAXQhSIZQfLK4Qz4FQJsnjCDTrZqJe+DDBzMB68sMgwEHWXlOHV1di3njBqtX9FHav/
         fR+Ozvez38uIPy6yw3BQeJ78h6eNbPDnijtHPa6cazgw1D3We0icbBrV1aejrMj7E6if
         1PSfMUmoLr/y3Y8ptBBlvJDRIj85TjXcjOnUkfTS3KxvMbsaPufy0AFKTv9TtIgnsIHC
         BWcqB4mvXFYO46zOZk1XGqlRAHhZcCnv7JGlzTwldbnqsevuEUx8Wx/LQugPN7t4D9mN
         q89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067934; x=1691672734;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWYA704UWyrCuVl2IVzrHz3n0S97k5VTTL5u48g6ZTA=;
        b=ONJhj9pYBUCwBPrjPWHmaEc04HOMEYXNOmnXn0+XAnw/hihayDy9LNz2ljx+IZGAyg
         CCOaoWZZxRlG/O8pxsOuWb2mquhIw0NBO6bpCN5GzeSADvUr8SbyyC1zgES2Nz6kDBtq
         cHQpYHUt2ZlG6ZlfE44EWV6QSrWIL/FJ3X5QutTxLaICybNJUMcDUnPRvRgfZNLzU349
         4OXd+ZU1LgWxPRixwQMNljTXzLRVuxO4ZbAE7dHeWBp4YdmudQh6t+jFbr2UfRPUYRs3
         anOfg45v3JHIqo36ul+LR54vgESG/xv9vG07SsRZ8KspSvvSensQ8JOF2yeYPs0JDQaa
         VAPw==
X-Gm-Message-State: ABy/qLYp9iQJYMDyQdSVx4Lfrn1R4sikM1dHdhXSfljeS7h5Pm6LrFMP
        Dj2pHBONTVrU5La6eQUpyMkIBQ==
X-Google-Smtp-Source: APBJJlGC3rABxiwyoiDF0oUWEpERVKiEj80Fs1x/UV5kinaiB16EEFg1DxZaPQsrEAhjC/Ej7JCD+g==
X-Received: by 2002:a05:6512:3ca3:b0:4fe:17a8:bee5 with SMTP id h35-20020a0565123ca300b004fe17a8bee5mr4122947lfv.31.1691067933716;
        Thu, 03 Aug 2023 06:05:33 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id h11-20020ac25d6b000000b004fa4323ec97sm3346594lft.301.2023.08.03.06.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 06:05:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 03 Aug 2023 15:05:26 +0200
Subject: [PATCH] arm64: dts: qcom: sc8280xp-x13s: Unreserve NC pins
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-topic-x13s_pin-v1-1-fae792274e89@linaro.org>
X-B4-Tracking: v=1; b=H4sIABWmy2QC/x2NywqDQAwAf0VybmAfB2t/pZSyu8YakLhsahHEf
 2/wOAPDHKDUmBQe3QGNfqy8ioG/dVDmJB9CHo0huBDd3UX8rpUL7j7qu7LgQBS973M/hQEsykk
 Jc0tSZstkWxaTtdHE+3V5vs7zD1liBMZ1AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691067932; l=1138;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Isdz9v//a75u85vSi/PjyYD1dgrHZUgYNZovgx3+yvA=;
 b=JyjBZpB+Bv5UsUJshxNfdQulQwSprrfTT60zfjNwelAxLfJnexNNxp4PttcYsRTPVNwX9ue2W
 pznf2z61XRoDb5KTM2QRjQTNgT5yJlLcx9dv8yPc8DV/iS3Ag0TFQVD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pins 83-86 and 158-160 are NC, so there's no point in keeping them
reserved. Take care of that.

Fixes: 32c231385ed4 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 6b5a7de6a27d..9a2bbd339e76 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1244,7 +1244,7 @@ hastings_reg_en: hastings-reg-en-state {
 };
 
 &tlmm {
-	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
+	gpio-reserved-ranges = <70 2>, <74 6>, <125 2>, <128 2>, <154 4>;
 
 	bt_default: bt-default-state {
 		hstp-bt-en-pins {

---
base-commit: fb4327106e5250ee360d0d8b056c1eef7eeb9a98
change-id: 20230803-topic-x13s_pin-9ee3117b7f29

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

