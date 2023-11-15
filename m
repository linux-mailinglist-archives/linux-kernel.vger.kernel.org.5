Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000FE7EBC36
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjKODkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbjKODku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:40:50 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EBA26C5;
        Tue, 14 Nov 2023 19:40:46 -0800 (PST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 93BC8609AA670;
        Wed, 15 Nov 2023 11:40:30 +0800 (CST)
Message-ID: <2c0915ab-c9ed-87d3-5049-7e03f3994e4b@nfschina.com>
Date:   Wed, 15 Nov 2023 11:40:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH wireless-next] wlcore: debugfs: add an error code check in
 beacon_filtering_write
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <878r71vots.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/13 20:07, Kalle Valo wrote:
> Su Hui <suhui@nfschina.com> writes:
>
>> On 2023/11/13 14:16, Kalle Valo wrote:
>>
>>> Su Hui <suhui@nfschina.com> writes:
>>>
>>>> wl1271_acx_beacon_filter_opt() return error code if failed, add a check
>>>> for this is better and safer.
>>>>
>>>> Signed-off-by: Su Hui <suhui@nfschina.com>
>>> How did you test this?
>> Only compile test.
> If you have only compile tested please document that clearly in the
> commit message.
Sorry for the unclear commit message.
>> Clang static checker complains about this code that  value stored to
>> 'ret' is never read.
> This would be good to also have in the commit message.
I will add this to v2 patch if pass a test  in a real device.
>> And most of the caller check  the error code of
>> wl1271_acx_beacon_filter_opt().
> This might still break something so I would prefer to test this in a
> real device before taking it.
This might take some time, I try to find a wlcore device to test this.
Thanks for your reply!

Su Hui


