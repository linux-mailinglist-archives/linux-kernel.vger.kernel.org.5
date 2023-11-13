Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3807EA5B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 23:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjKMWDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 17:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMWDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 17:03:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177DAD50;
        Mon, 13 Nov 2023 14:03:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096B6C433C7;
        Mon, 13 Nov 2023 22:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699913011;
        bh=pkmOTL04AJ1h5bNfaK/n1CUjH3QtMrv3NxFMXiMTlQM=;
        h=From:To:Cc:Subject:Date:From;
        b=LNJrCfmtv7peFxHZuym9obJNs3NUGicaVyGAtEVHtIJKXO6asqVT3+iO+YUhYdFBO
         q1u0v9Ub2WLLF6O2+rLPBFfcaSJq8kFxaVy49hc7qgkDMT6CVeYhP6VP4IvNQnsW8m
         oUsvl8t/oKXFQGFuxTOW2Udl/xSYiXJTrzE2GV7Xq306XfywSHAQa9R7hvYiRs5PwC
         zm15yKJzzTn35VCedUD8PBrhZ8woQYylkZcz/EPxy83VEn441+p7ezgkuO0z5qKQGj
         yA37IjC9t+rqkHDJ4abHxvQkVLHjsX7V3GDcgD0ATIMuvK2CFFBfxYyjB+lxdA+7Bx
         YFIzK7xXAJqUQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/2] cpuidle: Remove unnecessary TIF_NR_POLLING clear/TIF_NEED_RESCHED folding
Date:   Mon, 13 Nov 2023 17:03:24 -0500
Message-ID: <20231113220326.7933-1-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Those are cpuidle patches that you acked from a previous posting. I
figured they would be best routed through you so I'm reposting those
strict cpuidle bits from the series.

Thanks.

Frederic Weisbecker (2):
  cpuidle: Remove unnecessary current_clr_polling_and_test() from
    haltpoll
  cpuidle: Remove unnecessary current_clr_polling() on poll_idle()

 drivers/cpuidle/cpuidle-haltpoll.c | 5 +----
 drivers/cpuidle/poll_state.c       | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

-- 
2.42.1

