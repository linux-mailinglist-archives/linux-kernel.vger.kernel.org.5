Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F36E7F8429
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346009AbjKXTY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345996AbjKXTYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:24:24 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B84B0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:24:30 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf5ceadfd8so384355ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700853870; x=1701458670; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ivzBeFk46bHraSTpkDDO2OfgPAmO8fKwgp2Nt9UqFMA=;
        b=mKTNfEu0vC9nTsxzPx+cdgOlSm5yBaXnKQjv6YCXwwL8EqN9vvoOUBlelBVRRbDBt3
         q4PNT5pvQsRcBLffWwIPBJIcQEteI2AfPBY4P7D0NDELS8VcBs6NsMZ+1ImIkIynhahn
         N7G8fineejHmH1YB6DwOkE4cYBFgWVRENuXxpx9xjkhrqsfGg8r7Ne9cOy486eO5ytnz
         ve1zVTaHIao5JkblU6ypwYaHMqI/9kS+eioFOyoliQ+uPIiswu6WS35KU40FClXZYwfd
         Zg/o0HlCPMdk+82r7se6DQfeUJo0gRC32IOaAX6DtjsMf9s+lMdnc+e1FlFEuX9H6YQB
         iQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700853870; x=1701458670;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivzBeFk46bHraSTpkDDO2OfgPAmO8fKwgp2Nt9UqFMA=;
        b=bOOm6pukuzeUq3k2xJfSe8bvr+OSCaYNBxgp2Aum4YJGm5x27g/PiXJxnnaTp+arot
         V35l52PYw5uj7pyO9lm75NAouRNesVfBMke48qUryVfE6z73jnD07co/9ndsfruSh4Ol
         7SLtLr+VBHj2MNORs542lGHf7c8I/4KOmeMZvZkilUAY/miu95cVKw/+c5I+51rxSu/N
         vg336PusDXnT2rkLYBauyXUIoiK7bU2b8ZOOrV71sg+4yhr67/si0aD9iYkCH5MI4bnN
         E9wcw+/qJs0QnTislyqLixCAHmxkLEGfS1RKsVmt0UZqDPEElJMpHtOhYPC8F0Ae/Cgr
         ydlA==
X-Gm-Message-State: AOJu0Yyw33/fsEEpSMclE+Fe0zoWS2jNYXm3l+z+WMo6hgf5Ku4YkRaq
        gg4P7AXMsPkdKnuSukquY5su6Q==
X-Google-Smtp-Source: AGHT+IEKCAghp18p2RMzOJinFvRX0Df9f6+hZqfk/7rmYMmUaUHgCgPglqlA3wD53Qj04aOwfc+tiQ==
X-Received: by 2002:a17:902:d18c:b0:1c9:bfdb:aae4 with SMTP id m12-20020a170902d18c00b001c9bfdbaae4mr734910plb.18.1700853869860;
        Fri, 24 Nov 2023 11:24:29 -0800 (PST)
Received: from [2620:0:1008:15:d807:a0b3:20ea:f28f] ([2620:0:1008:15:d807:a0b3:20ea:f28f])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090282c400b001c5bcc9d916sm3509683plz.176.2023.11.24.11.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 11:24:29 -0800 (PST)
Date:   Fri, 24 Nov 2023 11:24:28 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, david@redhat.com, vbabka@suse.cz,
        hannes@cmpxchg.org, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] mm: page_alloc: enforce minimum zone size to do
 high atomic reserves
In-Reply-To: <c3a2a48e2cfe08176a80eaf01c110deb9e918055.1700821416.git.quic_charante@quicinc.com>
Message-ID: <01c81f6a-f090-a544-49db-ed9cd97ab8ee@google.com>
References: <cover.1700821416.git.quic_charante@quicinc.com> <c3a2a48e2cfe08176a80eaf01c110deb9e918055.1700821416.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 24 Nov 2023, Charan Teja Kalla wrote:

> Highatomic reserves are set to roughly 1% of zone for maximum and a
> pageblock size for minimum.  Encountered a system with the below
> configuration:
> Normal free:7728kB boost:0kB min:804kB low:1004kB high:1204kB
> reserved_highatomic:8192KB managed:49224kB
> 
> On such systems, even a single pageblock makes highatomic reserves are
> set to ~8% of the zone memory. This high value can easily exert pressure
> on the zone.
> 
> Per discussion with Michal and Mel, it is not much useful to reserve
> the memory for highatomic allocations on such small systems[1]. Since
> the minimum size for high atomic reserves is always going to be a
> pageblock size and if 1% of zone managed pages is going to be below
> pageblock size, don't reserve memory for high atomic allocations. Thanks
> Michal for this suggestion[2].
> 
> Since no memory is being reserved for high atomic allocations and if
> respective allocation failures are seen, this patch can be reverted.
> 
> [1] https://lore.kernel.org/linux-mm/20231117161956.d3yjdxhhm4rhl7h2@techsingularity.net/
> [2] https://lore.kernel.org/linux-mm/ZVYRJMUitykepLRy@tiehlicka/
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

Acked-by: David Rientjes <rientjes@google.com>
