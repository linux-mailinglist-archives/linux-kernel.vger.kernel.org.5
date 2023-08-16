Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470F577E3AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343643AbjHPOd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343641AbjHPOdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:33:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599BA268F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB747668B8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBBDC433C7;
        Wed, 16 Aug 2023 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692196418;
        bh=uBcRHsMTUoYVy2HBvf3JZKX9X9ZqfUDAJoCf9LSgY4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+OGP/VbzXjXdrHswwh+/ZMzRMfZH70glJ3aHxAIl8BVDlkmq9cKSTtEEdSSFDMMt
         Tggi+SCGBQ0qYOfEtv05Y5xeTn1gdMy0DNElJMPDSHjWy8EIiQqToWIz+QBXUOczCV
         2eTF1WGoZkCqf9mOJZnWFrJ83rv4ovjx0qm7sI/KVadm8QAfIPFuiQjaV+G1BLZMJh
         D8od7XFusuqarcQ8y2kiVV1C5Uuze2TkoFORmGk9C942NDo/D8790SE9ur6u8lnkQG
         Y4EHBmpXBZnCiPag0gk2nhUeZNPUf9buvJzXTVlXF1yqb7Ecj8IUTVrUzrH6pkiSA4
         clzw1OAvO4hlA==
Date:   Wed, 16 Aug 2023 17:33:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.duyck@gmail.com,
        xiaoning.wang@nxp.com, shenwei.wang@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH net-next] net: fec: use napi_consume_skb() in
 fec_enet_tx_queue()
Message-ID: <20230816143334.GZ22185@unreal>
References: <20230816090242.463822-1-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816090242.463822-1-wei.fang@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 05:02:42PM +0800, Wei Fang wrote:
> Now that the "budget" is passed into fec_enet_tx_queue(), one
> optimization we can do is to use napi_consume_skb() to instead
> of dev_kfree_skb_any().
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Suggested-by: Alexander H Duyck <alexander.duyck@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
