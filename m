Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5F7CE220
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjJRQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJRQFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:05:18 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84340A4;
        Wed, 18 Oct 2023 09:05:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 953FD3200B98;
        Wed, 18 Oct 2023 12:05:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 18 Oct 2023 12:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1697645113; x=1697731513; bh=OcI7K146pnoJnjGn0F28VwM8IGY10AUfkq0
        k1lyol4c=; b=cvczwF4GhPO/4SKndYOZJK0ARPLjGDCh4ZpHmVkq4iJrzlzCVSd
        QcDqVvuAnbRgW0koEA47wZUKAbR4yBXqZW0dDexDbxZomMMHu/sJyQQnhxN4Rwgz
        F0X08QU/zgMgRLPfcRw+8YztBvfiAP+zTxdFDUo0zcYV9RWNeibxCOdAtlmM7m+R
        kk10g3l+H2BZcFT/HVfLDx/dEKy3P7GRki0hdLspdc55Z2pJYzct+1PL7OSSxCkN
        D1w1Koi4KaOcwUmrnLJ/b2mYgH2Lo/aC+smaD0UPF/GI4dp3Fhswi0BQsXvdwGN6
        MOKRm6ddRyYh5Oh6TQiyh6WZUacPUkjZ9BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1697645113; x=1697731513; bh=OcI7K146pnoJnjGn0F28VwM8IGY10AUfkq0
        k1lyol4c=; b=RyMEzjT6mItxa7fHgAXyqmnzTPecbr6sdllVgRQTzU9aZgaZlkF
        thULbVVaJ892hC3t1B3ZjaScjeEH1MpdUoWnmxzkcj+GZuOlGAwuHXj+SMxmEFmA
        i+s+Rk7AQ0fTTUfEvohoQsKpB++6Lk0W5NDo1oLBJd9Z76/who0qcEd2n9WSCTld
        nkczK5Ri8iMiWAJn8QAd4BR8y0JahbRCnYrLuHn0Fik8urDmaKUPW1dhb3WNphpW
        VnK3T4094pyyGwtElMB6kmL3NAwwkKOlb0YI6FrURr0e91vd2BmE/uHhf5irs//J
        I19Mmf3ILG3yoKuVfWvN3mXjgZ837QbVw+g==
X-ME-Sender: <xms:OAIwZbie5CEjxYuu_lyJNzSQZ1TrS2xNupuDcxiMQh4pUNjWxwxGtA>
    <xme:OAIwZYAAh_5RMr_Z6wvsp_noFlQdItrlA7BGL0CHOCA4AOykmOlyF9YmIp4LtAT7G
    ZYm0EogdR-ZvNXNgsM>
X-ME-Received: <xmr:OAIwZbGOThdgk8va4wwdARD4UoDCQkXZ8-u0sBeQDWzwf60DQb8LZSGmATgRYPsP7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptfgrfhgr
    vghluceuvghimhhsuceorhgrfhgrvghlsegsvghimhhsrdhmvgeqnecuggftrfgrthhtvg
    hrnhepjeeijedvleegudevjeegledtveeifeetjeelieeijeegiefhleelhedtgeduieei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrfh
    grvghlsegsvghimhhsrdhmvg
X-ME-Proxy: <xmx:OAIwZYQztc4SzvSQRq_bEnh0wIRM02_eNBIBtHY-5JoEuv16XvF2lQ>
    <xmx:OAIwZYxLYwFWpfh7D0q7F4uvx6UR3uOOucpq8Lu7Ry7PGnfhefqSkA>
    <xmx:OAIwZe6OHVtmAKjg0sdTIGVmdV3FAau7ATyHIpUpIIS6PkeD97g-8Q>
    <xmx:OQIwZbyqsdr4NUiC601AX8uC9wsFhNHr0L6ag_TOe8CJejSl9iZLrA>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 12:05:10 -0400 (EDT)
Message-ID: <fbb29b88-7a16-4d3d-a96a-0256f6bcfc05@beims.me>
Date:   Wed, 18 Oct 2023 13:05:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron
 eMMC Q2J54A
Content-Language: pt-BR
To:     Ulf Hansson <ulf.hansson@linaro.org>, Bean Huo <beanhuo@iokpp.de>
Cc:     adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20231001194943.658299-1-beanhuo@iokpp.de>
 <CAPDyKFpgPEhVuTbxe5YhYQ0W6907SwJRxSQLB1F2FbVW3zKHxg@mail.gmail.com>
 <254df9b8ca7475ad9dbd3a303c60e1f99eca9c56.camel@iokpp.de>
 <CAPDyKFofJR0xtpmjCQXM7=VzUeN5jQLD2AZYEWocuyCnYNObYw@mail.gmail.com>
From:   Rafael Beims <rafael@beims.me>
In-Reply-To: <CAPDyKFofJR0xtpmjCQXM7=VzUeN5jQLD2AZYEWocuyCnYNObYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 18:04, Ulf Hansson wrote:
> On Tue, 10 Oct 2023 at 17:33, Bean Huo <beanhuo@iokpp.de> wrote:
>> Hi Ulf,
>>
>> thanks for your comments, I didn't quite get your points:
>>
>> On Tue, 2023-10-10 at 16:20 +0200, Ulf Hansson wrote:
>>>> @@ -2381,8 +2381,11 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct
>>>> mmc_queue *mq, struct request *req)
>>>>                           }
>>>>                           ret = mmc_blk_cqe_issue_flush(mq, req);
>>>>                           break;
>>>> -               case REQ_OP_READ:
>>>>                   case REQ_OP_WRITE:
>>>> +                       if (mmc_card_broken_cache_flush(card) &&
>>>> !card->written_flag)
>>> It looks superfluous to me to check mmc_card_broken_cache_flush() and
>>> !card->written_flag. Just set the card->written_flag unconditionally.
>> what did you mean "Just set the card->written_flag unconditionally."?
>> This means I just need to check card->written_flag and set card-
>>> written_flag to true and false in the case
>> MMC_QUIRK_BROKEN_CACHE_FLUSH? or don't need to call
>> mmc_card_broken_cache_flush()?
> I mean skip the checks above and just do the assignment below.
>
>>>> +                               card->written_flag = true;
>>>> +                       fallthrough;
>>>> +               case REQ_OP_READ:
>>>>                           if (host->cqe_enabled)
>>>>                                   ret = mmc_blk_cqe_issue_rw_rq(mq,
>>>> req);
>>>>                           else
>>>> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
>>>> index 4edf9057fa79..b7754a1b8d97 100644
>>>> --- a/drivers/mmc/core/card.h
>>>> +++ b/drivers/mmc/core/card.h
>>>> @@ -280,4 +280,8 @@ static inline int
>>>> mmc_card_broken_sd_cache(const struct mmc_card *c)
>>>>           return c->quirks & MMC_QUIRK_BROKEN_SD_CACHE;
>>>>    }
>>>>
>>>> +static inline int mmc_card_broken_cache_flush(const struct
>>>> mmc_card *c)
>>>> +{
>>>> +       return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
>>>> +}
>>>>    #endif
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>> index 89cd48fcec79..47896c32086e 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -1929,6 +1929,8 @@ static int mmc_init_card(struct mmc_host
>>>> *host, u32 ocr,
>>>>           if (!oldcard)
>>>>                   host->card = card;
>>>>
>>>> +       card->written_flag = false;
>>>> +
>>> How about doing this after a successful flush operation instead? In
>>> other words in _mmc_flush_cache().
>> Here initializes flag and the patch is intenting to eliminate the cache
>> flush command before writing. what do you mean adding in
>> mmc_flush_cache()?
> mmc_init_card() is called while initializing and re-initializing the
> card. So, it certainly works to reset the flag from here.
>
> However, _mmc_flush_cache() is called before powering off the card,
> which then would work similarly to the above, but also gets called for
> REQ_OP_FLUSH. Wouldn't that mean that we may be able to skip some
> unnecessary/troublesome cache flush requests if we would reset the
> flag from  mmc_flush_cache(), rather than from mmc_init_card()?
>
> Kind regards
> Uffe
Forgive me if I'm misunderstanding something, but wouldn't resetting the 
flag on _mmc_flush_cache()
essentially disable cache when the MMC_QUIRK_BROKEN_CACHE_FLUSH is active?

 From what I see, the card->written flag is supposed to stay true until 
we need to reinitialize the
eMMC again, otherwise we would be skipping cache flushes we don't want 
to skip. It's only before
writing for the first time that we want to skip the flush.

Regards,
Rafael
