Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F037EC4FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbjKOOUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbjKOOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:20:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16BDE7;
        Wed, 15 Nov 2023 06:19:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B709C433C7;
        Wed, 15 Nov 2023 14:19:56 +0000 (UTC)
Date:   Wed, 15 Nov 2023 14:19:53 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm/kmemleak: move set_track_prepare() outside
 raw_spinlocks
Message-ID: <ZVTTiXN333Tw4gxF@arm.com>
References: <20231115082138.2649870-1-liushixin2@huawei.com>
 <20231115082138.2649870-3-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115082138.2649870-3-liushixin2@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 04:21:38PM +0800, Liu Shixin wrote:
> set_track_prepare() will call __alloc_pages() which attempt to acquire
> zone->lock(spinlocks), so move it outside object->lock(raw_spinlocks)
> because it's not right to acquire spinlocks while holding raw_spinlocks
> in RT mode.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for the quick fixes.

-- 
Catalin
