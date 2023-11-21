Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B387F276E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjKUI20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKUI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:28:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4CEED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:28:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997BDC433C9;
        Tue, 21 Nov 2023 08:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700555300;
        bh=yrkU8VJB5SKAtcRYFYmhxNO9FCZg2MU9Fl1s+k0LICs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=RM4nuFG87Gcs2ajeJCX/i3p1qsayRyuOYvoGfMXS/tDcjXP1r7zeMwgMvpa45t433
         TETW6Sxp+5LTEQDnsvlY1dvjOUz9UdCf+q8qOE2p8THl/kYvrzHhqUpUEItYPcJ+ag
         dMcg+BIdMfvzFnIyr/AB5gy6IlxXOjYyj7eRU10dwAF7VexpfB50WG8hHznY5tYMiD
         JwIbJ1jC4JxeBo6DOoH4x/qeX0/VrU64cetOkgF9JMkQOyDSGkk6qQplgjPs7xzXDb
         LrWh1EfEntQWYealAN6SmbHCgR3u2m0e/9j3AO0ldtaP35PULqK2jx2IXLMkvPN0f8
         NcWrF7EWRqNdw==
Date:   Tue, 21 Nov 2023 09:28:16 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Johannes Roith <johannes@gnu-linux.rocks>
cc:     sergeantsagara@protonmail.com, andi.shyti@kernel.org,
        benjamin.tissoires@redhat.com, christophe.jaillet@wanadoo.fr,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v7] HID: mcp2200: added driver for GPIOs of MCP2200
In-Reply-To: <20230921164928.170383-1-johannes@gnu-linux.rocks>
Message-ID: <nycvar.YFH.7.76.2311210927510.29220@cbobk.fhfr.pm>
References: <20230921164928.170383-1-johannes@gnu-linux.rocks>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023, Johannes Roith wrote:

> Added a gpiochip compatible driver to control the 8 GPIOs of
> the MCP2200 by using the HID interface.
> 
> Using GPIOs with alternative functions (GP0<->SSPND, GP1<->USBCFG,
> GP6<->RXLED, GP7<->TXLED) will reset the functions, if set (unset by
> default).
> 
> The driver was tested while also using the UART of the chip. Setting
> and reading the GPIOs has no effect on the UART communication. However,
> a reset is triggered after the CONFIGURE command. If the GPIO Direction
> is constantly changed, this will affect the communication at low baud
> rates. This is a hardware problem of the MCP2200 and is not caused by
> the driver.
> 
> Signed-off-by: Johannes Roith <johannes@gnu-linux.rocks>

Now applied to hid.git#for-6.8/mcp2200. Thanks and sorry for the delay 
in the review.

-- 
Jiri Kosina
SUSE Labs

