Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3997912D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352487AbjIDH7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjIDH7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:59:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E3ECDD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84CBFB80DB5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB773C433C8;
        Mon,  4 Sep 2023 07:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693814352;
        bh=Hr+ZVUZEtyT9aITIw/fbNSO12wCle6xA57F6oFkrN3k=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=KkkWskWDxG1X90HqkhWXFHeZoCRsNKCmSzu9orGP+4K/SCoRyfG20SI2ru5IDQijk
         hJqqkixqI4seMEDdys16rT1nQNOGslEBv9uBxI9VTGXaiIebdApyL1DITesFLrLFj/
         nniNvjq9gIsscuV63xrzZg48ycKBnadFgf0XB2IlRnKkn1rqN2Vz9vk/wPFCWGIsFE
         F+eaGMLokU5QAhbPjtEjiPj0nzPGgdc3kgHBTGh6PjsL3Ghd+BFaGC7CgFsIW+7859
         h8Urw/DwIxPxLVkpip+r+TttIYdzA0FdDktWWBzgrQySke4kmuXU7j5NQ1qmOhoC2i
         8dsoBDq9ETQmA==
Message-ID: <bd57ed13cfa3f59b17bbae922c4e8bd1.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:59:09 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 4/6] drm/ssd130x: Call drm_atomic_helper_shutdown()
 at remove time
In-Reply-To: <20230901163944.RFT.4.I4752a39ad9f8fd08b32c2b78a8a3e40491bfb5eb@changeid>
References: <20230901163944.RFT.4.I4752a39ad9f8fd08b32c2b78a8a3e40491bfb5eb@changeid>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, javierm@redhat.com,
        linux-kernel@vger.kernel.org, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 16:39:55 -0700, Douglas Anderson wrote:
> Based on grepping through the source code, this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at remove time. Let's
> add it.
> 
> The fact that we should call drm_atomic_helper_shutdown() in the case
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
