Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3FD786ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbjHXMLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbjHXML1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:11:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CC8198B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:11:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E779E62446
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF8CC433C8;
        Thu, 24 Aug 2023 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692879084;
        bh=w0EtY0V42ap7xNdrb9LVuX4xxUWvo184EQMRJ30AxBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TD6vsq4x8nJfHJW5vQPCWvMawEscvAWes8lyEZ0QsxdwxnxWld9b5RsOSvc2FuQSl
         0plqeDSe3iC4lt9fFMnxDgsRrzt3YWT8WL80CM3fTe/svnjr5oiRhKp8vZpZHtYdWa
         QPUYstn7vfVe+vpf3Vj+rfyfA5BkdiB4D6NYApdAEi8OV0l2TWZBSsiTnKnLE0+ac1
         HY8k7zLM0lQEAieYQpGxPS5J8sfsM/ZubuFLxzHGD7awK2wKGxvTFBqdVjot1qoEpZ
         QgK3nMgh9if+OFPVdnSnxIHoi6EylMfDiRo0yLuFSepiyz8PdAPbw7+l13XdO6Tfmn
         AF9ODrgioUzVw==
Date:   Thu, 24 Aug 2023 13:11:20 +0100
From:   Lee Jones <lee@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 13/20] drm/tests/drm_kunit_helpers: Correct possible
 double-entry typo in 'ddrm_kunit_helper_acquire_ctx_alloc'
Message-ID: <20230824121120.GV1380343@google.com>
References: <20230824073710.2677348-1-lee@kernel.org>
 <20230824073710.2677348-14-lee@kernel.org>
 <b67sjdnlltxlg5qjeebbocgmpdsxv6qvyzpjwjqy5pkyeovaiv@76snvdcewxmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b67sjdnlltxlg5qjeebbocgmpdsxv6qvyzpjwjqy5pkyeovaiv@76snvdcewxmo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023, Maxime Ripard wrote:

> Hi,
> 
> On Thu, Aug 24, 2023 at 08:36:58AM +0100, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/tests/drm_kunit_helpers.c:172: warning: expecting prototype for ddrm_kunit_helper_acquire_ctx_alloc(). Prototype was for drm_kunit_helper_acquire_ctx_alloc() instead
> > 
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: "Maíra Canal" <mairacanal@riseup.net>
> > Cc: dri-devel@lists.freedesktop.org
> > ---
> >  drivers/gpu/drm/tests/drm_kunit_helpers.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> > index f102c23eee1dd..c1dfbfcaa0001 100644
> > --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> > +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> > @@ -156,7 +156,7 @@ static void action_drm_release_context(void *ptr)
> >  }
> >  
> >  /**
> > - * ddrm_kunit_helper_acquire_ctx_alloc - Allocates an acquire context
> > + * drm_kunit_helper_acquire_ctx_alloc - Allocates an acquire context
> >   * @test: The test context object
> >   *
> >   * Allocates and initializes a modeset acquire context.
> 
> The typo was added by your patch 9.

Whoops!  Good catch.
> 
> I've applied and squashed them both

Perfect, thank you.

-- 
Lee Jones [李琼斯]
