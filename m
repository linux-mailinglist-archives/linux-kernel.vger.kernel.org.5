Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2A07EC7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjKOPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjKOPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:52:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D621FFB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:51:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC229C433C7;
        Wed, 15 Nov 2023 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700063515;
        bh=UtU8CmcT9tpGHDF8mWEF6lFxjr7HU9BJf79DrVfL3XU=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=iuMFnn6BH+6Tq7rWCf8rAh96nJnt5f3Kk8u85KM1oUuAshrXF5yfT2ZxUIemM4hEp
         svANmekp8cG29Hx+ZsTFl4Sy3nO8hxZWNCmAqg3vP/F597iyH+1SG89CVP/unwZM3N
         D0BJqSdywTPPoTUkN4Q/wPI9mR2iQNkTJwcKJ1BJvuMC3GEPMWf+UfZZ3K1SJSxQul
         j/hoNezC0BYXRb9BPl8R74v+Sj0JuMeGvn9JTaayNeQE6nJDaZxiDUUZK6vGnfBV29
         j0B9/cZthBdiWHKlV3NZjxvM9ddaiqlE47Ve3Maa8mJZ4XxDOupKXebfSdpQb4Ax/k
         QtYwIwHUO7mAA==
Message-ID: <4e0c8bb796a67af5fb901f831c5f87fe.mripard@kernel.org>
Date:   Wed, 15 Nov 2023 15:51:52 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "David Gow" <davidgow@google.com>
Subject: Re: [PATCH 1/3] kunit: Add a macro to wrap a deferred action
 function
In-Reply-To: <20231110200830.1832556-1-davidgow@google.com>
References: <20231110200830.1832556-1-davidgow@google.com>
Cc:     dlatypov@google.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, "Arthur Grillo" <arthurgrillo@riseup.net>,
        "Benjamin Berg" <benjamin.berg@intel.com>,
        "Brendan Higgins" <brendan.higgins@linux.dev>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@gmail.com>,
        "Emma Anholt" <emma@anholt.net>,
        "Kees Cook" <keescook@chromium.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        =?utf-8?b?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Rae Moar" <rmoar@google.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        "Shuah Khan" <skhan@linuxfoundation.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2023 04:08:26 +0800, David Gow wrote:
> KUnit's deferred action API accepts a void(*)(void *) function pointer
> which is called when the test is exited. However, we very frequently
> want to use existing functions which accept a single pointer, but which
> may not be of type void*. While this is probably dodgy enough to be on
> the wrong side of the C standard, it's been often used for similar
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
