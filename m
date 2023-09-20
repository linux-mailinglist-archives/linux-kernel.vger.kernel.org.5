Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C657C7A7DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbjITMNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjITMNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:13:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE69E83
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:13:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEE7C433C8;
        Wed, 20 Sep 2023 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695212022;
        bh=w35NVCF/9jrWrU7dz2MW5dG9O6dNltiuqDlKeN+hdFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mDw3v21nQ5LONESfyMampQ1RUlVjQDqSp94A9FR14sYQTg4jCMaEIuIbZF9HgmJM2
         HZZCKheDyFLwta8yHDw2XDokrJtUyNcIovu9JHB3tav3bJHjqIO6QNCpp01VnMq+b5
         4NYqyHPxl+iXd6ArqwGs+BnAdEhRPtkxZz6bpbgZLA040kntxxekB+Y2X/pCItXfJ1
         2fxerI41PyibBLL2/pUoBwGXtqR/KFs4GODrZky3nJoHkx5Tp9uQiPQPu7DkBGPvf8
         8uHlSC+EZr8+c40oRhyR4AuBklJ59IHVdW9UuQtT0A9vIPJzS4xtdsz4M1josb/E2P
         F0zfPjfcMhwwQ==
Date:   Wed, 20 Sep 2023 13:13:38 +0100
From:   Lee Jones <lee@kernel.org>
To:     sunying@nj.iscas.ac.cn
Cc:     linux-kernel@vger.kernel.org, renyanjie01@gmail.com,
        pengpeng@iscas.ac.cn
Subject: Re: [PATCH] mfd: ab8500: remove non-existent configuration "#ifdef
 CONFIG_AB8500_DEBUG"
Message-ID: <20230920121338.GE13143@google.com>
References: <20230913084559.18141-1-sunying@nj.iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230913084559.18141-1-sunying@nj.iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023, sunying@nj.iscas.ac.cn wrote:

> From: Ying Sun <sunying@nj.iscas.ac.cn>
> 
> The CONFIG_AB8500_DEBUG has been deleted in
>  [PATCH]mfd: ab8500: Drop debugfs module.

In future please use the following format when referencing commits:

  3d4d1266597c0 ("mfd: ab8500: Drop debugfs module")

I have fixed this for you this time.

> The condition "#ifdef CONFIG_AB8500_DEBUG" in
>  include/linux/mfd/abx500/ab8500.h:502
>  cannot be valid. It is recommended to delete redundant code.
> 
> Suggested-by: Yanjie Ren <renyanjie01@gmail.com>
> Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
> ---
>  include/linux/mfd/abx500/ab8500.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
> index 09fb3c56e7d7..76d326ea8eba 100644
> --- a/include/linux/mfd/abx500/ab8500.h
> +++ b/include/linux/mfd/abx500/ab8500.h
> @@ -499,13 +499,7 @@ static inline int is_ab9540_2p0_or_earlier(struct ab8500 *ab)
>  
>  void ab8500_override_turn_on_stat(u8 mask, u8 set);
>  
> -#ifdef CONFIG_AB8500_DEBUG
> -extern int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size);
> -void ab8500_dump_all_banks(struct device *dev);
> -void ab8500_debug_register_interrupt(int line);
> -#else
>  static inline void ab8500_dump_all_banks(struct device *dev) {}
>  static inline void ab8500_debug_register_interrupt(int line) {}
> -#endif
>  
>  #endif /* MFD_AB8500_H */
> -- 
> 2.17.1
> 

-- 
Lee Jones [李琼斯]
