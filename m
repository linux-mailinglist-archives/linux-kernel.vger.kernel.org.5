Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624867ABA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjIVUF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjIVUF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:05:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443BB19D;
        Fri, 22 Sep 2023 13:05:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31BFC433C7;
        Fri, 22 Sep 2023 20:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695413147;
        bh=enJ0a4l3BE0ZdLon+dFG8Kc9jkMHxADxQvNfxaqNXMw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kiXM0287PPQdGa5bf0h4KRkI3Lkad5vpLAI17WtUPjhwPwb14rW+qiyUSHHQPPwhs
         qSbatTXAbEpqSgl5MKmO00NTvE8TGgrMXAFuLTnZnPLF0Yrz1d+J4NWeIfPUanzO5e
         T5iWhVMpxBSj7pKeuCuHI7w79EdripfbxhTBIRP6f7IicL766JUMaTgGd12uBy+EtO
         lT54AiQM/yImBjxzuTASYLD8VptwnRZhauIdxnl8mWt5NifTHRzAhe/lmGHvtRx5A7
         z110J/Ak1gHj8zWPa3KtJdlEzRzFzlfYbfRRe5qnkJogfxMWqiQeRsu1RQhfEzFMDp
         7bJB7APq8QNuw==
Message-ID: <55ab5197-51ba-87bf-e24d-44ebc45f13d7@kernel.org>
Date:   Fri, 22 Sep 2023 13:05:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC] ata: libata: increase PMP SRST timeout to 10s
Content-Language: en-US
To:     Matthias Schiffer <mschiffer@universe-factory.net>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <dcbe606ac716e01f103f8aa62f0201cdb8f3efa0.1695394865.git.mschiffer@universe-factory.net>
 <6309e45e-b1f7-0167-ff54-f1a86437a910@kernel.org>
 <f52aab50-fe43-4336-b214-d81185a67ac4@universe-factory.net>
 <1ed7c4dc-f026-4ac5-2011-afcdb1e962b0@kernel.org>
 <ace8c25c-cc62-4719-bcd1-8020881ed178@universe-factory.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ace8c25c-cc62-4719-bcd1-8020881ed178@universe-factory.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/09/22 12:41, Matthias Schiffer wrote:
>>> Even with the latest series applied, I still need my
>>> ATA_TMOUT_PMP_SRST_WAIT change to avoid the "softreset failed (1st FIS
>>> failed)" message (and get "softreset failed (device not ready)" instead).
>>
>> OK. Thank you for testing.
>> For increasing the timeout, please send a proper patch. I will queue it.
>>
>>
> 
> Will do. Do you see any downsides to the increased timeout? Otherwise, I'd 
> simply add a Fixes: tag for the last time the timeout was touched in 
> e7d3ef13d52a126438f687a1a32da65ff926ed57.

No, I do not see any downside. Most drives do not need such long timeout for
replying to a reset, so it should not be an issue. Increasing to 10s should be
OK. But please be sure to mention in the commit message the adapter and drive
you have that need this, so that we keep a trace of it.


-- 
Damien Le Moal
Western Digital Research

