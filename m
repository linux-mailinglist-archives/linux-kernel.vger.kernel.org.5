Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505F879A020
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 23:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjIJVfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 17:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIJVfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 17:35:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09F9B9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 14:35:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE7AC433C8;
        Sun, 10 Sep 2023 21:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694381705;
        bh=JPXOur3rM+l3ssv9EopwzgCejOCqHQeR72cDSEWxoII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=czdkTWqmnpBoMzhS0k0mUBpf5DvUSwikIafRVXUiyMDDVIBrpQhGZG+0YBCF2XQV0
         D4XYP1ch28nE4hBJadZG+5hcZdwS+TKc9JQmaAMmHD6jQYdRXJ+JRxrRyiaou9HyNc
         7pcsWWwXNlyBncy1UKeOBIWojjsmfHCmls6ENOoc=
Date:   Sun, 10 Sep 2023 14:35:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Damian Tometzki <dtometzki@fedoraproject.org>,
        Christian Brauner <brauner@kernel.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memfd: drop warning for missing exec-related flags
Message-Id: <20230910143504.6ebe71b01b3d23b96ec842ec@linux-foundation.org>
In-Reply-To: <20230906-memfd-reduce-spam-v1-1-1f0d35facd95@cyphar.com>
References: <20230906-memfd-reduce-spam-v1-1-1f0d35facd95@cyphar.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2023 17:02:06 +1000 Aleksa Sarai <cyphar@cyphar.com> wrote:

> Commit 434ed3350f57 ("memfd: improve userspace warnings for missing
> exec-related flags") attempted to make these warnings more useful (so
> they would work as an incentive to get users to switch to specifying
> these flags -- as intended by the original MFD_NOEXEC_SEAL patchset).
> Unfortunately, it turns out that even INFO-level logging is too extreme
> to enable by default and alternative solutions to the spam issue (such
> as doing more extreme rate-limiting per-task) are either too ugly or
> overkill for something as simple as emitting a log as a developer aid.
> 
> Given that the flags are new and there is no harm to not specifying them
> (after all, we maintain backwards compatibility) we can just drop the
> warnings for now until some time in the future when most programs have
> migrated and distributions start using vm.memfd_noexec=1 (where failing
> to pass the flag would result in unexpected errors for programs that use
> executable memfds).
> 
> Fixes: 434ed3350f57 ("memfd: improve userspace warnings for missing exec-related flags")

This was reverted, so please propose a new patch against 6.6-rc1.
