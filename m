Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0286B78A97C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjH1J74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjH1J7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:59:40 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0821FCA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:59:38 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7481bc4d6fso2979344276.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693216777; x=1693821577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ae2B/bJD6+pwU7iQXkYD7WW81UmVpdPoOKJ3dyD5y8=;
        b=f8Yzvy+q9p7b+uTEWqZMvv9SEdH8DMylAj82MSyBNZMaceHWqEOUBmJ2QPp2Fq0Jhe
         QZVJGaai3aWlYCwFJtU4A2K6OzSN0cFANsnL3Qjp2eilj8ChFys5NtfM3SC51dk7x0Li
         AdPbQwd7PlborWBlILgSxNJm6rqtxx5fFfLlJp73GpBlt5hjU/Hm0Fpsou0XZiw6r5R3
         0eg9Bghw94yVk/3e5KQqm3k0J02UvM+kA5BsCdeVpsvAqFoF2lvRh4wyiUzhak3DNBWH
         BlNx7NDUaV0vY33rKkfDAdOOq0kuqp3oR6RFxMc/hrKsPOJmhC+HXH4EDZ9DiYPgNMSG
         LkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693216777; x=1693821577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ae2B/bJD6+pwU7iQXkYD7WW81UmVpdPoOKJ3dyD5y8=;
        b=lbmqUBjpk6wpk3jmcAOVc1GPB6OALE4XY3ZdMbvH3Gn2JWxnWkuagavSEAZVKEeyIH
         hM/8ZXyYlPKso9NT1QfFO8PykMoPHGypFkkLD5fc+nMIL9Qw9x98Hcx5eF5NsSIwpGUS
         5XQo8Gs56hFczsROiztbnM08JykfgBxbyV0xoT+R63Nn7asPX+IkjqkchvgmYipTVuTI
         avC8iHg6mTeMtvhd5ilGnQ4yZ9tqsgRgvxvURCEK4AwcrhD5dNPeeLoYtf5f7hKXYsv1
         axzIumbLnRiO2L6C1hNDuazwAr+Auvxnl/3bx0Mi/PYjCuTbgHwv8rPifPC+pU0RMegb
         8ghw==
X-Gm-Message-State: AOJu0YzdEuN25m3GodnjPxMVu6l3Tjl522pRHa8tx/OK0SKW//sSHFHx
        t0KEILCIG7IHquAKVkNYPqaJC83YYLJElGwtJL5eLA==
X-Google-Smtp-Source: AGHT+IEaCoCpMUCPjNNvMpqNFEuip8dU+C99qMdfR/6PRAdeSAMP7ht991M5faWrDlN7Kt9uuuksTVQFdukE70njB/g=
X-Received: by 2002:a25:2641:0:b0:d7a:c626:538a with SMTP id
 m62-20020a252641000000b00d7ac626538amr6186920ybm.62.1693216777261; Mon, 28
 Aug 2023 02:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
In-Reply-To: <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Aug 2023 11:59:00 +0200
Message-ID: <CAPDyKFro6roynXuS1caARpMK08hvARQ7mQfiJcDgCyJXiw=nzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shenwei Wang <shenwei.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2023 at 19:31, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/08/2023 17:44, Shenwei Wang wrote:
> >>
> >> The genpd provider then needs to be a consumer of the resources it needs. In
> >> this case a couple of regulators it seems like.
> >>
> >
> > If I understood your reply correctly,  it seems that the current implementation of
> > regulator-pd is what you have described. Please correct me if I'm mistaken.
> >
> > The following are the diff of scu-pd and this regulator-pd.
> >
> >     power-controller {                                                    power-controller {
> >         compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";      |               compatible = "regulator-power-domain";
> >         #power-domain-cells = <1>;                                    #power-domain-cells = <1>;
> >                                                             >
> >                                                             >         regulator-number = <2>;
> >                                                             >         regulator-0-supply = <&reg1>;
> >                                                             >         regulator-1-supply = <&reg2>;
> >     };                                                                    };
> >
> > Are you suggesting to move the regulator-pd to the imx directory and add a company prefix
> > to the compatible string?
>
> There is no such part of iMX processor as such regulator-power-domain,
> so I don't recommend that approach. DTS nodes represent hardware, not
> your SW layers.

I would agree if this was pure SW layers, but I don't think it is. At
least, if I have understood the earlier discussions correctly [1],
there are certainly one or more power-domains here. The power-domains
just happen to be powered through something that can be modelled as a
regular regulator(s). No?

Note that, we already have other power-domains that are consumers of
regulators too.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20220609150851.23084-1-max.oss.09@gmail.com/
