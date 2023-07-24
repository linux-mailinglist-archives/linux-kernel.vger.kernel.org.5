Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3277176000A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGXTw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGXTwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:52:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6DCDB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=O8V/9suZuV99Dk5Ez4pRncxaWvco+zcCGtlx/y21dmI=; b=ctuWas+eT/vwXpL2A3nwlsgelB
        tghAnvi+h9kAk4lPW9QWB0Za91r8joMEJXhrPCbe7H/9crsjDmxyFC0QGNo3yCkQbilkGhgoY7L7r
        uG/cGfuUtlpbk+3D3kQYKHthGWy15KmUdlHExP9fJH/De5d9XHkb2hDamAG1UdmrZX8sYymuWb/qW
        4xFN4ABtdHYg7bqb9i8JYw/3MXG4P7xvXBNbUxlugx6PQIVUjQqg3iZjde76tL5XpU5Uu8PptKu3b
        1/q5v6qAM2I7lh8v5moGUDZ6JX7HER6ZMBTBWCs3Auc4UEo0yNbCn7C2XDr3iE2aekSnUVEh6SbKJ
        62KchA2g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qO1bS-005KZB-22;
        Mon, 24 Jul 2023 19:52:22 +0000
Message-ID: <020214b5-0c28-4261-618d-c78043b56652@infradead.org>
Date:   Mon, 24 Jul 2023 12:52:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] cpumask: fix typos and kernel-doc warnings in cpumask.h
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20230724023403.24869-1-rdunlap@infradead.org>
 <ZL42qItwNebssuBN@smile.fi.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZL42qItwNebssuBN@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/23 01:30, Andy Shevchenko wrote:
> On Sun, Jul 23, 2023 at 07:34:03PM -0700, Randy Dunlap wrote:
>> Fix some punctuation (plural vs. possessive).
>> Fix some abbreviations (ie. -> i.e., id -> ID).
>>
>> Fix 35 warnings like this:
>> include/linux/cpumask.h:161: warning: No description found for return value of 'cpumask_first'
> 
> I wouldn't explicitly change Returns -> Return, but since the latter is one
> mentioned in the documentation and we have no actual Return section anyway
> (means we need to touch those lines), I'm fine with that.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thank you!
> 
> P.S. For out of curiosity the command line to check this is like
> 
> 	scripts/kernel-doc -v -none -Wall ...
> 
> but I have no idea which one Randy used.

Yes, that's what I used.

Thanks.

-- 
~Randy
