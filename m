Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4177A7DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbjITMM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbjITMMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:12:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3862C2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:12:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1343DC433C7;
        Wed, 20 Sep 2023 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695211969;
        bh=ffA26Ut3j5gwcxjXVcNGDkgHGCMPmxR207hwYJ1EP/k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dil3Wkk10CrYIsBEoTabet7YzYCw/DY9VdMVvSzJ8xu13UmK1IzKNd3RLChmbYpKy
         vWsNyaFa+LCq6YlgOTzeyNYaCk4XENF3V6vq1ioV4rd50bMq9QrtQZxNV5k4++vL9T
         Gt93k43oVArbjUbZG97FY6p1iPn1M5wAmAzpE0EY6QfSsL2H+7q8TfDkEobnO44LXH
         UHJYpvUOdySMILMlKEMWxVkyFUrI42/x5v8zitm1eiaqZnX9GF+O4RInP4HXK/Fj3t
         LR8dTl4+UfbdNePh8QQYni1eIxi+Uhyp50rwaDUGikT+H0iRlEKuGpgFZXGe69u3cG
         ImqcjA1O3776Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, sunying@nj.iscas.ac.cn
Cc:     linux-kernel@vger.kernel.org, renyanjie01@gmail.com,
        pengpeng@iscas.ac.cn
In-Reply-To: <20230913084559.18141-1-sunying@nj.iscas.ac.cn>
References: <20230913084559.18141-1-sunying@nj.iscas.ac.cn>
Subject: Re: (subset) [PATCH] mfd: ab8500: remove non-existent
 configuration "#ifdef CONFIG_AB8500_DEBUG"
Message-Id: <169521196786.3410724.4021312044206198772.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 13:12:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 16:45:59 +0800, sunying@nj.iscas.ac.cn wrote:
> The CONFIG_AB8500_DEBUG has been deleted in
>  [PATCH]mfd: ab8500: Drop debugfs module.
> 
> The condition "#ifdef CONFIG_AB8500_DEBUG" in
>  include/linux/mfd/abx500/ab8500.h:502
>  cannot be valid. It is recommended to delete redundant code.
> 
> [...]

Applied, thanks!

[1/1] mfd: ab8500: remove non-existent configuration "#ifdef CONFIG_AB8500_DEBUG"
      commit: b173dcd781e0a8293f2dbba92c7245ff9aac5820

--
Lee Jones [李琼斯]

