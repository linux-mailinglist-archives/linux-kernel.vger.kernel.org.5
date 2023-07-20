Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544FE75AB74
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGTJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjGTJvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:51:06 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D675D272E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:49:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b708e49059so8244511fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689846569; x=1690451369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdPjULmUPa6VP/P9oFjDeDKjVlgwghUFnuvoEEW98lk=;
        b=HHofg5goD3MCmhVbpsCJpFHRqzFOOdspVHBHc2MmFRD4bmqkIYAxGzBuDtetpWZPfH
         0OJthp6Qkx/3jOFMvTzKiR0fyy7UKyy0cUctbhp3dZ2VKuc70D7P/iv8pu70g+fg4YkI
         6RLLYKp57LctOmyKyTv0pimuRRljO1xwIiG1mWGlVUrZwWPZbnjwmZJp+vbwoCBfgTFZ
         TTwyMSqWWCtioNyhmH+rq3zt1frT7WCEB7CRtzCOB+sCSOXwUFi9h+K14ZuikqRVksfI
         /KX7rJS+ULnu9yD9vnOJu2FDyx9T8JsnwE2uabQVA7SqQw1q4TihZ7xiF9R6WNJHgh6Y
         mQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689846569; x=1690451369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdPjULmUPa6VP/P9oFjDeDKjVlgwghUFnuvoEEW98lk=;
        b=Xpevp0MDXTOpD8uprdHPdiLi4Ifyd68fxudTvlBr+rAUqHLnewlCpmQl3fdbXfAcE7
         D3c3MoeprRVsun0q0TCYUjZcDHiE3blJuoIYBTnnwdHm+oGrNuGlphFcXsD+CiHdC+sx
         Q8wFYWr7FZu9YqptUaXfQyp9EGuiZym7h9ar3XZPAZMu6qXCYtXdWr/eFAd4jXABA36S
         JVS1S9KkvutY5N7d57D9tkd7vie98DrS2rMIdUY1Pgh7jXM4E9l4H1j3bQ5gbMm5Wa9Q
         GgxXiYBxCD4oyxqfWiJ75eyq5b+I12iNX8l0CngIUvYKW1Srg5vQVKjNugCthZgcZ95F
         fU5A==
X-Gm-Message-State: ABy/qLZCA8X16LWmzn6DmZcB59gDkAaguC2jyPpQlisErAsxfgXm9JYq
        mBNacWdRkJNH2ygyPepeDO4kyO5+QAcavB71nS7FzQ==
X-Google-Smtp-Source: APBJJlHcYyplb13P09E5HKiNPAyWuhkGEPGYuJW5CEjmOyn+qs4zkcM4vBw7USD+ttdRYJCm7IwZvsQDTv4pBHBNPdU=
X-Received: by 2002:a2e:8654:0:b0:2b6:e2cd:20f5 with SMTP id
 i20-20020a2e8654000000b002b6e2cd20f5mr2276664ljj.9.1689846568698; Thu, 20 Jul
 2023 02:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230616063210.19063-1-eric.lin@sifive.com> <20230616063210.19063-4-eric.lin@sifive.com>
 <2437bda9-bbdb-ad80-7201-1e16e1388890@linaro.org> <CAPqJEFoTsmVZ4kvsSB0RkQZaQGyXC96KV6RvdpeC5XxURCOZ0w@mail.gmail.com>
 <8c9ed2d4-83ab-ecc0-a300-e6bc8e2047b6@linaro.org> <CAPqJEFqhmxksvEgvC61cJcRGR0DrSWDZxJC3J7tdgcG8UY+sFw@mail.gmail.com>
 <f5275617-d68c-c76b-d799-106f67cc2071@linaro.org> <20230712110908.GA23216@hsinchu16>
 <0865b422-d587-c1c7-9463-510832ddddf4@linaro.org>
In-Reply-To: <0865b422-d587-c1c7-9463-510832ddddf4@linaro.org>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Thu, 20 Jul 2023 17:49:17 +0800
Message-ID: <CAPqJEFp_YgsXOymQPH1Pr4cORtv=8oS0OWnACWqNe69ARMRwvA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com,
        Zong Li <zong.li@sifive.com>, vincent.chen@sifive.com,
        Greentime Hu <greentime.hu@sifive.com>
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

Hi Krzysztof,

On Wed, Jul 12, 2023 at 8:30=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/07/2023 13:09, Eric Lin wrote:
> > On Sat, Jul 01, 2023 at 10:22:25AM +0200, Krzysztof Kozlowski wrote:
> >> On 28/06/2023 18:31, Eric Lin wrote:
> >>
> >>>>>>
> >>>>>>> +      - enum:
> >>>>>>> +          - sifive,pL2Cache0
> >>>>>>> +          - sifive,pL2Cache1
> >>>>>>
> >>>>>> What is "0" and "1" here? What do these compatibles represent? Why=
 they
> >>>>>> do not have any SoC related part?
> >>>>>
> >>>>> The pL2Cache1 has minor changes in hardware, but it can use the sam=
e
> >>>>> pl2 cache driver.
> >>>>
> >>>> Then why aren't they compatible?
> >>>>
> >>>
> >>> The pL2Cache1 has removed some unused bits in the register compared t=
o
> >>> pl2Cache0.
> >>> From the hardware perspective, they are not compatible but they can
> >>> share the same pl2 cache driver in software.
> >>
> >> So they are compatible... If they were not compatible, you wouldn't be
> >> able to use the same match in the driver.
> >>
> >>> Thus, we would like to keep both. It would be great if you can provid=
e
> >>> some suggestions. Thanks.
> >>
> >> I propose to make them compatible, like every other piece of SoC. I
> >> don't see any benefit of having them separate.
> >>
> >
> > Hi Krzysztof,
> >
> > Sorry for the late reply.
> > The pl2 cache is our internal platform IP and is not part of any SoC.
> >
> > The reason why this driver is compatible with the hardware "pl2cache0" =
and hardware "pl2cache1"
> > is that it doesn't program the different parts of the config register
> > However, our internal software (e.g., bare-metal software) will program=
 these different parts,
> > so it needs to rely on the different compatible string to identify the =
hardware.
> >
> > Additionally, we would like the compatible strings to reflect which har=
dware is being used Thanks.
>
> I don't understand how does it contradicts anything I said. So you do
> agree with me? Or what?
>

Thanks for your suggestions. OK, I'll fix it in v2.

Best regards,
Eric Lin

> Best regards,
> Krzysztof
>
