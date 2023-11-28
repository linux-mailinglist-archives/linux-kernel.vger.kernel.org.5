Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9A57FC9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345404AbjK1WpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjK1WpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:45:06 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073181990
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:45:13 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cfae5ca719so33804995ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701211512; x=1701816312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIxntpUV6An9T30/OVvCRNL5HGOjDnXv5bkE+BdjPrw=;
        b=Vfim6XvYZDA7AzQGfMvJ5knZHhX+viyOQ3XAOs95Q4yqtyMCcySt/Y1KH0SlFdP+Q9
         1M8QG0ql2JWiG/FtfaMIpPwe95u2UDRwVrHxA3+6T5a5rORJXJI5vIjIg/wwFUbBKOqI
         arA5KUaE1Px/q44krDUE9PQOFe6KVazDUFmZs+noYVMSJBcPSzNQVyGNLeEro/AkifnZ
         ZQ4BwqgRY9QxcwSLvlKQ6Kci1N/4coRXFoggWJl6E3qlYyCtOP2jKgBCwlRND3ZoL8SX
         4rdqOZVZ1OI1po6UVLs7hbAS04CyRYxOHA18UlTG41JZbvwOuOXIcP6aULYNcq51KwWu
         dwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701211512; x=1701816312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIxntpUV6An9T30/OVvCRNL5HGOjDnXv5bkE+BdjPrw=;
        b=qYdjxWA8SXHK2poSKSUwF8W2cqb5qxjJ6hxPArihAIBdOCq1TcZqRLun1NY419ejRv
         N5y8YDFfgldUcn7lRV91I8UWtSjYtMEsSG1eMRgWA5dCu2vDE7zr1Q0vSSOdFNdYNEnS
         zQbn9dVJZFLxfqN23kC9gyfdgW34zBvqRwlHrkpIJi9fTj6tq7dXP7QaiYvX2KL7Fnpq
         z5ErT6hx4n7NzmaDadozpKxMAY8p546iC7o1WpLhKebJYcU01csRhdgBShECa0EPq8wJ
         FzHcEnuzKVuJ+F/FAyIZIKU8AyAfpKbZtyjRItoQI2YWTZ0TkCyez/henVnHc8dF4E5b
         qklg==
X-Gm-Message-State: AOJu0YyAl6/k8z5wXT2oiQ/ONdOMOdTglkwQ0qHVvzcRpoexxv7fYfWt
        4Zqi79ou23sGO+aWVUXSCsI=
X-Google-Smtp-Source: AGHT+IGuuDxxp7Ov3KXDosfMOFDGyGkjXizTw+RX6QX20TDHGdgGTkoHhVlYYP1Jr+XANX7w9ORROQ==
X-Received: by 2002:a17:903:2345:b0:1cf:d8c5:2288 with SMTP id c5-20020a170903234500b001cfd8c52288mr7795170plh.41.1701211512355;
        Tue, 28 Nov 2023 14:45:12 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:8fd0:78d2:c604:3ac8])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001cfb971edf3sm6679898plg.8.2023.11.28.14.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:45:11 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 28 Nov 2023 14:45:09 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-ID: <ZWZtdQKSSnLC8kZ6@google.com>
References: <ZV3BWZ4ZaD5Rj_HS@tiehlicka>
 <ZV3TQCElHpcp0h0V@tiehlicka>
 <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka>
 <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka>
 <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWRdG49vlGzSY_Uj@tiehlicka>
 <87r0ka64v9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWW95JPQ1B0cVPY-@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWW95JPQ1B0cVPY-@tiehlicka>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 11:16:04AM +0100, Michal Hocko wrote:
> On Tue 28-11-23 09:31:06, Huang, Ying wrote:
> > Michal Hocko <mhocko@suse.com> writes:
> [...]
> > > Right. On the other hand we could be more aggressive when dropping the
> > > swapcache. Is there any actual reason why we cannot try to folio_free_swap
> > > even when mem_cgroup_swap_full == F?
> > 
> > If there are plenty free space in swap device, why not take advantage of
> > it?
> 
> Maybe a stupid question but what is the advantage of keeping around in
> the swap cache?

If the page is shared, we avoids addtional IO to bring them back so
swap cache.

If the page is still clean on reclaim moment since swap-in, VM doesn't
need to write them out to the swap disk since original data is already
there.
