Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98057FC1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346372AbjK1Oxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346283AbjK1Oxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:53:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C0419A8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:53:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF618C433C8;
        Tue, 28 Nov 2023 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701183220;
        bh=s13LC6ZqOcgJuEDiOYtPEnnI1TIenYkNDeB6eVAchC4=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=aDEW4XCa8SiymRXB0L2NQ5E/+Z5gKrj4cHbcCIsyw7DORAnxXmZVmpk8OhkjlxD5X
         0RJwRQv5oQWvY9qXn+Ln8lTjUILh7algqre7fmf5Gyxt/hEeynyGo0dvSx8ZUxLgl8
         mDk4PI3DUrraphNasAYxBhreq6Mb1w578WIHfGuHv1WXFDMuM6t79iTC9/cTFYgpac
         81etA5a0+Y3W330lqFDudyhlfDUy/Ap08JhnQoctVgVsWcQWlIXnhzmQFoPbLSQ0v8
         HzOVn8mKmHWH5vauMeR4wYHPUgKmgbbxFQ+bvwEr0m7+bLLziJDHTdQWCNpn0bYAeX
         qHut2Jwff8t5w==
Message-ID: <0977ffcd30973d0edc1ae4132216b094.mripard@kernel.org>
Date:   Tue, 28 Nov 2023 14:53:37 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "David Gow" <davidgow@google.com>
Subject: Re: [PATCH v2 3/3] drm/vc4: tests: Use KUNIT_DEFINE_ACTION_WRAPPER
In-Reply-To: <20231128072410.952662-3-davidgow@google.com>
References: <20231128072410.952662-3-davidgow@google.com>
Cc:     dlatypov@google.com, kunit-dev@googlegroups.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        "Benjamin Berg" <benjamin.berg@intel.com>,
        "Brendan Higgins" <brendan.higgins@linux.dev>,
        "Kees Cook" <keescook@chromium.org>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Rae Moar" <rmoar@google.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>,
        "Tom Rix" <trix@redhat.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 15:24:07 +0800, David Gow wrote:
> In order to pass functions to kunit_add_action(), they need to be of the
> kunit_action_t type. While casting the function pointer can work, it
> will break control-flow integrity.
> 
> vc4_mock already defines such a wrapper for drm_dev_unregister(), but it
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
