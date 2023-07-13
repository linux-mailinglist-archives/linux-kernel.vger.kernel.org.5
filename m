Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1878B752417
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjGMNm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjGMNm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:42:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106ACC1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2104612FC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51944C433C8;
        Thu, 13 Jul 2023 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689255745;
        bh=Pzvx/onzkFLeZHXmurZO43gv7Xi6QjhZYg5WaQZIbdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iw2YO4N9xwGBEPPMtdQHDE6nEVb+6gWjZq3DNx1c6rnomEZexGU9EMmEN1Gfg+77d
         E/M9NCwx3zCbzhYHDdjcIqZnt5CDm/zr3YyzaE6e9y6Sdpnoe3N5eNePrLTvUW1bIT
         5wOExWfCfsxj737uyvWKyyptMuL6lAnLjLbPLqV0xmS7OMY9fktt/tsOeWv0GDWith
         KO/xfi3oDjF566L1QiC6o532j3VeP2S9Ozo91THTkL7b2o1eafCY/ET7fuxur7J+M2
         6fytkL96d4vXg/VVXgnWn5Mj+EdzDETyfbd62/U/I4iPhJ9TkHin9LwO24xo/92mfO
         wboXpE65kwUDg==
Date:   Thu, 13 Jul 2023 14:42:21 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mfd: hi655x-pmic: Convert to
 devm_platform_ioremap_resource()
Message-ID: <20230713134221.GC10768@google.com>
References: <20230706113939.1178-1-frank.li@vivo.com>
 <20230706113939.1178-7-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706113939.1178-7-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023, Yangtao Li wrote:

> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/mfd/hi655x-pmic.c       | 3 +--
>  include/linux/mfd/hi655x-pmic.h | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
