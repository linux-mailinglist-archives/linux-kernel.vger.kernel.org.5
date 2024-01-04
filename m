Return-Path: <linux-kernel+bounces-16198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AB1823A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7DB2882AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53992103;
	Thu,  4 Jan 2024 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cx5mKoTJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4B20F7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8708C3F5AE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 02:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704334466;
	bh=hP9Ljk6vj9IfwiyEZCntQNwOkhNxgOUbUBOktssyTys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cx5mKoTJrUqbSWtmro60zl0HqGmUiRzJkBZVGIlM8CCY/XhcLoBMM4khmm9lyDHur
	 x8/gcknP8hWKJIU3EIqoIeC6lJJWYpChEnNgtuMe+m/7+uLzqHOrTCNfoLRO7Yj9f1
	 v8hOEmXt0BFtFuvq+c59MebzdyZrh3cPNbPTbz1RBi1ryJ6rOFDuvfej/8D9VkFFEK
	 MgBPdIpX7f6mHgRqgudBocbCHN2HAwp2JfRh/HsHD9t9OOdxrRpRCaJLHP4gJmMGpT
	 JXDoi/zi0bKfz1nueJe1pi8he4VQLIMeLeMVUgkd3flMh723cGqktbwpkNaTJnzyAn
	 INcEN/dsYbI0A==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28ccb055d6eso880208a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 18:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704334465; x=1704939265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hP9Ljk6vj9IfwiyEZCntQNwOkhNxgOUbUBOktssyTys=;
        b=cO6KHSf1G4kqOwrob3zjS8Qr7gn06rFYv/hYonoLgFSQ1e/EREY8tFrpJqe03OeMCM
         Smbhzq5UozHIUAGxpoTJclr1rIAqdC0E6GgPyz4muqs9p9n4YBUdpXQvehXxCeOr5sEq
         a2b4/ssYOW2Y6OtJ95OwSYiJWjlaogKqRzrShX70Q2gVtTWcRJXE2tTYi3+iW8C30LQX
         nI8Q0iz0hA7AfpYwt7RcT+Bbg2Dr6CqIWit9x03reFhl4LYRtLPgcl98uZtqcBochhTX
         mDcOecBset01Itb4LvS2XcEKhUrVo/CAeN3d1SgofpRlRjwbNN4rHsmkdpetRiE/X447
         HqVg==
X-Gm-Message-State: AOJu0YyN0S8U0HCKQpAHGDIRPZdLXOsiTiix7WWkar+u0DwV/4JgMxTs
	J4nP8bxRBwlQLoSyOPpqWAZFwQiYnpFIrTUguRfkXyllWTx+adfrhl9VsWC5HdpvYv+AHQ3pDL/
	sQ6V1jRPjdG7e2aVKqqUZirWV0czkCXWfdbT3y8ugjEKBz8Nas9IEoBVEj8U4VbPC
X-Received: by 2002:a17:90a:9b89:b0:28c:9b85:fd87 with SMTP id g9-20020a17090a9b8900b0028c9b85fd87mr2357445pjp.19.1704334464855;
        Wed, 03 Jan 2024 18:14:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBaEDU4xoq3fXu6YKSekz07lEtNdyGty4b6FmQ2FvS/MVZLqdTJWPebvwYWIEOsfCE0kk+nLH39bPP8PCQgP0=
X-Received: by 2002:a17:90a:9b89:b0:28c:9b85:fd87 with SMTP id
 g9-20020a17090a9b8900b0028c9b85fd87mr2357425pjp.19.1704334464473; Wed, 03 Jan
 2024 18:14:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227040401.548977-1-kai.heng.feng@canonical.com> <430501f6-47fc-49c8-8db8-9cbdf2ba1ae5@gmx.de>
In-Reply-To: <430501f6-47fc-49c8-8db8-9cbdf2ba1ae5@gmx.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 4 Jan 2024 10:14:11 +0800
Message-ID: <CAAd53p7-NkOa3QPD0szmC0OcHc1VGMBudVbAqWVstvqVm-kwWg@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (acpi_power_meter) Ensure IPMI space handler is
 ready on Dell systems
To: Armin Wolf <W_Armin@gmx.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 5:23=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 27.12.23 um 05:04 schrieb Kai-Heng Feng:
>
> > The following error can be observed at boot:
> > [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62=
c5) [IPMI] (20230628/evregion-130)
> > [    3.717928] ACPI Error: Region IPMI (ID=3D7) has no handler (2023062=
8/exfldio-261)
> >
> > [    3.717936] No Local Variables are initialized for Method [_GHL]
> >
> > [    3.717938] No Arguments are initialized for method [_GHL]
> >
> > [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previo=
us error (AE_NOT_EXIST) (20230628/psparse-529)
> > [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previo=
us error (AE_NOT_EXIST) (20230628/psparse-529)
> > [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
> >
> > On Dell systems several methods of acpi_power_meter access variables in
> > IPMI region [0], so wait until IPMI space handler is installed by
> > acpi_ipmi and also wait until SMI is selected to make the space handler
> > fully functional.
>
> Hi,
>
> could it be that the ACPI firmware expects us to support the ACPI SPMI ta=
ble?
> The ACPI SPMI table contains a description of the IPMI interface used by =
the platform,
> and its purpose seems to be similar to the ACPI ECDT table in that it all=
ows the OS
> to access IPMI resources before all ACPI namespaces are enumerated.
>
> Adding support for this table would solve this problem without stalling t=
he boot
> process by waiting for the ACPI IPMI device to probe. It would also avoid=
 any issues
> should the ACPI IPMI device be removed later.

Hi, the ACPI firmware on the system doesn't have SPMI table:
$ ls /sys/firmware/acpi/tables/
APIC  BERT  data  DMAR  DSDT  dynamic  EINJ  ERST  FACP  FACS  HEST
HMAT  HPET  MCFG  MIGT  MSCT  NBFT  OEM4  SLIC  SLIT  SRAT  SSDT1
SSDT2  SSDT3  SSDT4  SSDT5  SSDT6  TPM2  UEFI1  UEFI2  VFCT  WSMT

Kai-Heng

>
> Armin Wolf
>
> >
> > [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-=
v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-mes=
sages-displayed-in-dmesg?guid=3Dguid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >   - Use completion instead of request_module().
> >
> >   drivers/acpi/acpi_ipmi.c         | 13 ++++++++++++-
> >   drivers/hwmon/acpi_power_meter.c |  4 ++++
> >   include/acpi/acpi_bus.h          |  4 ++++
> >   3 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> > index 0555f68c2dfd..2ea8b7e6cebf 100644
> > --- a/drivers/acpi/acpi_ipmi.c
> > +++ b/drivers/acpi/acpi_ipmi.c
> > @@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
> >   #define IPMI_TIMEOUT                        (5000)
> >   #define ACPI_IPMI_MAX_MSG_LENGTH    64
> >
> > +static struct completion smi_selected;
> > +
> >   struct acpi_ipmi_device {
> >       /* the device list attached to driver_data.ipmi_devices */
> >       struct list_head head;
> > @@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct de=
vice *dev)
> >               if (temp->handle =3D=3D handle)
> >                       goto err_lock;
> >       }
> > -     if (!driver_data.selected_smi)
> > +     if (!driver_data.selected_smi) {
> >               driver_data.selected_smi =3D ipmi_device;
> > +             complete(&smi_selected);
> > +     }
> >       list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
> >       mutex_unlock(&driver_data.ipmi_lock);
> >
> > @@ -578,10 +582,17 @@ acpi_ipmi_space_handler(u32 function, acpi_physic=
al_address address,
> >       return status;
> >   }
> >
> > +void wait_for_acpi_ipmi(void)
> > +{
> > +     wait_for_completion_interruptible_timeout(&smi_selected, 2 * HZ);
> > +}
> > +EXPORT_SYMBOL_GPL(wait_for_acpi_ipmi);
> > +
> >   static int __init acpi_ipmi_init(void)
> >   {
> >       int result;
> >       acpi_status status;
> > +     init_completion(&smi_selected);
> >
> >       if (acpi_disabled)
> >               return 0;
> > diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_powe=
r_meter.c
> > index 703666b95bf4..acaf1ae68dc8 100644
> > --- a/drivers/hwmon/acpi_power_meter.c
> > +++ b/drivers/hwmon/acpi_power_meter.c
> > @@ -883,6 +883,10 @@ static int acpi_power_meter_add(struct acpi_device=
 *device)
> >       strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
> >       device->driver_data =3D resource;
> >
> > +     if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.") &&
> > +         acpi_dev_get_first_match_dev("IPI0001", NULL, -1))
> > +             wait_for_acpi_ipmi();
> > +
> >       res =3D read_capabilities(resource);
> >       if (res)
> >               goto exit_free;
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 1216d72c650f..ed59fb89721e 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -655,6 +655,7 @@ bool acpi_device_override_status(struct acpi_device=
 *adev, unsigned long long *s
> >   bool acpi_quirk_skip_acpi_ac_and_battery(void);
> >   int acpi_install_cmos_rtc_space_handler(acpi_handle handle);
> >   void acpi_remove_cmos_rtc_space_handler(acpi_handle handle);
> > +void wait_for_acpi_ipmi(void);
> >   #else
> >   static inline bool acpi_device_override_status(struct acpi_device *ad=
ev,
> >                                              unsigned long long *status=
)
> > @@ -672,6 +673,9 @@ static inline int acpi_install_cmos_rtc_space_handl=
er(acpi_handle handle)
> >   static inline void acpi_remove_cmos_rtc_space_handler(acpi_handle han=
dle)
> >   {
> >   }
> > +static inline void wait_for_acpi_ipmi(void)
> > +{
> > +}
> >   #endif
> >
> >   #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)

