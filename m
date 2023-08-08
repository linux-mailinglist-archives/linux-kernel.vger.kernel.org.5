Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D525774E44
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjHHWd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjHHWd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:33:56 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E01FE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:33:55 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40c72caec5cso62951cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691534035; x=1692138835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/tES5rAsQhPvTCs9h8UWgD+l8tw6HXSBo83JhiuAeKM=;
        b=182OnsU2RltnldUtbZ/AOU5d9Y8aCkgpvTMT9ZFaWfnPkHr4K+p4gY+ZFhNMOoRwit
         0B/hSaJu13DG5y0JvLhTEs4+wAI8Ugihb4ScVmpT9wfXiQivzvlE4cPqIq1wfMNnKeyE
         PCe/tc4BVC8JTO6L0JbWfqvuCYd9TCi2PgFsQh1t0C/w93cuNd0WYpCTWTHFvWvR7kMV
         lyEXuJLzP5cMqxoWIv9OyOw5qAO5DdGND/cagx+wgJrvpsjO0XJPWUKQHW4zfj8kOoFA
         2E2F0pW4BN1pzHXr66+VUrK1m8OOE5tX7CTluoFYVkBo75cNg1kcxIIGvapqDSL8Nlbb
         MdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534035; x=1692138835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tES5rAsQhPvTCs9h8UWgD+l8tw6HXSBo83JhiuAeKM=;
        b=PvTa8XRywrhVi264nEb1gbR4S31zUd0HcN5TwOhpa9XYUTJxmbZfxL5F54actvkMJm
         QsdYafdIBE7SnRn1x8w2D+XhmnPrdluLO+PuZGudhGQL7vWEcZJhuqDXKG4/hhTUVaxn
         pdzZ7FpjwOcxBcaJ9zN4Vu0P1+H4JzzKb1Tb+XzADPvNw23mHeUJbj8D785Q/3uCNRsp
         E8s19cYXgK9nUVN6XCzAXdYkM5SDYresRLdjpjt/y1xZmlHtgPsjfnIN0R5V1Wau5d0O
         XaAtZA/LhPIycbFCqW5ny8Gq3lRavQDaQH9RNGI2B8NgkwgEnHTBfFtUUZd55eZBgZNU
         Qb7A==
X-Gm-Message-State: AOJu0Yzj8r+pLIAZKkvwRPXlnppxuigVZhY+7TSToGwcI+ubmB130/N2
        6+fMTkdbojh2o+OjjE7+hkVK+N5hIxJGwzcrfFdmGQ==
X-Google-Smtp-Source: AGHT+IGSvGPi6HYr/AfpIovb5Kh34w9cWI89wQo+sov7hzkFL74EanlnAbVTK5vP3DM2D3H+imknBwgB5O3xVJAVaO4=
X-Received: by 2002:ac8:7d88:0:b0:403:58e8:2d96 with SMTP id
 c8-20020ac87d88000000b0040358e82d96mr46734qtd.7.1691534034915; Tue, 08 Aug
 2023 15:33:54 -0700 (PDT)
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
 <CAAH4kHYJrKPgWXn7+G_sZXoAs8fq2sDEyT-tyECPthdaaoXyDw@mail.gmail.com>
 <9c9c62f9243595a1faa3b0745fa8a1f8f018d9b8.camel@HansenPartnership.com>
 <CAAH4kHYLPP5ehLBDkXxJQmnuFTjjRp+1tON5T9HqSxCvD1mSxA@mail.gmail.com> <3ff1bee6d121ce76fd78217dbe3e5ab2f0134f54.camel@HansenPartnership.com>
In-Reply-To: <3ff1bee6d121ce76fd78217dbe3e5ab2f0134f54.camel@HansenPartnership.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 8 Aug 2023 15:33:43 -0700
Message-ID: <CAAH4kHZcx6Gjy8sPeyshWeKyxR81zXwT6zYMV_uOdfyCsgNLMA@mail.gmail.com>
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

> For an ephemeral TPM, the EK should be guaranteed to be random and
> therefore non repeating, so there's not much need for the nonce to add
> non-repeatability.  So, in theory, the vTPM/EK binding can be published
> once and relied on even for multiple different tenant endpoints, sort
> of like the EK cert for a physical TPM.
>

Okay that sounds reasonable.

Regarding my other comment about daemons, we might already be in that
state for containers even without the sysfs proposal, given that the
sev-guest device requires root.
We'd need a daemon to provide protected access to the attestation
report (e.g., https://github.com/confidential-containers/attestation-agent)
so that's a bit of a sad situation.

-- 
-Dionna Glaze, PhD (she/her)
