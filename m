Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2BF7B624B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjJCHM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjJCHMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:12:54 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1541383;
        Tue,  3 Oct 2023 00:12:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9338e4695so6243881fa.2;
        Tue, 03 Oct 2023 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696317170; x=1696921970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VpvT/D80OxJ4afszuNnSX5OlIZElw6h6KH28boI+JUo=;
        b=TE9K0aqpxYh9qFPIDdmYIugphqjuUEVf0d1FAuZNqr1E9RygMjpM9wQkkwz7Um5wLR
         XjQCb6RQOwJ4pzV+hD61yhcLS3lFAS1AMFLk20KdnEC4zoi0UcrdfEqqdI4ujBuu+D7D
         3WAuLAJ3bphcoZfHW1x66X2C1Tpwrfihn3tgbVs0aBd94QXVzWGz/WhzpJMqbVmxL0i3
         uWp4R7Uzkcc0ExrH8HTEPM+pcQNojNT+wE2bnXsF3JqV0otLvHJ8Y6cQPYzUvNUfFj3f
         S64b5o5pEapizzYe+qzBf3jamjvgOac2k+DcCUGQsGZPuZsRMe6SiI8Nh2r4+twL6yyM
         PbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696317170; x=1696921970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpvT/D80OxJ4afszuNnSX5OlIZElw6h6KH28boI+JUo=;
        b=KKLsJJ3niqdA1+nbDgUtVem+hlu4SvMltX2JL4awNxmBS3ulbgMx1BBEOMorpGVJUO
         b2iSjwzvE8mCAj0t/bxbApj8NGoHjPjCSYa2RzTPOSfM61piimV8zzGiqO2Uvp1NppoN
         cLrcIDHfEy6D6D8qkXC968ODP9oXS+RCznzfAyAjlM/heWV1GT6Ot8Y5XR09qr6T6NAf
         l7D+heptMfGXnYdsERvb/ETTFZFmm8g4Xx3l0rWQPxOncfPr7Qs8DNbvqMUqDm3/OL+g
         pTHgArar210vzp+3o4TwD38GNT+EpDGJJPdQNokyThDlC6XgNkX2wbYkvgue+XWo2Bv+
         L5Og==
X-Gm-Message-State: AOJu0YyT+TqMy2qRlS8inFx26SN2W+c3xIsUs3BYsE+2wEcPgqJaOBBP
        yTdLXpdbZc2fFpOZQD1PmAt5kJjHVgYIvf30Jbc=
X-Google-Smtp-Source: AGHT+IF/2qtL9lsTpoepg5ulXqwKd8bMtdNP5zrBn2lfZWD9LWZVW6RTD0ONNE313l5Zh4wEN8dsF04KIvlNA2yiadc=
X-Received: by 2002:a2e:a3c5:0:b0:2c0:a2:77d7 with SMTP id w5-20020a2ea3c5000000b002c000a277d7mr10724615lje.24.1696317170212;
 Tue, 03 Oct 2023 00:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231002161350.64229-1-tmaimon77@gmail.com> <2023100323-reunite-upfront-8922@gregkh>
 <CAP6Zq1jHzRP1Ytzk8YXyR8ppAP=ZoPvPkYvC2yMRfTt5140zqw@mail.gmail.com> <2023100342-unnerving-diaphragm-cf36@gregkh>
In-Reply-To: <2023100342-unnerving-diaphragm-cf36@gregkh>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 3 Oct 2023 10:12:39 +0300
Message-ID: <CAP6Zq1j-uqwCCXF6aJA9Y2GynHRrPXiLjZM90ORqmNDT9vFKRw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 0/3] usb: ChipIdea: add Nuvoton NPCM UDC support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     peter.chen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xu.yang_2@nxp.com,
        peng.fan@nxp.com, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O.K.

Thanks a lot

Tomer


On Tue, 3 Oct 2023 at 10:05, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 03, 2023 at 09:56:47AM +0300, Tomer Maimon wrote:
> > Hi Greg,
> >
> > Forgot to add in Acked-by: Peter Chen <peter.chen@kernel.org> in V3,
> > Resend the patch set with the Ack.
> >
> > Should I do it differently?
>
> You need to tell me what the difference is, otherwise I would have no
> clue what to do, what would you do if you had to review all of these and
> try to figure out which ones to accept?
>
> Please send this as a v4.
>
> thanks,
>
> greg k-h
