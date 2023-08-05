Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD7C771175
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjHEScc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEScb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:32:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973AEB7;
        Sat,  5 Aug 2023 11:32:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CAB560DEC;
        Sat,  5 Aug 2023 18:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2389C433C8;
        Sat,  5 Aug 2023 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691260349;
        bh=7oEjqHiH3ZxsY9aD7bdSp0q4wcao5/TsHCf19gInELM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UVySTPZXrhV3SIF9pdsZ6b7XC6pPLl0joI1lY9j/3DSD8WtDJKfOAb6ggsjntbJgi
         A39jd0Z4Ru9WDuicw11woYCyzj7FHORGs80l+5OFazyTEdFoZrywT8PRNL1db+e8Vs
         E11a9v8LSrTrlM0DcxxAPzm3MWq0D7luLLtD5k3F+58iXTEx6+0mETQsKgJS9rp2r4
         Y5VsXZvBPIFmWbGEOQeErsvin0t2BV+u5zS7JNCcre+fYsc13QkbJe8H1B6R89btj7
         /k8+8eP6OT70czKA1xwREsP9i4+qIS5dhXf9SyVegf4NTk+n6rRpwpgCeexCf61ZvA
         5XMRucjbwqW3w==
Date:   Sat, 5 Aug 2023 19:32:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Add new channels for adis16475
Message-ID: <20230805193223.6bbc5522@jic23-huawei>
In-Reply-To: <20230804064559.47192-1-ramona.bolboaca@analog.com>
References: <20230804064559.47192-1-ramona.bolboaca@analog.com>
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

On Fri, 4 Aug 2023 09:45:56 +0300
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> changes in v3:
>  new patches: 1,2 which add IIO_DELTA_ANGL and IIO_DELTA_VELOCITY channel types
>  patch3: 
>   - added new flag for presence of delta measuremets in burst data
>   - removed available scan mask, a simple check is performed in
>   adis16475_update_scan_mode to see if the scan mask is valid and to configure
>   the burst data selection based on the scan mask.

Not that it hugely matters as they don't end up in the git record, but good to
spell check cover letters (I often forget to do so as well!)

> 
> Ramona Bolboaca (3):
>   iio: Add IIO_DELTA_ANGL channel type
>   iio: Add IIO_DELTA_VELOCITY channel type
>   iio: imu: adis16475.c: Add delta angle and delta velocity channels
> 
>  Documentation/ABI/testing/sysfs-bus-iio |  29 +++++
>  drivers/iio/imu/adis16475.c             | 165 +++++++++++++++++++++---
>  drivers/iio/industrialio-core.c         |   2 +
>  include/uapi/linux/iio/types.h          |   2 +
>  tools/iio/iio_event_monitor.c           |   4 +
>  5 files changed, 183 insertions(+), 19 deletions(-)
> 

