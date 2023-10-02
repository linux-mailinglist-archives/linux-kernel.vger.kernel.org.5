Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F152D7B5818
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbjJBQtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbjJBQtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:49:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229219B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:49:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c328b53aeaso149556135ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696265352; x=1696870152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7XJ5dqJNV5CR1Ji4WUBRRsOzTxjBAVuiqQFOAjz294=;
        b=E8qQgqeUla7Z+Sv3I6z+DXWD8CATV7TWihdR5WJYkycIYg9MH72uJkAua1tD8ySbBG
         Zj3KoLdyI5jEVh5Y3iYLpKdU8Tr1CVwzgeI2B8fuGvwx1knWXx7AqOSm2UFvFv//XsOt
         BEfpbh7dXt4GSwjIqmCKxcmDjmJ3rEdJ+TaJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265352; x=1696870152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7XJ5dqJNV5CR1Ji4WUBRRsOzTxjBAVuiqQFOAjz294=;
        b=ufQhB346oknY7wb4YILXcAjecO4jzp4xlILUNo9eWlIHK5m08g/E2U180Kiy0qh2p/
         dtPpaobSkeq33dJWUD8panvE/3arC94kKvPgRE0Iy/IwMy8x5DmET00eP5AaqjQ/9+p4
         Pb0Ux5NgK/aIEgn6e2DkwsdGiUeZqH0qSQtUJGLCTrXhpQwM3caQ3AvJiHmvDfgAFyRA
         +wsaKUlagraKQWMLZVXSXuD88F1n3gAHaA1HeRN6apyymg5LuUATJOIWUIyHp4fpQ9kj
         wL/ZivehMD3dvd6M7KOTK/uBXgb6NKygWxZWPWAtWjom4ereeDpFAs56yy2F0bsoVp5v
         el4g==
X-Gm-Message-State: AOJu0Yy4sNdoNyMpVvKKOiRbu1+Nt9bCFjkf83ihQViBWHOX4Ac8Ovv+
        WUxUToMcmK/nZSY1Q5GutwuFXA==
X-Google-Smtp-Source: AGHT+IHrv23LVD12gIvMlECOZzW2oxgMdBZp+C3BsK92+u/yOg4JgdFuJ1c1G1mAfbhW7PBrvKLhkg==
X-Received: by 2002:a17:903:2788:b0:1c1:e380:b128 with SMTP id jw8-20020a170903278800b001c1e380b128mr11306748plb.60.1696265352674;
        Mon, 02 Oct 2023 09:49:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001c63429fa89sm12200145pll.247.2023.10.02.09.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:49:11 -0700 (PDT)
Date:   Mon, 2 Oct 2023 09:49:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: Use size_add() in call
 to struct_size()
Message-ID: <202310020948.DEFCF4F@keescook>
References: <ZQSr15AYJpDpipg6@work>
 <169625984488.65718.9772394979337795498.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169625984488.65718.9772394979337795498.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 04:17:24PM +0100, Mark Brown wrote:
> On Fri, 15 Sep 2023 13:09:11 -0600, Gustavo A. R. Silva wrote:
> > If, for any reason, the open-coded arithmetic causes a wraparound,
> > the protection that `struct_size()` adds against potential integer
> > overflows is defeated. Fix this by hardening call to `struct_size()`
> > with `size_add()`.
> > 
> > 
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()
>       commit: 3746284c233d5cf5f456400e61cd4a46a69c6e8c

Thanks! I've dropped it from my tree.

-Kees

-- 
Kees Cook
