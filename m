Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDA47EE852
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKPUai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKPUag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:30:36 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D5D4D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:30:32 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28014fed9efso1031357a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700166632; x=1700771432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEjWCpU7EfzbZkp/cS+44K0fOvV6SNfbaikoUgu/Bh8=;
        b=Mltlf2OGSIZl6NMhQ0FLbsxzYaCxySDWTbJUMotRpzbxes2Y5PUkJfFk+lIS6Qn291
         aQ3b1jOHHsJj77GbgRhFZxaTpyO1XjACFPtJuUnUtBL6591LDI+K3EwMLYKcvT5xGinD
         zJqz5YPKZsWM8PGGmpU55QMGgSmi3kiR9ZsfUTFLwa9hiOn/xxicBiHTQAYzFPQ39F65
         XXIrx4CVKDuisJw8p2IAy4+kgZk+bBBwQrBDwy8n+lfZJLIX5WsZSW0JuqOlYn4D6EMG
         8wM2wnJbC0u5DYaa+kN86/M3LttKf2luxU+PyYMzVpDNiMtxX22b8UXf1KRFTylGuMsD
         qKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700166632; x=1700771432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEjWCpU7EfzbZkp/cS+44K0fOvV6SNfbaikoUgu/Bh8=;
        b=PxiRkUX3KQlAXf35zWOMTory8ZJcjUprOSFyXRmHGhU7GKqEnIqIK6DJ2pO0Cqqxci
         S8hF0gezQoosEvO8e36P+Zf0A29Uk7T0AtpBvfNQ82qKa2n8ohzQmIlG+MPsaNYYuaDK
         E0ZjDml04IYNy9zmWBfKj5kaMJ68FYK46LTbKy/ADdhj5CdBn+RKYsqfyDCUDRxAdbK/
         wSYSRqnnBRtmt7pLd/B2JhKDQ9pVHOtAtQr9Q/wY24oHSjv4qmKo7Ir2y72LxAvGAYEW
         mqeZ6u1WtMIoQKwBgGvJs/W59W2BdvqUl8xydh8wKneRmrmPn0NOd5MVlnAkB1NjQxkL
         KETQ==
X-Gm-Message-State: AOJu0YwlywsJdGGgQy42e1b//I1fsAyy+CfLoKg0je4kWwAVAMEyeDto
        9NHAvKutK4bD5Hrly7iHqLIGiJS0G8LEiQ/gobn0aA==
X-Google-Smtp-Source: AGHT+IEX6IhtuDbopm9Q9kcM3lO96ECKq5Z2+KheUvpUBTosdcFLNM+0UQnZ3kN4dCP8P/1qAkCXnPNuOEOT5g9ZRY0=
X-Received: by 2002:a17:90b:33c6:b0:27c:ef18:d270 with SMTP id
 lk6-20020a17090b33c600b0027cef18d270mr13434773pjb.20.1700166632042; Thu, 16
 Nov 2023 12:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com> <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
In-Reply-To: <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
From:   Chris Li <chriscli@google.com>
Date:   Thu, 16 Nov 2023 12:30:20 -0800
Message-ID: <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two scenarios
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Nov 16, 2023 at 12:19=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> Not bypassing the swap slot cache, just make the callbacks to
> invalidate the zswap entry, do memg uncharging, etc when the slot is
> no longer used and is entering the swap slot cache (i.e. when
> free_swap_slot() is called), instead of when draining the swap slot
> cache (i.e. when swap_range_free() is called). For all parts of MM
> outside of swap, the swap entry is freed when free_swap_slot() is
> called. We don't free it immediately because of caching, but this
> should be transparent to other parts of MM (e.g. zswap, memcg, etc).

That will cancel the batching effect on the swap slot free, making the
common case for  swapping  faults take longer to complete, righ?
If I recall correctly, the uncharge is the expensive part of the swap
slot free operation.
I just want to figure out what we are trading off against. This is not
one side wins all situations.


Chris
