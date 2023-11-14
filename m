Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C717EAA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 06:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjKNFWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 00:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjKNFWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 00:22:13 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5158D123
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 21:21:46 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c72e275d96so70258211fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 21:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699939304; x=1700544104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFazJKGI/TXOxXxvNJdTYDm70uzaXwkwGyJYAesZ3KA=;
        b=EUx5WV+MRDWXSqfRVkdk7stz4ZBkG8p1z9u6OpX3Q/gbFkwXvSyOvUanR7sqP/Ob6S
         S8p/YcUOdnwZsWUmemriBLpuAJ8x84y0/3nZGUGytDJqByyucpLK66cv4cewlihcVAP7
         ZYzYyCradTEgGkqaAmfbURZuH14A1I0vSs4xrbKuf6z24nPRmbdjaNLtnHFdc/G6sEDh
         W5KusPbjGQU7XHbsVPTgNf9SUX7M/RJNS2ClYRlfzVKZJgZLqen8lzURKsR+vRr2xcSX
         y+BNxXD8alZjkA9X/VidxVE4erFtiiTu0u6sEc1D2IcGkOoC8Sq+nRabcxoJi3h2GQbG
         nr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699939304; x=1700544104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFazJKGI/TXOxXxvNJdTYDm70uzaXwkwGyJYAesZ3KA=;
        b=v5tcnQhrTe34Ojpai/ipjHc1nFzLqJXVYAzlGESBKgI+iYODNIwKKcyy+fc5ui4RDs
         WtZ0SGVSUdEzllNlKtCDxKSz784OyC2OIk6lFu5IS7+6J2dYrbXkgpsZbHBaN/+5FY/y
         0S3OeCo0vADEo0NL0/SC3cRSPfb/aJgyJdUic+8b+yT7Up0OmdOFXWdAuSNSVQlBxlfm
         LC8fj1ORWbq9IVYVJKISnwEdkn7W4JfH8/s1mhdd3j46d4QnPKeckC1B5fqA8ExZEv6/
         jSFAEUBqaEkT+GjWH24TJsrqPaNlXiPtVRzyUA2KYmX8anigaoF2RJ+S9+7U8O/ar6VL
         x2Dg==
X-Gm-Message-State: AOJu0Ywm2Sb58eI0dS8uMg93+Y6mozaNrG1XI1uVxbAlZSYnLVse5+Ro
        JAUWTTjyVvEPVq1wFi8mLYueRZDd1aKHHF6118AKBmEsAXap2W25h6xHJA==
X-Google-Smtp-Source: AGHT+IEJizqJ/1ImGcgFDonHZweB1Xt1y6ltaxyQoL5rns/lM33U5zyLoo2f0MZnaq+ayEER0/f39NPIgR+FBGZcMzY=
X-Received: by 2002:a2e:a175:0:b0:2b9:4b2e:5420 with SMTP id
 u21-20020a2ea175000000b002b94b2e5420mr817711ljl.52.1699939304588; Mon, 13 Nov
 2023 21:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com> <CAKEwX=NhiGyoqR3HaDCuarqGmM5CCMYDatvVEEtVKzrL8DdDbw@mail.gmail.com>
In-Reply-To: <CAKEwX=NhiGyoqR3HaDCuarqGmM5CCMYDatvVEEtVKzrL8DdDbw@mail.gmail.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Tue, 14 Nov 2023 13:21:32 +0800
Message-ID: <CACSyD1NyynLrrkrp-A8tGW5gUJeFQiYk_E_SO14m_7wqrddtiQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your time, Nhat.

>
> These two cases should not count as "successful writeback" right?
>

This is true from the perspective of the writeback itself, but should it
also be considered successful from the purpose of the writeback,
 i.e. whether the compressed memory and zswap_entry can be reclaimed?

> I'm slightly biased of course, since my zswap shrinker depends on this
> as one of the potential signals for over-shrinking - but that aside, I th=
ink
> that this constitutes a failed writeback (i.e should not increment writeb=
ack
> counter, and the limit-based reclaim should try again etc.). If anything,
> it will make it incredibly confusing for users.

This patch will skip the writeback step=EF=BC=8Cso the writeback counter wi=
ll not
be incremented. Currently MAX_RECLAIM_RETRIES is 14, shrink_worker
will often fail if writeback fails.

>
> For instance, we were trying to estimate the number of zswap store
> fails by subtracting the writeback count from the overall pswpout, and
> this could throw us off by inflating the writeback count, and deflating
> the zswap store failure count as a result.

As mentioned above, writeback counter will not be incremented.

>
> Regarding the second case specifically, I thought that was the point of
> having zswap_exclusive_loads_enabled disabled - i.e still keeps a copy
> around in the zswap pool even after a completed zswap_load? Based
> on the Kconfig documentation:
>
> "This avoids having two copies of the same page in memory
> (compressed and uncompressed) after faulting in a page from zswap.
> The cost is that if the page was never dirtied and needs to be
> swapped out again, it will be re-compressed."
>

Yes=EF=BC=8Ci know the point=EF=BC=8Cin the case of reading, there is no da=
ta update,
so the next swapout does not need to be compressed again.
Consider this scenario,there is a lot of data cached in memory and zswap,
hit the limit=EF=BC=8Cand shrink_worker will fail. The new coming data be w=
ritten
directly to swap due to zswap_store failure. Should we free the last one
to store the latest one in zswap.
