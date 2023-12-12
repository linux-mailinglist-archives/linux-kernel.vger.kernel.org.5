Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814A880F7EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377364AbjLLUao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377358AbjLLUan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:30:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C88999
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:30:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC0AC433C8;
        Tue, 12 Dec 2023 20:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702413049;
        bh=y8vlYmhIK7DL2ublK44Rokjsp/ohlcxBMr8GRcCvbLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJMxuU04j+ovQ73NpiIVK/rnB0bYVPAHXVYMi31q9vxg88yZpZdrE8gq0SiZMDtm0
         uGQsOu1Q+T5mPoyclLIauTmwZSIBIF9BejaD/NtO6mPLYs22BH56fEqlBu6kez/mcx
         CSntD2P5VXA1spcGk6mRzOOEVRSBqf7zk7xfj1jDAgRveS+QP5DyHFH3+CNppuFjkb
         Mxfal8cLIQtAn9NlGfbHPiubVUT1ZSoA3lcT9nTvCD4LxaULd2quZHCzDslWfwtzGf
         wQgKrmSJoIjFK5Dcam+f2uQR0B/T3GYpWDg0hfW/sxNJbs9UKeaGwgXE9lqTUVmCiu
         wRXmordw+Nb7w==
Date:   Tue, 12 Dec 2023 20:30:43 +0000
From:   Simon Horman <horms@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Tariq Toukan <tariqt@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mlx4: Fix spelling mistake: "mape" -> "map"
Message-ID: <20231212203043.GF5817@kernel.org>
References: <20231209225135.4055334-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209225135.4055334-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 10:51:35PM +0000, Colin Ian King wrote:
> There is a spelling mistake in a mlx4_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Hi Colin,

I am guessing that you are focusing on error messages and other user-facing
spelling errors (perhaps you told me f2f in the hallway track at Kernel
Recipes).  But I do wonder if you have plans to address other spelling
errors in this driver. codespell flags many, including 'segements' in a
comment in the same file.

In any case,

Reviewed-by: Simon Horman <horms@kernel.org>
