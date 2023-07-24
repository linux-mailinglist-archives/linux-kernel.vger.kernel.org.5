Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D406075EEEA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjGXJSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjGXJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C093A6;
        Mon, 24 Jul 2023 02:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92DE461000;
        Mon, 24 Jul 2023 09:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E051C433C7;
        Mon, 24 Jul 2023 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690190276;
        bh=8a29HgSLoVm9OT+3DOAGJKF4MS3J2IMMxQ4wA9HJO4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7mDhZF6QyCJBUWj+rU0z2Z4B0dMWl2PQGQaPeq5SGN3vmEKhgJc3qaWb311TrJlt
         d4J9J6icXBk/54Z1FsejZvX3LTVOa34QSr7tgkZdanmiqoydW0kp+KszNzwXS0RZQF
         mcZZ/eaMUHA2MkMkybmnGGXh1BeAhzrVwnHFCb3LvqXFo8jFIG7KPx9zED/w5DY2r+
         gNP/FsoGyz/5qlH5U/84iDNQF8APFAWiVlgZd7K/LaCT+AdaCanbwxokbAr1oUTukE
         MX+a1BQhDkgjdCSv9ppRWZZ0Q9zriBr8QlS9EZPmbbg1CZLv3ygPf2YF6c3WpdzL7M
         X6SfJJB1XuKew==
Date:   Mon, 24 Jul 2023 10:17:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH v2 2/3] leds: simatic-ipc-leds: default config switch to
 platform switch
Message-ID: <20230724091751.GA11203@google.com>
References: <20230719153518.13073-1-henning.schild@siemens.com>
 <20230719153518.13073-3-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230719153518.13073-3-henning.schild@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023, Henning Schild wrote:

> If a user did choose to enable Siemens Simatic platform support they
> likely want the LED drivers to be enabled without having to flip more
> config switches. So we make the LED drivers config switch default to
> the platform driver switches value.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
