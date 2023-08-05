Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5077117A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjHEShk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEShj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:37:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83176B7;
        Sat,  5 Aug 2023 11:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16F1C60E07;
        Sat,  5 Aug 2023 18:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA787C433C8;
        Sat,  5 Aug 2023 18:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691260657;
        bh=8t88zcs415iSQCxtVZFWqnAxxM7qJeG507k9UOVHbTc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TL0z//o/47XAEfT9XpF9c4jRzeazY8tNQUKen844PFkqjVA6V3ga51DQyuqWk+jNq
         UGv+3NiwLZMp5K1Nitrz712wv4+Ee250KMcIh0QlY36JS7qSfMJ7+bNdH3303nNP5k
         rPsDQ70kKDESgTO+zP6rkYUa3wXLqGX3yVLEbhAdi7OTpUVIz0Pq2jzOUtzKBe5GVj
         9GSgkfAQ1jMvoejTTbh8NemYx4kwiPcJiDyhLk2rfuHN2Fkb0qz1OMROP+zyojs0lR
         FX5zP52G3/bUl7QlUJlhICTQ6Km0Ifd3YhHeKH47k+D+ZmrLnhofEUeFBEIlBw8TCK
         3LjWOuxuqVAdg==
Date:   Sat, 5 Aug 2023 19:37:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: Add IIO_DELTA_VELOCITY channel type
Message-ID: <20230805193731.0bed13fc@jic23-huawei>
In-Reply-To: <20230804064559.47192-3-ramona.bolboaca@analog.com>
References: <20230804064559.47192-1-ramona.bolboaca@analog.com>
        <20230804064559.47192-3-ramona.bolboaca@analog.com>
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

On Fri, 4 Aug 2023 09:45:58 +0300
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> The delta velocity is defined as a piece-wise integration of
> acceleration data. The delta velocity represents the linear velocity
> change between two consecutive measurements and it
> is measured in m / s (meters per second).
> 
> In order to track the total linear velocity change during a desired
> period of time, simply sum-up the delta velocity samples acquired
> during that time.
> 
> IIO currently does not offer a suitable channel type for this
> type of measurements hence this patch adds it.
> 
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
This one looks good to me - I'll pick it up once we reach agreement on
the rest of the series.

Jonathan
