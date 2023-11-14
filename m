Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAF87EB0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjKNNOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKNNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:14:00 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5283D18E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:13:57 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a81ab75f21so64677047b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699967636; x=1700572436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AC7zPHlfp71u7FmPMHHQXTaJtq2nEvQZ45ctd9G44Cc=;
        b=Lc7nIMzcZuqZj+4ZCWURjauJdITA46ouGp2tGzapwA240rPlaQn3ef6HCeX8PmhSzx
         uCx8nslVnCCBmZfeIm4SrdU2WATpdpVA1/V81D1hSpACYleXa5tVsS+s3qHrKACRS8WW
         Gn9xhRPoaACwUdXR0dnW7eOnJgiXfO3Sla96emXlEQNsAIYzxTBI3wYAej4GP+16LqHa
         ka+QlzuSjuEbI7xSznw4kDyE4OwtRKmdHcyjZhNii6GlWjsW6hj9fg4wjzEs84hW8DG0
         4P4dRJIFrbrOEUxaP9Y/Y2BKumLByFRn4mYR7vKnojnBXWPUI1kmrsgKQjudvnGR16aB
         L4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699967636; x=1700572436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AC7zPHlfp71u7FmPMHHQXTaJtq2nEvQZ45ctd9G44Cc=;
        b=rayXYSUVeuGiANIyoYXbWUnwJLJ/fBLfebV6LbzSw8/VnhLeU7tXM9NsEUdVfWVOAU
         9Rw3kZIbajU3mFst7WRjJ0vEL/3worNPH8vMnVWjlr+8TtV4xATdQ6Tca9ji4A0Ov4oF
         KnVbo4HZuIY7+E+FeEfST4YVwmnO2tajcfRcs9MXwDVGEUoIsXUpdX68qC4P4oCkIe8m
         foYbFmpGKEPtTnG0iDhfvK6QEoYITyN6aBrPN6xrMMHbBJAGb1sGYTLxVkg5jfgeEs8E
         nboOFEUEQWRcpxaYKOPBLtYwuyTxD+4Y4C+yNIt1jWrhHgLymUIV+mJ4v/7NBikXX789
         HOLQ==
X-Gm-Message-State: AOJu0YxCc/iclCPhck4iYQsnqqpLK8l7Ieu02qIi/ig3gZ5lUBVRtNFa
        uw1kdjb2OCQ8xEUQDAbqu1XDNSsTV2KT4NSmsbjkZA==
X-Google-Smtp-Source: AGHT+IFBYaHMZzCsW4AsGoZv9pa46ZVwMbrh03aGv7/fzr5sc0Qhx4V8IFGe0paIJ4dy0X6AbiRaIop+hJhMUG6cgDY=
X-Received: by 2002:a05:690c:4446:b0:5c1:25f:567e with SMTP id
 gq6-20020a05690c444600b005c1025f567emr10692579ywb.23.1699967636567; Tue, 14
 Nov 2023 05:13:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
 <e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com>
 <CACRpkdYW-xmejyOo9H9XSkcabvYgBqPvpjppvNe_RF6RLxyxKA@mail.gmail.com>
 <ZU2AP7leDcIZIN+b@octopus> <ZU5LFC23JaEidEGZ@pluto> <2535571d-6fea-4064-8325-0f47d031c85f@arm.com>
 <CACRpkdaRY+rU+md-r5gVyFH5ATt3Pqp9=M4=+WArYkfVLAFdpw@mail.gmail.com> <604aee95-ad46-4102-80aa-71c2c9d1729c@arm.com>
In-Reply-To: <604aee95-ad46-4102-80aa-71c2c9d1729c@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 14:13:44 +0100
Message-ID: <CACRpkdb-4fBSRDaXiqXWe3Yh_Z1ni4ScJHfC_bw+bm4dqT_kCA@mail.gmail.com>
Subject: Re: [RFC v5 5/5] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
To:     Souvik Chakravarty <souvik.chakravarty@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
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

On Mon, Nov 13, 2023 at 3:23=E2=80=AFPM Souvik Chakravarty
<souvik.chakravarty@arm.com> wrote:
> On 13/11/2023 13:32, Linus Walleij wrote:
> > Hi Souvik,
> >
> > thanks for looking into this!
> >
> > On Mon, Nov 13, 2023 at 1:56=E2=80=AFPM Souvik Chakravarty
> > <souvik.chakravarty@arm.com> wrote:
> >
> >> The initial assumption always was that GPIOs can be considered as a
> >> specific function. Note that the spec does not define the types of
> >> function and leaves it to the DT binding (or driver) to figure out the
> >> function descriptions/names.
> >
> > Does this mean that each system using pinctrl-SCMI will need
> > to specify the available pins, groups and functions in a device tree
> > binding? For e.g. DT validation using schema?
>
> Sorry seems I made a typo above ("descriptions/names" should have been
> "description from names") which resulted in turning things on its head.
>
> I really meant that the driver has to figure out the exact type or
> meaning of what the function does from its name. SCMI still continues to
> provide the list of pins/groups/functions and their names.

Indeed, that's what I imagined.

I think the rest of my question spurred by the phrase
"leaves it to the DT binding (or driver) to figure out" is actually
something Oleksii needs to look into more than a question to you.

It should probably come as a review comment to the patch 5/5 itself.

Oleksii, what is your take on my question about DT schema validation
for different SoCs?

Yours,
Linus Walleij
