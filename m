Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946D3769B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjGaPxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjGaPxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:53:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9D61BB;
        Mon, 31 Jul 2023 08:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 938FD611CD;
        Mon, 31 Jul 2023 15:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AB1C433C8;
        Mon, 31 Jul 2023 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690818793;
        bh=L2tZXZmD+sXdaCCAuGFE2vWovGgLcHM5kSykAonNNRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pmf1rBhcf2IvuO1HRVVazeKI85pL2NAawrpMNiTlOnq4vloDO3GiOKfezq+ghBcX4
         X9w/xZMsXvTOgL9Hc/p72KdqRzwZ7m/m66c0T5BxRUCmD2MDS5ltLjxQ+uffTzmt18
         NEC+EZ1hGciytwGGDO+wBsU5VApeZzIsDEWUdwhI=
Date:   Mon, 31 Jul 2023 17:53:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 03/10] serial: sc16is7xx: remove obsolete out_thread
 label
Message-ID: <2023073135-puppy-reflected-700d@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
 <20230725142343.1724130-4-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725142343.1724130-4-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:23:35AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Commit c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later
> in probe") moved GPIO setup code later in probe function. Doing so
> also required to move ports cleanup code (out_ports label) after the
> GPIO cleanup code.
> 
> After these moves, the out_thread label becomes misplaced and makes
> part of the cleanup code illogical.
> 
> This patch remove the now obsolete out_thread label and make GPIO
> setup code jump to out_ports label if it fails.
> 
> Fixes: c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later in probe")
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Why is this not ok for stable kernels yet it has a Fixes: tag?

Please fix.

thanks,

greg k-h
