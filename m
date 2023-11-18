Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD577F032D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 23:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKRWux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 17:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRWuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 17:50:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CBE131
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 14:50:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F40C433C8;
        Sat, 18 Nov 2023 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700347847;
        bh=uQ/ZSMcPli58vrb2wZICC9Grz2rXBkOrQowxrcXgkO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AVadxAymdMxzQOCkCvQNww/5PBBPuoRgATXpsklBGLOebAkssLi332HEOy35Wec8i
         b9cpyaf6Po7KG2unaQ/Zx1JMKN6vTOyXVrfxcbg6le6lZOXggwqJa2GZzwmBzZRBjV
         dt7FkjEOJnbBHezfTyQBE1TN98HILGaQaW0MyjAe1jY/q/EBHZ+MEYYsdh9hyD6Osq
         dZplJYKsGZzzesycWyKVuzxoDdTfrHBd1MD0/cBKNAueid3ty9M2e1nppWIOlvlm+v
         9e/9xFfxbyzMAHJu3dGTKj7VMvt3slTHvgnlcTm981hek7dGv61L95i7bT9Ip8pRnK
         +ObAfK5ZGSQqw==
Date:   Sat, 18 Nov 2023 14:50:46 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v11 05/13] net:ethernet:realtek:rtase:
 Implement hardware configuration function
Message-ID: <20231118145046.7bb8efca@kernel.org>
In-Reply-To: <20231115133414.1221480-6-justinlai0215@realtek.com>
References: <20231115133414.1221480-1-justinlai0215@realtek.com>
        <20231115133414.1221480-6-justinlai0215@realtek.com>
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

On Wed, 15 Nov 2023 21:34:06 +0800 Justin Lai wrote:
> +	.ndo_vlan_rx_add_vid = rtase_vlan_rx_add_vid,
> +	.ndo_vlan_rx_kill_vid = rtase_vlan_rx_kill_vid,
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +	.ndo_poll_controller = rtase_netpoll,
> +#endif
> +	.ndo_setup_tc = rtase_setup_tc,

This patch is still way too huge. Please remove more functionality 
from the initial version of the driver. You certainly don't need VLAN
support or CBS offload to pass packets.
