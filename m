Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5841181383D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444114AbjLNRQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjLNRQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:16:07 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81360114
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:16:13 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-551c03ae050so3539713a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702574172; x=1703178972; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ecnta8fmq85962lS8hL+fAUj0iRD5WKCwqnVAGP2iIc=;
        b=DJRTAqQTYb5g5XBwNoiDQgAM4Nk82K09kycH3fC8q5whaLnbbjbbtNd2jdfWECDvQy
         fkdj/tApjWU+byQjNjUP8LY/j3pTK38x1PJiHQAO5pWd74wxWub4MMebw3QqtLjghHZU
         6/iiLEJ4lvzDFrqeAEHtxd+bkq3sdBcrk5hzDDZBdEVkrVy/5KpqRxCpviDZ9rWcVrTz
         Aj9w45hb0a/ql/3pCsEq4zT8oVMkGMD1Yf3RnP1kxypF8UkZpGYERXhePMYA2dny4zjz
         4tMgRX3Jbh17OaK9bhL68JgTWskzcxYQJvcykkJcfU04FauMWnMkC1oaMjHa6nLcIGr1
         ShVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702574172; x=1703178972;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecnta8fmq85962lS8hL+fAUj0iRD5WKCwqnVAGP2iIc=;
        b=mYnEbxLes9c+kKMr0zweFX984dBRaWgISJ0hZ1viBy0Pl4+cF2VhZbNKqbSJabtVSI
         aQkyKScl/4MkKffitfk5jeFXvcSxRgLXADKM6vD1CLat9R/qj/buHtf1aypPvxGFaVQW
         ibSymZLDFYYMyo2wJRTisFKZbeJ/nYR3yMwtsLCxt/LN9bVqjG8LOx924WtdA79Qofw5
         Na/dcw1WoFbval8otqSTJe3L/c4gvckrw8bQluEAl+/gKuTkKnzdlL6n0Ym+NlRNp18L
         0F/6O86oJmHa8kXzAfyYHQaG9u3+XtApljm7ryV/erlf1G5E6jdU2mr8iMBqO52BkoQ2
         l6RQ==
X-Gm-Message-State: AOJu0YyjfOiEsBHDPm/DLKZODLyoRxk43cAF+EtdxpDRU9RjxfgCXg0+
        p8rYLHmRQgysAhrpplHaulNCOQ==
X-Google-Smtp-Source: AGHT+IG6Su9AcJ8UB8+CR3YvRwMsFViTW9KvL5ywNrTDS3Z7rvlSiHVZSb3ePy1KzoSttFUebNqOqw==
X-Received: by 2002:a17:906:3f13:b0:a1e:7683:4da4 with SMTP id c19-20020a1709063f1300b00a1e76834da4mr4450934ejj.11.1702574172010;
        Thu, 14 Dec 2023 09:16:12 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id rl19-20020a1709076c1300b00a1f8bae93d3sm7609398ejc.215.2023.12.14.09.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:16:11 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Thu, 14 Dec 2023 19:16:04 +0200
Subject: [PATCH] dt-bindings: mailbox: qcom-ipcc: document the X1E80100
 Inter-Processor Communication Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-x1e80100-mailbox-ipcc-v1-1-49d177238c9b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFM4e2UC/x3MSwqFMAxA0a1IxgaSKqJuRRzUGDXgjxYeBXHvr
 zg8g3sfiBpMI/TFA0F/Fu06M7gsQDZ/roo2Z4MjV7HjGhNrS0yEh7d9uhLaLYIteTdL11QydZD
 bO+hi6fsO4/v+AeE8+h5nAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=JIVsQfTi7l0HKesJJg+/gqxHs3KMNT6H5TGenNe67T8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlezhVBSG2LXnGFpw9Fd6d+VIQW1urKEo21MZzX
 q9y4MpVefyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXs4VQAKCRAbX0TJAJUV
 VgO1D/9KAMQ9QWuf3XCJCB2S1M27TbPpoQV1A94UzDvNuRAGDAWLL3rXWX3kLh8KepIwZO6a73m
 t0WVFEyfwL8jDs+FL9z4+voUe1WZhJzDoazN/5EgYoNPF2/ZC/s2czxnHL7awlq0N9LWUIxtbPo
 uKpvi75s2QGc+LXuwJAy27nQV99LU8LPbhJsNC1Ohsqn2ZUT3xddFFBC9J+XKZQs0lBkuUXj1Kh
 LLvHbzRc7NlFpV9XSege3G/NRydc9LCc2NR755GNeZRdut0sZdbRItQM7r755MMZTJlsrQflg+m
 yx/OfzFjCpoCFPAGPK9s0fKxxPh9eMkI8QQ5YUIRky6LCuNSAiTQaAGSA/q/8QT5QgUQi+ZAMFQ
 BL5nrZ3OoG6NmNcypJA73U1AgnccBinsqOcvdx257SBkDyTCJhTGchhOO6Ea8LcJkO7oyIjHOFY
 /PaIHTDoVIJIT8Y4RZH5gv7v480HovOak7pBWHNrvZfJyD3T/MmsQynKjOeavfwS4AkBSmKJ6ns
 Hj2vPVb4IfR+O8qkcNRIvpJTK6Zr3nN1f5vxLPz0LCM6JdkvOXFVkVbY3SK3DMWMEhbdEGK3ZW6
 Dt+Uob23ejAJVRnPkpKndyYxeiVp0TOoP15VlH0xBZnvaaopAcTwMQnuz00ZnMBDD6bI7e37L+7
 LtD0xYBzWWGUBtQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Inter-Processor Communication Controller on the X1E80100 Platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index a35f9483dc71..8f004868aad9 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -35,6 +35,7 @@ properties:
           - qcom,sm8450-ipcc
           - qcom,sm8550-ipcc
           - qcom,sm8650-ipcc
+          - qcom,x1e80100-ipcc
       - const: qcom,ipcc
 
   reg:

---
base-commit: 48e8992e33abf054bcc0bb2e77b2d43bb899212e
change-id: 20231214-x1e80100-mailbox-ipcc-80a2dc963cb9

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

