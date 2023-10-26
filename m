Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A187D8BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344860AbjJZWsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJZWsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:48:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9341A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 15:48:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D820C433C7;
        Thu, 26 Oct 2023 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698360494;
        bh=ZUUtoMOmeBlBhtXVE8Cuph61LHIPCHr9OivK6H+jN9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T6esuD2BlPH6biLwr8jtZD5TxnvxuRsQMbLxkLknEWrLkjcKo7pi10Llnxe5PNx1E
         qMtV4YcuRGU8Pypz7aHC8Vr8VAO1mQ9b9lOaSxAqC2nULonFyS/n78aNKyf4l81OuE
         v3PfRZswkASw0xXVCAYJuyY+qgsUXhIuHazSoffByqiDcxLTfT2tfq1Dr6A8JChVLw
         dkz3wcO24zWVR7KGPNGMOatGh/1ediUsPcUMyWvrz7mo2RzNCl3vHwDtQYdzLUf6jO
         iWGHC/2YR7YwWsrUW+bw/idR/c3KdU06o8E4AgAKnXljKctm7rGZrBwAp9n6MfJ85E
         ysr1S+h7YtyQQ==
Date:   Thu, 26 Oct 2023 15:48:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>, Simon Horman <horms@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next] net/mlx5: fix uninit value use
Message-ID: <20231026154813.4682f7b8@kernel.org>
In-Reply-To: <ZTrkzRi1g3TknBdj@x130>
References: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>
        <ZTrkzRi1g3TknBdj@x130>
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

On Thu, 26 Oct 2023 15:14:37 -0700 Saeed Mahameed wrote:
> >Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> >Link: https://lore.kernel.org/netdev/8bd30131-c9f2-4075-a575-7fa2793a1760@moroto.mountain
> >Fixes: d17f98bf7cc9 ("net/mlx5: devlink health: use retained error fmsg API")
> >Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>  
> 
> Applied to net-next-mlx5

Given the hold up with your PR I prefer to take this directly, thanks.
