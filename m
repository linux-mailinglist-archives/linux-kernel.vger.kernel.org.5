Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3FD7B2236
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjI1QYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjI1QYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:24:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7423C139;
        Thu, 28 Sep 2023 09:24:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3BFC433C8;
        Thu, 28 Sep 2023 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695918284;
        bh=Yb73gD0w71DZLWWTyXpDtkeRLLlRucCxREX/JemEB8I=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BKcDfpYNChVFNEtxTBXfELZtQVEthED8lpdnWdWEE8cBEI6x+7gCWHud+T+Eo/LYp
         r8jb7nxiqf72drCkZcRMc+smSTLeZWKFxSo33taiUk1zs8/iEoX8/v/vlRU0ZoTRTp
         a4OUdYOFT571q3z2kbTzYbvvZQEOladuJPAUtBN3LGoppTmdIoiFZwhcBmuBBmchTe
         wShV/JzqhD8WbzG/cB3dx8pIZ1FSNsvWuTIj0x2Ym7f/MRv/7hZg1Et4n+kmrg5Pux
         b0id+Rj65bBH+m0J5KEd6954DqcXwNp8WHu9oNNgJQ61bzClV2m87UpS5mQozSEPu9
         11MInDvR5q1dQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: rt2x00: remove redundant check if u8 array
 element is less than zero
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230920121240.120455-1-colin.i.king@gmail.com>
References: <20230920121240.120455-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591828085.3187104.685774865780206664.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 16:24:42 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.i.king@gmail.com> wrote:

> The check on vga_gain[ch_idx] being less than zero is always false since
> vga_gain is a u8 array. Clean up the code by removing the check and the
> following assignment. Cleans up clang scan build warning:
> 
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9704:26: warning:
> result of comparison of unsigned expression < 0 is always
> false [-Wtautological-unsigned-zero-compare]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Patch applied to wireless-next.git, thanks.

b2172a9330b5 wifi: rt2x00: remove redundant check if u8 array element is less than zero

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230920121240.120455-1-colin.i.king@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

