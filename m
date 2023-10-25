Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD607D67A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjJYJ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYJ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:56:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670CB9C;
        Wed, 25 Oct 2023 02:56:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE110C433C8;
        Wed, 25 Oct 2023 09:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698227787;
        bh=Io+0mhN/DI2Tynf/rpk7RkkqXG4/7BUXxxxPDKfR8JY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Fv1NqmZjZ2c2hQMnMV4qc1/CVIJPxsGmw25WIcA1X1sjR5bwuHD+SW5jo8viVhlO0
         HQJGErC+HGvgTlH2B0iSf7PtUF9AoHlyOlRuSNxwliru7yBBV4/aP6I4sjylMB4NW5
         Ye4gIFb9E5ABIjfSOYLKPoKTndludG5VwMUJiJA/mctRrZC7KzmB3Gnl+TLl1B9ei/
         rDk8hT/ryVh+pRcW/BMWq9j/ExIkxxRUes5v5jH1JY3W48wLxwnEHPQfN8I1Vesbmq
         p6XxEzeVK+Lz++KAI8d14LsZnApqusVnUB4FM/mbYhw2b1AChq5teI34bj2LQiZbST
         m/08VTK5ILBvA==
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
Message-ID: <169822778398.891844.2822098383458779586.kvalo@kernel.org>
Date:   Wed, 25 Oct 2023 09:56:25 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Jeff, what do you think?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231013074711.2202850-1-make_ruc2021@163.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

