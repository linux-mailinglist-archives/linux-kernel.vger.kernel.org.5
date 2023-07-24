Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791F075F5A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjGXMHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGXMHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B31A1;
        Mon, 24 Jul 2023 05:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACCA61113;
        Mon, 24 Jul 2023 12:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DBFC433C8;
        Mon, 24 Jul 2023 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690200436;
        bh=mUzc4Ur1XvYCglWORhoouHVsGfP5Zuo7LALNOIroXA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nD+C2LDdhcXj+EtTw57POQ+IRCZqZyhOq0jbissoR4ryS62oI6EG7Mz9vZAQLBQMI
         sFWQfJh8Jkwhk/GaFvnHlTLw6MaOnHniHuBAR8HhUO6rlxqMzXxV38ZWbd/Adwt0bL
         sy+tT0k1wTEWcgl1RtFYyur4szZLlHaYTE8IWzOhnWywNL09/3jIGE5/qGnWlQL4La
         xZeUrKGqpXg2WELoQ43FjBTl0RjZCz6NIpoYiFRGGlasaVaG8NRU+gKiTT6RD3v0jj
         ov1kEP0NNpSzVsuR8mWZbK4nvv6kq17AMWKLt1zt0ntCHT40JwUOkoxGbgnW/hOmDj
         Q50yENGLj/umw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99357737980so727016966b.2;
        Mon, 24 Jul 2023 05:07:16 -0700 (PDT)
X-Gm-Message-State: ABy/qLYYMsJMca6lU/hPrtWr5XYlBYhEIMPMKKPVop6Ugh/WlXGuMacp
        2CLCWYwdk/sQR6mO6FUIPo8PN6lGnjuik1Xcqg4=
X-Google-Smtp-Source: APBJJlEyloc5DakAYqh6G8yHellhKgyr+9w2ynhQc6zoeQUHTTaspueWL6G8z+BSg5VtR0UUv51nNMHOKZoM0BoQTTg=
X-Received: by 2002:a17:906:3193:b0:994:5592:ba61 with SMTP id
 19-20020a170906319300b009945592ba61mr10340385ejy.0.1690200434376; Mon, 24 Jul
 2023 05:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v1-1-ccda511357f4@baylibre.com>
 <20230723-savor-trolling-e35ed4a7a751@spud> <ZL1jlacHj7sgNg8M@x1>
 <ZL3Eenj4lGZDhZTM@xhacker> <20230724-census-party-0a50d1563075@wendy>
In-Reply-To: <20230724-census-party-0a50d1563075@wendy>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 24 Jul 2023 20:07:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQrdM2+u=ek_dCYZHVAgJHvzpCknZ14xRR=s_yCFRJcTQ@mail.gmail.com>
Message-ID: <CAJF2gTQrdM2+u=ek_dCYZHVAgJHvzpCknZ14xRR=s_yCFRJcTQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: dts: thead: add BeagleV Ahead board device tree
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Conor Dooley <conor@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 6:38=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Mon, Jul 24, 2023 at 08:23:22AM +0800, Jisheng Zhang wrote:
> > On Sun, Jul 23, 2023 at 10:29:57AM -0700, Drew Fustini wrote:
> > > On Sun, Jul 23, 2023 at 11:32:17AM +0100, Conor Dooley wrote:
> > > > On Sat, Jul 22, 2023 at 02:55:39PM -0700, Drew Fustini wrote:
> > > >
> > > > > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > > @@ -0,0 +1,61 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > >
> > > > Hmm, should this not be dual licensed?
> > > > I notice the other th1520 stuff isn't either..
> > >
> > > Good point, I'll resubmit with a dual license.
> > >
> > > Jisheng: are you okay with the other arch/riscv/boot/dts/thead files
> > > changing to a dual license?
> >
> > When cooking the initial patch, I wrote the lpi4a dts files from
> > scratch based on sipeed opened sch file, and currently only I made
> > contributions to them, so it's easy to make the lpi4a dts files
> > dual license.
> >
> > However, when constructing the th1520.dtsi, I refered the T-HEAD's
> > opensourced yocto repo(in fact, that's the only sourcecode/doc I have
> > at that time), and the license there is GPL-2.0. That's
> > also the reason why copyright of Alibaba Group Holding Limited is
> > added to th1520.dtsi. I'm not sure how to make th1520.dtsi dual
> > license. At least, this needs help from Guo Ren. Any suggestion is
> > appreciated.
>
> I think Guo Ren Acking the change should be sufficient. It'd be good to
> have them dual licensed to make it easier for other projects to include
> the dts files from Linux. Almost all of what we have at the moment is
> dual licensed, other than the Canaan stuff & some board dts files I got
> from customers that were only GPLed.
Yes, dual license is okay for us.



--=20
Best Regards
 Guo Ren
