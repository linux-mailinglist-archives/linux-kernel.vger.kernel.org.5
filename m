Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203B17F7A98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjKXRzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjKXRy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:54:58 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E79189
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:55:05 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c5b7764016so24768911fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700848503; x=1701453303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BFE0t+TRDRGNBpCexvzqDA3fMaHJ8VxILINLTV7YhaI=;
        b=cBBirUIpsMTyIcS4hPjPSxlka3ie3spxpFbaElhsC2D6uZJdbo/xhRTQpKg5ksnTI4
         QHLXj+ggWjDcx02GS4h9yIss5jZU2VHh+8JnaYMz6xTOxFPipssOzJ8xBZnRAdbFyaxi
         IGxWogYOnUGyVjj4y7+Q26TS9bP5/DveMKG7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700848503; x=1701453303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFE0t+TRDRGNBpCexvzqDA3fMaHJ8VxILINLTV7YhaI=;
        b=tcR/GByFyFDNzKWj1U7erbb7Nd6qTFzVLwy1eZbQWMnG2CK1JmACcwcIYQx0XGAuYQ
         hmDUfDJkD54yDYkNBUm8khFNQR62n5/pav8LgQOcbW+ZA8GhdeyDtlPYOEzbrr6p4tCY
         rf3dpnHUbM7XgS8q/UA7vbaNcaNL3yDJXZHIAzp3hPk8dVHNY/E3dhA8yDURQAKgiZQf
         C1EF430HFhkmhsFd8jFm8XiVUlODao1g6AFFSMuT46EXrGjSwh8fJkUO6UNfMvOcbEpt
         57rKpEiPwOj+oBHH7JUdbTzJw7+j5i0mZ8qlyOB3nota4Ju9H9uTT7cgMo/zUhFfeX42
         9ThA==
X-Gm-Message-State: AOJu0Yx4C2UnZjKcP/HoMGXUhsl04RcyOiCQnOdSgDqlzL8jRhIcI7H8
        /zG0UUuD/KG1KAZjPliFlaP9hQ==
X-Google-Smtp-Source: AGHT+IEXc7shnNCNJyF3Y2bev/tDlX7XM9m0TsbpTMp7yEB8qRnDfoWC0hAXlw8rbPP5mKNCGncjOA==
X-Received: by 2002:a2e:9346:0:b0:2c8:714f:53a with SMTP id m6-20020a2e9346000000b002c8714f053amr3055274ljh.3.1700848502716;
        Fri, 24 Nov 2023 09:55:02 -0800 (PST)
Received: from google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id t23-20020a2e8e77000000b002c993572c7fsm59450ljk.35.2023.11.24.09.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 09:55:02 -0800 (PST)
Date:   Fri, 24 Nov 2023 18:54:54 +0100
From:   Dmytro Maluka <dmaluka@chromium.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kemi Wang <kemi.wang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next v2] mm, proc: collect percpu free pages into the
 free pages
Message-ID: <ZWDjbrHx6XNzAtl_@google.com>
References: <20220822023311.909316-1-liushixin2@huawei.com>
 <20220822033354.952849-1-liushixin2@huawei.com>
 <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
 <YwSGqtEICW5AlhWr@dhcp22.suse.cz>
 <6b2977fc-1e4a-f3d4-db24-7c4699e0773f@huawei.com>
 <YwTYMGtcS4/F/xQO@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwTYMGtcS4/F/xQO@dhcp22.suse.cz>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 03:37:52PM +0200, Michal Hocko wrote:
> On Tue 23-08-22 20:46:43, Liu Shixin wrote:
> > On 2022/8/23 15:50, Michal Hocko wrote:
> > > On Mon 22-08-22 14:12:07, Andrew Morton wrote:
> > >> On Mon, 22 Aug 2022 11:33:54 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
> > >>
> > >>> The page on pcplist could be used, but not counted into memory free or
> > >>> avaliable, and pcp_free is only showed by show_mem() for now. Since commit
> > >>> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
> > >>> significant decrease in the display of free memory, with a large number
> > >>> of cpus and zones, the number of pages in the percpu list can be very
> > >>> large, so it is better to let user to know the pcp count.
> > >>>
> > >>> On a machine with 3 zones and 72 CPUs. Before commit d8a759b57035, the
> > >>> maximum amount of pages in the pcp lists was theoretically 162MB(3*72*768KB).
> > >>> After the patch, the lists can hold 324MB. It has been observed to be 114MB
> > >>> in the idle state after system startup in practice(increased 80 MB).
> > >>>
> > >> Seems reasonable.
> > > I have asked in the previous incarnation of the patch but haven't really
> > > received any answer[1]. Is this a _real_ problem? The absolute amount of
> > > memory could be perceived as a lot but is this really noticeable wrt
> > > overall memory on those systems?

Let me provide some other numbers, from the desktop side. On a low-end
chromebook with 4GB RAM and a dual-core CPU, after commit b92ca18e8ca5
(mm/page_alloc: disassociate the pcp->high from pcp->batch) the max
amount of PCP pages increased 56x times: from 2.9MB (1.45 per CPU) to
165MB (82.5MB per CPU).

On such a system, memory pressure conditions are not a rare occurrence,
so several dozen MB make a lot of difference.

(The reason it increased so much is because it now corresponds to the
low watermark, which is 165MB. And the low watermark, in turn, is so
high because of khugepaged, which bumps up min_free_kbytes to 132MB
regardless of the total amount of memory.)

> > This may not obvious when the memory is sufficient. However, as products monitor the
> > memory to plan it. The change has caused warning.
> 
> Is it possible that the said monitor is over sensitive and looking at
> wrong numbers? Overall free memory doesn't really tell much TBH.
> MemAvailable is a very rough estimation as well.
> 
> In reality what really matters much more is whether the memory is
> readily available when it is required and none of MemFree/MemAvailable
> gives you that information in general case.
> 
> > We have also considered using /proc/zoneinfo to calculate the total
> > number of pcplists. However, we think it is more appropriate to add
> > the total number of pcplists to free and available pages. After all,
> > this part is also free pages.
> 
> Those free pages are not generally available as exaplained. They are
> available to a specific CPU, drained under memory pressure and other
> events but still there is no guarantee a specific process can harvest
> that memory because the pcp caches are replenished all the time.
> So in a sense it is a semi-hidden memory.

I was intuitively assuming that per-CPU pages should be always available
for allocation without resorting to paging out allocated pages (and thus
it should be non-controversially a good idea to include per-CPU pages in
MemFree, to make it more accurate).

But looking at the code in __alloc_pages() and around, I see you are
right: we don't try draining other CPUs' PCP lists *before* resorting to
direct reclaim, compaction etc.

BTW, why not? Shouldn't draining PCP lists be cheaper than pageout() in
any case?

> That being said, I am still not convinced this is actually going to help
> all that much. You will see a slightly different numbers which do not
> tell much one way or another and if the sole reason for tweaking these
> numbers is that some monitor is complaining because X became X-epsilon
> then this sounds like a weak justification to me. That epsilon happens
> all the time because there are quite some hidden caches that are
> released under memory pressure. I am not sure it is maintainable to
> consider each one of them and pretend that MemFree/MemAvailable is
> somehow precise. It has never been and likely never will be.
> -- 
> Michal Hocko
> SUSE Labs
