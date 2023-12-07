Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189098089A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjLGN6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjLGN6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:58:21 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847B6D5E;
        Thu,  7 Dec 2023 05:58:27 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1rBEtL-0006HO-Pv; Thu, 07 Dec 2023 14:58:15 +0100
Message-ID: <e2d47b6c-3420-4785-8e04-e5f217d09a46@leemhuis.info>
Date:   Thu, 7 Dec 2023 14:58:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: md raid6 oops in 6.6.4 stable
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Genes Lists <lists@sapience.com>, snitzer@kernel.org,
        song@kernel.org, yukuai3@huawei.com, axboe@kernel.dk,
        mpatocka@redhat.com, heinzm@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Bhanu Victor DiCara <00bvd0+linux@gmail.com>,
        Xiao Ni <xni@redhat.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <6e6816dd-2ec5-4bca-9558-60cfde46ef8c@sapience.com>
 <ZXHJEkwIJ5zKTMjV@archie.me>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ZXHJEkwIJ5zKTMjV@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701957507;23c09c83;
X-HE-SMSGID: 1rBEtL-0006HO-Pv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.23 14:30, Bagas Sanjaya wrote:
> On Thu, Dec 07, 2023 at 08:10:04AM -0500, Genes Lists wrote:
>> I have not had chance to git bisect this but since it happened in stable I
>> thought it was important to share sooner than later.
>>
>> One possibly relevant commit between 6.6.3 and 6.6.4 could be:
>>
>>   commit 2c975b0b8b11f1ffb1ed538609e2c89d8abf800e
>>   Author: Song Liu <song@kernel.org>
>>   Date:   Fri Nov 17 15:56:30 2023 -0800
>>
>>     md: fix bi_status reporting in md_end_clone_io
>>
>> log attached shows page_fault_oops.
>> Machine was up for 3 days before crash happened.
> 
> Can you confirm that culprit by bisection?

Bagas, I know you are trying to help, but sorry, I'd say this is not
helpful at all -- any maybe even harmful.

From the quoted texts it's pretty clear that the reporter knows that a
bisection would be helpful, but currently is unable to perform one --
and even states reasons for reporting it without having it bisected. So
your message afaics doesn't bring anything new to the table; and I might
be wrong with that, but I fear some people in a situation like this
might even be offended by a reply like that, as it states something
already obvious.

Ciao, Thorsten

