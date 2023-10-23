Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2147D3967
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjJWOeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjJWOeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:34:11 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430D9DD;
        Mon, 23 Oct 2023 07:34:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a0907896so4983543e87.2;
        Mon, 23 Oct 2023 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698071647; x=1698676447; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SAEPvwxGBHu171CY7R5Lgx+2jNo1g9so2I50+cUeJJY=;
        b=DkMD4csZsCaOgAbI962j63v5ELKB55YS1ZCX5DP+WhA8JjJRKT757z0/iUYZ+QiUnz
         K7cJIk9r49cfX6c6t1snVkl2l7RV6iueynrNlMpCOg12Y/wVhp4oz3Q/Bv9w1M1fD6YT
         GlfKVmrFU5tuSZk0QYQq+ZdH+dFp30ElPeItDTt9pwEFnH6SFulvFYdDpSaycCVz15jB
         PJ0cbm0P4aZFfDfKBYJPBe44Pf5f/BHaEds2bvZRT1PmYUL8LBxsD1ZVES0KqCG7HJ6O
         ZQHmyuLOAwrAy6aLkTkb+X8CI4k5NZZtb3z+SYXKD3lTHXw9TvrgWmAxgOWymdu4iWdj
         m1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071647; x=1698676447;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAEPvwxGBHu171CY7R5Lgx+2jNo1g9so2I50+cUeJJY=;
        b=m8nssr9KJ8VSAGcOPphByoUQObm/4g5k9MPd1AkzGLGD8wej2IaVko/TyJDU3KA/WG
         jzOtt63J5CsG4PxHjNp9P7+0uh1muaDqIPwEHSeM7quBpSPZ+NBupCwU9edvQQ70gbp6
         REUhycZpUj36fMvN06XY24WgoCevPNqscB+a4FF5af5whPBSRA/syzBVhYgClgu7SpfD
         fNBfS/er5AKQWxdYwASxAq/1Mp+EPb/fyY+8nWjvJwgFyS4j8RWMI5sJpO3iF66RcGTf
         +f90TBxs8X16jTnsd0hEaXWLheTa5IvLRw/RIyWZiF77txIU0N9IYNIGbAzKNqfcXlaz
         CBMw==
X-Gm-Message-State: AOJu0YzGbaEXIpDFKrF6EZOmSjlBO1jy/sl0tbIp+EcKrW7WWQxxEaK6
        I8+QV5uMKZGYeO8N7qgQ2WM=
X-Google-Smtp-Source: AGHT+IH/yoYRCoTrukDj3opINmf//MKljNUeMqhtNo0TsFui/hJge/i58U3IqUqhX0zMysOwtxvUHg==
X-Received: by 2002:ac2:5ec6:0:b0:502:9fce:b6d4 with SMTP id d6-20020ac25ec6000000b005029fceb6d4mr6203704lfq.25.1698071647113;
        Mon, 23 Oct 2023 07:34:07 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:4423:d503:bf11:e8c6? (p200300f6ef1b20004423d503bf11e8c6.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:4423:d503:bf11:e8c6])
        by smtp.gmail.com with ESMTPSA id u22-20020a50c056000000b0054037c6676esm2628483edd.69.2023.10.23.07.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:34:06 -0700 (PDT)
Message-ID: <a1ddec9a04c8a978d50d04c69d675510b05eedb1.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Eliza Balas <Eliza.Balas@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
        "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Date:   Mon, 23 Oct 2023 16:36:57 +0200
In-Reply-To: <15f25d73-32d5-4809-8096-32c856559d66@app.fastmail.com>
References: <20231019125646.14236-1-eliza.balas@analog.com>
         <20231019125646.14236-3-eliza.balas@analog.com>
         <2023101917-cork-numeric-dab8@gregkh>
         <BN7PR03MB4545E7EAB2D72B9098C30C6797DBA@BN7PR03MB4545.namprd03.prod.outlook.com>
         <2023102030-resort-glance-57ef@gregkh>
         <BN7PR03MB4545FF54B96514EC9F41887E97D8A@BN7PR03MB4545.namprd03.prod.outlook.com>
         <2023102339-outcast-scone-5a63@gregkh>
         <BN7PR03MB4545DA4A9404F349170CBA1097D8A@BN7PR03MB4545.namprd03.prod.outlook.com>
         <15f25d73-32d5-4809-8096-32c856559d66@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 16:19 +0200, Arnd Bergmann wrote:
> On Mon, Oct 23, 2023, at 15:30, Balas, Eliza wrote:
> > > -----Original Message-----
> > > Cvetic <dragan.cvetic@amd.com>; Arnd Bergmann <arnd@arndb.de>
> > > Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engin=
e
>=20
> > > > > > Since the device is not an iio device, using an iio function wo=
uld
> > > > > > be confusing.
> > > > >=20
> > > > > Why isn't this an iio device?
> > > >=20
> > > > The device is not registered into the IIO device tree,
> > > > and does not rely on IIO kernel APIs.
> > > > Even though there are a few attributes that resemble the
> > > > ones from iio, and the sysfs structure is similar,
> > > > this is not an IIO device.
> > > > In the previous patch versions 1 and 2 we concluded
> > > > that this device fits better in the misc subsystem.
> > >=20
> > > Ok, can you point to that in the changelog where the IIO maintainer
> > > agreed that this doesn't fit into that subsystem?
> > >=20
> > This was one of the discussions from previous v2 :=20
> > https://lore.kernel.org/all/5b6318f16799e6e2575fe541e83e42e0afebe6cf.ca=
mel@gmail.com/
> >=20
> > I will add it to the changelog the next time I submit the patches.
>=20
> It sounds like Jonathan wasn't quite sure either here, and I would
> still argue (as I did in that thread), that drivers/iio is probably
> a better option than drivers/misc.
>=20

Well, if Jonathan agrees to have this in IIO, it would actually be better f=
or
us... The below hack would not be needed at all and IIO is very familiar.

> In particular, you mention that you actually make this device
> appear as an IIO device to user space using the "iio-fake" hack.
>=20

I want to emphasize that is just our hack to make use of libiio RPC so that=
 we
can remotely access this device.
=20
- Nuno S=C3=A1

