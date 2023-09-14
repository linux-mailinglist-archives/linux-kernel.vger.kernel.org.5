Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A115A79FD91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjINH4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjINH4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:56:44 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E081BF9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:56:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51E4840010;
        Thu, 14 Sep 2023 07:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694678196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rif32sB1HbXsN5nBPsePEQZLXD9bQCbSkw3nnlsNu1A=;
        b=jNkHiYRGLgFweP826EIZpjwJs318S+vZ1Ob1VC++ZMNlR6veS72mozPyweqhOyJ6492S0M
        2mb/nroYg/bwChNbRrazpe11eTLKzsjH/fAwp3b4hFncyOCzHIZJPbbZbNA5fZ3A3x9nEg
        tVkrCrvcG1ltNeqRnbh8LuY2xCbjSIoQqdr4NUoW1HCimWVdMAXOaNMadCzoYKjjo24aeV
        uWzLWQvX+2iulDNFX7rj9+bW7VUwIolqXuSc2/UIDfJiaQkMaBf1zT5y0kqZqzRFD+Ylr0
        OBPQgup07Wq37DMeSxM3R/1GLJfeUMNNix4uGgP/UwmP/u96nIjuRK91Tip2FQ==
Message-ID: <3f175090-4c5f-4821-9155-06c4868d0489@arinc9.com>
Date:   Thu, 14 Sep 2023 10:56:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: brcm_nvram: store a copy of NVRAM content
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
References: <20230914064922.3986-1-zajec5@gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230914064922.3986-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.2023 09:49, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This driver uses MMIO access for reading NVRAM from a flash device.
> Underneath there is a flash controller that reads data and provides
> mapping window.
> 
> Using MMIO interface affects controller configuration and may break real
> controller driver. It was reported by multiple users of devices with
> NVRAM stored on NAND.
> 
> Modify driver to read & cache all NVRAM content during init and use that
> copy to provide NVMEM data when requested.
> 
> Link: https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=K0EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
> Cc: Arınç ÜNAL <arinc.unal@arinc9.com>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

This is a bug fix, could you add a "Fixes" tag so it will be backported to
stable releases?

Arınç
