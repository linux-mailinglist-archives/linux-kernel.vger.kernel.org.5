Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31328038BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjLDPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjLDPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:25:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ABBA5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:25:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9A3C433C8;
        Mon,  4 Dec 2023 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701703543;
        bh=87wG1kDj6b6gH/9dKdYLgikm7mMeRtoP3wmz09aZBmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=luWmtpc3YS8XrJMgI0Z803J9hR/unwQoXBr+bcRNQLPTJFTLEDPbWJz22FR5JPdx8
         vmQJRGm1PUsJokWwExfhCe7NhddmUfamxS02hawMIhnRdPS4uBrLEiQvqjQoho5zTQ
         yeiRLr+UOhJ907Jk56YYDhMF1RNh4JeD5ETVtexdRRkMPLtO8HIxpWIAz2mo4CnXDt
         tC1Zf3UR49sXMw4ldMK9s7kFUuksrG9yHlmcAtqzJCNVu6nSROG7vwJg529TqaA1E1
         KtRnMENQ8z4oZaaMNksBy7ad6OTbC5K4hzxLiAydtr8dh6NhACO9GqkiMGQ68Bnhen
         2Dywz51C1yU1w==
Date:   Mon, 4 Dec 2023 15:25:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc:     <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 09/12] iio: adc: ad9467: use chip_info variables instead
 of array
Message-ID: <20231204152533.252b6bfa@jic23-huawei>
In-Reply-To: <20231121-dev-iio-backend-v1-9-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
        <20231121-dev-iio-backend-v1-9-6a3d542eba35@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 11:20:22 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Instead of having an array and keeping IDs for each entry of the array,
> just have a chip_info struct per device.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Hi Nuno,

Probably makes sense to break out the various tidy up an fixes for ad9467 as a
precursor series and just refer to it from the main one (which will probably take
longer to settle).  Hopefully we can get these out the way and remove the distraction
from the stuff you really care about!

Jonathan
