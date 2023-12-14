Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A019D813A08
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjLNSeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNSef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:34:35 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E047CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:34:42 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2cc48cf8e70so6668771fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702578880; x=1703183680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kd5phlPt7VtJUezgR3/onk5WgF0KF/KEQizyh1jeonM=;
        b=f/JSjEnI5q9a92LHU575jelJN9L41cb2D61eMgF9yD9WOjumu8X5qaHE/eFjm6ji2d
         2tHqd66y6qEHcB7NE2rRhqW8juCZFoWjC9si+ZJPFlvo5P22NXAB59DvuJiVgDV2Ksw2
         71CGSMASCzIAj0dh7cr0TozeUhgOEzh48fLCXf5sCzsI+IWOxaSHRmty1yxvXoHFYDAN
         91H9Gq0riuV1n9MYsC8L1560keI0lqTE2ozE9WoFi7KjmIRQGUNdSl9U7NHHEP3LlH0H
         /vRtT62eGvuWu/8bOmq6NlekFKFH9O0iz5qCWVvH/hVNAboXbUI0n7rgSRF+FK/2w6JR
         lYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578880; x=1703183680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kd5phlPt7VtJUezgR3/onk5WgF0KF/KEQizyh1jeonM=;
        b=nzdMu9uTblBPKta6Pnj1mf9urq0V/yNeQUkBUcHp/Rd656Bk5rvIThJIdC8q7Oc/ZE
         RRfy+0HJ64QzpGdho71E07X7eawFxcYJX7GgJh8k/I1ZaNhxz2AZ6/L2k9/TNXX1IGvf
         35o5uYjSL44p3S4kBQFk68OAhrLiwcuzJbuh86mc2um5Q+84veVQetVObyiIxJ8aogea
         Kt8LQRoq/Y5TNMKRF3Lk59r0suUQdGpGz5pO1nw2Ncn1KoT9cCiHkmLph6egc+qtujXQ
         xIPYSpvklNZ877OOcfpBn49mm7mpsWkXLj+rm8TDQCfl4sEEdzsiL5ob8spQthy5u6fn
         CTYQ==
X-Gm-Message-State: AOJu0Yyn6tG8iQx/r1I/B/I0ig6IqK2b8xqSSzzBixl5Bjy8nUw/MaD+
        Ae/rdyVOVH2eTTTTk4+hVhNe1Tr4b5v7xU5roOASODM4GFwXRvlU2M4=
X-Google-Smtp-Source: AGHT+IHuohIc7ndJPih2o8S6kIrL4T6xCKUlR5QkoUQk8hygZL43couKufKeWx2DVpZaqEMzUz9vu3539rMGlUt7eRI=
X-Received: by 2002:a05:6512:4026:b0:50b:fe58:d6f1 with SMTP id
 br38-20020a056512402600b0050bfe58d6f1mr6772518lfb.87.1702578880160; Thu, 14
 Dec 2023 10:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-2-896763369d04@bytedance.com> <CAJD7tkZJRgf+502QU_ECVPey0w-5vw_e6HSL+Ay7unetq5gL0A@mail.gmail.com>
 <CAKEwX=P4=YbvoRCa5+BB+==f4YL_5-6AaUNUCdH3v2faTx-PYQ@mail.gmail.com>
 <cb558f85-4f9b-4eb9-b60c-9b609075920d@bytedance.com> <CAJD7tkY_fe9SeTxOSVmYHNgi2tKvZ+EoM15KifJihF_Zn_LqDg@mail.gmail.com>
 <7a8c77b0-c78c-427d-9545-2b328c7dc727@bytedance.com> <7a0e3229-be63-4a24-a3fe-7e3ff517de10@bytedance.com>
In-Reply-To: <7a0e3229-be63-4a24-a3fe-7e3ff517de10@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 14 Dec 2023 10:34:04 -0800
Message-ID: <CAJD7tkYB1MHC+rJa0wA8FHVM_sJb-DFcaqT1Oz+nSxdvkE0DyQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/zswap: change dstmem size to one page
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[..]
>
> I think we shouldn't put these poorly compressed output into zswap,
> maybe it's better to early return in these cases when compress ratio
> < threshold ratio, which can be tune by the user?

We have something similar at Google, but because we use zswap without
a backing swapfile, we make those pages unevictable. For the upstream
code, the pages will go to a backing swapfile, which arguably violates
the LRU ordering, but may be the correct thing to do. There was a
recent upstream attempt to solidify storing those incompressible pages
in zswap in their uncompressed form to retain the LRU ordering.

If you want, feel free to start a discussion about this separately,
it's out of context for this patch series.

Thanks!
