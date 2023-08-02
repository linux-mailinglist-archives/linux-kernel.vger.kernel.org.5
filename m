Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAC776C43E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjHBErP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjHBErM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:47:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754681715
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:47:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31297125334so288862f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 21:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690951630; x=1691556430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkZQ3YpJIkA2eAMb/15s9HR66Ei62jkCCugnnLEp5bo=;
        b=Jmy/5ATSLRhvIYLpnMf2o1bBssv9KZxTovxLJDP5KLq6z36/h9yDC1hwH78UexGBnz
         4zmh+cK+B0aWv1uBQXvM62idnZzxA8fp6HAk8psN21TCZED5f87buaqKEE5KnUz6Q1bM
         /aRgINxgE8u9cT7elVeuINDd/aDvEbcUlb7lsDpDpL4opoSeotI9thcV3QGqhu7u1OUu
         bkADdacwc2Kd2UHJO7g8P0e1b80iontzce8W/I3ktgOM3ZuxjBwbf+BXt0DJE1HNNTf/
         54EOD84TzN5HH68HzasAj3R68rZosd1xp2bfztFpXb9c6mTFswKCIZHdeRDk6ORHRBRT
         blwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690951630; x=1691556430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkZQ3YpJIkA2eAMb/15s9HR66Ei62jkCCugnnLEp5bo=;
        b=dGuLMdTrtT4PuHsXE3wkMR/q9BvzDZ77/vsJ+r63cdcS+UM+OUTNfhryI32uKMN+iw
         oEFWX+Z6So8NMUi//0UgPOVsfrrTrNepJ1oVb475Cm5aBmpZmOVub1mx7Wu54ZJzQnE2
         EQrzdy9GKvtJDPP2rgp1UH9DCsvbaVvHKr/ZeoY0umcJEWf7mSM1ZBbXPoi+81G65gxZ
         otMltMiXvF7OJ4nXq0/tchYFbHBujIgz8mf2Pl3Jf+ePm/syj3iMs/bbHp7mDUBFTDmw
         hmuyhtF0C1dA1bXr3xqBZWSvEREY5TeYLaYSFMgZvryImB0KfnlBmYBaWN0UyuV6wi6Z
         jQRA==
X-Gm-Message-State: ABy/qLYXMBubklNgEIyk6iANWngI0cYX+ojCHGZCGqBGULuxf+xcchc4
        3a+NEjRhh2rqshDewGkicN0p0Q==
X-Google-Smtp-Source: APBJJlEDYlkiXTohqZnL8MBZFMulqwTLKtgj6Y+Pkc+4ds+xCZvELARH/DwlmLQIVE0k3AtF89RSSg==
X-Received: by 2002:a5d:51cc:0:b0:317:614b:5dad with SMTP id n12-20020a5d51cc000000b00317614b5dadmr3955329wrv.7.1690951629924;
        Tue, 01 Aug 2023 21:47:09 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe884000000b003144b95e1ecsm17824935wrm.93.2023.08.01.21.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 21:47:09 -0700 (PDT)
Message-ID: <d10d803c-fc92-90f5-007c-3190742213ea@tuxon.dev>
Date:   Wed, 2 Aug 2023 07:47:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: at91: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230717225429.3211307-1-robh@kernel.org>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230717225429.3211307-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.07.2023 01:54, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> A couple of other includes are unused and can be dropped too.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to at91-soc, thanks!
