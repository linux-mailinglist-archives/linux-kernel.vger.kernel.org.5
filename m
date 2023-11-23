Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF097F5D21
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbjKWK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344926AbjKWK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:59:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C350AD67
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:59:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F4CC433C8;
        Thu, 23 Nov 2023 10:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700737149;
        bh=90AhqRMEb1URW49+jHELClQUBz+rpek7dQfPYTTBU3s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pzTpA21fS4E7VIIiK2AXpbARKJ2zwaJ85J26OuY9iHMSe9nF9HGOzknVg89sSfG/p
         8rhPDqVk66jHZnUtBl3nhNJBoDQwPn5/2Yqcwn+LXhSIuO8EMDCn8CuH6va9vfvKUY
         n1vT3pHE4w1bgae+55qFsbP0qIETsPqODGgnoEfPwrESC8tke2xn8/i9rYtTIi85gF
         +jMfVWiDr97CdQOj9XegXFDPiuW0kFQTLprTCm+8sA/vOtWWbsGFSdA1KVdPl/2ybB
         9HC3oHPyBC+qUHawUi4cs+MI0tTvhi4KOwCnmk2j6clJmnQ8aFGYhEhhjOsd9eQW9r
         4tzxVGQ3drLoA==
From:   Lee Jones <lee@kernel.org>
To:     Dang Huynh <danct12@riseup.net>
Cc:     Nikita Travkin <nikitos.tr@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231103114203.1108922-1-danct12@riseup.net>
References: <20231103114203.1108922-1-danct12@riseup.net>
Subject: Re: (subset) [PATCH] leds: aw2013: Select REGMAP_I2C
Message-Id: <170073714794.1242990.14043054450989948510.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 10:59:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Nov 2023 18:42:03 +0700, Dang Huynh wrote:
> The AW2013 driver uses devm_regmap_init_i2c, so REGMAP_I2C needs to
> be selected.
> 
> Otherwise build process may fail with:
> ld: drivers/leds/leds-aw2013.o: in function `aw2013_probe':
> leds-aw2013.c:345: undefined reference to `__devm_regmap_init_i2c'
> 
> [...]

Applied, thanks!

[1/1] leds: aw2013: Select REGMAP_I2C
      commit: 5de5423bb5f7c1a20f00a0f45ca38e533714fcfd

--
Lee Jones [李琼斯]

