Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070E77EC973
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjKORLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKORLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:11:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F6218E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:11:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC51C433C8;
        Wed, 15 Nov 2023 17:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700068269;
        bh=vlsYtScBbAr4UMoA0iR2Mneor4acUxG23D75vzElABo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzXjoF/WMJal17q+ByRWz+qs8gIzdTE3oFcPdUTGO5Dbtk/mRUxx5op6X1uMSGNGO
         AtDR0Zxt6AlonWztG5UeNiftH5uWJ5Kl0/AJc9HJ0GoG6V0yspBcn+vpO/pGzu+ZxD
         aqfG2y3sCh7dKcRGbh2M4UXdTr3lJ39GmqRSLUop+OKbfhwCmUw5cnkPNiIV2oCjxm
         3+222+dJ8cbY3lO9NoFuVNMW1iS3ZXyrmHifEoDs6pMLxeGhme/Qn1t4bAqSCdP2QY
         REC/CHMf4Sp0QHjRxJBnMBund3obUwo3GrBUW1ERj/dfdbWmZXbn/iTjlxUwinRcxm
         JlTr65BKQQjEg==
Date:   Wed, 15 Nov 2023 17:11:05 +0000
From:   Simon Horman <horms@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] stmmac: dwmac-loongson: Add architecture dependency
Message-ID: <20231115171105.GS74656@kernel.org>
References: <20231115115331.19eb0c24@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115115331.19eb0c24@endymion.delvare>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:53:31AM +0100, Jean Delvare wrote:
> Only present the DWMAC_LOONGSON option on architectures where it can
> actually be used.
> 
> This follows the same logic as the DWMAC_INTEL option.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> Changes since v1:
> * Enable build testing (suggested by Simon Horman)

Thanks for the update, this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
