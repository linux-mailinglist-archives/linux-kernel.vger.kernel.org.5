Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C76789DF9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjH0NLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjH0NLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A49C13D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 000FA611ED
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 13:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75D5C433C7;
        Sun, 27 Aug 2023 13:11:06 +0000 (UTC)
Date:   Sun, 27 Aug 2023 16:11:05 +0300
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v3 5/5] kselftest: vm: Add tests for no-inherit
 memory-deny-write-execute
Message-ID: <ZOtLaQXDsdodZHUc@arm.com>
References: <20230704153630.1591122-1-revest@chromium.org>
 <20230704153630.1591122-6-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704153630.1591122-6-revest@chromium.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 05:36:29PM +0200, Florent Revest wrote:
> Add some tests to cover the new PR_MDWE_NO_INHERIT flag of the
> PR_SET_MDWE prctl.
> 
> Check that:
> - it can't be set without PR_SET_MDWE
> - MDWE flags can't be unset
> - when set, PR_SET_MDWE doesn't propagate to children
> 
> Signed-off-by: Florent Revest <revest@chromium.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
