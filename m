Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46887B228A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjI1Qfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjI1Qfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:35:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51846CCC;
        Thu, 28 Sep 2023 09:35:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405524e6768so111039365e9.2;
        Thu, 28 Sep 2023 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695918931; x=1696523731; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h+FK2OVbL3g0y20LcvHBd99TVaWRiOn0IXCxVJC/UcA=;
        b=XBj1ur/Igv3Ch4d5js1mSKygSAUYYdtBvcOwpvkNYqcrbXpxO3liPI8MjOGlejAG2e
         8MuapSAlDz/+4JQEc+4f8Y15COIwvCGUKNfWEE7aB/HRlSQQqpbuF404tq6+bZzc7O/W
         yy38AQigYa8sgKzpWg3VTFwdFGLA5mUD8ClUk/psGKRgdfkE3gxFo2NNjIynV1dxJLdw
         NIj0ZFhIhzlLh4sDNhdyxVAMlkaSRZt7ZNaECpHy7gM8btkEjU72jEz7KcTsecTwX++k
         Edvunj38De4nChM0OjBcIjPAI4LdoKNXbXG/jfHM3/kYDw9uejH8yNOJILSgq+yFvDJH
         QvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695918931; x=1696523731;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+FK2OVbL3g0y20LcvHBd99TVaWRiOn0IXCxVJC/UcA=;
        b=lNQjctku6wPReZMuzfrG7lxFv7KNy6tETSb7bV3VbCS/Z2v0qxsozflq5rjsDVhVxM
         PbctZkOZe4RkV4nir32I1m9d1MjdhdTazqrZ5kE/rVMhN13ukY5eEjs46yLUD+XWDjpu
         moVB7XF1Y4F5XmsI90lE1WPaUSBFIBEiTkDcQ2u1GVlWwDifwBEobBS2XY1y0SjPYnNY
         xZvIYsNrTCQCBAOr1aFgLBaaYKSKpFaLFXnJKmy+DjrhITBY2WhQM7hWV2imGXsBDmXU
         L03jC+6OZo27+4dFOVne2VCFdcCIB4O+kluXVav31LkubbanJPVSKWF1bFjs8K/z3TIA
         QZGg==
X-Gm-Message-State: AOJu0Yzn3ZPDk9gm1Rf0tfk/bDUx1emSeWG5UczSWkOcmeObX1wlElS5
        iI0Kbc5WpCVaQKvarZDfMJg=
X-Google-Smtp-Source: AGHT+IHsXpcIy1OvuU/OMKNOy2CxYJcZLYIw10mTYlxsCLWbbldly+M6EDluCbxo8uFOvf6G268JAg==
X-Received: by 2002:a05:600c:2158:b0:405:3e92:76db with SMTP id v24-20020a05600c215800b004053e9276dbmr1631436wml.5.1695918930700;
        Thu, 28 Sep 2023 09:35:30 -0700 (PDT)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id d9-20020a1c7309000000b00402f713c56esm20259473wmb.2.2023.09.28.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 09:35:30 -0700 (PDT)
Message-ID: <5043c6729e1ffd2dac84b6908b26db11347521b0.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Eliza Balas <Eliza.Balas@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
        "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date:   Thu, 28 Sep 2023 18:35:29 +0200
In-Reply-To: <94110af1-2b32-4eb2-81be-2a79fc6973d8@app.fastmail.com>
References: <20230928092804.22612-1-eliza.balas@analog.com>
         <20230928092804.22612-3-eliza.balas@analog.com>
         <839638d2-7502-4925-8b7f-6b15779a6840@app.fastmail.com>
         <BN7PR03MB4545DC903A0D62639085591697C1A@BN7PR03MB4545.namprd03.prod.outlook.com>
         <94110af1-2b32-4eb2-81be-2a79fc6973d8@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-28 at 10:19 -0400, Arnd Bergmann wrote:
> On Thu, Sep 28, 2023, at 06:54, Balas, Eliza wrote:
> > > <conor+dt@kernel.org>; derek.kiernan@amd.com; dragan.cvetic@amd.com; =
Greg
> > > Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> > > Subject: Re: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engin=
e
> > >=20
> > > [External]
> > >=20
> > > On Thu, Sep 28, 2023, at 11:28, Eliza Balas wrote:
> > > > This patch introduces the driver for the new ADI TDD engine HDL.
> > > > The generic TDD controller is in essence a waveform generator
> > > > capable of addressing RF applications which require Time Division
> > > > Duplexing, as well as controlling other modules of general
> > > > applications through its dedicated 32 channel outputs.
> > > >=20
> > > > The reason of creating the generic TDD controller was to reduce
> > > > the naming confusion around the existing repurposed TDD core
> > > > built for AD9361, as well as expanding its number of output
> > > > channels for systems which require more than six controlling signal=
s.
> > > >=20
> > > > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > >=20
> > > Thanks for your submission, I've had a first look at the driver
> > > and the implementation of the interface you have chosen looks
> > > all good to me, so I have no detailed comments on that.
> > >=20
> > > It would however help to explain the ideas you had for the
> > > user-space interface design and summarize them in the changelog
> > > text.
> > >=20
> > > You have chosen a low-level interface that wraps the individual
> > > device registers and gives user space direct control over them.
> > > The risk here is to lock yourself into the first design,
> > > giving you less flexibility for future extensions, so it would
> > > help to understand what the usage model is here.
> > >=20
> > > One risk is that there may be an in-kernel user in the future
> > > when the TDD engine interacts with another device, so you
> > > need a driver level interface, which would in turn break
> > > if any user pokes the registers directly.
> > >=20
> > > Another possible problem I see is that an application written
> > > for this driver would be incompatible with similar hardware
> > > that has the same functionality but a different register-level
> > > interface, or even a minor revision of the device that ends up
> > > breaking one of the assumptions about the hardware design.
> > >=20
> > > In both cases, the likely answer is to have a higher-level
> > > interface of some sort, but the downside of that would be
> > > that it is much harder to come up with a good interface that
> > > covers all possible use cases.
> > >=20
> > > Another question is whether you could fit into some
> > > existing subsystem instead of creating a single-driver
> > > interface. drivers/iio/ might be a good choice, as
> > > it already handles both in-kernel and userspace users,
> > > and provides a common abstraction for multiple classes
> > > of devices that (without any domain knowledge in my case)
> > > look similar enough that this could be added there.
> > >=20
> >=20
> > We are using this driver with an iio-fake device=20
> > https://github.com/analogdevicesinc/linux/blob/master/Documentation/dev=
icetree/bindings/iio/jesd204/adi%2Ciio-fakedev.yaml
> > =C2=A0
> > =C2=A0so we can take advantage of the iio user-space interface.
>=20
> I don't understand how that works yet: Do you mean that there
> is=C2=A0 user-space application that uses the tdd sysfs interface to
> export an IIO device back into the kernel, or do you mean there
> is a regular IIO device in with a kernel driver that is used
> as the back-end for the tdd device, or something else?
>=20

Well, I never used this myself but the iio-fakedev is an out of tree driver=
 that
receives a phandle to a device and a string list of sysfs attributes of tha=
t same
device. It then symlinks those to an IIO fake device so they seem like IIO =
device
attributes. As a said, this is __very__, __very__ hackish and the solely re=
ason it's
being done (I believe), is to use libiio on that fakedev so you can access =
these kind
of devices (like this TDD core) remotely through the network for example (o=
r USB). In
the past, we would put drivers that are not IIO in IIO for the same reason.=
 So, at
least now, it's a one time ugly hack :sweat_smile: but then we can put driv=
ers in
their right places. Not saying this justifies this fakedev but it is what i=
t is :).

Well, maybe this one is not really in here but the IIO maintainer was also =
not to
keen to have in there. So I'm not really sure where else it can go.
>=20

- Nuno S=C3=A1
