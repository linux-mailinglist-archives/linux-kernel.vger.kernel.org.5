Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAC07F26F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjKUII6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 03:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKUIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:08:55 -0500
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4759FBB;
        Tue, 21 Nov 2023 00:08:52 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-507a55302e0so7610638e87.0;
        Tue, 21 Nov 2023 00:08:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700554126; x=1701158926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeOErr72GGCTbFniaP00vmRzQcGaVer6knTx1tHa9Zo=;
        b=gkkKTx/qmI/gQOtXrl3G7QAtgBsE7O+gmrBQpnp4ilsbufpkEl8b+3cjV+0MQKx4e2
         enWwxcxCi3Jd36w6KUrOZhll2NL3hro62Xa/SUVvCmiFq31k7RQ1HHXObMIKmEYHqMJv
         +6cQgIO+bwH6u2TL2TqZwO4c3z6aQ8aXvqJzNZsygRyrRYLsFyLO8Z6eoBNmkNuBrtDz
         f0fG8GV0waZkx9UQpWNt3bbnkcXPAEbgDtFLBXVB1bvefdF06KPPTSNs31uuDXZSVGsJ
         /fNZhyM2fOagdzh1ge+BpPMOxQ/3M96w6Cf8hkerZd+X+G48VpDnD8NX33sCejtNTe1X
         hJ+A==
X-Gm-Message-State: AOJu0YxW8D71LyI3Im6RlLeWNNaUEwqAch0s2gjNycKMP2M2aDm7UMuE
        CxmucjQwnFt2E6dPwKu/Sf3DkYIHhifQZQKq
X-Google-Smtp-Source: AGHT+IEVN6jgghK023lj1dADIueLibsq3V1q6B9ZoAcDCxCKfmhvd6C2PN+SCh/MFFH0Knt6dgBOIg==
X-Received: by 2002:a19:8c57:0:b0:507:9777:7a7 with SMTP id i23-20020a198c57000000b00507977707a7mr6634310lfj.17.1700554125562;
        Tue, 21 Nov 2023 00:08:45 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u23-20020a197917000000b00507a68e637bsm1430968lfc.205.2023.11.21.00.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 00:08:45 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50970c2115eso7578843e87.1;
        Tue, 21 Nov 2023 00:08:45 -0800 (PST)
X-Received: by 2002:ac2:599b:0:b0:507:a5e7:724 with SMTP id
 w27-20020ac2599b000000b00507a5e70724mr6535084lfn.38.1700554124979; Tue, 21
 Nov 2023 00:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
 <19358871-009d-4498-9c13-90d5338b1e9f@amd.com> <76fa8f61-fe31-4040-a38d-cc05be3f4f17@linaro.org>
 <CAMuHMdW4WPJT0Km7w8RWrGJaztk6QDGoFAn0bdGbrEsw81R1FA@mail.gmail.com>
 <acfdce81-f117-4a1a-a9fe-e2b4b8922adb@linaro.org> <bd49f17c-7ebf-4e19-b77b-b5ec95375f7d@amd.com>
 <b48293f3-16e3-4980-b900-add0cb7d69f6@linaro.org>
In-Reply-To: <b48293f3-16e3-4980-b900-add0cb7d69f6@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Nov 2023 09:08:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV_gqmf2=cXmZmYgE3aLxvPBr1DVp0cz0C+YrfBVG-8mg@mail.gmail.com>
Message-ID: <CAMuHMdV_gqmf2=cXmZmYgE3aLxvPBr1DVp0cz0C+YrfBVG-8mg@mail.gmail.com>
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michal Simek <michal.simek@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Nov 21, 2023 at 8:47 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 21/11/2023 08:33, Michal Simek wrote:
> > On 11/20/23 20:31, Krzysztof Kozlowski wrote:
> >> On 20/11/2023 20:18, Geert Uytterhoeven wrote:
> >>> On Mon, Nov 20, 2023 at 3:53 PM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>> On 20/11/2023 15:01, Michal Simek wrote:> >
> >>>>> On 11/20/23 09:40, Krzysztof Kozlowski wrote:
> >>>>>> Document preferred coding style for Devicetree sources (DTS and DTSI),
> >>>>>> to bring consistency among all (sub)architectures and ease in reviews.
> >>>
> >>>>>> +Organizing DTSI and DTS
> >>>>>> +-----------------------
> >>>>>> +
> >>>>>> +The DTSI and DTS files should be organized in a way representing the common
> >>>>>> +(and re-usable) parts of the hardware.  Typically this means organizing DTSI
> >>>>>> +and DTS files into several files:
> >>>>>> +
> >>>>>> +1. DTSI with contents of the entire SoC (without nodes for hardware not present
> >>>>>> +   on the SoC).
> >>>>>> +2. If applicable: DTSI with common or re-usable parts of the hardware (e.g.
> >>>>>> +   entire System-on-Module).
> >>>>>
> >>>>> DTS/DTSI - SOMs can actually run as they are that's why it is fair to say that
> >>>>> there doesn't need to be DTS representing the board.
> >>>>
> >>>> I have never seen a SoM which can run without elaborate hardware-hacking
> >>>> (e.g. connecting multiple wires to the SoM pins). The definition of the
> >>>> SoM is that it is a module. Module can be re-used, just like SoC.
> >>>
> >>> /me looks at his board farm...

> >>> I guess there are (many) other examples...
> >>
> >> OK, I never had such in my hands. Anyway, the SoM which can run
> >> standalone  has a meaning of a board, so how exactly you want to
> >> rephrase the paragraph?
> >
> > What about?
> >
> > 2. If applicable: DTSI with common or re-usable parts of the hardware (e.g.
> > entire System-on-Module). DTS if runs standalone.
>
> OK, but then it's duplicating the option 3. It also suggests that SoM
> should be a DTS, which is not what we want for such case. Such SoMs must
> have DTSI+DTS.

So you want us to have a one-line <SoM>.dts, which just includes <SoM>.dtsi?
IMHO that adds more files for no much gain.
Users of a SoM can easily include <SoM>.dts.
'git grep "#include .*dts\>"' tells you we have plenty of users of that scheme.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
