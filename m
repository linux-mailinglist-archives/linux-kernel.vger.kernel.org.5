Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD657754041
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjGNRPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGNRPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CBB1BF3;
        Fri, 14 Jul 2023 10:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0577B61D7E;
        Fri, 14 Jul 2023 17:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B906C433C8;
        Fri, 14 Jul 2023 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689354904;
        bh=4cZN/0yPBRg716uGY862ik2lzGILyhxLtVW1gjub4RQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HrS1OMo40K9SGEnFXfWqSCA4sqVQpUw3vDGxvQs9MXbJrAA0cC7Ix/oUdbYrS1ITN
         BqrYaZARZhbCLLzELlfnqqLeMPMECIbsBPzL26FPaG2HoipukDMciYCrfUCDZJaJLi
         zh/WhS0PkeJwAg3u20Sq5GL9Atk+CkRA+D9da2o7/Vj0cTlBsBElZdblVCBGG3mnaU
         NwfTh/prZEXznMzj+POGFuTmvAhJRYj2N8FBjtk0Fjw8QF1N/hudS60E7yTY3bUmCB
         T0zoALchAviCcQRi414eHuGDa8+P+LAY/gypxeevTaNZzfqVu5FvkFLtoahFzZwI3w
         /4hNmjiP1ee1A==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b6fbf0c0e2so33188901fa.2;
        Fri, 14 Jul 2023 10:15:04 -0700 (PDT)
X-Gm-Message-State: ABy/qLY3kaOkCBHS7yJX9ZWahqAE7uAPsOSJJhLazHY/+kmkbZ0+ck9C
        OqLTNmV2Y1buJqejkeX8SA6xDNSXU18tKfgKrg==
X-Google-Smtp-Source: APBJJlGIxEBd73gVlh9uEFRoSwIasdT7k7nyJT8l6WaM+W0IJi4Bvebcn1js9k4uyMMXWs5l7K6uQ9AJUu8BvgL7Pug=
X-Received: by 2002:a2e:9158:0:b0:2b7:7b9:4767 with SMTP id
 q24-20020a2e9158000000b002b707b94767mr4532281ljg.41.1689354902353; Fri, 14
 Jul 2023 10:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-10-ulf.hansson@linaro.org> <20230614230044.GA3019052-robh@kernel.org>
 <CAPDyKFoDQ12yUB-3f_V222kcUivP_NUcvcM+8s7CraLaBy7tBQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoDQ12yUB-3f_V222kcUivP_NUcvcM+8s7CraLaBy7tBQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Jul 2023 11:14:50 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+GMA62hey6+KYMmVSWsDEkGfD0B=0V9AbdmRqdE6VW1g@mail.gmail.com>
Message-ID: <CAL_Jsq+GMA62hey6+KYMmVSWsDEkGfD0B=0V9AbdmRqdE6VW1g@mail.gmail.com>
Subject: Re: [PATCH 09/16] dt-bindings: firmware: arm,scmi: Extend bindings
 for protocol@13
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 3:11=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Thu, 15 Jun 2023 at 01:00, Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Jun 07, 2023 at 02:46:21PM +0200, Ulf Hansson wrote:
> > > The protocol@13 node is describing the performance scaling option for=
 the
> > > ARM SCMI interface, as a clock provider. This is unnecessary limiting=
, as
> > > performance scaling is in many cases not limited to switching a clock=
's
> > > frequency.
> > >
> > > Therefore, let's extend the binding so the interface can be modelled =
as a
> > > generic "performance domain" too. The common way to describe this, is=
 to
> > > use the "power-domain" bindings, so let's use that.
> >
> > What's wrong with the performance-domain binding?
>
> In my opinion I think the performance-domain binding is superfluous.
> We already have plenty of power-domains that do performance scaling
> too - and they stick with the power-domain binding, as it's
> sufficient.

IMO, power-domains should be for power islands which can be power
gated. I know they are abused though. Of course, when things are
hidden in firmware, you don't really know. A power-domain could be
just a clock or a clock could be multiple physical clocks.

> That said, I would rather follow the defacto standard that has been
> used for many years in the kernel. Do you have a preference that we
> should stick to?

If power-domains are sufficient, then why do we have
performance-domains? We need clear rules for when to use what.

Rob
