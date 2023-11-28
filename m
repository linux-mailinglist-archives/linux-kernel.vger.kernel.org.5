Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7203C7FBAB7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbjK1NBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344901AbjK1NAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:00:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327C5D63
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:01:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F530C433C8;
        Tue, 28 Nov 2023 13:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701176460;
        bh=eNb/d406xgQ2BUi6ZWkdGu1qWx39Tq+M5tbfHdAGKkM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cdiir+Q2TW0rww5fa2/2e3cP5h8izbrR0u2XfDnFsYv7xNcXKv/zbISEpF975L98H
         gCzb11396ZNw8/8C5bI36zQYP6vdovckqEu4YR2RhPzuFnLeEOmsgICtymjZ7vZx3u
         B07Tdmqis+Qih87D0jTXo/BE0/mjHHUq4QDKfRgmmopVgHLx9UJKKalGeENSM2Kd0I
         1OZGS+Qmlc6ZeqHHqy7geTTNxMOWjjimOMq+p/0cS2UlBMyU4J4E4YdSw5aMW2qdZq
         M3TdpBqLzCmkNfzq+hPA5Kv5msr7cla0V6cRsuoM2dvL0ddLhNbiKp2AghqmsCzXT+
         3fgoEVnJ1sK8A==
From:   Maxime Ripard <mripard@kernel.org>
To:     airlied@gmail.com, daniel@ffwll.ch, frank.binns@imgtec.com,
        donald.robson@imgtec.com, matt.coster@imgtec.com,
        sarah.walker@imgtec.com, Danilo Krummrich <dakr@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231124233650.152653-3-dakr@redhat.com>
References: <20231124233650.152653-1-dakr@redhat.com>
 <20231124233650.152653-3-dakr@redhat.com>
Subject: Re: (subset) [PATCH drm-misc-next 2/5] drm/imagination: vm: check
 for drm_gpuvm_range_valid()
Message-Id: <170117645847.2825698.6258484637580832130.b4-ty@kernel.org>
Date:   Tue, 28 Nov 2023 14:00:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 00:36:37 +0100, Danilo Krummrich wrote:
> Extend pvr_device_addr_and_size_are_valid() by the corresponding GPUVM
> sanity checks. This includes a, previously missing, overflow check for
> the base address and size of the requested mapping.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

