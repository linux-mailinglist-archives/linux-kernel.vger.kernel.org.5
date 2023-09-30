Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563867B417B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjI3PJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjI3PJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:09:37 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B268DE5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 08:09:32 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4RyVxR6bBszDqYX;
        Sat, 30 Sep 2023 15:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1696086572; bh=Njov9crEEAyx/ZH+dhm6ZLX4cUh6uOIBOlSxDq03oqs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JvvZTtrLRXj4D810D+aYKYJUIeJZg4Bs1AcAI9n4BJjvkDdYXMg9J8k80EhcDtzkL
         SGHFgGlSxOT6v4KO00FHVlNZZRkoddgCFj9oDLPMp5pIn36UuK6WtlpJAo4ylVnf11
         P6Xf54NRR4c+ZmDC3Mh5O8LMExn0tRjX/Coe0Sp4=
X-Riseup-User-ID: C027825BD5B535AF7C62D6B8A5369EF8640170C15153CAFBB2DBDFB758649882
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4RyVxN6FyxzJntf;
        Sat, 30 Sep 2023 15:09:28 +0000 (UTC)
Message-ID: <3c3aed2c-cf87-7fcc-3e53-e2773e348367@riseup.net>
Date:   Sat, 30 Sep 2023 12:09:26 -0300
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v3 0/2] Add KUnit tests for drm_fb_blit()
To:     Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     tales.aparecida@gmail.com, andrealmeid@riseup.net,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20230918-final-gsoc-v3-0-b999c042a4cc@riseup.net>
Content-Language: en-US
From:   Maira Canal <mairacanal@riseup.net>
In-Reply-To: <20230918-final-gsoc-v3-0-b999c042a4cc@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arthur,

On 9/18/23 20:51, Arthur Grillo wrote:
> This patchset tests the drm_fb_blit() function.
> 
> As this function can be used with already tested formats, the first
> patch adds calls to drm_fb_blit() on the tests of supported formats.
> 
> Some supported formats were not yet covered by the existing tests
> because they are only supported by drm_fb_blit(). The second patch
> adds those format conversion tests.
> 
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>

Applied to drm-misc/drm-misc-next!

Thanks,
- Maíra

> ---
> Changes in v3:
> - Fix memset sizes to avoid out-of-bound access
> - Link to v2: https://lore.kernel.org/r/20230905-final-gsoc-v2-0-b52e8cb068ea@riseup.net
> 
> Changes in v2:
> - Split the patch into two (Maíra Canal)
> - Link to v1: https://lore.kernel.org/r/20230901-final-gsoc-v1-1-e310c7685982@riseup.net
> 
> ---
> Arthur Grillo (2):
>        drm/tests: Add calls to drm_fb_blit() on supported format conversion tests
>        drm/tests: Add new format conversion tests to better cover drm_fb_blit()
> 
>   drivers/gpu/drm/tests/drm_format_helper_test.c | 285 +++++++++++++++++++++++++
>   1 file changed, 285 insertions(+)
> ---
> base-commit: 37454bcbb68601c326b58ac45f508067047d791f
> change-id: 20230901-final-gsoc-395a84443c8f
> 
> Best regards,
