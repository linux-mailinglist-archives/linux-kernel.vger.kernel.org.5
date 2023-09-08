Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF4798F02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbjIHT0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIHT0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:26:14 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE2E8E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 12:26:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso41074851fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694201168; x=1694805968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGY9pRP4zXPESEDG1xIzcqkXDG7GbyjbuJ87NJ2oFmw=;
        b=uXB5rtCUOfQnPrwQeKEIseMRdmTmhmEuVl1Uo+iHrPrlkUMC902J0CfSLbWEQgtMAo
         W6Qa1whRZKVDC4EFqq5uBwqXKWsuciuPXEGHUeRB8RKqKtPU4bCnYvEMh9rWSacmlCld
         sOf3MFbQpbsZREDYCwn1pgsDXRG6c3dlj/3NPjet2osETW8FiC0MYRiYyem8NQNap55u
         WYU1dr/Ijn3k+jKB5uTwhAsQ+0yfcHAQRigN+v6A/y4N3ltx52gaqr3+wNS0TF9rxovn
         CPCRZ7fctQlKluXpR5x4tpUgHS2Il8pPSTNd0svf6DMtGeIizafd8tRpn2P+jzfxtKPv
         dXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694201168; x=1694805968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGY9pRP4zXPESEDG1xIzcqkXDG7GbyjbuJ87NJ2oFmw=;
        b=pyXJItxXQ9Or7Ds21X/WqtAPPtJyqMggXWR8aKwCPeCbsuvkGXyXNnyYWKT7sg019A
         8fZQTLzNGIaWgy1/35BQizNj1N0UPgcqBMnxBj32xqLGWLfrb3ry1a5I6SgXskDwVJTm
         JAqD9JsFLfJlDAyJuSPHyR5JHkc6dEQEl1fV7Ih/3BYql3Y+X3dM0B1qCa4rs0ckh54w
         PJURCaWaKIXY/tVWJ6cseE9kCBUSyRscVA/KeuwSj3utQN+ZVVOjnisiEJ76113eua3s
         ROL4eoTLXBaJLLP8DTV4gXrF91DOCpPn7ex4nFgj6CKtddnqX6XToBQi14Zk/lpHi6Ri
         CQTw==
X-Gm-Message-State: AOJu0YxpJwp73CHGVjljSprIp8gQbIMd/EBTcXO7zDpLWtznd6kAlSJg
        noHWl3zSuYbqAI5HOI7gbnnek2SHLnINm/g6eqmFSg==
X-Google-Smtp-Source: AGHT+IFymtFXtkG1oXRqy8G1UOHD/VxY7NihXOxf+AMoAFN0WAqlAJd1oLbMHB3fGZlLEJNmh4r4OPrtdjGrC7owa9s=
X-Received: by 2002:a05:651c:1027:b0:2b9:ba02:436c with SMTP id
 w7-20020a05651c102700b002b9ba02436cmr2418559ljm.28.1694201168446; Fri, 08 Sep
 2023 12:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230908175644.2478924-1-sagis@google.com> <d08303a4-321b-419c-5b3b-11f05e4286ae@intel.com>
In-Reply-To: <d08303a4-321b-419c-5b3b-11f05e4286ae@intel.com>
From:   Sagi Shahar <sagis@google.com>
Date:   Fri, 8 Sep 2023 12:25:57 -0700
Message-ID: <CAAhR5DGUjeU=QoQdSXSLqaKiQ6U-Q8+sRQhnijHHtUtHfgh01Q@mail.gmail.com>
Subject: Re: [PATCH] x86/tdx: Allow extended topology CPUID leafs to be
 emulated by hypercall
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Sep 8, 2023 at 11:00=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 9/8/23 10:56, Sagi Shahar wrote:
> > The current TDX module does not handle extended topology leaves
> > explicitly and will generate a #VE but the current #VE handler
> > implementation blindly returns 0 for those CPUID leaves.
> >
> > This currently causes TDX guests to see 0 values when querying the numa
> > topology leading to incorrect numa configurations.
> >
> > This patch fixes this behavior by emulating the extended topology leave=
s
> > using the CPUID hypercall.
>
> ... and thus acquires the data from the untrusted VMM.  Right?
>
> What are the security implications of consuming this untrusted data?

The topology information is mostly used for performance optimizations
on the guest side. I don't see any security implications if VMM passes
incorrect values.
Right now, the guest is already using the returned 0 values and gets
an incorrect numa topology leading to odd behavior in the guest. If we
allow guests to read these values from the untrusted VMM and VMM
spoofs the values, the worst that can happen is a different incorrect
numa topology instead of the incorrect one we already have today.
