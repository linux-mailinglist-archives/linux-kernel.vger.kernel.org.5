Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8867C561F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjJKOCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjJKOCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:02:50 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FE393;
        Wed, 11 Oct 2023 07:02:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01B7140004;
        Wed, 11 Oct 2023 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697032966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AmDid+2p5omqPQxMszlLHuNt/K12o40KfGGotdHRA4A=;
        b=fxkhROQypXEGEU25tCB1qFGhCBWiY7ChPSURIW48jG2TDWzf1Hs2f+d5jYfOdwyALI9Ven
        Az9tOMNZ49Sb+/fcBjwht/+vyXww0yARVBlafJsON1TIajAPJiOzWZrcgmWthQyJuyGSpy
        DadE20n8nsGPhXWuaM0d/t9UqwA2txhlMNlPoHxWsWeGv/G5Dr95OUNhC2rzWisyrPZ+jl
        pw3CL+XMwf6rqf5SvKn7Pf8V4Q6FudA6Fjjx8NwpdO6GCKrLMwABEaAM44NPbxytlnWvPE
        3qrO5CQ6hUZtHPAkOJWflWy/vcwWVKxZYa9vtxc3K6svT24dz36CqWTclQbjeA==
Date:   Wed, 11 Oct 2023 16:02:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v12 7/7] nvmem: core: Expose cells through sysfs
Message-ID: <20231011160243.4893729d@xps-13>
In-Reply-To: <a67f5fd1-6b5c-662d-5ab3-b528c2080efc@linaro.org>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
        <20231005155907.2701706-8-miquel.raynal@bootlin.com>
        <318fe799-f53e-64ed-b631-d099bb5202f4@linaro.org>
        <20231011091524.0c9ecc55@xps-13>
        <548849a8-9f11-5274-778e-f291267603bb@linaro.org>
        <20231011103306.08f1fbd4@xps-13>
        <fe4a2688-079c-a36d-0ea4-c244c6e1a0ad@linaro.org>
        <20231011105829.778bed58@xps-13>
        <490c6740-06cb-9ee6-ca8c-3ab404109344@linaro.org>
        <20231011114419.21821f4d@xps-13>
        <8b8403ee-b610-312b-aa98-3e4fa65a3800@linaro.org>
        <20231011130931.3b6216aa@xps-13>
        <a67f5fd1-6b5c-662d-5ab3-b528c2080efc@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 14:56:02 +0100:

> On 11/10/2023 12:09, Miquel Raynal wrote:
> > Hi Srinivas,
> >=20
> > srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 11:02:16 +0100:
> >  =20
> >> Hi Miquel,
> >>
> >> On 11/10/2023 10:44, Miquel Raynal wrote: =20
> >>> Hi Srinivas,
> >>>
> >>> srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 10:26:43 +01=
00: =20
> >>>    >>>> On 11/10/2023 09:58, Miquel Raynal wrote: =20
> >>>>> Hi Srinivas,
> >>>>>
> >>>>> srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 09:45:11 +=
0100: =20
> >>>>>     >>>> On 11/10/2023 09:33, Miquel Raynal wrote: =20
> >>>>>>> Hi Srinivas,
> >>>>>>>
> >>>>>>> srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 09:27:20=
 +0100: =20
> >>>>>>>      >>>> On 11/10/2023 08:15, Miquel Raynal wrote:
> >>>>>>>>>>> +
> >>>>>>>>>>> +	nvmem_cells_group.bin_attrs =3D cells_attrs;
> >>>>>>>>>>> +
> >>>>>>>>>>> +	ret =3D devm_device_add_groups(&nvmem->dev, nvmem_cells_gro=
ups);
> >>>>>>>>>>> +	if (ret)
> >>>>>>>>>>> +		goto unlock_mutex; =20
> >>>>>>>>>> This is going to create groups after the nvmem device is added=
, isn't this going to be problem with user space notifications? =20
> >>>>>>>>> Greg said it was not. I hope I understood correctly =F0=9F=98=84
> >>>>>>>>>
> >>>>>>>>> And anyway, cells have never been available to userspace, so th=
ere is
> >>>>>>>>> nothing userspace might expect yet? =20
> >>>>>>>> I agree, but once we add sysfs uapi then this is going to change=
. =20
> >>>>>>>
> >>>>>>> Can you elaborate? I'm not sure I follow you here. Is there still=
 a
> >>>>>>> problem you fear or you think it's okay? =20
> >>>>>>>      >> Now that we add cells to sysfs. =20
> >>>>>> AFAIU, By the time the userspace sees the udev event from this dev=
ice we might not have cells populated. =20
> >>>>>
> >>>>> Yes, but why would this be a problem? =20
> >>>>>     >> It will be problem if the userspace is using things like lib=
udev to act on these events. There seems to be some caching of attributes i=
n udev during event more info http://www.kroah.com/log/blog/2013/06/26/how-=
to-create-a-sysfs-file-correctly/ =20
> >>>
> >>> I am already using these attributes, right? The problem here is that =
we
> >>> always attach cells sysfs attributes to the nvmem device, but in some
> >>> cases (when using layout devices/drivers) the probe of these devices
> >>> will happen after the main nvmem device has been announced to userspa=
ce
> >>> and thus these attributes might not be populated yet (but Greg said it
> >>> was "supported" and I assumed it was fine). =20
> >>>   > So what is your idea here to overcome this? =20
> >>
> >> Ideally we should have all the cells definitions ready by the time nvm=
em is registered. =20
> >=20
> > I no longer think what you describe can happen because even though the
> > rootfs might be mounted, the daemons will only be 'started' once the
> > kernel is done starting and starts the init process, which means all
> > the devices have probed and all the cells have been registered as well.=
 =20
> I think you forgot about modules in the above flow.

We request module insertion when the layout gets populated. By the time
userspace starts the kernel is done initializing, meaning that any
available nvmem layout module has already been loaded and the devices
probed -> the cells are there already.

Thanks,
Miqu=C3=A8l
