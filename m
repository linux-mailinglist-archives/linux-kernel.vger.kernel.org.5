Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B547B8514
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243376AbjJDQ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbjJDQ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:26:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A8CAB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:26:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BA5C433C9;
        Wed,  4 Oct 2023 16:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696436775;
        bh=qcglxAxRgYQIz8E0bCy+wEqQLr5U4t9luHiOQaUV2Fo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jxa2ZLLsxGRvLwcvTQldZ96adZlICmJQJRLEB/ssJiEoxmM9MPQTVgiIQ3XkDC7fM
         bdogyPB07dsycbtlyP2aSNKv6SPPCpDh9joLzDX0roO/N1X+uFhAFmbVoW6mpAf3qx
         lVNe3tqlHYazhWBRPb641wMYKdzKEOgrLArUd7/fPhLs6VplRj54mSUps/tOf9KoXO
         0b2qnNSzPrqwl+tLXEuyhDgPH94MxcRn0W/pk/BLl985bNouApvERtFuaSgnqGOriS
         OuwBw5rcjYuoZ5+6Z2EkEHNSeIC3GKPDFMGFknU4z0Fx/sv5cNZHBttoIDdgrKtKlE
         CYTTNiuLLXwNw==
Date:   Wed, 4 Oct 2023 09:26:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Rohan G Thomas <rohan.g.thomas@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts
 handling
Message-ID: <20231004092613.07cb393f@kernel.org>
In-Reply-To: <vwdy5d3xirgioeac3mo7ditkfxevwmwmweput3xziq6tafa3zl@vtxddkiv2tux>
References: <20230923031031.21434-1-rohan.g.thomas@intel.com>
        <xwcwjtyy5yx6pruoa3vmssnjzkbeahmfyym4e5lrq2efcwwiym@2upf4ko4mah5>
        <20231002135551.020f180c@kernel.org>
        <vwdy5d3xirgioeac3mo7ditkfxevwmwmweput3xziq6tafa3zl@vtxddkiv2tux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 14:12:15 +0300 Serge Semin wrote:
> If I didn't miss some details after that we'll have a common EST
> module utilized for both DW QoS Eth and DW XGMAC IP-cores.

So the question now is whether we want Rohan to do this conversion
_first_, in DW QoS 5, and then add xgmac part. Or the patch should
go in as is and you'll follow up with the conversion?
