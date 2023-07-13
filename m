Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C66B7523DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjGMNdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbjGMNdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4095219B9;
        Thu, 13 Jul 2023 06:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8774B60A70;
        Thu, 13 Jul 2023 13:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD35C433C8;
        Thu, 13 Jul 2023 13:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689255210;
        bh=O9fZa5s/FLnr8HFbNTrKvC+Zl15VrzgxPjFRoLUMyds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TucL+YNwNK3K/Ywfi9RVKEt/afN2+7q2YQQjwNuBPYx7KNxZxLSMdxdkpFGJBsvPc
         hgOTBCYR1j2V4jVuLSvcu73SLHDMwPuatBj41wRlrFpLOrHJct2V6y6KL/GGXp6GjO
         fq0NvhpVU7N/ysmTcaXhVhlzz5sWi+q+JJgsBFLbS57OxdzcmKSzrGZ+8IHRWpYXEH
         MKQm8mmVONs9bI6VAzi/NzAY6jkm446M/SekTq0BDq8icL9ptmxvWJwlj8tzGI35CC
         UggFnL4KorqjGrw24LKmqr4YNDc0Qn6fNCxT8yhGboT4/MEo82EPMGQKreASxZAgMa
         Ig4ZNEiHK8LrQ==
Date:   Thu, 13 Jul 2023 14:33:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, kernel@axis.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] led: led-class: Read max-brightness from
 devicetree
Message-ID: <20230713133324.GT10768@google.com>
References: <20230703130313.548519-1-astrid.rost@axis.com>
 <20230703130313.548519-3-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230703130313.548519-3-astrid.rost@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2023, Astrid Rost wrote:

> Normally, the maximum brightness is determined by the hardware, and this
> property is not required. This property is used to set a software limit.
> It could happen that an LED is made so bright that it gets damaged or
> causes damage due to restrictions in a specific system, such as mounting
> conditions.
> Note that this flag is mainly used for PWM-LEDs, where it is not possible
> to map brightness to current. Drivers for other controllers should use
> led-max-microamp.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  drivers/leds/led-class.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
