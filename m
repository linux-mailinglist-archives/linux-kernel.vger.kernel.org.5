Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3997C920D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 03:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjJNBNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 21:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNBNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 21:13:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555D995;
        Fri, 13 Oct 2023 18:13:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED41C433C7;
        Sat, 14 Oct 2023 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697245987;
        bh=n50kcxXI9A3yMV6jxB8NrEwZdjVrYAXqsMjPwBDWtY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rNoygbMPeUIwtR64hZ7Q9YWWviszucUMdTDI1AIStFs/rvaOC69pt3n9quzesBklA
         QSAIC1b1su7cYyKrsjrSTAbSJNA4+Eq/7vBX5pRwX8JuEkD1u442a7Qz3sYL+tVjH6
         DtAOwHRgKy++OtzgwGKsxXIbNu+45VYfWHcjhYJQ3c4tcxjIq82FPKlNLawkVoEGyY
         cl9plrQrT7vQesR4b8c1y7wnQKg5AQQmi5XkP4EyaDQ0pLKwAM/TShTPymf0aWp0Q8
         x+qbRJu+c+B0N/m1qoJ5lnrHiHRS12f5N8pv67DNwUMkG+F1sdMpEoX2V6CcSyIQ8c
         9HlJizg1+GI/w==
Date:   Fri, 13 Oct 2023 18:13:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/4] net: stmmac: move TX timer arm after
 DMA enable
Message-ID: <20231013181305.605fc789@kernel.org>
In-Reply-To: <20231012100459.6158-4-ansuelsmth@gmail.com>
References: <20231012100459.6158-1-ansuelsmth@gmail.com>
        <20231012100459.6158-4-ansuelsmth@gmail.com>
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

On Thu, 12 Oct 2023 12:04:58 +0200 Christian Marangi wrote:
> +static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue

missing comma at the end, does not build :(
-- 
pw-bot: cr
