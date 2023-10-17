Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DC47CC70E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344205AbjJQPIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjJQPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:08:35 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4262530C2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:08:20 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so9991817a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697555298; x=1698160098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/d3+rTugA3DW8t0EfmzpaNsmaGk1NkaP0v69txt+hAQ=;
        b=LL6FWeeXGDti5JR8H7tRru+w9DEP2dib2ddi09hxA24uD1FmzQIMNruuh9p2XpwP4r
         eqTJtC+KjetIW3j9el6ERD6LhvfuNh5NLiuQcXBHS9KQq/rkxPkU9St+AMWkzyaXqe2Z
         LJt9EUnXYQ9C9hWY3bccfniC8rzpz85jhBN5KQEkc5ac0qOSOYLf3q//ffP4EmPTjPtv
         XsOfaskbfJ5FiE8pwS5SRfwpP/IvowTdJOP/6Q2N23Vayh018CG3v3ZI3jmkxSlZQ/dv
         uf10TqGFlj2rK4tKJCShN6UvPWxxIi+3xi8BloKP4vQty+riIwfWtxbtx37AwofQ5kCn
         0vPQ==
X-Gm-Message-State: AOJu0Yzmjivhi+fNQ4tt3MzsSrO4lR4jTKhWVjrJmpURnq/hTmfFtnAZ
        CedmBztU1GIK+KWAhi7WknE=
X-Google-Smtp-Source: AGHT+IFML+tmmWCHZDWhnmoP83sjK1f5sc09dmwq/SW+393WZWQeD0DGTlJlIQIBPInDOjI2z0OzJQ==
X-Received: by 2002:a50:aad1:0:b0:53b:9948:cc1f with SMTP id r17-20020a50aad1000000b0053b9948cc1fmr1943421edc.12.1697555298414;
        Tue, 17 Oct 2023 08:08:18 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id c16-20020aa7df10000000b0053e0f63ce33sm1331823edy.95.2023.10.17.08.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 08:08:17 -0700 (PDT)
Date:   Tue, 17 Oct 2023 08:08:15 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Borislav Petkov <bp@alien8.de>, mingo@kernel.org,
        jpoimboe@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        gustavold@meta.com
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <ZS6jX9v+QBsKyavE@gmail.com>
References: <20231010103028.4192223-1-leitao@debian.org>
 <20231011044252.42bplzjsam3qsasz@treble>
 <20231011190317.GDZSbxdd5TuCIp5+JN@fat_crate.local>
 <20231011220325.5uje4xnfxuccumm7@treble>
 <20231012072920.GAZSegUJkwHbcernQo@fat_crate.local>
 <ZS0Lfy8LUdRG3ca0@gmail.com>
 <20231016124654.GDZS0wvqJlsf+iVAeu@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016124654.GDZS0wvqJlsf+iVAeu@fat_crate.local>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 02:46:54PM +0200, Borislav Petkov wrote:
> IOW, I don't see the particular reason for having those namespaced. But
> since you and Josh care so much and I don't - not that much :-) - and
> I definitely won't be doing the work, feel free.

Thanks for all the discussion so far.

I am summarizing what I got from this discussion so far, and
starting to get the direction on where we want to be:

0) Each mitigation should have their own Kconfig entry under
SPECULATION_MITIGATIONS.

1) Have "Mitigation" namespace for each mitigation. These are the new
name for the mitigations:
 * MITIGATION_PAGE_TABLE_ISOLATION
 * MITIGATION_RETPOLINE
 * MITIGATION_UNRET_ENTRY
 * MITIGATION_CALL_DEPTH_TRACKING
 * MITIGATION_IBPB_ENTRY
 * MITIGATION_IBRS_ENTRY
 * MITIGATION_SRSO
 * MITIGATION_SLS

2) Split the GDS mitigation in two:
 * MITIGATION_GDS
 * MITIGATION_GDS_FORCE

3) Create new Kconfigs for the following missing mitigations:
 * MITIGATION_MDS
 * MITIGATION_TAA
 * MITIGATION_MMIO_STALE_DATA
 * MITIGATION_L1TF
 * MITIGATION_RETBLEED
 * MITIGATION_SPECTRE_V1
 * MITIGATION_SPECTRE_V2
 * MITIGATION_SRBDS
 * MITIGATION_SSB

4) Do no touch the enum order, instead use the something as the code
below to avoid the #ifdefs in the code:

  static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
        IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;

5) Make sure that there is clear messages when the mitigations are
disabled.  i.e, make sure that the current pr_info() we have today are
called in case the mitigation is disabled.

Am I missing something?
