Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6B768172
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 21:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjG2TdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 15:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjG2TdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 15:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B0FCE
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 12:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 636396069B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 19:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526BBC433C8;
        Sat, 29 Jul 2023 19:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690659194;
        bh=WoTBW2RInEWVN7BYf6Qj0vtLh2X+0pwyjuY2u3J4390=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uYVNNPMJrTg64eF+spfl+vwH4skqcYBOMk3kuSR/lkoXEOfQshJTY+Ll8rstVQCGY
         AMDTrcQJtLS7P0E80EGyejLSXk19zLdxLx0+QWQ4u3go90th3fXTp7H9tiFCsNprpB
         hYH89px4tQw2QA9jR1pS+wGFeA2T/T6D/uoJJ1vEohY2S1O7+EMJcTrZ4AtLKSXKO+
         jQefcmW/Vb4zma6pOOOpE0fFEs4XJo+ArEEv0efr33bbA2Ixqkv6ECKff5KamFAQ5l
         Vm0eCIvzIfArwrApqSAQCu/XHOV0DL9KFIetjGumiTu1zc1Z84Jqqn8fOKGXvbFKDj
         6ulLV+FQfbyDg==
Date:   Sat, 29 Jul 2023 12:33:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     =?utf-8?B?5a2Z5YaJ?= <sunran001@208suo.com>,
        airlied <airlied@gmail.com>, daniel <daniel@ffwll.ch>,
        "alexander.deucher" <alexander.deucher@amd.com>,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/radeon: Prefer 'unsigned int' to bare use of
 'unsigned'
Message-ID: <20230729193312.GA2844869@dev-arch.thelio-3990X>
References: <3a4bebc5-79fb-4799-8743-14a0dde97a4f.sunran001@208suo.com>
 <ZMUeNehNb52Qu/Cp@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMUeNehNb52Qu/Cp@debian.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 09:12:05PM +0700, Bagas Sanjaya wrote:
> On Fri, Jul 28, 2023 at 10:35:19PM +0800, 孙冉 wrote:
> > WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> > 
> > Signed-off-by: Ran Sun <sunran001@208suo.com>
> 
> Your From: address != SoB identity

While the comment below is a completely valid complaint, I think this
comment is being rather pedantic. Google Translate will tell you that
孙冉 is Sun Ran, so while the name does not strictly match, it is
clearly the same...

> > ---
> >  drivers/gpu/drm/radeon/radeon_object.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/radeon/radeon_object.h b/drivers/gpu/drm/radeon/radeon_object.h
> > index 39cc87a59a9a..9b55a7103cfd 100644
> > --- a/drivers/gpu/drm/radeon/radeon_object.h
> > +++ b/drivers/gpu/drm/radeon/radeon_object.h
> > @@ -37,7 +37,7 @@
> >   *
> >   * Returns corresponding domain of the ttm mem_type
> >   */
> > -static inline unsigned radeon_mem_type_to_domain(u32 mem_type)
> > +static inline unsigned int radeon_mem_type_to_domain(u32 mem_type)
> >  {
> >   switch (mem_type) {
> >   case TTM_PL_VRAM:
> > @@ -112,12 +112,12 @@ static inline unsigned long radeon_bo_size(struct radeon_bo *bo)
> >   return bo->tbo.base.size;
> >  }
> >  
> > -static inline unsigned radeon_bo_ngpu_pages(struct radeon_bo *bo)
> > +static inline unsigned int radeon_bo_ngpu_pages(struct radeon_bo *bo)
> >  {
> >   return bo->tbo.base.size / RADEON_GPU_PAGE_SIZE;
> >  }
> >  
> > -static inline unsigned radeon_bo_gpu_page_alignment(struct radeon_bo *bo)
> > +static inline unsigned int radeon_bo_gpu_page_alignment(struct radeon_bo *bo)
> >  {
> >   return (bo->tbo.page_alignment << PAGE_SHIFT) / RADEON_GPU_PAGE_SIZE;
> >  }
> > @@ -189,7 +189,7 @@ static inline void *radeon_sa_bo_cpu_addr(struct drm_suballoc *sa_bo)
> >  
> >  extern int radeon_sa_bo_manager_init(struct radeon_device *rdev,
> >           struct radeon_sa_manager *sa_manager,
> > -         unsigned size, u32 align, u32 domain,
> > +         unsigned int size, u32 align, u32 domain,
> >           u32 flags);
> >  extern void radeon_sa_bo_manager_fini(struct radeon_device *rdev,
> >            struct radeon_sa_manager *sa_manager);
> 
> The patch is whitespace-corrupted. Use git-send-email(1) to submit patches.
> Also, your patch is also MIME-encoded, hence the corruption.
> 
> To Alex: Please don't apply this patch due to reasons above.
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara


