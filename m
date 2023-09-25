Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160697AD791
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjIYMFd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 08:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjIYMFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:05:10 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9298E76;
        Mon, 25 Sep 2023 05:04:29 -0700 (PDT)
Received: from pd9e2f713.dip0.t-ipconnect.de ([217.226.247.19] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qkkK2-004AN8-EF; Mon, 25 Sep 2023 14:04:18 +0200
Date:   Mon, 25 Sep 2023 14:04:15 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com,
        jean-baptiste.maneyrol@tdk.com, chenhuiz@axis.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: mpu6050: add level shifter flag
Message-ID: <20230925140415.00130082@aktux>
In-Reply-To: <CAHp75VfvmED4ZsmrH4B6m9kGsH=68-zjQd5JMszb6UBTtbF0bw@mail.gmail.com>
References: <20230924222559.2038721-1-andreas@kemnade.info>
        <20230924222559.2038721-3-andreas@kemnade.info>
        <CAHp75VfvmED4ZsmrH4B6m9kGsH=68-zjQd5JMszb6UBTtbF0bw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 14:07:58 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Sep 25, 2023 at 1:26 AM Andreas Kemnade <andreas@kemnade.info> wrote:
> >
> > Some boards fail in magnetometer probe if flag is not set.  
> 
> Which flag? Can you elaborate a bit more?
> 
well see $subj. The level shifter flag.

> Does it deserve the Fixes tag?
> 
As there are only certain boards affected, they would also have
to add the flag in dtb, I do not think it deservers a Fixes tag.
Even in the board I have here, there are basically two
mpu9150 connected per cable, only one of them needs the flag.

> ...
> 
> >         unsigned int val;
> >         int ret;  
> 
> > +       ret = regmap_update_bits(st->map, 0x1, 0x80,
> > +                                st->level_shifter ? 0x80 : 0);  
> 
> This is a bit cryptic, what does 1 stand for?
> 
Well, I do not find anything in
https://invensense.tdk.com/wp-content/uploads/2015/02/MPU-9150-Register-Map.pdf
I have just found a similar line in the ancient 3.0 vendor kernel. No symbolic
names there.

Regards,
Andreas
