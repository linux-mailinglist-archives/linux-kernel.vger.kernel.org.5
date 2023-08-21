Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73527783476
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjHUUkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjHUUkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:40:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C2BCF8;
        Mon, 21 Aug 2023 13:39:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a3daf4cf7so1063668b3a.3;
        Mon, 21 Aug 2023 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692650389; x=1693255189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PfMPWJprUMeF8yP4267Fv+3PTsEN7ohaQVGNdsReww=;
        b=F2uDiF6btZa//mCPLdBcxOezN6eOhYE+6rCZI2JQWkpc9J0lHanMnjHjChtyhL7ekB
         I9p5RwaBn2udWUmcwTzm/HzpOwFb2/oQ8ybE6igG5DO4PZtOYF8FBSr5fYF91Fzou2uq
         9mMTqSEPk3es4kiwOf6+/piKH6acaQLL3LhuaflXRpeKvfq/mwNBZr1AVsiuLwH0wsAg
         Kwzma6HLLJVZCvfDaf/GhHoEjl+5TyeOd7A6U7jbvVOPPQH+MnOaaxCcABLgf8vdqerb
         1VtfvXA4bj1SH8skWHvWT8qI2c2PYc7yOfCoxPwPjZcOdZzfHk6AG57x65BnBzA0tho2
         oMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692650389; x=1693255189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PfMPWJprUMeF8yP4267Fv+3PTsEN7ohaQVGNdsReww=;
        b=Ug6SP0zsrJUo37cSIjvrkDWq5wvkKaKhiXMj0xLnFCDHm6gi9hHeOT78iNF/SMgSBW
         WpBBMOt1bvtcJCx9qZf5FmOkXLKGaTEuNCd/s6CFu1yWwa4n/5JvU4QndBYoRWn6ikH8
         zdx5cDf9N1hb4w0qo19en9rH37cegT+cMecYEWLmNWwCEmJmAu/V5YUO2PPlkHj43mFa
         mdXoOVMLjPUh0cMUceuXnuN4E5S46brhCnJIZPR6bbuuZhQQHUAuHSEPRSfrmtmZp9aI
         gU4DEV7Z/FIYx+0W9KCAqznFu2PXE6LzD0GV6rsAAZOprvBNFKvYLN+syTYc5qhvbatq
         pPTA==
X-Gm-Message-State: AOJu0YxvVji1Ix/WX69oAHYr4vvc0IoaxLY6+UsH+gnxCnsryR7BFdTl
        MVdgYrMrjna8zvz8c0E1R8rfpQpH2QIgNRxVs94=
X-Google-Smtp-Source: AGHT+IFJ6VWQoJxbLlcRzqZIquS45TqT59njPW+AujFPnvqV4Mw4QFxfQOxypL8pxzIdg85/A+5XPNeT6uJQc4R7Fcc=
X-Received: by 2002:a05:6a21:78aa:b0:148:184c:d4e8 with SMTP id
 bf42-20020a056a2178aa00b00148184cd4e8mr7250873pzc.2.1692650388807; Mon, 21
 Aug 2023 13:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230815140030.1068590-1-robimarko@gmail.com> <83cc4b10-34bf-ea91-7756-f345c0071479@linaro.org>
 <20230821193152.GA2157670-robh@kernel.org> <CAOX2RU6be+eeTPT7HbC8_-C7d7oVhspsXWOmwtgg6s=QMe6QEg@mail.gmail.com>
 <CAN8TOE96PjH67+vmi7mksSvqeMdLNBd8MH3m=1Ft_h+TXbk4BA@mail.gmail.com>
In-Reply-To: <CAN8TOE96PjH67+vmi7mksSvqeMdLNBd8MH3m=1Ft_h+TXbk4BA@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 21 Aug 2023 22:39:37 +0200
Message-ID: <CAOX2RU489vQZKNoJOUjZObF4oUFab_oZvuGMnPqAru=g08oz4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: firmware: qcom,scm: Document SDI disable
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 at 21:44, Brian Norris <computersforpeace@gmail.com> wr=
ote:
>
> On Mon, Aug 21, 2023 at 12:35=E2=80=AFPM Robert Marko <robimarko@gmail.co=
m> wrote:
> > On Mon, 21 Aug 2023 at 21:31, Rob Herring <robh@kernel.org> wrote:
> > > Why can't you just disable SDI unconditionally when going into debug
> > > mode? Is doing that when not enabled going to crash the system or
> > > something?
>
> I asked the same, to resounding silence:
>
> https://lore.kernel.org/all/20200721080054.2803881-1-computersforpeace@gm=
ail.com/
> https://lore.kernel.org/all/ZNlhSdh0qDMieTAS@localhost/
>
> > Because if not disabled you will enter the Secure Debug mode even on a
> > regular reboot and then you have to pull the power in order to boot aga=
in.
> > Even according to QCA docs they intended for the Linux to disable SDI a=
s
> > TZ/QSEE will always enable it as part of booting.
>
> NB: I've never read such docs. Presumably they're internal/private to
> Qualcomm and/or its direct partners? I'd love to see them.

Sadly they are all behind the NDA.

>
> But, I think you (robinmarko) are not really answering the same
> question that Rob (robh) is asking. Rob is asking why you ever *don't*
> want to disable SDI. You're answering why we ever need to disable it
> at all. I don't think the latter question is controversial.

I understood his question differently, hence my answer.

>
> FWIW, your description of those docs sounds like we should
> unconditionally *disable* SDI (like my first RFC above), which would
> answer Rob's question, and would agree with my RFC above :) And as a
> bonus, no Device Tree change would be required.

Well, the thing is that I only have docs for some of the IPQ chips, and wit=
h
the insane variety of SoC-s that use SCM and TZ/QSEE but completely
different FW base or version something would break for sure so I would
prefer to opt-in if its really required as SDI was something that was until
IPQ5018 came along, always disabled by default, except for the weird
Google WiFI board.

Regards,
Robert
>
> Brian
