Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97B27A7D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjITMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbjITMJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:09:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E89FD8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:09:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEB1C433C7;
        Wed, 20 Sep 2023 12:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695211757;
        bh=OEQRvNBIcEcIZeKClDejJiFA2DbjWtv3j3MKSl53GdE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mmkVUzJCBlePcrAqF1cHhE45d34gErfNsId7krXgNrjyQEA1KWWh7KCEs9NpRdhJK
         0V17T+gXrA/syoEeNHxVVZQF9ZALeCQhlrdvH2wiMTIpdwkpBtQOSseshchIaX/dMN
         fA7GkwPZsTc7+1pnkJkbZiyr+ekuRCwDoa6nuePB0uc+S1oSU+pSFxNkmf/5J92oj7
         cXHBgIg/nehjhcjakNZJcHanHgc9m3r8358z7U1TEfP0RYpFmpUEPWC6itDhBKcU95
         N2uD1IP5QcGx4QoQXv9Z2RDl6sbuzqsk8J119Rlgd36vxF11qq0feN/WOthfYH6zQf
         q8IxH4cjeRoaA==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230912-mfd-wcd934x-maple-v2-1-292a154113e3@kernel.org>
References: <20230912-mfd-wcd934x-maple-v2-1-292a154113e3@kernel.org>
Subject: Re: (subset) [PATCH v2] mfd: wcd934x: Update to use maple tree
 register cache
Message-Id: <169521175655.3407825.16648093995621569369.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 13:09:16 +0100
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

On Tue, 12 Sep 2023 12:36:46 +0100, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache. In
> v6.5 it has also acquired the ability to generate multi-register writes in
> sync operations, bringing performance up to parity with the rbtree cache
> there.
> 
> [...]

Applied, thanks!

[1/1] mfd: wcd934x: Update to use maple tree register cache
      commit: e141e0544443e3aa800eaddc3beb47417469cb0c

--
Lee Jones [李琼斯]

