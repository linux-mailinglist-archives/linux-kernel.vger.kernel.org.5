Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28887676A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjG1Tzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG1Tzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:55:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FF53C07;
        Fri, 28 Jul 2023 12:55:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52227142a27so3123786a12.1;
        Fri, 28 Jul 2023 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690574147; x=1691178947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnewSj+nxPC4rN/yj+rmk+zo+Gv7fJDwKRdhzvSKhXc=;
        b=osqRUqn6Yf76Yfw4RZk0cUmr8jJor/9NcWQhTSEslUj/m+jOsMghTNFZCFFMar+y4R
         +J4WXUYFDzhp74KK4avDw230R+Q9qD6+2SDqLrjsnkNBLc4iCIOAOaCtVkt9IDf7Km/2
         hQLkPLJdHeH2CI0TkejvuIYwIPWdwG8cvAZOGVogTQOSDSNEv9Mog+sCGTw45u6VnE4g
         NhnUbGUelR462TDLzOpB0bgvNjDxOYYZkQryOW+Ur9sccgy5T94rqBY6rtHNElLKlQ+u
         VUJGF24Jbk3pSN/DkDIJj92+ADxotTUbHP6SVj9HCam14wHLdPDyDEh4r29Dq8sqv0a9
         V1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690574147; x=1691178947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnewSj+nxPC4rN/yj+rmk+zo+Gv7fJDwKRdhzvSKhXc=;
        b=g57yLnIyfyFI0JI2LbBCYvy8pglblSCunRqLj2liLyj9XW/zSgh6tpzb1RJRgyE8tS
         tB8eIJP7aH2/ATSd69I+Y/JCY/UjxCEdQ/PAs27kF7i5X65kEwwviSvPIH3w8jeXhf0z
         wBuPD3wuQNaohE+XmKt7mSQ+XHK0ftjPmnMUMhWMPwGQ5nJMWSop5dEuanmgYpCjNfw+
         qrchTna4ehjjgTuTbxCr28btWi4HQJRK4IcrfMc/8SB7D+chgio2Ul+0Nu0LuWHtBlli
         NLm1Jtqd0b1VXoF5qVrvxR3sTUmBM05F/NTEjq4jRf3yCxbjt/36gNtWrTgda3PD/g1u
         4cBA==
X-Gm-Message-State: ABy/qLZIKV7KdBS5Y/ZCfFkEINx8mL69zBh9JXNzrVa1mVuwbMm9XaQG
        M1WQMLOdhquuz2LxhfA1J/w6X/8//fKjC4Nm73Y=
X-Google-Smtp-Source: APBJJlFFjgl1t0ZqKzGa3hb/R2FdQMV+qK86EbU+xnW2MhgvOJuQx7YYdSNq2sHYN8rqyjH5Es4cD36Biw94nlFiiLg=
X-Received: by 2002:a05:6402:12da:b0:521:d23d:6850 with SMTP id
 k26-20020a05640212da00b00521d23d6850mr2267699edx.21.1690574146676; Fri, 28
 Jul 2023 12:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230403175937.2842085-1-javierm@redhat.com> <3797122.KgjxqYA5nG@diego>
 <87pm4kuanl.fsf@minerva.mail-host-address-is-not-set> <4495367.TLkxdtWsSY@phil>
In-Reply-To: <4495367.TLkxdtWsSY@phil>
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
Date:   Fri, 28 Jul 2023 21:55:11 +0200
Message-ID: <CAO_Mup+JZjUyQK4yC8XwgcRpDU8_TTRJT0rjFQ6OpsEU1BnbJw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko

pt., 28 lip 2023 o 21:00 Heiko Stuebner <heiko@sntech.de> napisa=C5=82(a):
>
> Hi Javier,
>
> Am Samstag, 22. Juli 2023, 01:06:54 CEST schrieb Javier Martinez Canillas=
:
> > Heiko St=C3=BCbner <heiko@sntech.de> writes:
> > > Am Dienstag, 18. April 2023, 14:11:53 CEST schrieb Javier Martinez Ca=
nillas:
> > >> Heiko St=C3=BCbner <heiko@sntech.de> writes:
> > >> > Am Dienstag, 4. April 2023, 14:52:02 CEST schrieb Peter Geis:
> > >> >> On Tue, Apr 4, 2023 at 3:55=E2=80=AFAM Heiko St=C3=BCbner <heiko@=
sntech.de> wrote:
> > >> >> > Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez=
 Canillas:
> > >> >> > > This baud rate is set for the device by mainline u-boot and i=
s also what
> > >> >> > > is set in the Pinebook Pro Device Tree, which is a device sim=
ilar to the
> > >> >> > > PinePhone Pro but with a different form factor.
> > >> >> > >
> > >> >> > > Otherwise, the baud rate of the firmware and Linux don't matc=
h by default
> > >> >> > > and a 'console=3DttyS2,1500000n8' kernel command line paramet=
er is required
> > >> >> > > to have proper output for both.
> > >> >> >
> > >> >> > The interesting question is always if this will break someone e=
lse's setup.
> > >> >> > I've never really understood the strange setting of 1.5MBps, bu=
t on the
> > >> >> > other hand it _is_ a reality on most boards.
> > >> >
> > >> >> The 1.5M baud is default because the clock structure on rockchip
> > >> >> devices does not allow a clean 115200 baud. By attempting to forc=
e
> > >> >> 115200, it will always be slightly off (either low or high depend=
ing
> > >> >> on how the driver decided to round). If this actually causes any
> > >> >> problems is the subject of much debate.
> > >> >
> > >> > thanks so much for this piece of clock-detail. As I wrote, I never=
 really
> > >> > understood the why _before_ but also never cared that much to dive
> > >> > into it and find out.
> > >> >
> > >> > So your explanation closes one knowledge gap in my head.
> > >> >
> > >> > Thanks a lot :-)
> > >>
> > >> Did you make a decision about this? I guess the clock explanation is=
 yet
> > >> another argument in favour of switching the PPP to a 1.5 Mbps baud r=
ate ?
> > >
> > > Sorry, but no decision made here. Either way it's breaking for someon=
e,
> > > which makes this quite hard.
> > >
> >
> > Another ping on this patch.
> >
> > > The rate accuracy is the one side, the two-boot issue is the other si=
de.
> > > And mainline u-boot (and levinboot - whatever that is) provides a 3rd=
 side.
> > >
> > > People starting with the phone probably won't replace the bootloader
> > > in a first step but instead might play with a system image or newer k=
ernel.
> > > So if the uart will break for everyone using the default bootloader f=
rom
> > > the factory that is somewhat bad.
> > >
> >
> > Probably won't replace the DTB shipped with the firmware either? If one=
 is
> > replacing the firmware provided DTB witch the one in the mainline kerne=
l,
> > probably such person is also using mainline u-boot?
>
> Not necessarily.
>
> I.e. putting an extlinux.conf on an sd-card with a kernel-image and dtb
> is not rocket science ;-)
>
>
> > > I don't have a Pinephone Pro myself, so I really hoped for some Acks
> > > or similar to appear in the meantime.
> > >
> >
> > For someone like me who is only using mainline u-boot, linux, etc then
> > having a consistent uart baud rate across all components is really usef=
ul.
> >
> > Otherwise I either have serial console for u-boot or the kernel, but ca=
n't
> > have both working so is annoying.
> >
> > It would be good to have a definite answer on this. Since every time th=
at
> > I try to hack on my PPP, I end changing my DTS and remember this patch =
:)
>
> So far people only reported "breaks my setup". I'm in a pickle here ;-) .
> Without anybody saying "I want to also move into this direction" I really
> feel I should not merge a patch that breaks other peoples setups.

Well, I'd prefer 1.5M baud rate as it is more consistent with other Rockchi=
p
boards and it makes for a much more usable terminal experience when
logged in, it also doesn't affect boot times when serial is enabled with a
high loglevel and console on serial as 115200 does.

Though I'm just fine with using kernel's cmdline to set a baud rate.

*shrugs*

Best Regards,
Maya Matuszczyk

pt., 28 lip 2023 o 21:00 Heiko Stuebner <heiko@sntech.de> napisa=C5=82(a):
>
> Hi Javier,
>
> Am Samstag, 22. Juli 2023, 01:06:54 CEST schrieb Javier Martinez Canillas=
:
> > Heiko St=C3=BCbner <heiko@sntech.de> writes:
> > > Am Dienstag, 18. April 2023, 14:11:53 CEST schrieb Javier Martinez Ca=
nillas:
> > >> Heiko St=C3=BCbner <heiko@sntech.de> writes:
> > >> > Am Dienstag, 4. April 2023, 14:52:02 CEST schrieb Peter Geis:
> > >> >> On Tue, Apr 4, 2023 at 3:55=E2=80=AFAM Heiko St=C3=BCbner <heiko@=
sntech.de> wrote:
> > >> >> > Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez=
 Canillas:
> > >> >> > > This baud rate is set for the device by mainline u-boot and i=
s also what
> > >> >> > > is set in the Pinebook Pro Device Tree, which is a device sim=
ilar to the
> > >> >> > > PinePhone Pro but with a different form factor.
> > >> >> > >
> > >> >> > > Otherwise, the baud rate of the firmware and Linux don't matc=
h by default
> > >> >> > > and a 'console=3DttyS2,1500000n8' kernel command line paramet=
er is required
> > >> >> > > to have proper output for both.
> > >> >> >
> > >> >> > The interesting question is always if this will break someone e=
lse's setup.
> > >> >> > I've never really understood the strange setting of 1.5MBps, bu=
t on the
> > >> >> > other hand it _is_ a reality on most boards.
> > >> >
> > >> >> The 1.5M baud is default because the clock structure on rockchip
> > >> >> devices does not allow a clean 115200 baud. By attempting to forc=
e
> > >> >> 115200, it will always be slightly off (either low or high depend=
ing
> > >> >> on how the driver decided to round). If this actually causes any
> > >> >> problems is the subject of much debate.
> > >> >
> > >> > thanks so much for this piece of clock-detail. As I wrote, I never=
 really
> > >> > understood the why _before_ but also never cared that much to dive
> > >> > into it and find out.
> > >> >
> > >> > So your explanation closes one knowledge gap in my head.
> > >> >
> > >> > Thanks a lot :-)
> > >>
> > >> Did you make a decision about this? I guess the clock explanation is=
 yet
> > >> another argument in favour of switching the PPP to a 1.5 Mbps baud r=
ate ?
> > >
> > > Sorry, but no decision made here. Either way it's breaking for someon=
e,
> > > which makes this quite hard.
> > >
> >
> > Another ping on this patch.
> >
> > > The rate accuracy is the one side, the two-boot issue is the other si=
de.
> > > And mainline u-boot (and levinboot - whatever that is) provides a 3rd=
 side.
> > >
> > > People starting with the phone probably won't replace the bootloader
> > > in a first step but instead might play with a system image or newer k=
ernel.
> > > So if the uart will break for everyone using the default bootloader f=
rom
> > > the factory that is somewhat bad.
> > >
> >
> > Probably won't replace the DTB shipped with the firmware either? If one=
 is
> > replacing the firmware provided DTB witch the one in the mainline kerne=
l,
> > probably such person is also using mainline u-boot?
>
> Not necessarily.
>
> I.e. putting an extlinux.conf on an sd-card with a kernel-image and dtb
> is not rocket science ;-)
>
>
> > > I don't have a Pinephone Pro myself, so I really hoped for some Acks
> > > or similar to appear in the meantime.
> > >
> >
> > For someone like me who is only using mainline u-boot, linux, etc then
> > having a consistent uart baud rate across all components is really usef=
ul.
> >
> > Otherwise I either have serial console for u-boot or the kernel, but ca=
n't
> > have both working so is annoying.
> >
> > It would be good to have a definite answer on this. Since every time th=
at
> > I try to hack on my PPP, I end changing my DTS and remember this patch =
:)
>
> So far people only reported "breaks my setup". I'm in a pickle here ;-) .
> Without anybody saying "I want to also move into this direction" I really
> feel I should not merge a patch that breaks other peoples setups.
>
>
> Heiko
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
