Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66D5777AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbjHJOiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjHJOiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9DCE53
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 725C5655E6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E421C433C7;
        Thu, 10 Aug 2023 14:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691678291;
        bh=pb1Mpk6gHTiUNUX5UXjt9QQaJarDzRUuvVrX52gFOWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdU+jwiYBr/65i8kypKIoFPTX82qUusg8Am5Ss4kgFLmevUrjTTPGY+WZ3CC/vV5q
         bx+pBYz26PwfvOdqGESBv/4Wh5wuIJtvpnWk9/xTflfDwbBTc47XbK9dU1MlonZb5A
         ZNiICH+tuUzx53p7anw2/HnYAxrWArjzTrt7A91GT1QCEF3K+4uu+f5cBGeP/vEXku
         w2UAQuh54NhyYwOQ81125np9ViKGyQs2ZJtvcxvE8XqKydNtAznbtPFwEtj0bdTpk7
         BvOM1zH6v0XdQAFuwvBDqpi75TRdIH3QtifVslR2L6MoXmnMLGY0+7mMMWm4jeQ4Uy
         P/CoRhNIpZhyA==
Date:   Thu, 10 Aug 2023 07:38:09 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        ndesaulniers@google.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, trix@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        naresh.kamboju@linaro.org, dakr@redhat.com
Subject: Re: [PATCH 1/2] drm/exec: use unique instead of local label
Message-ID: <20230810143809.GC1549244@dev-arch.thelio-3990X>
References: <20230731123625.3766-1-christian.koenig@amd.com>
 <20230809153755.GA832145@dev-arch.thelio-3990X>
 <20230810084002.636cc827@collabora.com>
 <7a09909a-4c94-2e4b-dd9a-4bd019b67585@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a09909a-4c94-2e4b-dd9a-4bd019b67585@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 08:48:05AM +0200, Christian König wrote:
> Am 10.08.23 um 08:40 schrieb Boris Brezillon:
> > On Wed, 9 Aug 2023 08:37:55 -0700
> > Nathan Chancellor <nathan@kernel.org> wrote:
> > 
> > > Hi Christian,
> > > 
> > > Can this be applied to drm-misc? Other drivers are starting to make use
> > > of this API and our builds with clang-17 and clang-18 have been broken
> > > for some time due to this.
> > Queued to drm-misc-next.
> 
> Sorry for the delay I have been on vacation last week and haven't yet
> catched up to this point in my mails.

No worries, 'tis the season :) hope it was a good time and thank you
both for getting this fixed!

Cheers,
Nathan
