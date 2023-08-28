Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1365078B8AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjH1TsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjH1Trs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:47:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300A5122
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9FA261DB6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66336C433C7;
        Mon, 28 Aug 2023 19:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693252065;
        bh=C4Ir9bNWumGZzSRtNes2Jz5ys6JqBziIumxbHwsTdO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pt2TiriD50KKRwOmmP5NpsaQE/9Yosb+AWCBsHFkuvx1YnDtVcr5cC1cMTTps4Ug2
         sxYBUqkIdoEo3hg9uQnrdU3hoDPs9s6hRQsaXt8wIa2SWNyIYhXFz6TWN9rx+zFqwe
         rDOgPOSjJDW3u+aLPC30xtSXRzOa09okhBs/XxYAre2ExymejyBtKIiHl1lwst4jcJ
         vfKYGIOf6HwZ4G0d0AyMkJI+vkqQwMkRFqmeBzUGBiLihfMoL/fLKlK7Wn7myHZKRZ
         hno996IvnfHCxH8vK2twXukWv8fKEiA4R5PU29wnMwWM3/ZOPOU2hKk1uahpHBTfdV
         w40ubq/+KxytQ==
Date:   Mon, 28 Aug 2023 12:47:43 -0700
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
        Russell King <linux@armlinux.org.uk>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: add paths and
 SerDes modes for MT7988
Message-ID: <20230828124743.4882a1a2@kernel.org>
In-Reply-To: <e6bb7c95c93e7ae91de998d2fd32580db2ce05c3.1693183332.git.daniel@makrotopia.org>
References: <e6bb7c95c93e7ae91de998d2fd32580db2ce05c3.1693183332.git.daniel@makrotopia.org>
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

On Mon, 28 Aug 2023 01:56:19 +0100 Daniel Golle wrote:
> MT7988 comes with a built-in 2.5G TP PHY as well as SerDes lanes to
> connect external PHYs or transceivers in USXGMII, 10GBase-R, 5GBase-R,
> 2500Base-X, 1000Base-X and Cisco SGMII interface modes.

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

