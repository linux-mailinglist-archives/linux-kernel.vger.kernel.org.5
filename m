Return-Path: <linux-kernel+bounces-10058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614A381CF42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26270286EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2AD2E85E;
	Fri, 22 Dec 2023 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI+maqvS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C92E84B;
	Fri, 22 Dec 2023 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6db963bd3acso1486951a34.0;
        Fri, 22 Dec 2023 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703276964; x=1703881764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma5xrM90AVaZ9gvSq4/3m7j8Wtpi322oe0vwjTHYLoY=;
        b=UI+maqvSaF6VosYXwYoaer3OU6IEpjj8Lu0lGw47tOXJaSXV+DGHkeaDGWnsx8qVen
         7xfx+g4iAweZVxqJJjPPZo2qC6lQggPqvppa1N4kpYOjtX64BWqAAUa3FQm9wkRa+A9i
         ooiOtNhrcrAE03aThmiNHP24+7DKd8o/cJJAXM+4hrzP/DBQdRxShMbJPgFTr2uITEuo
         AWdwmS1qGUx6W5nx7Gvymz14fkNkwsuItQzYjMPlUGh1wuYpv3bFIm5MjTyhBToDvz+1
         3JBLv/7LTMCbyTSTh9NJE0WyVWYukHpMZDQ0OAFEU3xIpPgShv4Jw6B2EN3SNyIs+n3f
         uw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703276964; x=1703881764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ma5xrM90AVaZ9gvSq4/3m7j8Wtpi322oe0vwjTHYLoY=;
        b=tcaIw2RMz6WsZFNZeKciO7THw/z8BzeSpg8JSxCND9v8xWjCPjm+0SkvJM9aHohVM+
         Z5314gZjNPvrvPx+YryKsqTBBG24dYr6GnJIBroFpgmIth+K0NT9bOGPYDPv8RPwWcS4
         GxbSEdHPZgfDsp2dxPL38Hgvtnej5RLGksVltUA8aygsNjx8HnH5p/ckLcBnPLSn2R5d
         5GRo84l3GcaGtGkpHrBOgc2GQaUUvUctvineN+/UGn9sUt2H3d044q1Bw5D5a2aAvpfY
         UVOxBs/3JzI5KPAvQqCiM1LA8nj/8hRMakH+HFWWI9QHWPWhuWbBXHSmbywkQltg/ebl
         7Mkw==
X-Gm-Message-State: AOJu0YxTkRwM1f6XAdFcqX/I4deZGAbkg/Id4Q6bMaqE6MMSlBm020VN
	pT1ioMz791mcSl1pAeUg/M09/PEuk1153IyBWLE=
X-Google-Smtp-Source: AGHT+IEsIZ+rGop40x8sg+JUQu1HomFUt1JRxpCMluno/bDXoAig9/vIAsdBJPvCyV2nKOBjRgUQBqNs44KX21GqnQg=
X-Received: by 2002:a05:6830:1190:b0:6db:c20f:9070 with SMTP id
 u16-20020a056830119000b006dbc20f9070mr1415779otq.31.1703276964657; Fri, 22
 Dec 2023 12:29:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222200350.2024-1-kdipendra88@gmail.com> <b4ad9a64-53cf-449a-aa18-d19ff3c72c52@infradead.org>
In-Reply-To: <b4ad9a64-53cf-449a-aa18-d19ff3c72c52@infradead.org>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Sat, 23 Dec 2023 02:14:13 +0545
Message-ID: <CAEKBCKO4uGKxXPZHO9iqYZ_8ibgY3HS3C8Rsogcv1XU+qGkudA@mail.gmail.com>
Subject: Re: [PATCH] staging: media: atomisp: pci: Fix spelling mistake in ia_css_acc_types.h
To: Randy Dunlap <rdunlap@infradead.org>
Cc: hdegoede@redhat.com, mchehab@kernel.org, sakari.ailus@linux.intel.com, 
	gregkh@linuxfoundation.org, hpa@redhat.com, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Dec 2023 at 01:57, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 12/22/23 12:03, Dipendra Khadka wrote:
> > The script checkpatch.pl reported a spelling error
> > in ia_css_acc_types.h as below:
> >
> > '''
> > WARNING: 'cummulative' may be misspelled - perhaps 'cumulative'?
> >         u32 padding_size;       /** total cummulative of bytes added due to section alignment */
> >                                           ^^^^^^^^^^^
> > '''
> >
> > This patch corrects a spelling error,
> > changing "cummulative" to "cumulative".
> >
>
> 'codespell' reports this one as well:
>
> drivers/staging/media/atomisp/pci/ia_css_acc_types.h:411: descibes ==> describes
>
> Thanks.
>

Thanks for the reply. Do you want the spelling mistakes reported by
codespell in the same patch with this change as well or you will
consider
it in the next patch?

> > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > ---
> >  drivers/staging/media/atomisp/pci/ia_css_acc_types.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> > index d6e52b4971d6..ac6fb0eb990a 100644
> > --- a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> > +++ b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> > @@ -84,7 +84,7 @@ struct ia_css_blob_info {
> >               memory_offsets;  /** offset wrt hdr in bytes */
> >       u32 prog_name_offset;  /** offset wrt hdr in bytes */
> >       u32 size;                       /** Size of blob */
> > -     u32 padding_size;       /** total cummulative of bytes added due to section alignment */
> > +     u32 padding_size;       /** total cumulative of bytes added due to section alignment */
> >       u32 icache_source;      /** Position of icache in blob */
> >       u32 icache_size;        /** Size of icache section */
> >       u32 icache_padding;/** bytes added due to icache section alignment */
>
> --
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html

