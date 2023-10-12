Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96C17C721E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379320AbjJLQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346441AbjJLQKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:10:12 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF1DE0;
        Thu, 12 Oct 2023 09:10:10 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7dafb659cso14280777b3.0;
        Thu, 12 Oct 2023 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697127010; x=1697731810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U31QQ6oqfrHvcyV3YWQPCvzsOcxSTb4eUUepzZ2A96k=;
        b=XNEMfiTh9YzVpstt30BS3u3VUc6HzlF4WgSHLJlnUgDBGfGf1zInycWH9P1qlMZF8G
         ZQ+cN2hlQ2sRFEPsLdXpPsx/3cHBjzT5zP3rM7NJSBYMxDy8jQMners0s4bwj0NB7BhY
         m04JRDRd+hmBajSvzVdXWh3Xj1Z+hBsFLnuinVOuMyEe+1H0TLvrgRMD0MJ0bTW5ZXqb
         K3uorux0flFCpD7cTbd5pezL4A0ELFqMThD/Q3KIc+FOVqoGbeuFVv0zZkAf4HqFGox7
         Lyq2qMf+BFKqX7I+TSsHk0K+1bdpb9Kl8Unz78aONONNX3k8TUe6y9cM9PhsEvsfG+qP
         CSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127010; x=1697731810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U31QQ6oqfrHvcyV3YWQPCvzsOcxSTb4eUUepzZ2A96k=;
        b=frCCJ/Gf/L6HYndJyYAoL7qwXdZsCNl54ORUIjjaLDvqK0RDxPiAIkZ0+j5LVDGOY6
         ptSy3W/nkKdoU/Xrk3NiEes3lXPDTOKdaxq3gz0IDS9PRyTLM2zTk297XX5Ge1H0G6EP
         j073DO8orqKt+tZ6mffTccPwAw0oomZGWtvrZGwx8eQyHGm6/i5OMMha+TKXPoTPIP6q
         4ADj6KqymUbjN13ATDxqKtWAMxnk1I3Hh1VsD3tTK2NCTwzfWYlsWKkPnJ5bS2EvoI02
         ZY8HsUjCt5OZP9SAg0rzISTng8Qk128Ub14GD/9ZjrR4ZqZh99rh2arlOOrs4fMG+z9U
         wByg==
X-Gm-Message-State: AOJu0Yw0wTEsV/bs2MtzeSxTc/KBTZGFEGYc5Wz0SioX/QsFFpCTHY2I
        HtIB7+v8Y4X4oXN+pAcDqHLqrPrO9qLpm8FwZYk=
X-Google-Smtp-Source: AGHT+IE0L/hF7LnAQaml3Iw2C9VkW1fPyeijXPuKjoUyrjpwCACfHA6QETuANv0s/FG/EtLLHn8taq5PT01Vg4Ur6Go=
X-Received: by 2002:a25:d493:0:b0:d9a:ef4e:547b with SMTP id
 m141-20020a25d493000000b00d9aef4e547bmr831371ybf.41.1697127009682; Thu, 12
 Oct 2023 09:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
 <cd7bda98-2160-9271-9520-e98d1fe00ea5@linux.ibm.com> <331aafe1-df9b-cae4-c958-9cf1800e389a@huawei.com>
 <64d5a997-a1bf-7747-072d-711a8248874d@suse.de> <c4baacf1-0e86-9660-45f7-50ebc853e6af@huawei.com>
 <1dd69d03-b4f6-ab20-4923-0995b40f045d@suse.de> <d2f2c89f-c048-4f04-4d95-27958f0fa46a@huawei.com>
 <78d41ec1-b30c-f6d2-811c-e0e4adbc8f01@oracle.com> <84b38f16-2a32-f361-43e5-34bce1012e71@oracle.com>
 <769bcd36-4818-8470-2daa-49ac5c05b33a@suse.de> <e5f9e720-ddfd-ab8c-c8b9-18ba8ad266f0@huawei.com>
 <6329d8a3-3863-4185-8b64-567b4cf8491a@suse.de>
In-Reply-To: <6329d8a3-3863-4185-8b64-567b4cf8491a@suse.de>
From:   Wenchao Hao <haowenchao22@gmail.com>
Date:   Fri, 13 Oct 2023 00:09:57 +0800
Message-ID: <CAOptpSNNUxiv+g+xsU_iL=5v21BGLvAiNVc8KZNt=jRqz4LfRw@mail.gmail.com>
Subject: Re: [REQUEST DISCUSS]: speed up SCSI error handle for host with
 massive devices
To:     Hannes Reinecke <hare@suse.de>
Cc:     Wenchao Hao <haowenchao@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        John Garry <john.garry@huawei.com>, Wu Bo <wubo40@huawei.com>,
        Feilong Lin <linfeilong@huawei.com>, zhangjian013@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:51=E2=80=AFPM Hannes Reinecke <hare@suse.de> wro=
te:
>
> On 4/6/22 11:40, Wenchao Hao wrote:
> > On 2022/4/4 13:28, Hannes Reinecke wrote:
> >> On 4/3/22 19:17, Mike Christie wrote:
> >>> On 4/3/22 12:14 PM, Mike Christie wrote:
> >>>> We could share code with scsi_ioctl_reset as well. Drivers that supp=
ort
> >>>> TMFs via that ioctl already expect queuecommand to be possibly in th=
e
> >>>> middle of a run and IO not yet timed out. For example, the code to
> >>>> block a queue and reset the device could be used for the new EH and
> >>>> SG_SCSI_RESET_DEVICE handling.
> >>>>
> >>>
> >>> Hannes or others,
> >>>
> >>> How do parallel SCSI drivers support scsi_ioctl_reset? Is is not full=
y
> >>> supported and more only used for controlled testing?
> >>
> >> That's actually a problem in scsi_ioctl_reset(); it really should wait
> >> for all I/O to quiesce. Currently it just sets the 'tmf' flag and call=
s
> >> into the various reset functions.
> >>
> >> But really, I'd rather get my EH rework in before we're start discussi=
ng
> >> modifying EH behaviour.
> >> Let me repost it ...
> >>
> >
> > Would you take fast EH(such as single LUN reset) into consideration, ma=
ybe
> > a second but lightweight EH? It means a lot.
> >
> > Or give a way drivers can branch out the general timeout and EH handle =
logic?
>
> (Re-reading the thread:)
>
> If it's just about device reset I guess we can implement an asynchronous
> version. Based on my EH rework we could / should do:
>
> Have a 'eh_cmd_q' list per 'struct scsi_device' and 'struct
> scsi_target'. So Instead of always moving a failed command to the
> 'eh_cmq_q' list of the host, move it onto the list of the next higher
> level (eg a failed abort would move it to the eh_cmq_q of 'struct
> scsi_device', a failed device reset would move it to the eh_cmq_q of
> 'struct scsi_target' etc).
> That would actually make the code in SCSI EH easier to read as we
> could do away with constantly moving and splitting the per-host
> eh_cmq_q list.
>
> And then, as a second step, implement a new eh callback for
> asynchronous SCSI device aborts. That callback would need to
> stop I/O to the device first, send the TMF, and either
> restart the device upon successful completion or splice
> the list of failed commands onto the target and call
> the normal escalation with skipping eh_device_reset().
>

Yes, the RFC patch I sent before is based on this idea, and the details
of implementation may be different from what you described:

Here are how I did:

Three key operations are abstracted for scsi_device and scsi_target:

- mark device/target recovery: called in command dispatch path to stop I/O
- adding error command: called after abort failed to add error command
                                        to error list
- waking up error handling : called in scsi_device_unbusy() to wake up
                                            error handling work

Add struct scsi_device_eh and scsi_target_eh that encapsulate 3
callbacks for the above three key operations above, and invokes these 3
callbacks in the process mentioned above.

For details, please refer to the patch I posted before:
https://lore.kernel.org/linux-scsi/20230901094127.2010873-2-haowenchao2@hua=
wei.com/

The following two patches implement each of the three previously defined
callback functions, using kernel work to implement asynchrony handle.
https://lore.kernel.org/linux-scsi/20230901094127.2010873-9-haowenchao2@hua=
wei.com/
https://lore.kernel.org/linux-scsi/20230901094127.2010873-12-haowenchao2@hu=
awei.com/

For example, define following struct for error handling of scsi_device:

struct scsi_lun_eh {
        spinlock_t eh_lock;
        unsigned int eh_num;
        struct list_head eh_cmd_q;
        struct scsi_device *sdev;
        struct work_struct eh_handle_work;
        unsigned int fallback:1; /* If fallback to further */
        /* recovery on failure  */
};

The processing logic after awakening is as follows:

sdev_eh_work()
{
        try device reset
        if device reset succeed(including TUR)
                mark error command of this device handled
        else if fallback flag is false
                finish commands and mark this device offline
        fallback to target/host recovery
}

A flag fallback is defined here to determine whether to continue the advanc=
ed
reset after the device reset failed, because some drivers actually only
define the callback of the device reset, it is meaningless to continue
advanced reset for such drivers.

Note: the version I posted has bugs in adding commands which would be fixed
in the next version.

Looking for your response, thanks.

> Hmm?
>
> Cheers,
>
> Hannes
>
