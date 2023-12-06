Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504AD8077DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378987AbjLFSpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378962AbjLFSpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:45:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8048D4B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:45:47 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so1336a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701888346; x=1702493146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47YAkdkayM6J9ol4Fq0c4j+8eoetSWIWg4LqcP0jJzg=;
        b=PRJHfTZIczZsZYAn34J6/q3HE7+nI0wRfZVSngzDQQijt8dyIqYZZL/Z6jbZ8H0+pU
         keLGwGyOc2kolqAmjn9b3nYy3PSLA35KwLZjtR+MP0/rSlSvGWe+vZk8a7YLJztQwp61
         Ias+OCUjaLTYJUWJnqnF1zb0R3LrYvPQ/JEvo0YyA4zHSZtYccGfhhIJUqlp3MDhnQKH
         cLu5HDNs/CV18g8HEQKpcXX522lWs+sRAxXeDmcQZGiRi0MBGfB5dIX9akS3g+QGhU1U
         1G/oD1VFmjDEjf3hVt+Wo5jmKBD27Ja1SpR2n+w9ORMRWqUN9JO8YNFfAE79f0eXnV6b
         qLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888346; x=1702493146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47YAkdkayM6J9ol4Fq0c4j+8eoetSWIWg4LqcP0jJzg=;
        b=IyCri8O9s5nddx9jl5zn++IkwX+g2CMm1RpbsdhcWcGUoI9KpMAQjTLAxbhPhXsNou
         fQg20JGf5ojVcok45LslnALCL5cHbOI6vFLu1IPk+ScRUJAmkxhHD9lL5202KrFxrwdH
         MIsF27rxP24voVtd2DzjduDHx3eoX5/0wTC5qoerKgvHVvLgV3tDtbKG9LpYD1mT3sWC
         Z2wrsa+kfT5dKtDsObdzkKBkdEHqDacOfLS12US0SrG+5V1jGPIMpoh9KaxwRpVcT/eV
         cgyh4WxLCz1JuMTi5qE8B2qJ51i9GsjpPh3vPgwGGMw/gyqeG4E3GtkQ2hG5fG1FccHW
         cMRg==
X-Gm-Message-State: AOJu0YwMX4LsGt6gDueb85tgPu7SlgiiDby2gmZAfH98BwUkjDdSRZkC
        0CPsJVWI7EsGdycl+DGwm9e1TeN/J6YJeuqkKoOxoA==
X-Google-Smtp-Source: AGHT+IGZOreuXPIcmrKjukLTpQoCpsI5n2yTrCleugNY8KzuTUesi1Ys8axBY3GggxFOEafw5nNhGSdq9pVMiyinY4Y=
X-Received: by 2002:a50:d0cc:0:b0:54c:9996:7833 with SMTP id
 g12-20020a50d0cc000000b0054c99967833mr104496edf.7.1701888346145; Wed, 06 Dec
 2023 10:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20231128125959.1810039-1-nikunj@amd.com> <20231128125959.1810039-13-nikunj@amd.com>
 <CAAH4kHYL9A4+F0cN1VT1EbaHACFjB6Crbsdzp3hwjz+GuK_CSg@mail.gmail.com> <dbffc58e-e720-42fc-8c8d-44cd3f0281e3@amd.com>
In-Reply-To: <dbffc58e-e720-42fc-8c8d-44cd3f0281e3@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 6 Dec 2023 10:45:31 -0800
Message-ID: <CAAH4kHZVdZtU3MGLTuuxMZyBF1xO=UzpdVhqSE6szCxMLkHFvQ@mail.gmail.com>
Subject: Re: [PATCH v6 12/16] x86/sev: Prevent RDTSC/RDTSCP interception for
 Secure TSC enabled guests
To:     nikunj@amd.com
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, bp@alien8.de,
        mingo@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
        pgonda@google.com, seanjc@google.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +       if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
> >> +               return ES_VMM_ERROR;
> >
> > Is this not a cc_platform_has situation? I don't recall how the
> > conversation shook out for TDX's forcing X86_FEATURE_TSC_RELIABLE
> > versus having a cc_attr_secure_tsc
>
> For SNP, SecureTSC is an opt-in feature. AFAIU, for TDX the feature is
> turned on by default. So SNP guests need to check if the VMM has enabled
> the feature before moving forward with SecureTSC initializations.
>
> The idea was to have some generic name instead of AMD specific SecureTSC
> (cc_attr_secure_tsc), and I had sought comments from Kirill [1]. After
> that discussion I have added a synthetic flag for Secure TSC[2].
>

So with regards to [2], this sev_status flag check should be
cpu_has_feature(X86_FEATURE_SNP_SECURE_TSC)? I'm not sure if that's
available in early boot where this code is used, so if it isn't,
probably that's worth a comment.

-- 
-Dionna Glaze, PhD (she/her)
