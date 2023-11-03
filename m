Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D1A7E00B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346477AbjKCIfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346462AbjKCIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:35:12 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCD9D44
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:35:07 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6754b4091b6so10227216d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699000506; x=1699605306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nQWbcL/T3TlB1kRiOiag95+zWhxfHJr1Pmr2d9D+9g=;
        b=YQVK7PF/aMkEdA4TBNiIHNokXsWd40GWGEq2V2Zl/K+b3tWX1jr3FJ5ii9wWss143S
         ACLGrbu3Wzpw4U55EPArfsHlBTnnrgDnpV+a4gVw2yP9D0SWlU2/nikaFfVpiLhb1qdk
         Pe9WJ4+PsvwMwfayGcydLfXnOuNlaVU3kZwLIJXvXKjWqsx2a5ktQ3+DUCQrpI4PTb91
         Zu8N5Lohow0UB4ecD0cP6w80YvKtk4CKTpil+7ZILUFiUuk/f7281f2TiN+CAj3huf8z
         Q4xzZdGBRRcVE0hjv2uuprc/bf2hymLFP6RAUODSPDvlXGi2pUKLTwbdm39JhzKv2v0g
         4QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699000506; x=1699605306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nQWbcL/T3TlB1kRiOiag95+zWhxfHJr1Pmr2d9D+9g=;
        b=n0WswvDrLJd73LvoxrN2oiIGpDP0qZcPFTDebEOLAAwcWGk6EV2yZrGkIiyKU864pW
         7cwQMobbYcXFbRJpMTgEEQUVFYJd5Kg1qqU/FV4k2rZwNqKrBQH06rb4/6aOwCsINr4b
         G+jF8Vnt7GflHaVJ52usXtojWY91Z+MaP1miPn6a8ehYgmfEezNT/gIEN5dHMU8SXNsk
         VGtxHEAalsz0rxg4TAnkAG6f4GiDRT5IGewcW2mV4WAPMWxWhDwRZHPaheYRbxYuRth8
         VqsXi8s5/tnksQGt65twGxm86PcF8bpkyUDGVttRssQs+kWF8iD/WVo9dU46M7wc3wRj
         M6jA==
X-Gm-Message-State: AOJu0YyxgyCfegKhERSHtJyecnJ+6gyptUXZlOo+EToCi/kYwZcIZKkt
        I8Px1pcooCdMarvjQKs23tqhb9QnmsUFJmFx2Y16Ew==
X-Google-Smtp-Source: AGHT+IE5DsGvANqbxsuQaF1SolgSwmrS1iC1E8eMAmyRA11uXOzJOvVgtHl40CnD/cimv1XB1JU47T1UIzAeFdJ2hGk=
X-Received: by 2002:ad4:5bc4:0:b0:671:567d:b134 with SMTP id
 t4-20020ad45bc4000000b00671567db134mr18052970qvt.56.1699000506207; Fri, 03
 Nov 2023 01:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231102073056.174480-1-sumit.garg@linaro.org>
 <20231102073056.174480-2-sumit.garg@linaro.org> <CAC_iWjL_DLrKqbxvnWPmOYxLULjC46LMca5cF_sza1LDyifuWA@mail.gmail.com>
 <CAFA6WYO9S8n3uK9DYOMmFX=Sj1nSDFfKErZY4Xe4CM8+SgGhcA@mail.gmail.com>
In-Reply-To: <CAFA6WYO9S8n3uK9DYOMmFX=Sj1nSDFfKErZY4Xe4CM8+SgGhcA@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 3 Nov 2023 09:34:55 +0100
Message-ID: <CAHUa44Gto99R5iGPkE8SMZDT2GyvZ8fTgH9SVyrX7Hqk0XjBCg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tee: optee: Fix supplicant based device enumeration
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        op-tee@lists.trustedfirmware.org, jan.kiszka@siemens.com,
        arnd@linaro.org, ardb@kernel.org, jerome.forissier@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        diogo.ivo@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 3, 2023 at 6:52=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> Hi Ilias,
>
> On Thu, 2 Nov 2023 at 19:58, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Sumit,
> >
> > On Thu, 2 Nov 2023 at 09:31, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Currently supplicant dependent optee device enumeration only register=
s
> > > devices whenever tee-supplicant is invoked for the first time. But it
> > > forgets to remove devices when tee-supplicant daemon stops running an=
d
> > > closes its context gracefully. This leads to following error for fTPM
> > > driver during reboot/shutdown:
> > >
> > > [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke =
error: 0xffff3024
> > >
> > > Fix this by adding an attribute for supplicant dependent devices so t=
hat
> > > the user-space service can detect and detach supplicant devices befor=
e
> > > closing the supplicant:
> > >
> > > $ for dev in /sys/bus/tee/devices/*; do if [[ -f "$dev/need_supplican=
t" && -f "$dev/driver/unbind" ]]; \
> > >       then echo $(basename "$dev") > $dev/driver/unbind; fi done
> > >
> > > Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > Link: https://github.com/OP-TEE/optee_os/issues/6094

Checkpatch complains here, we should use "Closes:" instead of "Link:".

> > > Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enume=
ration")
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  .../ABI/testing/sysfs-bus-optee-devices         |  9 +++++++++
> > >  drivers/tee/optee/device.c                      | 17 +++++++++++++++=
--
> > >  2 files changed, 24 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Docu=
mentation/ABI/testing/sysfs-bus-optee-devices
> > > index 0f58701367b6..d914f6629662 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-optee-devices
> > > +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > > @@ -6,3 +6,12 @@ Description:
> > >                 OP-TEE bus provides reference to registered drivers u=
nder this directory. The <uuid>
> > >                 matches Trusted Application (TA) driver and correspon=
ding TA in secure OS. Drivers
> > >                 are free to create needed API under optee-ta-<uuid> d=
irectory.
> > > +
> > > +What:          /sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant
> > > +Date:          July 2008
> >
> > nit, date needs changing
> >
>
> Thanks for catching that. If nothing major comes up then I hope Jens
> can correct it while applying.

Sure, I can update it to November 2023.

I'll fix the date and the "Closes:" tag if there's no v5.

Cheers,
Jens

>
> > > +KernelVersion: 6.7
> > > +Contact:       op-tee@lists.trustedfirmware.org
> > > +Description:
> > > +               Allows to distinguish whether an OP-TEE based TA/devi=
ce requires user-space
> > > +               tee-supplicant to function properly or not. This attr=
ibute will be present for
> > > +               devices which depend on tee-supplicant to be running.
> > > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > > index 64f0e047c23d..4b1092127694 100644
> > > --- a/drivers/tee/optee/device.c
> > > +++ b/drivers/tee/optee/device.c
> > > @@ -60,7 +60,16 @@ static void optee_release_device(struct device *de=
v)
> > >         kfree(optee_device);
> > >  }
> > >
> > > -static int optee_register_device(const uuid_t *device_uuid)
> > > +static ssize_t
> >
> > (struct device *dev,
> > > +                                   struct device_attribute *attr,
> > > +                                   char *buf)
> > > +{
> > > +       return 0;
> > > +}
> > > +
> > > +static DEVICE_ATTR_RO(need_supplicant);
> > > +
> > > +static int optee_register_device(const uuid_t *device_uuid, u32 func=
)
> > >  {
> > >         struct tee_client_device *optee_device =3D NULL;
> > >         int rc;
> > > @@ -83,6 +92,10 @@ static int optee_register_device(const uuid_t *dev=
ice_uuid)
> > >                 put_device(&optee_device->dev);
> > >         }
> > >
> > > +       if (func =3D=3D PTA_CMD_GET_DEVICES_SUPP)
> > > +               device_create_file(&optee_device->dev,
> > > +                                  &dev_attr_need_supplicant);
> > > +
> > >         return rc;
> > >  }
> > >
> > > @@ -142,7 +155,7 @@ static int __optee_enumerate_devices(u32 func)
> > >         num_devices =3D shm_size / sizeof(uuid_t);
> > >
> > >         for (idx =3D 0; idx < num_devices; idx++) {
> > > -               rc =3D optee_register_device(&device_uuid[idx]);
> > > +               rc =3D optee_register_device(&device_uuid[idx], func)=
;
> > >                 if (rc)
> > >                         goto out_shm;
> > >         }
> > > --
> > > 2.34.1
> > >
> >
> > Other than that
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Thanks.
>
> -Sumit
