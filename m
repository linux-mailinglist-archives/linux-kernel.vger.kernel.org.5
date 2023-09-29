Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1D67B33F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjI2NpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjI2NpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:45:13 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E5B1A8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:45:11 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qmDnq-0008DL-36; Fri, 29 Sep 2023 15:45:10 +0200
Message-ID: <dc5e2e6b-f162-454a-b1f8-816c0d62401d@leemhuis.info>
Date:   Fri, 29 Sep 2023 15:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Panic in gen8_ggtt_insert_entries() with v6.5
Content-Language: en-US, de-DE
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <4857570.31r3eYUQgx@natalenko.name> <ZQmrR7FVKRdVP53q@debian.me>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZQmrR7FVKRdVP53q@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695995111;c4e272fe;
X-HE-SMSGID: 1qmDnq-0008DL-36
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.23 16:08, Bagas Sanjaya wrote:
> On Sat, Sep 02, 2023 at 06:14:12PM +0200, Oleksandr Natalenko wrote:
>>
>> Since v6.5 kernel the following HW:
>>
>> * Lenovo T460s laptop with Skylake GT2 [HD Graphics 520] (rev 07)
>> * Lenovo T490s laptop with WhiskeyLake-U GT2 [UHD Graphics 620] (rev 02)
> 
> #regzbot ^introduced: 0b62af28f249b9
> #regzbot title: gen8_ggtt_insert_entries() panic on Lenovo T14s (Tiger Lake) due to folio_batch() on shmem_sg_free_table()
> #regzbot link: https://gitlab.freedesktop.org/drm/intel/-/issues/9256

#regzbot fix: i915: Limit the length of an sg list to the requested length
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


