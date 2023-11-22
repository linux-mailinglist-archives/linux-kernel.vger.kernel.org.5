Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048417F48C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344039AbjKVOUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjKVOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:20:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B15D7A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:20:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32fe1a29010so4276704f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1700662822; x=1701267622; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUL3snhs+2QhvhLNvgibL9M8zm24NWKdJWHQAuI96sA=;
        b=FqGHF8MeUSPhjE53ovM2vWI+h1/ojTHJ41LEoTPiLHlNhY9usIdKxnvaNjPaOVNSsD
         Hfxp8Y7xp2/7218o0zJR9NJtF8v7AuNlMiwk3SLWjmnM1S0WTeTGmdlE7szoDQ5M7/v1
         PuK3q+3kp4VPROx1/emqVDdstHI9hNlJEzPc6pjOMOzipMJ7hut9z3FpF0pIa/2vbW0B
         nolSoM04VmupYpUb4Gm7xBaPkkNWNztqzT24zpEJMrTmHyF6A5jtgmNYWUUC8Ot/G6p8
         N5euCSMnK1Rlp+KguvQ9jQ3Yi8/f8pNc1a5TsuORjhq+lBFsVppu52HudVJBtkAm5Ly0
         Mqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662822; x=1701267622;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BUL3snhs+2QhvhLNvgibL9M8zm24NWKdJWHQAuI96sA=;
        b=s+98f+XDIroANi3WOJLtjVEcwRC6aIJDQ5YuKkXbtuGsQpFc3fzC9rsN5hAWXCegRw
         QN9ohZF1ciHvk6fGOKp2ZU2yzMQ7OPuPJBQ8OU+w7rM5vtguEaUmXNGbGqlJdAv3Fuwj
         JzB9BT+pIfBoqsA/CbTNF74S6EYqCDdJoE3HwFK2KGsEhUsvJzFC1ezTMv6YMzHIqjNm
         SZ6hd4VkBoqFFXeqpjNwUvHh09GRj1WWZAzm0LDkJPogrmhoVTapANd5jvSK3FZF9kE6
         jkpF4iszVsrryZA3x3fTH9Zi9Rvkr31BgR2wS9pnQsuIz3AHAv0afnL0hqhFXT/IHydZ
         IbVw==
X-Gm-Message-State: AOJu0YzDRHaOav55LaspWcOgkMvFhq+S5CfOtUUZl8itiisWoMICnjmc
        AcGY5E6rekYyKJywR4JScApYKA==
X-Google-Smtp-Source: AGHT+IG1LUHC5pGpTQElp6wOJmfzPipsCJxpTr7DDhvGvDgQMALXyyWyVUbANh48VSHPNBPYRpwyZQ==
X-Received: by 2002:a5d:45c1:0:b0:32d:701b:a585 with SMTP id b1-20020a5d45c1000000b0032d701ba585mr1308275wrs.69.1700662822099;
        Wed, 22 Nov 2023 06:20:22 -0800 (PST)
Received: from localhost ([194.206.60.209])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d4f8c000000b0032da87e32e2sm17362636wru.4.2023.11.22.06.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 06:20:21 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 22 Nov 2023 15:20:17 +0100
Message-Id: <CX5ENKY70B5J.2D6DXKGI4EGX3@fairphone.com>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7280: Move video-firmware to
 chrome-common
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Vikash Garodia" <quic_vgarodia@quicinc.com>,
        "Stanimir Varbanov" <stanimir.k.varbanov@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231002-sc7280-venus-pas-v2-0-bd2408891317@fairphone.com>
 <20231002-sc7280-venus-pas-v2-2-bd2408891317@fairphone.com>
 <4cfad910-1821-3a31-c372-3f6b199e8f71@quicinc.com>
In-Reply-To: <4cfad910-1821-3a31-c372-3f6b199e8f71@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Nov 22, 2023 at 2:17 PM CET, Vikash Garodia wrote:
>
> On 10/2/2023 7:50 PM, Luca Weiss wrote:
> > If the video-firmware node is present, the venus driver assumes we're o=
n
> > a system that doesn't use TZ for starting venus, like on ChromeOS
> > devices.
> >=20
> > Move the video-firmware node to chrome-common.dtsi so we can use venus
> > on a non-ChromeOS devices.
> >=20
> > At the same time also disable the venus node by default in the dtsi,
> > like it's done on other SoCs.
> >=20
> > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 8 ++++++++
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 6 ++----
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/=
arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > index 5d462ae14ba1..cd491e46666d 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > @@ -104,6 +104,14 @@ &scm {
> >  	dma-coherent;
> >  };
> > =20
> > +&venus {
> > +	status =3D "okay";
> > +
> > +	video-firmware {
> > +		iommus =3D <&apps_smmu 0x21a2 0x0>;
> > +	};
> > +};
> > +
> >  &watchdog {
> >  	status =3D "okay";
> >  };
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts=
/qcom/sc7280.dtsi
> > index 66f1eb83cca7..fa53f54d4675 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -3740,6 +3740,8 @@ venus: video-codec@aa00000 {
> >  				 <&apps_smmu 0x2184 0x20>;
> >  			memory-region =3D <&video_mem>;
> > =20
> > +			status =3D "disabled";
> > +
> >  			video-decoder {
> >  				compatible =3D "venus-decoder";
> >  			};
> > @@ -3748,10 +3750,6 @@ video-encoder {
> >  				compatible =3D "venus-encoder";
> >  			};
> > =20
> > -			video-firmware {
> > -				iommus =3D <&apps_smmu 0x21a2 0x0>;
> > -			};
> > -
> >  			venus_opp_table: opp-table {
> >  				compatible =3D "operating-points-v2";
> > =20
> >=20
> Changes look good. Is this tested on SC7280 ?

Hi Vikash,

I didn't test it myself on sc7280 (just qcm6490-fp5) but dtx_diff
reports no differences except for status =3D okay property being added, so
there should be no change on those boards. See below.

Regards
Luca


--- test-pre/sc7280-crd-r3.dtb
+++ test-post/sc7280-crd-r3.dtb
@@ -5744,6 +5744,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x13b 0x01 0x13b 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-herobrine-crd.dtb
+++ test-post/sc7280-herobrine-crd.dtb
@@ -6117,6 +6117,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x147 0x01 0x147 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-herobrine-crd-pro.dtb
+++ test-post/sc7280-herobrine-crd-pro.dtb
@@ -6112,6 +6112,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x147 0x01 0x147 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-herobrine-evoker.dtb
+++ test-post/sc7280-herobrine-evoker.dtb
@@ -6058,6 +6058,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x14b 0x01 0x14b 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-herobrine-evoker-lte.dtb
+++ test-post/sc7280-herobrine-evoker-lte.dtb
@@ -6121,6 +6121,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x151 0x01 0x151 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-herobrine-herobrine-r1.dtb
+++ test-post/sc7280-herobrine-herobrine-r1.dtb
@@ -6108,6 +6108,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x14f 0x01 0x14f 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-herobrine-villager-r0.dtb
+++ test-post/sc7280-herobrine-villager-r0.dtb
@@ -6049,6 +6049,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x145 0x01 0x145 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-herobrine-villager-r1.dtb
+++ test-post/sc7280-herobrine-villager-r1.dtb
@@ -6037,6 +6037,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x142 0x01 0x142 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-herobrine-villager-r1-lte.dtb
+++ test-post/sc7280-herobrine-villager-r1-lte.dtb
@@ -6100,6 +6100,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x148 0x01 0x148 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-herobrine-zombie.dtb
+++ test-post/sc7280-herobrine-zombie.dtb
@@ -6031,6 +6031,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x146 0x01 0x146 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-herobrine-zombie-lte.dtb
+++ test-post/sc7280-herobrine-zombie-lte.dtb
@@ -6094,6 +6094,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x14c 0x01 0x14c 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-herobrine-zombie-nvme.dtb
+++ test-post/sc7280-herobrine-zombie-nvme.dtb
@@ -6031,6 +6031,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x146 0x01 0x146 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-herobrine-zombie-nvme-lte.dtb
+++ test-post/sc7280-herobrine-zombie-nvme-lte.dtb
@@ -6094,6 +6094,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x14c 0x01 0x14c 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-idp2.dtb
+++ test-post/sc7280-idp2.dtb
@@ -5677,6 +5677,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x138 0x01 0x138 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";
--- test-pre/sc7280-idp.dtb
+++ test-post/sc7280-idp.dtb
@@ -5642,6 +5642,7 @@
                        power-domain-names =3D "venus\0vcodec0\0cx";
                        power-domains =3D <0x133 0x01 0x133 0x00 0x34 0x00>=
;
                        reg =3D <0x00 0xaa00000 0x00 0xd0600>;
+                       status =3D "okay";
=20
                        opp-table {
                                compatible =3D "operating-points-v2";


>
> Regards,
> Vikash

