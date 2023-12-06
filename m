Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CBF806F6A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378303AbjLFMFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378255AbjLFMFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:05:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496AA9A;
        Wed,  6 Dec 2023 04:05:56 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332c0c32d19so772750f8f.3;
        Wed, 06 Dec 2023 04:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701864355; x=1702469155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aDPm18t9o30pzYuZ1wTj/c6zupAighuOQRXZWPWFINk=;
        b=acNNMdQ/LtPXuiC5uTQWqWCpj+lkTPGm9kEd0yLSVUxdked4w5s3ppA8lE1z+m5G8k
         pcnXZRUKETRKVHPjnO4Jv1ktpmmvFlCtv5Khg5DbOnG62PszyFWomQe2fEDNFbkVqGOX
         ZI9gAqu0UXR7i6zhsRKXx6okPwkKulvrzsyw/ptUvr/sRApBvrAMA2khCGNUSO+oNH3m
         f+Dn8WZyNXPjpWGmVxUePu8dGSrGS4fTRh1ByM/crVttL9/gkuQr2SXIQiU+CyE8bvtJ
         crbcdge1YVM/PCn0rx71ckJ8Vry5zb+VZcnZo33tuafjz4p75LNLmM98dJwyrnYGflWk
         zZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701864355; x=1702469155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDPm18t9o30pzYuZ1wTj/c6zupAighuOQRXZWPWFINk=;
        b=Gzn7+RsbArMHsXLcoPiVXeym5w997WYdl367J/BbvtrPGvBIWsfpu3VJDofetMA4k6
         Y/i2OHoqZ1uJ6ldUjtAtgFPjGZHDIrA1XRQ9OyyHIN3BtMbpvTMb6cEfOXvIrcOvPcqm
         Yzl+uqfi6bcyu6+fatcQlyz0aE6gKQBjYGWUCejVEPKGBOESb+w0jGhYL4AMVaeOGr9F
         a2F6M8jb8kmFUvIxM7JD2fkwKj/Vh64VbGQ82de2I1flbqlcR1bE9Lwu3a5+zV/a+2Qq
         vFY/xTe4jpFOrr3/I8miQn/BY9YtbcObbRpuR/+DWY9z/JwN0wq5+uSgRI7pEzI2nzSy
         62jw==
X-Gm-Message-State: AOJu0Yz8lMXtVnheqD6TFmD3KnaBvryBNKHeBLWZyRSNlrlJqTYFCpG9
        190foFF+ID5Ad6vbOwrvzxc=
X-Google-Smtp-Source: AGHT+IHwMuty3UHp//1mR32/X8vOijFW8CaVCQvkg824u8QUBajzUYqFtqtw3rcuSxstkbZcgCdBbA==
X-Received: by 2002:a05:600c:4589:b0:40c:938:782 with SMTP id r9-20020a05600c458900b0040c09380782mr519918wmo.55.1701864354090;
        Wed, 06 Dec 2023 04:05:54 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c4e9000b0040b4e44cf8dsm21685559wmq.47.2023.12.06.04.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 04:05:53 -0800 (PST)
Message-ID: <bba767835e775909c6b8a3334cceeb419afef4ca.camel@gmail.com>
Subject: Re: [PATCH 03/12] iio: add the IIO backend framework
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno Sa via B4 Relay 
        <devnull+nuno.sa.analog.com@kernel.org>
Cc:     nuno.sa@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Wed, 06 Dec 2023 13:05:53 +0100
In-Reply-To: <20231204153855.71c9926f@jic23-huawei>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <20231121-dev-iio-backend-v1-3-6a3d542eba35@analog.com>
         <20231204153855.71c9926f@jic23-huawei>
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

On Mon, 2023-12-04 at 15:38 +0000, Jonathan Cameron wrote:
> On Tue, 21 Nov 2023 11:20:16 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > This is a Framework to handle complex IIO aggregate devices.
> >=20
> > The typical architecture is to have one device as the frontend device w=
hich
> > can be "linked" against one or multiple backend devices. All the IIO an=
d
> > userspace interface is expected to be registers/managed by the frontend
> > device which will callback into the backends when needed (to get/set
> > some configuration that it does not directly control).
>=20
> As this is first place backend / frontend terminology used (I think), mak=
e
> sure to give an example so people understand what sorts of IP / devices t=
hes
> might be.
>=20
> >=20
> > The basic framework interface is pretty simple:
> > =C2=A0- Backends should register themselves with @devm_iio_backend_regi=
ster()
> > =C2=A0- Frontend devices should get backends with @devm_iio_backend_get=
()
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Looks good to me in general.=C2=A0 I'll need to have a really close read =
though
> before we merge this as there may be sticky corners! (hopefully not)
>=20
>=20
> ...
>=20
> > +static LIST_HEAD(iio_back_list);
> > +static DEFINE_MUTEX(iio_back_lock);
> > +
> > +/*
> > + * Helper macros to properly call backend ops. The main point for thes=
e macros
> > + * is to properly lock the backend mutex on every call plus checking i=
f the
> > + * backend device is still around (by looking at the *ops pointer).
> If just checking if it is around rather thank looking for a bug, then
> I'd suggest a lighter choice than WARN_ON_x=20
>=20

Arguably, in here, removing a backend is the user doing something seriously=
 wrong so
I see the splat with good eyes :D.

That said, I'm fine in turning this into a pr_warn_once()...

> Btw, there were some interesting discussions on lifetimes and consumer / =
provider
> models at plumbers. I think https://www.youtube.com/watch?v=3DbHaMMnIH6AM=
=C2=A0will be
> the video.=C2=A0=C2=A0 Suggested the approach of not refcounting but inst=
ead allowing for
> a deliberate removal of access similar to your check on ops here (and the=
 one
> we do in core IIO for similar purposes).=C2=A0 Sounded interesting but I'=
ve not
> explored what it would really mean to switch to that model yet.

Yes, interesting talk indeed. I have been following this issue for some tim=
e now.
That's why I tried to be careful in the backend stuff (so we don't explode =
if a
backend is gone) even though is a much more simpler approach. But the talk =
mentions
three solutions and we kind of have both option C (the pointer stuff) and o=
ption A
(consumer removed on provicer unbind)
in here. option A is being given through device links with the AUTO_REMOVE_=
CONSUMER
flag.

And the talk actually left me thinking on that (as it's discussed in there.=
 In our
simpler case (ADI ones), it does make sense to remove the consumer if the p=
rovider is
not there. But if we think in more advanced usecases (or maybe already in t=
he STM
usecase) where we have a backend per data path. Does it make sense to compl=
etely
"kill" the consumer if we remove one of the data paths? Starting to think i=
t
doesn't...

- Nuno S=C3=A1

