Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA806774164
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjHHRTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjHHRS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:18:56 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454F48CA8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:07:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-407db3e9669so288521cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691510863; x=1692115663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8KJ5t+CiuSqsFYkiJ2Ez3PlStQR/yi3Jik6zirchtNg=;
        b=3rruu8VuQ6sEnx24V6i4EeBKQXuAYJ3UJoVV/TwptPF1nnHVWsrENT6C/rgoUsFLpE
         u2ZH6Mm2HudmF4Tq+4yZJMk2KulpkkZh60w6a+vnXK4a1OYH4JSUo2PdGAxHIrbuHrOM
         FCL1WDxv2EL9XJPzMm0P4NU77fqKLaU6dWV+qvWA3MSmdC4/XAPy86kEj3PV1pntJle2
         BCcQWfjCyWxvFx+H9XOnpKQeGwMIm409WshtOtmW5iWsWxkCSH/wS39fwcjRsbcE03NF
         zdZFukacIMYWAolIqT5GLdX8hyytJeXHnAiJgJ43z+vbPgvMGz5v0BXHYxMeXUnBpcfw
         OJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510863; x=1692115663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KJ5t+CiuSqsFYkiJ2Ez3PlStQR/yi3Jik6zirchtNg=;
        b=G1INspTI3dkJg8IuSq8Mh3vU7JnNf7RNUR7L81DT5pkhmergn4nmwvKXQfynJlyKjC
         fiQxmsknRYelLQgOu2Zcj2YiMTNQNPNMg/13+GJ0UqvSImIEHf6sP20xkZqrON382THw
         80gwW8VZQYCCORBqwLZh+6WnXlX9rjMBhL+u32o33vmof5APO8OAzsSGO34AzuhTn1ps
         SDnui0RaABq6aVkgQCJZEZx9PfA7XA1O7Kng3zwv9i3TWYX6chuxhP4dZh+Yy8oH3lFx
         4TGmfq6PEI3Jv82KF8zlsgkYawiNlZm1w7xtdtDjkZ21CSWQsMgZAfMtANwYrqL8RTjJ
         sw9w==
X-Gm-Message-State: AOJu0Yyt/I4esIdMVRMic+50sxGQ3PqpLwIZkUjY7+j4L1ZPG1sPOZCF
        V3WwkaK/+B8pYegUqIr7nJOBL2C35noEaT5F9kJimlSi0SHF0O+CKIw=
X-Google-Smtp-Source: AGHT+IHt6voO9BYVJcWdEkniRLCcqBRLef735ePpp1tfW1zNahlgGDA7vGpo612clikAIgeIZaaP9JI5rM3a1iauBbg=
X-Received: by 2002:ac8:5b08:0:b0:403:b1d0:2f0a with SMTP id
 m8-20020ac85b08000000b00403b1d02f0amr746939qtw.28.1691510863628; Tue, 08 Aug
 2023 09:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
 <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
 <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
 <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
 <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
 <2425e00b-defb-c12b-03e5-c3d23b30be01@linux.intel.com> <64d263e44e401_2138e29486@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64d263e44e401_2138e29486@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 8 Aug 2023 09:07:32 -0700
Message-ID: <CAAH4kHamob7g_+BRd0JW76cM7_vS=jzXzRjrgCPDxZ29VnzdCQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation reports
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        dhowells@redhat.com, Brijesh Singh <brijesh.singh@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
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

>
> At least that was not the level of concurrency I was worried about. The
> sysfs approach makes it so that concurrency problem of option-writing vs
> report-reading is pushed to userspace.
>

The reason I would advocate against making attestation report
collection single-threaded in user space at a machine level is that
there are new schemes of attested connections that may become the
basis of server handshakes. I think folks are mainly looking at this
from the use case of

1. workload will do large amounts of work on behalf of the VM owner,
provided it gets a sealing key released by the VM owner once on boot
after proving its code identity

however I'm thinking of the case of a more user-centric use case that
enables service users to challenge for proof of workload identity

2. workload is a server that accepts incoming connections that include
a hardware attestation challenge. It generates an attestation report
that includes the challenge as part of the connection handshake

This posits the existence of such an advanced user, but high security
applications also have users with high expectations. I want the option
to be open to empower more users to have access to provable workload
provenance, not just the VM owners that are unlocking resources.

> For example, take the following script:
>
> $ cat -n get_report
>      1  #!/bin/bash
>      2  tsm=/sys/class/tsm/tsm0
>      3  echo $1 > ${tsm}/privlevel
>      4  echo $2 > ${tsm}/format
>      5  echo "hex encoded attestation report for: $(cat ${tsm}/provider)"
>      6  xxd -p -c 0 -r ${tsm}/report
>
> The kernel handles the concurrency of line 6 where it synchronizes
> against new writes to the options for the duration of emitting a
> coherent report. However, if you do:
>
> $ get_report 2 extended > reportA & get_report 0 default > reportB
>
> ...there is race between those invocations to set the options and read
> the report.
>
> So to solve that concurrency problem userspace needs to be well behaved
> and only have one thread at a time configuring the options and reading
> out the report before the next agent is allowed to proceed. There are
> several ways to do that, but the kernel only guarantees that the state
> of the options is snapshotted for the duration of 6.



-- 
-Dionna Glaze, PhD (she/her)
