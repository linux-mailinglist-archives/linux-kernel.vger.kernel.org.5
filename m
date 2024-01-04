Return-Path: <linux-kernel+bounces-17039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C0824777
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DACB1C224A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDD8286B2;
	Thu,  4 Jan 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+2M/w/C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407AC25566;
	Thu,  4 Jan 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2045542eec3so274788fac.3;
        Thu, 04 Jan 2024 09:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704389429; x=1704994229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qrGoqq69nAGPfoa26Qn/jkUo5HX/E7e1DGuH6EcmXC8=;
        b=D+2M/w/Cyrj3oAiJlyfrFU+j0pvTO8149KDpUDFKg8GU7eAxFu9xja+7wC1INXJIcO
         qtpQzQ0GXP/NFFdM3h5/Tb8mCXICRpmWeyLunbt44vsby0CYuIu/W6lo66GiLApKrw+h
         LyIdqJVx3wIr0YZAiCPgN7bAqc5U1DXt93j1JjDzX+8obc/kBG6XJHJ5LGyghh9Pxfxy
         Rad7sOQ4XutlwBLjoqcgwropJ6HnLQ0+tPr8yAarFroU3uFFVKt6J9VnNm2mzNKLF309
         XSSciDr8qW5L29inJ35RaYPs9DmHyZaSDKs5+3df7NNGYgfZMBVXKJOM1dX72iPtvGYF
         C9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389429; x=1704994229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrGoqq69nAGPfoa26Qn/jkUo5HX/E7e1DGuH6EcmXC8=;
        b=thiEGvjFzqfgKEnb0vboMoXOCSM1ObksWEu49tGyykpKdGnhfUmNdoSCyGJpt+Igg6
         tuE92yD3aLzTbegEh8M1IsyNJaBguFLalWvnMO7NdvCN+y7SI8hX+018xmpN89gSPC3O
         bwHknxpnG2QGEmOW51nAI8MwpnxoSq6IupseFwfofm/LiJ4a7NIEG8VXfuGHVowg4/67
         RPsFI4Y44/DVi+4BNQpl7VBv/S67KQ1HRUz+qD1jnL9vbdrvOqJn9reHc88BFpjccso/
         Q7KFuuXnSLupn7JCOqlTa/DqkZrcSMGuWYPA10hW3wwI7ziRiSk3voRE12DNjX61KwU+
         pKow==
X-Gm-Message-State: AOJu0YyMdZK7DDwDVfAkEDoMoDn4nrbT8j4kmblt+5gsrDMIFfj4nYYd
	BCsODSbjxRX12Wi4YoSaIQ==
X-Google-Smtp-Source: AGHT+IEP4Po9HwFEDbzt4f/VWghJJksiHmwCguUCk5PNdbJWSc40ISS3awY2vfQ84b2jCjkxwdvrDw==
X-Received: by 2002:a05:6870:639f:b0:205:cf67:994c with SMTP id t31-20020a056870639f00b00205cf67994cmr355080oap.2.1704389428869;
        Thu, 04 Jan 2024 09:30:28 -0800 (PST)
Received: from serve.minyard.net ([47.184.128.73])
        by smtp.gmail.com with ESMTPSA id xa20-20020a0568707f1400b00205024df99bsm3076500oab.39.2024.01.04.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 09:30:28 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:45b4:3a91:698e])
	by serve.minyard.net (Postfix) with ESMTPSA id B74811800BC;
	Thu,  4 Jan 2024 17:30:27 +0000 (UTC)
Date: Thu, 4 Jan 2024 11:30:26 -0600
From: Corey Minyard <minyard@acm.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, jdelvare@suse.com,
	linux@roeck-us.net, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 1/2] ACPI: IPMI: Add helper to wait for when SMI is
 selected
Message-ID: <ZZbrMsI6m6RrltXQ@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20240104024819.848979-1-kai.heng.feng@canonical.com>
 <CAJZ5v0gNa7XvUo3B1srXaWBrWx+Bx=w=D7ddi-mqda8xBdWwCQ@mail.gmail.com>
 <ZZbR4X6z9wkSESzD@mail.minyard.net>
 <CAJZ5v0ibP7Kn1SgY2QK+7Ky_d0UjKG3CpG+hH+cEaCRG4EdDVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ibP7Kn1SgY2QK+7Ky_d0UjKG3CpG+hH+cEaCRG4EdDVg@mail.gmail.com>

On Thu, Jan 04, 2024 at 06:11:29PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 4, 2024 at 4:42 PM Corey Minyard <minyard@acm.org> wrote:
> >
> > On Thu, Jan 04, 2024 at 02:34:52PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Jan 4, 2024 at 3:48 AM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
> > > >
> > > > The function of acpi_power_meter module on Dell system requires IPMI
> > > > handler is installed and SMI is selected.
> > >
> > > Does the firmware use _DEP to let the OS know about this dependency?
> > >
> > > > So add a helper to let acpi_power_meter know when IPMI handler and SMI
> > > > are ready.
> > > >
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > > v3:
> > > >  - New patch.
> > > >
> > > >  drivers/acpi/acpi_ipmi.c | 17 ++++++++++++++++-
> > > >  include/acpi/acpi_bus.h  |  5 +++++
> > > >  2 files changed, 21 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> > > > index 0555f68c2dfd..54862cab7171 100644
> > > > --- a/drivers/acpi/acpi_ipmi.c
> > > > +++ b/drivers/acpi/acpi_ipmi.c
> > > > @@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
> > > >  #define IPMI_TIMEOUT                   (5000)
> > > >  #define ACPI_IPMI_MAX_MSG_LENGTH       64
> > > >
> > > > +static struct completion smi_selected;
> > > > +
> > > >  struct acpi_ipmi_device {
> > > >         /* the device list attached to driver_data.ipmi_devices */
> > > >         struct list_head head;
> > > > @@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct device *dev)
> > > >                 if (temp->handle == handle)
> > > >                         goto err_lock;
> > > >         }
> > > > -       if (!driver_data.selected_smi)
> > > > +       if (!driver_data.selected_smi) {
> > > >                 driver_data.selected_smi = ipmi_device;
> > > > +               complete(&smi_selected);
> > > > +       }
> > > >         list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
> > > >         mutex_unlock(&driver_data.ipmi_lock);
> > > >
> > > > @@ -578,10 +582,21 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
> > > >         return status;
> > > >  }
> > > >
> > > > +int acpi_wait_for_acpi_ipmi(void)
> > > > +{
> > > > +       long ret;
> > > > +
> > > > +       ret = wait_for_completion_interruptible_timeout(&smi_selected, 2 * HZ);
> > > > +
> > > > +       return ret > 0 ? 0 : -ETIMEDOUT;
> > >
> > > What will happen if the IPMI driver is unloaded after this has returned 0?
> >
> > The IPMI driver can't be unloaded if it has a user.
> 
> Because of the use of the exported symbol, right?

I wasn't thinking that, but yes, that would do it.  It also keep track
of users and doesn't allow the driver to be unloaded if anything has
registered as a user, either.

-corey

> 
> > I've been following this, but I know little about ACPI.  Beyond this
> > solution, the only other solution I could come up with was to start the
> > IPMI driver earlier.  But then you are in a chicken-and-egg situation
> > (https://dictionary.cambridge.org/dictionary/english/chicken-and-egg-situation).
> > Which was the reason for the SPMI table, but that's really kind of
> > useless for this, even if the SPMI table existed.
> 
> Fine.
> 
> Let me reply to the patch with some more comments then.

