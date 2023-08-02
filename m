Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CA476CDB2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjHBM6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjHBM6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:58:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C269C268E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:58:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31768ce2e81so6951000f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690981128; x=1691585928;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nM35gsA6CPAmgURYYCINSeaOq/vcjiHdkzvB/+S9OSc=;
        b=JzlKw9nzxvBVDvJQ1kq7HJaL2HxnAlqaVIS5QNT1elfHqLddv3k2oeObRsUnLH9s/q
         jVoeUaVCNGOuUW63sT1U8iJTqP6cbnUhn8Nuo5gs4AjO2n9Wmoepan66ybgDyA+nsS/V
         3qVyg0E79VqozUedZZvyrFan399GHBy9Cit0k056nFy71JvSxtyFJ4ho8OG5rAyychQS
         AEhaHfcsD19ml626osi42A8qdJbYDt77Y6QrASHfgx/sH723re8tOMJxrjDJ3HUu1s4w
         JOOItDl6IM8PGtK0RsyhNE3U6uMsIIfapitxDl63Gjbk9m6O3p3EOI9RmAtGRA4bbP/2
         rTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690981128; x=1691585928;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nM35gsA6CPAmgURYYCINSeaOq/vcjiHdkzvB/+S9OSc=;
        b=ZLMzV1fOk+wAKktAhqytxI4MPxNFgek00Gz9xFkMkfc/9MLyFBqYaDFf4GqwgmNw6A
         oKOXpS3yrl5g6fRqMMHJAK0iKD3XKKLD64wsL6rrZcxPBPxclE4CZZJIrIS8vzVDr7TJ
         QPmYV7zd9jORG7Lk+k1938kxRB4mnUL52bXrQhxfawTe4KpdBy+TzcC9aKUHyUUoTpwp
         fhFg72e4l+33un6V5L0fVzjROGj5/mxSvYRTEJVL7Bd/uNpy0sfpJ24HL+K4XJ/H9KXM
         vD8Key3HT7Vf4SfeAy93l8JUokvXDNAhiDWLhXVfotppNynO6NsA4zVhYPf+Vlyv1dYU
         FznQ==
X-Gm-Message-State: ABy/qLanvibHpIyn6LRRUz03MmYrFx3Txoo5qFGHwR5LkdiWnFAWGHPU
        Srohep4GA9a594OPwUB9s4zbPQ==
X-Google-Smtp-Source: APBJJlGdkSWe0FjsI0iKpzPoDTFo2gPe55Tldu84LoI9shoruw5nj+UrqQP2lEdQydwZtX8AfvfZhQ==
X-Received: by 2002:adf:fd4f:0:b0:314:3b78:da77 with SMTP id h15-20020adffd4f000000b003143b78da77mr4389666wrs.29.1690981128249;
        Wed, 02 Aug 2023 05:58:48 -0700 (PDT)
Received: from localhost (host-92-17-103-66.as13285.net. [92.17.103.66])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b00314417f5272sm19042667wrp.64.2023.08.02.05.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 05:58:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 02 Aug 2023 13:58:46 +0100
Message-Id: <CUI2S5IGZEHC.P7MUFZVOHCYR@lion.caleb.rex.connolly.tech>
Cc:     "Robert Marko" <robimarko@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Jeffrey Hugo" <quic_jhugo@quicinc.com>,
        "Marijn Suijten" <marijn.suijten@somainline.org>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v13 01/10] cpufreq: blocklist MSM8998 in
 cpufreq-dt-platdev
From:   "Caleb Connolly" <caleb.connolly@linaro.org>
To:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Viresh Kumar" <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Niklas Cassel" <nks@flawful.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
X-Mailer: aerc 0.15.2
References: <20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org>
 <20230217-topic-cpr3h-v13-1-d01cff1c54cf@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v13-1-d01cff1c54cf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 2, 2023 at 1:37 PM BST, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.or=
g>
>
> Add the MSM8998 to the blocklist since the CPU scaling on this platform
> is handled by a separate driver.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@soma=
inline.org>
> Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

// Caleb (they/them)

> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufr=
eq-dt-platdev.c
> index e2b20080de3a..adb3579a1fee 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -143,6 +143,7 @@ static const struct of_device_id blocklist[] __initco=
nst =3D {
> =20
>  	{ .compatible =3D "qcom,apq8096", },
>  	{ .compatible =3D "qcom,msm8996", },
> +	{ .compatible =3D "qcom,msm8998", },
>  	{ .compatible =3D "qcom,qcs404", },
>  	{ .compatible =3D "qcom,sa8155p" },
>  	{ .compatible =3D "qcom,sa8540p" },

