Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C07C9819
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 08:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjJOGHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 02:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJOGHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 02:07:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB76FC5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 23:07:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b497c8575aso1706728b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 23:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697350039; x=1697954839; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3kGlq2Xx5BQrtm1OWloUhGm2g6MFTZwo7jhQhW9zsg=;
        b=hpcC4fT/dJlD6/WyMRq8x0/jKUJkXeZa2M/B5ofFbmJ8U9ZlpYZn6UKVAZJnrite1W
         tb+gS73QAJel5NbYVes2UMwZqz1unqIUHIx4vgHwVoe1gtIx46q3qha/uTDjEZBrMP1N
         zs3ZCny8jFK4G6WcQcV2ovk+nYkI6ptYCnqaE1rj1XxUBhVxCR0ont7yxRxCCA/tWTyO
         sy36G+5ph1gpu+olgSbfOa7+4EQI0zQEtmw4PiFISWZIL9DRKMXlmQZwBPEO127agGaO
         zTZGsvAcl4p5KDgNLLVFh3lfJoWop/mLC8QBwjRmtdGcmJG7Fv3fH4TFKbaAVQsS/Tpq
         pQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697350039; x=1697954839;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3kGlq2Xx5BQrtm1OWloUhGm2g6MFTZwo7jhQhW9zsg=;
        b=Wh22FNUKII8Mgg17gmmjb083mtQ+yAtE7ditoawhFbx2KZcE/kpHJ2x2rwiKAYFLq+
         bumxlUQKCFsVLDzQ3cyo68pTSGKqDoHCoPCJVP3MInxd8QLWO9rtmOJj3hBA7aMV+xzS
         YCJczwqavl2FauxtoDrq0zxkrxzKuQF3G/PYpibI2jmiQdUPL5lwpDVCOTV2zXMy9M3v
         vwdZa2BOVmW7oRtQ2GGK/VgWN3Z0e5E+qBCvEmaoV83bs18Il0ekYmo1YA0QkDQ1RewN
         CLuhkSmfWN6H60z1EZZpJSrUku2QrmeRjHQW8X1ZXejNK4EJ0RrUxR0ifqji870C4xIf
         JthA==
X-Gm-Message-State: AOJu0YwnrgSQMvUqvCWg2bkS41/w4PSDurqhzMmWlsy7DNPC+EVHdKHB
        OdUXbjZmhzLkcXmeuEmj9YPliBGp2mgB0A==
X-Google-Smtp-Source: AGHT+IFZon2eyX8yO2v2tuhGiWGE3ETezS14zyfWDXYBmJGr4Z49Me9EoSJztJD6sCKGOcbAMQHq4g==
X-Received: by 2002:a05:6a20:9188:b0:140:f6c4:aa71 with SMTP id v8-20020a056a20918800b00140f6c4aa71mr34483243pzd.8.1697350038868;
        Sat, 14 Oct 2023 23:07:18 -0700 (PDT)
Received: from Negi (2603-8000-b93d-20a0-2184-6fa4-0d39-1c6b.res6.spectrum.com. [2603:8000:b93d:20a0:2184:6fa4:d39:1c6b])
        by smtp.gmail.com with ESMTPSA id bx29-20020a056a02051d00b0056606274e54sm2284008pgb.31.2023.10.14.23.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 23:07:18 -0700 (PDT)
Date:   Sat, 14 Oct 2023 23:07:16 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: gdm724x: Add blank line after declaration
Message-ID: <20231015060716.GA31326@Negi>
References: <cover.1697184167.git.soumya.negi97@gmail.com>
 <3b24ca9976cf873dbaadb499e09d7b545e9db89c.1697184167.git.soumya.negi97@gmail.com>
 <2023101551-placidly-garnish-3ee7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101551-placidly-garnish-3ee7@gregkh>
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

On Sun, Oct 15, 2023 at 07:37:30AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 13, 2023 at 01:26:35AM -0700, Soumya Negi wrote:
> > Fix WARNING: Missing a blank line after declarations
> > Issue found by checkpatch.pl
> > 
> > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > ---
> >  drivers/staging/gdm724x/gdm_tty.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Why do you have "tty:" as the prefix for a staging driver?  Shouldn't it
> be "staging: gdm724x: ...."?

Hi Greg,

Thats what I thought too. But when I looked at the git history for
gdm_tty.c the last few commits had "tty:". So I went with that.
Should I change it to "staging:"?

Regards,
Soumya

> thanks,
> 
> greg k-h
