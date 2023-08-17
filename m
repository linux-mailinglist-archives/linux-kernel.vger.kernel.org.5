Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F6477FB44
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353353AbjHQPx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353371AbjHQPxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6354630D4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8D6B6242D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282D8C433C7;
        Thu, 17 Aug 2023 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692287595;
        bh=GI7bsJEXllKrx04dcqP4aAQbJejYQRK+vrqF+j3kz2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AxuV6tErwgyi8sPCCLm58zhxU877tvhj+jq+WWyXMzzT2g/Fqcqoz5REAQQdr0fPq
         WUdyNHwncnCzDz64b0J19R1lk6T3HrsE3tpEt8D7Oj+qIch7l+7bbM8OEMPHobCIPF
         jMzn+PoKlcg2z0XNQuVqkJtysGBAUH9mBy9t9FjrcWx0qgqxLSndFXcHY1fa+JuiIU
         tg0CFwnO//Ddkt4LzR0z2SSlN3NlLnXvscOgPQKvCJc03fODY8378SRss3+NIPf9uV
         2GtmI9yucV1IeFa/DSSAKVvV9KkOpF3dMqATGrLNOc9AIYytT+GVXYnLtB3CzWf5r2
         ZQ82e505w/sdw==
Date:   Thu, 17 Aug 2023 08:53:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <20230817085314.1c8b567f@kernel.org>
In-Reply-To: <20230815143756.106623-2-justinlai0215@realtek.com>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
        <20230815143756.106623-2-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023 22:37:55 +0800 Justin Lai wrote:
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 2696 +++++++++++++++++
>  5 files changed, 3127 insertions(+)

Please try to make this patch smaller, usually breaking out ethtool
operations and any offloads to separate patches does the trick.
Keep in mind the driver must be operational after each patch.
