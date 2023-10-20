Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DA67D19B5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjJTXu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjJTXuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:50:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9675D6B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 16:50:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF7AC433C9;
        Fri, 20 Oct 2023 23:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697845849;
        bh=rD7i5HWfwFAX1Xen8caIl4ANRUZrjeYhCRejmepVOaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u9Qcrij8zEyJ81UKuhvdfHd9FG5ySDX9V3mhYiV7QnK4tZkpk2Yyo21/3m47v65Qc
         JvvhNaZ85DL4OsBJ/gCXR6sMa8w18eiZSbLkmFKSS0EOwMwwcPgPIDSIzjed/xmcet
         OYFbnu9Zj3iFMDYX6V8Q0rcowAcpYaQRxhRqfqZ274zxEfq3gnddfGj6I4fKjYU53W
         rAeBUNi9uXWuXckxGmePshU7v7CiBy/V5w05B1oGxUsh3pr0xfFkLbZZx8OEL+fbbj
         zYP4bKRs9s62bAM0aJY4u0MPmGVJEpayqi52QE1vcWM8htBEKC50tVdJ4e3Uir2zc2
         ojqHp/DjRDfdw==
Date:   Fri, 20 Oct 2023 16:50:48 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 1/3] r8169: fix the KCSAN reported data-race in
 rtl_tx() while reading tp->cur_tx
Message-ID: <20231020165048.33d3bff2@kernel.org>
In-Reply-To: <20231018193434.344176-1-mirsad.todorovac@alu.unizg.hr>
References: <20231018193434.344176-1-mirsad.todorovac@alu.unizg.hr>
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

On Wed, 18 Oct 2023 21:34:34 +0200 Mirsad Goran Todorovac wrote:
> KCSAN reported the following data-race:

All 3 patches seem to have been applied to net, thank you!
