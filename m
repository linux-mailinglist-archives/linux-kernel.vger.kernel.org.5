Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E5377441F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjHHSP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjHHSPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:15:00 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E25783F2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:21:15 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40a47e8e38dso12451cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515274; x=1692120074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8m2sz5ofN14PKsEKJrI2xSIa/NZXT9WULPoAZ3lB9qU=;
        b=1Ql1zomo7OT8mGm5eChBkB3BZsSmWdImOFmc9ivT6OASGC4elHfNZT3MndUBI+nD6q
         iu0lKSXUksnT8Ans0Eiw3RcVgSQUWwmNdl844CEIeUCuzeB4YDxFc8VdNqYo/b+Wcfzu
         t/MgA82AaWHxqR+4xfSMV4gncrNUp5ly3z3U+zF2M/NmQ6OgFPUIhE+RVFj1IUgH2YLM
         7EvFVhfwtom+Ns8I9NCbljv+LJv7a0WtYrX0Eeruo4czP4e4A0FDf7agjl9uJzspk36y
         EUFYn5Aq6R4bw+mQkKvC2Lrklx4XmHbCUoBUbm8i8wNhv7Eam8RLedpMXJPu5o9LaadL
         FrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515274; x=1692120074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8m2sz5ofN14PKsEKJrI2xSIa/NZXT9WULPoAZ3lB9qU=;
        b=irzWSb/Wnfj6rCM3AlRn4UfnHeQSzandtoYBkxoinzyAKpxmzNmZ3Jcfiudw8BEfa4
         xKY3bQ/+o+GIOpNc//FjDuTPNiNvDK0xxm0COVg3i9WVEzXgrEO2A7iYzla8mZ8ZRMbc
         U15U84nYxB0Jnw/MeYMlxgV7nGJWm6vfGYypA/IJK1ytjCuqNQ6F3XseXjwDaUqkuWHF
         KGBv6mN/lQQuG+f5fAUwrD/YHjNyFiUgxpn0y9quqYXIyu86T9US+KD5feEBtuN0Iizt
         5lEbm0er6FDaT3fkFN+I1owa2xDZwpx7WuTTtWCUZn2vIj5H9HYH5oIEEgjnjqllZ3qB
         B2vg==
X-Gm-Message-State: AOJu0Yz4fPO7EpAh1phIm6KpkT+bXZDqyuWq047nwU00H8sCOou1TokI
        /UEshPTLk1qKq/jP6Zc7aePEg0lzTzT5NvTklVlowA==
X-Google-Smtp-Source: AGHT+IFageD8Xz1u57GixYSKm20N8XHO6KbVXPJLL1PT98Mt37GF0ywxR1gnVgeRo2hCqp53F3eJr8SMw+iQeUoSS4k=
X-Received: by 2002:ac8:5850:0:b0:403:a43d:bd7d with SMTP id
 h16-20020ac85850000000b00403a43dbd7dmr15772qth.4.1691515274187; Tue, 08 Aug
 2023 10:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
 <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
 <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
 <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
 <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
 <2425e00b-defb-c12b-03e5-c3d23b30be01@linux.intel.com> <64d263e44e401_2138e29486@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHamob7g_+BRd0JW76cM7_vS=jzXzRjrgCPDxZ29VnzdCQ@mail.gmail.com> <64d270a2a68ce_5ea6e294f0@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64d270a2a68ce_5ea6e294f0@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 8 Aug 2023 10:21:02 -0700
Message-ID: <CAAH4kHYht5s4CkS5Y9+VotPH4WqDrzng0vYy89oq0_U16H_dDA@mail.gmail.com>
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
> I do not see sysfs precluding a use case like that. If the kernel can
> call out to userspace for TLS connection setup [1], then advanced user
> can call out to a daemon for workload provenance setup. Recall that TDX
> will round trip through the quoting enclave for these reports and,
> without measuring, that seems to have the potential to dominate the
> setup time vs the communication to ask a daemon to convey a report.
>

It's rather hard to get new daemons approved for container
distributions since they end up as resource hogs.
I really don't think it's appropriate to delegate to a daemon to
single-thread use of a kernel interface when the interface could
provide functional semantics to begin with.

> [1]: https://lore.kernel.org/all/168174169259.9520.1911007910797225963.stgit@91.116.238.104.host.secureserver.net/



-- 
-Dionna Glaze, PhD (she/her)
