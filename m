Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6F27B4995
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 22:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbjJAUhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 16:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjJAUhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 16:37:12 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ADFBD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 13:37:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5859a7d6556so2147909a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 13:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696192628; x=1696797428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fyBFMSqqwX8RPnuE4cKMfmvDwm/8Oa7DFI/6NjwESSg=;
        b=aGauLLfzUZSenoVQkQXwhwHD4HmsNjV2X8H9IjzgckcLywfFvM6+0+WO21zeo0gwNS
         IFl/eWWuG6G+6EDea75gDCFT5E2/K5GlpJfq0Sz+6zXJ9/xvfqBcKZMXkJBglDQT65aO
         B+uTD0035K3nfua5WOnhMMpyxyrWhyg6++KOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696192628; x=1696797428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyBFMSqqwX8RPnuE4cKMfmvDwm/8Oa7DFI/6NjwESSg=;
        b=Oj1Fy4g8Q7PQPNwGztCR5WsQFQvAACZDhOv8b05akuiSZSeTYHotkx6RvK7bWFLU1O
         JMf3XVN3GGdwgfFK2S9TjtBuS1vXuBlRMthSKMRLgzu6hsnE0f/huXNOud+QJ+F5G4Gj
         PjTLOcYgNChcW993oON8CFWqRaJyWEf6Rj6NMVZQ1OyBXVvIxgnQ6+kOO/swya/5ORdu
         84Ldcst0k03kJiXcQmm8G2zJmmBDdHK1i7VCdMpdrFjpZm9LXvtP24mrxeILSiYfi0ld
         QjJLI4SfRlqwQPZCmDv8qxwG+rJnq427ggGwtQ6atUn1bOZLGtjtVm+qnp/Ohv14RuQw
         sUdg==
X-Gm-Message-State: AOJu0Yzi86bDS7kHwdsNGf5D2nReLmhlU/qg64dbtAXj7eZDrRHqWSyW
        PA4WdxQj8NKzzFW7Py3hLSR54P0q9a2zJesLTwY=
X-Google-Smtp-Source: AGHT+IH0+lH3U3tlZJvdil7jRXzwK7T7NrFAv5uYLQCT/HAB93NjqNDt0CShB8VBCNkf5st0BzTA+w==
X-Received: by 2002:a05:6a20:8e0a:b0:133:bbe0:312f with SMTP id y10-20020a056a208e0a00b00133bbe0312fmr12736806pzj.50.1696192628223;
        Sun, 01 Oct 2023 13:37:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b001c3e732b8dbsm20673804plg.168.2023.10.01.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 13:37:07 -0700 (PDT)
Date:   Sun, 1 Oct 2023 13:37:04 -0700
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
Message-ID: <202310011335.28B55A3BE@keescook>
References: <ZQSr15AYJpDpipg6@work>
 <169601489953.3012131.13922425518082792309.b4-ty@chromium.org>
 <ZRlJN9qVOv7CIu1N@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRlJN9qVOv7CIu1N@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 11:25:59AM +0100, Mark Brown wrote:
> On Fri, Sep 29, 2023 at 12:14:59PM -0700, Kees Cook wrote:
> > On Fri, 15 Sep 2023 13:09:11 -0600, Gustavo A. R. Silva wrote:
> 
> > > If, for any reason, the open-coded arithmetic causes a wraparound,
> > > the protection that `struct_size()` adds against potential integer
> > > overflows is defeated. Fix this by hardening call to `struct_size()`
> > > with `size_add()`.
> 
> > [1/1] ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()
> >       https://git.kernel.org/kees/c/93d2858dd630
> 
> Why is this bypassing the ASoC tree?

Hi! Sorry, I can drop it if you want to take it? I tend to collect trivial
hardening changes with reviews that haven't been otherwise commented on
for at least 2 weeks.

-Kees

-- 
Kees Cook
