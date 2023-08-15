Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D0E77CB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbjHOKl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbjHOKlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C185198A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE02E61A4E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65213C433C8;
        Tue, 15 Aug 2023 10:40:39 +0000 (UTC)
Date:   Tue, 15 Aug 2023 11:40:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, glider@google.com,
        andreyknvl@gmail.com, zhaoyang.huang@unisoc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Rename kmemleak_initialized to
 kmemleak_late_initialized
Message-ID: <ZNtWJW+SFYhvGw9M@arm.com>
References: <20230815051358.802035-1-xiaolei.wang@windriver.com>
 <20230815051358.802035-3-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815051358.802035-3-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 01:13:58PM +0800, Xiaolei Wang wrote:
> kmemleak_initialized is set in kmemleak_late_init()
> instead of kmemleak_init(), which may cause confusion,
> so rename kmemleak_initialized to kmemleak_late_initialized.
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

If it makes it clearer, fine by me.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
