Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B627F5D86
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbjKWLNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344939AbjKWLNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:13:40 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6AB9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:13:47 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so8795731fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700738025; x=1701342825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVOejPj0G54Lit2Uyo96eZ6bkXM9HZIazx2Np37e5CI=;
        b=J6KdDANSk7WrZCqXaX6P2xp440vkaa5mad8JOkvkTKraKHbuMq3Wa7bCFWvAgdTxXU
         gsCroILaBHXsSQLuirsMDJTo+hgmJw6qbtcJONlOZx/nHKWmSF08+yNhm+wgoYUysOOZ
         1XLHAOQTQi3Tj94SwourTLBHK8fiF8iLDfRH8aGNufFd1UT72NyaoVadVO69/11LPv1M
         zBBkE1VwAlO4yvtrucHv9pRXyT+jClxFNsWnuwJOt+ZhkxQoW260cpQ5XYKBDGr5Uozd
         PCpsvN0RXVBYyB96WaiesuF5xmuN2DsDrt7DFnYUIIU7zlPAr7NiNcsKEi77+gYIEd2T
         3wMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700738025; x=1701342825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVOejPj0G54Lit2Uyo96eZ6bkXM9HZIazx2Np37e5CI=;
        b=E2yL+0WDqRhOIwOFU1sXOBPkgREYmhqWFNPqloSI9Z1rno6ovag40l/ZA2x+yZ5Ri0
         XijI9h7NQ2bVKLvj0xXFNh4AQ8+1pK6xxABOxo8vQVsnUaBcR5VhGRH3Kbf9YI7a8sdz
         qluDQNCtw4Si1wuBZsp4Ox4Y698q5xg5fG5hz8djItAGwyvzW4s6Ap7oK5SGobLkrW3Y
         urrW+EMsEiwflf4FRLf+YwfZbODoF7DnkEou0ctGHw2ejGIRqshhm2RK7ghMYkudLjB2
         fl3I05Fyh113+6WKjXICOb9SuAbrhLrFfOFCs5BUQga/lavYa/jmQVN9cxbQuS2mAxHO
         Bm8Q==
X-Gm-Message-State: AOJu0YxwvuMKOOv7gaFGJxZzAApUvXxVAydB6zgXEE0dLnnCd2oLQGld
        YjRd5ue+LJWkcLS2m0/BYTIFNXU5vwxuFweTDf8=
X-Google-Smtp-Source: AGHT+IEGg5VfnCETwTajEapRt0obuhE0/nk0jzOVjxAmRtmGkRRcnk8xi5p89NpdZrTjIxyKqZ70HP5HK6obg5YSRuQ=
X-Received: by 2002:a2e:90cf:0:b0:2c6:ee73:a20e with SMTP id
 o15-20020a2e90cf000000b002c6ee73a20emr3583861ljg.33.1700738025304; Thu, 23
 Nov 2023 03:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-17-ryncsn@gmail.com>
 <87sf4yaajv.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sf4yaajv.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Thu, 23 Nov 2023 19:13:27 +0800
Message-ID: <CAMgjq7Ba9inFHCqoZSNY_gFUv=UEVEC8FvG+V7-7Qpv027tEmQ@mail.gmail.com>
Subject: Re: [PATCH 16/24] mm/swap: reduce scope of get_swap_device in swapin path
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=89 08:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Move get_swap_device into swapin_readahead, simplify the code
> > and prepare for follow up commits.
>
> No.  Please don't do this.  Please check the get/put_swap_device() usage
> rule in the comments of get_swap_device().
>
> "
>  * When we get a swap entry, if there aren't some other ways to
>  * prevent swapoff, such as the folio in swap cache is locked, page
>  * table lock is held, etc., the swap entry may become invalid because
>  * of swapoff.  Then, we need to enclose all swap related functions
>  * with get_swap_device() and put_swap_device(), unless the swap
>  * functions call get/put_swap_device() by themselves.
> "
>
> This is to simplify the reasoning about swapoff and swap entry.
>
> Why does it bother you?

Hi Ying,

This is trying to reduce LOC, avoid a trivial si read, and make error
checking logic easier to refactor in later commits.

And besides there is one trivial change I forgot to include in this
commit, get_swap_device can be put after swap_cache_get_folio in
swapin_readahead, since swap_cache_get_folio doesn't need to hold the
swap device, so in cache hit case this get/put_swap_device() can be
saved.

The comment also mentioned:

"Then, we need to enclose all swap related functions with
get_swap_device() and put_swap_device(), unless the swap functions
call get/put_swap_device() by themselves"

So I think it should be OK to do this.
