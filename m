Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9517B6AD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbjJCNqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjJCNqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:46:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBDEAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:46:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82818C433C8;
        Tue,  3 Oct 2023 13:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696340810;
        bh=Dwbea6D8KUSYEnmFFyh+l6bz5hKq3AOojgORJeK5KGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lk9lvtXbRNP2OnYh3CE/VtihNkES2ujGUVR+ueC2QmePzqOR+dHIyvkpYGlVbCL/w
         edhUVtjmqfBy09rYzmrdXKhS0LleEB6fOm7QVWgwK3hWLPjJhLzt9fkQfUBRUp5RuR
         y3zfW9odG/YqTVjGp67h0v8jYxMd2HpWBwvjlUeh6PD3vhaf7hOzPOczVBoh95IFmc
         AXgZOsGLbioHbtU4jMCmU8v1oB2f0JRnKGdLsSp6wER4ESl5U9Y+T6ZzGv0zfYcATG
         bT3AqyjjsozR+M0vqhtnVniZ5Wq/1NmaMOrzTL1TqgvppXthNiGG2HkD6hX6Q4C+Vu
         FxB6NMhaAa63w==
Date:   Tue, 3 Oct 2023 06:46:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH] net: phy: dp83867: Add support for hardware blinking
 LEDs
Message-ID: <20231003064645.470ed55c@kernel.org>
In-Reply-To: <20230907084731.2181381-1-s.hauer@pengutronix.de>
References: <20230907084731.2181381-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Sep 2023 10:47:31 +0200 Sascha Hauer wrote:
> This implements the led_hw_* hooks to support hardware blinking LEDs on
> the DP83867 phy. The driver supports all LED modes that have a
> corresponding TRIGGER_NETDEV_* define. Error and collision do not have
> a TRIGGER_NETDEV_* define, so these modes are currently not supported.

FWIW I think this patch got marked as Deferred in patchwork because it
was posted mid-merge window. Could you repost?
