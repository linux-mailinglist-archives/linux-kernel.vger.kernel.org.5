Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553B876C8E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjHBJBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjHBJA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:00:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E068273B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E69506181B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA0BC433C7;
        Wed,  2 Aug 2023 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690966853;
        bh=S/vkfxkWrnp88I3Ppmf/4fzyKWNmnJ5WJw/ak8C1jw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cl15IMYFF0oFYh85fPyA5v1L0x8yFKz9jdYxXpjiH9AMPKOxvpYyPUN6LQEmR1CxV
         4xoyEJ4v9+Bg/+O0WG7a3oxji71vgm7mfYbZ5bRymmi7QAxUsjnv/CLyRtoOI+gdfE
         Ermb/xnIeytyj9rK4p7qqRF6VfDUGye8q0jkSu8ONvFMj61p+WpU1xw7wnbMK4OZfa
         YrJmEXvBhDnQDgy4pgCxJliKDTKDXgIPcdw5f0yZzi/LhhYXzjVDwTr/pdovwXKRmO
         BiJbsM1WgEwH94pU7yMJjIRcMUn01/YMCgYKsEJDjRY9VtOpkj359/uUcPlMi6/89N
         bgCHJzMSZ/Apg==
Date:   Wed, 2 Aug 2023 11:00:49 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     madalin.bucur@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, sean.anderson@seco.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH net-next v2] net: fman: Remove duplicated include in mac.c
Message-ID: <ZMobQezYzNWI+9ps@kernel.org>
References: <20230802005639.88395-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802005639.88395-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 08:56:39AM +0800, Yang Li wrote:
> ./drivers/net/ethernet/freescale/fman/mac.c: linux/of_platform.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6039
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
> 
> change in v2:
> --According to Simon's suggestion, make a slightly better prefix: net: fman: ...

Thanks.

Reviewed-by: Simon Horman <horms@kernel.org>
