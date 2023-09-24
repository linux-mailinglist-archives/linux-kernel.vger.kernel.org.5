Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1669C7ACB40
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjIXSKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjIXSKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:10:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD953FE;
        Sun, 24 Sep 2023 11:10:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5104C433C7;
        Sun, 24 Sep 2023 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695579041;
        bh=tYGxKVpxb7PZ2YIh2JBJHjxiM1XOyE8essbNsK2nP68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f2WS1Q4Xi3Sodin4WDSptsS62GVbZdwRevbbVH+XhFjLBEY9hyCt4a0CzWDfYFIq7
         1bjclmrMnQPEdvDl7UdRRkVfj2HU8Sd0YhqaHtg21Cft/nBXxzIh8wMfe9bxSTT0oy
         LALiG0kxaChjgrCxA3Ix65QPf3i5x7h+rVh6Wo/7WcvSmLLt3L1l1QgGpJ5+uZ9VZe
         J9JcX+Z+2SH9VQQXraT2Q6HqXWDirP4kd9i/ujpXA6oKGi8WDYDvGOshy6PDYZ6E48
         W1WCxoi3eL1GbNCMQphcbD7KuFQsEDg3m2dSNzqdjhX2lDPFSmkA5cfq/5fhf/ovBD
         SV0GjfufZIdDA==
Date:   Sun, 24 Sep 2023 19:10:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: Re: [PATCH v2 17/19] staging: iio: resolver: ad2s1210: convert
 resolution to devicetree property
Message-ID: <20230924191032.48cc906b@jic23-huawei>
In-Reply-To: <20230921144400.62380-18-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
        <20230921144400.62380-18-dlechner@baylibre.com>
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

On Thu, 21 Sep 2023 09:43:58 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Selecting the resolution was implemented as the `bits` sysfs attribute.
> However, the selection of the resolution depends on how the hardware
> is wired and the specific application, so this is rather a job for
> devicetree to describe.
> 
> A new devicetree property `adi,resolution` to specify the resolution
> required for each chip is added and the `bits` sysfs attribute is
> removed.
> 
> Since the resolution is now supplied by a devicetree property, the
> resolution-gpios are now optional and we can allow for the case where
> the resolution pins on the AD2S1210 are hard-wired instead of requiring
> them to be connected to gpios.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Good change to see.  Note that mostly I've not commented on patches
where I fully agree with them.
