Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE95C75D7D0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 01:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGUXHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 19:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGUXHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 19:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FFA269F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689980819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NasJhN8fBoLwgmMb8fDN81QOfOt3NYCI8cJ6HWiK1WI=;
        b=DhJH/s6QyvfYUAo/a2i3YbOifJRSJuJPF64XxH/gi1zVIr5maQgeU5UtzJ0UKYZjdtONzJ
        WLW/WfLUv2sVYX/jdpYKZWEb2dVNwfCWdwIcTncay1OcooAasDvYfM8qIhM7mq+vJ2h6gb
        KucNGNAVrjgyCq4a0REHd6rDQ1TUeEs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-31IweEmZNoGE5SlQyqCo2A-1; Fri, 21 Jul 2023 19:06:57 -0400
X-MC-Unique: 31IweEmZNoGE5SlQyqCo2A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbb0c01e71so13547965e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689980817; x=1690585617;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NasJhN8fBoLwgmMb8fDN81QOfOt3NYCI8cJ6HWiK1WI=;
        b=Nsl4wI/pma2WeQnvcaAerTOLTzx7XScx6bGgFvtAZQIG2y3ZYLMXfpDIgUveWyCzhu
         exW+ETGpYKSRyIJjR50hlqDZdop97Cr5qkF43EY9ja0fNO6h1T5xhhXDw0e4tvGe6Kj4
         M+GUM0aPfL1YeL+gfKuGj+p59KtSqAYea6E1WzLkaipUGymum0lGjj27oxFLTHtPiR3j
         WymWp7CMkdshqbK3L0DCRX0ja96TCqzlNIzqWsr2Yww5NY8dSrnj+Q6S/jdahOFCPPgN
         qKWJiEjNFMCjwE9YOjGJXXSs8NOnAE86hcWrlSaHdEkj3ghrBUGJ0VExVIEEs7KdiUwZ
         FhtQ==
X-Gm-Message-State: ABy/qLaqw6CqTZZg6SrDSX2kdlc62xvgeGPRP23LVHMWgsgaOUp16EsI
        b7wgtOCWOADOuRZ7Cye1YoIGGqfLJHQMADCpUi85FP1tt3A4Xqu3z5eMY2AKvORdGZ1Bks6Ox6O
        58hIN+CXELQEaqaju3vASTlPH
X-Received: by 2002:a5d:4050:0:b0:313:deda:c444 with SMTP id w16-20020a5d4050000000b00313dedac444mr2019788wrp.24.1689980816821;
        Fri, 21 Jul 2023 16:06:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH7shqVKurWd3w6vZ/GI3t7GZG76b0T/0WRqT0uW1YqcIy1k3JSfhPh4mjonUVEUk67D08HEw==
X-Received: by 2002:a5d:4050:0:b0:313:deda:c444 with SMTP id w16-20020a5d4050000000b00313dedac444mr2019779wrp.24.1689980816528;
        Fri, 21 Jul 2023 16:06:56 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600001cd00b00316eb7770b8sm5376648wrx.5.2023.07.21.16.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 16:06:55 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
In-Reply-To: <3797122.KgjxqYA5nG@diego>
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3999080.iIbC2pHGDl@diego>
 <87h6tdie46.fsf@minerva.mail-host-address-is-not-set>
 <3797122.KgjxqYA5nG@diego>
Date:   Sat, 22 Jul 2023 01:06:54 +0200
Message-ID: <87pm4kuanl.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko St=C3=BCbner <heiko@sntech.de> writes:

Hello Heiko,

> Hi,
>
> Am Dienstag, 18. April 2023, 14:11:53 CEST schrieb Javier Martinez Canill=
as:
>> Heiko St=C3=BCbner <heiko@sntech.de> writes:
>>=20
>> Hello Heiko,
>>=20
>> > Hi Peter,
>> >
>> > Am Dienstag, 4. April 2023, 14:52:02 CEST schrieb Peter Geis:
>> >> On Tue, Apr 4, 2023 at 3:55=E2=80=AFAM Heiko St=C3=BCbner <heiko@snte=
ch.de> wrote:
>> >> >
>> >> > Hi,
>> >> >
>> >> > Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez Can=
illas:
>> >> > > This baud rate is set for the device by mainline u-boot and is al=
so what
>> >> > > is set in the Pinebook Pro Device Tree, which is a device similar=
 to the
>> >> > > PinePhone Pro but with a different form factor.
>> >> > >
>> >> > > Otherwise, the baud rate of the firmware and Linux don't match by=
 default
>> >> > > and a 'console=3DttyS2,1500000n8' kernel command line parameter i=
s required
>> >> > > to have proper output for both.
>> >> >
>> >> > The interesting question is always if this will break someone else'=
s setup.
>> >> > I've never really understood the strange setting of 1.5MBps, but on=
 the
>> >> > other hand it _is_ a reality on most boards.
>> >
>> >> The 1.5M baud is default because the clock structure on rockchip
>> >> devices does not allow a clean 115200 baud. By attempting to force
>> >> 115200, it will always be slightly off (either low or high depending
>> >> on how the driver decided to round). If this actually causes any
>> >> problems is the subject of much debate.
>> >
>> > thanks so much for this piece of clock-detail. As I wrote, I never rea=
lly
>> > understood the why _before_ but also never cared that much to dive
>> > into it and find out.
>> >
>> > So your explanation closes one knowledge gap in my head.
>> >
>> > Thanks a lot :-)
>>=20
>> Did you make a decision about this? I guess the clock explanation is yet
>> another argument in favour of switching the PPP to a 1.5 Mbps baud rate ?
>
> Sorry, but no decision made here. Either way it's breaking for someone,
> which makes this quite hard.
>

Another ping on this patch.

> The rate accuracy is the one side, the two-boot issue is the other side.
> And mainline u-boot (and levinboot - whatever that is) provides a 3rd sid=
e.
>
> People starting with the phone probably won't replace the bootloader
> in a first step but instead might play with a system image or newer kerne=
l.
> So if the uart will break for everyone using the default bootloader from
> the factory that is somewhat bad.
>

Probably won't replace the DTB shipped with the firmware either? If one is
replacing the firmware provided DTB witch the one in the mainline kernel,
probably such person is also using mainline u-boot?

> I don't have a Pinephone Pro myself, so I really hoped for some Acks
> or similar to appear in the meantime.
>

For someone like me who is only using mainline u-boot, linux, etc then
having a consistent uart baud rate across all components is really useful.

Otherwise I either have serial console for u-boot or the kernel, but can't
have both working so is annoying.

It would be good to have a definite answer on this. Since every time that
I try to hack on my PPP, I end changing my DTS and remember this patch :)

> Do we have someone with an actual Pine64 affiliation in this loop?
>

I don't think pine64 cares that much about the software. They just build
the hardware and expect the community to add the support I believe.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

