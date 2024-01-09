Return-Path: <linux-kernel+bounces-21550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EFB829106
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE761F2676D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA23E488;
	Tue,  9 Jan 2024 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKUlwEE3"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6101D364B5;
	Tue,  9 Jan 2024 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-20503dc09adso2517134fac.2;
        Tue, 09 Jan 2024 15:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704844366; x=1705449166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwt8ShdmMyz/ckaqBwQ+uvCQ84MS61yetIl89zXgABg=;
        b=nKUlwEE3jKdZ5Urf8c3DKLTt6MKVcK8Q/JmGjkDxTPbMsz4vbMbPZtjM2x/hEtXOoh
         zulufALQdMbxogkgesTYu2uB5IO6dgInpfhP7P3/usx5+OmYUklbqBw/oIgOhiWQOCqr
         rWx9RDro0d121XHppb6sDuBsPOfNAMde2MPJrJS6I7mIY/kKNmcAa52cXDejNrLfoKT6
         gSXqhn30jMc5b13CGTq4pgHSYQKz2gsUbPnXxEyT7RqFa/ppqUmoTnAitMwMKM0V3edJ
         PZbrURlaQlX1E6vg5bLBMQJIohZhRxGHN3vRbTLllsShfMRy3INaqykjPLonZckF6zgY
         KWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704844366; x=1705449166;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lwt8ShdmMyz/ckaqBwQ+uvCQ84MS61yetIl89zXgABg=;
        b=VistYqr8XAfDiVKvcq0NDN7TMJQsfsNEJoLCOKIkeg4jlgPlfkl8pPRJSFpiNvrbEL
         TxKWDEREH6NW5xWvG7tQyuw0ksIU5KznHlGVCeET0DPbOgXQs+XhmWovvf3YwSEbecmi
         p0xtm/0PmMMq4yqUIT0NqzZ6wCR73PcNzHgxUwviJVsgzugiXGpeTr1KJys41nVabt/3
         D9qhgqLsj/lUhVok3kMNmdivLFb7r/YyKGelk/nk9QMpRCHLGtLPRAF/tS7+oJ1Y3j9P
         e2HVY+LbRH4p1zEkJVBFoUKuMVK51KXwfPm90IEuXj3Teb2zGqVWGRWLYmOOjcBET8Qj
         1e0A==
X-Gm-Message-State: AOJu0YwHX40jViLVGgNMiOT3C9KtQhwAkRYmLehD3k01hUlot6LVBV2S
	BXvowWiGsUZ3k8nEs+TNNGF1JWCZXA==
X-Google-Smtp-Source: AGHT+IFw7gJLtak6nEOa7Kpzc8bOOgFbFxmPTM/HJcuyGEmpbaPoSmx5m7sXFjzDhs4Lx5ZPd1SyIA==
X-Received: by 2002:a05:6870:6592:b0:203:2253:bd8d with SMTP id fp18-20020a056870659200b002032253bd8dmr311998oab.77.1704844366052;
        Tue, 09 Jan 2024 15:52:46 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id i25-20020a056830011900b006dbfc48c7f0sm538422otp.63.2024.01.09.15.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 15:52:45 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:15fc:59d7:78af:ea88])
	by serve.minyard.net (Postfix) with ESMTPSA id CF77C1800BF;
	Tue,  9 Jan 2024 23:52:44 +0000 (UTC)
Date: Tue, 9 Jan 2024 17:52:43 -0600
From: Corey Minyard <minyard@acm.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, jdelvare@suse.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: (acpi_power_meter) Ensure IPMI space
 handler is ready on Dell systems
Message-ID: <ZZ3cSygeCTAr35nz@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20240109041218.980674-1-kai.heng.feng@canonical.com>
 <20240109041218.980674-2-kai.heng.feng@canonical.com>
 <1b8ff82e-ff26-410e-a37e-0d818494bac3@roeck-us.net>
 <ZZ26ea5KV9Xg1MDc@mail.minyard.net>
 <e090d7f5-208a-4a4d-8162-7202ad6b0183@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e090d7f5-208a-4a4d-8162-7202ad6b0183@roeck-us.net>

On Tue, Jan 09, 2024 at 02:32:41PM -0800, Guenter Roeck wrote:
> On 1/9/24 13:28, Corey Minyard wrote:
> > On Tue, Jan 09, 2024 at 07:23:40AM -0800, Guenter Roeck wrote:
> > > On 1/8/24 20:12, Kai-Heng Feng wrote:
> > > > The following error can be observed at boot:
> > > > [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62c5) [IPMI] (20230628/evregion-130)
> > > > [    3.717928] ACPI Error: Region IPMI (ID=7) has no handler (20230628/exfldio-261)
> > > > 
> > > > [    3.717936] No Local Variables are initialized for Method [_GHL]
> > > > 
> > > > [    3.717938] No Arguments are initialized for method [_GHL]
> > > > 
> > > > [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> > > > [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> > > > [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
> > > > 
> > > > On Dell systems several methods of acpi_power_meter access variables in
> > > > IPMI region [0], so wait until IPMI space handler is installed by
> > > > acpi_ipmi and also wait until SMI is selected to make the space handler
> > > > fully functional.
> > > > 
> > > > [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-messages-displayed-in-dmesg?guid=guid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62
> > > > 
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > > v4:
> > > >    - No change.
> > > > 
> > > > v3:
> > > >    - Use helper.
> > > >    - Use return value to print warning message.
> > > > 
> > > > v2:
> > > >    - Use completion instead of request_module().
> > > > 
> > > >    drivers/hwmon/acpi_power_meter.c | 6 ++++++
> > > >    1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> > > > index 703666b95bf4..33fb9626633d 100644
> > > > --- a/drivers/hwmon/acpi_power_meter.c
> > > > +++ b/drivers/hwmon/acpi_power_meter.c
> > > > @@ -883,6 +883,12 @@ static int acpi_power_meter_add(struct acpi_device *device)
> > > >    	strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
> > > >    	device->driver_data = resource;
> > > > +	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.") &&
> > > > +	    acpi_dev_get_first_match_dev("IPI0001", NULL, -1)) {
> > > > +		if (acpi_wait_for_acpi_ipmi())
> > > > +			dev_warn(&device->dev, "Waiting for ACPI IPMI timeout");
> > > > +	}
> > > > +
> > > 
> > > What a hack :-(.
> > > 
> > > This needs a comment in the driver explaining the rationale for this change, and
> > > also a comment explaining why, for example, using late_initcall() does not help.
> > > 
> > > If CONFIG_IPMI_SI=n, acpi_wait_for_acpi_ipmi() will return 0, indicating success.
> > > I can only imagine that this will result in a failure since the whole point
> > > of this code is to wait until that driver is loaded. Please explain how and why
> > > the code works with CONFIG_IPMI_SI=n. Similar, if the function returns an error,
> > > I can not imagine how it would make sense to instantiate the driver. If it does
> > > make sense to continue in this situation, a comment is needed in the code
> > > describing the rationale.
> > 
> > I'm trying to figure out where CONFIG_IPMI_SI comes in here.  It's
> > nowhere in these patches or in drivers/acpi.  ACPI_IPMI depends on
> > IPMI_HANDLER, but that's all I found.  However, ACPI_IPMI can be "m" as
> > you mention and SENSOR_ACPI_POWER is only under the ACPI config, which
> > is a problem.
> > 
> 
> The patch above is looking for IPI0001, which is instantiated in
> 
> drivers/char/ipmi/ipmi_si_platform.c:   { "IPI0001", 0 },
> drivers/char/ipmi/ipmi_ssif.c:  { "IPI0001", 0 },
> 
> Are you saying that the above code doesn't depend on it ? In that case,
> why does it need to check for the IPI0001 device in the first place ?
> 
> That will need another comment/explanation in the code because people
> (or maybe dummies) like me won't understand the non-dependency (i.e.,
> the need to look for IPI0001 but not requiring the associated code).
> 
> More specifically, unless I really don't understand the acpi code,
> acpi_dev_get_first_match_dev() will return NULL if there is no matching
> device. In that case, the above code won't call acpi_wait_for_acpi_ipmi().
> Fine, but why would this driver have to wait for ipmi if and only if there
> is a device (and thus a driver) for IPI0001 ?

Honestly, I don't really understand the acpi code that well, either.
What I think it's saying is that if IPI0001 is present in the ACPI
tables (there is an acpi_device present), then wait for the driver to
get loaded.  It could be IPMI_SI or IPMI_SSIF, but there's no direct
connection between this code and the low-level IPMI driver.  I don't
think it forces the driver to load, at least not from what I can tell.

And another bug.  From the description of acpi_dev_get_first_match_dev():
The caller is responsible for invoking acpi_dev_put() on the returned device.

As you said, this is a big hack.  There must be a better way.

-corey

> 
> Thanks,
> Guenter
> 
> > I do think there are other issues with this patch, though.  The IPMI
> > handler code decouples the user from the driver from a dependency point
> > of view.  It seems to be fairly common to see IPMI_HANDLER and
> > ACPI_IPMI as "y" and IPMI_SI (and IPMI_SSIF, and others) as "m".  That
> > means this code will run but will wait for the IPMI device to appear,
> > which may not be until the module gets loaded, which may be far more
> > than 2 seconds later.
> > 
> > I'm not quite sure how to fix this.  Really, the add call for this
> > driver shouldn't be called until the IPMI device is present.  Doesn't
> > ACPI have mechanisms to handle this sort of thing?  If so, the hack may
> > need to be in the handling of that ACPI data (this field is not there
> > but should be), not here, which as Guenter says, is a big hack.
> > 
> > -corey
> > 
> > > 
> > > Third, the new symbol is declared with CONFIG_ACPI, but defined with
> > > CONFIG_IPMI_SI. I can not imagine how this would compile with CONFIG_ACPI=y
> > > and CONFIG_IPMI_SI={m,n} and/or CONFIG_ACPI_IPMI={m,n}.
> > > 
> > > On top of that, IPMI_SI and ACPI_IPMI are is tristate, as is SENSORS_ACPI_POWER.
> > > This means that SENSORS_ACPI_POWER=y combined with CONFIG_IPMI_SI={m,n} or
> > > CONFIG_ACPI_IPMI={m,n} will result in a compile failure.
> > > 
> > > Please make sure that this code compiles with all possible symbol combinations.
> > > 
> > > Thanks,
> > > Guenter
> > > 
> > > >    	res = read_capabilities(resource);
> > > >    	if (res)
> > > >    		goto exit_free;
> > > 
> > > 
> > 
> 
> 

