Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E247C4F52
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjJKJo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjJKJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:44:27 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5411B94;
        Wed, 11 Oct 2023 02:44:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB3F11C0014;
        Wed, 11 Oct 2023 09:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697017462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMDc23w0I6TnyM8rEKpcp545SbgSBtoexxlJSBO6a9E=;
        b=cVCGWFolRyPZktAQIt1lj1LSb5ozI6hojdiZide+Mj5fmFv5lu1+UDdjIWmYlJaQciP90t
        oUlfYQtKAIt0C1WeeQCA5gRStP0vvGjRJ6ucVjpBkh5AuXBFPj6E+CE98KN6M3hHXl4h3g
        stzHsCMANi7sVLKbrU2UXeNyzv2tKWKJ7okLElxpE/DTExbn0HrUBEphA7Tv7XsAREdh3q
        /MbYB64m1T2LoCC/da6DU+itw5q+eWvhzifaXsonemEXkWd7squFpoMOIDKC+Untl+XnDI
        6Mfv1u/M1W48YUOmoUN3asfykoVlzT/yfy4ceK+N/ySnXK2ge/T6cBPaeKRB+g==
Date:   Wed, 11 Oct 2023 11:44:19 +0200
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
Message-ID: <20231011114419.21821f4d@xps-13>
In-Reply-To: <490c6740-06cb-9ee6-ca8c-3ab404109344@linaro.org>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
        <20231005155907.2701706-8-miquel.raynal@bootlin.com>
        <318fe799-f53e-64ed-b631-d099bb5202f4@linaro.org>
        <20231011091524.0c9ecc55@xps-13>
        <548849a8-9f11-5274-778e-f291267603bb@linaro.org>
        <20231011103306.08f1fbd4@xps-13>
        <fe4a2688-079c-a36d-0ea4-c244c6e1a0ad@linaro.org>
        <20231011105829.778bed58@xps-13>
        <490c6740-06cb-9ee6-ca8c-3ab404109344@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 10:26:43 +0100:

> On 11/10/2023 09:58, Miquel Raynal wrote:
> > Hi Srinivas,
> >=20
> > srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 09:45:11 +0100:
> >  =20
> >> On 11/10/2023 09:33, Miquel Raynal wrote: =20
> >>> Hi Srinivas,
> >>>
> >>> srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 09:27:20 +01=
00: =20
> >>>    >>>> On 11/10/2023 08:15, Miquel Raynal wrote:
> >>>>>>> +
> >>>>>>> +	nvmem_cells_group.bin_attrs =3D cells_attrs;
> >>>>>>> +
> >>>>>>> +	ret =3D devm_device_add_groups(&nvmem->dev, nvmem_cells_groups);
> >>>>>>> +	if (ret)
> >>>>>>> +		goto unlock_mutex; =20
> >>>>>> This is going to create groups after the nvmem device is added, is=
n't this going to be problem with user space notifications? =20
> >>>>> Greg said it was not. I hope I understood correctly =F0=9F=98=84
> >>>>>
> >>>>> And anyway, cells have never been available to userspace, so there =
is
> >>>>> nothing userspace might expect yet? =20
> >>>> I agree, but once we add sysfs uapi then this is going to change. =20
> >>>
> >>> Can you elaborate? I'm not sure I follow you here. Is there still a
> >>> problem you fear or you think it's okay? =20
> >>>    >> Now that we add cells to sysfs. =20
> >> AFAIU, By the time the userspace sees the udev event from this device =
we might not have cells populated. =20
> >=20
> > Yes, but why would this be a problem?
> >  =20
> It will be problem if the userspace is using things like libudev to act o=
n these events. There seems to be some caching of attributes in udev during=
 event more info http://www.kroah.com/log/blog/2013/06/26/how-to-create-a-s=
ysfs-file-correctly/

I am already using these attributes, right? The problem here is that we
always attach cells sysfs attributes to the nvmem device, but in some
cases (when using layout devices/drivers) the probe of these devices
will happen after the main nvmem device has been announced to userspace
and thus these attributes might not be populated yet (but Greg said it
was "supported" and I assumed it was fine).

So what is your idea here to overcome this?

Thanks,
Miqu=C3=A8l
