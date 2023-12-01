Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0764C80142A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379530AbjLAUPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjLAUPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:15:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E06710C2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:15:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53012C433C9;
        Fri,  1 Dec 2023 20:15:12 +0000 (UTC)
Date:   Fri, 1 Dec 2023 15:15:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/rmap: Fix misplaced parenthesis of a likely()
Message-ID: <20231201151535.06c7aaaf@gandalf.local.home>
In-Reply-To: <2d691c11-fa97-4f56-a4c4-c7f466c81d3a@redhat.com>
References: <20231201145936.5ddfdb50@gandalf.local.home>
        <2d691c11-fa97-4f56-a4c4-c7f466c81d3a@redhat.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 21:06:22 +0100
David Hildenbrand <david@redhat.com> wrote:

> But
> 
> > Cc: stable@vger.kernel.org  
> 
> stable, really? Why?
> 
> > Fixes:fb3d824d1a46c ("mm/rmap: split page_dup_rmap() into page_dup_file_rmap() and page_try_dup_anon_rmap()")  
> 
> and does it even fix a real bug?

As a performance person, who measures likely and unlikely results (the
ftrace ring buffer was sped up by over 50% with strategically placed
likely/unlikely annotation). I find this to be a real bug, and something I
would want backported to the kernels we maintain in ChromeOS (which uses
upstream stable kernels).

-- Steve
