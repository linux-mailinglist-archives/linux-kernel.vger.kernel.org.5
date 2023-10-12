Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56B77C6EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378572AbjJLNDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347260AbjJLNDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:03:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66428B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:03:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso705427b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697115827; x=1697720627; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIDdHfachdzSYdbMoayfgG9KGaQkVwpYZ7M9Wz17QLI=;
        b=nPBcUDDsmAoxCuC+Du7Alwq2wlNTMQ3y0OXzdjuc1D97wi35BL3tgYiBTLSUaXGRDY
         qkALBV61E10J8c5TeFY1Ge1MLT00JwUf9+80DmtNwbJJCZjgpkJJ9LmXwsEMxPOu+yrZ
         DvmuanPkRz+J8//WpAXzUaIaEJ78Vq9NMyy+AHRWWZ9oMd+DgfuQRfXv1mqkv/VyjVYx
         Tfti4ufsxDByjZFRxwo+MCyFd7I61Z+s6zaA3QbIlpqex7WjjqY+POVfQdp1TJ0DOSF0
         2ioOvKVJsreb/af0agQr5PlV4fqFJGcJ77Vw2rdk1xtkuXmSu9xHJ6tlhdbK5XTwndc9
         IIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697115827; x=1697720627;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIDdHfachdzSYdbMoayfgG9KGaQkVwpYZ7M9Wz17QLI=;
        b=teDKHVAdqBcz5qfQ9MGsOYkw1SbmoqllRY9a+ignGBctNuwkTML3fiFSWLSNG0KQOA
         2OwGgzEIu4YLbqm4fvYss0DKcbVjfF0/QkHyFx+Y633QU4IsPAnENxc/qGtInFiuaIm8
         GuZEPdSt3x/nxkuzjENyFK3+13vA+q2/LvsbuipxlyWRLqSwR6cJKClfwheqePw1wT1R
         enkHBDTvGhJF0FlVbLsGR1XIMMKK1kXCR+XIS3v0D7yNDoc9N8jOqaGShlmQlstAGDk8
         5lHr3SftcTQ0Rbl0sB78RT3RtJiX4n1m8qEMjEjvp3m+pGbFwI0z6R5TzJ2SF+IEU14v
         ndUQ==
X-Gm-Message-State: AOJu0Yz4KJs2gApac8ef1fLpxzOsilKZEs+sEDNBq7WmQxbXKve2r648
        KCvP2AxNt+fOepDU/09a3h3ulUDhdty6iQ==
X-Google-Smtp-Source: AGHT+IEUgLYHpBlq28D59kLvKyvlLaVPZA/uM46REBEA+C2L29sl0PSXTZXGTdkya46UNec+FfsCbg==
X-Received: by 2002:a05:6a20:1456:b0:134:73f6:5832 with SMTP id a22-20020a056a20145600b0013473f65832mr34363741pzi.16.1697115826088;
        Thu, 12 Oct 2023 06:03:46 -0700 (PDT)
Received: from Negi (2603-8000-b93d-20a0-2184-6fa4-0d39-1c6b.res6.spectrum.com. [2603:8000:b93d:20a0:2184:6fa4:d39:1c6b])
        by smtp.gmail.com with ESMTPSA id y18-20020a637d12000000b0059d219cb359sm1606244pgc.9.2023.10.12.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:03:45 -0700 (PDT)
Date:   Thu, 12 Oct 2023 06:03:44 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Micky Ching <micky_ching@realsil.com.cn>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Parenthesize macro arguments
Message-ID: <20231012130344.GB7107@Negi>
References: <20231012050240.20378-1-soumya.negi97@gmail.com>
 <81d6e283-fd87-4fd6-964f-22cbf420cdaa@kadam.mountain>
 <20231012074837.GE16374@Negi>
 <a1556f74-83ef-d32-103d-6b0b0233473@inria.fr>
 <20231012124920.GA7107@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012124920.GA7107@Negi>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 12, 2023 at 05:49:20AM -0700, Soumya Negi wrote:
> Hi Julia,
> 
> On Thu, Oct 12, 2023 at 09:51:27AM +0200, Julia Lawall wrote:
> > 
> > 
> > On Thu, 12 Oct 2023, Soumya Negi wrote:
> > 
> > > Hi Dan,
> > > > For these ones, the name is too generic.  probably the right thing is
> > > > to just get rid of them completely and call spin_lock/unlock_irq()
> > > > directly.
> > >
> > > I understand that there should be 2 different patches, one for the
> > > macro-to-function rewrites & one for replacing the scsi lock/unlock macros with
> > > direct spinlock calls. But, should these be in a patchset(they are vaguely
> > > related since the patches together would get rid of the checkpatch warnings)?
> > > I'm not sure.
> > 
> > Patch set, since they affect the same file.  Otherwise, Greg doesn't know
> > in what order to apply them.
> 
> Thank you for explaining each point. I'm sending over the patch set for
> review in a new email thread.

My last patch in the set didn't go through. THe error message is "multiple In-Reply-To
headers. To reduce the amount of spam sent to Gmail, this message has
been blocked." I used the --thread=shallow flag with git format-patch.

Should I try resend the entire patch set again without the flag? Or is
there any way to send the remaining patch by itself?

Thanks,
Soumya
> - Soumya


