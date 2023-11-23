Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6897F55EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjKWBfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjKWBe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:34:57 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A4B0411F;
        Wed, 22 Nov 2023 17:35:02 -0800 (PST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 93A156027E065;
        Thu, 23 Nov 2023 09:34:58 +0800 (CST)
Message-ID: <79634dda-fd3b-5a93-9435-d0a1474b847f@nfschina.com>
Date:   Thu, 23 Nov 2023 09:34:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH wireless-next 2/2] rtlwifi: rtl8821ae: phy: fix an
 undefined bitwise shift behavior
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "lizetao1@huawei.com" <lizetao1@huawei.com>,
        "linville@tuxdriver.com" <linville@tuxdriver.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <99ec66d717b249e781f9316cbd689521@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/23 08:41, Ping-Ke Shih wrote:
>
>> -----Original Message-----
>> From: Dan Carpenter <dan.carpenter@linaro.org>
>> Sent: Wednesday, November 22, 2023 9:02 PM
>> To: Su Hui <suhui@nfschina.com>
>> Cc: Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org; nathan@kernel.org; ndesaulniers@google.com;
>> trix@redhat.com; lizetao1@huawei.com; linville@tuxdriver.com; Larry.Finger@lwfinger.net;
>> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; llvm@lists.linux.dev;
>> kernel-janitors@vger.kernel.org
>> Subject: Re: [PATCH wireless-next 2/2] rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
>>
>> Perhaps, a better way to silence the warning is to just change
>> _rtl8821ae_phy_calculate_bit_shift() to not return 32 bits?  Do we
>> really ever pass bitmask 0?  No idea...
>>
> I think the bitmask should not 0, so just replace _rtl8821ae_phy_calculate_bit_shift()
> by __ffs(bitmask). To be safer, callers can check bitmask is not 0 before calling.
Thanks for your great suggestion!
I will send v2 soon.

Su Hui

