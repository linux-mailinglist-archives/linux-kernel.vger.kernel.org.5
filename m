Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2207C7CA005
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjJPG6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjJPG6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:58:12 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2B4AD;
        Sun, 15 Oct 2023 23:58:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52B6B40004;
        Mon, 16 Oct 2023 06:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697439489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ko3cY+uTmqDMyruLPIoKaoj2Pg+fZKHzWwHqRwh37QU=;
        b=PZa+WoE6X2TXCnR9wo3EW5OBC1iIkMoMKEokX9uScgUmx5WjuRSGqexC5ZRuEv+0CIkz3X
        lbaiUMIsnZ9Oyt+RLha1PjRGQp7zk9O6TSaWF9IzW0Ze/QpJAxs1dSTTcautOwa4ADcy6d
        4BEqJ9fYlt8xYesHL0gkfrqtfq+vBA4jzWHSSkb67MXongGUaRCJ/ilX6SjaABlO6/c/XT
        ZU7xJHS7SkMUoI7yBG7VT5kpmFOzocT1obp0+nnuky5Ce7AAC+bzMyvLD1+t5M10sUWcJZ
        S1LwJ1veq5U54LV5+q3R0/chSgfJbxuy6fsNR9Tm8RwuPWn2pIno66f3GrsCsQ==
Message-ID: <969d7010-736f-46cb-98df-0a3ff6be867c@bootlin.com>
Date:   Mon, 16 Oct 2023 08:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: use vmm_table as array in wilc struct
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ajay Singh <ajay.kathat@microchip.com>, stable@vger.kernel.org,
        heiko.thiery@gmail.com
References: <20231013-wilc1000_tx_oops-v1-1-3761beb9524d@bootlin.com>
 <f615b0895135489a2555d898afdcfbfa@kernel.org>
From:   =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <f615b0895135489a2555d898afdcfbfa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

On 10/13/23 11:24, Michael Walle wrote:
>> Fixes: 40b717bfcefa ("wifi: wilc1000: fix DMA on stack objects")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Looks good to me. But you'll change the alignment of the table, not sure
> if that matters for some DMA controllers.

Thanks for the review.
Indeed, I may have overlooked that point. I am not sure either how much of an
issue it could be, but checking back the driver history on lore, I see that it
has already been mentioned, so let's be safe and keep a dedicated kzalloc for
vmm_table to make sure its address is safe to use with DMA.
I will send the corresponding v2.

Thanks,
Alexis

> 
> -michael

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

