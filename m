Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E7F791254
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbjIDHgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjIDHgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0256E1;
        Mon,  4 Sep 2023 00:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 314D360E07;
        Mon,  4 Sep 2023 07:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4189EC433C7;
        Mon,  4 Sep 2023 07:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693812992;
        bh=ifPD/PpcFGy5BkBIW60gH1WfLi6Mtr0jzAX+D89MzQc=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=BiPKLKjhSiZaGu/WeyIVG5OopwSw93yvGNubGE+4uxjPw4sUJjAnonnTG2b5hQAn9
         Ija//ja626ZM2/Qu/ROs0As9soVtMgG6fTsqa5IMlBcNo6w2ojLGDF4CWkyyS2pecy
         jnY8b2sKbavQ9rDV77C0tWar2LbH8cL6FpRjpJe/g6GOhHKXkZxcFc2XOvcePOqCWb
         JbV00ePi1e5YnngihYWwDzryeVlfjrSbADy2WqNXCiRHKNoxMId1j6yRRfo6q7Dfga
         G3vQhsYQtqNGjRRSQF52VBXiJzBZGk6Zo8GAh8yQpwsb0XEiF01MCAgpWXgDhjX8mJ
         qTHnQhn8FcRdA==
Message-ID: <26841f583f9527205554a0ae8f75ec8d.mripard@kernel.org>
Date:   Mon, 04 Sep 2023 07:36:29 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [RFT PATCH 03/15] drm/ingenic: Call
 drm_atomic_helper_shutdown() at shutdown time
In-Reply-To: <20230901164111.RFT.3.Iea742f06d8bec41598aa40378fc625fbd7e8a3d6@changeid>
References: <20230901164111.RFT.3.Iea742f06d8bec41598aa40378fc625fbd7e8a3d6@changeid>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, paul@crapouillou.net,
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

On Fri, 1 Sep 2023 16:41:14 -0700, Douglas Anderson wrote:
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
