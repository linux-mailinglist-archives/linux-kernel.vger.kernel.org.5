Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36F37B1C77
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjI1Maz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjI1Mas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:30:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F819D;
        Thu, 28 Sep 2023 05:30:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a64619d8fbso1691055766b.0;
        Thu, 28 Sep 2023 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695904243; x=1696509043; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pa99WKi0ZutazJSkijjM2Ke2vSmVN1iISnLjgW4Hqnk=;
        b=IN8BDH2BuvcrRyiEGYoscuM9Ga8buhqRs0KcBIAat2IMmI3xeZaMc+RYgU8xxiZB6Z
         5/1B8vOfFjUNJmVxNcLSOsvFN9SKSgtauflgl9i06ni5kh5FrY9dX4/sjAOA4WcBfTGY
         bTFuCnfhG26kBMs7aSr13c0NSpkTFJL+jBYtrUXyoH8IBuYiTSofLjiSo0JODej4Q4E8
         t7lxo/UnoO/h/1/Qx7+nZ9yat0bCkJ4eXUExwlFEThCSt7Mla/WSuyPrpqt9hbBIcNmx
         T50/OMkmPgsa0cpDClfCUVv67/CPqW9HBue04TA4Ol4IkJQQYhBzZgHQq9Vck4AZ77L8
         iQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904243; x=1696509043;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pa99WKi0ZutazJSkijjM2Ke2vSmVN1iISnLjgW4Hqnk=;
        b=bfqsmlCZ1QvCuzu5JlvoPrFcdS6YtVv/1IeHmctR4vU8P6TTI9Pm9ep7WDuySFvkAe
         +je/cBnW0wATlfEg0dYYqAJlbv7ioLPTI0j8s34uA4orVoK3C1As5IVxLEn7EMFZHmO+
         Fen+QKHADX2g17uV7ZoO6YzrknWxMP8Ua+owgBoJYpH2lbi3jd3hp0KqCn82tZJNJB0k
         WtaDqSXjJ/iASu6vnbfzy9rnOf/NxGlNBsch7zIkXOOualKulmfKJte4WGRdEgn9SZnt
         aENiveRL3+DRhXelimmC2IassAw4TmbeXN4csMXax4NULrEJ/ulmGu7HOvxMXnNxkg6Z
         CKIQ==
X-Gm-Message-State: AOJu0YxFvYFyOgmodOyLgC8e2ecf3oLYBdkKkPu+KBdVZoj8enSmQ0F6
        kQKjy7MQj1DfRdodrSeZbzE=
X-Google-Smtp-Source: AGHT+IE3Qo6MBirJVmxZVy38t4x1pYtshHAhrDjsniEE2u4e4ELQHUl5k1sBP9z7igQSYcYSGvdTpg==
X-Received: by 2002:a17:906:cd1:b0:9ae:6919:813 with SMTP id l17-20020a1709060cd100b009ae69190813mr1013474ejh.17.1695904242989;
        Thu, 28 Sep 2023 05:30:42 -0700 (PDT)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id m14-20020a7bce0e000000b00402ff8d6086sm4352265wmc.18.2023.09.28.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:30:42 -0700 (PDT)
Message-ID: <e39c7b4f44d4c4713bb352469e3367731f8497fc.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     "Balas, Eliza" <Eliza.Balas@analog.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
        "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Date:   Thu, 28 Sep 2023 14:30:41 +0200
In-Reply-To: <BN7PR03MB4545DC903A0D62639085591697C1A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20230928092804.22612-1-eliza.balas@analog.com>
         <20230928092804.22612-3-eliza.balas@analog.com>
         <839638d2-7502-4925-8b7f-6b15779a6840@app.fastmail.com>
         <BN7PR03MB4545DC903A0D62639085591697C1A@BN7PR03MB4545.namprd03.prod.outlook.com>
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

On Thu, 2023-09-28 at 10:54 +0000, Balas, Eliza wrote:
>=20
>=20
> > -----Original Message-----
> > From: Arnd Bergmann <arnd@arndb.de>
> > Sent: Thursday, September 28, 2023 13:07
> > To: Balas, Eliza <Eliza.Balas@analog.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > <conor+dt@kernel.org>; derek.kiernan@amd.com; dragan.cvetic@amd.com; Gr=
eg Kroah-
> > Hartman <gregkh@linuxfoundation.org>;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Subject: Re: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
> >=20
> > [External]
> >=20
> > On Thu, Sep 28, 2023, at 11:28, Eliza Balas wrote:
> > > This patch introduces the driver for the new ADI TDD engine HDL.
> > > The generic TDD controller is in essence a waveform generator
> > > capable of addressing RF applications which require Time Division
> > > Duplexing, as well as controlling other modules of general
> > > applications through its dedicated 32 channel outputs.
> > >=20
> > > The reason of creating the generic TDD controller was to reduce
> > > the naming confusion around the existing repurposed TDD core
> > > built for AD9361, as well as expanding its number of output
> > > channels for systems which require more than six controlling signals.
> > >=20
> > > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> >=20
> > Thanks for your submission, I've had a first look at the driver
> > and the implementation of the interface you have chosen looks
> > all good to me, so I have no detailed comments on that.
> >=20
> > It would however help to explain the ideas you had for the
> > user-space interface design and summarize them in the changelog
> > text.
> >=20
> > You have chosen a low-level interface that wraps the individual
> > device registers and gives user space direct control over them.
> > The risk here is to lock yourself into the first design,
> > giving you less flexibility for future extensions, so it would
> > help to understand what the usage model is here.
> >=20
> > One risk is that there may be an in-kernel user in the future
> > when the TDD engine interacts with another device, so you
> > need a driver level interface, which would in turn break
> > if any user pokes the registers directly.
> >=20
> > Another possible problem I see is that an application written
> > for this driver would be incompatible with similar hardware
> > that has the same functionality but a different register-level
> > interface, or even a minor revision of the device that ends up
> > breaking one of the assumptions about the hardware design.
> >=20
> > In both cases, the likely answer is to have a higher-level
> > interface of some sort, but the downside of that would be
> > that it is much harder to come up with a good interface that
> > covers all possible use cases.
> >=20
> > Another question is whether you could fit into some
> > existing subsystem instead of creating a single-driver
> > interface. drivers/iio/ might be a good choice, as
> > it already handles both in-kernel and userspace users,
> > and provides a common abstraction for multiple classes
> > of devices that (without any domain knowledge in my case)
> > look similar enough that this could be added there.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20
> Hello Arnd,
>=20
> We are using this driver with an iio-fake device
> https://github.com/analogdevicesinc/linux/blob/master/Documentation/devic=
etree/bindings/iio/jesd204/adi%2Ciio-fakedev.yaml
> =C2=A0 so we can take advantage of the iio user-space interface.
>=20

Ehehehh, iio-fake device is an hack we have to make use of libiio capabilit=
y to
access IIO devices trough USB, network and serial. I might be wrong, but I =
think
that's pretty much the reason for that driver.

In the past we used to treat non IIO devices as IIO solely for that reason =
so it's
better do it just once (with that fake device)

- Nuno S=C3=A1

