Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A95C7B122F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjI1Fhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI1Fhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:37:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A61B13A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 22:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oCs9pPPAfG+6rr3UFszgJdG+UGor/qhSAHCcQlB7aqQ=; b=QN/QU1TSehiksGI86vYhyrm9I7
        StpxLNjxcV8ZoAmUlb6z79w3jL2FVd8r71K1ktsoESHwHQaW3f2DdqYAyl7lRFT2UTnfxsYZcczPn
        UR6JFt4842HpkK4R7UcZgtUpNJRmhEsOmkidaR0ouUjf08N2+loJj8B52REk9EhwrHGgsHobhB30j
        ttui51DYaeqTC33fdYZz/eLAZMnmo91No19eDo+wV0h5u+Oo6EUKEMySTPTXMKc7rozUvzbn3nqpo
        VkgvA5yoIZH25WTepNEOxQdK3+79sIWS25Z7ttPOnzjwf6d0o0rI0RqQZi9TTiRba2qTTH+Wqh2xT
        UCCQ2JOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qljiU-000gA5-TL; Thu, 28 Sep 2023 05:37:38 +0000
Date:   Thu, 28 Sep 2023 06:37:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yikebaer Aizezi <yikebaer61@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: WARNING in vma_merge
Message-ID: <ZRURIkHJF9meX+Ms@casper.infradead.org>
References: <CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALcu4rbT+fMVNaO_F2izaCT+e7jzcAciFkOvk21HGJsmLcUuwQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:31:05AM +0800, Yikebaer Aizezi wrote:
> Call Trace:
>  <TASK>
>  mbind_range+0x299/0x560 mm/mempolicy.c:834

https://lore.kernel.org/linux-mm/20230918211608.3580629-1-surenb@google.com/
