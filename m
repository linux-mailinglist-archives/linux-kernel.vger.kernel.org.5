Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC43780E206
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345700AbjLLCoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLCoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:44:06 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45BAD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:43:51 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9efa1ab7fso64322401fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702349030; x=1702953830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KaLk4QjiddLthhe61ZtqkCQM4vFUDEU82pA5JUhvoLM=;
        b=DRVWl+3DcoFbLMdABJur0JARjpubyVJztXG7UplaOZueHlUBYlRrNtbOGsm+Vi92PM
         RX02DKtc+MSLwfGDSygaR14iIhkGSg8sHnpyDO5B356e5yHjLJtf1rEQEFUcQFooV8cT
         AK8X5FJBTbLW9aG0e0ZGDKd9UqTPrYx+jY1UHcgNQeHlUA2aHTbUUYFs3c2mOOgm+9Ht
         c8HawJkMZTahh4iiDPWJ+46q8Wtit1zqjxwx1pDk+Mcz8MzPT/Bjz/+gTqqlUbsXmn4X
         G6/8vFCqbHYDzRRUWKDhYcgSsxfBQ0ffCmpd1ZpEZON+q2bg6V3o38WBD7aBLmwt8ah0
         MoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702349030; x=1702953830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KaLk4QjiddLthhe61ZtqkCQM4vFUDEU82pA5JUhvoLM=;
        b=hVylIkCVzJ6ApsFZ4jd0/WeGcNmC5oMRtVYtWv2KWywwBDWVDnbSVS+BdQMa5VtD7o
         p7CJPL5fmO5auhSvDjt2dQfnJ2sQRIIQbEG+55t98HbB5JvGEMHzkckWUPY6GHBj9yke
         1msK2FML8lMv9lWxZ0Vbsr8eA8wvHjFajdwZAM0kjEGnebBvceU56eEnZSpXWY0JrL8F
         59+X6QD7lPC427XdzROZEbWGMoqn0TC8e0OHOLurJFfa5G+kKflwwoLh/zFlkTkLPkJl
         Byp1tw7KltfPqXNrKXMlG5wyzUi86AMe9ouQ+QzRdwgmeHnXo2PmW8eUAxN05wLIM71Y
         3MAw==
X-Gm-Message-State: AOJu0Ywnepf1pSwF9KQMt20K6kizRyDX0OpkVVqmdls2LjtsWQ/F/3vy
        timk7iyjGjyrbc3NPb0IWRJ4x6TyFJodrAnUmNyZxw==
X-Google-Smtp-Source: AGHT+IGmTbrr+WPLH70Vp1/LxV2ShJdknyBI+xq5BxcnSB8agx7zdQkVJFzrXE6XAVxuwW4h5JTudbc3boLFVNSEUks=
X-Received: by 2002:a2e:9619:0:b0:2ca:760:bc55 with SMTP id
 v25-20020a2e9619000000b002ca0760bc55mr880262ljh.209.1702349029948; Mon, 11
 Dec 2023 18:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
 <20231209034229.GA1001962@cmpxchg.org> <ZXeTb_ACou7TEVsa@google.com>
In-Reply-To: <ZXeTb_ACou7TEVsa@google.com>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
Date:   Tue, 12 Dec 2023 10:43:38 +0800
Message-ID: <CACSyD1NPM-m_KeViGdoDbaoAwKUETkYPe8f6HLEzRtLm8VE+Fg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6] zswap: memcontrol: implement zswap
 writeback disabling
To:     Minchan Kim <minchan@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Chris Li <chrisl@kernel.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Johannes,
>
> I haven't been following the thread closely, but I noticed the discussion
> about potential use cases for zram with memcg.
>
> One interesting idea I have is to implement a swap controller per cgroup.
> This would allow us to tailor the zram swap behavior to the specific needs of
> different groups.

Hi Minchan,

It would be great if this feature could be in place. We are using zram and also
trying to use zswap to offload memory to disk. As kairui mentioned above,
there are many workloads of varying priority and sensitivity on a machine.

>
> For example, Group A, which is sensitive to swap latency, could use zram swap
> with a fast compression setting, even if it sacrifices some compression ratio.
> This would prioritize quick access to swapped data, even if it takes up more space.
>
> On the other hand, Group B, which can tolerate higher swap latency, could benefit
> from a slower compression setting that achieves a higher compression ratio.
> This would maximize memory efficiency at the cost of slightly slower data access.
>
> This approach could provide a more nuanced and flexible way to manage swap usage
> within different cgroups.

Indeed.
