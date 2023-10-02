Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501A27B5933
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbjJBQ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjJBQ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:58:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C35BD;
        Mon,  2 Oct 2023 09:58:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D89C433C9;
        Mon,  2 Oct 2023 16:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696265926;
        bh=Z54mipjqUI9KFG6Xrua2pg2Iij4JSR9fBBR7ccXfGPY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gxDJzpMedBCagEC9jPJnMQ0wgxrDXzM2ERf6nX49QjacHwjCCdjhPVTq4gBg6JyGn
         BcIMCAyCkydCbOLTzLkU0pZ3SYJKufKFK40LMh9d0nBNINPmiKwRAPpF4s8X8TsxSf
         O4ozlSRUyQj7z+WvmubDS+ayY5P6J8vUgdiSAucqeJfJudNtTfkkXTOjNrqdsil5Wa
         TS7Yx0uN2+E/sXxped4oX6pAuuA4Ec+3ncarq7JKgf8FJ7c70bQ7qWv6o0atVskXGU
         a7+emtmxGHYDwxJpyZz962ePwzk3oM2f+37OavAkr3IeLIpJtEY4JS+29Qx0ngov61
         uQIGEXQuAeBlg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless 1/2] ath: dfs_pattern_detector: Fix a memory
 initialization issue
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ad8c55b97ee4b330cb053ce2c448123c309cc91c.1695538105.git.christophe.jaillet@wanadoo.fr>
References: <ad8c55b97ee4b330cb053ce2c448123c309cc91c.1695538105.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Kalle Valo <quic_kvalo@quicinc.com>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169626592372.3936351.4590251912605769395.kvalo@kernel.org>
Date:   Mon,  2 Oct 2023 16:58:45 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> If an error occurs and channel_detector_exit() is called, it relies on
> entries of the 'detectors' array to be NULL.
> Otherwise, it may access to un-initialized memory.
> 
> Fix it and initialize the memory, as what was done before the commit in
> Fixes.
> 
> Fixes: a063b650ce5d ("ath: dfs_pattern_detector: Avoid open coded arithmetic in memory allocation")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

79bd60ee87e1 wifi: ath: dfs_pattern_detector: Fix a memory initialization issue
27e154abf694 wifi: ath: dfs_pattern_detector: Use flex array to simplify code

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ad8c55b97ee4b330cb053ce2c448123c309cc91c.1695538105.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

