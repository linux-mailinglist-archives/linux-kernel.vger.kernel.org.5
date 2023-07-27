Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B593765FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjG0Wlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjG0Wlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:41:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5413E1B8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=h+7YtBFH153J0tbx3u/vBGOfFvIqRRlon0VF8DFAosE=; b=RB9LmhOxDRzcs2UoDkLjld8YIK
        GuZFfb+StJ7HVTL/CWE8ytyU4A2Z/cZHlHpV21sZZAA/LgAgX/3BRMwTzOBQyDe22jt1T7XDxKYFJ
        7w337rqyvfqHo/zF5uBtJv3mUP1VSxrjyBE1XPQwtWU0jT2dWgJGy1PaUusQnrPpAlg2dR3q8cnfS
        px0z5bHzpEeJjeA19/3TxWSjYWX/0J9EHUq94r0YysbXdHx6OJZOEMyqCaI6scsZvKvLGo2sGlI5Y
        wQ2CYsm3QuVXO8+8+6axFJa827NRWwWBa3PaSUpac74yBSqWZTdzVfsZRJAj9RycCxR5DIt281QGg
        cWf0nF0g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qP9fq-000ljX-03;
        Thu, 27 Jul 2023 22:41:34 +0000
Message-ID: <de55c767-1bc3-3bd5-84c3-1a636373f3b0@infradead.org>
Date:   Thu, 27 Jul 2023 15:41:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/APM: drop the duplicate APM_MINOR_DEV macro
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>, x86@kernel.org
References: <20230726234910.14775-1-rdunlap@infradead.org>
 <c4410ce3-e38d-a935-0e5f-6773cdbfe11b@intel.com>
 <772ac95d-9eab-2090-245e-fcc40bd7a5da@infradead.org>
 <6ba4a23c-3b4b-eb7f-0ecb-3b7bf5c4406e@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6ba4a23c-3b4b-eb7f-0ecb-3b7bf5c4406e@intel.com>
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



On 7/27/23 15:05, Sohil Mehta wrote:
> On 7/27/2023 2:21 PM, Randy Dunlap wrote:
>> On 7/27/23 13:06, Sohil Mehta wrote:
>>> I am not sure if a Fixes tag is really needed for a redundant macro
>>> definition. If at all, shouldn't it be 874bcd00f520c ("apm-emulation:
>>> move APM_MINOR_DEV to include/linux/miscdevice.h") ?
>>
>> I don't see any need for this patch to be backported.
>>
>> Should it be commit 874bcd00f520c?  Maybe. That one certainly
>> missed moving this macro.
>>
> 
> Also, applying this patch anytime before 874bcd00f520c will cause a
> compilation issue unless 874bcd00f520c is applied as well.

Yeah, that's a good point. Thanks.

-- 
~Randy
