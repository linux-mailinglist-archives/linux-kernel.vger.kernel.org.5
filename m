Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA3C7B6333
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjJCIHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjJCIHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:07:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AC2A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:07:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so97161466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696320426; x=1696925226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38ynsIBEheGs4gkWED1zWaxYk58O5vbdb4lzANCtwlo=;
        b=ifrBb2sfotnAMObTgAB0HAKhuMK23ivbvqHICZmT6I6YpmXLTgK5kayZzvx1ynFb1u
         +Ue8gpgHSlomsRvJmeFE31i/+3MVxUEf0KBhB9WcIa7nSe7Iog6Qhh6IsmeSbXzV1Gwq
         rXkqJuIkFdTsd8qLZnQlVonKTum3hNCbzpOVVPIA1CeaTYqyXGfPfYKwQxLx2Hi0cydo
         +FJqNuWNlklInMkCgyYSe+CDH23UGP7E769rZdtRWF5EEl2gZ0zNMO/uXBrXfFs6ExvW
         BV3drCxwhq/AtG86WKdnidItntzkR/MRTDciwyNQC3UtGYwqoI1jNsDBnDw6DBNNnSqG
         cR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696320426; x=1696925226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38ynsIBEheGs4gkWED1zWaxYk58O5vbdb4lzANCtwlo=;
        b=vFDwa8wvokTWQ5m4YvQ3NwR2mc5z7QZwD2dFGUWFDwx8KthT4A0uvhQczdM0xQv7Qc
         IJZUwkNw8iFXtuLGmG/29NevPtYETzgFqIOAOMtkyT6KFPXXl8sAl80Txpg2677jNDuZ
         iclOFUzfLAgL6xYdsbzZtUFYmLnW12cNUygH2FDXLvAvO9Q+P89MQIGRzom6UaM9eSyo
         v3+F/+6ihVsSq3SwCN7W+Rz9FRFJNjS4MU9bF2lmmUrL22t0jwoFruWBWhpqpoRmJltE
         TA7dskGQIdMvTuA4Q24wtgBxMy+nsSw05SAmi0V8oK/OQUFxsx5B5gPyVUysDtridiML
         RF9Q==
X-Gm-Message-State: AOJu0Yz4N2rwks43Bvd9eLhiO/uqvrecdkXzxTBmf4f4Q1j8uBNEPBc/
        MfAkbGN5jFR8fhV8MueX2iBD2ZwG8xM=
X-Google-Smtp-Source: AGHT+IGbykwwZqUQJkPGya1T+8PCVDIXtm9QsUR860RS9VD80s2nOqO0JzCd1PTKjN57053XTaTnnw==
X-Received: by 2002:a17:906:3098:b0:9ae:7088:6e5d with SMTP id 24-20020a170906309800b009ae70886e5dmr13208920ejv.3.1696320426326;
        Tue, 03 Oct 2023 01:07:06 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id dt26-20020a170906b79a00b0099290e2c163sm621475ejb.204.2023.10.03.01.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:07:05 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 10:07:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH kernel v3] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Message-ID: <ZRvLp11IJqvTiOst@gmail.com>
References: <20231003073123.1763564-1-aik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003073123.1763564-1-aik@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Kardashevskiy <aik@amd.com> wrote:

> For certain intercepts an SNP guest uses the GHCB protocol to talk to
> the hypervisor from the #VC handler. The protocol requires a shared page so

s/requires a shared page so there is
 /requires a shared page, so there is

> there is one per vCPU. In case NMI arrives in a middle of #VC or the NMI
> handler triggers a #VC, there is another "backup" GHCB page which stores
> the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
> The vc_raw_handle_exception() handler manages main and backup GHCB pages
> via __sev_get_ghcb/__sev_put_ghcb.
> 
> This works fine for #VC and occasional NMIs but not so fine when the #VC
> handler causes intercept + another #VC. If NMI arrives during
> the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
> The problem place is the #VC CPUID handler which reads an MSR which
> triggers another #VC and if "perf" was running, panic happens:
> 
> Kernel panic - not syncing: Unable to handle #VC exception! GHCB and Backup GHCB are already in use
> 
> Add a helper similar to native_read_msr_safe() for making a direct hypercall
> in the SEV-ES environment. Use the new helper instead of the raw "rdmsr" to

s/"rdmsr"
 /RDMSR

> avoid the extra #VC event.
> 
> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>

LGTM.

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
