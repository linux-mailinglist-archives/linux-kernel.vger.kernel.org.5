Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E317B4761
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbjJAMXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjJAMXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:23:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ED899;
        Sun,  1 Oct 2023 05:23:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07EFC433C8;
        Sun,  1 Oct 2023 12:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696163019;
        bh=bGLLx3W/04YDixrwTRJ2+yQqyEYUWpZQHtkoZLDsy3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=caoR0sLj5VpWHHsGJ1M4cEFL/G+xaKIL0fGS7ecUE24Tb0AQbuHTYmPt6fWfYI4kE
         TK13OC9lhMsw2OW16ainYYFdxcogJHS+ARuInHIEWuyjI9jHE6Q+X14xZOJeqLBBC0
         6aMr8i0vUsfeE2LX5ueOwWGWxQmEJkox6EiSZcpREpvgNJnbJK9JK2SW88GNZm0ERR
         A6F/MYDc/1BP5eP8cBXGYjfbGzhOch4YcnT/nE21yXD4dA/+oGBHXQ7bbATZ5J1Djb
         LjnANZrLCxfiCTxiIGqs+xVi76QJWjtivfn4LJLzk705GgEdVULago4+TBeZIJXwYx
         f9Up9PwAIu++Q==
Date:   Sun, 1 Oct 2023 14:23:34 +0200
From:   Simon Horman <horms@kernel.org>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v6 05/14] can: m_can: Implement transmit coalescing
Message-ID: <20231001122334.GM92317@kernel.org>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <20230929141304.3934380-6-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-6-msp@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 04:12:55PM +0200, Markus Schneider-Pargmann wrote:
> Extend the coalescing implementation for transmits.
> 
> In normal mode the chip raises an interrupt for every finished transmit.
> This implementation switches to coalescing mode as soon as an interrupt
> handled a transmit. For coalescing the watermark level interrupt is used
> to interrupt exactly after x frames were sent. It switches back into
> normal mode once there was an interrupt with no finished transmit and
> the timer being inactive.
> 
> The timer is shared with receive coalescing. The time for receive and
> transmit coalescing timers have to be the same for that to work. The
> benefit is to have only a single running timer.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>

