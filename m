Return-Path: <linux-kernel+bounces-62368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A1F851F34
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0720B22AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23784C615;
	Mon, 12 Feb 2024 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="r8L2f28v"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E54C61B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772123; cv=none; b=UBWH0IMyr82H8njo4RWICAetFTfmZK8uU+cjDej4ZWuSMFGaZXrPFXUZq6we2EVel2Z9nf0u9SWgMiFaNYQla0zzuZcWJyaSEZzWFUmsYTyB7bnqlAMCqk8/vasfCwDVD1YL9DwCizqtDtP5lP6kpbtEzINmvZtESi9jupCUQag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772123; c=relaxed/simple;
	bh=cT6oEXxc39vrH0YgJRtkQAV0D4LcChlx3yJhcWWEjVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwJdTMBd02wK+y5xH0sBb1IhKZKnAgtcY90wWEdUGD0Jo368V7Gr9d1FUGRPzbVgL2+cb5w8GOwhlodcGhNa/zka8wY1LOMc/oTyb6VUW/ZNcP0ZcbxfXWkcVyTLQL+D4Zs+WWMqSRxnr7Cgydlk72Svhu7pGFIVXKGWtFvJHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8L2f28v; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42dac9f7183so11431cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707772119; x=1708376919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+d9JGQ7QCBLiQWxTJtAp8Y26oWjCdolLMdTv/a9cv8=;
        b=r8L2f28vmdmC+afXY3kzvpCHql+6fSIoy6kZ7N0L/1Z7R+WNL7XGAXjqLkrwLvSgFc
         MyF/7HKEf9D5yw50XeJI7+B6JlLBD4DeV0493ayCOuIZW0oK+AtqHIsXvxP8zEpZb5Vi
         Za+mIkQT6KIeTkvAIu2iL4ejia1GJaJuL8s4j+t4/K+0zl1XtgsF/xqiM4bSjfpPleGS
         1x9CS2Zp+OfB33nNi1j04d2jblTOqgJ5J43Ixl5Uq8f62N733hIuSi8xtvsFt15bWyc3
         X10OMn/8jB40v3OMuGJ9eoF7araGA3Q8nfqX8N5AWc090TupfSuLIer/swTP43W6brCw
         PRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707772119; x=1708376919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+d9JGQ7QCBLiQWxTJtAp8Y26oWjCdolLMdTv/a9cv8=;
        b=UAzc//IMLF8Nt/okeGe5aMCBW+qubqV9a1Z0acV8uHMuHij0fAnEAv2yvG65BNpWPG
         LqRmWTmAYEIq0bXucteFckDeWFZ24aZnQrSpAAweLfRA8yBzTErIwDCIGcGGNLs/H/be
         YwCjeLtESYI00DLj4icSDtUni4eiy/Z7jSFYkv6GZ2z3sjMo3yAlf94HB7WN023CVRDT
         PtmmlBtu99oFlbMNO3YoNBnbKh6zKfrcyx1nxtkzBydvnoPHUf6F1fxa/VbXvD06qaTz
         sx/nCYEKr2TxNo3U08MWfgur2zVdFC2UTuAQL7IZ+iIhksioLV/WcV2/D8cpQxcnIr0D
         6OlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+7ej20elxGAcdsKxET0u/Q5HmIxi0/eQw/+VO1FiL7bqcQCNMPPx9JASV3ZHG8hHI6Z/IMP/WL5C4Q03GDnHQ2a7tE0UdcZdvXvrM
X-Gm-Message-State: AOJu0YxCIip9YrhQTafhKkxfKiXYAQUl4xQYDYmecwIlrWnTvorA3qIj
	jVcjUQEwFrsALXg8A7PEo3sS+WU0zo8MhoSiceWgq93MYDmy4QQyhQzktYTkQb5GCcgTctMky+l
	NCrRN7nu9z8OwoxfztYvfdj/2JKf+4dWEbI9j
X-Google-Smtp-Source: AGHT+IEDqmoTtT2agh02uJiNKeZfP9bWjW02lWNGSEM6It4rrTXIHzftcneItrx4H7q3pIKgvKfKACqaEEyykLLBu0g=
X-Received: by 2002:ac8:6e8d:0:b0:42c:5c91:b93c with SMTP id
 c13-20020ac86e8d000000b0042c5c91b93cmr7185qtv.27.1707772119457; Mon, 12 Feb
 2024 13:08:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210030549.4048795-1-saravanak@google.com>
 <20240210030549.4048795-4-saravanak@google.com> <CAL_Jsq+tMK6myLtvD2EYEE2juev+wMvWoVMnYpT8JPy2eD9hKA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+tMK6myLtvD2EYEE2juev+wMvWoVMnYpT8JPy2eD9hKA@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 12 Feb 2024 13:08:00 -0800
Message-ID: <CAGETcx-g6MXk0DP8pNwiGfjr4amdc0Mha3Uk9Kx74xaqxbUHOg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] dt-bindings: Add post-init-supplier property
To: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 3:26=E2=80=AFAM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> On Sat, Feb 10, 2024 at 3:06=E2=80=AFAM Saravana Kannan <saravanak@google=
com> wrote:
> >
> > The post-init-supplier property can be used to break a dependency cycle=
 by
> > marking some supplier(s) as a post device initialization supplier(s). T=
his
> > allows the kernel to do a better job at ordering initialization and
>
> s/the kernel/an OS/
>
> > suspend/resume of the devices in a dependency cycle.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../bindings/post-init-supplier.yaml          | 99 +++++++++++++++++++
>
> This should probably go into dtschema instead, but fine here now for revi=
ewing.

How do I submit it for dtschema?

> We have to consider if this property should be automatically allowed
> on any node or nodes with specific suppliers, or if it should be
> explicit for users. The former needs tool support. I'm leaning towards
> the latter as I want to know when this is needed.

I think I understand your question. This property can be relevant for
any device -- it really depends on the device's consumers and
suppliers and if they form a cycle. Ideally, we can check if a device
is in a cycle and then allow it only for those, but that's going to be
too complicated I think. So, I think this should be allowed for any
device.

Since this property is defined as a "post-init-supplier" and only
applies to an existing direct supplier, there's not a lot of room for
misuse. Actually if you can add a check "are all the phandles listed
in this property also present in one of the other properties in this
device node", that should be sufficient.

I'll also edit the documentation to make it clear it's meaningful only
for an existing supplier.

>
> >  MAINTAINERS                                   |  3 +-
> >  2 files changed, 101 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/post-init-supplie=
r.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/post-init-supplier.yaml =
b/Documentation/devicetree/bindings/post-init-supplier.yaml
> > new file mode 100644
> > index 000000000000..cf9071ecd06e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/post-init-supplier.yaml
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2018 Linaro Ltd.
>
> ?

Oops... didn't edit out all the lines in the example.

I'll address all your other comments in the next patch.

Btw, this is the command I used to validate this file (before I sent
v1), but it didn't spit out anything meaningful that I could
understand:

make dt_binding_check DT_CHECKER_FLAGS=3D-m
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/trivial-devices.yaml

Is that the right way to run it? I'm using yamllint 1.32. So it's not
terribly old either (can't install anything newer).

-Saravana

>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/post-init-supplier.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Post device initialization supplier
> > +
> > +maintainers:
> > +  - Saravana Kannan <saravanak@google.com>
> > +
> > +description: |
> > +  This property is used to indicate that the device(s) pointed to by t=
he
> > +  property are not needed for the initialization of the device that li=
sts this
> > +  property.
> > +
> > +  A device can list its suppliers in devicetree using one or more of t=
he
> > +  standard devicetree bindings. By default, it would be safe to assume=
 the
> > +  supplier device can be initialized before the consumer device is ini=
tialized.
> > +
> > +  However, that assumption cannot be made when there are cyclic depend=
ecies
>
> typo
>
> > +  between devices. Since each device is a supplier (directly or indire=
ctly) of
> > +  the others in the cycle, there is no guaranteed safe order for inita=
lizing
>
> typo
>
> > +  the devices in a cycle. We can try to initialize them in an arbitrar=
y order
> > +  and eventually successfully initialize all of them, but that doesn't=
 always
> > +  work well.
> > +
> > +  For example, say,
> > +  * The device tree has the following cyclic dependency X -> Y -> Z ->=
 X (where
> > +    -> denotes "depends on").
> > +  * But X is not needed to fully initialize Z (X might be needed only =
when a
> > +    specific functionality if requested post initialization).
> > +
> > +  If all the other -> are mandatory initialization dependencies, then =
trying to
> > +  initialize the devices in a loop (or arbitrarily) will always eventu=
ally end
> > +  up with the devices being initialized in the order Z, Y and X.
> > +
> > +  However, if Y is an optional supplier for X (where X provides limite=
d
> > +  functionality when Y is not initialized and providing its services),=
 then
> > +  trying to initialize the devices in a loop (or arbitrarily) could en=
d up with
> > +  the devices being initialized in the following order:
> > +
> > +  * Z, Y and X - All devices provide full functionality
> > +  * Z, X and Y - X provides partial functionality
> > +  * X, Z and Y - X provides partial functionality
> > +
> > +  However, we always want to initialize the devices in the order Z, Y =
and X
> > +  since that provides the full functionality without interruptions.
> > +
> > +  One alternate option that might be suggested is to have the driver f=
or X
> > +  notice that Y became available at a later point and adjust the funct=
ionality
> > +  it provides. However, other userspace applications could have starte=
d using X
> > +  with the limited functionality before Y was available and it might n=
ot be
> > +  possible to transparently transition X or the users of X to full
> > +  functionality while X is in use.
> > +
> > +  Similarly, when it comes to suspend (resume) ordering, it's unclear =
which
> > +  device in a dependency cycle needs to be suspended/resumed first and=
 trying
> > +  arbitrary orders can result in system crashes or instability.
> > +
> > +  Explicitly calling out which link in a cycle needs to be broken when
> > +  determining the order, simplifies things a lot, improves efficiency,=
 makes
> > +  the behavior more deterministic and maximizes the functionality that=
 can be
> > +  provided without interruption.
> > +
> > +  This property is used to provide this additional information between=
 devices
> > +  in a cycle by telling which supplier(s) is not needed for initializi=
ng the
> > +  device that lists this property.
> > +
> > +  In the example above, Z would list X as a post-init-supplier and the
> > +  initialization dependency would become X -> Y -> Z -/-> X. So the be=
st order
> > +  to initialize them become clear: Z, Y and then X.
> > +
>
> select: true
>
> Otherwise, this is never applied.
>
> > +properties:
> > +  # A dictionary of DT properties for this binding schema
>
> Drop
>
> > +  post-init-supplier:
> > +    # One or more suppliers can be marked as post initialization suppl=
ier
> > +    minItems: 1
>
> That's the default.
>
> > +    description:
> > +      List of phandles to suppliers that are not needed for initializi=
ng or
> > +      resuming this device.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
>
> Should be phandle-array plus:
>
> items:
>   maxItems: 1
>
> (as each entry is a single phandle)
>
> > +
> > +examples:
> > +  - |
> > +    gcc: general-clock-controller@1000 {
>
> clock-controller@1000
>
> > +        compatible =3D "vendor,soc4-gcc", "vendor,soc1-gcc";
> > +        reg =3D <0x1000 0x80>;> +        clocks =3D <&dispcc 0x1>
> > +        #clock-cells =3D <1>;
> > +        post-init-supplier =3D <&dispcc>;
> > +    };
> > +    dispcc: display-clock-controller@2000 {
>
> clock-controller@2000
>
> > +        compatible =3D "vendor,soc4-dispcc", "vendor,soc1-dispcc";
> > +        reg =3D <0x2000 0x80>;
> > +        clocks =3D <&gcc 0xdd>
> > +        #clock-cells =3D <1>;
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3dfe7ea25320..40fd498543a5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6055,10 +6055,11 @@ S:      Maintained
> >  F:     drivers/base/devcoredump.c
> >  F:     include/linux/devcoredump.h
> >
> > -DEVICE DEPENDENCY HELPER SCRIPT
> > +FIRMWARE DEVICE LINK (fw_devlink)
> >  M:     Saravana Kannan <saravanak@google.com>
> >  L:     linux-kernel@vger.kernel.org
> >  S:     Maintained
> > +F:     Documentation/devicetree/bindings/post-init-supplier.yaml
> >  F:     scripts/dev-needs.sh
> >
> >  DEVICE DIRECT ACCESS (DAX)
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >

