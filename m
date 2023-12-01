Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EF680072A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378213AbjLAJeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378055AbjLAJeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:34:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD32129
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:33:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54bb9024378so2185831a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1701423226; x=1702028026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTbESXzcXZ37/AxtizRE/kwCz5vVYNKpF/F7wAyS+CQ=;
        b=FHU+4D2jfOed21rv2GRbIh5eCFWePtkFS4/1YT1fFDfLl6PM5vuIzNJ6VtzjVcrByC
         KZQzEBAZGglRUyDL77gtZ6XDcVe2UAFTQgsKRc5Mq/iCf0nYlf0j1lIe3JRQZiR/QLn0
         tOpdOscWM7Ows1ddqtYYqmoknObhETrAhzb+M5a6aiyEN6Sy4TAvm7V+iuCcblqqZRMS
         l71ht+NOOuHJwdEYZX868VUkzNn83sMqqooFyYF6ztCesc7Fb8ZSXQU5RmdEwCpU+cQ1
         VjmpcWmPYPtHNFBhPli6fth+H693c6y8zStpKMM6S9QqTMvTTiR2yAlAvsXa0eoYZ0Co
         6jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701423226; x=1702028026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTbESXzcXZ37/AxtizRE/kwCz5vVYNKpF/F7wAyS+CQ=;
        b=Ve7oFdpxTddWNk04Wn7vHy0t0oJHRwmpr4J+9j1fnXf4tbUS+hbdeKsLOIbKqwq02G
         N/Z0iKSO41+MxClOHfKPWAVGYedPtfaVU0XZ8tGwEmWKqoWyk6p9E/RXk+fs0SoYgXgP
         Wa5x7GEBrGHZHokAYv4ir2v+qy5pLDX8JX4zfk8ksb4vVoiANIBwazky4RXyA+Eu3+CY
         2clpUIOcDKm1XDwnstR+y32rKdAGP5DB3OgFD38sTRwFFT+aH3bwQqxTqC+GDcF0X/xh
         q6xrRyq1R5Vb2El04Fv1HN0YKucI10lIezZQDU69gRecgZ9M4uPBV3VyrugyxrSs6eV0
         Af2Q==
X-Gm-Message-State: AOJu0YzvCjbSW5heXVl1JvX7vfBnoc7TZ9QaqfXl0WnsDc4/r76HnMxY
        yRKwFBunEVgq7G5iJe7v2rucjQ==
X-Google-Smtp-Source: AGHT+IEzLImOfl+SUEo6jVo606UYx0ucUdZyTVpCROkXcLzAMFsH7RPCUeL8vivDWmRZ7rZQP1JLUA==
X-Received: by 2002:a50:d4d2:0:b0:54c:4837:a663 with SMTP id e18-20020a50d4d2000000b0054c4837a663mr468061edj.80.1701423226576;
        Fri, 01 Dec 2023 01:33:46 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (dhcp-089-099-055-216.chello.nl. [89.99.55.216])
        by smtp.gmail.com with ESMTPSA id b16-20020a05640202d000b0054bbc6b6580sm1423708edx.31.2023.12.01.01.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:33:45 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 01 Dec 2023 10:33:20 +0100
Subject: [PATCH v3 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable
 venus node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-sc7280-venus-pas-v3-3-bc132dc5fc30@fairphone.com>
References: <20231201-sc7280-venus-pas-v3-0-bc132dc5fc30@fairphone.com>
In-Reply-To: <20231201-sc7280-venus-pas-v3-0-bc132dc5fc30@fairphone.com>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the venus node so that the video encoder/decoder will start
working.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 762c5db29520..cc092735ce17 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -688,3 +688,8 @@ &usb_1_qmpphy {
 
 	status = "okay";
 };
+
+&venus {
+	firmware-name = "qcom/qcm6490/fairphone5/venus.mbn";
+	status = "okay";
+};

-- 
2.43.0

