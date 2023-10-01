Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF49B7B4768
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjJAMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjJAMYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:24:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0ED9E;
        Sun,  1 Oct 2023 05:24:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D041C433C7;
        Sun,  1 Oct 2023 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696163091;
        bh=60Jvv/Pm2PQ/Yz/ve2h3Ch8pPQyPw2+hMP/ocOFmqxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LU/VU39MeIZafsdLU1IGGQOSAP1F4b2/uUhGtdrafCRP27AbfZ+wYnWgjGressAuk
         ZxszmyylMKtxWOYoD82cfsq3hg7g/sO4eyBF+4DIiocOH0T2NpTf05++AA+Nll2K9g
         486xbmG81EFLJUFX4+6oL/1kUBwueeG3X9TvoiZZu424PX4ZsxaL/+USQflUXQ7bvM
         XY5o/qz+N9O/x8oONtzmVFi4OlYb1DcD+IubgWbGNn81uqbMv+Wf8V5BCBip8OT4As
         ESPUI6LZKh82yDPR8a002qHif70K023W846IggV/eKKqVWclFWTNMZf0S9iQX0olkB
         iamK58LXFAWFw==
Date:   Sun, 1 Oct 2023 14:24:47 +0200
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
Subject: Re: [PATCH v6 07/14] can: m_can: Add tx coalescing ethtool support
Message-ID: <20231001122447.GO92317@kernel.org>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <20230929141304.3934380-8-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-8-msp@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 04:12:57PM +0200, Markus Schneider-Pargmann wrote:
> Add TX support to get/set functions for ethtool coalescing.
> tx-frames-irq and tx-usecs-irq can only be set/unset together.
> tx-frames-irq needs to be less than TXE and TXB.
> 
> As rx and tx share the same timer, rx-usecs-irq and tx-usecs-irq can be
> enabled/disabled individually but they need to have the same value if
> enabled.
> 
> Polling is excluded from TX irq coalescing.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>

