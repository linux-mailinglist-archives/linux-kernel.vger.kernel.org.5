Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A1875B67A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGTSTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjGTSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C68A272B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2298D61BBC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 18:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C13FC433C7;
        Thu, 20 Jul 2023 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689877154;
        bh=EoiN3EVWdGI5p92XNOOiXWCrlOjYOsJOhYmgu+f1JVE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gbuFuhwZjRn0883aAz7El2daY8jeSla3B9Kt4d4f9Vm1rY46haBvpqKExUNsJRO6Y
         ee9Wc2IpqgORghzxwR6UZIDKAHEa3ooSpV5f0S/EIeDrx7Sbeiqo+AZYQdu+1ldZNc
         geEfX/I7a0wuXdmW8AvLBxI3liHLurLgtphXs5Ulhksb5m+0qSJJRXz+IP4X5zJS43
         C2MSr4hulBcmQ1GL+oyyG0J5JSPu/Bpr/+yuydn4GR9TxtAXM6QsrfuRlYeHV/EL4m
         HIixu6FLON5GWV0/OQKan7McO4FS4Y7W4CrofpPxd7QzFulszrkud8A92fMpp1/5Qm
         sOP1n8zjakBPw==
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230720032848.1306349-1-linux@roeck-us.net>
References: <20230720032848.1306349-1-linux@roeck-us.net>
Subject: Re: [PATCH 1/2] regmap: Disable locking for RBTREE and MAPLE unit
 tests
Message-Id: <168987715333.223567.12616672116347581062.b4-ty@kernel.org>
Date:   Thu, 20 Jul 2023 19:19:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 20:28:47 -0700, Guenter Roeck wrote:
> REGCACHE_RBTREE and REGCACHE_MAPLE dynamically allocate memory
> for regmap operations. This is incompatible with spinlock based locking
> which is used for fast_io operations. Disable locking for the associated
> unit tests to avoid lockdep splashes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: Disable locking for RBTREE and MAPLE unit tests
      (no commit info)
[2/2] regmap: Reject fast_io regmap configurations with RBTREE and MAPLE caches
      commit: ee43f5bb23340c27603c3ad8ef94f677ad7cb9ad

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

