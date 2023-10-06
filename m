Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F4D7BB768
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjJFMQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjJFMQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:16:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30F6C2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hNVK67EoEfC4ks5hIAmDG5CWFmou5FKHiT7V2Fk4tdM=; b=d1BCfI5Y1aDqG8YFJIpPF8rqpg
        iX0dqf3J5uWGdolaIETXawNMHPUMFTjjpVZgO+7Ovginh9ff7pRDkB1myntd9n4LyHrItWhkK55gR
        yKTKZtf3kF/jPbIFSbRmDQp4dO7ohyBJVa2RocafQf5TrNSXflCbUZ5dKsaBAP+NZ5802HQuEHeHQ
        WosGZ9/Z+Tu/W63PJijMdnT+S950bB+lFBospOiArsxwj320Fy8z7e3hUMlh7HdwNdObkfyNFJ0fo
        pTS9oXr7tM/OStaBt1wt++t2skwpbA+ybA2RX7PINzg8gq2OoiyUrLB1IvgqRGXNqdp6S1nh5Wc5T
        1pXtrEog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qojlB-00FEWW-5W; Fri, 06 Oct 2023 12:16:49 +0000
Date:   Fri, 6 Oct 2023 13:16:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muzammil <m.muzzammilashraf@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: rmap.c: fix kenrel-doc warning
Message-ID: <ZR/6sZmNMpMkfxKf@casper.infradead.org>
References: <20231006113948.51673-1-muzammil@dreambigsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006113948.51673-1-muzammil@dreambigsemi.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:39:48PM +0500, Muzammil wrote:
>  /**
>   * folio_move_anon_rmap - move a folio to our anon_vma
> - * @page:	The folio to move to our anon_vma
> + * @folio:  struct folio - Represents a contiguous set of bytes.
>   * @vma:	The vma the folio belongs to

Why did you change more than just 'page' to 'folio'?  I think the
other changes you have made to this line are not an improvement.
