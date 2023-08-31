Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1389478E934
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbjHaJSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbjHaJSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:18:48 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E194CF7;
        Thu, 31 Aug 2023 02:18:41 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qbdp1-0004V0-9q; Thu, 31 Aug 2023 11:18:39 +0200
Message-ID: <8666bff5-e9ba-f472-d44f-82bdff35eecd@leemhuis.info>
Date:   Thu, 31 Aug 2023 11:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Linux Regressions <regressions@lists.linux.dev>
Cc:     Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
 <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
 <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
 <03daca5c-e468-8889-4dc2-e625a664d571@alliedtelesis.co.nz>
 <ec5245bd-3103-f0c7-d3ef-85aabb4d4712@alliedtelesis.co.nz>
 <ZH6TIjXeXJVMvSKa@debian.me> <2023060606-unlatch-yiddish-a45f@gregkh>
 <ac5b76af-87dc-b04d-6035-8eda8ba5ed12@kunbus.com>
 <2023060736-immodest-doormat-f957@gregkh>
 <2d7ed7bb-38ba-8840-6629-d210937b8513@leemhuis.info>
In-Reply-To: <2d7ed7bb-38ba-8840-6629-d210937b8513@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693473521;0f0897b6;
X-HE-SMSGID: 1qbdp1-0004V0-9q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 20.06.23 14:41, Linux regression tracking #update (Thorsten Leemhuis)
wrote:
> On 07.06.23 19:49, Greg KH wrote:
>> On Wed, Jun 07, 2023 at 05:47:57PM +0200, Lino Sanfilippo wrote:
>>> On 06.06.23 08:45, Greg KH wrote:
>>>>>
>>>>> Lino, it looks like this regression is caused by (backported) commit of yours.
>>>>> Would you like to take a look on it?
> 
>>>>> Anyway, telling regzbot:
>>>>>
>>>>> #regzbot introduced: 51162b05a44cb5
>>>>
>>>> There's some tpm backports to 5.15.y that were suspect and I'll look
>>>> into reverting them and see if this was one of the ones that was on that
>>>> list.  Give me a few days...
>>>
>>> Could you please consider to apply (mainline) commit 0c7e66e5fd69 ("tpm, tpm_tis: Request threaded
>>> interrupt handler") to 5.15.y?
>>>
>>> As Chris confirmed it fixes the regression caused by 51162b05a44cb5 ("tpm, tpm_tis: Claim locality
>>> before writing interrupt registers").
>>>
>>> Commit 0c7e66e5fd69 is also needed for 5.10.y, 6.1.y and 6.3.y.
>>
>> Now queued up, thanks.
> 
> #regzbot fix: 0c7e66e5fd69
> #regzbot ignore-activity

Brown paperback fix: should have used a stable commit id. Sory for the noise

#regzbot fix: 4c3dda6b7cfd73fe818e424fe89ea19674ddb
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
