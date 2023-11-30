Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E297FF131
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345813AbjK3OGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345768AbjK3OGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:06:35 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C2E196
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:06:41 -0800 (PST)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1r8hgb-0001aa-DR; Thu, 30 Nov 2023 15:06:37 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <2440edae7ca8534628cdbaf559ded288f2998178.1701276806.git.geert+renesas@glider.be>
References: <2440edae7ca8534628cdbaf559ded288f2998178.1701276806.git.geert+renesas@glider.be>
Subject: Re: [PATCH] reset: Fix crash when freeing non-existent optional
 resets
Message-Id: <170135319678.682649.10186168762521739609.b4-ty@pengutronix.de>
Date:   Thu, 30 Nov 2023 15:06:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 17:55:33 +0100, Geert Uytterhoeven wrote:
> When obtaining one or more optional resets, non-existent resets are
> stored as NULL pointers, and all related error and cleanup paths need to
> take this into account.
> 
> Currently only reset_control_put() and reset_control_bulk_put()
> get this right.  All of __reset_control_bulk_get(),
> of_reset_control_array_get(), and reset_control_array_put() lack the
> proper checking, causing NULL pointer dereferences on failure or
> release.
> 
> [...]

Applied to reset/fixes, thanks!

[1/1] reset: Fix crash when freeing non-existent optional resets
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=4a6756f56bcf

regards
Philipp

