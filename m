Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA97F8CD9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjKYRh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjKYRh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:37:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A696127
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:38:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da3dd6a72a7so3501886276.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700933884; x=1701538684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OjN2yjM4lGF+xoZzPeOmLggYv6X6PaCmv884vExzhQ=;
        b=Sb4za/p9PvTD0oIEk6DlS068u8izzt+Sbq6UOPQjqx4DXCVv3RzHfPPtGJvLBf9rEY
         gx3iWBUNixvRIlAXWhsJqAEWH/lDvJto9kE+a6x9TJTskmY5EDfzR2IFfD3egqbZ8WWY
         9vZKRKCQWjUxR2eOC4eKFtWqyYFL6QcpZwKE8lVHFIuhFyboHHyGXplhidwIClLPfVqB
         DVNX4I/6qtjEZsFqaCERd12IM72HcJxqdb05CIp1TkG5vxAGsXeQT/XWRRrKRAWBpddK
         hXY29g905eyC4DjR98qVwDL/n+f4BRWMcS840qldcg6y0MGMW2ZlBTuRJLUf/X6SIiwT
         Gbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700933884; x=1701538684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OjN2yjM4lGF+xoZzPeOmLggYv6X6PaCmv884vExzhQ=;
        b=F0vwmysKlQ2Y/Xc7uHS0ddpLamcnx9RLkX8CoIy+W4vR/quUzRN9HefVUKFBiN7J5s
         vPPhB2Ljr9ebu2h14HiKCS2gTQQtTMUu4A7MgPg2OJF0ZMmpcoghSHMqazVjKImEosDL
         v+jnb+KZmHagrdqav84QbqZXKauWQmls/v9dUax8pxyrgxrro1J6mjqkV5sSG1jXvJGO
         DC6bOf70sr2ISQHVDQ8izzoAg8m/zt4dtQjfyNoPZvExUYSrxetx29iaCX7D+rl2fSOl
         i21vLpXoj1jy8itDIMayUI/ss2XM5H+tsxhSPbbr02e88fOsJlPY7jAb+8nJyOngvKn0
         /Lhw==
X-Gm-Message-State: AOJu0Yw/yOPEjCEm+KJNmRzM2xU8Pxlr4A2/zE4pD+7A1ozvu5dzn6zh
        VjtU+MYEBXrbn+Hp/Gd7KO+omXfEttnMSg==
X-Google-Smtp-Source: AGHT+IHnGysxB/944b9w0n+byMEk08BlMdz921PvjzprbIkgHG0uwA4pdEh20uVwBEuI1Q+ppKReG75nHOmEVQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:3d44:0:b0:da0:567d:f819 with SMTP id
 k65-20020a253d44000000b00da0567df819mr220022yba.10.1700933884073; Sat, 25 Nov
 2023 09:38:04 -0800 (PST)
Date:   Sat, 25 Nov 2023 17:38:02 +0000
In-Reply-To: <20231125080137.2fhmi4374yxqjyix@CAB-WSD-L081021>
Mime-Version: 1.0
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
 <20231123193937.11628-3-ddrokosov@salutedevices.com> <20231125063616.dex3kh3ea43ceyu3@google.com>
 <20231125080137.2fhmi4374yxqjyix@CAB-WSD-L081021>
Message-ID: <20231125173802.pfhalf27kxk3wavy@google.com>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace shrink_memcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        mhocko@suse.com, akpm@linux-foundation.org, kernel@sberdevices.ru,
        rockosov@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 11:01:37AM +0300, Dmitry Rokosov wrote:
[...]
> > > +		trace_mm_vmscan_memcg_shrink_begin(sc->order,
> > > +						   sc->gfp_mask,
> > > +						   memcg);
> > > +
> > 
> > If you place the start of the trace here, you may have only the begin
> > trace for memcgs whose usage are below their min or low limits. Is that
> > fine? Otherwise you can put it just before shrink_lruvec() call.
> > 
> 
> From my point of view, it's fine. For situations like the one you
> described, when we only see the begin() tracepoint raised without the
> end(), we understand that reclaim requests are being made but cannot be
> satisfied due to certain conditions within memcg (such as limits).
> 
> There may be some spam tracepoints in the trace pipe, which is a disadvantage
> of this approach.
> 
> How important do you think it is to understand such situations? Or do
> you suggest moving the begin() tracepoint after the memcg limits checks
> and don't care about it?
> 

I was mainly wondering if that is intentional. It seems like you as
first user of this trace has a need to know that a reclaim for a given
memcg was triggered but due to min/low limits no reclaim was done. This
is a totally reasonable use-case.
