Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22B777FC23
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351892AbjHQQa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352002AbjHQQau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DFBE2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:30:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ECB8644CC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51024C433C8;
        Thu, 17 Aug 2023 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692289848;
        bh=ltwTI0YOVOhXNo5fZPWlYF6RrBeTO7y8wp8NcJ4OnaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T/C7YCO3f4zJ0aXbqvxTuiIVXZYExo8q5pPI9k0xjhG1xGfFbbBfxntldYArAF5C0
         q2Jyl6ueTOatoKIRIxmvGLC/XKOJtfwzKlY6We2HqljYDkC0ME17uI1OZjY9Uxsq+F
         0PE7QZ5qoV4pjtyZ3WsrTarxehWJGbqNIJ64+2tE1ULZ1U22Y6Za0DawIToSZUaO24
         hQG3val954kG7I9RCsGAwe9Vfjkm+lWU7NDtADNwLR9GmD0zqLGapLOtg2svvxMQQ8
         5bZk+tdPEj3GUPOOlcn31vu/45mbKKhxSSO/37dMW1z8VXEt2b7cUbi0dLnJg2eaKf
         xL/TwwCSYpajQ==
Date:   Thu, 17 Aug 2023 09:30:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Josua Mayer <josua@solid-run.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: sfp: handle 100G/25G active optical cables in
 sfp_parse_support
Message-ID: <20230817093047.28a2b11d@kernel.org>
In-Reply-To: <20230814141739.25552-1-josua@solid-run.com>
References: <20230814141739.25552-1-josua@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 16:17:39 +0200 Josua Mayer wrote:
> Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
> for active optical cables supporting 25G and 100G speeds.
> 
> Since the specification makes no statement about transmitter range, and
> as the specific sfp module that had been tested features only 2m fiber -
> short-range (SR) modes are selected.

FWIW this got marked as "changes requested" in patchwork by DaveM.
Since we didn't get an Ack from Russell, would you mind fixing
the comment style and reposting?
