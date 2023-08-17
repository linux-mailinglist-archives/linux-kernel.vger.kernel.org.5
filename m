Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9725877F537
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350313AbjHQL2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350347AbjHQL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115533599;
        Thu, 17 Aug 2023 04:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F14B3616E4;
        Thu, 17 Aug 2023 11:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33268C433C7;
        Thu, 17 Aug 2023 11:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692271625;
        bh=CgpyAn4XPo7wawKt8pESyplY/MXDqD/84guw3hcr5BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhzoCu/TUdNQziircJe7kowP+fuoRY5rwZgWkf3X+imWBhowe3cgf/AO8n0jsOlrv
         4pjwtk0uo3WF6fdwfhkZmrY3I8sQglwJbM3r8eCPhDuoQUX3XOgkIKwZP0GmvpmkD9
         RJUwmju+2tWM5Vg0zNR6Cjdlc9SKsJwhXFz6hnllUqUvpeZzG/O43RnlyG6A1khasd
         Lq3roKSj4CfJINjXV42AV83A6gDyMMrdRwXOrSUd29rqtuMrEFLKm87LvGIfGM8aCN
         oWQUEbmkIT1Ckbps4g2CIMA3xheWkc1lX4YIX30H+5wIA6t4rqjFQipUwP/Uv2EGVx
         MYCB5Sj1LmZPg==
Date:   Thu, 17 Aug 2023 12:26:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     broonie@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, vkoul@kernel.org,
        lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v7 0/6] Add cs42l43 PC focused SoundWire CODEC
Message-ID: <20230817112659.GA986605@google.com>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <169227059141.987802.3881975345148652106.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169227059141.987802.3881975345148652106.b4-ty@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023, Lee Jones wrote:

> On Fri, 04 Aug 2023 11:45:56 +0100, Charles Keepax wrote:
> > This patch chain adds support for the Cirrus Logic cs42l43 PC focused
> > SoundWire CODEC. The chain is currently based of Lee's for-mfd-next
> > branch.
> > 
> > This series is mostly just a resend keeping pace with the kernel under
> > it, except for a minor fixup in the ASoC stuff.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/6] soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
>       commit: 89e63e62ad14dbe528257882856c08365e5bb337
> [2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
>       commit: 940cdb69aeb4aa3dde97bd46a5d8422f8a0f1236
> [3/6] mfd: cs42l43: Add support for cs42l43 core driver
>       commit: c4962e013792df36dceacd692fef0f6803517b3f
> [4/6] pinctrl: cs42l43: Add support for the cs42l43
>       commit: df393be615ae61993ac0c32edc13dff27b7e925d

Sent for build-test.  Will submit a PR once all checked out.

-- 
Lee Jones [李琼斯]
