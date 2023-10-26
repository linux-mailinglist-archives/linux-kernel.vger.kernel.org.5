Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA6B7D8B88
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344897AbjJZWOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjJZWOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:14:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B6CC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 15:14:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3ECC433C7;
        Thu, 26 Oct 2023 22:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698358479;
        bh=wdtxi9YB4Q7u6/Z/exalHB5taKXwpbqqYgnzOSqDJYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOGBtMjlzkNafi0qHI+8/5DxxHZt/kBWocDwsMQVNApHs83eTyswpD4Mv5Nm18CdN
         fNDKPHzW8d1okDP91OssQumyw2cRR7mzn/515BMAAqAvuL4JAijQGs3Tqj3z4u3GjS
         /kJQOZpYNRFN2hIJ+AT6HqYVUdqTQV9NviN0J0tHl4Bw2cFozzVWVU0Q14CNh484io
         keq7sWuLvUpC2bAu+HHNFBfSDQexzWPWaRqQ3iRBwSbvMVRdaJa80xeUrpzeZvTD8P
         Prgs0SW1PfK+20KLMgnoCrMeSNPMjLdr751Hn36oVfpN//apZsjmt8CPWu0OtuiUFD
         b5FC/ZIUgZ4dg==
Date:   Thu, 26 Oct 2023 15:14:37 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <ZTrkzRi1g3TknBdj@x130>
References: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Oct 16:50, Przemek Kitszel wrote:
>Avoid use of uninitialized state variable.
>
>In case of mlx5e_tx_reporter_build_diagnose_output_sq_common() it's better
>to still collect other data than bail out entirely.
>
>Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>Link: https://lore.kernel.org/netdev/8bd30131-c9f2-4075-a575-7fa2793a1760@moroto.mountain
>Fixes: d17f98bf7cc9 ("net/mlx5: devlink health: use retained error fmsg API")
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


Applied to net-next-mlx5
