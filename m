Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5217B4756
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjJAMWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjJAMWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:22:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B7BEB;
        Sun,  1 Oct 2023 05:22:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D5AC433C8;
        Sun,  1 Oct 2023 12:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696162934;
        bh=KEKIGJ8YzKasW9ukSR/+yIY9EqVyIgke9DbyhZEYjFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+UW6dFcaRdFOoLZ8eu0qf9uAYLsCIKFXs3SzihQe2dnCxUI83LjD5C+RUco/Za7q
         82Du5oMzjqHcCo8qicNOq5egrBuiM3iSpogdRxWffF55x+Ik2oMiVxZDw1Fpapex2m
         Rrc8VztWiNvU1pu0N79JYsyG2P8/627ZO9ce/CMoGqxfrZzq/WwvWJdAFCQDGE3hgP
         b9XxdBAdLthYn+xHRAkrl5xFRv8xAsql413u884WMrDUdpnzYFKmNPVAUo9+761Dfk
         ytTc3/A17/3FPpWoV6Lw6FQ2u0RBW1/c7l9wCs+IXswyrgQRzaWQFUiQ02ZOGKdATf
         O4nupdDbKHQEQ==
Date:   Sun, 1 Oct 2023 14:22:09 +0200
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
Subject: Re: [PATCH v6 01/14] can: m_can: Start/Cancel polling timer together
 with interrupts
Message-ID: <20231001122209.GJ92317@kernel.org>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <20230929141304.3934380-2-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-2-msp@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 04:12:51PM +0200, Markus Schneider-Pargmann wrote:
> Interrupts are enabled/disabled in more places than just m_can_start()
> and m_can_stop(). Couple the polling timer with enabling/disabling of
> all interrupts to achieve equivalent behavior.
> 
> Cc: Judith Mendez <jm@ti.com>
> Fixes: b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>

