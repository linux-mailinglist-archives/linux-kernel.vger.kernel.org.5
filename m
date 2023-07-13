Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EF7752AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjGMTTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjGMTSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:18:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92B21993
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8189261B39
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28CFC433CB;
        Thu, 13 Jul 2023 19:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689275927;
        bh=vafqn8AR/75AYFDccVSyG2B7wIw7vf0a/ENgk2BFQ5c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ksrHrhz37aqbjc8nMVvBXofezYTckyYbgwb+srWOwq8suRbJfGMYzgHmecDdPLJ3P
         Cm5mPq7es7cq4lfAiiHNJHWdE77bF7V6U8LCzbeiuUuSJp6ZBSiy3x/4dnxsndFTkO
         RyY9RVFGvIKZxie5oNBPIlXHtNXREih3wM/CTbKl0Rc2DW5w7qEPjJ+C4vag5GMyC7
         57w81oAfGkrTVtj5lLZnErlSmx8Sa5xzB2B52XuCTGcxZEE7feoMvnesYoMHbodrht
         y2fkh7foNZUiRgds9f8NQWmqR475tovgzjjCEdjvyGs2EyNaKImJlmy9K3MEaX07AW
         /CZo3Y7R11R4g==
From:   Lee Jones <lee@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
Subject: Re: [PATCH 00/11] mfd:: Update Cirrus Logic drivers to use maple
 tree register caches
Message-Id: <168927592510.1059976.1452188805408715416.b4-ty@kernel.org>
Date:   Thu, 13 Jul 2023 20:18:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Jul 2023 01:49:18 +0100, Mark Brown wrote:
> With the v6.5 merge window the maple tree register cache has acquired
> the ability to generate multi-register writes during sync operations,
> removing the last major limitation it had compared to the rbtree cache.
> As part of a general modernisation effort update the Cirrus Logic
> drivers to use the more modern data structure, realistically there is
> likely to be very little user visible impact either way but generally
> the implementation choices of the maple tree cache should be a bit
> better on modern hardware.
> 
> [...]

Applied, thanks!

[01/11] mfd: cs47l15: Update to use maple tree register cache
        commit: b4dcbfa82d1264f7c813b6fa4cdc63851daa9b86
[02/11] mfd: cs47l24: Update to use maple tree register cache
        commit: 7814d7e4eac9ad7f87dd1a670feadd9caafd3713
[03/11] mfd: cs47l35: Update to use maple tree register cache
        commit: 1ae7edc5cb666d6d382263d50d9a48cb8a6898e9
[04/11] mfd: cs47l85: Update to use maple tree register cache
        commit: e7c8dce6e5dc3f9963bc9762278f8db33770db95
[05/11] mfd: cs47l90: Update to use maple tree register cache
        commit: 703458beace3c8530808371398dd147339f31c71
[06/11] mfd: cs47l92: Update to use maple tree register cache
        commit: 5b6b74f62046d44269d3720fdfe5cc482392b99e
[07/11] mfd: wm5102: Update to use maple tree register cache
        commit: d635f7d7f1be3160291d22cb05148259c9fdfafd
[08/11] mfd: wm5110: Update to use maple tree register cache
        commit: aad8ec37d158a35c2397a76964f9541fe3fd59b6
[09/11] mfd: wm8994: Update to use maple tree register cache
        commit: 03665778ce02e9bf95ef18f2548cb6dfca01a347
[10/11] mfd: wm8997: Update to use maple tree register cache
        commit: 8e3c1052f4fb404f7264059e706807de43f68a23
[11/11] mfd: wm8998: Update to use maple tree register cache
        commit: 0d606d3545727c1399bd61b1340dde84e900178f

Best regards,
-- 
Lee Jones <lee@kernel.org>

