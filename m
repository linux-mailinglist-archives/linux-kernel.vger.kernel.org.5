Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942767827C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjHULRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHULRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:17:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E086691;
        Mon, 21 Aug 2023 04:17:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 708126144C;
        Mon, 21 Aug 2023 11:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FEBC433C7;
        Mon, 21 Aug 2023 11:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692616655;
        bh=V/jiRj5wmrCoPlTqxTwhl6K9aF48O4FnW83gBBmAXtw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=DQ4LIs0gYWuj/vywUoTgThh6rWDgJROGSzxuu3tA2nHYjbSfxv6aQ97oGZ7RWk1S1
         6n2M0PC5ncMJRsovFV9xr/6+HAClf/9TRK7CF4oRiciaWC7rUlXZTMTngTPw3dK//M
         e90wLhDmrtzEA7CIYwBx0fwSPznTikYrH18rkXMaVYwWos8ZAMP+QpEFP7aC6rVHpm
         qi56oawtf5bnj32baNKkBe8f/UOwl9MsBRrn7zsL8XOBRrznpp+ElsexPb7ICEt1x4
         OxIm4BOw05M6fQiaXoCPlqiVKHBCiK2irITjBzb9bP7Xu1bZytp6ZoFEu6DXRSKTXL
         ySDlNcetDqn0g==
From:   Lee Jones <lee@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230818012308.2058373-1-ruanjinjie@huawei.com>
References: <20230818012308.2058373-1-ruanjinjie@huawei.com>
Subject: Re: (subset) [PATCH -next RESEND] backlight: led_bl: Remove
 redundant of_match_ptr()
Message-Id: <169261665381.1545342.12598274786028807236.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 12:17:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 09:23:08 +0800, Ruan Jinjie wrote:
> The driver depends on CONFIG_OF, it is not necessary to use
> of_match_ptr() here.
> 
> 

Applied, thanks!

[1/1] backlight: led_bl: Remove redundant of_match_ptr()
      commit: a4464092f2c514a7f0788906d340f0bab59fdd73

--
Lee Jones [李琼斯]

