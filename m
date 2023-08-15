Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF8F77D388
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjHOTpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbjHOTp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:45:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137310C1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:45:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so23235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692128727; x=1692733527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aG0p6tGClogiWITji1d8WR0DZsPiG/lH8vMa5m2e7gQ=;
        b=bJDEqTmXf/tfzQGKAnaAtHeYWwfSlORdEyMY+zoaiJYKKPEmmp/1s0SIlHEW4rT5Fl
         3JpuVt4QuT32zqwfB4UaAgqYdNk6vXptn+NYo1UmDoQmu22w1vraDPPLGHJvx4bZcigH
         bFLuGnhIw25FDuaIl653lHA2fmocZe1TjaVFataGEy0rlMcjCHR4vvdV1olK3l05mquA
         67YtEyMC9Nxg4DuUR4mu3Y5kEhy6xq6XlfTLGx/0zlzZfUYg3NaXOjo90kjaW9GggEO7
         aqtsQSLvYKpwcQ1NwoW+fSob6hznfToqd9rd9MS9cLtBvxc6sz5KxGIZmPU2dtbEFmdC
         a0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128727; x=1692733527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aG0p6tGClogiWITji1d8WR0DZsPiG/lH8vMa5m2e7gQ=;
        b=DQuRRgiwku3MdHJ5no6MVMEsXKPpfylBsDik9OQCndK2QJ3cDNbUZMdQRWI9HMeHqh
         IK9XLwJLkaHDOE41LIrGPU7WebUSnwSPIZ/XkHSqeWy4G9pPK/hOBV1BsQifzqmSXEdd
         VtgK5VwYU2BKCjcXMHHnS4yFahWiJ5nCnjf84J9DMEbqVh2fpPshX4Ex2TBgN+HK3Q7M
         lgJzWYrYptcoDPTdU61ia3LHrHX34Zi4Xm2yqSvzWV9vQ4Wtv+JBgfdTuhTXxDug5NGs
         IHkaD2+b3AxHMw7wbHlqJd+1A8r3l76I81E+fzfZf5OVRDhaCZPM30/VcauR9ausB8o5
         L0gA==
X-Gm-Message-State: AOJu0Yzv6ezaIQGLN0xv0Wn5QteDRQGc5GbmhMpxGrZb7mipXnGkgP/D
        U8QkCmDSx/HWzbWlxDCFkOojiWptRV+uih7p7R5g5A==
X-Google-Smtp-Source: AGHT+IGdVkc5nLoT3UGwhhMddARc/ZYFi61zvwDUlxSmjK9dhk0rvOIhAOVf3W7xqzOhbrBw8haigJhh8LdlU15TBnk=
X-Received: by 2002:a05:600c:314a:b0:3f4:fb7:48d4 with SMTP id
 h10-20020a05600c314a00b003f40fb748d4mr2165wmo.3.1692128727217; Tue, 15 Aug
 2023 12:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com>
In-Reply-To: <CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 15 Aug 2023 21:44:50 +0200
Message-ID: <CAG48ez2CFMi75nZnC+CpKAXC9U+NmPaqUP9X7x_ysdEGxn5DMw@mail.gmail.com>
Subject: Re: maple tree change made it possible for VMA iteration to see same
 VMA twice due to late vma_merge() failure
To:     Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Aug 15, 2023 at 9:36=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> I think - my understanding is that the kernel will basically kill
> every process on the system except for init before it starts failing
> GFP_KERNEL allocations that fit within a single slab, unless the

s/slab/page/
