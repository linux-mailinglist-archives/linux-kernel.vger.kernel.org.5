Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351A47EDB3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjKPFbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPFbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:31:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C63118D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:31:49 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so4466a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700112708; x=1700717508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4diCtTL3EivIaKd6Yrty+RIJmvtzTDLTo/nXfRxccPk=;
        b=BAzyXnv9LHq75tPsgaJ3pvn5mvOcfTOaw7Vxzv3Qt6TKXfJpYHxBx4zOnXKgwzHvcv
         zUl050HjJz6yvJutrQKLq4GwbGhIW+aClp0w7e8KVZLYXTJH3SojZ/SMtr0iyzaKEWFO
         Pofb0gId5uugehW8XAIJRbwsaH8FjJfUCzd/Z/Ynnrr1dB89+UBAft7F/ok6BKSEEULf
         VMG/2Ripc/9ofcfxkoBOFwT1UvSDgtrfoVikztw1oXMTzyshUZKNPBqR+mfttu7f0lYe
         LiGX6nI+2f96Jh1HZWA7OiDEcQaD05hLvUzDRsH59fL7Fuf4vtl0g5FQMK2GHl+W4f53
         0dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700112708; x=1700717508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4diCtTL3EivIaKd6Yrty+RIJmvtzTDLTo/nXfRxccPk=;
        b=XxzjAMqec8oUh7WxR/pf4cO/FlcJBS0fnxsbguK84NdtsUiChYLUm2J2sZPQmIBD4T
         zrxyj8/TRJ1ITurbQjuwNIU6Ez85NbvYNOz1oyJ9RdaTPp7Lnr2GUBrpoggZqMjwhnE7
         n+mi4mhipnlBMmJsF/8CBkFmBvymhJG1pWAgJ6L0BoFx+tdFbLWj7qC6YERiDRknTAvP
         Zg32OrPAJL28Ynwj0BnOKxbYQHtVsjGUaRnOW5YcN2DBTSc7R59Xwh7LMRaxa2+MNE/1
         TQdakR3lwb8qwe/v/IS0QUUDfUK8cfnijUDR2MZCE4vgm39OBv+MbAxPFSQFJdrJIXuh
         XQHQ==
X-Gm-Message-State: AOJu0Yzn+o8cwbJXzyMWFU5pTaO98WBpwIQWF5PZIb5bu32lE8lRPV+X
        unjCS5rk6nPtCSNI7CI3aQGBjRuBy3IfujrgvMt+tg==
X-Google-Smtp-Source: AGHT+IGOHarkPwgABVlEMIKneg9bFJeC/Sizgt1g86eNBkXhc6lGj6UX9Rcz+JOCTeiCxNp2DrA60v/aOwz4dSqmSxY=
X-Received: by 2002:a05:6402:1bcb:b0:547:3f1:84e0 with SMTP id
 ch11-20020a0564021bcb00b0054703f184e0mr60685edb.7.1700112707847; Wed, 15 Nov
 2023 21:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20231016132819.1002933-1-michael.roth@amd.com>
 <20231016132819.1002933-49-michael.roth@amd.com> <CAAH4kHb=hNH88poYw-fj+ewYgt8F-hseZcRuLDdvbgpSQ5FDZQ@mail.gmail.com>
 <ZS614OSoritrE1d2@google.com> <b9da2fed-b527-4242-a588-7fc3ee6c9070@amd.com>
 <ZS_iS4UOgBbssp7Z@google.com> <20231110220756.7hhiy36jc6jiu7nm@amd.com> <ZU6zGgvfhga0Oiob@google.com>
In-Reply-To: <ZU6zGgvfhga0Oiob@google.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 15 Nov 2023 21:31:34 -0800
Message-ID: <CAAH4kHYPAiS+_KKhb1=8q=OkS+XBsES8J3K_acJ_5YcNZPi=kA@mail.gmail.com>
Subject: Re: [PATCH v10 48/50] KVM: SEV: Provide support for SNP_GUEST_REQUEST
 NAE event
To:     Sean Christopherson <seanjc@google.com>
Cc:     Michael Roth <michael.roth@amd.com>,
        Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, pbonzini@redhat.com, vkuznets@redhat.com,
        jmattson@google.com, luto@kernel.org, dave.hansen@linux.intel.com,
        slp@redhat.com, pgonda@google.com, peterz@infradead.org,
        srinivas.pandruvada@linux.intel.com, rientjes@google.com,
        dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de,
        vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        alpergun@google.com, jarkko@kernel.org, ashish.kalra@amd.com,
        nikunj.dadhania@amd.com, pankaj.gupta@amd.com,
        liam.merwick@oracle.com, zhi.a.wang@intel.com,
        Brijesh Singh <brijesh.singh@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > So we're sort of complicating the more common case to support a more niche
> > one (as far as userspace is concerned anyway; as far as kernel goes, your
> > approach is certainly simplest :)).
> >
> > Instead, maybe a compromise is warranted so the requirements on userspace
> > side are less complicated for a more basic deployment:
> >
> >   1) If /dev/sev is used to set a global certificate, then that will be
> >      used unconditionally by KVM, protected by simple dumb mutex during
> >      usage/update.
> >   2) If /dev/sev is not used to set the global certificate is the value
> >      is NULL, we assume userspace wants full responsibility for managing
> >      certificates and exit to userspace to request the certs in the manner
> >      you suggested.
> >
> > Sean, Dionna, would this cover your concerns and address the certificate
> > update use-case?
>
> Honestly, no.  I see zero reason for the kernel to be involved.  IIUC, there's no
> privileged operations that require kernel intervention, which means that shoving
> a global cert into /dev/sev is using the CCP driver as middleman.  Just use a
> userspace daemon.  I have a very hard time believing that passing around large-ish
> blobs of data in userspace isn't already a solved problem.

ping sathyanarayanan.kuppuswamy@linux.intel.com and +Dan Williams

I think for a uniform experience for all coco technologies, we need
someone from Intel to weigh in on supporting auxblob through a similar
vmexit. Whereas the quoting enclave gets its PCK cert installed by the
host, something like the firmware's SBOM [1] could be delivered in
auxblob. The proposal to embed the compressed SBOM binary in a coff
section of the UEFI doesn't get it communicated to user space, so this
is a good place to get that info about the expected TDMR in. The SBOM
proposal itself would need additional modeling in the coRIM profile to
have extra coco-specific measurements or we need to find some other
method of getting this info bundled with the attestation report.

My own plan for SEV-SNP was to have a bespoke signed measurement of
the UEFI in the GUID table, but that doesn't extend to TDX. If we're
looking more at an industry alignment on coRIM for SBOM formats (yes
please), then it'd be great to start getting that kind of info plumbed
to the user in a uniform way that doesn't have to rely on servers
providing the endorsements.

[1] https://uefi.org/blog/firmware-sbom-proposal



-- 
-Dionna Glaze, PhD (she/her)
