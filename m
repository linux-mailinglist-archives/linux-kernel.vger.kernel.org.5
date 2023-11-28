Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434B07FCB21
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376653AbjK1X4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjK1X43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:56:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C0F1988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:56:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D11DC433C7;
        Tue, 28 Nov 2023 23:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701215795;
        bh=nvsvvynpek/zOvf0pUPcypWcMGJ2PtkOtXpvUsfR7I4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jrz8eaHzA/MashuzJGaOE+p4xwEr91K2ATTCNE0r3vnKRlVVBbxVznDltfPazcRJS
         xeDyx7roDh6QPiu9/3l8x+0m4WF39kLpHZ9Hf3vO5ihFPwyJmn/wqvkjztaSnKkkLc
         7XV607/1kxyW9pJvmVyRRqEegxMLIuT6naqt7JL4=
Date:   Tue, 28 Nov 2023 15:56:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] implement "memmap on memory" feature on s390
Message-Id: <20231128155634.9c325682d2cf87d0a6d48728@linux-foundation.org>
In-Reply-To: <20231128155227.1315063-1-sumanthk@linux.ibm.com>
References: <20231128155227.1315063-1-sumanthk@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 16:52:22 +0100 Sumanth Korikkar <sumanthk@linux.ibm.com> wrote:

> The patch series implements "memmap on memory" feature on s390.

The cover letter doesn't acutally have a description of what "memmap on
memory" *is*.  A nice overview to help readers understand what they're
about to look at.  A description of what value this feature brings to
our users.  Use-cases.  That sort of thing.

I guess the [1/N] changelog covers it, but it's hard to tell.  It isn't
exactly broad-sweep overview.

Probably something short would suffice.  There are plenty of examples
on the mailing list, please take a look and send us something?
