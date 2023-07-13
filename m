Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0093751906
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjGMGrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjGMGrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:47:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5641998
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:47:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso2581345e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689230822; x=1691822822;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDXRZ/E9io/51ukbLFISpRHZSMAt3CAsusimpt3aOJ0=;
        b=Y2TgwIcpW0GqU2VbKjQAsG2KFmUQpWcwvXEXNuJ6lsWeayFiZTSrj4IfIO8+EYOCnK
         Gs4WcbzE1N9+9N+NWfSBBg6lXMqgPqM/ozQXThnRdqmJxeeSYBRR9ZOhCfXjK1/ghD/C
         2jIVuUHEKaFCH/bOzsQ6UPnvI9+ulKSXqSts/H0HyXZVcw6Jp03vv3oryA2uheQmnjee
         4Wc9UkRZRCyyu3j41EcLtEtdMBtli0zmlF3xeIm1GV+mOLW1zNQGSeayCsr74Zkckh1N
         h1FueLXrFBmE0SxjRIR8ZeG2h86TnAHvk3hwcA+ZUSaULVRORUuPbVWTClnVbgHMxsnt
         OOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689230822; x=1691822822;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDXRZ/E9io/51ukbLFISpRHZSMAt3CAsusimpt3aOJ0=;
        b=YuxpY8n83gJdVOFp0RQ0xmbadTci5C0OBUmxDcT5y45vj2ggs6A1d9lfI/y1qgcFKd
         81pKlyC00nhjBK7DzmxSmzvZtHPsixQiI8g5BKzE7KmHoyBVqjrJNrtJmOBsfa3GfKKw
         BpbJocohntsBDdFnzY3YJN05kP5z/20V+WVx4XKCJPjue+S7Og12QhNDjKN2S8FdB8k2
         L11zpPOezS2lHXhV/Oz+5MMiVKIfJvP8WLXI7xeg+U+Qn7mC0f2s7DG8M48SKSWF3Yrb
         gC6eGmyYE52h1Bbsi9mOkSDQBPbm/kXl5xgzLEQj44+ZCtDb6XApLEtizdbMvxaKrkuc
         RsTg==
X-Gm-Message-State: ABy/qLa99yB9YIOmT25LXvIqCZaJUIFzqOhLtGGOTNUT1n3hTNxY66ug
        kFAJfrHLpgYca7FIJRyZsNmQVw==
X-Google-Smtp-Source: APBJJlH81v8zuibmeCPcWRJ4UoBAP0+rpVBJJvKoujWGteihPBYQ8w1aAtLN/pbTLVkcmOj/G6M4mA==
X-Received: by 2002:a5d:42cb:0:b0:311:142d:5d97 with SMTP id t11-20020a5d42cb000000b00311142d5d97mr604664wrr.31.1689230822204;
        Wed, 12 Jul 2023 23:47:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i16-20020adffdd0000000b0030fb4b55c13sm7005237wrs.96.2023.07.12.23.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 23:47:01 -0700 (PDT)
Message-ID: <ce217ae6-6dd5-26ea-2ce7-95d97ef791c4@linaro.org>
Date:   Thu, 13 Jul 2023 08:46:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/28] media: cec: ch7322: drop of_match_ptr for ID table
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sakari Ailus <sakari.ailus@iki.fi>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Joe Tessler <jrt@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <98a77653-ec58-56c4-9893-3b424f67c87e@linaro.org>
 <5afcec8b-b8f6-35b0-278a-5de185e4a7a2@xs4all.nl>
 <ZG9XJCD98VWjGjTN@valkosipuli.retiisi.eu>
 <ZG9ger4WE2VWoVEF@valkosipuli.retiisi.eu>
 <158425ec-86e8-ca3e-eed8-e14b37c42730@linaro.org>
In-Reply-To: <158425ec-86e8-ca3e-eed8-e14b37c42730@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 16:13, Krzysztof Kozlowski wrote:
> On 25/05/2023 15:19, Sakari Ailus wrote:
>> Hi folks,
>>
>> On Thu, May 25, 2023 at 03:40:04PM +0300, Sakari Ailus wrote:
>>> Hi Hans,
>>>
>>> On Sat, May 13, 2023 at 11:57:33AM +0200, Hans Verkuil wrote:
>>>> On 12/05/2023 18:35, Krzysztof Kozlowski wrote:
>>>>> On 12/03/2023 14:12, Krzysztof Kozlowski wrote:
>>>>>> The driver can match only via the DT table so the table should be always
>>>>>> used and the of_match_ptr does not have any sense (this also allows ACPI
>>>>>> matching via PRP0001, even though it might not be relevant here).
>>>>>>
>>>>>>   drivers/media/cec/i2c/ch7322.c:583:34: error: ‘ch7322_of_match’ defined but not used [-Werror=unused-const-variable=]
>>>>>>
>>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>> ---
>>>>>
>>>>> Hans, Sakari,
>>>>>
>>>>> Can you pick up the patchset? There was positive feedback:
>>>>> https://patchwork.linuxtv.org/project/linux-media/patch/20230312131318.351173-1-krzysztof.kozlowski@linaro.org/
>>>>>
>>>>> but it seems it was not applied.
>>>>
>>>> I see it is delegated to Sakari in patchwork and marked Under Review, but I don't
>>>> see a corresponding pull request for this series.
>>>>
>>>> Sakari, did something go wrong?
>>>
>>> I spotted this as Hans notified me in IRC, I wasn't cc'd. Apologies for
>>> this --- I intended to take these but I think I must have missed something
>>> important in the process. I'll take them now.
>>>
>>> Thanks.
>>
>> This no longer applied cleanly. Mostly there was fuzz near .of_match_table
>> changes as probe_new (and remove_new?) changes have been recently merged.
>> There were other issues as well, I marked a few patches in the set "not
>> applicable" as other patches had already done equivalent changes earlier.
>>
>> There were substance-changing changes in the 20th patch, replied to the
>> disuccsion there.
>>
>> I've pushed the result here and intend to send PR to Mauro soon if there
>> are no issues:
>>
>> <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=of-match-ptr>
> 
> One month later, I still don't see this set in the linux-next.  What's
> happening here?
> 

I don't think this was merged in v6.5-rc1. It's not in linux-next,
either. Another month passed...

Best regards,
Krzysztof

