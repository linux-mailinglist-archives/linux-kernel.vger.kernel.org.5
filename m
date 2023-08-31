Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032AA78F4C6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347594AbjHaVnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHaVnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:43:11 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D446F107
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:43:08 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4036bd4fff1so24521cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693518188; x=1694122988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/mZ1G6WYDoeO3Lvq+RNnrhZA1r2o8U/1/K3H65sBRiw=;
        b=6S7vaNqW0F3u7AJE22QgUT0shSK90QwTZBjFOHQppoZX+phH64Ee71AIuT+NHD/p5C
         DTco9lpiuMc1abLKZk7vbi3O/J4jazKymt3Oazha4WhhgppMKeWZnnK0mMwMYP7M4R/y
         z8NLbhrpdKDP9KxjS+ps+4KjS9/xBy4qo1qVDx1AqkwSGPe2E1uM71Kg+Jg+NM2wIbdI
         MTBNI3mAoeSHCto8z3Dk/0PnkDiG0DRNrj6vso/2n2/DGsqT8DG8FOJzdwVcwDkBD+em
         7cYm/EXdRna7fRQbMvEsVBuO8IX9gjqFZ/MDCMvFuf8fyhEW7XVRiOEMWhBMUOiCNXC7
         E55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693518188; x=1694122988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mZ1G6WYDoeO3Lvq+RNnrhZA1r2o8U/1/K3H65sBRiw=;
        b=NncfaOSWyroftxvSWmfy8STwfexeEtv6plJglT+six3BZm9G/kqe3DDMR7Hl1dsoWC
         tWDozVUT6rZ5Y/jeO1F8dYGULz7V0E3ZTUEtsimVH5Hj3nUoeH8L4NyLKtsON1rE1+ho
         nzZSNEDbvYtKNM9VJ1oYOH0GMU4mcMZuG6WeH97Z9wM9dKuCXaOMoKJgyv7Mc49SB7xU
         A1rOs09zSqLx9Uol7teSSA4YEvtIFL4RtNUb+tlei2JqwIWhOJ1rnI33xzdiIOuhYrio
         oRpkz2yut7p1bDOf08E4WDRAHadDwPgR/7WrvrpLFrWVWysASsy5DxcD2tPhzoZ3nlFM
         BxqQ==
X-Gm-Message-State: AOJu0YyVymwenOWtpswG5jqUDdvuHlpzf9eoWpmRxY07F25hHR79mN3V
        2d9g5XYwzMpZhPe5ftVPeaC3HYp9cPRLHPZjOj2ISA==
X-Google-Smtp-Source: AGHT+IG7pahh3NiOV7dOHK10ykKRvqDUl/wZH0nf2uzIX1qDM/zlw41rANgNx8Ce0oUM7H0PnXyHz7JLZxjyJpTPVqA=
X-Received: by 2002:ac8:7c4d:0:b0:410:a4cb:9045 with SMTP id
 o13-20020ac87c4d000000b00410a4cb9045mr105945qtv.18.1693518187836; Thu, 31 Aug
 2023 14:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342400469.3934343.12316161608372095860.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169342400469.3934343.12316161608372095860.stgit@dwillia2-xfh.jf.intel.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 31 Aug 2023 14:42:56 -0700
Message-ID: <CAAH4kHYNhiewBZ8Z_yF2F+ogkv_1UV8=Gu0KVDdTJN4iQKyNMg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] configfs-tsm: Introduce a shared ABI for
 attestation reports
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
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

This is clean and approachable. Thanks for your implementation.

> +static int try_advance_write_generation(struct tsm_report *report)
> +{
> +       lockdep_assert_held_write(&tsm_rwsem);
> +
> +       /*
> +        * malicious or broken userspace is attempting to wrap read_generation,
> +        * stop accepting updates until current report configuration is read.
> +        */
> +       if (report->write_generation == report->read_generation - 1)
> +               return -EBUSY;
> +       report->write_generation++;
> +       return 0;
> +}
> +

This took me a while to wrap my head around.
The property we want is that when we read outblob, it is the result of
the attribute changes since the last read. If we write to an attribute
2^64 times, we could get write_generation to wrap around to equal
read_generation without actually reading outblob. So we could end up
given a badly cached result when we read outblob? Is that what this is
preventing?

I think I would word this to say,

"Malicious or broken userspace has written enough times for
read_generation == write_generation by modular arithmetic without an
interim read. Stop accepting updates until the current report
configuration is read."

I think that at least in the SEV-SNP case, we can double-check from
userspace that the report has values that we expected to configure the
get_report with, so this isn't really an issue. I'm not sure what the
use is of configuration that doesn't lead to observable (and
checkable) differences, but I suppose this check doesn't hurt.

-- 
-Dionna Glaze, PhD (she/her)
