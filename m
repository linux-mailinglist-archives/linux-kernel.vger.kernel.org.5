Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEA07B38FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjI2R3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjI2R3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:29:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0112689
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50302e8fca8so7546e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696008407; x=1696613207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZPhV+/EescYNoXGPgKiBmp8aKwNwiwKoYsNuSuqswY=;
        b=rbG95gnsWVUIUE7rzWrKlQ4M4yLuF7vQzKHpyg+Y0HvpxUxL4L9zk0dCvE6yKaxko2
         VidezBNMeeSjyz1ptJhBL/tM93wGty7tlDsdbodPtvwEo+5U3SskJZrhdQ7krWSO/qj2
         zqqgQvRmcN7/HT1acKmFHC6LaxI4bp+0w95Hs5da75dVX/Rkw3be3t1+rUDK9VDyDa37
         8FMUz6BT6/MAnAlTMHkaLUu/Y4SGAJ385LXFuJIOQRklV1hx3/hUMPXAOQh6btxdUZxg
         2Kt5jATNwQVmYnxjbMY8HduUc1Zezfzjpi55zqNBM69MJpAaW2fu2akh3chu31j/pqQ4
         F04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008407; x=1696613207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZPhV+/EescYNoXGPgKiBmp8aKwNwiwKoYsNuSuqswY=;
        b=olFcLJne3/Bt+95oRLJOdv0BmO8t97ILaDQixWKu15xPrUZfOSrEjGfuepLjp9Jwoi
         LHkurL2vjRMWYa4JpoJ0rluwmmRaXq4Dlf+PwEFaPIfVoHdhNzC08ygeZlpNuNZ70zGq
         kC/g1Eos2mR3kRfOc/tdY3lEoRGaAKuk8RT8yoellvnLKZq35c23vEFStiykb8lHMVqh
         k3BLoxxr8hKdWqkZ2yxdnfqMqQaqgmomI75FG3HOjBYWBvtoEaaOd4L7REQvYA/XVFJ8
         bPrFEwEZmXoIGCcoR39V30Roz67H7sypx4R8Wb5mFwqnizuFYn0pnlM/GyneTHvKySKI
         0R4Q==
X-Gm-Message-State: AOJu0YyTf7bYw9ASFOo0yxynx4AV4WVupib+0xgQYU2M6H2h31RkLxNw
        Sb/EzIU2hSmpjtzZYYAIsD+/LnU4E2S1itsGqI+lHA==
X-Google-Smtp-Source: AGHT+IFIckkiJ7IDtcPtgReT4Fq1UwxsaGJZC+o5Zjm+RM8U8RzMO41DIeOfkVuUg1f+kk0U/Fa7aj2qoq0Q19HXl4g=
X-Received: by 2002:ac2:4c26:0:b0:501:a2b4:8ff5 with SMTP id
 u6-20020ac24c26000000b00501a2b48ff5mr3105lfq.7.1696008406607; Fri, 29 Sep
 2023 10:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570185411.596431.3153227201984845022.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6r2VPPMZ__SQfJse8qWsUyYW3AgYbOUVM0S_Vtk=KvkxQ@mail.gmail.com> <651602dc4c6e3_91c1e2947f@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <651602dc4c6e3_91c1e2947f@dwillia2-xfh.jf.intel.com.notmuch>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 29 Sep 2023 11:26:34 -0600
Message-ID: <CAMkAt6rrzS85ZT9T7r6iwQHoVyEPwaxQ3Xayp_6XMbU+RJzS4w@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] virt: tdx-guest: Add Quote generation support
 using TSM_REPORTS
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Erdem Aktas <erdemaktas@google.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 4:49=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Peter Gonda wrote:
> > On Mon, Sep 25, 2023 at 10:17=E2=80=AFPM Dan Williams <dan.j.williams@i=
ntel.com> wrote:
> > >
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.in=
tel.com>
> > >
> > > In TDX guest, the attestation process is used to verify the TDX guest
> > > trustworthiness to other entities before provisioning secrets to the
> > > guest. The first step in the attestation process is TDREPORT
> > > generation, which involves getting the guest measurement data in the
> > > format of TDREPORT, which is further used to validate the authenticit=
y
> > > of the TDX guest. TDREPORT by design is integrity-protected and can
> > > only be verified on the local machine.
> > >
> > > To support remote verification of the TDREPORT in a SGX-based
> > > attestation, the TDREPORT needs to be sent to the SGX Quoting Enclave
> > > (QE) to convert it to a remotely verifiable Quote. SGX QE by design c=
an
> > > only run outside of the TDX guest (i.e. in a host process or in a
> > > normal VM) and guest can use communication channels like vsock or
> > > TCP/IP to send the TDREPORT to the QE. But for security concerns, the
> > > TDX guest may not support these communication channels. To handle suc=
h
> > > cases, TDX defines a GetQuote hypercall which can be used by the gues=
t
> > > to request the host VMM to communicate with the SGX QE. More details
> > > about GetQuote hypercall can be found in TDX Guest-Host Communication
> > > Interface (GHCI) for Intel TDX 1.0, section titled
> > > "TDG.VP.VMCALL<GetQuote>".
> > >
> > > Trusted Security Module (TSM) [1] exposes a common ABI for Confidenti=
al
> > > Computing Guest platforms to get the measurement data via ConfigFS.
> > > Extend the TSM framework and add support to allow an attestation agen=
t
> > > to get the TDX Quote data (included usage example below).
> > >
> > >   report=3D/sys/kernel/config/tsm/report/report0
> > >   mkdir $report
> > >   dd if=3D/dev/urandom bs=3D64 count=3D1 > $report/inblob
> > >   hexdump -C $report/outblob
> > >   rmdir $report
> > >
> > > GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
> > > with TDREPORT data as input, which is further used by the VMM to copy
> > > the TD Quote result after successful Quote generation. To create the
> > > shared buffer, allocate a large enough memory and mark it shared usin=
g
> > > set_memory_decrypted() in tdx_guest_init(). This buffer will be re-us=
ed
> > > for GetQuote requests in the TDX TSM handler.
> > >
> > > Although this method reserves a fixed chunk of memory for GetQuote
> > > requests, such one time allocation can help avoid memory fragmentatio=
n
> > > related allocation failures later in the uptime of the guest.
> > >
> > > Since the Quote generation process is not time-critical or frequently
> > > used, the current version uses a polling model for Quote requests and
> > > it also does not support parallel GetQuote requests.
> > >
> > > Link: https://lore.kernel.org/lkml/169342399185.3934343.3035845348326=
944519.stgit@dwillia2-xfh.jf.intel.com/ [1]
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy=
@linux.intel.com>
> > > Reviewed-by: Erdem Aktas <erdemaktas@google.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > Hey Dan,
> >
> > I tried running your test commands on an SNP enabled guest. To build
> > the kernel I just checked out linus/master and applied your series. I
> > haven't done any debugging yet, so I will update with what I find.
> >
> > root@Ubuntu2004:~#   hexdump -C $report/outblob
> > [  219.871875] ------------[ cut here ]------------
> > [  219.876642] kernel BUG at include/linux/scatterlist.h:187!
>
> Ok, it does not like virtual address of one of the buffers, but my
> changes "should" not have affected that as get_ext_report() internally
> uses snp_dev->certs_data and snp_dev->response for bounce buffering the
> actual request / response memory. First test I want to try once I can
> get on an SNP system is compare this to the ioctl path just make sure
> that succeeds.

I tried the IOCTL with our attestation test and it seems to be working
fine. I was hoping to debug further next week.

I also mailed you offlist to discuss getting access to SNP for testing.
