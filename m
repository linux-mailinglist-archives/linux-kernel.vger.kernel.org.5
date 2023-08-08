Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FE1774AE3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbjHHUhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjHHUhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:37:20 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686437EFD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:05:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40a47e8e38dso11791cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 13:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691525104; x=1692129904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A3Gse/n1KcESVWhM7B7IDywbevkkJ8BX6XkqzvAh2wo=;
        b=h8CiTiA6oKfcPqnb/eqNMeSqNLiCOaqNFez8+Yi+QiIgsfxaNoRzSX2cNlNFaBDTTe
         tzcRf8KweTwO0zkVmd/rgBAGEbu2QxslkUsoI3YKuQ6IqWcdhjcM1Ij9vyiToE4x9VfT
         WjgWRuvhRH5cmPucD+OlPbphWq27dCD4iHPYn024y85zR35FKQiCWbu4mc6zz3AJ9a57
         qIS7cMPDA3DxGRdBE7eeNwlJDeMPV1+k7IIiAM8cUuXFEjbsC8SWoJtzt8wYoBrUtmdg
         fVXf0+JpGrdKfe+NYxVBSFh8EjYp3eF+uYe+9nkdPwAYuwg7YXNlCBbEFxeZzAlmkBSQ
         l5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691525104; x=1692129904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3Gse/n1KcESVWhM7B7IDywbevkkJ8BX6XkqzvAh2wo=;
        b=YkTZEMObtUT8l7gXosNJvzANQWqJb80/PDJVScheBK01hZvZpFfBe7l30UrzhLG14n
         Vj/0e9TIDza8tCVoh1x3jGBSuXkvK7Sbyo3IdOP3NOL4mJgeWcG16tqppHPUjB3mBZvT
         3wff5UJEZGMRho7f3CTuDe+wJ72BSm25OQbyrLgIFfcuDtyLfr3KnM1tpAlLOsH0zAkP
         xyWllYioVbEUX5tLC0uj4DjbzeJz81IasI3FjFrAq/8AqF75FE+XQF0zngV6pFZsE1fw
         voy+PGDrDFMiVt/O9V6pxYSpVjuzIaqHzKYqD0MaIhUW2T1J314lviBMNozMMksPUK2C
         vjYg==
X-Gm-Message-State: AOJu0YznLMnGHBUWi2y2MnQ1fQITMdDNzeOCQkmfWMUcaHGOG0T3VbYB
        ae97S5plAdzV9D+thPnBie38XPB9jvyopNXinobbvA==
X-Google-Smtp-Source: AGHT+IGNBE6dFnyFADf1Zm7XSPB1CUPxxwK5Lk++7K/zWHyetI7bdc4dFgm5ZygS1qde1KTXi7lUYgHUEzLhJ2FPsoE=
X-Received: by 2002:ac8:5b85:0:b0:40f:d387:65d0 with SMTP id
 a5-20020ac85b85000000b0040fd38765d0mr82670qta.16.1691525104516; Tue, 08 Aug
 2023 13:05:04 -0700 (PDT)
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
 <CAAH4kHamob7g_+BRd0JW76cM7_vS=jzXzRjrgCPDxZ29VnzdCQ@mail.gmail.com>
 <f95d75c513c081d5bb8b5d1fd3b0a5d5e24ab467.camel@HansenPartnership.com>
 <CAAH4kHYJrKPgWXn7+G_sZXoAs8fq2sDEyT-tyECPthdaaoXyDw@mail.gmail.com> <9c9c62f9243595a1faa3b0745fa8a1f8f018d9b8.camel@HansenPartnership.com>
In-Reply-To: <9c9c62f9243595a1faa3b0745fa8a1f8f018d9b8.camel@HansenPartnership.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 8 Aug 2023 13:04:53 -0700
Message-ID: <CAAH4kHYLPP5ehLBDkXxJQmnuFTjjRp+1tON5T9HqSxCvD1mSxA@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Trusting the vTPM is a one time thing.  Once trust in the TPM is
> established, you don't need to be worried about replay and you can just
> use standard TPM primitives for everything onward, even when doing
> point in time runtime attestation.
>

It's a one time thing for who? It seems like you're still only looking
at the 1. use case and not the 2. use case. Every different person
establishing a connection with the service will need to independently
establish trust in the TPM.


-- 
-Dionna Glaze, PhD (she/her)
