Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A687C696F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbjJLJZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjJLJZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:25:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3940BA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:25:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F961C433C7;
        Thu, 12 Oct 2023 09:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697102741;
        bh=/ItVD3SvDH45EQ0lyeWLvr5gyjqXDrdu9xT+D7zuRD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAPRudiiiP/cOB9GJkTQM72oWaMkY96tenGbcfG8VG+P5GydgmeLerzyu+VpHzIyd
         7QZQO9or4iA1AYVMmmI3DjcsDnVbRv+sGblFts3DSkTmQLwEKxgyfWBL3YGc+cB/Cy
         xeN0w+3qf6eFDDSRBq5Oto96UuEENgyBj5oRlaMTtYzAIopZbziUk8NMR6P+he4Y6Q
         ekG6rEwI5eAcFRTX8iSKPPPeUGlCeQk+CrnHUEFLXfyOWHxH2NQcAJNoz0l2AYOuV+
         0Tzqq1KpeQQBlgbKdLi0hL11z7EDtBgZXyKjrf9BR7kn+C/QVc80BwxrZQ0iRYO9k9
         XOpI2q24LiVxQ==
Date:   Thu, 12 Oct 2023 12:24:42 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] memblock: don't run loop in memblock_add_range() twice
Message-ID: <20231012092442.GR3303@kernel.org>
References: <20231003163045.191184-1-yajun.deng@linux.dev>
 <20231005051959.GC3303@kernel.org>
 <df623d80-befb-09e0-04eb-3c93ecfa9f2e@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df623d80-befb-09e0-04eb-3c93ecfa9f2e@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 11:20:19PM +0800, Yajun Deng wrote:
> 
> On 2023/10/5 13:19, Mike Rapoport wrote:
> 
> > I don't see this micro-optimization is worth the churn and potential bugs.
> > NAK.
> 
> There are many handouts that tell people it needs to run twice in
> memblock_add_range().
> 
> I think it's time to change this. I'm trying to tell people that running
> twice is unnecessary.

It might be unnecessary, but it's still simpler than the solutions you
proposed. And, again, removing the second loop is not worth the churn and
potential bugs.
 
-- 
Sincerely yours,
Mike.
