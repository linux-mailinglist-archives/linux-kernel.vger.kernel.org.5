Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B4D803BD5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjLDRlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjLDRko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:40:44 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD79E1;
        Mon,  4 Dec 2023 09:40:30 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1a0fedd3a1so369385266b.1;
        Mon, 04 Dec 2023 09:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701711629; x=1702316429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lBX76/WyazZCOF7hTYHm6kdCEbLg+NpPINR6F7BEsKQ=;
        b=ArNyMghz/rY8xcmyxcgDyMKKH5OaUcIBiis1s6L/9A6nVzYy1u2pl/bdSPRxWBfGuX
         VnVGYeVsvRXGch8/awivJs5MXiFwMY4ROtOnTekAuQH0ygp0oFAM83FM0y+gIKHHPPKC
         Q9Ge5AfnigBG7bveBRPwF6Ah3xcwZ8X9RVl8aMDJTk89GTXAgbTjyrjPDiDSIUzQMSTM
         sCL/jWKX0SG4VBFRhXDkg97b/DUf259ul00tPgX2uXKWFICND+oR/CBNJBWpxhJyubRs
         3H5dyt5v1bp7KhKOFlt8fAygzGs8gCohp07BSg+uVpvUiNXfSo6UZYeHTBavCJ56K9Iy
         H0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711629; x=1702316429;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBX76/WyazZCOF7hTYHm6kdCEbLg+NpPINR6F7BEsKQ=;
        b=bdyHwm/AFrNFGgcLa+GcSq6ABrEQSpzIKY+ZtLP4GyRL5IDeLnOQd657c7SJUM3Jm+
         ENVBzBrGIvrRbWwlkRQ60fHJVW/wf6rfd0ZgR3i0M1f+ZVaK0kLb+BFDxH2ye8MUid+2
         zqS+fGS2Du/nhCQZ1LJF3KcFEgwtT2UsfWIymwh/GaAza/K9TepqXIPpbUurRDH8jsAG
         S5fUQr98SWqolJUitZxunu9h7q24myu0yy04KGeDJlZPYtD8b+GtAzbLMOI9Vwh0GTqg
         eLqGvlYcTLILxKQIw5J0HXxTdECALWCPPfN12me9Ga/+VVSQuFBhA3o+YYfAuMCskX50
         lMzw==
X-Gm-Message-State: AOJu0YxvStOQiZXe0emq/bi1YL+BZ7u3BLTnZdRsHcvhBOzY/s9QuE5T
        GTWK3OHy2CW3sCR0RBtKHhlAjDAIrIM=
X-Google-Smtp-Source: AGHT+IHMH9uic5dLSCR8Pr0qU32sTrkd1wr2Qfk2m+Ql0J7xa4OYX+U0HMiwUojUtUW7pGG2yw6/9g==
X-Received: by 2002:a17:906:3f1e:b0:a16:3da0:dd36 with SMTP id c30-20020a1709063f1e00b00a163da0dd36mr1108363ejj.48.1701711628992;
        Mon, 04 Dec 2023 09:40:28 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bs5-20020a170906d1c500b00a0bf09c9483sm5512149ejb.35.2023.12.04.09.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:40:28 -0800 (PST)
Message-ID: <9a2afac1-ed5c-382d-02b0-b2f5f1af3abb@gmail.com>
Date:   Mon, 4 Dec 2023 18:40:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/3] ARM: dts: rockchip: rk3036: fix hdmi ports node
To:     heiko@sntech.de, hjc@rock-chips.com
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <49c6afec-022f-02de-99a0-d409b64da198@gmail.com>
Content-Language: en-US
In-Reply-To: <49c6afec-022f-02de-99a0-d409b64da198@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix hdmi ports node so that it matches the
rockchip,inno-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3036.dtsi | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
index 8aa2e0864fed..2b00109bea6a 100644
--- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
@@ -405,12 +405,20 @@ hdmi: hdmi@20034000 {
 		pinctrl-0 = <&hdmi_ctl>;
 		status = "disabled";

-		hdmi_in: port {
+		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			hdmi_in_vop: endpoint@0 {
+
+			hdmi_in: port@0 {
 				reg = <0>;
-				remote-endpoint = <&vop_out_hdmi>;
+
+				hdmi_in_vop: endpoint {
+					remote-endpoint = <&vop_out_hdmi>;
+				};
+			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
 			};
 		};
 	};
--
2.39.2

