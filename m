Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15E9751D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjGMJfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjGMJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:35:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8C72118;
        Thu, 13 Jul 2023 02:35:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35AFA61AA3;
        Thu, 13 Jul 2023 09:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CE8C433C7;
        Thu, 13 Jul 2023 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689240904;
        bh=lO59LrWn+BDuGmFHjQkiC0C5iyCqQnSMPxzJYUGFRL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GhHxt8EHSZe2zoWUNhy5M2KBdzqsZpnKOa5aG2GWTYXPPR14SrlHD4tLHbSKGt3J1
         deUzhoxj0Zdv9BgSd59b0l+RpUzUtwSYM8GVhYE1biN617Pfxvdq8KD/KMEGcsjHQn
         RRLdYu/3H5WV46/wJ7tzRWk1YMPGgS7cEv04lPNmSCm0PKdsyv4863+tiCjHF8HZUo
         vhCcI5sV/l+p0pfKeaJnodqsNwgOm/hGPGYkJFKJKE96RQEoQeOdUwwaPgvYIfhh/A
         Y4jXoCEBYF6M9RgsmKBHfUv2ivxGoGka1br9Njd+G0e5lQQvgvvcEO6GEXKyYhY7rA
         lAm4rwZMt5/5A==
Date:   Thu, 13 Jul 2023 10:34:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Henning Schild <henning.schild@siemens.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: simatic-ipc-leds-gpio: restore LEDS_CLASS
 dependency
Message-ID: <20230713093459.GG10768@google.com>
References: <20230623152233.2246285-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230623152233.2246285-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent rework accidentally lost the dependency on LEDS_CLASS, which
> leads to a link error when LED support is disbled:
> 
> x86_64-linux-ld: drivers/leds/simple/simatic-ipc-leds.o: in function `simatic_ipc_leds_probe':
> simatic-ipc-leds.c:(.text+0x10c): undefined reference to `devm_led_classdev_register_ext'
> 
> Add back the dependency that was there originally.
> 
> Fixes: a6c80bec3c935 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/leds/simple/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
