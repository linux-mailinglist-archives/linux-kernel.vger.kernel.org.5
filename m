Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425997D0719
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376266AbjJTDqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbjJTDqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:46:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82428FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:46:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9adca291f99so52568466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697773590; x=1698378390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VGeRszknI8Vp8HsUL3IX8fsK+U4qmVS9OPc1Q4Z2bP4=;
        b=NA+tgDQjZRhPYminUHAQJ12cyYl9ISfdI/HBQTY+LHEeUHvkhQwB7EDWsMcsAWo6lb
         +qIkMyppcHcDayJqq5DVrsrxMjlkelS+YW+1qq13pSIc3XhjGnpILaKSxILpWCegtnMB
         gUYhNDD3/vnwwRHQ6xcfzUsc2SorJVOIn+kb53Oy6l5JJ/VHN3Cs6uxlHcIUYD5qtLuR
         UJqtyajY6Zp0JMv8ERnCLobkSfzq0gWAKF/SbaBw0z0BYVLonEsNlKkNjxi7+l0oa0in
         Rgjc8CyeApNqnaN1thkuCK5OxRVuqUe7JA4YcVSqAtmCwvMfc+1026OTP2blzutClUFn
         VkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697773590; x=1698378390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGeRszknI8Vp8HsUL3IX8fsK+U4qmVS9OPc1Q4Z2bP4=;
        b=CWmGKAFaVih24dgduBoL/10WHTeMBLpqnYbAGD6HrnuzCbRfdU/wB63sT6AC1aGUJy
         ffyQaRYxKnSOCKXHnyKJTWhkZAbgpy2Ih2NbHxG5SftmedptTu0QKeLeTu8IQCv6HjMw
         62WMBey7GVNMUa8b2iEtvcPOZKDxQOgZpVt7Dt0bYg/1ScBsY4bVvmiJNK1Xmpq0ULhd
         a7LIwk1shEq7bESU5/mcMzO0JBrn7cr37pscPVQA5wT/OD5sILQGPoAvCfLW3uyIrBko
         +PwztfjlX5YD/WTWSswbXJuX97dHMfRx/X+QaGqKGrllzRwo4X2c+NWqQyhITvFO7y/b
         M1sw==
X-Gm-Message-State: AOJu0YyP9UbRiMSPhJq+mTbN2aVwqi+8NmXuONrjlBGaXtc6+oP2TiIU
        MuXiSf7ridjIOBw9CI5vCvg029l/jgk7mYp0DruqmA==
X-Google-Smtp-Source: AGHT+IG2T7laE3iDmE7uz9HaeoIjLZakva0IZlxp9hy9kmChsrsM4a0HvG38mHosxab3hwmdo2F6W4k3d6d0ZwzjwuE=
X-Received: by 2002:a17:906:6a13:b0:9ae:74d1:4b45 with SMTP id
 qw19-20020a1709066a1300b009ae74d14b45mr411837ejc.65.1697773589697; Thu, 19
 Oct 2023 20:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <64899ad0bb78cde88b52abed1a5a5abbc9919998.1697632761.git.baolin.wang@linux.alibaba.com>
 <1F80D8DA-8BB5-4C7E-BC2F-030BF52931F7@nvidia.com> <87il73uos1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ad721be-b81e-d279-0055-f995a8cfe180@linux.alibaba.com> <27f40fc2-806a-52a9-3697-4ed9cd7081d4@intel.com>
 <e8099116-6f78-cb4a-5036-1d7e38b63e52@linux.alibaba.com> <fd389af5-d949-43dc-9a35-d53112fe4a60@intel.com>
 <05d596f3-c59c-76c3-495e-09f8573cf438@linux.alibaba.com> <b9042fcb-05df-460f-87b8-4d7a04d3bd5e@intel.com>
 <e84f8c2d-6264-f2a3-3737-17d48a0251f8@linux.alibaba.com> <93abbbfb-27fb-4f65-883c-a6aa38c61fa0@intel.com>
 <0aaf6bf4-a327-9582-569e-2a634ce74af4@linux.alibaba.com>
In-Reply-To: <0aaf6bf4-a327-9582-569e-2a634ce74af4@linux.alibaba.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 19 Oct 2023 20:45:50 -0700
Message-ID: <CAJD7tkbA0Ofvw8wQM0017DKWC3SXOT71rCnUhGkoPgQ4wOfLOA@mail.gmail.com>
Subject: Re: [PATCH] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        hughd@google.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

> >>
> >> IMHO, that seems too hacky to me. I still prefer to rely on the migration process of the mlcock pages.
> >
> > BTW, Yosry tried to address the overlap of field lru and mlock_count:
> > https://lore.kernel.org/lkml/20230618065719.1363271-1-yosryahmed@google.com/
> > But the lore doesn't group all the patches.
>
> Thanks for the information. I'd like to review and test if this work can
> continue.

The motivation for this work was reviving the unevictable LRU for the
memcg recharging RFC series [1]. However, that series was heavily
criticized. I was not intending on following up on it.

If reworking the mlock_count is beneficial for other reasons, I am
happy to respin it if the work needed to make it mergeable is minimal.
Otherwise, I don't think I have the time to revisit (but feel free to
pick up the patches if you'd like).

[1]https://lore.kernel.org/lkml/20230720070825.992023-1-yosryahmed@google.com/
