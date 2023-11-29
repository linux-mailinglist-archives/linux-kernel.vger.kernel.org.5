Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1677FDE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjK2Rdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2Rdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:33:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6A5CA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:33:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86921C433CD;
        Wed, 29 Nov 2023 17:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701279223;
        bh=zQQtQnUHucJiwN/RgIyJnqMuBd9OdTTF4L4XnghdVhM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=USgwQzTaJOoS5e7xNqNJZYaQJgsm4DYEqgxPQkGiNGMQ9bYiU3rSdOdAKhOorK1Hd
         sAF10PwyYmAceKrI9fZfeEGjxvuXj5AeqWrKzr3UgzpHW5OEj9eoWAUJDn5MUd/7YU
         H8TJCT5AxiHc68DVNQc+hjedUEZDe8Tczed+byys=
Date:   Wed, 29 Nov 2023 09:33:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     Michal Hocko <mhocko@suse.com>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <muchun.song@linux.dev>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace
 shrink_memcg
Message-Id: <20231129093341.02605a16142fc3e04384c52e@linux-foundation.org>
In-Reply-To: <20231129152057.x7fhbcvwtsmkbdpb@CAB-WSD-L081021>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
        <20231123193937.11628-3-ddrokosov@salutedevices.com>
        <ZWRifQgRR0570oDY@tiehlicka>
        <20231127113644.btg2xrcpjhq4cdgu@CAB-WSD-L081021>
        <ZWSQji7UDSYa1m5M@tiehlicka>
        <20231127161637.5eqxk7xjhhyr5tj4@CAB-WSD-L081021>
        <ZWWzwhWnW1_iX0FP@tiehlicka>
        <20231129152057.x7fhbcvwtsmkbdpb@CAB-WSD-L081021>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 18:20:57 +0300 Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> Okay, I will try to prepare a new patch version with memcg printing from
> lruvec and slab tracepoints.
> 
> Then Andrew should drop the previous patchsets, I suppose. Please advise
> on the correct workflow steps here.

This series is present in mm.git's mm-unstable branch.  Note
"unstable".  So dropping the v3 series and merging v4 is totally not a
problem.  It's why this branch exists - it's daily rebasing, in high
flux.

When a patchset is considered stabilized and ready, I'll move it into
the mm-stable branch, which is (supposed to be) the non-rebasing tree
for next merge window.

If you have small fixes then I prefer little fixup patches against what
is presently in mm-unstable.

If you send replacement patches then no problem, I'll check to see
whether I should turn them into little fixup deltas.

I prefer little fixups so that people can see what has changed, so I
can see which review/test issues were addressed and so that people
don't feel a need to re-review the whole patchset.

If generation of little fixups is impractical, I'll drop the old series
entirely and I'll merge the new one.

Each case is a judgement call, please send whatever you think makes
most sense given the above.
