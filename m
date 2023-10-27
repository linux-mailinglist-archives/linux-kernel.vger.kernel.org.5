Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF47D8F82
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345543AbjJ0HQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345517AbjJ0HQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:16:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951F8D64
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:16:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b95622c620so277409666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1698390987; x=1698995787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ddgeFEbz6IlrCxVYwXYFwysgYH7+uLRZ36rsStSaFs=;
        b=ZI2RVfhuEZzJ/JoL0Xpdcsw7msBbgNhfcgZOGbKeJVv+w9xbeFYiwWBibCvvraKfs1
         D5YFRIqLDSeSAZnp08wY1G27bsklWxYpPZpT4zCIS2U/MLHHIRgoDti5yx7rBTotw3hv
         NJ36ehXDgM51ZM9YsftT6NO8HuYO2IzRGcG/6aqEZKKOHfiI/YUHvvNI+WkQZ++7WdaA
         r71pp5YhDZH4g48/QUYkyl6XvW5PbxoxIXoQk1IqW/kyGRjfaowL7FM/DJKN93oNnQmz
         DTv9oCis0JkVOH4p0NyFj0L0YWg68dh57/wyjaEjvptZbW3ACsvmUDBYtSZWJ2F5fgly
         aPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698390987; x=1698995787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ddgeFEbz6IlrCxVYwXYFwysgYH7+uLRZ36rsStSaFs=;
        b=m7m+sKz8Nv4v1Iz60kCKTMZH2VT1B1SnRK+d97inSdnVQs63VHJzCTtZL/IqvZBO1d
         MY3EGeoAUGIoi8OMrYfgAtK3gvwl/ktqrWGOg6MarkdzbVALVhOo0xWRFloX8hlckKQC
         DQ4XE7AY2JKkXrl1kf44yyZgm7Ove5YtChLyR2+zXaS5rCk10f4sGbFBBfMhaUD5lrgi
         JRY+34Ibm9kze/kSjHYnjS9QYQnIXBApsGjYymhbaFpATYi4Mj2NzSctCwWHY4OSPr8Y
         G1LJALMgcAGhL8SgFWRDVKy+IUjwTFSyQO1KkxjFsBTuq6kX82pZBT/omrFOguk2lvic
         CGQw==
X-Gm-Message-State: AOJu0Yy7MWVTB97xiMRprzRfH6vyGf2jYY9doztm2RbG3ul8e/oWaYkA
        DCDxzdCzOr+S6VP77yzvvtNDmP54LuU42Nztl4a4ig==
X-Google-Smtp-Source: AGHT+IE8Eg+gl1oUKbvd40VC6iGtzQrs1ua9ZwoVLBt3jaZI183+rzT7zw+HfCSU4qDQDGAb5C1GjDHUNXLe5IpaIQs=
X-Received: by 2002:a17:907:2910:b0:9c6:724:fa1f with SMTP id
 eq16-20020a170907291000b009c60724fa1fmr1128697ejc.66.1698390986930; Fri, 27
 Oct 2023 00:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231027041023.16681-1-hunter.chasens18@ncf.edu> <4257cc2a-c116-4a5a-8c4e-422e67258525@infradead.org>
In-Reply-To: <4257cc2a-c116-4a5a-8c4e-422e67258525@infradead.org>
From:   Hunter Chasens <hunter.chasens18@ncf.edu>
Date:   Fri, 27 Oct 2023 03:16:15 -0400
Message-ID: <CAFJe6O1UWXm-yhr+q2bT_Zt1wH8W-=XcvJsCV1JZo9irrL+hNw@mail.gmail.com>
Subject: Re: [PATCH] docs: admin-guide: Update bootloader and installation instructions
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the catch. v2, has just been sent.

On Fri, Oct 27, 2023 at 12:41=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 10/26/23 21:10, Hunter Chasens wrote:
> > Updates the bootloader and installation instructions in admin-guide/REA=
DME.rst
> > to align with modern practices.
> >
> > Details of Changes:
> >
> >  - Added guidance on using EFISTUB for UEFI/EFI systems.
> >  - Noted that LILO is no longer in active development and provides
> >    alternatives.
> >  - Kept LILO instructions but marked as Legacy LILO Instructions.
> >    Suggest removal in future patch.
> >
> > Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>
> > ---
> >  Documentation/admin-guide/README.rst | 71 ++++++++++++++++++----------
> >  1 file changed, 46 insertions(+), 25 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin=
-guide/README.rst
> > index 9a969c0157f1..fba66f909f98 100644
> > --- a/Documentation/admin-guide/README.rst
> > +++ b/Documentation/admin-guide/README.rst
> > @@ -252,7 +252,7 @@ Configuring the kernel
> >      - The "kernel hacking" configuration details usually result in a
> >        bigger or slower kernel (or both), and can even make the kernel
> >        less stable by configuring some routines to actively try to
> > -      break bad code to find kernel problems (kmalloc()).  Thus you
>
> I don't see a problem with the above notation.
>
> > +      break bad code to find kernel problems (kmalloc()().  Thus you
>
> This way has unmatched parens.
>
> >        should probably answer 'n' to the questions for "development",
> >        "experimental", or "debugging" features.
> >
>
>
> --
> ~Randy
