Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08627523DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjGMNdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbjGMNdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C3CC1;
        Thu, 13 Jul 2023 06:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4596261087;
        Thu, 13 Jul 2023 13:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1785C433C8;
        Thu, 13 Jul 2023 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689255186;
        bh=rwC+/m8RPKQ/NaQ55b5OfPkeokx//P0umPQN/vB4+oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beU9ZZU62oP1jtA32iHMv6r92DuWhogqDrG1wftzTde3OWWtawflTvbOCKeun41m8
         fJJyPMHDXhkNL7GKCPpsdL+wx9F9ic+cK7lUbs5wkCWUjFQ14v8fvhG5X4A5fdsSGB
         m2EefzOzOyhRWGKNhP0aN6JSvyPHBSycyonM7Rya0F6H/4ki99opOsXqt41UMwiNGE
         sDqucSEiCA3GNJHrqeiTVIOl7DK8Gxrs7gXZtkPdybzSDcjanMY7FqC6K9IC0x9uQS
         jXR77xJ1Mpjd/OgC9GCFGV77gXHUoywMg7WCvsBCFJSOOuTcMdzHzPFb91z/V5tqkR
         5KqEM4KqKgh+A==
Date:   Thu, 13 Jul 2023 14:33:00 +0100
From:   Lee Jones <lee@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@axis.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Read max-brightness from
 devicetree
Message-ID: <20230713133300.GS10768@google.com>
References: <20230703130313.548519-1-astrid.rost@axis.com>
 <20230703130313.548519-2-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230703130313.548519-2-astrid.rost@axis.com>
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
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
