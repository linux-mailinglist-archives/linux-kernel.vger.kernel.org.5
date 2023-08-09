Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8D7764C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjHIQPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHIQPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:15:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826B0C3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:15:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb0336ed4fso3151e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691597709; x=1692202509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ge4/pDkqmiTtO6zxF9ocy+mzFbM/2S8kdi07JV6tM/0=;
        b=GIeXUn3eT8b4PPj11nTp7+SktlRtr+CoOsOs9S5BJTDQeQ+qvnREL0KOp5C4SjzQd6
         o2DoIltjb5W87yZhMwngPqFUOtW4tZY+YoqJEGlLplYJzGZDeLOCQjg55IkgxgkD+KJs
         gq3Qu0crhbnbc+0qr6Ou4EXRw2zn2D54p6rWIVQxCwaivGS1YVLscvWTT8EBPrxENmzU
         EQfE3nrbGc5ds+vxCe9qFKg2G8fD6Z7K3xbPeOxy/1wYvgdAFh+2qIuPjw95rjGsCJjV
         1xJSH3gk4fPvTBcp6Bpjb/KP4w5tvzLVlsPpflzm4m4oz9HG2v0ezt6Ewh8RwE57U4Ek
         v7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691597709; x=1692202509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ge4/pDkqmiTtO6zxF9ocy+mzFbM/2S8kdi07JV6tM/0=;
        b=FMW3RwCJyuJz36LZ8dv6G/RPW7eHLINInuT+QW44WKlnd35I1yBBdNrZz0CosSXxYO
         fdZfqORB53f9bbXCHr8LQAf09pKMi04jecvURbnsQGzduF/+Cc+WDxkyNtFYqpFsAnQp
         3RMQdHR2ovb8NGI0ToEghKqJjFOekvzqMwApUf3JQuRngq0oyj85iptsx3LXE+YLgpOU
         I6aVJxqL1e23nLOCs/zsq3i9OIzvqjKsHiUoODsnmseKezjtShWmmbEJYts8c6xkRxr7
         5ChAsm0CISvykzUo7V6jzsu5keuLOZ/K795WbHUgnoaJC5ClU1Z450p4LM3jU0QI69o/
         t1kA==
X-Gm-Message-State: AOJu0YyjuP8OndV/caaJYfTGkyJ2Kc9lZr2tZnIHCqN9U3r2jZl+tzx2
        UxlvAHqs0eF6TPgvnbbWrKDbQ3wfKM0gqjpl3PzuCA==
X-Google-Smtp-Source: AGHT+IHF/WXoaAJAXDnuRVSjAdOpfVQAqUnaVBf5JE1I8R6N0ChVyF4sknYt10BzUS+acXM/g9461/MuuzbM3qtyPmc=
X-Received: by 2002:ac2:46f1:0:b0:4f6:257f:318f with SMTP id
 q17-20020ac246f1000000b004f6257f318fmr53321lfo.4.1691597708584; Wed, 09 Aug
 2023 09:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
 <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
 <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
 <2425e00b-defb-c12b-03e5-c3d23b30be01@linux.intel.com> <64d263e44e401_2138e29486@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHamob7g_+BRd0JW76cM7_vS=jzXzRjrgCPDxZ29VnzdCQ@mail.gmail.com>
 <64d270a2a68ce_5ea6e294f0@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHYht5s4CkS5Y9+VotPH4WqDrzng0vYy89oq0_U16H_dDA@mail.gmail.com>
 <64d286bda1d8b_5ea6e294eb@dwillia2-xfh.jf.intel.com.notmuch>
 <8d7acdd5d4824999ac6f28def43f9bdb8bd45d44.camel@intel.com> <64d307b94bd9_2138e29488@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64d307b94bd9_2138e29488@dwillia2-xfh.jf.intel.com.notmuch>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 9 Aug 2023 10:14:56 -0600
Message-ID: <CAMkAt6oTnjcpLch7DQmWyM+JOobhRMVNSQFrBxKV4Z4eB51oXA@mail.gmail.com>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation reports
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Huang, Kai" <kai.huang@intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
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

On Tue, Aug 8, 2023 at 9:28=E2=80=AFPM Dan Williams <dan.j.williams@intel.c=
om> wrote:
>
> Huang, Kai wrote:
> > On Tue, 2023-08-08 at 11:17 -0700, Dan Williams wrote:
> > > Dionna Amalie Glaze wrote:
> > > > >
> > > > > I do not see sysfs precluding a use case like that. If the kernel=
 can
> > > > > call out to userspace for TLS connection setup [1], then advanced=
 user
> > > > > can call out to a daemon for workload provenance setup. Recall th=
at TDX
> > > > > will round trip through the quoting enclave for these reports and=
,
> > > > > without measuring, that seems to have the potential to dominate t=
he
> > > > > setup time vs the communication to ask a daemon to convey a repor=
t.
> > > > >
> > > >
> > > > It's rather hard to get new daemons approved for container
> > > > distributions since they end up as resource hogs.
> > > > I really don't think it's appropriate to delegate to a daemon to
> > > > single-thread use of a kernel interface when the interface could
> > > > provide functional semantics to begin with.
> > >
> > > That's fair, it's also not without precedence for the kernel to await=
 a
> > > strong motivation of a use case before taking on a higher maintenance
> > > burden. Unifying kernel interfaces is important for maintainability a=
nd
> > > difficult / needs care. sysfs simplifies maintainability (but exports
> > > complexity to userspace), keyring simplifies that (but there is a val=
id
> > > argument that this is not a key), ioctl complicates that (it is not a=
s
> > > amenable to transport unification as the above options).
> > >
> >
> > I don't quite follow why ioctl() is not amenable to transport unificati=
on as the
> > /sysfs?  IIUC both are new ABI(s) to the userspace thus userspace needs=
 to adopt
> > anyway.
>
> Recall that the concern here is kernel maintainability, the kernel can
> decide to export complexity to userspace. In that light, ioctl() code is
> grotty sysfs is not. sysfs attributes (tsm blob options) are easy to
> reason about and audit, ioctl() is not. sysfs is easy to extend with
> local attributes to augment the core, ioctl() forces all the optionality
> to be planned up front.
>
> Basically, if you hand me a choice between maintaining a cross vendor
> ioctl() ABI vs a sysfs ABI, I am picking sysfs every time.

Thanks for the explanation. My pushback isn't because I really want an
IOCTL, rather I want the user to have the ability to get the exact
attestation report they want. This interface shown here was too
restrictive. If this can be accomplished with another ABI that sounds
fine to me.
