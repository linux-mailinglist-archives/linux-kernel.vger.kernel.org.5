Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514BB7D04AB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346606AbjJSWOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjJSWOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:14:03 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35A7A4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:13:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b20a48522fso220812b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697753637; x=1698358437; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxO9CeupjJm1VNV2qD42mx1Z0tO6w55cG3DvFE0akJU=;
        b=S3v5fvXQgCE30407qy8DPQu4aOh/7tNf4+PnlUBy6ALJQ9BU0ziNS8aRSK44pUmujc
         Ch3o0ku99uqSGsHIBgVjdPeAiSuXYMgqs3Qmg5SrJWSa0wugl1hfKYEe/V/NH9lT2d4q
         O6GOoYjK6CP0Ic30aDm2/3Nv7844RREZbldODkjb0Fgwz2V6Yzw5XQHvsp8K7/c3Tv+F
         TQZ34YhBwCyC5DfhMSZI65KunJCTfCLeC8dSbSffXXJztFoP8CZmaIH7a4AyL0qsUc5v
         h70SNvuyOylXUwYSpZbpUf9Zs/Pj+R3RPOwPmdDv96tE4MGKqqgBxrGfiL9jh+e0Datn
         sdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697753637; x=1698358437;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxO9CeupjJm1VNV2qD42mx1Z0tO6w55cG3DvFE0akJU=;
        b=W22SwHP/W4RvYY7cZFUzjodMSRJN0ReH7alhnQtRIa6sU3bvDv3PuJl4EgCQxvcaYo
         yUNiqFo5bbD5ZvA7nx2UcDtu4X2h1ne42W5INeDyGwBuK4mv47jkf/6NkEEtkgpP3o+8
         R8wkTxM0d+Wml6PKEK2O8MeSyQCNyYowz4UJS0dultbZkT8kWqUa8bmEK5UT0qhbli6d
         dfFzTzBGHOspOb41BvPQTKYjhcBLybknocsSoY2+r23v+bubyANhDJ0oGoYDRN2v+pR9
         gb12ubwmlco1tdmbguDyjtw5VgxWb+ANDug/Z8Dma/5aUo3tmCT2h2oIHhGAu+o2qMRC
         JdHQ==
X-Gm-Message-State: AOJu0YxE2UmpBGGNrBbxB1xcMUR4ALyzpmrozxcNYr9tz1VNtD/e36SC
        X++SIeQWbTjHiNdui+ho/Mc=
X-Google-Smtp-Source: AGHT+IFwQRmhtvP0fKkwRfeNWZwTshKFTJ7DO2jhksHpulTKIEY5JBnAse72r6NqTA1XdtG76bRWuw==
X-Received: by 2002:a05:6a00:138f:b0:68f:dd50:aef8 with SMTP id t15-20020a056a00138f00b0068fdd50aef8mr60518pfg.4.1697753636739;
        Thu, 19 Oct 2023 15:13:56 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id n11-20020aa7984b000000b00690d4464b95sm276425pfq.16.2023.10.19.15.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 15:13:56 -0700 (PDT)
Date:   Thu, 19 Oct 2023 15:13:55 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 2/2] staging: vme_user: Use __func__ instead of
 function name
Message-ID: <20231019221355.GC3017@Negi>
References: <cover.1697696951.git.soumya.negi97@gmail.com>
 <996c9f92e7fd288f67c02dfb0ba524ab7c5fe421.1697696951.git.soumya.negi97@gmail.com>
 <ZTFOGIu5U+ZUodXW@ashyti-mobl2.lan>
 <20231019191428.GA32717@Negi>
 <ZTGgVNBoxOtWOuE8@ashyti-mobl2.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTGgVNBoxOtWOuE8@ashyti-mobl2.lan>
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

On Thu, Oct 19, 2023 at 11:32:04PM +0200, Andi Shyti wrote:
> Hi Soumya,
> 
> > > On Thu, Oct 19, 2023 at 12:20:10AM -0700, Soumya Negi wrote:
> > > > Replace function names in message strings with __func__ to fix
> > > > all checkpatch warnings like:
> > > > 
> > > >     WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
> > > >              this function's name, in a string
> > > > 
> > > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > 
> > > you forgot my ack here:
> > > 
> > > Acked-by: Andi Shyti <andi.shyti@linux.intel.com> 
> > > 
> > > Andi
> > 
> > Sorry I forgot the tag Andi. I'll add the tags in v3(Greg has suggested
> > more changes). There will be some new patches, so I'll leave the tags out in 
> > those as you may want to review them first.
> 
> no problem.
> 
> I don't see reviews from Greg in this v2 series. If you are
> referring to the changelog, then you don't need to resend.
> 
> Andi

Hi Andi,

I had sent in v2 after suggestions from Julia and Greg. Got some more
feedback from Greg in the v1 email thread though. Will have to send a v3 due 
to that.

Regards,
Soumya
