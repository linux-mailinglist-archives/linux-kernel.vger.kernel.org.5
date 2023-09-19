Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C777A682A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjISPdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjISPdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:33:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD0591;
        Tue, 19 Sep 2023 08:33:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEB6C433C8;
        Tue, 19 Sep 2023 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695137617;
        bh=yOR7LqcC6UnVhoCsLDoSMz+eMVTQCK/pdNaacI/x5Bo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZAIUBNC/0qwXAq6gm6nKiIr3sLLP03cF8m49gRipwAlqyc3n2vpJ8GuW969o3W9YH
         /yGlMc0NF46oZejYW5fztUuvKUhX90Mod5vTRGIAcEYxpjQ+O04Aojzx2S2s7GLrga
         +pfqh4jMLapazvEqviIzEXhCQFMNLJkmFt6DdXxJV2waXIXL171197UXR2VdTEmTgq
         QE3l64QSGv/LvihIGFWEs7QYtzxXrInypDUgESDo9gH05jFUSY4FfPpgIgmMBhx7tt
         eTKTScynJZ3in0zD/9ynzm3IBLknxAhSo83FOTySFP+VchPr3zGfmKyhXDZPb0lHJi
         Eaj+0VfHzcYNQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50336768615so885797e87.0;
        Tue, 19 Sep 2023 08:33:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YzpHDa+0TU8wcvoMcW/M8DziGXQvuZdeXfY4zOJPygMOBeRFcAI
        uqwZCDZuGfcIvuDG2hS/sD6AuFQuZ6877PwFbg==
X-Google-Smtp-Source: AGHT+IG4NemizbroTHabZqJmVRYbfzQj/Z71eTpMw47wZmTM8LxdOwDVEuRVse/8BE4YHVprFzwItJWQTZKQPAmGY7o=
X-Received: by 2002:a05:6512:10d1:b0:4ff:9a75:211e with SMTP id
 k17-20020a05651210d100b004ff9a75211emr29911lfg.42.1695137615334; Tue, 19 Sep
 2023 08:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230911214623.2201324-1-robh@kernel.org> <CAMuHMdXAW6MNEdo+vuTPkpGPXa0ebfG3Ec_=i0UhEtt6YfSQeQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXAW6MNEdo+vuTPkpGPXa0ebfG3Ec_=i0UhEtt6YfSQeQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Sep 2023 10:33:22 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+kj8Sui1eQJNdqm34ENQoPCk5Q1NDYg2gag9akBoLmDw@mail.gmail.com>
Message-ID: <CAL_Jsq+kj8Sui1eQJNdqm34ENQoPCk5Q1NDYg2gag9akBoLmDw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: Apply overlays to base dtbs
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 7:08=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Rob,
>
> On Mon, Sep 11, 2023 at 11:47=E2=80=AFPM Rob Herring <robh@kernel.org> wr=
ote:
> > DT overlays in tree need to be applied to a base DTB to validate they
> > apply, to run schema checks on them, and to catch any errors at compile
> > time.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Thanks for your patch!
>
> > Looks like some of these apply to multiple base DTs. I've only added th=
em
> > to 1 base.
>
> Indeed:
>   - draak-ebisu-panel-aa104xd12.dtbo applies to r8a77990-ebisu.dtb, too,
>   - salvator-panel-aa104xd12.dtbo applies to all salvator-x(s) variants.
>
> So should they be added to all bases they apply to?

I'll leave that to you. All depends what combinations you want to
validate. I just don't want overlays in the kernel that don't have a
base in the kernel.

> Or, if you intend none of the composite DTBs to be consumed as-is, but
> only intend them to be created for validation, perhaps the additional
> rules should be grouped together at the bottom of the Makefile?

Folks may want the composite DTBs if their bootloader can't apply them
or they don't want to mess with it in the bootloader.

> > --- a/arch/arm64/boot/dts/renesas/Makefile
> > +++ b/arch/arm64/boot/dts/renesas/Makefile
> > @@ -64,6 +65,8 @@ dtb-$(CONFIG_ARCH_R8A779F0) +=3D r8a779f0-spider.dtb
> >
> >  dtb-$(CONFIG_ARCH_R8A779G0) +=3D r8a779g0-white-hawk.dtb
> >  dtb-$(CONFIG_ARCH_R8A779G0) +=3D r8a779g0-white-hawk-ard-audio-da7212.=
dtbo
>
> Do you still need the individual *.dtbo rules? Perhaps you are
> afraid that make will auto-delete them as they are only used as
> intermediaries?

Yes you need them if you want to install the .dtbo's. I'm not sure
offhand if it matters for cleaning.

Rob
