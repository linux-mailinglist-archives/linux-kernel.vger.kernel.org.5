Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4750D7B7120
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbjJCSh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbjJCShY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:37:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7111AF9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:37:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-502f29ed596so1059e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696358234; x=1696963034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm+7cYOviUtknmQJho1MKtDViZUMXc6rKNxLrNChrFE=;
        b=PKkNrlXyllguVwJ+6XyvgLNVccFf4czr/8MUIj/9qgZ/FV0DyVTuJIbwwk8nG5SQI1
         k0vullpFZY5/4NZphihSGJ067yY7xWn2jKgDkycsyr2ciL/SEYti/f3p4QGT2yv/+UTj
         kWJbnP5jgkEtcgQ+1RlHDNlnMG1Ac4BCJtYhtfW5aOgHNu1snrVPUuVjxvCai32LKqOE
         I08n7zGnagdbMwRKIEOxAHunpxLnYY/isrkZODX2fvhhWO2lRQBdJFBgOfz8qYeItWDS
         WyTdCNcLx5Kf6JZCdCgNg42vfmUeWQcLLA7rjxc4ZdO441snADD9kQ/ZCebBHPQM6qxg
         1A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696358234; x=1696963034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nm+7cYOviUtknmQJho1MKtDViZUMXc6rKNxLrNChrFE=;
        b=U8OOg2kS3lj5Uraae6ckZ3KhP/lYaaaZVc3/wZHfXdh4f3kxe89k6LuF4FIvKq0Tq+
         mEnnF+/C6lLAW27mklCpmbr229pbXDUc1Edrdxw51Rx3o1bR3mulFJMLMihlev2TEeI8
         vXR//bxZrEngJJAmU7A9xM3UfGYsQKIFD1mvC6Xm1ku+Bbxs4me/BwkGBMd42ZgelYaa
         vVU86X21dvIoVkRENdA9Wpra7LdLRI81sf5AsCiPDVFw97mFglXcrxwfw+IUNfUx1FQZ
         2RFrclxgbSe8RPCBZq0J8zUatjOKjbQQdqimmqrHJYpmq551gjQBvjly476DSHXZoTbJ
         KK8g==
X-Gm-Message-State: AOJu0Yy6g2z/Gix+Xejg0WWfo2jEWI3T3zVzIPVPvb0fv7vAD4YhW4sX
        o3KQtQ5TSCLnsndsxZR0CGX1YnmKeOyAvx3pZ/PFgw==
X-Google-Smtp-Source: AGHT+IGdkJLAOSTaCP9iR1nSmb71LB9wabpp+OpwtH+LOFpxDpXBbaAswNhzmlQFVKxR07+Cfxc89jVmUpKwnd3OSP0=
X-Received: by 2002:ac2:51a7:0:b0:502:cdb6:f316 with SMTP id
 f7-20020ac251a7000000b00502cdb6f316mr4633lfk.3.1696358234460; Tue, 03 Oct
 2023 11:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570185411.596431.3153227201984845022.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6r2VPPMZ__SQfJse8qWsUyYW3AgYbOUVM0S_Vtk=KvkxQ@mail.gmail.com>
 <651602dc4c6e3_91c1e2947f@dwillia2-xfh.jf.intel.com.notmuch> <CAMkAt6rrzS85ZT9T7r6iwQHoVyEPwaxQ3Xayp_6XMbU+RJzS4w@mail.gmail.com>
In-Reply-To: <CAMkAt6rrzS85ZT9T7r6iwQHoVyEPwaxQ3Xayp_6XMbU+RJzS4w@mail.gmail.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 3 Oct 2023 12:37:00 -0600
Message-ID: <CAMkAt6rwSwES_hEac=_7Gg8wcGosHMPXA3J2g_BGC_c+NbVp1w@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:26=E2=80=AFAM Peter Gonda <pgonda@google.com> wr=
ote:
>
> On Thu, Sep 28, 2023 at 4:49=E2=80=AFPM Dan Williams <dan.j.williams@inte=
l.com> wrote:
> >
> > Peter Gonda wrote:
> > > On Mon, Sep 25, 2023 at 10:17=E2=80=AFPM Dan Williams <dan.j.williams=
@intel.com> wrote:
> > > >
> > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.=
intel.com>
> > > >
> > > > In TDX guest, the attestation process is used to verify the TDX gue=
st
> > > > trustworthiness to other entities before provisioning secrets to th=
e
> > > > guest. The first step in the attestation process is TDREPORT
> > > > generation, which involves getting the guest measurement data in th=
e
> > > > format of TDREPORT, which is further used to validate the authentic=
ity
> > > > of the TDX guest. TDREPORT by design is integrity-protected and can
> > > > only be verified on the local machine.
> > > >
> > > > To support remote verification of the TDREPORT in a SGX-based
> > > > attestation, the TDREPORT needs to be sent to the SGX Quoting Encla=
ve
> > > > (QE) to convert it to a remotely verifiable Quote. SGX QE by design=
 can
> > > > only run outside of the TDX guest (i.e. in a host process or in a
> > > > normal VM) and guest can use communication channels like vsock or
> > > > TCP/IP to send the TDREPORT to the QE. But for security concerns, t=
he
> > > > TDX guest may not support these communication channels. To handle s=
uch
> > > > cases, TDX defines a GetQuote hypercall which can be used by the gu=
est
> > > > to request the host VMM to communicate with the SGX QE. More detail=
s
> > > > about GetQuote hypercall can be found in TDX Guest-Host Communicati=
on
> > > > Interface (GHCI) for Intel TDX 1.0, section titled
> > > > "TDG.VP.VMCALL<GetQuote>".
> > > >
> > > > Trusted Security Module (TSM) [1] exposes a common ABI for Confiden=
tial
> > > > Computing Guest platforms to get the measurement data via ConfigFS.
> > > > Extend the TSM framework and add support to allow an attestation ag=
ent
> > > > to get the TDX Quote data (included usage example below).
> > > >
> > > >   report=3D/sys/kernel/config/tsm/report/report0
> > > >   mkdir $report
> > > >   dd if=3D/dev/urandom bs=3D64 count=3D1 > $report/inblob
> > > >   hexdump -C $report/outblob
> > > >   rmdir $report
> > > >
> > > > GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
> > > > with TDREPORT data as input, which is further used by the VMM to co=
py
> > > > the TD Quote result after successful Quote generation. To create th=
e
> > > > shared buffer, allocate a large enough memory and mark it shared us=
ing
> > > > set_memory_decrypted() in tdx_guest_init(). This buffer will be re-=
used
> > > > for GetQuote requests in the TDX TSM handler.
> > > >
> > > > Although this method reserves a fixed chunk of memory for GetQuote
> > > > requests, such one time allocation can help avoid memory fragmentat=
ion
> > > > related allocation failures later in the uptime of the guest.
> > > >
> > > > Since the Quote generation process is not time-critical or frequent=
ly
> > > > used, the current version uses a polling model for Quote requests a=
nd
> > > > it also does not support parallel GetQuote requests.
> > > >
> > > > Link: https://lore.kernel.org/lkml/169342399185.3934343.30358453483=
26944519.stgit@dwillia2-xfh.jf.intel.com/ [1]
> > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswa=
my@linux.intel.com>
> > > > Reviewed-by: Erdem Aktas <erdemaktas@google.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > Hey Dan,
> > >
> > > I tried running your test commands on an SNP enabled guest. To build
> > > the kernel I just checked out linus/master and applied your series. I
> > > haven't done any debugging yet, so I will update with what I find.
> > >
> > > root@Ubuntu2004:~#   hexdump -C $report/outblob
> > > [  219.871875] ------------[ cut here ]------------
> > > [  219.876642] kernel BUG at include/linux/scatterlist.h:187!
> >
> > Ok, it does not like virtual address of one of the buffers, but my
> > changes "should" not have affected that as get_ext_report() internally
> > uses snp_dev->certs_data and snp_dev->response for bounce buffering the
> > actual request / response memory. First test I want to try once I can
> > get on an SNP system is compare this to the ioctl path just make sure
> > that succeeds.
>

I think there may be an issue with CONFIG_DEBUG_SG. That was the
warning we were getting in my above stack trace:

> [  219.876642] kernel BUG at include/linux/scatterlist.h:187!

This was for this line in enc_dec_message():

        sg_set_buf(&src[1], src_buf, hdr->msg_sz);

I am not sure why in sg_set_buf() virt_addr_valid() returns false for
the address given in the sev_report_new() which is from the variable
'ext_req' which is stack allocated?

static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
     unsigned int buflen)
{
#ifdef CONFIG_DEBUG_SG
    BUG_ON(!virt_addr_valid(buf));
#endif
    sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
}

When I disable CONFIG_DEBUG_SG in my config. Your patch seems to work,
well at least it doesn't crash the guest. I haven't checked if the
report is valid yet.
