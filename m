Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E607F6F41
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjKXJPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjKXJPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:15:30 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D99B0;
        Fri, 24 Nov 2023 01:15:35 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54af1daf6a9so787649a12.1;
        Fri, 24 Nov 2023 01:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700817334; x=1701422134; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6kRk7Goc6hUK5lXDDcfcFjF2TFYoCUPomnxmo7qAhJM=;
        b=L4VnncXo30pHON6jwFm+tjSmIk4bizGaBpfXZoUhczUwWwNWgAvDFGWw7lbpr7ceaX
         hORJh4Y/vqB4VqtKmRfRfdBqlPKumXVMEWVliD11wb/KfHvNmp8aPR7712+CweiGSK/x
         QEqGAQo7PcRnZmxuvBErGv/EqFdKtJBFFTWnCYHp5GEDTVvcF9LDkE0iLuoo/a3x2vjL
         AH7BM7CaOf9a7Dcy1AQFTFvMQ1fKWu8jtZecOkN1FXKrhhTbe80eIPFxj+K5YKId51QI
         Bs8xi/4n5DR6Qbz8G6V4ZIY6cELPQ73Sep0lUGSTm4gslDJ3BheLROcxofpjtZjRsvdU
         3SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700817334; x=1701422134;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kRk7Goc6hUK5lXDDcfcFjF2TFYoCUPomnxmo7qAhJM=;
        b=TG99OkOxAsOJYN3RMhc2RqyCGw5kIiuok6O5k9V6P/RvJCJpUXAAF//49xe8aYylHB
         16PvbmQb3AHvvj7bBCXc+ZecWfmiMtWsVrOmOupaNiGfpyWpQSQQRsQktqcC3+n8drZD
         RPEcg9ZEBufmhQkf9PxSzAL02IId48V6nlnryDVInoyoQ+qJM5yKrC/9yEZWDhFBKsh9
         dmGqDfdQ+YKJ89TdsmPq31WPNNWlUC+d5Joq2ZLLShOOG/Y7SwF5q5cDYDzKcppCgnpL
         2jqjaJlUgR1RAhUkOXPoAi9l61f0cVFuxC8vUf5iTMxucZwNwdhLBo0ftx3WaZMyLzMG
         c3ng==
X-Gm-Message-State: AOJu0YwgPDIPJXZbyEnk3lWpU8UYCjroj+tqsabI+cmrKiZVpVOEug7w
        h7ELP3630doqCNYpPf45n7I=
X-Google-Smtp-Source: AGHT+IFu01dY/t4VI0lj9frcLMLKZW4WdocaWxXVM5QL3w94LfiESYd3xuuDtEj08JNe0qoO/CnBZg==
X-Received: by 2002:a05:6402:206d:b0:54a:271d:9648 with SMTP id bd13-20020a056402206d00b0054a271d9648mr4267375edb.13.1700817333722;
        Fri, 24 Nov 2023 01:15:33 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id cf11-20020a0564020b8b00b0054afcab0af2sm331052edb.59.2023.11.24.01.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:15:33 -0800 (PST)
Message-ID: <178c36656ecbb26c169b5a878ccc18bf89c6b36d.camel@gmail.com>
Subject: Re: [PATCH 00/12] iio: add new backend framework
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>, nuno.sa@analog.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Fri, 24 Nov 2023 10:15:32 +0100
In-Reply-To: <031e616b-b080-4cfc-9c99-00df46b4075b@foss.st.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <031e616b-b080-4cfc-9c99-00df46b4075b@foss.st.com>
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

On Thu, 2023-11-23 at 18:36 +0100, Olivier MOYSAN wrote:
> Hi Nuno,
>=20
> On 11/21/23 11:20, Nuno Sa via B4 Relay wrote:
> > Hi all,
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
> >=20
> > The basic framework interface is pretty simple:
> > =C2=A0 - Backends should register themselves with @devm_iio_backend_reg=
ister()
> > =C2=A0 - Frontend devices should get backends with @devm_iio_backend_ge=
t()
> >=20
> > (typical provider - consumer stuff)
> >=20
> > This is the result of the discussions in [1] and [2]. In short, both AD=
I
> > and STM wanted some way to control/get configurations from a kind of
> > IIO aggregate device. So discussions were made to have something that
> > serves and can be used by everyone.
> >=20
> > The main differences with the converter framework RFC [1]:
> >=20
> > 1) Dropped the component framework. One can get more overview about
> > the concerns on the references but the main reasons were:
> > =C2=A0 * Relying on providing .remove() callbacks to be allowed to use =
device
> > =C2=A0=C2=A0=C2=A0 managed functions. I was not even totally sure about=
 the correctness
> > =C2=A0=C2=A0=C2=A0 of it and in times where everyone tries to avoid tha=
t driver
> > =C2=A0=C2=A0=C2=A0 callback, it could lead to some maintenance burden.
> > =C2=A0 * Scalability issues. As mentioned in [2], to support backends d=
efined
> > =C2=A0=C2=A0=C2=A0 in FW child nodes was not so straightforward with th=
e component
> > =C2=A0=C2=A0=C2=A0 framework.
> > =C2=A0 * Device links can already do some of the things that made me
> > =C2=A0=C2=A0=C2=A0 try the component framework (eg: removing consumers =
on suppliers
> > =C2=A0=C2=A0=C2=A0 unbind).
> >=20
> > 2) Only support the minimal set of functionality to have the devices in
> > =C2=A0=C2=A0=C2=A0 the same state as before using the backend framework=
. New features
> > =C2=A0=C2=A0=C2=A0 will be added afterwards.
> >=20
> > 3) Moved the API docs into the .c files.
> >=20
> > 4) Moved the framework to the IIO top dir and renamed it to
> > =C2=A0=C2=A0=C2=A0 industrialio-backend.c.
> >=20
> > Also, as compared with the RFC in [2], I don't think there are that man=
y
> > similarities other than the filename. However, it should now be pretty
> > straight for Olivier to build on top of it. Also to mention that I did
> > grabbed patch 1 ("of: property: add device link support for
> > io-backends") from that series and just did some minor changes:
> >=20
>=20
> I did not already look at the framework patches in detail, but at first=
=20
> glance it looks fine.
>=20
> I confirm that it has been quite straightforward to build on top of this=
=20
> framework, as it remains close to my first approach. I had only some=20
> small changes to do, to match the API, and to get it alive. This is great=
.
>=20
> I see just one concern regarding ADC generic channel bindings support.
> Here we have no devices associated to the channel sub-nodes. So, I=20
> cannot figure out we could use the devm_iio_backend_get() API, when=20
> looking for backend handle in channels sub-nodes. I have to think about i=
t.
>=20

Yeah, I'm keeping the series small (as Jonathan asked in the RFC) and just =
with basic
stuff needed to get the ad9647 driver in the exact same state as before the
framework. So yes, it's the same deal as with the component approach. You'l=
l need to
add support for it. But, in this case, I believe it should be as straight a=
s:

-/**
- * devm_iio_backend_get - Get a backend device
- * @dev:       Device where to look for the backend.
- * @name:      Backend name.
- *
- * Get's the backend associated with @dev.
- *
- * RETURNS:
- * A backend pointer, negative error pointer otherwise.
- */
-struct iio_backend *devm_iio_backend_get(struct device *dev, const char *n=
ame)
+struct iio_backend *devm_fwnode_iio_backend_get(struct device *dev,
+                                               const struct fwnode_handle =
*fwnode,
+                                               const char *name)
 {
-       struct fwnode_handle *fwnode;
+       struct fwnode_handle *back_fwnode;
        struct iio_backend *back;
        int index =3D 0, ret;

@@ -195,20 +187,20 @@ struct iio_backend *devm_iio_backend_get(struct devic=
e *dev,
const char *name)
                        return ERR_PTR(index);
        }

-       fwnode =3D fwnode_find_reference(dev_fwnode(dev), "io-backends", in=
dex);
-       if (IS_ERR(fwnode)) {
+       back_fwnode =3D fwnode_find_reference(fwnode, "io-backends", index)=
;
+       if (IS_ERR(back_fwnode)) {
                dev_err(dev, "Cannot get Firmware reference\n");
-               return ERR_CAST(fwnode);
+               return ERR_CAST(back_fwnode);
        }

        guard(mutex)(&iio_back_lock);
        list_for_each_entry(back, &iio_back_list, entry) {
                struct device_link *link;

-               if (!device_match_fwnode(back->dev, fwnode))
+               if (!device_match_fwnode(back->dev, back_fwnode))
                        continue;

-               fwnode_handle_put(fwnode);
+               fwnode_handle_put(back_fwnode);
                kref_get(&back->ref);
                if (!try_module_get(back->owner)) {
                        dev_err(dev, "Cannot get module reference\n");
@@ -229,9 +221,25 @@ struct iio_backend *devm_iio_backend_get(struct device=
 *dev,
const char *name)
                return back;
        }

-       fwnode_handle_put(fwnode);
+       fwnode_handle_put(back_fwnode);
        return ERR_PTR(-EPROBE_DEFER);
 }
+EXPORT_SYMBOL_GPL(devm_fwnode_iio_backend_get);
+
+/**
+ * devm_iio_backend_get - Get a backend device
+ * @dev:       Device where to look for the backend.
+ * @name:      Backend name.
+ *
+ * Get's the backend associated with @dev.
+ *
+ * RETURNS:
+ * A backend pointer, negative error pointer otherwise.
+ */
+struct iio_backend *devm_iio_backend_get(struct device *dev, const char *n=
ame)
+{
+       return devm_fwnode_iio_backend_get(dev, dev_fwnode(dev), name);
+}
 EXPORT_SYMBOL_GPL(devm_iio_backend_get);

 /**

Completely untested (not even compiled :)). Anyways, the goal is to just ha=
ve the
minimum accepted and you can then send the needed patches for subnode looku=
ps.


> > 1) Renamed the property from "io-backend" to "io-backends".
> > 2) No '#io-backend-cells' as it's not supported/needed by the framework
> > (at least for now) .
> >=20
> > Regarding the driver core patch
> > ("driver: core: allow modifying device_links flags"), it is more like a
> > RFC one. I'm not really sure if the current behavior isn't just
> > expected/wanted. Since I could not really understand if it is or not
> > (or why the different handling DL_FLAG_AUTOREMOVE_CONSUMER vs
> > DL_FLAG_AUTOREMOVE_SUPPLIER), I'm sending out the patch.
> >=20
> > Jonathan,
> >=20
> > I also have some fixes and cleanups for the ad9467 driver. I added
> > Fixes tags but I'm not sure if it's really worth it to backport them (g=
iven
> > what we already discussed about these drivers). I'll leave that to you
> > :).
> >=20
> > I'm also not sure if I'm missing some tags (even though the series
> > is frankly different from [2]).
> >=20
> > Olivier,
> >=20
> > If you want to be included as a Reviewer let me know and I'll happily d=
o
> > so in the next version.
> >=20
>=20
> Yes, please add me as reviewer.
> Thanks.
> Olivier

Will do.

- Nuno S=C3=A1
>=20
