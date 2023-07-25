Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8841776091A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGYFRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGYFRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:17:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B55E116;
        Mon, 24 Jul 2023 22:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=coeqR40KGzIzC8OscsyYtEGf1VYewayeiAdRV5OXk4s=; b=OMWD1+xoe7xjBvyF7wDIfEDaRD
        bEwQSxA5L7B+Jhv6dI/iVBgxHgl5sqaewnXC7/KXFwwvS39tqgrPKqCnEIUHL/gerSXj0HKXz0IJE
        8w/zZUHLahb35SbEnKWdsJxBjBvFpdUVXn9PDSB+Mb7K4rRh7dRgUid0XW2zeTwx3XbiTzfNlpMx2
        0nRwNb7J0aKoZvNTVjKCX2lNtDXHLdkj9tjRgUlE/FEd6VOM0HVaJqRySchFhbsFPTpUXojDwams5
        3mTxROl/oEzYRGcTo1a8QSLosBbCuQEHEvhXxh91eq8kjuyeuZlk8JwRROGcqIGZa4XmzUK8kqJ2p
        2Yq7by2w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOAPe-006Hsm-1S;
        Tue, 25 Jul 2023 05:16:46 +0000
Message-ID: <e41096bb-1911-3d91-119a-8cdf55135673@infradead.org>
Date:   Mon, 24 Jul 2023 22:16:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: build warning after merge of the mm-hotfixes tree
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230725135546.28334fe4@canb.auug.org.au>
 <3084e97c-3a7d-ace8-2e9c-31642fd663df@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <3084e97c-3a7d-ace8-2e9c-31642fd663df@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/23 21:10, Hugh Dickins wrote:
> On Tue, 25 Jul 2023, Stephen Rothwell wrote:
> 
>> Hi all,
>>
>> After merging the mm-hotfixes tree, today's linux-next build (htmldocs)
>> produced this warning:
>>
>> Documentation/filesystems/tmpfs.rst:116: ERROR: Malformed table.
>> Text in column margin in table line 4.
>>
>> ===========  ==============================================================
>> huge=never   Do not allocate huge pages.  This is the default.
>> huge=always  Attempt to allocate huge page every time a new page is needed.
>> huge=within_size Only allocate huge page if it will be fully within i_size.
>>              Also respect madvise(2) hints.
>> huge=advise  Only allocate huge page if requested with madvise(2).
>> ===========  ==============================================================
>>
>> Introduced by commit
>>
>>   a0ebb5aa2de3 ("tmpfs: fix Documentation of noswap and huge mount options")
> 
> Sorry about that, Stephen: thanks for the report.
> 
> Randy, you're always my goto guy for how to get these Doc things right,
> I hope you don't mind.  I just write the text as I want it to appear,
> then get caught out by unfamiliar rules.
> 
> Please suggest a fixup to the fix patch if you can - thanks!

Hi Hugh,

I have a patch ready. I'll send it in a few minutes.

-- 
~Randy
