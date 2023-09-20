Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39DC7A72C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjITG3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITG3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:29:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5B39D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:29:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E88C433C8;
        Wed, 20 Sep 2023 06:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695191386;
        bh=2wuCQSkylz9QSMdbFh7QrwaeAka4CUawgsgVJN9yMuo=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=pWleZaUv0HwBbTmDCrmPy2HWqvGtedgCEo1fr6WPp6t5fz3l8y5PkqIKzQ30qTUAk
         1wXCVwQvGZW4LTK8D1v8p2DNIzw374U6ODp1dWWMvYR720WpRIeG7/fcwhlpiR1D4f
         brgFzHWoWj5clrFFaW9gskr0rqNlnf0I2L/QNPL3jSuR78uwLE4J43Rglgg0Inh6oO
         HApOPNA8UlyhDelA+T5w+UWDfjx9Ms0vZ4Pv6B6c2j/Sr6f8HVB2h6sEYMQN4cL0Tc
         opVOri2hc66XoGVkOTflnubb3ypGFr34DTjSSZ718f7UNlT8nGa9nKnB+/qyL8p0lF
         EedpViyWR6Vhg==
Message-ID: <cf7df9564146d47476d50d43f7b0bbff.mripard@kernel.org>
Date:   Wed, 20 Sep 2023 06:29:42 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Arthur Grillo" <arthurgrillo@riseup.net>
Subject: Re: [PATCH 1/3] drm/tests: Fix kunit_release_action ctx argument
In-Reply-To: <20230920-kunit-kasan-fixes-v1-1-1a0fc261832d@riseup.net>
References: <20230920-kunit-kasan-fixes-v1-1-1a0fc261832d@riseup.net>
Cc:     andrealmeid@riseup.net, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        mairacanal@riseup.net, tales.aparecida@gmail.com,
        "Brendan Higgins" <brendan.higgins@linux.dev>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@gmail.com>,
        "David Gow" <davidgow@google.com>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 03:11:36 -0300, Arthur Grillo wrote:
> The kunit_action_platform_driver_unregister is added with
> &fake_platform_driver as ctx, but the kunit_release_action is called
> pdev as ctx. Fix that by replacing it with &fake_platform_driver.
> 
> Fixes: 4f2b0b583baa ("drm/tests: helpers: Switch to kunit actions")
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
