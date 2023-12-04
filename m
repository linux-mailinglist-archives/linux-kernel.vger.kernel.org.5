Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0693803A95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjLDQlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLDQlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:41:44 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B789A;
        Mon,  4 Dec 2023 08:41:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3316a4bc37dso4392857f8f.2;
        Mon, 04 Dec 2023 08:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701708109; x=1702312909; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6KJn9AsRhet3LPMYrxQkrFL4xXi1HWQlnhRfWLxXAos=;
        b=m6lrwR/c9DqngHxTbixY+YNJLxMl0kjS8z6N0zWzZmTK2aeOvirReyrDNXFCIkoGKl
         HcoM+6G0BL7SMpJNFmm8+F36uGiXJO666QuxI/AsNZQ2pRDvxbvoq1c03rr8HitmoADu
         Ju4IuleYLBoZi/yokWAGIlTSHOvQAXpmBwjlcexawbDswnBQ72Nffdwi1VeZsn63UcIc
         HlhkJxWkZmmO9JrEd5tOHFCpraDSLvPqnG7MlSsN3fKSGO3y4pxYga8ewrd3jj4/WcYT
         OJEshNJVxITKcq6XHvnTwvpOv246S2dzbL4M0YDjqbm6uAwMRhMdFa/JO9FdGjyNaxgf
         j9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708109; x=1702312909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KJn9AsRhet3LPMYrxQkrFL4xXi1HWQlnhRfWLxXAos=;
        b=WrFgx0Fnmrc80QV23uIT6LPj0PreENUFVVkM+lfw1k64iQF7imslCPOaB0OFmZ4nQL
         gK1yBhlVaeyjAM3YqE40ekoyE3LzmUWNmv11hICNeV9ptRskfzyjjxiQ3X6NpN8Suw7l
         zgG8nRPqYmzDWL8HHApyrpEj/FfN+7obHVl6uPhk3In+UiRWZuKwpRHcJBD2z/LrN618
         ELs3F15dXAEqTlDZ/HDzRHgutwCO+8Y3okkc6xtZLG03ref0nt4V5PvN1+OqM43Rfhhv
         rSbuMnNbIFI4Zy7XFSueRMQ21HZXqSWbdzY/euqGlp+u2UyBgESSlrrHhGYv5laVg3di
         nqYw==
X-Gm-Message-State: AOJu0YyApnUBs4oLOZMjLHPrPyiiujUVcX05qa6fFwqRCYJ3GoQx4oco
        hxl2FVEBSjGDKLwSxME3LvA=
X-Google-Smtp-Source: AGHT+IGGQsZJ3eOLPq6l8Ehu4n5FPqXCh2VbaytPpR3qjhezSmcei/sWQ9i5KU8NMKyMFwH4pcjblA==
X-Received: by 2002:a5d:40c4:0:b0:333:1ca5:7954 with SMTP id b4-20020a5d40c4000000b003331ca57954mr3089959wrq.69.1701708108943;
        Mon, 04 Dec 2023 08:41:48 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id j28-20020adfb31c000000b003333d46a9e8sm6415350wrd.56.2023.12.04.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:41:48 -0800 (PST)
Message-ID: <9b11a42d83dfe77215bafae1d116375ee2398ae6.camel@gmail.com>
Subject: Re: [PATCH 04/12] iio: adc: ad9467: fix reset gpio handling
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Mon, 04 Dec 2023 17:41:48 +0100
In-Reply-To: <20231204151514.4e2c8ada@jic23-huawei>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <20231121-dev-iio-backend-v1-4-6a3d542eba35@analog.com>
         <CAMknhBGCqnzCp6vQ+59Z-SybScvbtU7aWdAD6KnP1e6=q60gVQ@mail.gmail.com>
         <d534c3323c32d4ed2aedae19a9f101be90ef0cc7.camel@gmail.com>
         <CAMknhBGjm2ja9HOenOWi9O5Ao8qUg=gT=_Vz8CyxQ=pfNX2EJQ@mail.gmail.com>
         <3925cb4b6453644c889675c20329b3477a06fcd5.camel@gmail.com>
         <20231204151514.4e2c8ada@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-12-04 at 15:15 +0000, Jonathan Cameron wrote:
> On Sat, 02 Dec 2023 09:36:47 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Fri, 2023-12-01 at 11:01 -0600, David Lechner wrote:
> > > On Fri, Dec 1, 2023 at 2:47=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmai=
l.com> wrote:=C2=A0=20
> > > >=20
> > > > On Thu, 2023-11-30 at 15:41 -0600, David Lechner wrote:=C2=A0=20
> > > > > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:=C2=A0=20
> > > > > >=20
> > > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > > >=20
> > > > > > The reset gpio was being requested with GPIOD_OUT_LOW which mea=
ns, not
> > > > > > asserted. Then it was being asserted but never de-asserted whic=
h means
> > > > > > the devices was left in reset. Fix it by de-asserting the gpio.=
=C2=A0=20
> > > > >=20
> > > > > It could be helpful to update the devicetree bindings to state th=
e
> > > > > expected active-high or active-low setting for this gpio so it is
> > > > > clear which state means asserted.
> > > > > =C2=A0=20
> > > >=20
> > > > You could state that the chip is active low but I don't see that ch=
ange that
> > > > important for now. Not sure if this is clear and maybe that's why y=
our
> > > > comment.
> > > > GPIOD_OUT_HIGH has nothing to do with active high or low. It just m=
eans, "get
> > > > me
> > > > the
> > > > pin in the asserted state".
> > > > =C2=A0=20
> > >=20
> > > I would assume that this bug happened in the first place because
> > > someone forgot GPIOD_OUT_LOW in the devicetree when they were
> > > developing the driver. So this is why I suggested that updating the
> > > devicetree binding docs so that future users are less likely to make
> > > the same mistake. Currently, the bindings don't even have reset-gpios
> > > in the examples.=C2=A0=20
> >=20
> > Hmm, I think you're missing the point... The bug has nothing to do with
> > devicetree.
> > This is what was happening:
> >=20
> > 1) We were calling devm_gpiod_get_optional() with GPIOD_OUT_LOW. What t=
his means
> > is
> > that you get an output gpio deasserted. Hence the device is out of rese=
t. And
> > here is
> > the important part... what you have in dts does not matter. If you have=
 active
> > low,
> > it means the pin level will be 1. If you have high, the pin level is 0.=
 And this
> > is
> > all handled by gpiolib for you.=20
> >=20
> > 2) Then, we called gpiod_direction_output(..., 1), which means set the =
direction
> > out
> > (which is actually not needed since it was already done when getting th=
e pin) and
> > assert the pin. Hence, reset the device. And we were never de-asserting=
 the pin
> > so
> > the device would be left in reset.
>=20
> Functionally I believe David is correct.=C2=A0=C2=A0 Flipping the DT woul=
d 'fix' this.
> It's all down to a nreset vs reset pin description.
>=20

Ahh I see. Well would not really be a fix :)

- Nuno S=C3=A1

