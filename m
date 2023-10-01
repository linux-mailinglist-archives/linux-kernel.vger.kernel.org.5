Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41887B475B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbjJAMXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbjJAMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:23:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2753A99;
        Sun,  1 Oct 2023 05:23:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C31C433C7;
        Sun,  1 Oct 2023 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696162981;
        bh=OkfmSReXJWH65GTbJ8/OWhwdpJ6O+HTlW6xaMfOmcAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKQ6iWk3LDBQwoOkyswRFnrviy9ScHi2U9OPc1p7MlgpAmDJ5Go6j112CRQJbYShA
         YpfsbY1ryvRkN+fEPJW3/jOEqCD/XcmFrzIQ33SOvx156KY+22zx6iuS3Vowlgqndx
         ak4yZK2CUk3lIYCFflWdgxLMdjJ3lm8pw1nvfZxUsgTyCInrkVvvlIX/eGtikikVrh
         ov3bpgO+Ygp08rWcMeG1/aKJA4ky3so4pOYtbFybWb8UshcnJv/AokHnWnEUGz0Lug
         5zrvk1FC2oFPISMBkb4s7mYhbpfcVqnxdvRqy2bZpw0B0DPMCVE4UW4G89836fL89d
         /Qh8nAVOvQhYQ==
Date:   Sun, 1 Oct 2023 14:22:57 +0200
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
Subject: Re: [PATCH v6 02/14] can: m_can: Move hrtimer init to
 m_can_class_register
Message-ID: <20231001122257.GK92317@kernel.org>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <20230929141304.3934380-3-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-3-msp@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 04:12:52PM +0200, Markus Schneider-Pargmann wrote:
> The hrtimer_init() is called in m_can_plat_probe() and the hrtimer
> function is set in m_can_class_register(). For readability it is better
> to keep these two together in m_can_class_register().
> 
> Cc: Judith Mendez <jm@ti.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>

