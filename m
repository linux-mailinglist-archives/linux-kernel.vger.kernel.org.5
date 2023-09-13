Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E9079E1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbjIMIYJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 04:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjIMIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:24:08 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB581E73;
        Wed, 13 Sep 2023 01:24:04 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-58c92a2c52dso62440907b3.2;
        Wed, 13 Sep 2023 01:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593444; x=1695198244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YpGKJuDtrl+7ORYHXXZK89Axri0zAtMDBhXftL8Qjk=;
        b=j54TWAR9li5C7xEsZHsgXo6RsgGYG5XzSWx9lNk82ObL8fqqP0NGL/2+iT7FcPZvof
         a012o0kUvxTF2SDj/qWNW5yXa3HUpdM+JdtEiC6c1lIGZTW33o0Fa4jH2O+4mpZruJcK
         BoKMp+XgHbIJgSOWndCutmrtNwZkgbhlhPZ0AZ9lVhwKt8v0xX5IxP0+h8Iiq0aLlWHi
         eVuomBVQgw09aK3gk4ZbWF0FMJ0ERrU5EuffuShU4MCAlUpZ5R8P0DWS3gGroP91jNe6
         POgEbq+04nqRZ4rHpVUczxujEPypQARlunErJslo0bJoemvqrTyfg0Rl8giVm0t5JN/n
         hzlA==
X-Gm-Message-State: AOJu0YwT6srZY6+ATzceF+J+Do3VoNk2kOQ0z2b72yVKHqzD8fU1z8WU
        MdEwE0i6sU2Y8O+8BCq1VS2AiBH41ASsbg==
X-Google-Smtp-Source: AGHT+IGVwk+ycTXGeEGKkEi3H5eUGCLRXcodxKTCwu8p7OaPp8DF+PtdafJgwCLuJjD1jBYPpz/qkg==
X-Received: by 2002:a0d:ea0b:0:b0:59b:4116:cf12 with SMTP id t11-20020a0dea0b000000b0059b4116cf12mr1931803ywe.8.1694593443927;
        Wed, 13 Sep 2023 01:24:03 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id m4-20020a819c04000000b0059b20231f1dsm2964940ywa.121.2023.09.13.01.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:24:02 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-58c92a2c52dso62440617b3.2;
        Wed, 13 Sep 2023 01:24:02 -0700 (PDT)
X-Received: by 2002:a25:d045:0:b0:d74:6c9f:e734 with SMTP id
 h66-20020a25d045000000b00d746c9fe734mr1738982ybg.47.1694593442162; Wed, 13
 Sep 2023 01:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-7-quic_devipriy@quicinc.com> <CAA8EJpo75zWLXuF-HC-Xz+6mvu_S1ET-9gzW=mOq+FjKspDwhw@mail.gmail.com>
In-Reply-To: <CAA8EJpo75zWLXuF-HC-Xz+6mvu_S1ET-9gzW=mOq+FjKspDwhw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Sep 2023 10:23:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXx_b-uubonRH5=Tcxo+ddxg2wXvRNQNjhMrfvSFh0Xcw@mail.gmail.com>
Message-ID: <CAMuHMdXx_b-uubonRH5=Tcxo+ddxg2wXvRNQNjhMrfvSFh0Xcw@mail.gmail.com>
Subject: Re: [PATCH V2 6/7] arm64: dts: qcom: ipq9574: Add support for nsscc node
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Devi Priya <quic_devipriy@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, arnd@arndb.de, geert+renesas@glider.be,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        quic_saahtoma@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Fri, Aug 25, 2023 at 1:28 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> On Fri, 25 Aug 2023 at 12:15, Devi Priya <quic_devipriy@quicinc.com> wrote:
> > Add a node for the nss clock controller found on ipq9574 based devices.
> >
> > Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> > ---
> >  Changes in V2:
> >         - Dropped the fixed clock node gcc_gpll0_out_aux and added
> >           support for the same in gcc driver
> >         - Updated the node name to clock-controller@39b00000
> >         - Added clock-names to retrieve the nssnoc clocks and add them
> >           to the list of pm clocks in nss driver
> >
> >  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 48 +++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > index 51aba071c1eb..903311547e96 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > @@ -722,6 +742,34 @@ frame@b128000 {
> >                                 status = "disabled";
> >                         };
> >                 };
> > +
> > +               nsscc: clock-controller@39b00000 {
> > +                       compatible = "qcom,ipq9574-nsscc";
> > +                       reg = <0x39b00000 0x80000>;
> > +                       clocks = <&gcc GCC_NSSNOC_NSSCC_CLK>,
> > +                                <&gcc GCC_NSSNOC_SNOC_CLK>,
> > +                                <&gcc GCC_NSSNOC_SNOC_1_CLK>,
> > +                                <&bias_pll_cc_clk>,
> > +                                <&bias_pll_nss_noc_clk>,
> > +                                <&bias_pll_ubi_nc_clk>,
> > +                                <&gcc GPLL0_OUT_AUX>,
> > +                                <0>,
> > +                                <0>,
> > +                                <0>,
> > +                                <0>,
> > +                                <0>,
> > +                                <0>,
> > +                                <&xo_board_clk>;
>
> If you move xo_board closer to the start of the list, it will be
> slightly easier to review.
>
> > +                       clock-names = "nssnoc_nsscc", "nssnoc_snoc", "nssnoc_snoc_1",
> > +                                     "bias_pll_cc_clk", "bias_pll_nss_noc_clk",
> > +                                     "bias_pll_ubi_nc_clk", "gpll0_out_aux", "uniphy0_nss_rx_clk",
> > +                                     "uniphy0_nss_tx_clk", "uniphy1_nss_rx_clk",
> > +                                     "uniphy1_nss_tx_clk", "uniphy2_nss_rx_clk",
> > +                                     "uniphy2_nss_tx_clk", "xo_board_clk";
>
> You are using clock indices. Please drop clock-names.

What do you mean by "using clock indices"?
Note that the "clock-names" property is required according to the DT bindings.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
