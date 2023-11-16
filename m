Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75CA7EDA43
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344846AbjKPDdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKPDdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:33:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCFBD5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:33:17 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so395465e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700105595; x=1700710395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpqwIukJN4pe5ng/7gTK1zs3f2lJ5+Nh8U6l7DMo/Ls=;
        b=PfNuS8X9GvIHbI6c+MqurPcSzltGr+ljl+1NakTd6ccbbrdohyKfzpCrUBz3IZCjAV
         3nZiEpHDi1mOGVhZnmmEmRCuN7ZeYnoaP3SjxtfS3M+zJP9O9pVMun5WQVS769fNLijT
         tvqSI0cyl0QqArAjphhNQ2rqtj6914Sg1TxrMOjNU6fdZtHtNpGIG825l2QUlfQ5BpHQ
         euUsLU4zry/n3ZJHJodaT3VA5S9omSG+ZbE+OcVUBNkSckXx5W+CbVC6Ru1JiQoiBJ3S
         eCqGpAg1Epi5AGjsKQaxI9Y8DoqxGhY0UOKv4T7E/Bg3b2DscJeBBcl9jKIiLvi73FaC
         wbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700105595; x=1700710395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpqwIukJN4pe5ng/7gTK1zs3f2lJ5+Nh8U6l7DMo/Ls=;
        b=io5zF8dGHTE9CZJuXsDnL2qX0otkWBIJ3OjF/3BWcSd6YNLRJD4UR6O5CRrkjqf78g
         euxYLYwZeY2RSetrdENjfmSjCxXVipuffci8kmUWIr1wER5JIrrBxbjUc+Lf7COrWou+
         5ZAFcfR7aOb7XXNfdx9FMzDr+RjO+L0JLkEw8QloRaEan+q2vbRRrqfdN5P37c4Dtrvr
         n4pdhSQN+hGBlCNOUjYJEdCZiLkn77P+/+M421LdnJTv+ZsE8eVwDgqKc2rjmPdOT+WG
         /NAsnpOAJ8IdaWuGImFW7VfkF29AbRuOnbxw+QJKi/EVoqi9xcKH9RUYcbQxf7tZWxSm
         BfRQ==
X-Gm-Message-State: AOJu0YwCTnAP4KwUDd1lRUQY+nI2GItlP7Ma+17eL18CDBYuLiiydwUj
        AYpxlmq00Y2YJj4Mzit7xjfI+g5ibxYA9WIw5/7w+g==
X-Google-Smtp-Source: AGHT+IGbUOhz2+BNaQkvb9Z18TKRjDf/Bxz4dE2NrTeLNsgDDqA6PVyBftHctxYwLqfPsb6qJXCg7uNMng1BpgSymkg=
X-Received: by 2002:a05:6512:b0f:b0:506:8b41:7e31 with SMTP id
 w15-20020a0565120b0f00b005068b417e31mr193547lfu.6.1700105595568; Wed, 15 Nov
 2023 19:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CACSyD1P6RwjWpKhvNWEo77LKpTrnKOzT-+TV+GnQu_g-ADYbcQ@mail.gmail.com> <CAJD7tkbkPZ-Fiyz_4CKNQmufCpWSF330xK3bc7aHNML_cPi2sA@mail.gmail.com>
In-Reply-To: <CAJD7tkbkPZ-Fiyz_4CKNQmufCpWSF330xK3bc7aHNML_cPi2sA@mail.gmail.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Thu, 16 Nov 2023 11:33:03 +0800
Message-ID: <CACSyD1Nav7+zppx3BZS8vU5uF3AaBin0XOKCdtdQ1d6sA4wu9w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 4:13=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> I think we may need to try to lock the folio. Otherwise we may race
> with reclaim reading the dirty bit before we set it.
>
> Taking a step back, this seems like we are going behind exclusive
> loads. We "should" keep the page in zswap as exclusive loads are
> disabled and the page is not yet invalidated from zswap (the swap
> entry is still in use). What you are trying to do here is sneakily
> drop the page from zswap as if we wrote it back, but we didn't.

If  we want to reclaim the cached zswap_entry, Writing back might
be the easy way.

> We just know that it was already loaded from zswap. We are essentially
> making the previous load exclusive retroactively.
>
> Is there a reason why exclusive loads cannot be enabled to achieve the
> same result in the (arguably) correct way?
>

zswap_exclusive_loads is not enabled by default, so the shrink_worker
may fail if there are many cached zswap_entries on the zswap_pool->lru.

Is it possible to make zswap_exclusive_loads the only way in zswap_load?
It only makes sense when the page is read and no longer dirty.
If the page is read frequently, it should stay in cache rather than zswap.
The benefit of doing this is very small, two copies of the same page
in memory.

Thanks.
