Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC24F75195D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjGMHIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjGMHIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:08:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7D212D;
        Thu, 13 Jul 2023 00:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D17E561A39;
        Thu, 13 Jul 2023 07:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0B4C433C8;
        Thu, 13 Jul 2023 07:07:33 +0000 (UTC)
Message-ID: <37b85c30-7ba4-00ee-3441-26335e16ecf2@xs4all.nl>
Date:   Thu, 13 Jul 2023 09:07:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/28] media: cec: ch7322: drop of_match_ptr for ID table
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
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
 <ce217ae6-6dd5-26ea-2ce7-95d97ef791c4@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <ce217ae6-6dd5-26ea-2ce7-95d97ef791c4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 08:46, Krzysztof Kozlowski wrote:
> On 19/06/2023 16:13, Krzysztof Kozlowski wrote:
>> On 25/05/2023 15:19, Sakari Ailus wrote:
>>> Hi folks,
>>>
>>> On Thu, May 25, 2023 at 03:40:04PM +0300, Sakari Ailus wrote:
>>>> Hi Hans,
>>>>
>>>> On Sat, May 13, 2023 at 11:57:33AM +0200, Hans Verkuil wrote:
>>>>> On 12/05/2023 18:35, Krzysztof Kozlowski wrote:
>>>>>> On 12/03/2023 14:12, Krzysztof Kozlowski wrote:
>>>>>>> The driver can match only via the DT table so the table should be always
>>>>>>> used and the of_match_ptr does not have any sense (this also allows ACPI
>>>>>>> matching via PRP0001, even though it might not be relevant here).
>>>>>>>
>>>>>>>   drivers/media/cec/i2c/ch7322.c:583:34: error: ‘ch7322_of_match’ defined but not used [-Werror=unused-const-variable=]
>>>>>>>
>>>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>>> ---
>>>>>>
>>>>>> Hans, Sakari,
>>>>>>
>>>>>> Can you pick up the patchset? There was positive feedback:
>>>>>> https://patchwork.linuxtv.org/project/linux-media/patch/20230312131318.351173-1-krzysztof.kozlowski@linaro.org/
>>>>>>
>>>>>> but it seems it was not applied.
>>>>>
>>>>> I see it is delegated to Sakari in patchwork and marked Under Review, but I don't
>>>>> see a corresponding pull request for this series.
>>>>>
>>>>> Sakari, did something go wrong?
>>>>
>>>> I spotted this as Hans notified me in IRC, I wasn't cc'd. Apologies for
>>>> this --- I intended to take these but I think I must have missed something
>>>> important in the process. I'll take them now.
>>>>
>>>> Thanks.
>>>
>>> This no longer applied cleanly. Mostly there was fuzz near .of_match_table
>>> changes as probe_new (and remove_new?) changes have been recently merged.
>>> There were other issues as well, I marked a few patches in the set "not
>>> applicable" as other patches had already done equivalent changes earlier.
>>>
>>> There were substance-changing changes in the 20th patch, replied to the
>>> disuccsion there.
>>>
>>> I've pushed the result here and intend to send PR to Mauro soon if there
>>> are no issues:
>>>
>>> <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=of-match-ptr>
>>
>> One month later, I still don't see this set in the linux-next.  What's
>> happening here?
>>
> 
> I don't think this was merged in v6.5-rc1. It's not in linux-next,
> either. Another month passed...

I'm really hopeful it will be merged very soon. As you may have noticed (!) we
have problems with maintaining the media subsystem (too many patches, not enough
maintainers). We had a meeting about that a few weeks ago and are working on
it.

The core problem for this particular series was that the PR containing this series
was posted much too late (as in three months too late!), and it came in too late
for 6.5.

Regards,

	Hans
