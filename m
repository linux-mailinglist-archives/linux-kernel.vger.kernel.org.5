Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386D677F5B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350491AbjHQLvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350522AbjHQLux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:50:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFF6E4F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11209642F9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E13C433C8;
        Thu, 17 Aug 2023 11:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692273051;
        bh=i1QqOJSzjXCJNcSY0s2TunOZ6EDSGT6CMl0nct6rPwU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ECUy4GsW14Dg4dNAVKuphSK0UmGailBH0vM6iwVetwKp2R+1IFrougTXHqhcXuojO
         8+XggaPF98lp89WHYgmFMgjhsxjKY5RoNFWLnw72POC5LBmMla5b6yvX4uFcaJVBY9
         ORDCwFUehATUmfXvd7xuUzS+aVM/OHM9Wj5jk7uUIVNi3CUOgf+SA8LgKCdjwFKHee
         rKWuTNAd47YBUnwH0JlZEuKytOlEXFquHzWYvHxXRljSGfxg2AHaV9Khy59jZzoxVo
         LrRDEkbV2Vv8GkyIOpQyCI84jqLV5/PT+AGhP/Xww11zWginOG/dNACHS+j9FS4jZv
         0zbRRCwl6m1/w==
From:   Lee Jones <lee@kernel.org>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     bot@kernelci.org, lee@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230817114505.1810920-1-lizetao1@huawei.com>
References: <20230802092342.970476-1-lizetao1@huawei.com>
 <20230817114505.1810920-1-lizetao1@huawei.com>
Subject: Re: (subset) [PATCH -next v2] mfd: ipaq-micro: Remove unused
 variable i in micro_rx_msg()
Message-Id: <169227305026.1008224.16033778480321111075.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 12:50:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 19:45:05 +0800, Li Zetao wrote:
> There is a warning reported by kernel test robot:
> 
> drivers/mfd/ipaq-micro.c:81:6: warning:
> 	unused variable ‘i’ [-Wunused-variable]
> 
> Since the commit 92d82d76c842 ("mfd: ipaq-micro: Use %*ph for printing
> hexdump of a small buffer"), the variable 'i' is unused. Remove it to
> silence the warning.
> 
> [...]

Applied, thanks!

[1/1] mfd: ipaq-micro: Remove unused variable i in micro_rx_msg()
      commit: 1cda16fd366ffce79c11838fea9e627d2e9d9fea

--
Lee Jones [李琼斯]

