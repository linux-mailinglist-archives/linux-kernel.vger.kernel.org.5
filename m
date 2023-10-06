Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C250C7BBF99
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjJFTLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjJFTLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:11:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B549E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:11:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1451C433C8;
        Fri,  6 Oct 2023 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696619469;
        bh=EnuEKRB9oFSk++wlKiOY0cRkD8mdQLc5D/LnwswF4NI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R2Bg82Mef+62IDjs/fjlRoxaLJjewc3GxQZUaaH7SYppOOlSLuVYd4SGeNNUIn/a6
         2sDgGy3+8ZEg5q4ltPM/uY0QGS/g2bHn8HzW6BjBMmWvt+5Aa4Nde5ee2dJ/iHeoCC
         AgfkUwkBMaVhwDuVMUiMus7ORhXVb5Ytw2suYkG0=
Date:   Fri, 6 Oct 2023 12:11:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v4] mm/thp: fix
 "mm: thp: kill __transhuge_page_enabled()"
Message-Id: <20231006121105.69a1f32753dad00b993e2547@linux-foundation.org>
In-Reply-To: <0ed83331-9037-421a-d450-363e07e87f6a@redhat.com>
References: <20230925200110.1979606-1-zokeefe@google.com>
        <20231006105810.17fcb352e33cbcab1645099b@linux-foundation.org>
        <0ed83331-9037-421a-d450-363e07e87f6a@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 20:52:30 +0200 David Hildenbrand <david@redhat.com> wrote:

> > And as I don't know what is the urgency of this patch ("mm/thp: fix
> > "mm: thp: kill __transhuge_page_enabled()"), I'm unable to decide which
> > patch needs to come first (thus requiring rework of the other patch).
> > 
> > Please discuss!
> 
> IMHO clearly this one.

OK.  I'll drop the "variable-order, large folios for anonymous memory" v6
series for now.
