Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275057D1675
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjJTTmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTTmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:42:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95690D52;
        Fri, 20 Oct 2023 12:42:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251FAC433C9;
        Fri, 20 Oct 2023 19:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697830940;
        bh=qIjDdNn6tW/Z1KM4goLEX3ZPlV6MIF2Hzz0OmkttADE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p7JArPzGTHSfiL1qYArrwUyX5pB5PNtg8qFfVWn5qcF0F2etOM3YxB0InOCY34zqs
         oW7czuqLlMW44f6wpqHtr1dcWZj0DKJgEDxraiQWJ9s4N3m7PoEhWioS6bY2HQL0ox
         9jHT4wlrqLdReF6rZSN8KOXQH8qmtKu6cLnv/IE/geYQEJYl6Xu5C9JWBJtw0fARt5
         BOECllFLDrRAlnXem2+7GuKXJJSaqSyfQjDZGMOf3U0FCj2BKARMJntZM/w8MArwzu
         EDEver2a7LRCgLnRySpnWLtkdV5fTXVe1810FqwocOyVlu+wsteM8QFBwu/LMOa+UM
         wykw0dbz/gA2w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5079c846dcfso1482569e87.2;
        Fri, 20 Oct 2023 12:42:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YybwDAfcGZ1p0nFvOMzHJ735j2LTcMeCMugX3otGRPp5olWFiFQ
        1DEIgZ1cpe/bGq2NyB0yd3ZQU7cevuh0PxDrag==
X-Google-Smtp-Source: AGHT+IE/SttWYtk6O+YVKNHEBNdGBPVfwkufXCF0xMXDizYo4sopafYgp9I25iAHV/JyHlXdGXPLZXpKBWd+M2uTT2c=
X-Received: by 2002:ac2:550b:0:b0:507:a86d:89bb with SMTP id
 j11-20020ac2550b000000b00507a86d89bbmr1933075lfk.23.1697830938350; Fri, 20
 Oct 2023 12:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230824091737.75813-1-davidwronek@gmail.com> <20230824091737.75813-4-davidwronek@gmail.com>
In-Reply-To: <20230824091737.75813-4-davidwronek@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 20 Oct 2023 14:42:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKG0icvs1y1SMpdgk9mTk9pFziPo2YFjwhcgdkHdaV6KQ@mail.gmail.com>
Message-ID: <CAL_JsqKG0icvs1y1SMpdgk9mTk9pFziPo2YFjwhcgdkHdaV6KQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: Add SM7125 device tree
To:     David Wronek <davidwronek@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 4:17=E2=80=AFAM David Wronek <davidwronek@gmail.com=
> wrote:
>
> The Snapdragon 720G (sm7125) is software-wise very similar to the
> Snapdragon 7c with minor differences in clock speeds and as added here,
> it uses the Kryo 465 instead of Kryo 468.
>
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm7125.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/sm7125.dtsi b/arch/arm64/boot/dts/q=
com/sm7125.dtsi
> new file mode 100644
> index 000000000000..12dd72859a43
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm7125.dtsi
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include "sc7180.dtsi"
> +
> +/* SM7125 uses Kryo 465 instead of Kryo 468 */
> +&CPU0 { compatible =3D "qcom,kryo465"; };
> +&CPU1 { compatible =3D "qcom,kryo465"; };
> +&CPU2 { compatible =3D "qcom,kryo465"; };
> +&CPU3 { compatible =3D "qcom,kryo465"; };
> +&CPU4 { compatible =3D "qcom,kryo465"; };
> +&CPU5 { compatible =3D "qcom,kryo465"; };
> +&CPU6 { compatible =3D "qcom,kryo465"; };
> +&CPU7 { compatible =3D "qcom,kryo465"; };

This compatible is not documented. Please add it.

Rob
