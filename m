Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E57478B323
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjH1O3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjH1O2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:28:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A49CC;
        Mon, 28 Aug 2023 07:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E495C642D4;
        Mon, 28 Aug 2023 14:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D435FC433C7;
        Mon, 28 Aug 2023 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693232912;
        bh=jItjtC4A+zVJrsmFSLDj0GZxC/YQ57uI1L0f1Hr25HA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O/rPdpquODkOscEhkFJ/rRyhcPNOnn6QSDg0cZJmnc6iGdKs3w3lVtLmZOIfLe28E
         bvTrSV1YPt4MR66txUrnoKii/j1NJQLfukUgM7sF0YQiercQ25fRIFwxPy19fcTeul
         AfDr4AXAh0lkRLPb7EJ404Dd5Hyq8JXs5NSg1/LICzu7UBIddVf7YtDpBmtcs5pmBt
         t13M13u5yVJyLrU+3suX6vwZxcwsRKeGtQWuk0La4sq7GOydqDRA3JbPCDXRWaTtKu
         C6Sw4aZNMKHfSVMmo1KnEzYly/Y8MKL+P4DtDMqHAprFiG5pjPrIDQEZSzxFX8ee7G
         0IwXv48sgO4vw==
Date:   Mon, 28 Aug 2023 15:28:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] iio: pressure: bmp280: Allow multiple chips id per
 family of devices
Message-ID: <20230828152853.35585965@jic23-huawei>
In-Reply-To: <8856287079b5dc1099f5b98a0168f008fbb8debd.1692305434.git.ang.iglesiasg@gmail.com>
References: <cover.1692305434.git.ang.iglesiasg@gmail.com>
        <8856287079b5dc1099f5b98a0168f008fbb8debd.1692305434.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (ret) {
> +		// 0x<id>, so four chars per number plus one space + ENDL
/* */

