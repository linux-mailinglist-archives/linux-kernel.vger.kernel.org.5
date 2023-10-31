Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2D07DC77D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbjJaHmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343655AbjJaHmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:42:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F799C1;
        Tue, 31 Oct 2023 00:42:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DCEC433C7;
        Tue, 31 Oct 2023 07:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698738127;
        bh=Ntji3BYvyMWI2O4plkskfkqHFK/VJ90VPxsK6AyDuV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohZ00+6vewOgEN1PRcDT9vuDdbxXGzQwBKRCOB013cjpAPUICewAAptjYVo3Prlsb
         G+B1qIEgL9ivT7YhB6iprOUJIcb0Hn/2HyGGyIUA+r/4I12QeUqdXmjZwYBDuhdgNO
         idysZUtsQNkagomgQ2JAzN+czGY1aO+WdsK1ATyTBMZl2iyHBndk72odsXD69HEpfB
         QBpcV9/VXIBtctHgfrP+Em9pOUN1sjNo6aV4QM+4ss7wcd6vfptOJ6VOLjXXJ+cQ+H
         bd5CtaANwgf+XRd7rusmai+41sEm5gXLs/tMdHjnu0NActiKiW7d8g13zirsQJlZjz
         F38hRduKxhAMQ==
Date:   Tue, 31 Oct 2023 07:42:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>
Cc:     "pavel@ucw.cz" <pavel@ucw.cz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wyx137120466@gmail.com" <wyx137120466@gmail.com>
Subject: Re: [PATCH 0/2] leds: Add a driver for mp3326
Message-ID: <20231031074201.GP8909@google.com>
References: <b2a603bac3aa47e2bfbcbcd7154a4166@monolithicpower.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2a603bac3aa47e2bfbcbcd7154a4166@monolithicpower.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023, Yuxi (Yuxi) Wang wrote:

> Add the binding description and the corresponding driver for
> the mps mp3326.
> 
> Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
> Yuxi Wang (2):
>   dt-bindings: leds: add mps mp3326 LED
>   leds: add mp3326 driver

These 2 patches and this cover letter were all sent as individual
emails.  Please re-submit the set using `git send-mail`s --thread option.

>  .../devicetree/bindings/leds/leds-mp3326.yaml | 184 +++++
>  drivers/leds/Kconfig                          |   7 +
>  drivers/leds/Makefile                         |   1 +
>  drivers/leds/leds-mp3326.c                    | 632 ++++++++++++++++++
>  4 files changed, 824 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-mp3326.yaml
>  create mode 100644 drivers/leds/leds-mp3326.c

-- 
Lee Jones [李琼斯]
