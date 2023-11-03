Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE80D7DFEF1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 06:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjKCFwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 01:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjKCFwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 01:52:33 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D95F1B4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 22:52:27 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7b9bd9f8bfaso660264241.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 22:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698990746; x=1699595546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HiczkNxLsiyha9T8ai5EOTntUvui5yOEYDfeiqQv0M4=;
        b=tIfe8cs+MAc3FrkfZIbAt4liXiEF59YHN0SU2O2x5a0Zq2Cl290uug030iVMr0WYlr
         AQWFTNea5/9Vt+F9etSBU30/Uv8bmr6xHHx5A1r61W1keJvIulBWcQWkEO0G9Czg/7fG
         T6LvRXuAy6Xm6tyNDLh1BE1T+CGBkLvuBvRua6yMq3AqmfiXnJixPC+1WWuDNmNExf9R
         eyMIY4emNZHV3JnEW4RMFmaOXhtllh0Z7BV1UYt8lns8M1ZnFzake9puNNnRNPPI0rbi
         t1Z3mCVsWoUQPtmced5/0x8v2nxzknVXeF3hC/IqE8FzRzyhoqHh+AVy5YVsPeaTp/jl
         764Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698990746; x=1699595546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiczkNxLsiyha9T8ai5EOTntUvui5yOEYDfeiqQv0M4=;
        b=dVMsZxmCYfmH8jym69yaLoq52GHSjPOnEuacbBe1gtMDRAenPHpeWJPpDi9zB2vAhb
         /Fo7YFqTteTC0Ev8TyNBiX1PnwEZbMTgzNg9eI3hhAAnSYg1syD6BNXKSmJUPUO2n10s
         EJ39aI3qkzDHvEgcDHNpDY27M8/Ym7+ljChL0z/iNjrMKZNWJoxVBAIbW3130mq7Pju3
         iESdaF+tO3cxCobbYpV/bVJzLFnF5ie9/urau4SXk+tvc2rKZK+3qRiDvwCjGZTfpSdq
         TgQjggHLKvmwesGZBJAsC1ogVDswzItSnf49jXlEmB54dcx04ldtKRI4alUudNqgyhNj
         Vz3g==
X-Gm-Message-State: AOJu0Yx7hf/g5enPnY2odMGyVn4mYkb2aRvk17l1G7ASRSODQhU9ao9p
        RC31qDCPA5uCNP1og9uGn0ADZ4EJIrs5NfNGbeJIhQ==
X-Google-Smtp-Source: AGHT+IGwXdCuCQC/fspLPpyrSkbhZ57zFhJVZieGwX0daE68XKiMZ5J57gP6JDWRmDOch/IFhanq42jz2CR+MjpNFmw=
X-Received: by 2002:a67:e047:0:b0:45d:a10f:cb5c with SMTP id
 n7-20020a67e047000000b0045da10fcb5cmr8890vsl.18.1698990746690; Thu, 02 Nov
 2023 22:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231102073056.174480-1-sumit.garg@linaro.org>
 <20231102073056.174480-2-sumit.garg@linaro.org> <CAC_iWjL_DLrKqbxvnWPmOYxLULjC46LMca5cF_sza1LDyifuWA@mail.gmail.com>
In-Reply-To: <CAC_iWjL_DLrKqbxvnWPmOYxLULjC46LMca5cF_sza1LDyifuWA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 3 Nov 2023 11:22:15 +0530
Message-ID: <CAFA6WYO9S8n3uK9DYOMmFX=Sj1nSDFfKErZY4Xe4CM8+SgGhcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tee: optee: Fix supplicant based device enumeration
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
        jan.kiszka@siemens.com, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, masahisa.kojima@linaro.org,
        maxim.uvarov@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, diogo.ivo@siemens.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilias,

On Thu, 2 Nov 2023 at 19:58, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sumit,
>
> On Thu, 2 Nov 2023 at 09:31, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Currently supplicant dependent optee device enumeration only registers
> > devices whenever tee-supplicant is invoked for the first time. But it
> > forgets to remove devices when tee-supplicant daemon stops running and
> > closes its context gracefully. This leads to following error for fTPM
> > driver during reboot/shutdown:
> >
> > [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
> >
> > Fix this by adding an attribute for supplicant dependent devices so that
> > the user-space service can detect and detach supplicant devices before
> > closing the supplicant:
> >
> > $ for dev in /sys/bus/tee/devices/*; do if [[ -f "$dev/need_supplicant" && -f "$dev/driver/unbind" ]]; \
> >       then echo $(basename "$dev") > $dev/driver/unbind; fi done
> >
> > Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> > Link: https://github.com/OP-TEE/optee_os/issues/6094
> > Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  .../ABI/testing/sysfs-bus-optee-devices         |  9 +++++++++
> >  drivers/tee/optee/device.c                      | 17 +++++++++++++++--
> >  2 files changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > index 0f58701367b6..d914f6629662 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-optee-devices
> > +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > @@ -6,3 +6,12 @@ Description:
> >                 OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
> >                 matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
> >                 are free to create needed API under optee-ta-<uuid> directory.
> > +
> > +What:          /sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant
> > +Date:          July 2008
>
> nit, date needs changing
>

Thanks for catching that. If nothing major comes up then I hope Jens
can correct it while applying.

> > +KernelVersion: 6.7
> > +Contact:       op-tee@lists.trustedfirmware.org
> > +Description:
> > +               Allows to distinguish whether an OP-TEE based TA/device requires user-space
> > +               tee-supplicant to function properly or not. This attribute will be present for
> > +               devices which depend on tee-supplicant to be running.
> > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > index 64f0e047c23d..4b1092127694 100644
> > --- a/drivers/tee/optee/device.c
> > +++ b/drivers/tee/optee/device.c
> > @@ -60,7 +60,16 @@ static void optee_release_device(struct device *dev)
> >         kfree(optee_device);
> >  }
> >
> > -static int optee_register_device(const uuid_t *device_uuid)
> > +static ssize_t
>
> (struct device *dev,
> > +                                   struct device_attribute *attr,
> > +                                   char *buf)
> > +{
> > +       return 0;
> > +}
> > +
> > +static DEVICE_ATTR_RO(need_supplicant);
> > +
> > +static int optee_register_device(const uuid_t *device_uuid, u32 func)
> >  {
> >         struct tee_client_device *optee_device = NULL;
> >         int rc;
> > @@ -83,6 +92,10 @@ static int optee_register_device(const uuid_t *device_uuid)
> >                 put_device(&optee_device->dev);
> >         }
> >
> > +       if (func == PTA_CMD_GET_DEVICES_SUPP)
> > +               device_create_file(&optee_device->dev,
> > +                                  &dev_attr_need_supplicant);
> > +
> >         return rc;
> >  }
> >
> > @@ -142,7 +155,7 @@ static int __optee_enumerate_devices(u32 func)
> >         num_devices = shm_size / sizeof(uuid_t);
> >
> >         for (idx = 0; idx < num_devices; idx++) {
> > -               rc = optee_register_device(&device_uuid[idx]);
> > +               rc = optee_register_device(&device_uuid[idx], func);
> >                 if (rc)
> >                         goto out_shm;
> >         }
> > --
> > 2.34.1
> >
>
> Other than that
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks.

-Sumit
