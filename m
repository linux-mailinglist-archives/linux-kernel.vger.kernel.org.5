Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA13A776C29
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjHIW0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjHIW0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:26:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDB5B2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:26:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC4B64B2E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD1BC433C7;
        Wed,  9 Aug 2023 22:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691619998;
        bh=D86GAVma+0XKP4Z8hF6yc63R4h8X8o+QwNFVeaE3SjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HTFySCuPBdNPIER5Y7kPQ3iaxpQ/VJW8QTf5UuEQceOeOeLQR15lf7coUzMkMYo6N
         N/N9fouxUaNUIYoKJmTIWj4e/g88sqdU58pnJAit91LUaB3A2lJBiyrF2QR0+p6o0R
         OZWT95ZdhBaAz0yvyx3Y5E0/mNAiPzulfVimj9Pox4CauzURq4+Dkd6shNlFwgOwo7
         RTkgCkaJJvHGtUGxlSgNXSlhJKeZ9ZnOhuJmUbUpIUwSpJ6TlJspAgHb9vn9x3GL3P
         rzfdEEpqA6agZXgA8+SH3pi6I8+jd2vVVaFMEi6NiAcFzxq0t0jTFUUyV9lX8KYyWe
         PoRt0+yWYkFCQ==
Date:   Wed, 9 Aug 2023 15:26:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [net Patch] octeontx2-pf: Allow both ntuple and TC features on
 the interface
Message-ID: <20230809152637.17888c9b@kernel.org>
In-Reply-To: <20230808063623.22595-1-hkelam@marvell.com>
References: <20230808063623.22595-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 12:06:23 +0530 Hariprasad Kelam wrote:
> The current implementation does not allow the user to enable both
> hw-tc-offload and ntuple features on the interface. These checks
> are added as TC flower offload and ntuple features internally configures
> the same hardware resource MCAM. But TC HTB offload configures the
> transmit scheduler which can be safely enabled on the interface with
> ntuple feature.
> 
> This patch fixes the issue by relaxing the checks and ensures
> only TC flower offload and ntuple features are mutually exclusive.

Not enabling a feature is not a bug. And it will cause conflicts 
with net-next. Resend for net-next without the Fixes tag, please.
-- 
pw-bot: cr
