Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2D9751A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjGMH4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjGMH42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:56:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812226A3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:56:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so739595e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689234967; x=1689839767;
        h=cc:to:subject:message-id:date:from:sender:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aWc1kwBXlooW52GInseesObOXCmA4do/WYm4jVF0oTk=;
        b=bK4trt4UL+dxunXDoQNJl8B3ONBnUGkfUVcPUnObBOSvbL98iRsHLOxU+2S3HfTmJ0
         kl0uAZNnG2l7Qa6nlqhRBWsWNaLM+JW6lMrEbl9Bo1+5T5BEQ4G5Nqw8SVF0Sa71PGTK
         sSn0JDdS2PWX8qQT8KzTwXKyTNJXJsw8xVOQcjAmI3NyhpkdcmUhJZLiRBhku5pqfVuC
         l90r6lLvgOLSrYEQk9yHpjb8ZpBfbrIaCyCHS1O1wjKOu6sE6S1JCwMRaZE0EQMXB/q4
         qlIqTiHx56NaD1dxmmia3d94FY5o9gRf3zGwAMxkehD5dDtlIHXXHao4t+6kW5TQBnmX
         4SKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689234967; x=1689839767;
        h=cc:to:subject:message-id:date:from:sender:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWc1kwBXlooW52GInseesObOXCmA4do/WYm4jVF0oTk=;
        b=kNFZ3a4ijdg8CLekkjoo+wqlxv5OrEAw1MMmHtYmi45uWnQ68OM5BEBshOJU9pyk6b
         rK2ivRfeAkOA8nZngcI0MMsRzGn/GTPXSnC/+5sXvjdiIQMcq+wNF9U67dYj9usanUPc
         hDP0ElZrmY/iZ4tEmVfG64Z+bcd3r2bTBjov+dUy6aGtJCuIsP5QbQd3pkkYRn5CzXBw
         CMAB8szPocqxixoDES+RlCybUHy2tXb8x7kl/GDt5ZxUupjdSkgZ0zqcTMOHNHpCbwAc
         Ie/K/tEhxgdFvgFY22Qqx3frHk/ir2RFHIdOUSSbFQVuFEvb23nczj072GMAov8OLw6a
         YjNw==
X-Gm-Message-State: ABy/qLalUkPHacbLDmkAEkJsv1wk+2WLs/6lAUkGJj+/i6dTwZZAS/b6
        Ay3Uu10PLV/cIsEqnofMYILZAgYbDQcxwZzTReE=
X-Google-Smtp-Source: APBJJlHIFwdXoq3fEeouuZHA3uRgotwmI8xtAA9OvUeQRBGjHbAdQIve77otqj4pB4KAcLWTqy9vCoLfVILX4h+g9FY=
X-Received: by 2002:ac2:43c4:0:b0:4f8:5f32:b1da with SMTP id
 u4-20020ac243c4000000b004f85f32b1damr515861lfl.24.1689234966774; Thu, 13 Jul
 2023 00:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_8D245D1A87D17619EA8475E8F005A151000A@qq.com> <65f4c60a-9534-56dc-099f-ee7a96e0ccaf@redhat.com>
In-Reply-To: <65f4c60a-9534-56dc-099f-ee7a96e0ccaf@redhat.com>
Sender: cl1ntlov3@gmail.com
X-Google-Sender-Delegation: cl1ntlov3@gmail.com
From:   linke li <lilinke99@gmail.com>
Date:   Thu, 13 Jul 2023 15:55:55 +0800
X-Google-Sender-Auth: mLUbCrxKcTjFCSMauTl1sicDTA0
Message-ID: <CAKdjhyBRcCFDiA923x0FLNYzs5vafENm96iAqV2XiDD_eTWBUQ@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: Fix integer overflow check in hugetlbfs_file_mmap()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linke Li <lilinke99@foxmail.com>, linux-mm@kvack.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        trix@redhat.com, ndesaulniers@google.com, nathan@kernel.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So we're adding code to handle eventual future compiler bugs? That sounds
> wrong, but maybe I misunderstood the problem you are trying to solve?

Sorry for not making it clear. My focus is the presence of undefined
behavior in kernel code.
Compilers can generate any code for undefined behavior and compiler
developers will not
take this as compiler bugs. In my option,  kernel should not have
undefined behavior.

I double check this patch, this patch can not solve this issue well. I
am considering a new
patch below. The new patch do overflow check before the addition operation.
```
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -155,10 +155,10 @@ static int hugetlbfs_file_mmap(struct file
*file, struct vm_area_struct *vma)
  return -EINVAL;

  vma_len = (loff_t)(vma->vm_end - vma->vm_start);
- len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
  /* check for overflow */
- if (len < vma_len)
+ if (vma_len > LLONG_MAX - ((loff_t)vma->vm_pgoff << PAGE_SHIFT))
  return -EINVAL;
+ len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
```
