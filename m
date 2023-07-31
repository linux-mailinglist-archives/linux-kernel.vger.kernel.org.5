Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CE976A24E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjGaVAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjGaVAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E752D1997
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8587161298
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 21:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86073C433C8;
        Mon, 31 Jul 2023 21:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690837245;
        bh=KL21ST4EEQnhv5fxf57IORwltkN1VqU/fjD0I4RXt3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EWQxSUIQ51uFFnekenk1T77nLQlcED+dQZZmEdJx5NZppeiDy6vxqCHeINARAUP4N
         GRr68CZsDKGXjkQiBfuc9kmDK/FPrGK95N/0dAYtQDYG8Hfn5H8AFd0HdqZsjFhHRX
         kAQ4asby07QY7US5WtyBw4jD8qSKpBhr4xPf49/vZTKtPOczYZRlmUFBIPciBivcRQ
         +PavYut1Dh/TvSPin1xjulQWS2qlBdt297pG+iTKuT0/he1GVl/5inO/1+ZAliNkvu
         G1UC0y+WdlKI4hcx3dHAUKhYnfOygA6RWxGVj7jffDfNL+ltOYMIllHuu+Ap9rzZnU
         6z7hNupUWkI6A==
Date:   Mon, 31 Jul 2023 14:00:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     <netdev@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <20230731140043.28a42c8f@kernel.org>
In-Reply-To: <20230727082550.15254-1-ante.knezic@helmholz.de>
References: <20230727082550.15254-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 10:25:50 +0200 Ante Knezic wrote:
> Fixes XAUI/RXAUI lane alignment errors.
> Issue causes dropped packets when trying to communicate over
> fiber via SERDES lanes of port 9 and 10.
> Errata document applies only to 88E6190X and 88E6390X devices.
> Requires poking in undocumented registers.

Looks like the patch was set to Changes Requested in patchwork:

https://patchwork.kernel.org/project/netdevbpf/patch/20230727082550.15254-1-ante.knezic@helmholz.de/

Presumably due to lack of CC and/or Ack from Russell.
Could you repost with Russell included?
