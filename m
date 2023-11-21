Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92127F29E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjKUKNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjKUKNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:13:30 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A12EBA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:13:25 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a877e0f0d8so49421297b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700561604; x=1701166404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvvVHM7viL1Jmzkz/E4yhNDYNAPR+6Zga/hBjsBolp0=;
        b=c9ZypsVhnRqU0Y4NFy0A2r1lwHD4nUnaUDssND9bcPtiXVBc+Imc1hiA3iT7UPSIvn
         Jx56+XIoNqcLEzODhkGmvoe859RHsL9xJg/mliyXGv7wt84oiUV6v1t8MTZeqbZ5AiIy
         OpF25nAH6QLDHMiuYHL7P1epee2FHGd0R9/44q/Y5vIIRfuqb8XrV1LGXSUKc+pH9jNO
         Mq7YqUgUdLkSW/lre4BuR6Sqh3+3BDlwb9DaedfQqrCMGyjwZLr6Vp91G926JSHALDv9
         vncpnOZlldAwxItDe0IgOYYHMqCphs3q6P4CExAdqnl3NLtaJgblWjjJMgrCFAsZFTWM
         xreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700561604; x=1701166404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvvVHM7viL1Jmzkz/E4yhNDYNAPR+6Zga/hBjsBolp0=;
        b=xHZ71AZTHUgWOyUHVBX9+Ec5mZNkW0RKE/zroqQ/F6b7bSmyEpJT76c3b36/pHe3a/
         pJ/hd2IVI8tm1dLNoEuhBFc0ac9X2cRhanJbcjB0Hq1HPQZ4CrtdK61wcoi8lbsh7mbk
         d1xh1NjyUfXgWtUsL6G1RCLp/NkzZ3PN+r3F6zNu/iGnBhGsQ2S8b0yk1moVveqgLeL0
         4gaQmlRfMXmp082mN8yEa3XbwiVHZ6/PdZG59FT0HeXHO/Ja7015gIbo16yY53i1LamT
         7l2UgxqqUNTIn7Ntjwo0dHcCN0m53j4qHvbN117oul++WvAZX2TMfnmiJlUkhjtdDghY
         AtpQ==
X-Gm-Message-State: AOJu0YyRkT49rMu/m4jZtyLqUyAzKaBTxkAwVRKy4wPCixVnZw6iEwwW
        QguxcKlm1dRWbRBxHk7EivHVSc2dCTnbCOsr1C8kTw==
X-Google-Smtp-Source: AGHT+IGyl+3FXfVMW5/uo6prZ2T+50NtUsg/gYXLA7xT5MJNgeqZIoadaWE6u0rFfAURccalW4ny9xhVD7fTcYc7HiY=
X-Received: by 2002:a25:6088:0:b0:d9a:5f53:1732 with SMTP id
 u130-20020a256088000000b00d9a5f531732mr1584303ybb.18.1700561604504; Tue, 21
 Nov 2023 02:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
 <19358871-009d-4498-9c13-90d5338b1e9f@amd.com> <76fa8f61-fe31-4040-a38d-cc05be3f4f17@linaro.org>
 <CAMuHMdW4WPJT0Km7w8RWrGJaztk6QDGoFAn0bdGbrEsw81R1FA@mail.gmail.com>
 <acfdce81-f117-4a1a-a9fe-e2b4b8922adb@linaro.org> <bd49f17c-7ebf-4e19-b77b-b5ec95375f7d@amd.com>
 <b48293f3-16e3-4980-b900-add0cb7d69f6@linaro.org> <CAMuHMdV_gqmf2=cXmZmYgE3aLxvPBr1DVp0cz0C+YrfBVG-8mg@mail.gmail.com>
In-Reply-To: <CAMuHMdV_gqmf2=cXmZmYgE3aLxvPBr1DVp0cz0C+YrfBVG-8mg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Nov 2023 12:13:13 +0200
Message-ID: <CAA8EJpo6w9N_opJkfDaF-20zwZmn6JHrYYhakqzLFqVtgXaV=Q@mail.gmail.com>
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 at 10:09, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Krzysztof,
>
> On Tue, Nov 21, 2023 at 8:47=E2=80=AFAM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 21/11/2023 08:33, Michal Simek wrote:
> > > On 11/20/23 20:31, Krzysztof Kozlowski wrote:
> > >> On 20/11/2023 20:18, Geert Uytterhoeven wrote:
> > >>> On Mon, Nov 20, 2023 at 3:53=E2=80=AFPM Krzysztof Kozlowski
> > >>> <krzysztof.kozlowski@linaro.org> wrote:
> > >>>> On 20/11/2023 15:01, Michal Simek wrote:> >
> > >>>>> On 11/20/23 09:40, Krzysztof Kozlowski wrote:
> > >>>>>> Document preferred coding style for Devicetree sources (DTS and =
DTSI),
> > >>>>>> to bring consistency among all (sub)architectures and ease in re=
views.
> > >>>
> > >>>>>> +Organizing DTSI and DTS
> > >>>>>> +-----------------------
> > >>>>>> +
> > >>>>>> +The DTSI and DTS files should be organized in a way representin=
g the common
> > >>>>>> +(and re-usable) parts of the hardware.  Typically this means or=
ganizing DTSI
> > >>>>>> +and DTS files into several files:
> > >>>>>> +
> > >>>>>> +1. DTSI with contents of the entire SoC (without nodes for hard=
ware not present
> > >>>>>> +   on the SoC).
> > >>>>>> +2. If applicable: DTSI with common or re-usable parts of the ha=
rdware (e.g.
> > >>>>>> +   entire System-on-Module).
> > >>>>>
> > >>>>> DTS/DTSI - SOMs can actually run as they are that's why it is fai=
r to say that
> > >>>>> there doesn't need to be DTS representing the board.
> > >>>>
> > >>>> I have never seen a SoM which can run without elaborate hardware-h=
acking
> > >>>> (e.g. connecting multiple wires to the SoM pins). The definition o=
f the
> > >>>> SoM is that it is a module. Module can be re-used, just like SoC.
> > >>>
> > >>> /me looks at his board farm...
>
> > >>> I guess there are (many) other examples...
> > >>
> > >> OK, I never had such in my hands. Anyway, the SoM which can run
> > >> standalone  has a meaning of a board, so how exactly you want to
> > >> rephrase the paragraph?
> > >
> > > What about?
> > >
> > > 2. If applicable: DTSI with common or re-usable parts of the hardware=
 (e.g.
> > > entire System-on-Module). DTS if runs standalone.
> >
> > OK, but then it's duplicating the option 3. It also suggests that SoM
> > should be a DTS, which is not what we want for such case. Such SoMs mus=
t
> > have DTSI+DTS.
>
> So you want us to have a one-line <SoM>.dts, which just includes <SoM>.dt=
si?

Well, I think it is impossible to run SoM directly. There is a carrier
board anyway, which includes at least regulators. So, I guess, the
SoM.dts will not be a oneline file.

> IMHO that adds more files for no much gain.
> Users of a SoM can easily include <SoM>.dts.
> 'git grep "#include .*dts\>"' tells you we have plenty of users of that s=
cheme.


--=20
With best wishes
Dmitry
