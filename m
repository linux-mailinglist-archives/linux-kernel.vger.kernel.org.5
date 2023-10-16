Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39717CA196
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjJPI3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjJPI3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:29:19 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7FFDE;
        Mon, 16 Oct 2023 01:29:16 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qsIyQ-0005VB-FA; Mon, 16 Oct 2023 10:29:14 +0200
Message-ID: <3e1f079f-a0a7-43b3-96db-24c2e04d5ff8@leemhuis.info>
Date:   Mon, 16 Oct 2023 10:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com>
 <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <7e9735bf-c42b-4f03-8645-8cdbf87a75f3@leemhuis.info>
In-Reply-To: <7e9735bf-c42b-4f03-8645-8cdbf87a75f3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697444956;348b960e;
X-HE-SMSGID: 1qsIyQ-0005VB-FA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.09.23 14:27, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 29.08.23 18:42, Geert Uytterhoeven wrote:
>>
>> On Fri, 18 Aug 2023, Liam R. Howlett wrote:
>>> The current implementation of append may cause duplicate data and/or
>>> incorrect ranges to be returned to a reader during an update.  Although
>>> this has not been reported or seen, disable the append write operation
>>> while the tree is in rcu mode out of an abundance of caution.
>>>
>>> During the analysis of the mas_next_slot() the following was
>>> artificially created by separating the writer and reader code:
>> [...]
>> Thanks for your patch, which is now commit cfeb6ae8bcb96ccf
>> ("maple_tree: disable mas_wr_append() when other readers are
>> possible") in v6.5, and is being backported to stable.
>>
>> On Renesas RZ/A1 and RZ/A2 (single-core Cortex-A9), this causes the
>> following warning:
>>> […]
>> Reverting this commit fixes the issue.

#regzbot fix: cff9b2332ab762
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
