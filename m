Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A107C9AFC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 21:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjJOTTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 15:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjJOTTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 15:19:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54728A9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 12:19:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso1586245b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697397553; x=1698002353; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D1FB5LCWe5+pgRGVMl8YGDlVNocRdZi5zO7vTLOp1k=;
        b=MyrkOxwozyghqfVSD9W71fgqFXX7gNDI+XNCv0C32AaH6KE3gS6GerFe7KtHbRuJL5
         MzVmxQMs8IJRmwPtgKZ+xO4O6l99/UVS0iUp/JUhZtW4X/ZT8r+c6Xd/lyE1sLdTYQTs
         YTMBBYVT5IVVjWg8gFVGFc+2J3mykylPmLNOwtVowY/ZwAgSKNa5c0cbBCre2HBgljpV
         2odOAxeKpJeuxMUI+syDdpx6/3joe1yOgsIJXj0oFRiFsRaMr0dSj0evR1qO6AIK4Dtk
         0kfiF6GuQZKYNwQ4obz7Drv+1zC453FIBHDczpeEdlU81l23RMS6PhyQCNEPoj3S5Udu
         Hw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697397553; x=1698002353;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6D1FB5LCWe5+pgRGVMl8YGDlVNocRdZi5zO7vTLOp1k=;
        b=ekJrXTbS+vuUgoiXCr/sZSswhxxWaOivdIkyAIThILKl0bx858wPeCzOJZ2Qja6spd
         crBTe5pDy6avVgQbwG0kWA9Ot75ABRkJmvk6tofSzcxkqz4rE+82/LO4b5FCpYOV/cP1
         yOJ9B1pZH6+ve9hur31k5W5wGRxvBzeY+ws7Fu6gqSoQeT8EqFx3UXucQNurHmjCP2BW
         VPkPNxwzq0kkNtwRcDBl25SEs6EDTOaE3pWbHaT4X9fs4LdmflfJ1E7gfyXYaJ89TL8I
         seu1RpL5AfRq4MJiLrRzU/u0yCo4OcSAfeDdJ7lQcyKC7gSy3XsGTOH37/N7REh37554
         6qEA==
X-Gm-Message-State: AOJu0YxkOcmIGpphB9IM4RFouA2qJD5POFBuL3gcirP2Ko4j2d43pw5j
        cDxJre3t/ryqQqsMp7S1IWtivLdyC5DomA==
X-Google-Smtp-Source: AGHT+IGwnPwzd1w/U3V/+aV6xYyt2haECnHpqgVZhtugIsRBR7bQ6rZcoH8alxLhhb2Gh41Crg25Wg==
X-Received: by 2002:a05:6a20:5490:b0:13d:8876:4c97 with SMTP id i16-20020a056a20549000b0013d88764c97mr34217524pzk.16.1697397553507;
        Sun, 15 Oct 2023 12:19:13 -0700 (PDT)
Received: from Negi (2603-8000-b93d-20a0-2184-6fa4-0d39-1c6b.res6.spectrum.com. [2603:8000:b93d:20a0:2184:6fa4:d39:1c6b])
        by smtp.gmail.com with ESMTPSA id i15-20020a63b30f000000b005891f3af36asm5641490pgf.87.2023.10.15.12.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 12:19:12 -0700 (PDT)
Date:   Sun, 15 Oct 2023 12:19:10 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: gdm724x: Add blank line after declaration
Message-ID: <20231015191910.GA2361@Negi>
References: <cover.1697184167.git.soumya.negi97@gmail.com>
 <3b24ca9976cf873dbaadb499e09d7b545e9db89c.1697184167.git.soumya.negi97@gmail.com>
 <2023101551-placidly-garnish-3ee7@gregkh>
 <20231015060716.GA31326@Negi>
 <2023101508-curry-disorder-1b10@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101508-curry-disorder-1b10@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun, Oct 15, 2023 at 02:50:44PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Oct 14, 2023 at 11:07:16PM -0700, Soumya Negi wrote:
> > On Sun, Oct 15, 2023 at 07:37:30AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Oct 13, 2023 at 01:26:35AM -0700, Soumya Negi wrote:
> > > > Fix WARNING: Missing a blank line after declarations
> > > > Issue found by checkpatch.pl
> > > > 
> > > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > > ---
> > > >  drivers/staging/gdm724x/gdm_tty.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > 
> > > Why do you have "tty:" as the prefix for a staging driver?  Shouldn't it
> > > be "staging: gdm724x: ...."?
> > 
> > Hi Greg,
> > 
> > Thats what I thought too. But when I looked at the git history for
> > gdm_tty.c the last few commits had "tty:". So I went with that.
> 
> That is because those commits were tty-wide, and they changed things in
> multiple drivers all at once, not just for the one file.
>
> > Should I change it to "staging:"?
> 
> Please do.

I'm sending this patch in a new thread since the other patch in the
patchset(had 2 patches) was reviewed as unneeded.

Regards,
Soumya
