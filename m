Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4BB811A14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378924AbjLMQvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378150AbjLMQvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:51:51 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DCDAC;
        Wed, 13 Dec 2023 08:51:57 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A636B60006;
        Wed, 13 Dec 2023 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1702486316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DO+XQgFKSsBWJhVaHsjNWAi6FsCEUTPXzosA6TLpkG0=;
        b=iYqRh1lE0vFH0qsU/MBWMTVw3nOznRswNPqjqKsuzFOzVOJjA3wKelXxC/ez3kzfJDIokT
        nOcHnJt5czuN/T8cHOgcLc3G7m31L8TfhSWJdHPU4rDq+DzyHsB97pgB7AwmbeQAbOQcxN
        I7ijsXFuXmk4wDBuYcLvsqBWPjRoiVn1f/0u+4dFBw5TzI/ihaTfmNo4H2tUPjIT8weoUU
        kDDpeXBIaMThHWPHgqlAyHA0acPk4Mdu2QbqXYUFBRiMO/qrdCnUtgwukNnJdMYPxqswYA
        psvrxd1eYzqxZIlzi8nsSJwYkoN3RXmMhNOQHqGzAxh9TFGNamRUxIYssv62Iw==
Message-ID: <fe48082e-1545-4cb6-a29a-79b4f6276c91@arinc9.com>
Date:   Wed, 13 Dec 2023 19:51:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] MT7530 DSA subdriver improvements
Content-Language: en-US
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <45221d69-a780-4e81-b4c3-db1b9894a1db@arinc9.com>
 <20231213151910.hr3n4px7a4upc372@skbuf>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231213151910.hr3n4px7a4upc372@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.2023 18:19, Vladimir Oltean wrote:
> Hi Arınç,
> 
> On Sat, Dec 02, 2023 at 11:52:13AM +0300, Arınç ÜNAL wrote:
>> Can I receive reviews for patches 6, 12, 13, 14, and 15?
>>
>> Thanks.
>> Arınç
> 
> Sorry, I don't have time to look at this old thread anymore.
> 
> Please repost the series with the feedback you got so far addressed.
> Also, you can try to split into smaller, more cohesive groups of
> patches, that have higher chances of getting merged.

Thanks Vladimir. I've been fighting a bad fever with sore throat. I'll
submit the first 7 patches after working on your reviews.

Thanks a lot for your attention to my patches that's been going on for more
than half a year now.

Arınç
