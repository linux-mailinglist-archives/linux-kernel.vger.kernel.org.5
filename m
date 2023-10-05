Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCDC7BA265
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjJEPdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjJEPc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:32:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE83D5C6BA;
        Thu,  5 Oct 2023 07:50:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C61C3278A;
        Thu,  5 Oct 2023 11:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696504244;
        bh=81DnpxxdBYZrrUfyjgAJck9Wj4KLJe818fuwhsQR8+Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cWy0RApPbByN09t6pLFrtNEMn3oUnEl+1fgjrYnK0wjnt4TS1k1ixGdjUTaMDd8BZ
         ts+kdvt4N6Hqac1rifjOJnWqfnekB/dA0edFrP9UTfi9SuqqcDz7Mx2sNESC+FBSLw
         jmZf1+QT7B1CKM09y6bsEsSYf7N1p8N0qzW40uIeKHWYxj3XcEAODKahrGYBznIAUz
         Eer+PBcIyx4V4a0hUCuonk17HJDnMdLjSH9LjBLVWILe3IQMttBCAa3qZiekA7Rp2E
         lHeHvWX5Fbksap9nnNwbrxqVMfT/15s+eE70tc8imu4NHAg85yAgLgouxnoq1NnOcg
         DwbNARrutJ5Hg==
From:   Lee Jones <lee@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
In-Reply-To: <20230929-leds-maple-v1-0-ba5f9dcb1e75@kernel.org>
References: <20230929-leds-maple-v1-0-ba5f9dcb1e75@kernel.org>
Subject: Re: [PATCH 0/4] leds: Convert to use maple tree register cache
Message-Id: <169650424265.688682.2460798715972634009.b4-ty@kernel.org>
Date:   Thu, 05 Oct 2023 12:10:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 17:23:34 +0200, Mark Brown wrote:
> The maple tree register cache is a more modern replacement for the
> rbtree cache, the underlying data structure is more modern and the
> surrounding cache implementation makes a number of choices which are
> more suited to modern systems than those made by rbtree.  This series
> updates the LED drivers that use the rbtree cache to use the maple tree
> cache.
> 
> [...]

Applied, thanks!

[1/4] leds: lm3601x: Convert to use maple tree register cache
      commit: c2b7575239f5d0925035f3fc3bb155d176abee80
[2/4] leds: aw200xx: Convert to use maple tree register cache
      commit: 2aedfe62b4151b0abe35bf022edf18f84817afcd
[3/4] leds: lm392x: Convert to use maple tree register cache
      commit: c2ecac98222a23ad8209a71ad5c1e32a8be46392
[4/4] leds: lp3952: Convert to use maple tree register cache
      commit: 2997d69d888d6ee7114a89d066889a016448422a

--
Lee Jones [李琼斯]

