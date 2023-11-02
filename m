Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9C7DEDE9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjKBIJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjKBIJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:09:19 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB72128
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:09:13 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7b9dc92881eso283283241.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 01:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698912553; x=1699517353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3yGEMJ9IFoeOVwT4DcSTqO8vZq3/GXtKgmjkxRhuWPU=;
        b=XhuW3sxhyyKDQ/pP/FJ/3t5TfI9rdc6jGwLKEZIoVtuYee1PM3JnpVW3ieLtHWzz6T
         1Sp7uGamcMXDoV8q3eOcdlreNGHKTWu9eMODqQTrnJ5i29R8YfGU6og072iYGv2QQFxZ
         yXdcauID5BkLhasPSVO+h4nVIc3R7/gi0THQVALLouKQ+4DInTd3GAybpC/v6BHy+AtF
         MihBC+NOv8YWZ2Opf41ypWl38veUbyLYpMyHjGxoKhMIHUp5qOttNrVXw1mAlkg8mJG3
         lxIMhxHN7pkdmbc7EnFwbbHqNuo3nUiWQ/qtnKroOSqEPTWW1EoSHp7xB/HwHywCq3on
         XKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698912553; x=1699517353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yGEMJ9IFoeOVwT4DcSTqO8vZq3/GXtKgmjkxRhuWPU=;
        b=er/JPQI61O7ON+5U9ArZytVtKIEstHi9+l5eJAW1oURRDGT68w/uvdeocDsC+kceQ+
         cPcefm/9IM5KMaG9T0Om6OMzycg7iYsvh/b7ntuqq4pSH08b7w22vwt9WLTByQJbDxRJ
         mRNvU+G/hJTdEbJHa9SDHwe+FNQN2WnRITF+0MMaW5PIfK2fWIkaeOQHZ780IsOjpROB
         Lkz0e892LLL/L/yvlyrw4AGr3oIABORvSl9HeZZl+hzd74uCJEOuouLBBtURMzqHMqvb
         WlQP7tpP2VIidB+mA8ae3YJcx/8DyISrBo1PTJoGKfGzVGKDjiIZoQsVQtcGLHZve3uU
         BArA==
X-Gm-Message-State: AOJu0Yz700OI1wvlPyGZ84MSCwSENm/HPIMF5/MWDuJAdKRzn/zz6dKa
        r3Nn3C/rjOH2X9ot26ZUaXje6JGW0R/P6BQ0wr04VpwmufKDrzXL
X-Google-Smtp-Source: AGHT+IFcOq5MJ/ukwjbPy21XckZD6lehAZwXPxvB6UQV5UhenRE529iZl62ebmuZxtUO3osIHe0P0nXDnKAvf8Z9Q7Q=
X-Received: by 2002:a67:c199:0:b0:452:7f81:1502 with SMTP id
 h25-20020a67c199000000b004527f811502mr17046562vsj.26.1698912552860; Thu, 02
 Nov 2023 01:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231030155901.80673-1-sumit.garg@linaro.org> <20231030155901.80673-2-sumit.garg@linaro.org>
 <a54b6109-5a38-4d72-a197-00fee0162860@linaro.org> <1418e74e-175f-4b04-90d7-8bec2987c207@siemens.com>
 <CAFA6WYNe+pt2meP-KDtG2duYqWXHHwTCnHnm97PeNsbi+PJ5ng@mail.gmail.com>
 <cb729887-13ba-4fe4-8824-3062aeb1ef8e@siemens.com> <CAFA6WYN-9dYRbBNM8q=H1DE7YMH4_z2fJpyvSG+W=Hy=Vo8NrQ@mail.gmail.com>
 <61eb38c9-e40d-456a-86c8-e2d851b947f8@siemens.com>
In-Reply-To: <61eb38c9-e40d-456a-86c8-e2d851b947f8@siemens.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 2 Nov 2023 13:39:01 +0530
Message-ID: <CAFA6WYNXi9U2KXXSZOy2erjRSfe7vcXFduy+1sU=MzaFtrjpWQ@mail.gmail.com>
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

On Thu, 2 Nov 2023 at 13:35, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 02.11.23 09:02, Sumit Garg wrote:
> > On Thu, 2 Nov 2023 at 13:28, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 02.11.23 08:37, Sumit Garg wrote:
> >>> On Tue, 31 Oct 2023 at 17:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>>
> >>>> On 31.10.23 12:04, Jerome Forissier wrote:
> >>>>>
> >>>>>
> >>>>> On 10/30/23 16:59, Sumit Garg wrote:
> >>>>>> Currently supplicant dependent optee device enumeration only registers
> >>>>>> devices whenever tee-supplicant is invoked for the first time. But it
> >>>>>> forgets to remove devices when tee-supplicant daemon stops running and
> >>>>>> closes its context gracefully. This leads to following error for fTPM
> >>>>>> driver during reboot/shutdown:
> >>>>>>
> >>>>>> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
> >>>>>>
> >>>>>> Fix this by separating supplicant dependent devices so that the
> >>>>>> user-space service can detach supplicant devices before closing the
> >>>>>> supplicant.
> >>>>>>
> >>>>>> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>>> Link: https://github.com/OP-TEE/optee_os/issues/6094
> >>>>>> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
> >>>>>> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>>> Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >>>>>> ---
> >>>>>>  drivers/tee/optee/device.c | 13 ++++++++++---
> >>>>>>  1 file changed, 10 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> >>>>>> index 64f0e047c23d..78fc0a15c463 100644
> >>>>>> --- a/drivers/tee/optee/device.c
> >>>>>> +++ b/drivers/tee/optee/device.c
> >>>>>> @@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
> >>>>>>      kfree(optee_device);
> >>>>>>  }
> >>>>>>
> >>>>>> -static int optee_register_device(const uuid_t *device_uuid)
> >>>>>> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
> >>>>>>  {
> >>>>>>      struct tee_client_device *optee_device = NULL;
> >>>>>> +    const char *dev_name_fmt = NULL;
> >>>>>>      int rc;
> >>>>>>
> >>>>>>      optee_device = kzalloc(sizeof(*optee_device), GFP_KERNEL);
> >>>>>> @@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uuid)
> >>>>>>
> >>>>>>      optee_device->dev.bus = &tee_bus_type;
> >>>>>>      optee_device->dev.release = optee_release_device;
> >>>>>> -    if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
> >>>>>> +
> >>>>>> +    if (func == PTA_CMD_GET_DEVICES_SUPP)
> >>>>>> +            dev_name_fmt = "optee-ta-supp-%pUb";
> >>>>>> +    else
> >>>>>> +            dev_name_fmt = "optee-ta-%pUb";
> >>>>>
> >>>>> That's an ABI change, isn't it?
> >>>>
> >>>
> >>> Indeed it is an ABI break although we would like this to be backported
> >>> but don't want to break existing users. So I brainstormed on it and
> >>> came up with an alternative fix via device attribute in v4. Please
> >>> have a look.
> >>>
> >>>> Oh, here did this come from! Yes, I recently had to adjust some systemd
> >>>> service due to carrying this patch but looking for the change only in
> >>>> upstream:
> >>>>
> >>>> https://github.com/ilbers/isar/commit/83644ddf694e51f11793e6107e4aaf68dc0043a5
> >>>>
> >>>
> >>> You don't need to unbind all of the optee devices. v4 would help you
> >>> to maintain backwards compatibility, can you retest it?
> >>
> >> How do I know from tee-supplicant perspective which devices I need to
> >> unbind? There could be one in the future that will also use storage and
> >> will therefore also fail once the supplicant is gone.
> >>
> >
> > With v4, the devices where the below attribute is present need to
> > unbind before closing tee-supplicant.
> >
> > /sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant
>
> OK - but that will only help in future kernels, nothing we have today.
> Thus, the shutdown script cannot assume to alone kill those devices
> unless it find a certain upcoming kernel release.
>

This v4 fix will be backported to stable kernels. So you can update
your scripts once it lands into your stable tree.

-Sumit

> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>
