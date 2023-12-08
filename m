Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C184480A729
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574247AbjLHPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574260AbjLHPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:17:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBBFF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:17:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2D5C433C7;
        Fri,  8 Dec 2023 15:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702048649;
        bh=hX6GbMkn+q3aw8cUXh7DUuZsJkUeN7K0RoNohm9TiuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EcYhb15zqwEBqikmKpTsvrdG37y++jvmYlI7BurSQR8ud2IF9Gh/z3lX9GLQMell8
         jhPrY22ycsPYDovQ7F/AaQXBCI3tQa/wEhm1sSGxO5caZFcFAyUKv39ge6c8PrlFg7
         JyLbbYc/oNcuUw6k/E++8h2o+75bQLEeGr1ahl7cSA4PQz4X1T8Hz8aypq1Q8I+ES7
         vNEsBY8t50F1H0jFzieNDpFMoZW5KtjHutDKb5RhTscPu73t9a0BvYLdrafcw5y7T1
         kX6gIIQhPXZjBTYi4THKI/kr0kySau7Djb29E5CNxECMFd+2NC6u8heBTo/GwqMths
         qYlRVh9itH5gA==
Date:   Fri, 8 Dec 2023 16:17:24 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Sjoerd Simons <sjoerd@collabora.com>, kernel@collabora.com,
        Andrew Lunn <andrew@lunn.ch>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Moxtet bus fixes
Message-ID: <20231208161724.5f4f626a@dellmb>
In-Reply-To: <87fs0ceoif.fsf@BL-laptop>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
        <87fs0ceoif.fsf@BL-laptop>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2023 15:51:20 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Hello Marek and Sjoerd,
> 
> > It seems the moxtet bus support was broken since 21aad8ba615e ("arm64:
> > dts: armada-3720-turris-mox: Add missing interrupt for RTC") for two
> > reasons:
> > * The moxtet irq isn't marked as shared so the driver fails to load if
> >   the rtc driver gets set up first.
> > * The dts change didn't set the IRQ type, so in case the rtc driver got
> >   probed first irq setup ended up wrong (rising instead of falling edge).
> >
> > On top of that the moxtet module isn't auto-loading due to a missing spi
> > table
> >
> > Changes in v2:
> > - Add cover letter
> > - Add patch to set the irq type
> >
> > Sjoerd Simons (3):
> >   bus: moxtet: Mark the irq as shared
> >   bus: moxtet: Add spi device table
> >   arm64: dts: armada-3720-turris-mox: set irq type for RTC  
> 
> I only received the previous patch in my inbox, I plan to apply it. But
> what about the 2 other patches ? Marek will you do a pull request with
> these 2 patches or do you expect that I take them also ?
> 
> Regards,
> 
> Gregory

Gregory, as of yet I've never done a pull request. If you are willing
to take all 3 patches now, please do. In the future I would like to
start doing it for Turris stuff, if you are OK with it.

Marek
