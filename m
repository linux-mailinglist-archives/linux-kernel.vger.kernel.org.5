Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FE076609E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjG1AP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjG1APy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:15:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA83194
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5926E61F5F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44748C433C7;
        Fri, 28 Jul 2023 00:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690503352;
        bh=qO4orcqKIyixzmIclS1d/jfz4X+1nmlz+rtM+R1Fxos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LobF8n518Uk7LAFEXo5QKP3w6kV5tGfANO6/cFDubUC8bnhwYaicNcoDykkloTom+
         U5FUaRwtxyZ6FL16q8fCCFCBXRKBnDCq13kQecKp2NBJlgVRQP/+PfWalXXpd7XJbo
         q3GmY3PZPd025cMREcBcgrnAK9SZEcTZVza909aZcKDnunX9RiCcBvU9todEt2eHxn
         ymTC5AdZ0YJzlHLiorrN/JFGo7Rnjk7bhtLHualsDsm317FLCVkpvYsYVo0JUqfCm5
         mLfcyBTA4TD8sFMG8Kphmb17L/Vvu2lQlV1BrCfvgPdvP6Do97k2AB8X5NrH2xMKhk
         t26B14KayTlOg==
Date:   Thu, 27 Jul 2023 17:15:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        razor@blackwall.org, idosch@nvidia.com, lucien.xin@gmail.com,
        liuhangbin@gmail.com, edwin.peer@broadcom.com, jiri@resnulli.us,
        md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com,
        jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
Message-ID: <20230727171551.28b7504d@kernel.org>
In-Reply-To: <20230726075314.1059224-1-linma@zju.edu.cn>
References: <20230726075314.1059224-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 15:53:14 +0800 Lin Ma wrote:
> V2 -> V3: add net subject prefix and Acked-by tag

Because of the repost this patch didn't make it in time to today's
PR and you'll have to wait another week before posting the cleanup
of the drivers :(
