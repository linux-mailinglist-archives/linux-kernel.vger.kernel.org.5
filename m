Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3296777F22D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348928AbjHQI3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348952AbjHQI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:29:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A49273C;
        Thu, 17 Aug 2023 01:29:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 685BA65648;
        Thu, 17 Aug 2023 08:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1951AC433CB;
        Thu, 17 Aug 2023 08:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692260943;
        bh=BhryKMVOLHybGG2NTxAa8UP5EQFyvT233Ct/zVJuTjw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nYn2245aL0JJKwUADbaGYjsJKUuuFpi86L90HgF5Crlgc95k8+mF7IRlnsCn5HH8l
         MpySQd72mtGs++VhW0euuItFlKZpG/SAxSV/pQ5tR15WxEgPQbYyJTH3YkRBmzqrcL
         QINh1fH+3Ip9R+HyUqTLV0hBA10cVpX8fE/6AaP0aBrYPIkALQoqOeUokH2rZlv0RA
         jPT/T1a/aMWpmluaRK4BpBL1j93Jy+1wfaxtuaixGVVjNQ9mXArc8tJzyGD4gM8tkH
         dO8w+U/Zhrh9le5hRQNXGOapJSQTUVXzzf5Om7+rPrQUfyeWND9tzKfrVo7Pt0uJLm
         OuCh2wopXKQSQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230728153731.3742339-5-jjhiblot@traphandler.com>
References: <20230728153731.3742339-1-jjhiblot@traphandler.com>
 <20230728153731.3742339-5-jjhiblot@traphandler.com>
Subject: Re: (subset) [RESEND] [PATCH v11 4/4] leds: Add a multicolor LED
 driver to group monochromatic LEDs
Message-Id: <169226094184.909741.5903687328186752796.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 09:29:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 17:37:31 +0200, Jean-Jacques Hiblot wrote:
> Grouping multiple monochrome LEDs into a multicolor LED device has a few
> benefits over handling the group in user-space:
> - The state of the LEDs relative to each other is consistent. In other
>   words, if 2 threads competes to set the LED to green and red, the
>   end-result cannot be black or yellow.
> - The multicolor LED as a whole can be driven through the sysfs LED
>   interface.
> 
> [...]

Applied, thanks!

[4/4] leds: Add a multicolor LED driver to group monochromatic LEDs
      commit: 37d0849ed3927f7c4be6f5ee030730f9aa7439c0

--
Lee Jones [李琼斯]

