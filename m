Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5054A78A621
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjH1G4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjH1G4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:56:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF6D122
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:56:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so3767768a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693205786; x=1693810586;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CbUT7b5YjU9P228SDDHko9vselWOLP8ICBut5LNj2c=;
        b=2rNhbgoRHVDFkzEpf81k4KaCrCEAsCDYs0ux+pAPX3dt8Sct/z38NnYADiB9GutA+H
         joy9/F/84EF3vEdzMqqwZGd4bA3SGCH4KTCae9+pP8BA4zcq9WPvQ6UulTBoTlhElPpF
         tjaxd3W1dzqsosSgoA4sv2mtYsN2P3WA7oBaP0guFWQCifaUZSMwyg6SnFoBOB7yoAMb
         SzIPqBhy/Yr4dPp+E0HZTgPVa/d5gLVxvD9SfzTBbn3g+USdvf/gbzoHTKgZxhL3DZNI
         ZWV7EyUuvLkbL17+IP8CJn4kpF0hNsd9uJ5hSz5FMTNwuRKDXhk2xKaD5LoHXdMmL54U
         kWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693205786; x=1693810586;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+CbUT7b5YjU9P228SDDHko9vselWOLP8ICBut5LNj2c=;
        b=YybPrBlw6cQrpwIz3NUGpLyuEJorVbacyWSvrNoALpVEmUyGbWDeXgcuezwqm4gUPb
         0bIzMNSKr+NP9NW/eqOKPZl0E2WNyYgGf9uSuyeTEiuV5jcN1mH8vM9su2ajcqF9D5qm
         EIZWUZb9asmhY2dfY3UA0+FbctKP6Sa0fqUk6YM2miQqoL9xI2LZD3+4ybWXijmmFpdC
         kZIp9Y5kS7TTBI7Ol6wu0d7xqYdfAXM2Lca1WVI+337SP5KB5TBldJ2YOFJk0Ng2djHX
         Nshb5zfn0v6gka1WUFi3ufG/ix4n7Xr+sNk9PR/qmojMPlrhsC8274mXDylaA1kFzkT+
         tuAw==
X-Gm-Message-State: AOJu0Yz9yCcN6xQDGk8pq/+Z0Plu27/CEH5Du3QZi4ZoPRejCNLJAg99
        zzxzizxtRwa7ecSJJ/1q+Cu7hbW0sY3XdUo1l7tDLw==
X-Google-Smtp-Source: AGHT+IGpD+i6cTIMpPLeel6+nmEVQ3zCBV3QHxnYxIWG/i4LHURGs8TnS7EH2Tl0fCt8kxtHdFJ+bQ==
X-Received: by 2002:a17:906:2097:b0:9a2:19ea:88f7 with SMTP id 23-20020a170906209700b009a219ea88f7mr8449355ejq.64.1693205786646;
        Sun, 27 Aug 2023 23:56:26 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id va17-20020a17090711d100b00992b71d8f19sm4320827ejb.133.2023.08.27.23.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 23:56:26 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 28 Aug 2023 08:56:25 +0200
Message-Id: <CV3ZCVK29BLY.D7Y8AEEOYLO3@otso>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fp4: Revert "arm64: dts:
 qcom: sm7225-fairphone-fp4: Add AW8695 haptics"
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20230827122842.63741-1-krzysztof.kozlowski@linaro.org>
 <20230827122842.63741-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230827122842.63741-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun Aug 27, 2023 at 2:28 PM CEST, Krzysztof Kozlowski wrote:
> This reverts commit 413821b7777d062b57f8dc66ab088ed390cbc3ec because it
> was never reviewed, was buggy (report from kernel test robot:
> https://lore.kernel.org/all/202204090333.QZXMI2tu-lkp@intel.com/) and

(I wouldn't say this part is accurate, the robot just didn't use a tree
with the i2c10 node already present, it was sent in an earlier patch
IIRC, but whatever)

> used undocumented, broken bindings.  Half of the properties in this
> device are questioned, thus adding DTS node causes only errors and does
> not make the device usable without the bindings and driver part:
>
>   sm7225-fairphone-fp4.dtb: haptics@5a: failed to match any schema with c=
ompatible: ['awinic,aw8695']
>   sm7225-fairphone-fp4.dtb: haptics@5a: awinic,tset: b'\x12' is not of ty=
pe 'object', 'array', 'boolean', 'null'
>   sm7225-fairphone-fp4.dtb: haptics@5a: awinic,r-spare: b'h' is not of ty=
pe 'object', 'array', 'boolean', 'null'
>
> Since bindings were abandoned (4 months since review), revert the commit
> to avoid false sense of supporting something which is not supported.

I've been avoiding touching this topic again since I'm really not sure
how to resolve.

There's a bunch of magic registers being written to in the downstream
driver, I don't have any documentation for that so I'm not exactly sure
what I can do to make nice bindings with proper properties.

Would you recommend just hardcoding some of these properties in the
driver, assuming they're constant for every AW8695, even though the
downstream driver has these properties in devicetree? Because of that I
assumed these properties could differ per implementation / usage of the
AW8695 in different devices.

Or do you have any other suggestion?

In any case:

Acked-by: Luca Weiss <luca.weiss@fairphone.com>

Regards
Luca

>
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../boot/dts/qcom/sm7225-fairphone-fp4.dts    | 28 +------------------
>  1 file changed, 1 insertion(+), 27 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm=
64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index 18171c5d8a38..568165f4f9e4 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -386,36 +386,10 @@ &i2c8 {
>  };
> =20
>  &i2c10 {
> -	clock-frequency =3D <400000>;
> -	status =3D "okay";
> -
>  	/* PM8008 PMIC @ 8 and 9 */
>  	/* PX8618 @ 26 */
>  	/* SMB1395 PMIC @ 34 */
> -
> -	haptics@5a {
> -		compatible =3D "awinic,aw8695";
> -		reg =3D <0x5a>;
> -		interrupts-extended =3D <&tlmm 85 IRQ_TYPE_EDGE_FALLING>;
> -		reset-gpios =3D <&tlmm 90 GPIO_ACTIVE_HIGH>;
> -
> -		awinic,f0-preset =3D <2350>;
> -		awinic,f0-coefficient =3D <260>;
> -		awinic,f0-calibration-percent =3D <7>;
> -		awinic,drive-level =3D <125>;
> -
> -		awinic,f0-detection-play-time =3D <5>;
> -		awinic,f0-detection-wait-time =3D <3>;
> -		awinic,f0-detection-repeat =3D <2>;
> -		awinic,f0-detection-trace =3D <15>;
> -
> -		awinic,boost-debug =3D /bits/ 8 <0x30 0xeb 0xd4>;
> -		awinic,tset =3D /bits/ 8 <0x12>;
> -		awinic,r-spare =3D /bits/ 8 <0x68>;
> -
> -		awinic,bemf-upper-threshold =3D <4104>;
> -		awinic,bemf-lower-threshold =3D <1016>;
> -	};
> +	/* awinic,aw8695 @ 5a */
>  };
> =20
>  &ipa {

