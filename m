Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949CA789DF7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjH0NKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjH0NJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:09:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2813E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:09:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5217E627DA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 13:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E63C433C7;
        Sun, 27 Aug 2023 13:09:38 +0000 (UTC)
Date:   Sun, 27 Aug 2023 16:09:36 +0300
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v3 2/5] kselftest: vm: Fix mdwe's mmap_FIXED test case
Message-ID: <ZOtLEPW+AaiYF6c2@arm.com>
References: <20230704153630.1591122-1-revest@chromium.org>
 <20230704153630.1591122-3-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704153630.1591122-3-revest@chromium.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 05:36:26PM +0200, Florent Revest wrote:
> I checked with the original author, the mmap_FIXED test case wasn't
> properly tested and fails. Currently, it maps two consecutive (non
> overlapping) pages and expects the second mapping to be denied by MDWE
> but these two pages have nothing to do with each other so MDWE is
> actually out of the picture here.
> 
> What the test actually intended to do was to remap a virtual address
> using MAP_FIXED. However, this operation unmaps the existing mapping and
> creates a new one so the va is backed by a new page and MDWE is again
> out of the picture, all remappings should succeed.
> 
> This patch keeps the test case to make it clear that this situation is
> expected to work.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Fixes: 4cf1fe34fd18 ("kselftest: vm: add tests for memory-deny-write-execute")

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
