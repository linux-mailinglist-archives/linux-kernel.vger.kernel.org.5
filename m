Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEFA8061E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346524AbjLEWnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346259AbjLEWnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:43:22 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDCE1A2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:43:28 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5ab94fc098cso2471049a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 14:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701816208; x=1702421008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5PDjvnXiofAm+LfrZr5GVjzdYbiyiT62E/CMkJfzm4=;
        b=QfZxWlKsHMlPcqy9Kt+NlA82ZbgqK7VVPUBj50xMjomFqi0DrN66LhIjiZCaiQnCmc
         wxlKmRlSImP4+A1h+jCW63Baq6M3r5zGaiNsVQaNY2PokzeDJGVImg1pDxQToXNv7O2x
         FCDL1Hdqs/fxziQB78yMWtxDAKvGOA092rBMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701816208; x=1702421008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5PDjvnXiofAm+LfrZr5GVjzdYbiyiT62E/CMkJfzm4=;
        b=I/UJ6yQ5OLNMSnbf4CwXklqy3SlIJOcvo5vc+/q08V7rZN/OdQBCTt985Usizu6+yc
         Et9Mk9l47b91+ElI8hbuyGRW8l3bQA9WRo9NszAX73EwItzWhZapVjGDxCbflToRVv5B
         byM5hapsRbCtUoeCSV0puKWX3P6auyP4iDgM4mbKwwY7XfUQQPNr0Zrey88iwOhX5iSr
         wbTYuXoJqVqhBfjMToy4RZ2TvYf8guwtLnKZFEtp6YckxJENIBvUzYujf9/FhMFxbXsK
         JsdEUBZ3b7+VdOzcF7l9gTML/qOAniJ25IFldGhcX0z161PLMoD89NvCAo3N+h7qEOrU
         Un8Q==
X-Gm-Message-State: AOJu0YxwC0qoxnaCy6LItGf1PqjAdgWji9JgAjZNrk+okZhndbU6wgPy
        rxD4/k4rPBQqHpf9jOvTsqInBX+MxX6WUbWjx+BsYbPT8WGnnMj4fBeE1h4IHVX/0x9PM8wpV0q
        oGTeL5XBfnwMMnvYQhKAFjJ8uongOg5o=
X-Google-Smtp-Source: AGHT+IGLyjhmShxcrztf4iUASVXKLIZrQvbl2nOMjR/Yv9SysVtwrvaOGSlk/eSVNbluuvrw8muVoWkRUp1fFXY/kkM=
X-Received: by 2002:a05:6a20:1608:b0:18c:b6:ab4f with SMTP id
 l8-20020a056a20160800b0018c00b6ab4fmr4318468pzj.48.1701816207958; Tue, 05 Dec
 2023 14:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20231122233058.185601-8-amakhalov@vmware.com> <20231201232452.220355-1-amakhalov@vmware.com>
 <20231201232452.220355-7-amakhalov@vmware.com> <20231204103100.GYZW2qZE9tbGMtuVgY@fat_crate.local>
 <c2519c9a-8518-403a-9bca-cb79a5f2a6e9@intel.com> <204f743d-2901-4ad2-bbcc-a7857a8644e7@broadcom.com>
In-Reply-To: <204f743d-2901-4ad2-bbcc-a7857a8644e7@broadcom.com>
From:   Tim Merrifield <tim.merrifield@broadcom.com>
Date:   Tue, 5 Dec 2023 16:43:16 -0600
Message-ID: <CAJfbqWyeubVofe4BHQC+a3wacwk0kMPECa8mxZ7gkzhBJ3d5LA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] x86/vmware: Add TDX hypercall support
To:     Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Alexey Makhalov <amakhalov@vmware.com>,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        hpa@zytor.com, dave.hansen@linux.intel.co, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, netdev@vger.kernel.org,
        richardcochran@gmail.com, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, zackr@vmware.com,
        linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        namit@vmware.com, timothym@vmware.com, akaher@vmware.com,
        jsipek@vmware.com, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave and Alexey,

Regarding VMware-specific checks, it may be beneficial to add some
additional checks
such as ensuring that the hypervisor vendor is VMware,
r12=3D=3DVMWARE_HYPERVISOR_MAGIC,
r10=3D=3DVMWARE_TDX_VENDOR_LEAF, r11=3D=3DVMWARE_TDX_HCALL_FUNC and r13 (co=
mmand) is
restricted to those few commands we expect to be invoked from the
kernel or drivers by VMware-specific
code.

If we add these checks, would folks be OK with exporting this function?


On Tue, Dec 5, 2023 at 3:41=E2=80=AFPM Alexey Makhalov
<alexey.makhalov@broadcom.com> wrote:
>
>
>
> On 12/5/23 1:24 PM, Dave Hansen wrote:
> > On 12/4/23 02:31, Borislav Petkov wrote:
> >> On Fri, Dec 01, 2023 at 03:24:52PM -0800, Alexey Makhalov wrote:
> >>> +#ifdef CONFIG_INTEL_TDX_GUEST
> >>> +/* __tdx_hypercall() is not exported. So, export the wrapper */
> >>> +void vmware_tdx_hypercall_args(struct tdx_module_args *args)
> >>> +{
> >>> +   __tdx_hypercall(args);
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(vmware_tdx_hypercall_args);
> >> Uuuh, lovely. I'd like to see what the TDX folks think about this
> >> export first.
> >
> > I don't really like it much.  This does a generic thing (make a TDX
> > hypercall) with a specific name ("vmware_").  If you want to make an
> > argument that a certain chunk of the __tdx_hypercall() space is just fo=
r
> > VMWare and you also add a VMWare-specific check and then export *that*,
> > it might be acceptable.
> >
> > But I don't want random modules able to make random, unrestricted TDX
> > hypercalls.  That's asking for trouble.
>
> Considering exporting of __tdx_hypercall for random modules is not an
> option, what VMware specific checks you are suggesting?
>
> --
> This electronic communication and the information and any files transmitt=
ed
> with it, or attached to it, are confidential and are intended solely for
> the use of the individual or entity to whom it is addressed and may conta=
in
> information that is confidential, legally privileged, protected by privac=
y
> laws, or otherwise restricted from disclosure to anyone else. If you are
> not the intended recipient or the person responsible for delivering the
> e-mail to the intended recipient, you are hereby notified that any use,
> copying, distributing, dissemination, forwarding, printing, or copying of
> this e-mail is strictly prohibited. If you received this e-mail in error,
> please return the e-mail to the sender, delete it from your computer, and
> destroy any printed copy of it.

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.
