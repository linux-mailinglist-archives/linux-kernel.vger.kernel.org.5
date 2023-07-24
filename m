Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA36975F9D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGXO0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjGXO0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:26:31 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D617DE59
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:26:29 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bba5563cd6so4247505ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690208789; x=1690813589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mL4/hlRXZM4j4GENS2ROMNedOywN4Y40WobkLyw1U40=;
        b=0JZayPTGquYMXgHedz2hVa/hjidK4VJ6suGY6Orxvr2MZMl6Nut3abBRV+HiLbzZRo
         F+nvPbzsjDa9VR+zsMB4l7U2NAtdY1VdejY5y0bunyXVFRDhZ9M89dR/8Z+j2vg6mMkZ
         WEU+ig754rCd8A4KzB8m4nWMV6egaYovtCF1oQFqBTrppB0xdGi3xRjdXn2LTT0+mRsw
         0v04VoXaAVEtAd5Rrj1mACnYuMS3Oy0p0OmUVW5o/GsRV3hqAvICaaTChRYImZ+0jZGW
         1+FpiAlKB1e2nIgLaNPm55MdM+vwxadyWPX2OqMmSaSvoYNrLfMRPdDDefvL9Y4OFxkw
         CgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690208789; x=1690813589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mL4/hlRXZM4j4GENS2ROMNedOywN4Y40WobkLyw1U40=;
        b=Q0ze/2Vd842ii4gOjL07cisrefTFHPk4D9pPLWaPPG/2XhYCHNNVVZi0/JbTgABeUo
         A0w88T/Mq2/IgWp/SzKDzow3gf2e73sWnk2x0NWRWSop3VVRusNgPMQs1nLw6ZbMHBsZ
         B+1faKNlASRkwVFHo8PyTL3B75yKjpEaEhGWH6R2+Bgz261M66mYMgL+DM5gHBxg3F6O
         pcSgrAj4/YHMLqNGoAF19sO5fU3Qhp1mKfWhSNjoAP/tg+v5jlsthsIeZeTDFjgFf9Jq
         Objl3CsQSvNseCSrV+JPbsCyko6s/LGJEEdOHXejbdxAvRCpwbTqAZSEZBeLUzgT/Fk2
         vdwA==
X-Gm-Message-State: ABy/qLa38wOYtDGvz4qk7j+oHvogAySwXsFk6JOwN5YUYzI3CVhjHqvN
        vszEiHPgHZ0pDsoEpArWz0/PrMU4AS0=
X-Google-Smtp-Source: APBJJlGryf2vqymIr3GilpOteVj9nZVBQ61sKgZ8mitLyBvY9O1huvzRXP3Q3flSBlN7RxvTIfN7YBgCWW8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2305:b0:1b7:edcd:8dcf with SMTP id
 d5-20020a170903230500b001b7edcd8dcfmr42791plh.4.1690208789053; Mon, 24 Jul
 2023 07:26:29 -0700 (PDT)
Date:   Mon, 24 Jul 2023 07:26:27 -0700
In-Reply-To: <296c5c68-d03b-65bd-bfb6-41e6046ed389@intel.com>
Mime-Version: 1.0
References: <20230721030352.72414-1-weijiang.yang@intel.com>
 <20230721030352.72414-12-weijiang.yang@intel.com> <ZL5AwOBYN1JV7I4W@chao-email>
 <296c5c68-d03b-65bd-bfb6-41e6046ed389@intel.com>
Message-ID: <ZL6KE5elqCBVIbv7@google.com>
Subject: Re: [PATCH v4 11/20] KVM:x86: Save and reload GUEST_SSP to/from SMRAM
From:   Sean Christopherson <seanjc@google.com>
To:     Weijiang Yang <weijiang.yang@intel.com>
Cc:     Chao Gao <chao.gao@intel.com>, pbonzini@redhat.com,
        peterz@infradead.org, john.allen@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
        binbin.wu@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023, Weijiang Yang wrote:
> 
> On 7/24/2023 5:13 PM, Chao Gao wrote:
> > On Thu, Jul 20, 2023 at 11:03:43PM -0400, Yang Weijiang wrote:
> > > Save GUEST_SSP to SMRAM on SMI and reload it on RSM.
> > > KVM emulates architectural behavior when guest enters/leaves SMM
> > > mode, i.e., save registers to SMRAM at the entry of SMM and reload
> > > them at the exit of SMM. Per SDM, GUEST_SSP is defined as one of
> > To me, GUEST_SSP is confusing here. From QEMU's perspective, it reads/writes
> > the SSP register. People may confuse it with the GUEST_SSP in nVMCS field.
> > I prefer to rename it to MSR_KVM_SSP.
> 
> Hmm, looks a bit, I'll change it, thanks!

Please just say "SSP".  The SMRAM field has nothing to do with KVM's synthetic MSR.
