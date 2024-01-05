Return-Path: <linux-kernel+bounces-17476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360C6824DD1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9441F22C1A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559B75397;
	Fri,  5 Jan 2024 04:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZjDJteR7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C838524C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 04:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7713D3F2C4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 04:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704430494;
	bh=RmsBGh357gTnxMuX2QZf4f7gG0wqdDy6mYTiBGYGCmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ZjDJteR7tyUOrB9JXcB26qKV1MfLohVLIZe24o4y/bAy8rogfmM5LqD+RxY+FQ4oG
	 z57e7W+RsagyjHDaPT/s837spEcW2E9L/IuJoqMOBhyaH+xQ98oaerxWL1MUn+jGiP
	 t5bKXd2wkEu6NW9oPSdTZAaJhQlaQX4h74p2k/oi4+rrQ40IFrZBTEexa4izKdEHfE
	 fcQgr6X5ebhJdF5Wd6AOW9TGtZcyk/2cP9jFCdeYMTmNLpe7U5PjKCsVZDpcYp+A7k
	 9thJWh8mPb7lJ5WmHusueKJ1ZgseE9vqXKyVlDZ9483HdGzqTiu1ODo9UZg+0Lur85
	 FtMmulLeBCCUg==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28bbe965866so918903a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 20:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704430493; x=1705035293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmsBGh357gTnxMuX2QZf4f7gG0wqdDy6mYTiBGYGCmk=;
        b=RJPfXhEsL1PvjD7Zi2WCOeKNNvn565DkVyHiZFLcS3Iso7/5yLjvQnEpDNWv5ohyPX
         2QKcR2gBio+NmzSGiyF7gXml+4SSDtpAlREZF/OTGoQ3udXJXhnYvaGqmJdYA5M02o94
         RRaezQrM5WYsKTFTCEpPCPRjDUqbl398yNMf4IKravTb09CzFvHClDajsdsBogD1xlG+
         f6xnuQM0Ldv9diy7oMGsjRfGgLSbC4tDuRwkadgArftG1suZ4rOh3LoWZs6hh+qDBen1
         OcmKu0/246AGO+0pEA22gUCEM98jIM8HgCswlxlgMi6rk1r/ej7Dsr4ebu87ukT5o//4
         XwAw==
X-Gm-Message-State: AOJu0Yx0FjoY2ClrETBnZQp+h9SBdzLtBjBynqqisJcV4dENWC0wUI1P
	XxK2lLXPFVNcu/qJk8YGsBjd0zPA26DOXa263bh6wr3fW4bFqwYLythOKrehKZr4jN0nGuyz5rq
	aTfKDjN30xcglYUX6Fo8l2+dhije6iEN8rvJ9+J3I5TaGAteBiAgS4R0kE0Cq8FtQ
X-Received: by 2002:a17:90a:ba85:b0:28c:28b4:e499 with SMTP id t5-20020a17090aba8500b0028c28b4e499mr1349255pjr.41.1704430492779;
        Thu, 04 Jan 2024 20:54:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGXrvgRyWcCk+nXIuvq+aAdMLhT+C/Ly2g0LceapXrNcJW2yfM6MB+qExmzmfh5h39hxXlfn20P3F7eXA3Xbg=
X-Received: by 2002:a17:90a:ba85:b0:28c:28b4:e499 with SMTP id
 t5-20020a17090aba8500b0028c28b4e499mr1349245pjr.41.1704430492481; Thu, 04 Jan
 2024 20:54:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024819.848979-1-kai.heng.feng@canonical.com> <CAJZ5v0g0M4B-01AT6+WBASkSyfqVAYSJUS4oE+rw=obXFT1WcA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g0M4B-01AT6+WBASkSyfqVAYSJUS4oE+rw=obXFT1WcA@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 5 Jan 2024 12:54:40 +0800
Message-ID: <CAAd53p4iLK1gJPgrpr5AuB2WEFYD263RW3VKC9FUp3TgZ54Kvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: IPMI: Add helper to wait for when SMI is selected
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: jdelvare@suse.com, linux@roeck-us.net, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 1:25=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Thu, Jan 4, 2024 at 3:48=E2=80=AFAM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > The function of acpi_power_meter module on Dell system requires IPMI
> > handler is installed and SMI is selected.
> >
> > So add a helper to let acpi_power_meter know when IPMI handler and SMI
> > are ready.
>
> The changelog is a bit terse.
>
> It could describe the problem at hand in more detail, for example.
>
> Also it wouldn't hurt to provide a Link: tag pointing to a place where
> some extra details could be found.

OK. Will add more info in next revision.

>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> >  - New patch.
> >
> >  drivers/acpi/acpi_ipmi.c | 17 ++++++++++++++++-
> >  include/acpi/acpi_bus.h  |  5 +++++
> >  2 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> > index 0555f68c2dfd..54862cab7171 100644
> > --- a/drivers/acpi/acpi_ipmi.c
> > +++ b/drivers/acpi/acpi_ipmi.c
> > @@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
> >  #define IPMI_TIMEOUT                   (5000)
> >  #define ACPI_IPMI_MAX_MSG_LENGTH       64
> >
> > +static struct completion smi_selected;
> > +
> >  struct acpi_ipmi_device {
> >         /* the device list attached to driver_data.ipmi_devices */
> >         struct list_head head;
> > @@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct de=
vice *dev)
> >                 if (temp->handle =3D=3D handle)
> >                         goto err_lock;
> >         }
> > -       if (!driver_data.selected_smi)
> > +       if (!driver_data.selected_smi) {
> >                 driver_data.selected_smi =3D ipmi_device;
> > +               complete(&smi_selected);
>
> It looks like the new completion is at least related to driver_data,
> so should it be a member of the latter?

Sure thing.

>
> > +       }
> >         list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
> >         mutex_unlock(&driver_data.ipmi_lock);
> >
> > @@ -578,10 +582,21 @@ acpi_ipmi_space_handler(u32 function, acpi_physic=
al_address address,
> >         return status;
> >  }
> >
> > +int acpi_wait_for_acpi_ipmi(void)
> > +{
> > +       long ret;
> > +
> > +       ret =3D wait_for_completion_interruptible_timeout(&smi_selected=
, 2 * HZ);
>
> Why does it wait for 2 ticks and not 3 or 5?
>
> Also it would be nice to have a symbol defined for this timeout value.

Sure. Will add a define and comment.

>
> > +
> > +       return ret > 0 ? 0 : -ETIMEDOUT;
>
> if (ret <=3D 0)
>         return -ETIMEDOUT;
>
> return 0;
>
> pretty please.

OK.

>
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_wait_for_acpi_ipmi);
> > +
> >  static int __init acpi_ipmi_init(void)
> >  {
> >         int result;
> >         acpi_status status;
>
> Empty line here, please.

OK.

>
> > +       init_completion(&smi_selected);
>
> Does it really make sense to initialize it when ACPI is disabled?

OK, will move it further down.

Kai-Heng

>
> >
> >         if (acpi_disabled)
> >                 return 0;
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 1216d72c650f..afa6e4d4bf46 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -821,11 +821,16 @@ static inline void acpi_put_acpi_dev(struct acpi_=
device *adev)
> >  {
> >         acpi_dev_put(adev);
> >  }
> > +
> > +int acpi_wait_for_acpi_ipmi(void);
> > +
> >  #else  /* CONFIG_ACPI */
> >
> >  static inline int register_acpi_bus_type(void *bus) { return 0; }
> >  static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> >
> > +static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> > +
> >  #endif                         /* CONFIG_ACPI */
> >
> >  #endif /*__ACPI_BUS_H__*/
> > --

