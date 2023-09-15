Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE467A1B60
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjIOJyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjIOJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:54:33 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 46ED52D72;
        Fri, 15 Sep 2023 02:53:18 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 5B5BF60AA49FE;
        Fri, 15 Sep 2023 17:53:07 +0800 (CST)
Message-ID: <bc26c08d-5bcd-59e0-2262-c6114cbe5afc@nfschina.com>
Date:   Fri, 15 Sep 2023 17:53:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH wireless-next 6/9] wifi: ath10k: Remove unnecessary
 (void*) conversions
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>, kvalo@kernel.org,
        toke@toke.dk
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
In-Reply-To: <7855cee1-c554-40b7-885f-d7f8d3d90979@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/14 22:48, Jeff Johnson wrote:
> On 9/13/2023 9:05 PM, Wu Yunchuan wrote:
>> No need cast (void*) to (struct htt_rx_ring_setup_ring32 *),
>> (struct htt_rx_ring_setup_ring64 *), (struct ath_softc *)
>> or (struct ath_hw *).
>>
>> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
>> ---
>>   drivers/net/wireless/ath/ath10k/htt_tx.c | 6 ++----
>>   drivers/net/wireless/ath/ath9k/pci.c     | 6 +++---
>
> ath9k change should be in a separate patch since it has a different 
> maintainer than ath10k
>
Hi,

Sorry for this careless mistake, I will send v2 patch next week to fix 
this mistake.
Thanks for your reminder!

Wu Yunchuan

