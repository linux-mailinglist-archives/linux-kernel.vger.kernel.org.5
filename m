Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02AF7660F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjG1A6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjG1A6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:58:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF88430D4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=9DnA3+DnfMPwXVmaW7kvsfkA65ovN7mYmtX3Ty8xBsA=; b=aQRv3PzAJtLoHog0T3kdjF1yE+
        tI1WD8HvmahXZh/Yr8u8q4fOTb7FtBOIRWW6OtM7S770MZ7mU4h/W3MLr/QwqQbKWygZox4GyIhB8
        aWczJzO0dRNHuxZnB0oHXVDGXrDWD/CAjyUhcnM9QX8G8Yxjj/Zx3saxTGaJLCe7rxm5O81VRY0E9
        IYhKSOq7wsVSg0aTwNbUtgcUMBka0evShk4VDeyNwL6DFNllq1+tmbJ4F243z9sXG1Ax+HP4V0xPW
        rsihU+xKei/IS5XvPHwDl072li2keqVRawotiIDISzELggrYxwcvaPZS72hNJ2bNAzHeq8BkHetmb
        63Y7Q9+Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qPBoe-0015gC-1N;
        Fri, 28 Jul 2023 00:58:48 +0000
Message-ID: <a510e9bd-ea17-dc43-9985-0c7fcec4b245@infradead.org>
Date:   Thu, 27 Jul 2023 17:58:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/APM: drop the duplicate APM_MINOR_DEV macro
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Sohil Mehta <sohil.mehta@intel.com>, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>, x86@kernel.org
References: <20230726234910.14775-1-rdunlap@infradead.org>
 <c4410ce3-e38d-a935-0e5f-6773cdbfe11b@intel.com>
 <772ac95d-9eab-2090-245e-fcc40bd7a5da@infradead.org>
 <6ba4a23c-3b4b-eb7f-0ecb-3b7bf5c4406e@intel.com>
 <de55c767-1bc3-3bd5-84c3-1a636373f3b0@infradead.org>
In-Reply-To: <de55c767-1bc3-3bd5-84c3-1a636373f3b0@infradead.org>
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



On 7/27/23 15:41, Randy Dunlap wrote:
> 
> 
> On 7/27/23 15:05, Sohil Mehta wrote:
>> On 7/27/2023 2:21 PM, Randy Dunlap wrote:
>>> On 7/27/23 13:06, Sohil Mehta wrote:
>>>> I am not sure if a Fixes tag is really needed for a redundant macro
>>>> definition. If at all, shouldn't it be 874bcd00f520c ("apm-emulation:
>>>> move APM_MINOR_DEV to include/linux/miscdevice.h") ?
>>>
>>> I don't see any need for this patch to be backported.
>>>
>>> Should it be commit 874bcd00f520c?  Maybe. That one certainly
>>> missed moving this macro.
>>>
>>
>> Also, applying this patch anytime before 874bcd00f520c will cause a
>> compilation issue unless 874bcd00f520c is applied as well.
> 
> Yeah, that's a good point. Thanks.
> 

I'll send a v2 with the Fixes: tag changed.
Thanks.

-- 
~Randy
