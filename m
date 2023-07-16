Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685C4754D28
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 04:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGPCmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 22:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPCmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 22:42:05 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F456D3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 19:42:04 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-cab61f812efso3333008276.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 19:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689475323; x=1692067323;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBCMVJPU/Zt2Fyzdjtg0pHSQITw+twghbG+ABS33Zns=;
        b=a2KWfcx0LGQ7ckLjKEdbxt2nMyV4rcIfPnqoyvw9sRER/ITd7/hkEzmxiU4s5Sc7ze
         Q0kLRIxgKGvzP7d/ueISDkEY2+9p3pXhI9cCwmKiG45SsFn9PUUSPTTuxGL2ER+mXDzP
         IdaD8dNSJZ/+qh4Ieph/P4Zy1AhgZLVujhhXuVTsPKYkuUW60doVmntU3Ln8WdcYlJau
         TmNkdXw3kB7Tw+iVklQb+VpXewFq7x5rU0qvXpm0Ea3+eyQKGOjhtNZyNBd0IKSQIvw0
         5bBz4dAA9BOppH12RRBCUZTFRhrYE/SHqVlSkpiRo6PvoyaIDs8eE+QX+jnSfMgzsfoI
         4rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689475323; x=1692067323;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBCMVJPU/Zt2Fyzdjtg0pHSQITw+twghbG+ABS33Zns=;
        b=EXDpENYznIa5hKq/ab68p5we+ym1+PsN2IQLQsGitG7nIKwXS5NDniNf5bJ4sufImG
         YTCoMQJ5Sukq7CDtH0CDzBM/hBLHUIKKSZLQg9jbGH1WFXhNhA2AKrjrJIYEwtjvTYee
         8wb1J5QPERhKPg2odO/lVrtvJ/fa2sqVff+9Zzi2vctVSRQdb/89qIwbQ5BftC60TwhD
         1stWZLIw11idtK+YuFOlpQrPMgdi4jBPZfRd0Up3ENfxMvaU9L3PWs6w1k/+vufbyHfP
         Go450SuUP7tp8HNXZOQW7fHPL/NFX3vyj6R8xkU+lbQo4t8X5Wv/xT2qCFg2sejvu1OY
         ybAA==
X-Gm-Message-State: ABy/qLa6yIdqvBVCbfJrSfd2CCRmkWIL5AZ8ZI7Q43sYhoPYpmUWPBbt
        lYynRwE4tYYAtIe5gZjFA7oVfQ==
X-Google-Smtp-Source: APBJJlE0beKyrlN6/zbOkQuDmqcNOdQE90DxNqh0mpYM3xyVueqJ621Uj5TMdlTj5tr6egv33kWotA==
X-Received: by 2002:a25:b31d:0:b0:c60:982f:680c with SMTP id l29-20020a25b31d000000b00c60982f680cmr8034493ybj.63.1689475323336;
        Sat, 15 Jul 2023 19:42:03 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r14-20020a255d0e000000b00c602b4b7226sm2381363ybb.25.2023.07.15.19.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 19:42:02 -0700 (PDT)
Date:   Sat, 15 Jul 2023 19:41:48 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        hughd@google.com
Subject: Re: [bug/bisected] I see "mm/pgtable-generic.c:53: bad pmd
 (____ptrval____)(8000000100077061)" every boot time
In-Reply-To: <CABXGCsN3JqXckWO=V7p=FhPU1tK03RE1w9UE6xL5Y86SMk209w@mail.gmail.com>
Message-ID: <b41e1b86-6280-5779-7bb7-3ba97481239@google.com>
References: <CABXGCsN3JqXckWO=V7p=FhPU1tK03RE1w9UE6xL5Y86SMk209w@mail.gmail.com>
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

On Sat, 15 Jul 2023, Mikhail Gavrilov wrote:

> Hi,
> It's ok that I see "mm/pgtable-generic.c:53: bad pmd
> (____ptrval____)(8000000100077061)" every boot time?

Many thanks for reporting, Mike.  No, I wouldn't call that ok at all.
Though I've more research to do before I can tell how much it matters.

> Unfortunately bisect couldn't say which of commits
> # possible first bad commit:
> [be872f83bf571f4f9a0ac25e2c9c36e905a36619] mm/pagewalk:
> walk_pte_range() allow for pte_offset_map()
> # possible first bad commit:
> [7780d04046a2288ab85d88bedacc60fa4fad9971] mm/pagewalkers:
> ACTION_AGAIN if pte_offset_map_lock() fails
> # possible first bad commit:
> [2798bbe75b9c2752b46d292e5c2a49f49da36418] mm/page_vma_mapped:
> pte_offset_map_nolock() not pte_lockptr()
> # possible first bad commit:
> [90f43b0a13cddb09e2686f4d976751c0a9b8b197] mm/page_vma_mapped:
> reformat map_pte() with less indentation
> # possible first bad commit:
> [45fe85e9811ede2d65b21724cae50d6a0563e452] mm/page_vma_mapped: delete
> bogosity in page_vma_mapped_walk()
> # possible first bad commit:
> [65747aaf42b7db6acb8e57a2b8e9959928f404dd] mm/filemap: allow
> pte_offset_map_lock() to fail
> # possible first bad commit:
> [0d940a9b270b9220dcff74d8e9123c9788365751] mm/pgtable: allow
> pte_offset_map[_lock]() to fail
> definitely first bad because my machine on which I am was doing
> bisection is unbootable on these commits.
> I hope Hugh Dickins can figure out what's going on here. He is the
> author of these commits.

And thanks for the patient bisecting.  Yes, it will be 0d940a9b270b
which introduced the unexpected problem, then be872f83bf5 which fixed
the unbootability aspect (that's right, isn't it? with be872f83bf5 in,
your machine booted ok? but in between it was unbootable).

Very useful info, since it narrowed the symptom down to users of
that pagewalker, before it was allowing for NULL from pte_offset_map()
(we were not expecting ever to hit a bad pmd in normal circumstances).

I have now been able to reproduce such a message, by setting
CONFIG_EFI_PGT_DUMP=y - am I guessing correctly that you have that?

For now, I recommend that you leave CONFIG_EFI_PGT_DUMP unset.
I wonder how many other people have it set, but have not yet noticed
this "bad pmd" message you are reporting.

The problem comes from a confluence of surprises: the pagewalker
now makes an exception for init_mm, but efi_mm is another odd case;
and espfix sets up pmd entries in an unconventional way, which happens
to fit the "bad pmd" criterion; then the efi_mm pgt dump discovers them.

I'm not rushing to judgment on where and what the right fix will be,
that needs some reflection.  And perhaps more urgent than that, is that
I got not one but 12 such messages (with 4 processors): that's another
surprise, I would have expected the condition to be cleared after the
first message (but that clearing to ruin the running of Win16 binaries).

More will follow, at lower priority; but if I'm wrong about you having
CONFIG_EFI_PGT_DUMP=y, and unsetting it hiding the issue, please speak up.

Thanks,
Hugh

> 
> All mine machines are based on the AMD platform two 7950X and one 5900HX.
> 
> It seems that this message is harmless for the system in any way, but
> I can't judge it is a bug or not.
> From the user side it looks like regression because on commit
> 46c475bd676bb05077c8a38b37f175552f035406 this message was absent.
> 
> -- 
> Best Regards,
> Mike Gavrilov.
