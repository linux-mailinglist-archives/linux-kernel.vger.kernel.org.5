Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC05A7935FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjIFHNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjIFHNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:13:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06B9E60
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:13:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3CFC433C8;
        Wed,  6 Sep 2023 07:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693984414;
        bh=xbpzvOy1GbMdzWOLcnPSwZpXoa52vIob+3+/5L6zTO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vp6ei2RspuPENaYFEij+M8YMq1wAYO5vWV8K2G0JaK+XK4bMI+Tss/7qOjJctjsbA
         uTYeT8WpQrox9A0CPTkzwD5GJIFAhN0p8aftbPhHGKBq6hEI+9iBD4izW6iSEorkCi
         RcVX0o+FEgZiq+KVhT8aOklHPxJP0cTkm84n+FC9qe0X1kjcaAJII7+v1PceleftJr
         m53VU/z+YWsUZgA9RZbz7ns+x90yEpfAtgDwhmFQpbTfpCeAYTj+PB8vAch8KM97PJ
         bduC+5XQlS+HU8mbqGRJop/p1pkgI1P10lhu4nFLpEwcwhU4aFOPwPrZwbJu/oaBBq
         d/zAcrFsJh61w==
Date:   Wed, 6 Sep 2023 09:13:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Damian Tometzki <dtometzki@fedoraproject.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memfd: drop warning for missing exec-related flags
Message-ID: <20230906-eichenbaum-hektar-01140b56ca64@brauner>
References: <20230906-memfd-reduce-spam-v1-1-1f0d35facd95@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230906-memfd-reduce-spam-v1-1-1f0d35facd95@cyphar.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:02:06PM +1000, Aleksa Sarai wrote:
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
> Reported-by: Damian Tometzki <dtometzki@fedoraproject.org>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
