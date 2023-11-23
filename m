Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4CB7F6259
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346003AbjKWPKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345968AbjKWPKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:10:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAFCD41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:10:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CB3C433C8;
        Thu, 23 Nov 2023 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700752239;
        bh=GrCfOdky6KNJjNJ8E6fqLtWu4tum/bJIEaA+gGu5VLw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WBZCK6JDKty6AftLqkLykG1Umyj3B/rM3ito0gNW3a5LedbPUkkEwT0aBtWDQ27nh
         loDcAF5kt/0aFE4ADmtkojEyRn8AN8et83fmoANl73lCL+EOaooqkPhta1TYh3LVz1
         PKog3Q+I0x+WQhFPnWoHFo/2hd6tWoIL5umhlQUdr0s4AyEI22FB9eIqhR4oALSjs9
         NgLDD6vV0N7nDqi1+xZ7OKyAYVFOYNWk45l+w0iv80iZYzY6YJFamh4xshT0lf4Toh
         soPMM2Oc36GpPnatU+U6Xlf5DcOxVqvzw68yDKtOYdebiIdo1xoMBM5dfIzGMikkWY
         kat5oSK0qcRdg==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Davis <afd@ti.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231116224121.302150-1-afd@ti.com>
References: <20231116224121.302150-1-afd@ti.com>
Subject: Re: [PATCH 1/2] leds: tca6507: Use devm_gpiochip_add_data() to
 simplify remove path
Message-Id: <170075223827.1377245.12365647707765746523.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 15:10:38 +0000
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

On Thu, 16 Nov 2023 16:41:20 -0600, Andrew Davis wrote:
> Use devm version of gpiochip add function to handle removal for us.
> 
> 

Applied, thanks!

[1/2] leds: tca6507: Use devm_gpiochip_add_data() to simplify remove path
      commit: 50b683a8b9884f032c3d268b8a68df799219e91b
[2/2] leds: tca6507: Use devm_led_classdev_register() to simplify remove path
      commit: 612af3a44921f21c361a369899fec61698aa08e1

--
Lee Jones [李琼斯]

