Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321687DC78B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbjJaHpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjJaHpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:45:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4DBC1;
        Tue, 31 Oct 2023 00:45:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865D6C433C7;
        Tue, 31 Oct 2023 07:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698738335;
        bh=NLwwmbwwqCvtjN1OuNUTkMJw4NZmW5mM/PG/LUZj3yQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Rfk3Xm2TAO9J0XEURs8VKXDgjneyf4OxmZpDmsMj+M9Y3x0+hfvqLXcAXqKL1ps06
         U67INSuHVjYfeEjPSD4rmM/Xmz5vUIYDNigLLaTfXGCSOb5DBCOC9Dc9UeCT019G6W
         C+KZ2PoPmVx5Mzt81CxsGL8SYxQD3BeyLKILRnKAazybnTTU8lOKZc4iwe/rBmwUKV
         c259/yt60sBsgVNC/dYrf7a7UPLfQaXxA4zt8qt6dez8XG8FDBiDyvs00r6fbcERS+
         bIkvnRd2ZodNuQFrK2YcJTbQh/21QwOnsa7/qAYK3XFzXvc894+Z1lC0xlzUs7p8+3
         H/SnnQ9wr9+5g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: drop NULL pointer check in
 ath12k_update_per_peer_tx_stats()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231013074711.2202850-1-make_ruc2021@163.com>
References: <20231013074711.2202850-1-make_ruc2021@163.com>
To:     Ma Ke <make_ruc2021@163.com>
Cc:     quic_jjohnson@quicinc.com, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169873833230.2137176.1125391865101568519.kvalo@kernel.org>
Date:   Tue, 31 Oct 2023 07:45:34 +0000 (UTC)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ma Ke <make_ruc2021@163.com> wrote:

> Since 'user_stats' is a fixed-size array of 'struct htt_ppdu_user_stats'
> in 'struct htt_ppdu_stats', any of its member can't be NULL and so
> relevant check may be dropped.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

56d9854bd7c6 wifi: ath12k: drop NULL pointer check in ath12k_update_per_peer_tx_stats()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231013074711.2202850-1-make_ruc2021@163.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

