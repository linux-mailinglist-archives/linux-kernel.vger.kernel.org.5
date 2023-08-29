Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1855678C44C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjH2Mcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbjH2McN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:32:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE811A3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/tFGeoIOTSwMPxn6jit/B1Nh0WKY+PIwsengOhDWvgU=; b=kmRfFUUgOqOwMBkss/1f0YiIPK
        KjK+EErKgLgkVmMGdHItFf12BrIIpE3zm2LmjhsrsnVhG8FKSdYgAA9A2EL7sUmb0AQgDaF9K969s
        gAgjXhRY+tH/Opi0/ITecWeYCx4pGM5WgRjKgIQlqYCZs2qljjuXks6Eph9G2tAUCLIWnf2OkLi4C
        UHIm3sSstFhwdsNnOZDRD2kEiU10wrEvhKnhZ7T3xqw2AzOwwLDV07Vvl8Cdal393Xp1USeHyGesC
        FfHmhAULpkLHMc9B377Pbh8dT71HMirbDnRWfU+IIOoGMAgC7sE03UbaucvgB2PbltOsMXfHGwv8J
        oj9HFWEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qaxt4-006XZk-T3; Tue, 29 Aug 2023 12:32:02 +0000
Date:   Tue, 29 Aug 2023 13:32:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: Define DEFAULT_STACK_GUARD_GAP
Message-ID: <ZO3lQn8XZA+Q9/dF@casper.infradead.org>
References: <20230828035248.678960-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828035248.678960-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 09:22:48AM +0530, Anshuman Khandual wrote:
> This just defines a macro constant i.e DEFAULT_STACK_GUARD_GAP representing
> the default gap, guarding the stack mapping. This does not cause functional
> changes.

But why have you done it at all?
