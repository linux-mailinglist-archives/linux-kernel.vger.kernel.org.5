Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221F5765DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjG0VVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG0VVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:21:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905330E2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=4Dvu0LZOOc2XThdPIMD2N26WmxG9vFW1cG3vhgfwue4=; b=rcweS4GSymP0pvS+VUaw1oNKY+
        aR+1G9ZB+MpAS8DpCpk5IMRNBOyHIsRBIKQJbmHdSnF9UEg5d4S/32wtXtd2DXwzlCknFE8omC+7g
        3jMjhgth59LOWJnDyBI/gLiNAg7QUCfkGVtN/MZ9DjTfkuz17yY+tGW8VjYj1CH9ZHKa4xWCHpeuE
        4VjSABMHPIzsyKzpDww3O5pZ4e3/WJw2GA1bcSzf0T0uLYQPa/ruhucBF+DDm8XZSoDV/66n5T1Tv
        iqPAzdR28yV1uCmk7M5juXbIBfwvfJ3c4UxyTrBq7Go72A/VrtSqNvtY1iXY8T/LY2cOI/5rWuhsc
        pRZKyCVw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qP8Qd-000bNy-0z;
        Thu, 27 Jul 2023 21:21:47 +0000
Message-ID: <772ac95d-9eab-2090-245e-fcc40bd7a5da@infradead.org>
Date:   Thu, 27 Jul 2023 14:21:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/APM: drop the duplicate APM_MINOR_DEV macro
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>, x86@kernel.org
References: <20230726234910.14775-1-rdunlap@infradead.org>
 <c4410ce3-e38d-a935-0e5f-6773cdbfe11b@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c4410ce3-e38d-a935-0e5f-6773cdbfe11b@intel.com>
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

Hi Sohil,

On 7/27/23 13:06, Sohil Mehta wrote:
> s/drop/Drop
> 
> On 7/26/2023 4:49 PM, Randy Dunlap wrote:
>> This source file already includes <linux/miscdevice.h>, which contains
>> the same macro. It doesn't need to be defined here again.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Jiri Kosina <jikos@kernel.org>
>> Cc: x86@kernel.org
>> ---
> 
> I am not sure if a Fixes tag is really needed for a redundant macro
> definition. If at all, shouldn't it be 874bcd00f520c ("apm-emulation:
> move APM_MINOR_DEV to include/linux/miscdevice.h") ?

I don't see any need for this patch to be backported.

Should it be commit 874bcd00f520c?  Maybe. That one certainly
missed moving this macro.

> Either way,
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

Thanks.

-- 
~Randy
