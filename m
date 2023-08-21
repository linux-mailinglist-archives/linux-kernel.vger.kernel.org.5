Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8327828D3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjHUMSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbjHUMSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:18:04 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8F2CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:18:01 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-44768e056e1so1078408137.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692620281; x=1693225081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef2CJ7MVrIkAtM6KRm3CoFIA9zeGJWtcFDVbDKp64Yw=;
        b=Aq2F9jBdcp870EaKlwQhtf93Hqdx3EhLsEZUTQSZcsIpsIK/f8zQuV4avs76I4XlVk
         jBq96SjVo84Blgiv3bNCfmIqEfUJSwil4kVfD4nM1VFFZAp5LYbc4FxC3YXP9l4BrJzT
         6nMJek2xOYL9LY1T++P/hOH0tGvngEHwAhCuZl5a2UtEv6pU3mMiWz5DwtWdC8xLjxFg
         xQlA+55RCq5OMuWphxxO5byWg4GRsOV8DugBbyZDv8NtmQmDtYjBFhNmE+yBINGzR+W2
         bWItwsvTkmHRBMN1SfWP+NDAqJNtFZk4EKQF9LpXOGdx0lpHaf4/k86lNvcZ5mJFqQSQ
         JQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692620281; x=1693225081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef2CJ7MVrIkAtM6KRm3CoFIA9zeGJWtcFDVbDKp64Yw=;
        b=UjxLmmGZ9XOJjELgaBfhj1lzSCEmmNHNRDz5jdmLz58kuCAAustU0xWvrKdPtJ7vLI
         cVPSbfQ+COc7eOI+OBl4ebCf4ayLH6McyPPlEl0D7lp/nSJsNUaY81A6k+vj4Q5xh2aU
         sOAMdwYSpR3Cet9glUaVBWkDBcyjhMyOvl4mByOdv7OcF0PAWYUNNPxg3Jrn9XiY/edg
         9YZKppFmiRApfbLY1LAmSbvWALUQTvYSlJ9dS+DNjF1xsryGjRCJvt/VXg+HWZXo3rMw
         m5tTzBiUesKhebtryDsBFcIYcPadFrr3/LeaQo1bi5tVsoFZadFz5mIpE3NYhpwsxYYo
         UqZg==
X-Gm-Message-State: AOJu0YyEjLdJ1eVCqSqzLQ9eQyWIz+H22WfU8hxmFmx5MPzLAApsHpXe
        1mW73PSuAbjTXgiyN7wk6xNRG0TLyDjPg4NEFKTgrw==
X-Google-Smtp-Source: AGHT+IGcUFoygjyzPMhd4MRKXSAEwJf2yDxfOjjutokBnK7TaeFItjOvthxq5L4rawOsixQisDSYEWa/yZkdVDIwqYg=
X-Received: by 2002:a05:6102:48b:b0:444:bf88:c6d5 with SMTP id
 n11-20020a056102048b00b00444bf88c6d5mr5677608vsa.1.1692620280903; Mon, 21 Aug
 2023 05:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
 <20230722014037.42647-2-shyamsaini@linux.microsoft.com> <CAPDyKFoBC+GaGerGDEAjg9q4ayV9mMBKkfFk3nO-zcQzOZ_H6Q@mail.gmail.com>
 <b875892c-1777-d84a-987e-1b0d5ac29df@linux.microsoft.com> <94728786-b41b-1467-63c1-8e2d5acfa5e4@linaro.org>
 <CAFA6WYNPViMs=3cbNsEdhqnjNOUCsHE_8uqiDTzwCKDNNiDkCw@mail.gmail.com>
 <CAHUa44Ek0k2b-igA6Gd1ZXVzibTh2sNDMnE-weQwFFKEZ_1jOA@mail.gmail.com> <CAC_iWjKKap47PhiCi=BfPZC_wJhVDB10WSf9oWMgdwSgWCfO_A@mail.gmail.com>
In-Reply-To: <CAC_iWjKKap47PhiCi=BfPZC_wJhVDB10WSf9oWMgdwSgWCfO_A@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 21 Aug 2023 17:47:49 +0530
Message-ID: <CAFA6WYMPsBUutjKrm+6qTNHpVr80K2GcSLoYa+MFE3CfLSo8ew@mail.gmail.com>
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-scsi@vger.kernel.org,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Tyler Hicks <code@tyhicks.com>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Paul Moore <paul@paul-moore.com>,
        Allen Pais <apais@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 at 17:26, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Mon, 21 Aug 2023 at 14:19, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > On Mon, Aug 21, 2023 at 12:03=E2=80=AFPM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > >
> > > On Mon, 21 Aug 2023 at 15:19, Jerome Forissier
> > > <jerome.forissier@linaro.org> wrote:
> > > >
> > > >
> > > >
> > > > On 8/17/23 01:31, Shyam Saini wrote:
> > > > >
> > > > > Hi Ulf,
> > > > >
> > > > >> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
> > > > >> <shyamsaini@linux.microsoft.com> wrote:
> > > > >>>
> > > > >>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > > >>>
> > > > >>> [This is patch 1 from [1] Alex's submission and this RPMB layer=
 was
> > > > >>> originally proposed by [2]Thomas Winkler ]
> > > > >>>
> > > > >>> A number of storage technologies support a specialised hardware
> > > > >>> partition designed to be resistant to replay attacks. The under=
lying
> > > > >>> HW protocols differ but the operations are common. The RPMB par=
tition
> > > > >>> cannot be accessed via standard block layer, but by a set of sp=
ecific
> > > > >>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such=
 a
> > > > >>> partition provides authenticated and replay protected access, h=
ence
> > > > >>> suitable as a secure storage.
> > > > >>>
> > > > >>> The initial aim of this patch is to provide a simple RPMB Drive=
r which
> > > > >>> can be accessed by Linux's optee driver to facilitate fast-path=
 for
> > > > >>> RPMB access to optee OS(secure OS) during the boot time. [1] Cu=
rrently,
> > > > >>> Optee OS relies on user-tee supplicant to access eMMC RPMB part=
ition.
> > > > >>>
> > > > >>> A TEE device driver can claim the RPMB interface, for example, =
via
> > > > >>> class_interface_register(). The RPMB driver provides a series o=
f
> > > > >>> operations for interacting with the device.
> > > > >>
> > > > >> I don't quite follow this. More exactly, how will the TEE driver=
 know
> > > > >> what RPMB device it should use?
> > > > >
> > > > > I don't have complete code to for this yet, but i think OP-TEE dr=
iver
> > > > > should register with RPMB subsystem and then we can have eMMC/UFS=
/NVMe
> > > > > specific implementation for RPMB operations.
> > > > >
> > > > > Linux optee driver can handle RPMB frames and pass it to RPMB sub=
system
> > > > >
> > >
> > > It would be better to have this OP-TEE use case fully implemented. So
> > > that we can justify it as a valid user for this proposed RPMB
> > > subsystem. If you are looking for any further suggestions then please
> > > let us know.
> >
> > +1
> >
> > >
> > > > > [1] U-Boot has mmc specific implementation
> > > > >
> > > > > I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
> > > > > CFG_RPMB_FS_DEV_ID=3D1 for /dev/mmcblk1rpmb,
> > > >
> > > > Correct. Note that tee-supplicant will ignore this device ID if --r=
mb-cid
> > > > is given and use the specified RPMB instead (the CID is a non-ambig=
uous way
> > > > to identify a RPMB device).
> > > >
> > > > > but in case if a
> > > > > system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
> > > > > should be declared as secure storage and optee should access that=
 one only.
> > > >
> > > > Indeed, that would be an equivalent of tee-supplicant's --rpmb-cid.
> > > >
> > > > > Sumit, do you have suggestions for this ?
> > > >
> > >
> > > I would suggest having an OP-TEE secure DT property that would provid=
e
> > > the RPMB CID which is allocated to the secure world.
> >
> > Another option is for OP-TEE to iterate over all RPMBs with a
> > programmed key and test if the key OP-TEE would use works. That should
> > avoid the problem of provisioning a device-unique secure DTB. I'd
> > expect that the RPMB key is programmed by a trusted provisioning tool
> > since allowing OP-TEE to program the RPMB key has never been secure,
> > not unless the OP-TEE binary is rollback protected.
>
> +1 to that.  Overall we shound't 'trust' to do the programming. For
> example, in OP-TEE if you compile it with device programming
> capabilities, you can easily convince OP-TEE to send you the symmetric
> key by swapping the supplicant with a malicious application.
>

Agree, with your overall intent, that OP-TEE shouldn't expose RPMB key
in plain form. But with suggested OP-TEE RPMB frames routing via
kernel, tee-supplicant won't be used for RPMB accesses.

-Sumit

> Thanks
> /Ilias
> >
> > Cheers,
> > Jens
> >
> > >
> > > -Sumit
> > >
> > > >
> > > > --
> > > > Jerome
