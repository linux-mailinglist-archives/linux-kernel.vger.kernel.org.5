Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B60751FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjGMLTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjGMLTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:19:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8092C198A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:19:43 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJuMG-0002IM-SL; Thu, 13 Jul 2023 13:19:40 +0200
Message-ID: <358822fd-4dca-865d-1330-39897fb16082@leemhuis.info>
Date:   Thu, 13 Jul 2023 13:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use
 pte_offset_kernel()
Content-Language: en-US, de-DE
To:     linux-mm@kvack.org
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <696386a-84f8-b33c-82e5-f865ed6eb39@google.com>
 <42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk>
 <901ae88d-ad0c-4e9d-b199-f1566cc62a00@lucifer.local>
 <c2358f37-ebaa-44d1-b443-ff91bdedc00b@sirena.org.uk>
 <977ddee4-35f0-fcd1-2fd-1c3057e7ea2a@google.com>
 <fbb2b76c-bc5c-4d75-b8cd-37479de688d4@sirena.org.uk>
 <b479b946-f052-eb75-295d-6fa7c2d8ce8e@google.com>
 <591b5253-47f0-440c-84b6-7786ff59667d@sirena.org.uk>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <591b5253-47f0-440c-84b6-7786ff59667d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689247183;b4194be6;
X-HE-SMSGID: 1qJuMG-0002IM-SL
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.23 19:57, Mark Brown wrote:
> On Tue, Jul 11, 2023 at 09:13:18AM -0700, Hugh Dickins wrote:
>> On Tue, 11 Jul 2023, Mark Brown wrote:
>>> On Mon, Jul 10, 2023 at 09:34:42PM -0700, Hugh Dickins wrote:
>>>
>>>> I suppose I should ask you to try reverting this 0d1c81edc61e alone
>>>> from 6.5-rc1: the consistency of your bisection implies that it will
>>>> "fix" the issues, and it is a commit which we could drop.  It makes
>>>> me a little nervous, applying userspace-pagetable validation to kernel
>>>> pagetables, so I don't want to drop it; and it would really be cargo-
>>>> culting to drop it without understanding.  But we could drop it.
>>>
>>> I did look at that, it doesn't revert cleanly by itself. ...
>>
>> Right, that ptep_get() wrapper on the next line came in on top.
>> The patch to revert just 0d1c81edc61e is this:
> 
> Still investigating but I'm pretty convinced this is nothing to do with
> your commit/series and is just common or garden memory corruption that
> just happens to get tickled by your changes.  Sorry for the noise.

In that case:

#regzbot introduced v6.4..v6.5-rc1
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
