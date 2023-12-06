Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E674880640D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 02:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376372AbjLFBW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjLFBW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:22:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7841B8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:22:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DBCC433C8;
        Wed,  6 Dec 2023 01:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701825752;
        bh=I78wRLtllGr8IUlWB1dUuLbqcVT04Doycx1mn6uEh+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtSiNUt+HWdIep3iZ7EbiL5GSm1fz72RB8kCgV4+u6xmWNKVI3jVtpP/LXAUeP6pO
         1tlj+6koaIGeByCCsuXvHRz7FH1oSHzVEiWxZFpnx4n7Q/PA/XWUTtZy4vYryJcxRy
         46GcWaNrKET4/QOpPFwWnrZNS880jWzEgI4i0L1KDAhuIBaGk/bWmhcZ4aQBq8fb3/
         EnI0i9rhoCbE4YXB+QtmBo5FxlzAcIy4cYQv1PN+RQxUkEp+4JEs5yEMlAGOMtYDW/
         X7VLEn3UMY/8uxZScUZer8DRvfK/rYCHCgd4d/SrDwfuyej/z8c3MBcTyGwRJnpjy6
         UYThi+5HjUYRg==
Date:   Wed, 6 Dec 2023 09:22:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] ARM: imx: Use device_get_match_data()
Message-ID: <20231206012227.GW236001@dragon>
References: <20231115210319.3747145-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115210319.3747145-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 03:03:18PM -0600, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!
