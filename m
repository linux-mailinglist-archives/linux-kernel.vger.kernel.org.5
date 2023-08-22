Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C29378487C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjHVRiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHVRiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DBA827AE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 912726130D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4DFC433C7;
        Tue, 22 Aug 2023 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692725872;
        bh=cgwoAZ+oPhXsfMPQkJe9+jL333w4VKeyDL7/7MY3uVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XFbf+y4ZAmZjqLp384mR9qzZ3/xySAqrVNcjnxSAE/PESVlDyx+E1SmXsW0Perlzr
         jsWVI0d7rfNu1XxmjAf3BASKqtWIFf5kbEuS4sbplfSe9luKEpUdqkmkao8lcBAfwT
         G4pcCXRGAmxWLA4kqzojJ9z8kFFrRxCeD/CuQwjXnHL6qS5q3TGL0Q9gTIDZIOE9s/
         5sgTiQqCyF/A0KM/ZDQUhApTYcBPIwpFDs7fysSDRg68qeoSGBEFqrgdwuCEeC7u8K
         pFFQSA4UQP5VYOh07bIXyTTY/co/9gNNN9uvyQoZ8WQO95C9N6QAYjLEbPb6MgMq3g
         aw+Tekz3P06aQ==
Date:   Tue, 22 Aug 2023 10:37:50 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <jiri@resnulli.us>, <andrew@lunn.ch>
Subject: Re: [PATCH net-next v6 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <20230822103750.6dbb6fc2@kernel.org>
In-Reply-To: <20230822031805.4752-2-justinlai0215@realtek.com>
References: <20230822031805.4752-1-justinlai0215@realtek.com>
        <20230822031805.4752-2-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 11:18:04 +0800 Justin Lai wrote:
>  drivers/net/ethernet/realtek/rtase/rtase.h    |  372 +++
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 2432 +++++++++++++++++
>  5 files changed, 2832 insertions(+)

Please split this into multiple patches, I already asked you to do so.

Individual ethtool ops and vlan support should be separate patches,
perhaps you can separate other features out, too.
