Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51F78C3EF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjH2MMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbjH2MMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:12:07 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35405E57;
        Tue, 29 Aug 2023 05:11:41 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qaxZL-0005te-66; Tue, 29 Aug 2023 14:11:39 +0200
Message-ID: <e4f32537-bec5-3d9e-11b1-0aa79fa10103@leemhuis.info>
Date:   Tue, 29 Aug 2023 14:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: UBSAN: index 1 is out of range for type
 'xen_netif_rx_sring_entry [1]'
Content-Language: en-US, de-DE
To:     Linux Regressions <regressions@lists.linux.dev>
Cc:     Linux Xen <xen-devel@lists.xenproject.org>,
        Linux BPF <bpf@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7e3841ce-011d-5ba6-9dae-7b14e07b5c4b@gmail.com>
 <20230723000657.GA878540@dev-arch.thelio-3990X>
 <e208365f-dbc6-06d1-ccc9-3b2e945a0bff@suse.com>
 <73019154-6a34-f714-96b5-b43038569feb@suse.com>
 <202307252204.09AC0089@keescook>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <202307252204.09AC0089@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693311101;bafe2bc0;
X-HE-SMSGID: 1qaxZL-0005te-66
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 26.07.23 07:06, Kees Cook wrote:
> On Tue, Jul 25, 2023 at 03:34:26PM +0200, Juergen Gross wrote:
>> On 25.07.23 15:24, Juergen Gross wrote:
>>> On 23.07.23 02:06, Nathan Chancellor wrote:
>>>> On Sat, Jul 22, 2023 at 07:21:05AM +0700, Bagas Sanjaya wrote:
>>>>>
>>>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>>>>
>>>>>> I rebuild today latest version from mainline repo.
>>>>>> And i notice issue regarding xen-netfront.c.
> [...]
>> Oh, in fact there is a way in Xen to do that correctly. It schould be enough to
>> use ring[XEN_FLEX_ARRAY_DIM], which will do the right thing.
>>
>> So I'll write a Xen patch first, after all.
> 
> Perfect! I went to go look, and yes, this is good:

#regzbot resolve: will be dealt with on the xen side
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

