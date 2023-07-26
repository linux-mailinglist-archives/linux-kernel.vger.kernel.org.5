Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE54E762A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjGZEzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGZEzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:55:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8227019AD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 202E36145A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2E3C433C7;
        Wed, 26 Jul 2023 04:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690347339;
        bh=jOeF8cppzlPBCIFSmBztXHTHPsxcIlXUKSUY753sPaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxwcE7OfXPa1gb3qMiUZj/lC1U5j/C1r691UiAJQVkcVVAudxFcwtAGx8Wu2AcBnB
         8lw24oou0sqv8AzGPDJFOusy7EgHHBLa0o5YKEMRCYKB89vjV3tpZvC17ICy6u/8X6
         wk9O06Fvrp3aj5VQ4wyFnph/ve5zGaqkPJNX5ABraRKfX98byGF+KGkHOPeLYldO83
         LJguFqCyv0CZWxH63HcSnPxUnB+xQo2/ZUImevvR5gtdveNs84BRWD/GnRadRWkB03
         xjDYrOn/ZU721oOo2Pfgdaa1cWGeddodXaPNYVMwVN/JG2S9oD+Y1Nz2p6/u6fUTNP
         VKL7rm/ov1IpQ==
Date:   Wed, 26 Jul 2023 10:25:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robert Lee <lerobert@google.com>
Cc:     Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: compress: add opus codec define
Message-ID: <ZMCnR0AooUOLbQKB@matsya>
References: <20230725093005.3499455-1-lerobert@google.com>
 <87sf9ctifg.wl-tiwai@suse.de>
 <CAOM6g_Db8qwbDmbWSSLKqUHsSMLUYxFtpqKi1cWsXsXTE9B+vA@mail.gmail.com>
 <87lef4thir.wl-tiwai@suse.de>
 <CAOM6g_DVKpEhnVStpNWmPoXyHNUuNTA+CNbdPxasObGcXtGEpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOM6g_DVKpEhnVStpNWmPoXyHNUuNTA+CNbdPxasObGcXtGEpQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-07-23, 09:47, Robert Lee wrote:

Please stop top posting!

> Yes, but we still need this change to let the sound system can use the
> codec. or do you have any suggestions?

Upstream your driver along with this change should be the way to go

> 
> Thanks,
> Robert.
> 
> Takashi Iwai <tiwai@suse.de> 於 2023年7月25日 週二 下午6:25寫道：
> >
> > On Tue, 25 Jul 2023 12:14:56 +0200,
> > Robert Lee wrote:
> > >
> > > Thanks for reply so quickly.
> > > And yes, there are other changes but it is inside our offload pcm
> > > driver to handle it.
> > > Currently we only use it to decode, and we don't need additional option for it.
> >
> > It means still a downstream-only change :)
> >
> > It's nice to upstream changes in general, but from the upstream POV,
> > only changing this gives no benefit.  Let's tie with the actual use
> > case *in the upstream*.
> >
> >
> > thanks,
> >
> > Takashi
> >
> > >
> > > Thanks,
> > > Robert.
> > >
> > > Takashi Iwai <tiwai@suse.de> 於 2023年7月25日 週二 下午6:05寫道：
> > > >
> > > > On Tue, 25 Jul 2023 11:30:05 +0200,
> > > > Robert Lee wrote:
> > > > >
> > > > > Add to support decode Opus codec in Ogg container.
> > > > >
> > > > > Signed-off-by: Robert Lee <lerobert@google.com>
> > > >
> > > > The change makes sense only when it's really used.  So usually it's
> > > > better to put into a series that actually implements its usage.
> > > >
> > > >
> > > > thanks,
> > > >
> > > > Takashi
> > > >
> > > > > ---
> > > > >  include/uapi/sound/compress_params.h | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
> > > > > index ddc77322d571..bac5797bcb02 100644
> > > > > --- a/include/uapi/sound/compress_params.h
> > > > > +++ b/include/uapi/sound/compress_params.h
> > > > > @@ -43,7 +43,8 @@
> > > > >  #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
> > > > >  #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
> > > > >  #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
> > > > > -#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
> > > > > +#define SND_AUDIOCODEC_OPUS                  ((__u32) 0x00000011)
> > > > > +#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_OPUS
> > > > >
> > > > >  /*
> > > > >   * Profile and modes are listed with bit masks. This allows for a
> > > > > --
> > > > > 2.41.0.487.g6d72f3e995-goog
> > > > >
> > >

-- 
~Vinod
