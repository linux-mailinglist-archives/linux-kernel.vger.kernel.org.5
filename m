Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B7E7F97EF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjK0DZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0DZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:25:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D3A8F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:25:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A56C433C8;
        Mon, 27 Nov 2023 03:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701055524;
        bh=5F+fc/oItrdvQDeOgVfLwePvEYH547GfcINss4CmLRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UsQy/Z4HLv3TGOLojU0NHKyRL/I8dfAMMD9M9Aipj465vD/XgGMN0mnBIaHguj6Hj
         4pdm9H1KDwcop7QJclXuTDjYc5ZJ6HoCgDOHVGV/XLW6iz4O50lFRotHIbfJbQ4FAE
         rb7OKQ8J/LhHbJxedaOFMGmUAVWskWqTzSGS7RyVCYglA3NbSyb+Fuz57JpP5KZEy5
         qInPwn148XinvK/PPOxAJ0ydOWbjTf0CN6yxQQva63J/h9e8Omqi3Q4cdrbDs5FK1T
         hQe9G0X+Ccr4xqIF7DrGXMAHZ6CVBLVieZb08OfHelUrVzN/luz0tXcGqXERE7IOIJ
         ws1jGpm8G3KyA==
Date:   Mon, 27 Nov 2023 11:25:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     s.kerkmann@pengutronix.de
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6q: skov: fix ethernet clock regression
Message-ID: <20231127032518.GB87953@dragon>
References: <20231101-v6-6-topic-imx6q-dt-v1-1-274f6c13c7d5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101-v6-6-topic-imx6q-dt-v1-1-274f6c13c7d5@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 12:03:37PM +0100, Stefan Kerkmann via B4 Relay wrote:
> From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
> 
> A regression was introduced in the Skov specific i.MX6 flavor
> reve-mi1010ait-1cp1 device tree causing the external ethernet controller
> to not being selected as the clock source for the i.MX6 ethernet MAC,
> resulting in a none functional ethernet interface. The root cause is
> that the ethernet clock selection is now part of the clocks node, which
> is overwritten in the specific device tree and wasn't updated to contain
> these ethernet clocks.
> 
> Fixes: c89614079e44 ("ARM: dts: imx6qdl-skov-cpu: configure ethernet reference clock parent")
> Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>

Applied, thanks!
