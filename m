Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2BB7C00DF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjJJP5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjJJP5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:57:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA693;
        Tue, 10 Oct 2023 08:57:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868EBC433C8;
        Tue, 10 Oct 2023 15:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696953421;
        bh=UwuZ32zC8AXiHmdbjhpI6SAE/Jw6t06ng7IB8mYYtyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X49pyZQ64ZrT6prpmrF8Og4aeHanVydZ5d+Tk8P/CKok4xaPzB8WSFPS9quuVo1m9
         vIXywCCl6bV1pvDPVueiNIzFu+xjjFdwL5tC8JR+uhGIBZlkYyU1bVRdawzTgCF104
         pZRq2ZTSVvYbXuJZJuJBzIzcV7gBBFRPyjcUMp2lR5FyY+6plMmMRQTTJyW3u3UvGN
         SsaAKPlgiN4uxboa9IJv81F4Idiw8J4VLiZsesf/vkMChKvN+r4vrzd4OIq2FibBYO
         NL7Gb4FS2s1rsVQsm/CtqypOid03Y02F92D5e5/Y7XQcyMN9ruTOxHzTrVeNaVy0Hn
         yqBNyY/ZjPwLw==
Date:   Tue, 10 Oct 2023 16:57:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/17] staging: iio: resolver: ad2s1210: rename DOS
 reset min/max attrs
Message-ID: <20231010165712.5584d4c1@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-11-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-11-ec00746840fc@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Oct 2023 19:50:28 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The AD2S1210 has a programmable threshold for the degradation of signal
> (DOS) mismatch fault. This fault is triggered when the difference in
> amplitude between the sine and cosine inputs exceeds the threshold.
> 
> The DOS reset min/max registers on the chip provide initial values
> for internal tracking of the min/max of the monitor signal after the
> fault register is cleared.
> 
> This patch converts the custom device DOS reset min/max threshold
> attributes custom event attributes on the monitor signal channel.
> 
> The attributes now use millivolts instead of the raw register value in
> accordance with the IIO ABI.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.
