Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D90782851
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjHULzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjHULzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:55:37 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB57129
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:55:11 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-79af014b555so1012869241.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692618910; x=1693223710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gR8I8Q6lx9u8Hp3ihISykSpTYB0L05CPENUuRUE8Ag=;
        b=D9GP2yfrhDGiqqYYGcGKvFWhUtpwmb+1csMOfoZuC338sR+Dg10xlYhB1j6yuQdU3m
         5tRJ7LZnLBSsDYQHZGWnFciHZELXTrF0l+n71FgFdd+PIheqOhHJ3QI2vbmV06M714El
         7aTOIBxaHsc0DlnR8Y0Ji/CuK+C2ECBNlbsZMHp35PPzdJhlFm7M1AxtxLdbFCuJFzXy
         WxCZUE0736lF679uCYpiCQs3/ZDb94Md17FW+H6i0tqvUROfxpwPgbUL+O/uTxeQ3Wpc
         7mo2VxValkuAdVCRO5DKgRaMLFUATi7+Mg37/kxzWeVjeKei1YpbG4CyfOAC8dI/KrpI
         NSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692618910; x=1693223710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gR8I8Q6lx9u8Hp3ihISykSpTYB0L05CPENUuRUE8Ag=;
        b=WVvkT0AvETgIvtxRtUVWMrsNs7F8Vcix/jvYynD03O9VxTSxjWxr/gfnha1mF0yP2I
         pwDnZ6zPApGIcACkEWHUSMLa8sibXaiW2EPHLfQ0jyEV59nrstIH3C/je3E9s+6QwciL
         3yaj0+jVXxMtFrRpUWpkwccwNu6muEJQkBcPLsEGkut1TB353Qs1zVnPFEQ1rcFIM7Li
         XSzmgcoxme0fPCouxZcC2uMngkLGUU7MKfzJkvG4fh5sTsDwmmADSId8fuIkoYtEBJFO
         BOLCG9Pz8oSgHEaI4NPqhV8YvoK/WuTMa3592nn1JmC2u0Ik9RveEnQqM+cfLW2ppQbT
         bLrg==
X-Gm-Message-State: AOJu0Ywgz+lKCzZZ1IP9D2ihGuRn8BgnMCFLTFGnOQwFWgjeZQJuzI90
        uHmO2zRtQybUE6DeIx9fZow238nV2ielXKwQloy55Q==
X-Google-Smtp-Source: AGHT+IE2rHnMRiJRqvuyXM+0ECA3Mi1TUyfIRuccTB+v5EBSEi+uLFZvVob9chbPnXA+QkWaZ2U8AYaVn9pSrGt/c18=
X-Received: by 2002:a67:f70b:0:b0:44d:4385:1627 with SMTP id
 m11-20020a67f70b000000b0044d43851627mr2822642vso.14.1692618910548; Mon, 21
 Aug 2023 04:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
 <20230722014037.42647-2-shyamsaini@linux.microsoft.com> <CAPDyKFoBC+GaGerGDEAjg9q4ayV9mMBKkfFk3nO-zcQzOZ_H6Q@mail.gmail.com>
 <b875892c-1777-d84a-987e-1b0d5ac29df@linux.microsoft.com> <94728786-b41b-1467-63c1-8e2d5acfa5e4@linaro.org>
 <CAFA6WYNPViMs=3cbNsEdhqnjNOUCsHE_8uqiDTzwCKDNNiDkCw@mail.gmail.com> <CAHUa44Ek0k2b-igA6Gd1ZXVzibTh2sNDMnE-weQwFFKEZ_1jOA@mail.gmail.com>
In-Reply-To: <CAHUa44Ek0k2b-igA6Gd1ZXVzibTh2sNDMnE-weQwFFKEZ_1jOA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 21 Aug 2023 17:24:59 +0530
Message-ID: <CAFA6WYMLuvmXcc3FVoT_mOPsBrjPc3ucSoLK6qY_5995+ygHDw@mail.gmail.com>
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Shyam Saini <shyamsaini@linux.microsoft.com>,
        Jerome Forissier <jerome.forissier@linaro.org>,
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

On Mon, 21 Aug 2023 at 16:49, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Mon, Aug 21, 2023 at 12:03=E2=80=AFPM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > On Mon, 21 Aug 2023 at 15:19, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > >
> > >
> > > On 8/17/23 01:31, Shyam Saini wrote:
> > > >
> > > > Hi Ulf,
> > > >
> > > >> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
> > > >> <shyamsaini@linux.microsoft.com> wrote:
> > > >>>
> > > >>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > >>>
> > > >>> [This is patch 1 from [1] Alex's submission and this RPMB layer w=
as
> > > >>> originally proposed by [2]Thomas Winkler ]
> > > >>>
> > > >>> A number of storage technologies support a specialised hardware
> > > >>> partition designed to be resistant to replay attacks. The underly=
ing
> > > >>> HW protocols differ but the operations are common. The RPMB parti=
tion
> > > >>> cannot be accessed via standard block layer, but by a set of spec=
ific
> > > >>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> > > >>> partition provides authenticated and replay protected access, hen=
ce
> > > >>> suitable as a secure storage.
> > > >>>
> > > >>> The initial aim of this patch is to provide a simple RPMB Driver =
which
> > > >>> can be accessed by Linux's optee driver to facilitate fast-path f=
or
> > > >>> RPMB access to optee OS(secure OS) during the boot time. [1] Curr=
ently,
> > > >>> Optee OS relies on user-tee supplicant to access eMMC RPMB partit=
ion.
> > > >>>
> > > >>> A TEE device driver can claim the RPMB interface, for example, vi=
a
> > > >>> class_interface_register(). The RPMB driver provides a series of
> > > >>> operations for interacting with the device.
> > > >>
> > > >> I don't quite follow this. More exactly, how will the TEE driver k=
now
> > > >> what RPMB device it should use?
> > > >
> > > > I don't have complete code to for this yet, but i think OP-TEE driv=
er
> > > > should register with RPMB subsystem and then we can have eMMC/UFS/N=
VMe
> > > > specific implementation for RPMB operations.
> > > >
> > > > Linux optee driver can handle RPMB frames and pass it to RPMB subsy=
stem
> > > >
> >
> > It would be better to have this OP-TEE use case fully implemented. So
> > that we can justify it as a valid user for this proposed RPMB
> > subsystem. If you are looking for any further suggestions then please
> > let us know.
>
> +1
>
> >
> > > > [1] U-Boot has mmc specific implementation
> > > >
> > > > I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
> > > > CFG_RPMB_FS_DEV_ID=3D1 for /dev/mmcblk1rpmb,
> > >
> > > Correct. Note that tee-supplicant will ignore this device ID if --rmb=
-cid
> > > is given and use the specified RPMB instead (the CID is a non-ambiguo=
us way
> > > to identify a RPMB device).
> > >
> > > > but in case if a
> > > > system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
> > > > should be declared as secure storage and optee should access that o=
ne only.
> > >
> > > Indeed, that would be an equivalent of tee-supplicant's --rpmb-cid.
> > >
> > > > Sumit, do you have suggestions for this ?
> > >
> >
> > I would suggest having an OP-TEE secure DT property that would provide
> > the RPMB CID which is allocated to the secure world.
>
> Another option is for OP-TEE to iterate over all RPMBs with a
> programmed key and test if the key OP-TEE would use works.

That would require intercepting OP-TEE RPMB frames such that any
"write key" frame is blocked. As we don't want OP-TEE to occupy
unprovisioned RPMB partitions.

> That should
> avoid the problem of provisioning a device-unique secure DTB.

Okay I see the scalability concerns. So how about instead we have a
UFS/eMMC/NVMe controller specific boolean secure RPMB DT property?

> I'd
> expect that the RPMB key is programmed by a trusted provisioning tool
> since allowing OP-TEE to program the RPMB key has never been secure,
> not unless the OP-TEE binary is rollback protected.

Agree but any such RPMB key provisioning tool should either belong to
OP-TEE, u-boot or Linux.

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > >
> > > --
> > > Jerome
