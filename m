Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55907C9BFC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 23:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjJOVsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 17:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOVsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 17:48:08 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42061A9;
        Sun, 15 Oct 2023 14:48:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57C81FF806;
        Sun, 15 Oct 2023 21:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697406485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Mo1zdiF8qX4RNc1NXuxfSMRi/ufFekjBlc8TKG4Dcg=;
        b=NWMEUIrPXvCnKwbEMBWrSH4+8yqPhTwLJ886vY5MmLqYjhbxvHOcdai21yB8QqgjJCRTdq
        nj5FDwDu2CovWDXcC0R+FXfB1fPoxiRaLW4daxzrYIvJ/Hz+DylkZeCYMTsULQaM80oEyA
        ePJg/IxR4pP02K8UA89r8HmxBLxJJ2acoowT224SjfV+KkB9n5X+HR1jzK7QqtOcVVEXpw
        5mQsxa+5B4rsTVjYdeQqSr8ep1fT7NpHcxoN7YFeO/ZQwFHBL1Mrf2lzqPfZqqBGlzT/3y
        AzvhyLqgKkoaVrm3i/CA4FriHeYYouy1z85SJBuwJcZ1PVAKHDzA3tBi3d1+xg==
Date:   Sun, 15 Oct 2023 23:48:02 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] rtc: Add support for the SSD202D RTC
Message-ID: <2023101521480226f64b51@mail.local>
References: <20230913151606.69494-1-romain.perier@gmail.com>
 <20230913151606.69494-2-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913151606.69494-2-romain.perier@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Romain,

Sorry for the very long delay,

On 13/09/2023 17:16:04+0200, Romain Perier wrote:
> +MODULE_AUTHOR("Daniel Palmer <daniel@thingy.jp>");
> +MODULE_AUTHOR("Romain Perier <romain.perier@gmail.com>");
> +MODULE_DESCRIPTION("MStar SSD202D RTC Driver");
> +MODULE_LICENSE("GPL v2");

checkpatch complains rightfully about GPL v2 here. If you agree, I'll
change this to simply GPL.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
