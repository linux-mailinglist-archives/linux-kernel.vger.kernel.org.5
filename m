Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4177480E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjHHTZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjHHTZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:25:02 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF15AAFE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:49:09 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so50851cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691520549; x=1692125349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh3g3xzDTV4b/0rT3NYTC0qmjiPKkmxg3PT3HLqCVZY=;
        b=zRZUveJH1KZRH6tYQ1yGZPSChFIbIeV6NT3uvNZujkhvRKwM95maPvj0D1SzvwSNey
         T9uvqSCtb3wHomjfs6OYQxd0fYUXIcih9rr3ab2iQvui60Tv5IBJWUlfdVQPmRe160Hv
         bFt0TYrE1wAnPlywT9LhmIFzigT3OeLia2ZZ0kcnxoUwoMQKwJV77L1wNSAnRe3WjUT1
         OK3rHZYaeGLFzWk6HRg/Po/gOu0eLZeE/vzNQdgECLRNT44O55w1dKrxxZJNNbR/DHce
         zKcbndJFc3/KWf7wejr2EgLLdCA3X8t3pndqs5viKGN+KwrtUQ8MP2FLh3C/HbgZsVl6
         MnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691520549; x=1692125349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zh3g3xzDTV4b/0rT3NYTC0qmjiPKkmxg3PT3HLqCVZY=;
        b=QBBhI5mSKutA055CGvqJ+3mxL+bQ41PIBvAS4BGVekONld7d82OYRUffUy6Hnc0Gop
         kGzCa32IB2GD5c5uGq5pBarAGvJgdMMTUaIUgLUQiX/ZGSYJxU146ocT1YUHXOtTz4Zu
         0lxHwOHtDbGyxEFBCS1z3Tk4m0WPWOaz1L6dn3c2sTaGJl1JUBpDujq19i9NikiHQVCC
         ANtpRlbC1qXJjHJnxSIBAbTZVNomK3GHQNNEI1sOmclUUYqwF6wXCoqFWaEB7XfQqokX
         ojobuVON8R1i+q+WoruFCzz/KmbOr5BQ8w5ILWFjNED3pKho066fzei2tbFRydr1Bky+
         t+TA==
X-Gm-Message-State: AOJu0Yw0xCuotO6GBHzM25tTYheXlDIXUkZ0r+zDSidYuUvK+cmjZA/h
        D40bpwzCffhQ6KLLwJ9LgSCFaMaixRyMcrVqXg4pHg==
X-Google-Smtp-Source: AGHT+IHKG1g9UlJ1hPirgjC7AadcpCjA9ieQnjt5my7ufYVULAUOHLkcnYD66My8bA4sXpCr+wJFuOLoENiUje06R8A=
X-Received: by 2002:a05:622a:106:b0:3fd:ad1b:4e8a with SMTP id
 u6-20020a05622a010600b003fdad1b4e8amr49679qtw.22.1691520548584; Tue, 08 Aug
 2023 11:49:08 -0700 (PDT)
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
 <CAAH4kHamob7g_+BRd0JW76cM7_vS=jzXzRjrgCPDxZ29VnzdCQ@mail.gmail.com> <f95d75c513c081d5bb8b5d1fd3b0a5d5e24ab467.camel@HansenPartnership.com>
In-Reply-To: <f95d75c513c081d5bb8b5d1fd3b0a5d5e24ab467.camel@HansenPartnership.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 8 Aug 2023 11:48:57 -0700
Message-ID: <CAAH4kHYJrKPgWXn7+G_sZXoAs8fq2sDEyT-tyECPthdaaoXyDw@mail.gmail.com>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation reports
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, dhowells@redhat.com,
        Brijesh Singh <brijesh.singh@amd.com>,
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

> Isn't this more runtime attestation?  In which case you wouldn't use
> the boot report.  I assume someone somewhere is hacking the TPM-TLS
> protocol to also do RTMRs, but it strikes me we could just use a vTPM
> and the existing protocols.
>
> Even if you don't do anything as complex as TPM-TLS (and continuing
> runtime attestation), you can still make TLS conditioned on a private
> key released after a successful boot time attestation.  Since the boot
> evidence never changes, there's not much point doing it on each
> connection, so relying on a private key conditioned on boot evidence is
> just as good.
>
> James
>

The TPM quote will need to be bound to the VM instance, so there will
still be a hardware attestation in there that incorporates the user's
challenge.
Anything less than that is subject to replay attacks, no? Am I missing
a clever trick?

-- 
-Dionna Glaze, PhD (she/her)
