Return-Path: <linux-kernel+bounces-165942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719708B93A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04671F22670
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B1F19470;
	Thu,  2 May 2024 03:41:01 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC678171AD
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 03:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714621261; cv=none; b=hODr+R6G7jOoXr6uTCeED43M6n8nPDt94ZyOJNy/ybiHZWNAIxRl07EHBujZMu/4jQWP+7QZbMvLvLDYewLnydYVutZBtiuynZxhfxntecj6FqZIaEXoHQmVbyCvW/JAq44SS6RCJ7P46W3SgJngryWFxWCPEt6dgPfKKpHgavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714621261; c=relaxed/simple;
	bh=XRqNXEpahaUKXI6jw1HamILuyXH8geeeaQFQyQE+IP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgDfzy9hP9gmMvs9HJ5x4Dhj3Lzf8TbGR2lELZbtwQW8yfqXOiXidAyapfQLUdOoH+PKRr3jsaj2cTkmVVJy3pl0zknYVTksy1cBNCwkNmretnTIe5rhzGufwqPOOKhVfWM73fFi9gD3Twjb2hW/iQIiNBfVl1B1MbnKVXhokLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2db13ca0363so119686771fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 20:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714621258; x=1715226058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjbdI7aA0VFa2ZjYKTzan8ccV6sWkCqg04GHpcz08yA=;
        b=bP/TZzUEgiKHeWu7bL/vP9WlpkK6eJc33LA3KSp7HawS5KciCy7theCJSmqa2bEurs
         tb84UfrjyMJOU3e0TOZRlBtZn+41EB6WYPcPVyV5Qpl8DemzIN8uJdEP7Ps3O7jCtGe9
         aftxmqsiXwAGGp6g0w8z8c8Wt6ANdV0DcavN2a04y1rHdWukqC8xqY4MLvGTw16M2WPO
         Sqxb67+LWmTYLin8p6UZ3wFeGMYfRUFBsRRK55az9X7LTU7mLpY6CySq89Oh3nsZqSBq
         qZL9ooT6ka0zNQIecu9x6AXiSDIvcw8fFqVhc2FEUT+WkqQ3iOfglC7ME4Nqj5+uzoW6
         U8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV7ZQWKmSBTqwWDwmMhFhIqbbaDOmhiL7i8M6pAdhy2UDiDDPtUu8ufyrkwt7KXWUXU1yS4jFfILJc2zqbomqlr0/kyXGldYE2VDO22
X-Gm-Message-State: AOJu0YzkeO9Mv7G5sGNLclM8mJMVJXsTw2Gh/+CdSspy9G9UFrkPmasO
	Y2sBIouRgtsvX1hXWP9pBLDTmkZDp9F4jJN6eFlolPA1IiDoXUJLZg8p8ipI
X-Google-Smtp-Source: AGHT+IGG/1M4BJnC5vTYFz59VTL0tINRlCqGdmZDnOz6KG4TpC8nNVTr6FRN2lnVNsEibavg5wz1tg==
X-Received: by 2002:a2e:9050:0:b0:2e0:5d7:a3a6 with SMTP id n16-20020a2e9050000000b002e005d7a3a6mr3428085ljg.9.1714621255501;
        Wed, 01 May 2024 20:40:55 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906595500b00a55662919c1sm21971ejr.172.2024.05.01.20.40.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 20:40:55 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57230faeb81so4513108a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 20:40:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKDH8Ts8BVR/zARqWBu1fHHP2ST14vitY3r+Z8GJIe43man48o975pyQoVCSKbMp8UODeySghq1fKt6AaBehUgG+IBUdncdW9HUDZc
X-Received: by 2002:a50:d6da:0:b0:56c:d35:1775 with SMTP id
 l26-20020a50d6da000000b0056c0d351775mr3426349edj.35.1714621255210; Wed, 01
 May 2024 20:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713974291.git.thomas.lendacky@amd.com> <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
 <CAC41dw-g2=jKkevGOJUqnzYTpxQ8+Z_JxnNNuoLR+CM_yqfRzA@mail.gmail.com> <6632a2e0738d_1384629442@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <6632a2e0738d_1384629442@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Wed, 1 May 2024 20:40:43 -0700
X-Gmail-Original-Message-ID: <CAC41dw_Dnm=suyue+jFx2z8f+YT1K_aWfQEijrU=WH4OLWpOqQ@mail.gmail.com>
Message-ID: <CAC41dw_Dnm=suyue+jFx2z8f+YT1K_aWfQEijrU=WH4OLWpOqQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] x86/sev: Take advantage of configfs visibility
 support in TSM
To: Dan Williams <dan.j.williams@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 1:15=E2=80=AFPM Dan Williams <dan.j.williams@intel.c=
om> wrote:
>
> Kuppuswamy Sathyanarayanan wrote:
> > On Wed, Apr 24, 2024 at 9:00=E2=80=AFAM Tom Lendacky <thomas.lendacky@a=
md.com> wrote:
> > >
> > > The TSM attestation report support provides multiple configfs attribu=
te
> > > types (both for standard and binary attributes) to allow for addition=
al
> > > attributes to be displayed for SNP as compared to TDX. With the abili=
ty
> > > to hide attributes via configfs, consoldate the multiple attribute gr=
oups
> > > into a single standard attribute group and a single binary attribute
> > > group. Modify the TDX support to hide the attributes that were previo=
usly
> > > "hidden" as a result of registering the selective attribute groups.
> > >
> > > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> [..]
> > > + */
> > > +enum tsm_attr_index {
> > > +       TSM_REPORT_GENERATION,
> >
> > Do we need an index for the generation attribute ? Since it is a core
> > function, we can allow it by default.
>
> That is up to the is_visible() callback to decide the declaration of
> which index corresponds to which attribute is just static information.
>
> >
> > > +       TSM_REPORT_PROVIDER,
> >
> > Same as above.
>
> These numbers need to match the array indices of tsm_report_attrs.
>
> Your suggestion makes the declaration of tsm_report_attrs more
> difficult:
>
>  static struct configfs_attribute *tsm_report_attrs[] =3D {
>     [TSM_REPORT_GENERATION] =3D &tsm_report_attr_generation,
>     [TSM_REPORT_PROVIDER] =3D &tsm_report_attr_provider,
>     [TSM_REPORT_PRIVLEVEL] =3D &tsm_report_attr_privlevel,
>     [TSM_REPORT_PRIVLEVEL_FLOOR] =3D &tsm_report_attr_privlevel_floor,
>     NULL,
>  };
>
> ...because then the definition of TSM_REPORT_PRIVLEVEL would need to
> know how many attributes precede it in the array. So, defining it this
> way makes it more robust against future changes that want to
> add/delete/reorder attributes in the array.

Got it. Makes sense. It is simpler to do it this way. I am just
worried that the vendor driver might mistakenly disable some core
attributes like inblob, outblob, provider and generation.

