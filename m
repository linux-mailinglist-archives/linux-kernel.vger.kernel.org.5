Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7707E77E9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345843AbjHPTjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345927AbjHPTi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:38:59 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6AB273C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:38:50 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-407db3e9669so3481cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 12:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692214729; x=1692819529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JNDp3i2bBwoOV1rWtC/ohzjbdWhzdLjzTZ59sTAggCU=;
        b=zauDROUUKvcs8lCQ/BfV9kcQA4HIORrUlzsCcdVtdntWypJgGELZqZcEPLioY0DX1d
         UZTL8VoPIfEhBk0xRjDcyf9AqwQrbV0warNe/Q5irckHL//x2ua7KFrsy9YP53ps8gIr
         Y25/CTQUJBZxNty4Qz8tQDZf36+O091toHhi80CCb7b0XTD8jR2DttEpmTMY19WOJcyO
         X/hU+x6DLfL7tVILoR3oXr77fDuqp4wQ7rgEtiSf+7j/37CGM66AepJOf4st574goUhl
         hcJa09xtf3ESJfDOe4BfolpD04dXesNC+RWoz2KCs0hYYa9GxZoWxlWIbPdJwYStxD+G
         47tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692214729; x=1692819529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNDp3i2bBwoOV1rWtC/ohzjbdWhzdLjzTZ59sTAggCU=;
        b=GeJ4GDERyS1Xw5e/flc4wFYIL1CGi9Rl/JrQ5nllahR1QvgP/XfjOGQEQYx1UWf24N
         chMkw6YWvHcCcxnaduhyl4XiSN6fdz54OAcOcVzzA+6Q60ERsWhMjBxHVrYtrtEUG6JV
         qJToBagXuNDzL2f7WBuJvBmv8f+Qh2nlsUaCMa+fhPVN1Vjhk1tSgiUhBKKpeW5yOjq1
         Nz6KzCW9P/O+K56/m8Zn45ogh+i5o8SE70yzZEcwIMVZnTM2ovcESvkoCAnvtCl4h848
         t6p9kD17/qHl+QARCaRy9NsSg3TUvdn9HJMM3QATu5pQgj1ikLBUcNlUWY+GL0sOJGvB
         FGiw==
X-Gm-Message-State: AOJu0YyX1Mw5sE/9m3TPNWBl/U/2V+l1hO9gJtIJ4YNa7WCBWnn2QAVw
        rWD71KHVwBfaVDVtZkXZYuXWt+xlXGIstl/Le1gBxw==
X-Google-Smtp-Source: AGHT+IFpIaCPqotOsX3UISM7uhBPq1XQaPa+MtAyjklx4cxfSxVons1e1QLTn7tMSjl7u9VZ5PpbIJ+PhOxSqkDX0oM=
X-Received: by 2002:ac8:5e48:0:b0:403:a43d:be41 with SMTP id
 i8-20020ac85e48000000b00403a43dbe41mr53686qtx.20.1692214729529; Wed, 16 Aug
 2023 12:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900677.1782217.12516417657696965559.stgit@dwillia2-xfh.jf.intel.com>
 <CAAH4kHbRkFdmdQyPHjOjnnyuYXPLT2GKmQTE8fU9aDFMtri8ew@mail.gmail.com>
 <64dab7a322eef_2138e29421@dwillia2-xfh.jf.intel.com.notmuch>
 <ed962dc3-1e7e-8959-7921-365fae705594@amd.com> <64dbe8079511b_47b57294de@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <64dbe8079511b_47b57294de@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 16 Aug 2023 12:38:38 -0700
Message-ID: <CAAH4kHaM_hUPNFLpg-2unnBFL5b_ZYrrj=ZuYub9kR_CxVkqdQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] virt: sevguest: Prep for kernel internal {get, get_ext}_report()
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, linux-coco@lists.linux.dev,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
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

> Definitely, instead it was this comment from James that gave me pause:
>
> "To get a bit off topic, I'm not sure derived keys are much use.  The
> problem is in SNP that by the time the PSP does the derivation, the key
> is both tied to the physical system and derived from a measurement too
> general to differentiate between VM images (so one VM could read
> another VMs stored secrets)."
>

Key derivation on AMD SEV-SNP is not necessarily tied to a physical
system with the introduction of VLEK-based attestation. It's now tied
to a CSP's fleet of machines. We can use key derivation in the SVSM as
a basis for further key derivation based on measurement registers, so
the utility increases to provide something like persisted sealed data
that can only be unsealed when the SVSM witnesses a particular runtime
measurement configuration.
We can use NIST 800-90A Rev. 1 for combining keys from the PSP with
measurement register values for example.

> http://lore.kernel.org/r/c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com




--
-Dionna Glaze, PhD (she/her)
