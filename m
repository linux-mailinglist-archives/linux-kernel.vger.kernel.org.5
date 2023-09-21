Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE4E7A9938
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjIUSMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjIUSLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:11:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7E88CC82
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:42:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c3c8adb27so154569066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695318156; x=1695922956; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8eS5EsLnF+3eMR0Okk+7DiUYY6jE3GaH2tKxaZiXFU=;
        b=ri1Yu6CYJSt1aY02Xip0uZxN76NEL8rdxzaARfTex8DAH0G/AdxJbCrl045xgAzVa8
         NKUuAytjKmMga+8NCzAxXVHjgqBMos2aZg47WNv1N9QGxY6I8qW63uBvBb2JNwiGvgwO
         AczCt0SgrXSnKoF7+yL1uK68t9mByv52ha8p/buzHzWACNBhJNis7f3eOIqRAaKafcaY
         X52pQ8oYOGEKaqBg9G76Tl8FlwBB/hGXvP8+8o8iHl5ZWAcLhF3jj6waC3y+8N0CYZms
         05CFv5/mffwnX2ZkkXUfkd09Gjgu90+1HyyIkk04C5buik8Rv3aGegjE0s/rPRydiAY0
         MzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318156; x=1695922956;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q8eS5EsLnF+3eMR0Okk+7DiUYY6jE3GaH2tKxaZiXFU=;
        b=q+cZIN4+1TPq80rVHNT6qaxaPS7wYEjOiFikYaQ/ArztCSYX5NwFxTtFaK1M0g67Qs
         vabjTJWQCF/8VVhyXifs2vmWZu30/B5B3kzYdwh+9Nmc1CWJx30WkcLkCTxN5/Tbc0sT
         cUWqy3mJoCLXbwLPb44qOPKG/q/C6xNpUnRG8BMMrL0KH1Uu90Y66GuGLiaPziU5AqPA
         9tNPYqNPRp+U3dENwWszsrB+8SimP+4BMw0L0M4ZM6vLNafa0mGy5t15g6iGUf8zuc1b
         OlNsORkocDKohboZmXb1njE/PNxeZXVBHsPuJY6wFljoujKfv8etJCNHyoWFIo+p0Z++
         Q7Lw==
X-Gm-Message-State: AOJu0YwhTM+RO3R0TsoUdUjMmR/215khbjyaCyMu088YASQl2EkZZSka
        B9gmtMyHNJ+cuZsh9eAY+EQnBFK+cN2FbJmvuZGO4g==
X-Google-Smtp-Source: AGHT+IH0xC3AnMjYLD8sk+f9VGN5MFIAOGTQLEfy1gXzGtJvdU7IH7Xk3Rmde+6cngEOiB0uUj1Zrg==
X-Received: by 2002:a2e:86c9:0:b0:2c0:d44:6162 with SMTP id n9-20020a2e86c9000000b002c00d446162mr3655168ljj.12.1695277809976;
        Wed, 20 Sep 2023 23:30:09 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906278b00b00977eec7b7e8sm555508ejc.68.2023.09.20.23.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 23:30:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 21 Sep 2023 08:30:08 +0200
Message-Id: <CVODTTU89L11.Y3SSDO2Y9A35@otso>
Cc:     "Bjorn Andersson" <andersson@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the qcom tree
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Andy Gross" <agross@kernel.org>
X-Mailer: aerc 0.15.2
References: <20230921084252.3c5ab501@canb.auug.org.au>
In-Reply-To: <20230921084252.3c5ab501@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 21, 2023 at 12:42 AM CEST, Stephen Rothwell wrote:
> Hi all,
>
> After merging the qcom tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> Error: scripts/dtc/include-prefixes/arm64/qcom/pm7250b.dtsi:44.10-11 synt=
ax error
> FATAL ERROR: Unable to parse input tree
>
> Caused (exposed) by commit
>
>   eee9602ad649 ("arm64: dts: qcom: qcm6490: Add device-tree for Fairphone=
 5")

Hi, this should be caused by
"arm64: dts: qcom: pm7250b: make SID configurable"

It seems I've missed updating one arm32 dts file, I'll send a patch for
this shortly.

Sorry about that.

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/=
qcom/qcom-sdx65-mtp.dts
index fcf1c51c5e7a..9649c859a2c3 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts
@@ -4,6 +4,10 @@
  */
 /dts-v1/;
=20
+/* PM7250B is configured to use SID2/3 */
+#define PM7250B_SID 2
+#define PM7250B_SID1 3
+
 #include "qcom-sdx65.dtsi"
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <arm64/qcom/pmk8350.dtsi>

>
> I have used the qcom tree from next-20230920 for today.

