Return-Path: <linux-kernel+bounces-10308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2213481D281
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAFC2859B1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B29B5683;
	Sat, 23 Dec 2023 05:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naTgHAQd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861504A34;
	Sat, 23 Dec 2023 05:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7cc6c88fb12so455952241.0;
        Fri, 22 Dec 2023 21:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703309386; x=1703914186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2rOcyFfxflN36gMhvNpR/DHK+BxldNKzckHr4V32hdY=;
        b=naTgHAQdRzAj7O2+T44bTXzOew3upcCpniaDmbOQl4IgnmhIIaTdrrMBJPJDR8f2M2
         PSdphYQBGt4Vrm7KbP1DD5fJsWdSr7meetCHbMfJJV7ydOnW40F6RG8x4TJt+Ac3KnvW
         SlZnfzV2K0q0zx6BmnnWF8pl1Gofmshs71ln6rY0IJthhjqXL6BxllPODRCzf4g8gWkI
         r2lgbBFVJSb0GaXIy2kt121ONj5+oo1yr8TeTnF2jII5pSjvSpc71N1CwUU7uAqSTO6e
         6MCcI8nwE1XOdzy7OyDhgCyG0KwPxfljEnCKFmSlyAq2iQn6KPuDeulQ31ogW/Kp9U+j
         X2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703309386; x=1703914186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rOcyFfxflN36gMhvNpR/DHK+BxldNKzckHr4V32hdY=;
        b=CwKPPNO6AixrMXTJYQESYauNPd3VuoeEWoPihXExTx+TgDykSvTz5Z8fZXTmvhSWbf
         K4+VJIR3P5/qUk6aGRmDdFpn4VMReKnGalvA8mLzlraxnqOTGR4bCTucDYWO/6splHRA
         1sOGj/xENOUEVSTmYlzeepuPTwpOTJMpVrZJ0+aY/NjohdEA1rnlXGTefE7hPS7mLv7U
         SUyzv6DpSxp5TUbvNALEfMOpyZxlirc7kgBc5j/IkPTVDnL/BsvkHb6matT16USKx7Z2
         IvOy8PSA70fAHkhn8TPIW+SucB77eiCkOB/kKqR6v+JQazdtWTFO8hI+AY/EFRMn5aXj
         xkQA==
X-Gm-Message-State: AOJu0YwfMCzScgn7oFkunmGoQ1JLmzhMO9jdzKYt6N98Ye/jn1qKrU9x
	mku0xoBtYvhuoFM7qR6BnRKyLAuR1nFsvYmXtFU=
X-Google-Smtp-Source: AGHT+IGcwfl+nZgyqOI3mjw5SJycNNKtCTspNzLxl1V2itEH0srYxfsVRjfqZNbeYjSLhf1B+i9CeGZg5QXIxjJvYLE=
X-Received: by 2002:a05:6102:2ed:b0:466:e5af:2384 with SMTP id
 j13-20020a05610202ed00b00466e5af2384mr1195497vsj.23.1703309386228; Fri, 22
 Dec 2023 21:29:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223051108.74711-1-kdipendra88@gmail.com> <d1c18155-9c8e-4164-a2bf-5eab3d42995d@infradead.org>
In-Reply-To: <d1c18155-9c8e-4164-a2bf-5eab3d42995d@infradead.org>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Sat, 23 Dec 2023 11:14:35 +0545
Message-ID: <CAEKBCKP+-6=JuRYtHU7YVstfZzzbTdvm9L4PBvOWAgKj2xaOrA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: media: atomisp: pci: Fix spelling mistake in ia_css_acc_types.h
To: Randy Dunlap <rdunlap@infradead.org>
Cc: hdegoede@redhat.com, mchehab@kernel.org, sakari.ailus@linux.intel.com, 
	gregkh@linuxfoundation.org, hpa@redhat.com, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi Randy,

On Sat, 23 Dec 2023 at 11:03, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi Dipendra,
>
> On 12/22/23 21:11, Dipendra Khadka wrote:
> > codespell reported spelling mistakes in
> > ia_css_acc_types.h as below:
> >
> > '''
> > ia_css_acc_types.h:87: cummulative ==> cumulative
> > ia_css_acc_types.h:411: descibes ==> describes
> > '''
> >
> > This patch fixes these spelling mistakes.
> >
> > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
>
> This patch is an improvement so it could be merged as is IMO.
> But...
>
> > ---
> > v2:
> >  - Previously only corrected spelling  mistake reported by checkpatch.pl.
> >  - All spelling mistakes reported by codespell are fixed.
> > v1: https://lore.kernel.org/lkml/20231222200350.2024-1-kdipendra88@gmail.com/
> >
> >  drivers/staging/media/atomisp/pci/ia_css_acc_types.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> > index d6e52b4971d6..1dc2085ecd61 100644
> > --- a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> > +++ b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> > @@ -84,7 +84,7 @@ struct ia_css_blob_info {
> >               memory_offsets;  /** offset wrt hdr in bytes */
> >       u32 prog_name_offset;  /** offset wrt hdr in bytes */
> >       u32 size;                       /** Size of blob */
> > -     u32 padding_size;       /** total cummulative of bytes added due to section alignment */
> > +     u32 padding_size;       /** total cumulative of bytes added due to section alignment */
>
> I apologize for not looking at your v1 patch carefully.
> The comment above would be much better as
>
>                                 /** total accumulation of bytes added due to section alignment */
>

So, would you like me to change "cummulative" to accumulation or
should I wait what other maintainer(s) would say?

Thanks.

> And if the maintainer(s) want to take it as is:
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thanks.
>
>
> >       u32 icache_source;      /** Position of icache in blob */
> >       u32 icache_size;        /** Size of icache section */
> >       u32 icache_padding;/** bytes added due to icache section alignment */
> > @@ -408,7 +408,7 @@ struct ia_css_acc_sp {
> >  };
> >
> >  /* Acceleration firmware descriptor.
> > -  * This descriptor descibes either SP code (stand-alone), or
> > +  * This descriptor describes either SP code (stand-alone), or
> >    * ISP code (a separate pipeline stage).
> >    */
> >  struct ia_css_acc_fw_hdr {
>
> --
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html

