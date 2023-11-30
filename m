Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF737FFB26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376362AbjK3TWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376331AbjK3TWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:22:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52D410DE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:22:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0612BC433C7;
        Thu, 30 Nov 2023 19:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701372139;
        bh=+7y/SoB0oekqe7y/gT33Bcz6gA3T+9Zo09+5P9Q1naY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VsquDq4ozGnJM2AsKT3V7db8lUQAoqT0ku4HmN0YvirIuLernk2g6FugwhGB31BNO
         RGhvSPM4wZEgJqhm44lXuMQaEY9YDmdKy5B94p2cBC5Sqqz36CQNRxfFJ37s0mcC6k
         eYk/07nfaZ0MahKCvz9cbGNJv66QctAShqOvhfeY1O+fCh1AlzVdRkEHiKxM2BueXN
         9CZiO7p1eKUseIb2B+NUaN0sHU7c5HOFjtPB/qp4pjfMrgAiS0v/5WNjlM0jfRVkm8
         fyubqsRUC1nO8b5v+BYyb2fD56UDZuheA0JjkIbkG7oh/hoFHGktuycO44Q37I/jSc
         HiTnyJSpBzIxQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless-next,v3,1/2] wifi: rtlwifi: rtl8821ae: phy: remove some
 useless code
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231127013511.26694-1-suhui@nfschina.com>
References: <20231127013511.26694-1-suhui@nfschina.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     pkshih@realtek.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, Su Hui <suhui@nfschina.com>, lizetao1@huawei.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170137213526.1963309.2251579800524493199.kvalo@kernel.org>
Date:   Thu, 30 Nov 2023 19:22:16 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Su Hui <suhui@nfschina.com> wrote:

> Clang static checker warns:
> 
> Value stored to 'v1' is never read [deadcode.DeadStores]
> Value stored to 'channel' is never read [deadcode.DeadStores]
> 
> Remove them to save some place.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

cda37445718d wifi: rtlwifi: rtl8821ae: phy: remove some useless code
bc8263083af6 wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231127013511.26694-1-suhui@nfschina.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

