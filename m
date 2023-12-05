Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12586804545
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344326AbjLECol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjLECoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:44:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2FD1BCC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:44:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C401C433CD;
        Tue,  5 Dec 2023 02:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701744248;
        bh=+vaehnyGBwsYfA73YriN0Q6j6b8ok5Vd+IkndBBTTDY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D92fC8RR1BS7la11RrCDi0nvg78+QgLm8aN6rcwqMdkzkF9tOYxB34GalxyQ/nXB0
         lDKmGQSFQGg2H0py5nNdVw245XRn5AtiYVI3s/BLYzChBaeBKsBJh2c9hW1ivX70eT
         dOqjEU7+hNMA1psrs+KCpXDF6wLux/m6nV5CnUp8gpyVp9yEEzMhdZlsa8a3++St4w
         wqntoU8i0FE4I6um4Ba0fhKAWmS31LhHlyEnVxGZGtGw8mYFFSnhCKyNsduaVADGSo
         q5mR+TM66fMDsWGVOg/xj6VTTuUYrq/mqMprFL7kiKcBUcBcnxFKd551auOgPksgDF
         Y0BxOA0l0dm8g==
Date:   Mon, 4 Dec 2023 18:44:06 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v6 3/6] ptp: clockmatrix: Fix u8 -> u16,
 DPLL_WF_TIMER and DPLL_WP_TIMER are 2-byte registers
Message-ID: <20231204184406.4c154e28@kernel.org>
In-Reply-To: <PH7PR03MB70643CB46D5BA34397181500A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
References: <20231130184634.22577-1-lnimi@hotmail.com>
        <PH7PR03MB70643CB46D5BA34397181500A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 13:46:31 -0500 Min Li wrote:
> Subject: [PATCH net-next v6 3/6] ptp: clockmatrix: Fix u8 -> u16, DPLL_WF_TIMER and DPLL_WP_TIMER are 2-byte registers

> From: Min Li <min.li.xe@renesas.com>

Thanks for the changes, much easier to review now.
This patch, however, should be squashed with the previous one.
