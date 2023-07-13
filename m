Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3C751A81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjGMH5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjGMH5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:57:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D962723
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:57:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e5da802afso440135a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689235031; x=1689839831;
        h=cc:to:subject:message-id:date:from:sender:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBeF8DimtieRIbeczjrQAO7Bmt6r/83M9FTzR+dYQus=;
        b=j/nV/8M8qJDGiBFI8327yymczZxYK3EfM6/n5B+YZFgBAbsM/NkhigpTrpzmhftlim
         sU9+IpUQhH+EozlQ8N+xthICiD87MdzfWGGhmOFrlFvVBLBZ9RyIXawww6pS6oMMOD/W
         34dGfPC+7nNIb6RO65P3JlWDda6SSyv+raLu1gVioQGyGlxCj3oloUL1ds0vxrQgqfoW
         ivlzJxRwt4BvvmFntFjoZL/7wSo0p91OqWuP3X+UtA63HEeE9BvbSLAjMh2X08w/PTcR
         YHluygjJ7slsd5eqGK/SAm+AlFSvlynVotNqmbbccE7lLTZQU+JpYjYHBvO/E0k1Ezgh
         0j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689235031; x=1689839831;
        h=cc:to:subject:message-id:date:from:sender:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBeF8DimtieRIbeczjrQAO7Bmt6r/83M9FTzR+dYQus=;
        b=V5HdAtUx8nzwAPjIGLUJD7VhHLRaQ66iNOS/gI8ACMTICZTSXJ5QHiUoStKso600P9
         H9xxD3OS8R1nJe+pJCVaskFUsOcngShbwxRjxdipFYrby9DSIAjMyqqbNZaCKsZPLzq9
         rFFXFHm92EYEuTyOZjsbtafWHEth/BIeXw9H1VsqyD8jQh8XcptZp5HeInnVQcrxeEI7
         Us45LS9q88QnK8LwIkUipKN4fPuIJDrp6ZmOnD0GDrX0UocZBdRuy8rKek4i3fUawt3O
         FgA073WKBKTMmVS7D75gFVFx2TjpvB6gu0g4y9FhFzSbxLOESXEI3vhr/u4yd7l2Np+2
         oFmQ==
X-Gm-Message-State: ABy/qLZ+1FrGtOlFOWoLHJuy1jVSWNEkfcn6CCWIooKutfYoqQN0G9Gp
        x7plhtXjBhbhng5DZUBLBQJT0roumIw/44D6nkY=
X-Google-Smtp-Source: APBJJlHbM+0P718q61QkhmRg2sZBdOo9EtDJ8+TrS+eXLQDo5tAoYPNE/0mM/eZP5gei9DkV5833SS3E0v0Hx3rZF2E=
X-Received: by 2002:aa7:c90f:0:b0:51e:f83:6de6 with SMTP id
 b15-20020aa7c90f000000b0051e0f836de6mr1240233edt.16.1689235031366; Thu, 13
 Jul 2023 00:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_8D245D1A87D17619EA8475E8F005A151000A@qq.com>
 <65f4c60a-9534-56dc-099f-ee7a96e0ccaf@redhat.com> <20230712235813.GE6354@monkey>
In-Reply-To: <20230712235813.GE6354@monkey>
Sender: cl1ntlov3@gmail.com
X-Google-Sender-Delegation: cl1ntlov3@gmail.com
From:   linke li <lilinke99@gmail.com>
Date:   Thu, 13 Jul 2023 15:57:00 +0800
X-Google-Sender-Auth: AOlVQvJu9wTequs-Y5TVT_XTP9o
Message-ID: <CAKdjhyD4RVHFVLrcfcuEnvwrjjxAk_GL=kjcm1iw3WTrmmFb9Q@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: Fix integer overflow check in hugetlbfs_file_mmap()
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linke Li <lilinke99@foxmail.com>, linux-mm@kvack.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        trix@redhat.com, ndesaulniers@google.com, nathan@kernel.org,
        muchun.song@linux.dev
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

> However, if this is a real issue it would make more
> sense to look for and change all such checks rather than one single occurrence.

Hi, Mike. I have checked the example code you provided, and the
difference between
those codes and the patched code is that those checks are checks for
unsigned integer
 overflow, which is well-defined. Only undefined behavior poses a
security risk. So they
 don't need any modifications. I have only found one occurrence of
signed number
overflow so far.

Thank you for your valuable feedback.
