Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB351787100
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbjHXOCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbjHXOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:01:51 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5451BC3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:01:40 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44d48168e2cso1885850137.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692885699; x=1693490499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgE1Z6hS5PELjPgipAhTPY+hEOvvc5P1iG+fu9pr+/k=;
        b=I/VxC+vxoc/EHs7XzgN70uqxwVQTpl3vtai+42TcV7nR3KFDq5Jz+LHjOIETirfusw
         aZE7uWz37nO2Ojt+VPpwhNsdgir8vpsjIlQzUeYrBCorvnmx2/Y9kBbGauUj6qZ4TNuq
         WlmmW5m4pn3UxEM0879scGUNVrSz67NVYjRpGJUZ9tBIE3byC19kIQ8qfO5ETL4mcM64
         1+o1S02w66PI4vGBv+5MV5OOENYuz0mJzG2N8+3Z6zeS6EQ/eXXWl77RjE2LmIUDwyki
         0phopVDvdd95+88ffBZG/qhNtStivEf8hD1kd7jAE033VppkBzSNKEx05mqeaAvV6Gab
         J40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692885699; x=1693490499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgE1Z6hS5PELjPgipAhTPY+hEOvvc5P1iG+fu9pr+/k=;
        b=R8mC5XPhvOvqb9QD/fbfAda5bFaJ1v5qKN8ZSe8wAmtpb91ZYgeLJcpypIB8E41RSH
         E+YPvPlYPn/M4Op6OydTurMBRTWDQnXlea231stVDMsYMYrHxbpgGmyHjMI9pobAR0N2
         a9PcBump9s+jaeu3TUCAUDp6B7zNbzgV9et/nFAwVZ8Es0lI+XwbaNoZ33sdDyOtV/Y2
         yNxo6knDmrn4zebZrhm6VYDidEkWKaDCIafh0Y8X/UTo9ETRnCwAU6e2DSCOqwnFXR6S
         Vypm9eAMQkpGK/kIfSCO2Rg9kBUEpRl+JMPyb83fa2zs5GwyrhwBUVtAGD2dlm/Bsj37
         j75Q==
X-Gm-Message-State: AOJu0YwayMgNTc2mQ6a9N2Zn5zWnVWWk0MTCyXx2d6iLrvV+f5rLnRrz
        DBXOB776dZo1RWn4/3DJEGn89EN7fIpS7/Otkkqq9g==
X-Google-Smtp-Source: AGHT+IExU45Wzw0uDMlScM3eigEjBo+8qsRt5W/u2kC/1ACD7gi5tr+OsjcvOtx3XwBJj1sC2cOVTqxGHuIn12NMr2I=
X-Received: by 2002:a67:e9d6:0:b0:44e:9ab0:ed24 with SMTP id
 q22-20020a67e9d6000000b0044e9ab0ed24mr1452325vso.24.1692885699504; Thu, 24
 Aug 2023 07:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
 <20230722014037.42647-2-shyamsaini@linux.microsoft.com> <CAPDyKFoBC+GaGerGDEAjg9q4ayV9mMBKkfFk3nO-zcQzOZ_H6Q@mail.gmail.com>
 <b875892c-1777-d84a-987e-1b0d5ac29df@linux.microsoft.com> <94728786-b41b-1467-63c1-8e2d5acfa5e4@linaro.org>
 <CAFA6WYNPViMs=3cbNsEdhqnjNOUCsHE_8uqiDTzwCKDNNiDkCw@mail.gmail.com> <d24dba8-a777-1acb-98f0-747998b6e8a3@linux.microsoft.com>
In-Reply-To: <d24dba8-a777-1acb-98f0-747998b6e8a3@linux.microsoft.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 24 Aug 2023 19:31:28 +0530
Message-ID: <CAFA6WYMYepbFwF0nWpR1vNkmzvFUoNojY1cWRPtGQAF8U8ngfA@mail.gmail.com>
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
To:     Shyam Saini <shyamsaini@linux.microsoft.com>
Cc:     Jerome Forissier <jerome.forissier@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-scsi@vger.kernel.org,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Tyler Hicks <code@tyhicks.com>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Paul Moore <paul@paul-moore.com>,
        Allen Pais <apais@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 at 00:29, Shyam Saini
<shyamsaini@linux.microsoft.com> wrote:
>
>
> Hi Sumit,
>
> > On Mon, 21 Aug 2023 at 15:19, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >>
> >>
> >> On 8/17/23 01:31, Shyam Saini wrote:
> >>>
> >>> Hi Ulf,
> >>>
> >>>> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
> >>>> <shyamsaini@linux.microsoft.com> wrote:
> >>>>>
> >>>>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >>>>>
> >>>>> [This is patch 1 from [1] Alex's submission and this RPMB layer was
> >>>>> originally proposed by [2]Thomas Winkler ]
> >>>>>
> >>>>> A number of storage technologies support a specialised hardware
> >>>>> partition designed to be resistant to replay attacks. The underlyin=
g
> >>>>> HW protocols differ but the operations are common. The RPMB partiti=
on
> >>>>> cannot be accessed via standard block layer, but by a set of specif=
ic
> >>>>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> >>>>> partition provides authenticated and replay protected access, hence
> >>>>> suitable as a secure storage.
> >>>>>
> >>>>> The initial aim of this patch is to provide a simple RPMB Driver wh=
ich
> >>>>> can be accessed by Linux's optee driver to facilitate fast-path for
> >>>>> RPMB access to optee OS(secure OS) during the boot time. [1] Curren=
tly,
> >>>>> Optee OS relies on user-tee supplicant to access eMMC RPMB partitio=
n.
> >>>>>
> >>>>> A TEE device driver can claim the RPMB interface, for example, via
> >>>>> class_interface_register(). The RPMB driver provides a series of
> >>>>> operations for interacting with the device.
> >>>>
> >>>> I don't quite follow this. More exactly, how will the TEE driver kno=
w
> >>>> what RPMB device it should use?
> >>>
> >>> I don't have complete code to for this yet, but i think OP-TEE driver
> >>> should register with RPMB subsystem and then we can have eMMC/UFS/NVM=
e
> >>> specific implementation for RPMB operations.
> >>>
> >>> Linux optee driver can handle RPMB frames and pass it to RPMB subsyst=
em
> >>>
> >
> > It would be better to have this OP-TEE use case fully implemented. So
> > that we can justify it as a valid user for this proposed RPMB
> > subsystem. If you are looking for any further suggestions then please
> > let us know.
>
> I was looking into UFS/NVMe user-space utils, it seems we may have to
> adapt rpmb frame data structure in optee-os to to handle NVMe/UFS
> specific bits.
>
> For nvme rpmb data frame, I think we would need an extra "target" member
> in rpmb data frame structure,
> as NVMe can support upto 7 RPMB units, see  [1] "struct rpmb_data_frame_t=
"
> UFS may support upto 3 or 4 RPMB regions.
>
> So even if we use CID to uniquely identify RPMB device either from
> eMMC/NVMe/UFS, we still need identify which RPMB target/unit in case
> if the device is NVMe, and which RPMB region if the device UFS.
>
> Also both NVMe/UFS utils have two extra RPMB operations implemented,
> Although new request/response operation than eMMC spec:
>   1) Authenticated Device Configuration Block Write
>   2) Authenticated Device Configuration Block Read
>
> see [2] enum rpmb_request/response_type and [3]enum rpmb_op_type
>
> do we need those implemented as well ?

IMO, we should start with eMMC RPMB support first with OP-TEE. This is
what OP-TEE currently supports. And later on we can extend that
framework for UFS and NVMe RPMB.

We need to put extra care here regarding the eMMC RPMB ABI among
OP-TEE and Linux kernel. It should be designed in a way that it is
future compatible for UFS/NMVe. IOW, the bits that you have already
discovered above.

Also, we have to be backwards compatible with eMMC RPMB ABI towards
u-boot too since OP-TEE would use the same ABI whether it is towards
Linux or u-boot.

-Sumit

>
> Please let me know what you think about these.
>
> [1] https://github.com/linux-nvme/nvme-cli/blob/master/nvme-rpmb.c#L252
> [2] https://github.com/linux-nvme/nvme-cli/blob/master/nvme-rpmb.c#L230
> [3] https://github.com/westerndigitalcorporation/ufs-utils/blob/dev/ufs_r=
pmb.c#L27
>
> >>> [1] U-Boot has mmc specific implementation
> >>>
> >>> I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
> >>> CFG_RPMB_FS_DEV_ID=3D1 for /dev/mmcblk1rpmb,
> >>
> >> Correct. Note that tee-supplicant will ignore this device ID if --rmb-=
cid
> >> is given and use the specified RPMB instead (the CID is a non-ambiguou=
s way
> >> to identify a RPMB device).
> >>
> >>> but in case if a
> >>> system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
> >>> should be declared as secure storage and optee should access that one=
 only.
> >>
> >> Indeed, that would be an equivalent of tee-supplicant's --rpmb-cid.
> >>
> >>> Sumit, do you have suggestions for this ?
> >>
> >
> > I would suggest having an OP-TEE secure DT property that would provide
> > the RPMB CID which is allocated to the secure world.
> >
> > -Sumit
> >
> >>
> >> --
> >> Jerome
> >
