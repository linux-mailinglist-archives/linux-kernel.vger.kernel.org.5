Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF3D7E5BFE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjKHRKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjKHRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:10:20 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39BEE8;
        Wed,  8 Nov 2023 09:10:18 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 273B45C01B6;
        Wed,  8 Nov 2023 12:10:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 Nov 2023 12:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1699463418; x=1699549818; bh=5Q
        6Rk+qzMpMI23pOp3I8TlmgYyCmchkLsFD/CkDi2mw=; b=eUWrxueEssiCj+bvgf
        Sq643QOe3X6h42kIJc2C4ZR4tm4w3mOdG8mMOOrmOgg0M9yYXlhsfKxDkCNkqCCG
        BgOwi8kOtWhJvTJkklO6nDjZNnLpGJinks5lcfiGObfANptCTPVE0woOqtneT3uJ
        9U2DdjeQAOnKqKFIXNDdnFKImsdzIKXrz2xrUxh9Sf0wRj4pqTquFzfj84JdnNrC
        enHU1i72+MY2mDPjMpLNJt3BloxtRY1Xnwh0859u2X49iID79qpBoQk95E+FWBEO
        o53Ayv8FbA2H/j19polIQxiFBiw/8ogVIXTrD+e3IrI5e2SzZLXZn1SaqPiqhrpT
        6MrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1699463418; x=1699549818; bh=5Q6Rk+qzMpMI2
        3pOp3I8TlmgYyCmchkLsFD/CkDi2mw=; b=NKn3/MIMQ3Rnjm54WfE83DqAwKBK2
        hplEw1Zsln9YKY/ZWiSFy0CcN0wh9u4YfTXhg7bxgUnyy50JS7YbOxEVCX27W66v
        2DtcCXXIx/TdFs1ZOnaeUX9v198NlEGUphmLT7rMmetAI1i3kloyh43awROxkFsc
        nOlpqSo1gyzWl7adDulrFFLP2IuiYIVdFeFvS6bt64abESHd5mAokFox4AXEU7S3
        mqwJhKdGi0s23L8rILgDQvL3uSHzrq7JtKeVv0UqB6ZCVp062S/uoO4N6UC1kqp0
        DsH52V3khxQn8DPs9PExDYToZxG8sVdsicOUYEQPmI/j5mmKLiI2ZgDNQ==
X-ME-Sender: <xms:-cBLZXK7ZfCPlOmysWZ6vvIs8owrujDXy0u-qI72B6TJjrP_LjG08A>
    <xme:-cBLZbJXx7IiK-z-uQvajKTMEp6y5v3kcHhlKF5e_k4k2wk-i6cTMhY1ukpfOVEAb
    z1gxec6kFDCjfsNBi8>
X-ME-Received: <xmr:-cBLZfuaImNAwYFULO8RvuXk9VbIVi7hpm3NjEUGdnXo_HUsgkjqDQ2a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduledgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvfevufffjgfkgggtsehttd
    ertddtredtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceoshhhrhesuggvvhhk
    vghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeevlefggffhheduiedtheejveehtd
    fhtedvhfeludetvdegieekgeeggfdugeeutdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:-cBLZQbrQBspZq4QP7h9HHk-xW-VKFgjaRJY9adYNu_THDJ6sdjKaA>
    <xmx:-cBLZeY5lwcYRKtD3ztuK1vgHb1d_2LgV5j75AIwVMED8ezJEl1TAw>
    <xmx:-cBLZUDnVm6i0ocua75e7TQT0qPpBAMG8__vTlbYGdkbOTBVax674w>
    <xmx:-sBLZTPhYDAUkt2OdMbPG9x44c1cHG_m-vpBWp6HXiUJak7IlNyXkQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Nov 2023 12:10:14 -0500 (EST)
References: <20231107181805.4188397-1-shr@devkernel.io>
 <ZUqRia1Ww0+wNfKr@casper.infradead.org>
User-agent: mu4e 1.10.3; emacs 29.1
From:   Stefan Roesch <shr@devkernel.io>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: Fix for negative counter: nr_file_hugepages
Date:   Wed, 08 Nov 2023 09:09:55 -0800
In-reply-to: <ZUqRia1Ww0+wNfKr@casper.infradead.org>
Message-ID: <87leb8npcd.fsf@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Nov 07, 2023 at 10:18:05AM -0800, Stefan Roesch wrote:
>> +++ b/mm/huge_memory.c
>> @@ -2740,7 +2740,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>>  			if (folio_test_swapbacked(folio)) {
>>  				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
>>  							-nr);
>> -			} else {
>> +			} else if (folio_test_pmd_mappable(folio)) {
>>  				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
>>  							-nr);
>>  				filemap_nr_thps_dec(mapping);
>
> As I said, we also need the folio_test_pmd_mappable() for swapbacked.
> Not because there's currently a problem, but because we don't leave
> landmines for other people to trip over in future!

I'll add it in the next version.
