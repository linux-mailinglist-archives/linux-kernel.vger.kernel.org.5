Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA12278166D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 03:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbjHSBde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 21:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbjHSBdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 21:33:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DE34206
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 18:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C78362B03
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 01:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA794C433C8;
        Sat, 19 Aug 2023 01:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692408795;
        bh=eQsDnVRcEoBkIR035KXsBsK1ZgEoecLvJBhlfQqPdvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oo2h163uvr5HkeY9eXN8I13GpuAxwj82iwdkWJRNvXGueeQjJzVI1wg2ww2kootiX
         BOVZEjnlMwvuagtOGJGXD+ULBRIQfFEwLJPBtTSvvhRmE2lvfkSgfJMGiWTWNUBl2d
         eTyxlrW/En3wvKguy8EPt/fnSJdJvAT24dS3aYurZN44OggxY2hzJ707984EvwAS9W
         BFzf8J57P3niIwJ14Kk309Z80y3ivkjKHJT83nrDEmttwQPFzuE1uXjenECTkDwWiX
         qBtqnSltRcmeOJJKhc4AEcTtN4nZlF/7ash+D3wKJZDjrrLQUnvknu8PrWTyiPErSx
         WVyc4zzWA3NJQ==
Date:   Fri, 18 Aug 2023 18:33:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix NULL pointer on hw
 reset
Message-ID: <20230818183313.52f9b9f3@kernel.org>
In-Reply-To: <6863f378a2a077701c60cea6ae654212e919d624.1692273610.git.daniel@makrotopia.org>
References: <6863f378a2a077701c60cea6ae654212e919d624.1692273610.git.daniel@makrotopia.org>
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

On Thu, 17 Aug 2023 13:01:11 +0100 Daniel Golle wrote:
> Initialize the hw_list will 0s and break out of both functions in case
> a hw_list entry is 0.

Static variables are always initialized to 0, I don't think that part
is need.
-- 
pw-bot: cr
