Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F2578285A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjHUL4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjHUL4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:56:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F467B4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:56:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so4729638e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692618988; x=1693223788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzHaCli76XFFs33dAyI/yMfRmboZlidg3nEdkVe0b9Q=;
        b=X0ssVBK7yRWBK0zk6g+1Ji2ID9x9G2jXVwT9QWO2vm4RpbTC9yOqx0NwLHVxztI8lH
         T+rgXo+CVlMMfZBLfCloJByRuwn11CT5vBdrTfAFMdwitcWOJvlXGlKRMTR7tE8IOH78
         /bbomsm9zEwuH2y8m70LSQYmnlf0EXqJ9jgxGXsmMnsv5eN06tp3D4jYQe4uTF5gCFWm
         ni99YRNW/p5I564qyZ1Cyr221M1M1F/WvYCIqc1RdDfRL8YALCsCUm4IZmbkHE+Hh1Ux
         SrjqOBiiNGFvIvnAwrQeRLJNKwyQ1tIXJFedlfnsAbSfC+Z69fsHPilaU5N4SY98KBmE
         V0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692618988; x=1693223788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzHaCli76XFFs33dAyI/yMfRmboZlidg3nEdkVe0b9Q=;
        b=esXOIfgMyOEcGxfqYtXdxFUrIVhLQWInYw7HAFaj4K/FQRPrW6xrRTXe6YQZhUJ28N
         M8t/qrftVaLnb2kwh+/XuNmfY4xkbT2PL8ACxaOUay23r17I6H8XhBpbWhII3f1nuHHJ
         LywK5x6D2b0J5siBQx8Avs+aKTHZLJv9zd0FQg5axgspd+ATZKQjCr3pEOiLn09ylqxb
         IMCGVDrw19cx1mX063/Ss2NUcFDVXpM46bA40fpO6y+43FTYYTOsUAVZWZx2+1npI0ZR
         cSSLJx1XU5bhdC3mMyPTPcbbQkFcRl7D5zqHM0oh3zAxRmy+EaPAwBSwq2zK/3U4qH5F
         5qeA==
X-Gm-Message-State: AOJu0YxQC949tlYdHLxcZY+HtCkEu1sfF9IVmZtZok95A/0S2fz7z2Gf
        tk51HxZQhWutOK9EAtAsr3LvRiBzGcsWhkPVdmF5FQ==
X-Google-Smtp-Source: AGHT+IHDnDMYgdw1o22e43vEva7CUygObyhXkZuEOTOkU+m0tAPt9tiUDaG9HAE7F8xMAW9r3E9YZpl1nfGzX+qLqts=
X-Received: by 2002:a05:6512:108d:b0:4ff:9095:a817 with SMTP id
 j13-20020a056512108d00b004ff9095a817mr5762946lfg.57.1692618987664; Mon, 21
 Aug 2023 04:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
 <20230722014037.42647-2-shyamsaini@linux.microsoft.com> <CAPDyKFoBC+GaGerGDEAjg9q4ayV9mMBKkfFk3nO-zcQzOZ_H6Q@mail.gmail.com>
 <b875892c-1777-d84a-987e-1b0d5ac29df@linux.microsoft.com> <94728786-b41b-1467-63c1-8e2d5acfa5e4@linaro.org>
 <CAFA6WYNPViMs=3cbNsEdhqnjNOUCsHE_8uqiDTzwCKDNNiDkCw@mail.gmail.com> <CAHUa44Ek0k2b-igA6Gd1ZXVzibTh2sNDMnE-weQwFFKEZ_1jOA@mail.gmail.com>
In-Reply-To: <CAHUa44Ek0k2b-igA6Gd1ZXVzibTh2sNDMnE-weQwFFKEZ_1jOA@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Mon, 21 Aug 2023 14:55:51 +0300
Message-ID: <CAC_iWjKKap47PhiCi=BfPZC_wJhVDB10WSf9oWMgdwSgWCfO_A@mail.gmail.com>
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 at 14:19, Jens Wiklander <jens.wiklander@linaro.org> wr=
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
> programmed key and test if the key OP-TEE would use works. That should
> avoid the problem of provisioning a device-unique secure DTB. I'd
> expect that the RPMB key is programmed by a trusted provisioning tool
> since allowing OP-TEE to program the RPMB key has never been secure,
> not unless the OP-TEE binary is rollback protected.

+1 to that.  Overall we shound't 'trust' to do the programming. For
example, in OP-TEE if you compile it with device programming
capabilities, you can easily convince OP-TEE to send you the symmetric
key by swapping the supplicant with a malicious application.

Thanks
/Ilias
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
