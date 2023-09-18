Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA4D7A5224
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjIRSh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIRSh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:37:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF0EFC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:37:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c451541f23so13315165ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062272; x=1695667072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ScKdDfhlF+ZG275yQXOonVaIbCq8z4oSkAgmpL2eHU=;
        b=lAZxHq4Y1CD/DLV1L4yAAvPtSVulfJVzPzaRLMWSsqGjm14JBUyvfjnWNlbS5QbdnF
         ONWGd0sjDDwo7sFcSmDywINXjBPszYlO+Ex/IWTVW+f9/fjo2bpE/R7G8FjLZOXyE6Zx
         98AuclCNmJoQ7VZFzhEOAe9V0g7EeiFL1E+WoLqNjik9xdPcp70bvXXaSFekc9NievaJ
         lG1c27nIbxqbv809Kdfuq6fjTPzYtdtr9I6QIW1QN91tWTNDY3LJoXjWD54tB7p0f22O
         sBhUv2nY3hSFBhcGVEikGwEX2ErNhxgLpAbp0+jAMkwjKcYQPH7MjUIUTi1uKDAQQC/V
         PmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062272; x=1695667072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ScKdDfhlF+ZG275yQXOonVaIbCq8z4oSkAgmpL2eHU=;
        b=H+UgvUKTkO/jqaR6ZhznHaG0wFKECpUK8O+YH8bjpIiN8LTZPzs1Z/BSxZISXVNFTs
         NPW2AdMYHVENSyKXAZnAsQ3NX94IlTdGm7EV/NxwKr8PbsI765/CBzg0X9vsrRnnLoXi
         crpqBZ0YOHWzsfwyQJWmP/oMvE6ks0nJQcwkcvvbew4fwVRpf8ReaAGTrn/0dYuTX5HR
         2g1VNeiIrB9fZqIvc0s8koh616S5GqNc3uK0UYQguI90ygBj6Oqemk5QZgMbbxwi4cPF
         SMt6Et6KJUGvhjtv4Kk0a0uwgcg5hCWD4oxtk/XFggbFIwBB+AmzXDaw/DfmJMtPdsGO
         CzJg==
X-Gm-Message-State: AOJu0YyPX0CW4Ms1xqbH4cRQ2GPF0Nvr366UxWUQ4MPaPK0VXs/6inlN
        k1K46rjXZ3STdsAZmf+hnLo=
X-Google-Smtp-Source: AGHT+IG4B/eP4zg58lHmf6KXEN2QiIe0AdDbu3rb/IxkWlNtqX4y6NW3TYDCjtW2wOvWbRzb3fF+AQ==
X-Received: by 2002:a17:902:6aca:b0:1c3:411c:9b7d with SMTP id i10-20020a1709026aca00b001c3411c9b7dmr8138103plt.57.1695062272019;
        Mon, 18 Sep 2023 11:37:52 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902768200b001c1ef9d2215sm8509960pll.270.2023.09.18.11.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:37:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 18 Sep 2023 08:37:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Expose swapcache stat for memcg v1
Message-ID: <ZQiY_q_vIV-SRU5A@slm.duckdns.org>
References: <20230915105845.3199656-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105845.3199656-1-liushixin2@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 06:58:43PM +0800, Liu Shixin wrote:
> The first patch expose swapcache stat for memcg v1, the second patch
> remote unused do_memsw_account() in memcg1_stat_format().
> 
> v1->v2: Cover MEMCG_SWAP with CONFIG_SWAP and delete unused code suggested
> 	by Michal.
> 
> Liu Shixin (2):
>   memcg: expose swapcache stat for memcg v1
>   memcg: remove unused do_memsw_account in memcg1_stat_format

Acked-by: Tejun heo <tj@kernel.org>

Thanks.

-- 
tejun
