Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A1775ABC6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGTKQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjGTKQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:16:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DCD136
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:16:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b743161832so8329561fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689848190; x=1690452990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYiLa4u+MTqh8C9SMSMYqQrfYRu7ZFEq+xyyji42VYE=;
        b=bVvtsauMFB62DU8vBl8gUAS627fFY4ZdSGJG5xymmmih6oMshAWewuWrZjdBCutbm3
         wb+ja+DjM15k/djMMv/iHzuHwqAS/UQZgyWCCFI+IJcz3WT4ng+Go3ztOAXxB7CuswaR
         HD7E8lwZRShYjkwfoRH0V26Bxub/+iW3Arw+DR6tkYpvaPkLTG7Jn5SoZPlYXHvh0qhA
         CKVnLGWLItVMQFHrqCP+oDvaAab4zkha4yWMUgnG5mMoL7ZgfzgrELwM+F13ozNgsWSC
         39IO1alqPQiWmi5DnyAWSHsl4m+fHX6msdjDTFNJuNs+LJmB+hSOAyMT5yuDJvEvWzAa
         NOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689848190; x=1690452990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYiLa4u+MTqh8C9SMSMYqQrfYRu7ZFEq+xyyji42VYE=;
        b=FzQ0sLjCcOLQ9j/AbW11OAuvc44xQ+RZxmyKN5b2/EztxzVox5JTiwuTuSTGGV1nk3
         qrqgfCsdi2OPqwoYswvz86I+OL21Q3yLY98QYCysxcPeal1rOKEbJB/55w4msbeqmhnT
         AsqN6/z3LCMoOfUEtLwBC8aFGSfYAJ3jq54dkDX/cekklrNq8vUg7kXF6a9+GiemL/bn
         7L6IXeBCDoDswpwAWWSDuZPxq34JWc5KCvFihAueQZnXD48LLMzzK6qpqKoV6vNAY5cF
         pout0FPAdll+iqTQDUHzS+05zlOubx1qSfBr14ehgH/qcM/8JCWxuEZpHg8ZhVJi3va6
         RaQA==
X-Gm-Message-State: ABy/qLY741+JvI4fiKn5M+l8a24srrQ33DtarBmeUPFE8moYhlXMLGMH
        vLLrp0Dx6/3w0Pe4OV3Sza5SBjbZbOxcUPOOZx441Vw704Bc1KwmN4Q=
X-Google-Smtp-Source: APBJJlGPAo7nfpmFNyXqdwGSXn8kws4LlB9dGHdGK27p2J81w/bW6cXdRPeo3wUpjTWtsubxehiwboVRMZq2QRffFPs=
X-Received: by 2002:a2e:9604:0:b0:2b6:e128:e7a3 with SMTP id
 v4-20020a2e9604000000b002b6e128e7a3mr1863330ljh.33.1689848190396; Thu, 20 Jul
 2023 03:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230616063210.19063-1-eric.lin@sifive.com> <20230616063210.19063-4-eric.lin@sifive.com>
 <2437bda9-bbdb-ad80-7201-1e16e1388890@linaro.org> <CAPqJEFoTsmVZ4kvsSB0RkQZaQGyXC96KV6RvdpeC5XxURCOZ0w@mail.gmail.com>
 <8c9ed2d4-83ab-ecc0-a300-e6bc8e2047b6@linaro.org> <CAPqJEFqhmxksvEgvC61cJcRGR0DrSWDZxJC3J7tdgcG8UY+sFw@mail.gmail.com>
 <f5275617-d68c-c76b-d799-106f67cc2071@linaro.org> <20230712110908.GA23216@hsinchu16>
 <0865b422-d587-c1c7-9463-510832ddddf4@linaro.org> <20230712-parking-acting-e91f24204467@wendy>
In-Reply-To: <20230712-parking-acting-e91f24204467@wendy>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Thu, 20 Jul 2023 18:16:19 +0800
Message-ID: <CAPqJEFqN-13MyDaCPV31RJjrgmXkx=pTVmgZ6KhabY3xTP6kxg@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com,
        Zong Li <zong.li@sifive.com>, vincent.chen@sifive.com,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Wed, Jul 12, 2023 at 8:49=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Wed, Jul 12, 2023 at 02:30:06PM +0200, Krzysztof Kozlowski wrote:
> > On 12/07/2023 13:09, Eric Lin wrote:
> > > On Sat, Jul 01, 2023 at 10:22:25AM +0200, Krzysztof Kozlowski wrote:
> > >> On 28/06/2023 18:31, Eric Lin wrote:
> > >>
> > >>>>>>
> > >>>>>>> +      - enum:
> > >>>>>>> +          - sifive,pL2Cache0
> > >>>>>>> +          - sifive,pL2Cache1
> > >>>>>>
> > >>>>>> What is "0" and "1" here? What do these compatibles represent? W=
hy they
> > >>>>>> do not have any SoC related part?
> > >>>>>
> > >>>>> The pL2Cache1 has minor changes in hardware, but it can use the s=
ame
> > >>>>> pl2 cache driver.
> > >>>>
> > >>>> Then why aren't they compatible?
> > >>>>
> > >>>
> > >>> The pL2Cache1 has removed some unused bits in the register compared=
 to
> > >>> pl2Cache0.
> > >>> From the hardware perspective, they are not compatible but they can
> > >>> share the same pl2 cache driver in software.
> > >>
> > >> So they are compatible... If they were not compatible, you wouldn't =
be
> > >> able to use the same match in the driver.
> > >>
> > >>> Thus, we would like to keep both. It would be great if you can prov=
ide
> > >>> some suggestions. Thanks.
> > >>
> > >> I propose to make them compatible, like every other piece of SoC. I
> > >> don't see any benefit of having them separate.
> > >>
> > > Sorry for the late reply.
> > > The pl2 cache is our internal platform IP and is not part of any SoC.
> > >
> > > The reason why this driver is compatible with the hardware "pl2cache0=
" and hardware "pl2cache1"
> > > is that it doesn't program the different parts of the config register
> > > However, our internal software (e.g., bare-metal software) will progr=
am these different parts,
> > > so it needs to rely on the different compatible string to identify th=
e hardware.
> > >
> > > Additionally, we would like the compatible strings to reflect which h=
ardware is being used Thanks.
> >
> > I don't understand how does it contradicts anything I said. So you do
> > agree with me? Or what?
>
> I probably should've been keeping a closer eye here, sorry.
>
> I assume what Krzysztof means is why do you permit both
> "sifive,pL2Cache0" and "sifive,pL2Cache1" appearing in isolation. IOW,
> both of
> compatible =3D "sifive,pl2cache0";
> and
> compatible =3D "sifive,pl2cache1";
> are valid in your binding.
>
> The hardware for both might be different, and their full featuresets may
> be incompatible, but they implement a compatible subset of features. I
> would expect that the following would be the permitted compatible setups:
> compatible =3D "sifive,pl2cache0";
> and
> compatible =3D "sifive,pl2cache1", "sifive,pl2cache0";
>
> A consumer of the DT that does care for the differences should be
> looking for the specific compatible, and OS code that does not care can
> always bind to the "0" version.
>

Yes, but I think the proper compatible string for hw pl2cache0 and hw
pl2cache1 should be as follows:
hw pl2cache0 -> compatible =3D "sifive,pl2cache0","sifive,pl2cache1";
hw pl2cache1 -> compatible =3D "sifive,pl2cache1";

Since the hw pl2cache0 implements more features than hw pl2cache1, it
can be compatible with the pl2cache1 driver.
However, hw pl2cache1 only implements a sub-feature of hw pl2cache0,
so it cannot be compatible with the pl2cache0 driver.
Thus, I'll keep only the compatible =3D "sifive,pl2cache1". in the
driver and dt-binding.  Thanks for the suggestions.

> Do the "0" & "1" here refer to the IP version, as in
> sifive-blocks-ip-versioning.txt? I didn't think the compatibles
> containing those IP versions were supposed to appear in isolation,
> without a soc-specific one?
>
Yes, I think they refer to IP versions. OK, I'll fix it in v2.
Thanks for the review.

Best regards,
Eric Lin

> Thanks,
> Conor.
