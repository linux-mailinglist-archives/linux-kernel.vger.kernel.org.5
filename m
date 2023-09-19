Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE467A5864
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 06:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjISEax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 00:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjISEau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:30:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FBD8F;
        Mon, 18 Sep 2023 21:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6YzD0TEG0mrsWINbIwMn5VbOm71/O1g1GNk3cGYRBi8=; b=tscVhqXLa7uTfJJ+WJfEuOd7Ly
        3lNcFq0KpHc+un1+SzHQcptA/V0V5QQykMLpKvdu273vth3F8OgR25OzbQqOfIXTjkg/AER2MQ/Qf
        YDQGh3mtEEOQfTUkW4Tdxq45OWaUF3jvYTJ4uxaOIbVtILzKBZdX/6g99V1+ClWZFw8a8MoWDKqZF
        SqMGCeySgGNGQ1ZFjBl7MKPOnqp8oFwhEwPrQcOWYNP9DK5JiA5PweKkmtiKQcBaw3WNBklwna2Tj
        ugxdtX7T2HFbCwDpjopvsdm/jobRN8hQ5n5uleeWPt+iXTaCiaksjxIsdwyi5xBI18Qvr0k0XKyjJ
        /ZF/bDvw==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiSNo-00GwNF-2Q;
        Tue, 19 Sep 2023 04:30:45 +0000
Message-ID: <6d36de0a-5ab4-4862-abcc-c7946e6f80b1@infradead.org>
Date:   Mon, 18 Sep 2023 21:30:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-doc: add a warning prefix option
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20230919023415.4744-1-rdunlap@infradead.org>
 <ZQke26HX9Am3k2sh@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZQke26HX9Am3k2sh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/23 21:08, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 07:34:15PM -0700, Randy Dunlap wrote:
>> Add an environment variable ("KDOC_LABEL") for use by scripts/kernel-doc.
>> This variable instructs kernel-doc to label each "warning:" line with
>> a prefix of the KDOC_LABEL value. E.g., using
>>   KDOC_LABEL="doc" ./scripts/kernel-doc -none -Wall kernel/panic.c
>> causes kernel-doc warnings to be emitted as "doc warning:", like this:
>>   kernel/panic.c:497: doc warning: No description found for return value of 'print_tainted'
>>
>> This can aid either in finding or eliminating kernel-doc warnings.
> 
> I worry this will lead to people saying "Oh, it's just a doc warning,
> so I ignored it".

Yeah, that's a fair comment.

I'll find some other way to do what I want to do.

Thanks.
-- 
~Randy
