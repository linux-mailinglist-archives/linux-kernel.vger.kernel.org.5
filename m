Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319897BBA32
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjJFO0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjJFO0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:26:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B14C6;
        Fri,  6 Oct 2023 07:26:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FA0C433C8;
        Fri,  6 Oct 2023 14:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696602375;
        bh=HeJt1ypgXjuNt6xsHJELoxplYIVXB8WYLchsi/6sW6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sFSZ0SnmSt3PzAwq+R36W2yRhX5h4mxS94LXVggXe39rWkSZVM9r1XmNQEHQG0IMQ
         nI9Dz7oHFVGPNY7CAw+f3tdJ7JLTp+jRlp7sY20i1rdtMHUKE+ub6kWI1dSHB6EbSM
         laAK+dB/aCsOtseu5+aNxqdyd+mTdIwWiG7BAtpY0couefipNz6aZLMU70/N2MnokS
         748yL8stY62k5zgoOPW0/InhyIOMELvvl5Eda8pkrHKp0rWmf3xg+UbV8vbDx9j7rf
         /6nsPVyEXfnV6OEu6Evn6lo801QWXUuiKZuPG4vbCJiTVXLdl49OTY8SEEtslBuu9V
         GhC2IK48U8M4g==
Date:   Fri, 6 Oct 2023 07:26:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] net: cpmac: remove driver to prepare
 for platform removal
Message-ID: <20231006072614.33f68e2f@kernel.org>
In-Reply-To: <20230922061530.3121-6-wsa+renesas@sang-engineering.com>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
        <20230922061530.3121-6-wsa+renesas@sang-engineering.com>
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

On Fri, 22 Sep 2023 08:15:26 +0200 Wolfram Sang wrote:
> AR7 is going to be removed from the Kernel, so remove its networking
> support in form of the cpmac driver. This allows us to remove the
> platform because this driver includes a platform specific header.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to net-next (98bdeae9502b), thanks!
