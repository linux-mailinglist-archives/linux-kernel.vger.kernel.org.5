Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994C37BA339
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbjJEPwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjJEPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53826079B;
        Thu,  5 Oct 2023 07:07:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700E6C32790;
        Thu,  5 Oct 2023 11:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696505879;
        bh=LOAxG0Jr81YYuWH9A6gH/itFYQmM7Ke3vuSJ0R6KdxE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jTUZKHsqapDRDpNErIirrcgRtUXDMt/GpYIuCVb48ZRw0tcIQwRxE5FOxVpdXAgzi
         Y0indAMT0oUT+CsAbyRP/1I1HA8/aAN2S0B//2j+bN2e+n8e0EPVxzNECn5WnFOfwN
         BvRF+WBJH/hDRFjUNWsfNfXTQZroBM1ERmdq4EP7gQYbBV0hvb0pBbErsKHGFp7uoQ
         QqNbEPwmKe7KndRb5Erj5sO9K95GjgJzg00LE5sca5IgY6sajLg7MmPQwy+EMFRVI2
         /ThvTt5fWCqEkEkRIyZ3J83uEy/sB8G9ObaQ7MqC9QieMiUQvIAvNNccB9hgIAqZTg
         J8y3sDSOL5YPA==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
References: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
Subject: Re: [PATCH 0/7] mfd: ti: Convert to maple tree register cache
Message-Id: <169650587815.706993.16199144308620450017.b4-ty@kernel.org>
Date:   Thu, 05 Oct 2023 12:37:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Oct 2023 11:27:47 +0100, Mark Brown wrote:
> The maple tree based register cache is based on a more modern data
> structure and makes more current implementation decisions than the
> rbtree cache, convert the TI drivers that use rbtree caches to use
> maple tree instead.
> 
> 

Applied, thanks!

[1/7] mfd: tps65086: Convert to use maple tree register cache
      commit: aa732bb3da329abc28b4eee89efd974acb5b8c36
[2/7] mfd: tps65090: Convert to use maple tree register cache
      commit: 21a3beab2dbf6c0f3fdc45a14dfffbe2d1c53e79
[3/7] mfd: tps65128: Convert to use maple tree register cache
      commit: d252f0f6c8df10559cca85bc8824e9b7c45c1c51
[4/7] mfd: tps6586x: Convert to use maple tree register cache
      commit: 0c16d3d6b758aca06c7c550cc43b8a0368525bba
[5/7] mfd: tps65910: Convert to use maple tree register cache
      commit: f77a3bcff35c1c8bccb347f2f7cf3e25af782984
[6/7] mfd: tps65912: Convert to use maple tree register cache
      commit: 6e554a744ff576223275fbedafccf9d88581b1fd
[7/7] mfd: twl: Convert to use maple tree register cache
      commit: 680d253c3ba0674b8da269e5c51e6caaa623cad5

--
Lee Jones [李琼斯]

