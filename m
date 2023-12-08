Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62D0809767
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjLHAnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHAnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:43:05 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6318FD5B;
        Thu,  7 Dec 2023 16:43:11 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7b373b0e9b7so71054839f.0;
        Thu, 07 Dec 2023 16:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701996191; x=1702600991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8OQ4qcJBnrVu5qdEda2Vkc1e736jChzDqNzRg++7jp4=;
        b=Xp1OZaYwu7UmbI0jUOrYrDiwhgyOlQEfKxfcDHrsmTS0OUUmChDC50iG+O8GF42b9O
         X943sj1BPgoR05PWOfKH1du5kzGFCn1o9ctlr2+kW5SPxM3h06LUnUWsoK6zg03BzfcH
         xYNIboaLLCCstB51Sn0vSWPM2PPSl79eYj+l3zT5BiDNqC2lQmEUBEPUm6AcjhVlhW3Q
         Zl6dJrZNznPt5vUpvyiXlWCecW+qoE7PH+8tqJ4rfDtTbrvH/XDOh4zGZE0zHvgWNCtz
         hSMw2Guejll6mTGBQGYtbPzQQC04eSUzPNdaAJLIR4oPEHqkjdg5zis3VgcI2RXx9saZ
         /eJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996191; x=1702600991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OQ4qcJBnrVu5qdEda2Vkc1e736jChzDqNzRg++7jp4=;
        b=AUahYRwgKNB0hrw68HZauD7jkg0rewKoypiKdFDDccZJ8ZzjfzbyWZepnLf3bild/F
         eZFNq0G+OdSnXRJhFm9S42NDyEy+TSfKem2RsLtUU4sZi7IecHZzi2V3mFu6BrHp/T9Y
         7+VfWCRdsyGcMgNCOCREJDWWsUQfnpHqrHUDMteoDi/rtUIkaIwejMlhoPyIlDJi7/lQ
         35SP06MQN8qiIFfjjqWiAgXq5Np9i4Cws6F7jz18/9Qhff4KW6mbR004I1u6lnpWDp2P
         jDM67THU0B5daQeedzLHP/VCjHMzgmZSrBO+xPXf4XZmj0aq+iLTW0DIoRs8ydj1fzuD
         PeUA==
X-Gm-Message-State: AOJu0YyUj+95w0wAxs2SPnhC3iGSua5WOIuwFjT1sF+8B7ozJRo2vadz
        SFCUDQQS30juTYF+9lwemloQPFBVHmjrkTIiM3o=
X-Google-Smtp-Source: AGHT+IEpRm0jQ8487xc394HrqLkpMOegFa+1vLDmLWlmGaEzkTVkdOUdqPonhL6LsuUtyJKsDg8S18tMf1iCe2gOMD8=
X-Received: by 2002:a5e:8e04:0:b0:7b6:ef47:7042 with SMTP id
 a4-20020a5e8e04000000b007b6ef477042mr2369173ion.20.1701996190674; Thu, 07 Dec
 2023 16:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <20231207141142.307745be167d044b0eec1b42@linux-foundation.org>
In-Reply-To: <20231207141142.307745be167d044b0eec1b42@linux-foundation.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 7 Dec 2023 16:42:59 -0800
Message-ID: <CAKEwX=Oa4hKCvhhR7D9kbQ-gi2LaKBjeC3GNB3b91doVB07vEA@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This does seem to be getting down into the weeds.  How would a user
> know (or even suspect) that these things are happening to them?  Perhaps
> it would be helpful to tell people where to go look to determine this.

When I test this feature during its development, I primarily just look
at the swapin/major fault counters to see if I'm experiencing swapping
IO, and when writeback is disabled, if the IO is still there. We can
also poll these counters overtime and plot it/compute their rate of
change. I just assumed this is usually the standard practice, and not
very zswap-specific in general, so I did not specify in the zswap
documentation.

>
> Also, it would be quite helpful of the changelog were to give us some
> idea of how important this tunable is.  What sort of throughput
> differences might it cause and under what circumstances?

For the most part, this feature is motivated by internal parties who
have already established their opinions regarding swapping - the
workloads that are highly sensitive to IO, and especially those who
are using servers with really slow disk performance (for instance,
massive but slow HDDs). For these folks, it's impossible to convince
them to even entertain zswap if swapping also comes as a packaged
deal. Writeback disabling is quite a useful feature in these
situations - on a mixed workloads deployment, they can disable
writeback for the more IO-sensitive workloads, and enable writeback
for other background workloads.

(Maybe we should include the paragraph above as part of the changelog?)

I don't have any concrete numbers though - any numbers I can pull out
are from highly artificial tasks that only serve to test the
correctness aspect of the implementation. zswap.writeback disablement
would of course be faster in these situations (up to 33%!!!!) - but
that's basically just saying HDD is slow. Which is not very
informative or surprising, so I did not include it in the changelog.
