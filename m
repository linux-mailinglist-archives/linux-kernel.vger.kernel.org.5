Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA365797774
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbjIGQ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbjIGQ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:26:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41DF6A74;
        Thu,  7 Sep 2023 09:22:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A618C433CB;
        Thu,  7 Sep 2023 06:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694066417;
        bh=k6m1FrHgokNhY1DM/EuEPwGTEKfRg8usrhPLJuc9oiY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rJ9eA+LQqXNJL/vMKBoi1qHHT7dufrHijo19qqi6yEa7+C7YYpL/huaJ3k7rW2pvr
         3xdzybrxI0sXHNXn2P+qTjfe/r66AD0BMF6utFe8qrrLBvdo9eOZhulT1Qwl6NWfRE
         gJQPd0QZXY80BVgHXN9Eb/eCc+wDdxNF4LBv33Goviyp/JiDBp6QgDUmWes3iv9Q02
         UVwor99VEG4S64jFyz48PxuFiGJigaFIyhI238CJc1yWQvL+0hVNkFKTguMusTRf1H
         slk6NZJc8JE+KRQ8Te792ig4masRNmknJhXKhuv4Z4c/UsCRo4Js/qZIPwKT8pnID/
         eJ8cAsAt1v/vg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ssb: Fix division by zero issue in ssb_calc_clock_rate
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230904232346.34991-1-rand.sec96@gmail.com>
References: <20230904232346.34991-1-rand.sec96@gmail.com>
To:     Rand Deeb <rand.sec96@gmail.com>
Cc:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, deeb.rand@confident.ru,
        lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru,
        Rand Deeb <rand.sec96@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169406641403.3946078.14931132240535951245.kvalo@kernel.org>
Date:   Thu,  7 Sep 2023 06:00:15 +0000 (UTC)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rand Deeb <rand.sec96@gmail.com> wrote:

> In ssb_calc_clock_rate(), there is a potential issue where the value of
> m1 could be zero due to initialization using clkfactor_f6_resolv(). This
> situation raised concerns about the possibility of a division by zero
> error.
> 
> We fixed it by following the suggestions provided by Larry Finger
> <Larry.Finger@lwfinger.net> and Michael Büsch <m@bues.ch>. The fix
> involves returning a value of 1 instead of 0 in clkfactor_f6_resolv().
> This modification ensures the proper functioning of the code and
> eliminates the risk of division by zero errors.
> 
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
> Acked-by: Michael Büsch <m@bues.ch>

Patch applied to wireless-next.git, thanks.

e0b5127fa134 ssb: Fix division by zero issue in ssb_calc_clock_rate

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230904232346.34991-1-rand.sec96@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

