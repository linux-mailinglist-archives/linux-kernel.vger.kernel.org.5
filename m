Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9A7DEDD2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjKBIDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjKBIDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:03:06 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D261132
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:03:01 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49d45964fcaso1094234e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 01:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698912180; x=1699516980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cKQS5PgvItDvNN05vSK2iMgNMHwbhRI+e2Nai2snXOQ=;
        b=f8MxWnfWTz/DA7Av4ipA3+Ct8iY79xSecknrYMvXtqkkN6l4otTjyKMEQ4kGHDmzVl
         ta/GWuEG27GGNqlFriVEIv+XFtjh/3xTuNuq2uDoynGODtP0Ob+rIX/Nca/Yev9R1Q3F
         drzU2kwHS6v1cTalBW4rBowTptYtYyGhDX+boPU5Ui0c6KDpo7v4S/zvZ26JfxDckx8E
         11MvcUWt6diYRGlJJoxUKbloi9EgEua2yQtPYnpZcYBGmUyXeh2Luwf/Va/4H8tRg6xa
         vI3KXPpo9QK3YjfxGUCuLJJUTkgkFCe9ZXs0dlr7tM73boOGmSxW9Ef9LPuI/4f80dJB
         aKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698912180; x=1699516980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKQS5PgvItDvNN05vSK2iMgNMHwbhRI+e2Nai2snXOQ=;
        b=hxCydgJ/1mKqJ0ylZgB8dzDlBht0+UwHZAsKQ1o8VY1e0uqL8Zs1OP4jH2pqTHyFBu
         zEtPOhEDvMF7wGWvs3DunBMGwC01LAm8Z/zP4orA6MiVgmIEDCNzdo5FcAs/M/VHKFGX
         je6bsBSsw5xJAXxi6DqzgafRlxpIGmHlG1VrnpEPLqvZpDDJwutE1m99H7VFWI11LlZF
         J7AS/+n4HOHmjzj0OfgE4cA7zYxnpHKjqUhe15FMXWyOwF66UGoh7zDTFgPeAu58tt4L
         XvSqToHhQRm00Jx65+6mQZWvWUVenZd//vF8kv3Cic+/tccbA4n/n4waVzwzC9/pC6h/
         3yyA==
X-Gm-Message-State: AOJu0YwS5erZEWiFQ0GrpbeS7RXOi4G3uwbiQx9JlfS9o0TTKTODRecz
        nqAy3aGasj0Cqt8HK9wO5I0/zN1nQgVM3gpwKyLeuA==
X-Google-Smtp-Source: AGHT+IHTY134eMH+UQu0qE0OSoh5VYBjnfJwKvx7lq3FMSI3bMeR22IziFnPi2xHEeziSTsgs67AJBJekWwNpzj2S5E=
X-Received: by 2002:ac5:cc5c:0:b0:496:2d54:e6f0 with SMTP id
 l28-20020ac5cc5c000000b004962d54e6f0mr2379457vkm.6.1698912180333; Thu, 02 Nov
 2023 01:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231030155901.80673-1-sumit.garg@linaro.org> <20231030155901.80673-2-sumit.garg@linaro.org>
 <a54b6109-5a38-4d72-a197-00fee0162860@linaro.org> <1418e74e-175f-4b04-90d7-8bec2987c207@siemens.com>
 <CAFA6WYNe+pt2meP-KDtG2duYqWXHHwTCnHnm97PeNsbi+PJ5ng@mail.gmail.com> <cb729887-13ba-4fe4-8824-3062aeb1ef8e@siemens.com>
In-Reply-To: <cb729887-13ba-4fe4-8824-3062aeb1ef8e@siemens.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 2 Nov 2023 13:32:48 +0530
Message-ID: <CAFA6WYN-9dYRbBNM8q=H1DE7YMH4_z2fJpyvSG+W=Hy=Vo8NrQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tee: optee: Fix supplicant based device enumeration
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Jerome Forissier <jerome.forissier@linaro.org>,
        jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
        arnd@linaro.org, ardb@kernel.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        diogo.ivo@siemens.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 13:28, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 02.11.23 08:37, Sumit Garg wrote:
> > On Tue, 31 Oct 2023 at 17:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 31.10.23 12:04, Jerome Forissier wrote:
> >>>
> >>>
> >>> On 10/30/23 16:59, Sumit Garg wrote:
> >>>> Currently supplicant dependent optee device enumeration only registers
> >>>> devices whenever tee-supplicant is invoked for the first time. But it
> >>>> forgets to remove devices when tee-supplicant daemon stops running and
> >>>> closes its context gracefully. This leads to following error for fTPM
> >>>> driver during reboot/shutdown:
> >>>>
> >>>> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
> >>>>
> >>>> Fix this by separating supplicant dependent devices so that the
> >>>> user-space service can detach supplicant devices before closing the
> >>>> supplicant.
> >>>>
> >>>> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>> Link: https://github.com/OP-TEE/optee_os/issues/6094
> >>>> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
> >>>> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>> Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >>>> ---
> >>>>  drivers/tee/optee/device.c | 13 ++++++++++---
> >>>>  1 file changed, 10 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> >>>> index 64f0e047c23d..78fc0a15c463 100644
> >>>> --- a/drivers/tee/optee/device.c
> >>>> +++ b/drivers/tee/optee/device.c
> >>>> @@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
> >>>>      kfree(optee_device);
> >>>>  }
> >>>>
> >>>> -static int optee_register_device(const uuid_t *device_uuid)
> >>>> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
> >>>>  {
> >>>>      struct tee_client_device *optee_device = NULL;
> >>>> +    const char *dev_name_fmt = NULL;
> >>>>      int rc;
> >>>>
> >>>>      optee_device = kzalloc(sizeof(*optee_device), GFP_KERNEL);
> >>>> @@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uuid)
> >>>>
> >>>>      optee_device->dev.bus = &tee_bus_type;
> >>>>      optee_device->dev.release = optee_release_device;
> >>>> -    if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
> >>>> +
> >>>> +    if (func == PTA_CMD_GET_DEVICES_SUPP)
> >>>> +            dev_name_fmt = "optee-ta-supp-%pUb";
> >>>> +    else
> >>>> +            dev_name_fmt = "optee-ta-%pUb";
> >>>
> >>> That's an ABI change, isn't it?
> >>
> >
> > Indeed it is an ABI break although we would like this to be backported
> > but don't want to break existing users. So I brainstormed on it and
> > came up with an alternative fix via device attribute in v4. Please
> > have a look.
> >
> >> Oh, here did this come from! Yes, I recently had to adjust some systemd
> >> service due to carrying this patch but looking for the change only in
> >> upstream:
> >>
> >> https://github.com/ilbers/isar/commit/83644ddf694e51f11793e6107e4aaf68dc0043a5
> >>
> >
> > You don't need to unbind all of the optee devices. v4 would help you
> > to maintain backwards compatibility, can you retest it?
>
> How do I know from tee-supplicant perspective which devices I need to
> unbind? There could be one in the future that will also use storage and
> will therefore also fail once the supplicant is gone.
>

With v4, the devices where the below attribute is present need to
unbind before closing tee-supplicant.

/sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant

-Sumit

> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>
