Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744A575201B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjGMLjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjGMLjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:39:01 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ADA2268A;
        Thu, 13 Jul 2023 04:38:58 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Jul 2023 20:38:56 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id D5DAD21A65F9;
        Thu, 13 Jul 2023 20:38:56 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Thu, 13 Jul 2023 20:38:56 +0900
Received: from [10.212.156.24] (unknown [10.212.156.24])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 759B1174815;
        Thu, 13 Jul 2023 20:38:56 +0900 (JST)
Message-ID: <1d924f9a-54b7-e70b-304c-284e5bf90b59@socionext.com>
Date:   Thu, 13 Jul 2023 20:38:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] mmc: sdhci-f-sdh30: Replace with sdhci_pltfm
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230630004533.26644-1-hayashi.kunihiko@socionext.com>
 <CAPDyKFqJU3VwXJJDQPWvNBDz1+gSjYxFJBST3s8mpJoh7-c9-Q@mail.gmail.com>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <CAPDyKFqJU3VwXJJDQPWvNBDz1+gSjYxFJBST3s8mpJoh7-c9-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On 2023/07/13 20:06, Ulf Hansson wrote:
> On Fri, 30 Jun 2023 at 02:45, Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> Even if sdhci_pltfm_pmops is specified for PM, this driver doesn't apply
>> sdhci_pltfm, so the structure is not correctly referenced in PM functions.
>> This applies sdhci_pltfm to this driver to fix this issue.
>>
>> - Call sdhci_pltfm_init() instead of sdhci_alloc_host() and
>>    other functions that covered by sdhci_pltfm.
>> - Move ops and quirks to sdhci_pltfm_data
>> - Replace sdhci_priv() with own private function sdhci_f_sdh30_priv().
>>
>> Fixes: 87a507459f49 ("mmc: sdhci: host: add new f_sdh30")
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Applied for next, thanks!
> 
> Or maybe this should go for fixes and have a stable tag too?

Thank you for applying!
I think this should be applied to the stable branch if possible.

> 
> Kind regards
> Uffe

Thank you,

---
Best Regards
Kunihiko Hayashi
