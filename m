Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0DB7DED86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjKBHhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjKBHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:37:43 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B3312B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:37:37 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-45d72e4eb31so80649137.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698910656; x=1699515456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=39/MnCG/gD4mKDfarw8iQQFYjQ6DMO8A5yB1tHLrYgE=;
        b=Uf6hJ5G1cE6waU2epvjtjCiv+q3ftVHrxFihZriWMVQNQrTGH71+YJY2rwMArFP2zF
         Wkozh9rMNlTmwOZQFcufo9wGka7IE2IZzk9vxv+gC6/QFXf0rVNavEZNxH2BcFWiOYd0
         WJMOODsUpvgHLK169ycJQowsH2vuVfSgEYJlyZfXaI4zFhqPTXAZzJeiK0F8skG+AEXC
         BsNVBSLdZFJiP//3kd//8E+uskKkMWn4UR20GzHj7DO1QJcD4oLJkqmncWu25ZrbOa4D
         GqVvlaFzPzMKQawtugPyvBM3FbQKUY1gkQAlkNJo+YexM1e0QNzVRvDKU38EGygWGfxU
         qlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698910656; x=1699515456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39/MnCG/gD4mKDfarw8iQQFYjQ6DMO8A5yB1tHLrYgE=;
        b=f8VUk5TCCBSgbIMjEYXjIv0LNX2InOo1swxTmVOgs4i+c52bDUOmzaGgfU3RCWc4Qr
         xWwSLk0m6FGgkpsJAs52BgAjJ4XoNU+ni+7cZhnT0YIk6tavYenKhyXv0UloRLjP1xxo
         KsmnyDvgYt4ukhupmFhCdSMTsmAIdohMgArkt2Oi+nwQFMzWuyPQyxr+YTSEhPT787ra
         3Q8TvV6RN1oTrKbCxIIpX0eH+M/mdUgP9hwxlsuTdjBHRLduFG1xdal5ZQzEvS2xIv1M
         JtqamZdijFrj0BWLfX82xP9C2crrZ3wtqRdn4uKz7d8C8wHrwIbH/s1RuMVZkTGJUmKC
         /3YA==
X-Gm-Message-State: AOJu0YwldnAm0AXlp+cCdeoGtn3oLpqSrQKggEIaU1AtRWLnCnI4G9T7
        ZM+0ASusP3B+RI28LNhd02Dp7WF9Tczr5k5XbMDPYUjY3Ac3r30sETU=
X-Google-Smtp-Source: AGHT+IGczuPcFh7ktMDLQ7QLgGV3i0dt3K2uI1b/ZRUyXAwifaqnxw1an2az8ljHoJWckCZ3jyOZK/nSydtGaxCYfw8=
X-Received: by 2002:a05:6102:20c4:b0:457:c10a:28d5 with SMTP id
 i4-20020a05610220c400b00457c10a28d5mr16496655vsr.20.1698910656428; Thu, 02
 Nov 2023 00:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231030155901.80673-1-sumit.garg@linaro.org> <20231030155901.80673-2-sumit.garg@linaro.org>
 <a54b6109-5a38-4d72-a197-00fee0162860@linaro.org> <1418e74e-175f-4b04-90d7-8bec2987c207@siemens.com>
In-Reply-To: <1418e74e-175f-4b04-90d7-8bec2987c207@siemens.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 2 Nov 2023 13:07:24 +0530
Message-ID: <CAFA6WYNe+pt2meP-KDtG2duYqWXHHwTCnHnm97PeNsbi+PJ5ng@mail.gmail.com>
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

On Tue, 31 Oct 2023 at 17:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 31.10.23 12:04, Jerome Forissier wrote:
> >
> >
> > On 10/30/23 16:59, Sumit Garg wrote:
> >> Currently supplicant dependent optee device enumeration only registers
> >> devices whenever tee-supplicant is invoked for the first time. But it
> >> forgets to remove devices when tee-supplicant daemon stops running and
> >> closes its context gracefully. This leads to following error for fTPM
> >> driver during reboot/shutdown:
> >>
> >> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
> >>
> >> Fix this by separating supplicant dependent devices so that the
> >> user-space service can detach supplicant devices before closing the
> >> supplicant.
> >>
> >> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> Link: https://github.com/OP-TEE/optee_os/issues/6094
> >> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
> >> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> >> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >> ---
> >>  drivers/tee/optee/device.c | 13 ++++++++++---
> >>  1 file changed, 10 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> >> index 64f0e047c23d..78fc0a15c463 100644
> >> --- a/drivers/tee/optee/device.c
> >> +++ b/drivers/tee/optee/device.c
> >> @@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
> >>      kfree(optee_device);
> >>  }
> >>
> >> -static int optee_register_device(const uuid_t *device_uuid)
> >> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
> >>  {
> >>      struct tee_client_device *optee_device = NULL;
> >> +    const char *dev_name_fmt = NULL;
> >>      int rc;
> >>
> >>      optee_device = kzalloc(sizeof(*optee_device), GFP_KERNEL);
> >> @@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uuid)
> >>
> >>      optee_device->dev.bus = &tee_bus_type;
> >>      optee_device->dev.release = optee_release_device;
> >> -    if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
> >> +
> >> +    if (func == PTA_CMD_GET_DEVICES_SUPP)
> >> +            dev_name_fmt = "optee-ta-supp-%pUb";
> >> +    else
> >> +            dev_name_fmt = "optee-ta-%pUb";
> >
> > That's an ABI change, isn't it?
>

Indeed it is an ABI break although we would like this to be backported
but don't want to break existing users. So I brainstormed on it and
came up with an alternative fix via device attribute in v4. Please
have a look.

> Oh, here did this come from! Yes, I recently had to adjust some systemd
> service due to carrying this patch but looking for the change only in
> upstream:
>
> https://github.com/ilbers/isar/commit/83644ddf694e51f11793e6107e4aaf68dc0043a5
>

You don't need to unbind all of the optee devices. v4 would help you
to maintain backwards compatibility, can you retest it?

-Sumit

> Jan
>
> >
> >> +
> >> +    if (dev_set_name(&optee_device->dev, dev_name_fmt, device_uuid)) {
> >>              kfree(optee_device);
> >>              return -ENOMEM;
> >>      }
> >> @@ -142,7 +149,7 @@ static int __optee_enumerate_devices(u32 func)
> >>      num_devices = shm_size / sizeof(uuid_t);
> >>
> >>      for (idx = 0; idx < num_devices; idx++) {
> >> -            rc = optee_register_device(&device_uuid[idx]);
> >> +            rc = optee_register_device(&device_uuid[idx], func);
> >>              if (rc)
> >>                      goto out_shm;
> >>      }
> >
>
> --
> Siemens AG, Technology
> Linux Expert Center
>
