Return-Path: <linux-kernel+bounces-139183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A289FFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D99C1C23372
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC471802B8;
	Wed, 10 Apr 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIxEOQb6"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4641E17B4E6;
	Wed, 10 Apr 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773197; cv=none; b=GD9eNvCrDrzisIIf+ReOXN01go9KXOnspWUa0hHzmnSp8V5T1HQlMwgDyvmkQVVAoPCFX3fDnEGWW6qcIWvo2ZzkLdXEhmDTF0IYWEIwLBmWh4IfY2libYUstLS9csTRRjiUsbJE7Q88f4vXEfe3fwecumU14O1ZLgCeJ8wMYfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773197; c=relaxed/simple;
	bh=4LaxoFkmQwPe5fwPIktwCrCnuxyfeMUCXbjHbB/+wSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u31HZG6EMRm/7EKv126xO7kSjjQuxzLcvbMDfIN5G56IwyCzgiCg2p5fF+eeJcbaBexaHniBU23GQgqIh5E3RZRqYp+Ou+8Q57CavmyekxshkK+8EVpyat9lx62Ra6TCVGQtnUWcLDck62Z0yGBUAUd0L7fhOB2Y01NPCvk8GNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIxEOQb6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343d6b55c42so5061052f8f.2;
        Wed, 10 Apr 2024 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712773194; x=1713377994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LaxoFkmQwPe5fwPIktwCrCnuxyfeMUCXbjHbB/+wSk=;
        b=kIxEOQb6GufgMVXGt2EjYV6kqbRGHa1SLS9aProgsVi0Ita0XRBRLDIzWjjZQJv5y4
         telbaIylnoAebasm4yPFa6MFyQnlqWK5c7fCogulNeWy7fwzbWPnzWpVHHlFjnEROdbl
         FaTUPn+qn2UKYugPLtz3Hd+eOtl6INNO/AiGA6KSz5MzuyaZTcMgTRjasovZFvDq7d1s
         vIPgbgrOCGobBuJ+rL/NtlXKJy6N5s2UdkpbCLBnsZ52iILUYj9gTDs/7Oyixfu9bCJL
         Zqs9Xvl2D3TQEeeUjLMBClct/eMom0NwbCpeH5OIEWFdwV+ctkJgKYSwfhv9QFshqkNP
         L+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712773194; x=1713377994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LaxoFkmQwPe5fwPIktwCrCnuxyfeMUCXbjHbB/+wSk=;
        b=QnRBewXB5YD3G5jYNWOwN6DSjvxiExyhaEDx79CcaMN9MaZMS3RjpxHo+9nz12iiVE
         S5RKfSwg+4NO+kVAQWFw4hZAuXZ60nQXhn38wU3/XhN+Q9Ca0cpZmgb8F/zYvZzgzhi8
         v8FEZtNraTmp/F2+SmMotUTBOBkfCSf3LDGoZtOpm2bpTY1Pyp0U8SFnOJX1d2O3KWGx
         oCRsJWJNrIvNvpvpwamkhkXp09En31tDImoPk5yG0A89ZERVXuQ6bJuKIKLLhDyjjG3J
         4ViotXqi+dhZLs2Q4tTKE2UIsCkopklzyquElu+x0kM5AOHqzL8ObBqCzAUq1myq0i1k
         ua+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIUEZYvounv7ozfzPpMd2gd9BSfe4npZktTBbnEMiVVgSNx10aUGlI+nGHGSHLBW/GFOEtAkQCNLb8PIbWv3ku+WBMbBxKu/SVWMwfR4w3/LPNACqW1C5+55bfIcV6U4Nk5PLydvsDPrYb9EB8yz+GB/kjBePBm0DxtRnBOLAB
X-Gm-Message-State: AOJu0YxHT2RJJ73d4tASRy+XYjtoo7et3GjCjy6wwsCk2xxzlxTr9SiK
	WWM7PWRlv46pz6K1Fr+5BNo4UWZUNUE5ZWrIpebyC3H05x8auM3Cjckg4BjRuy3nQ8cPjmAevR6
	cTlCAuTYHyWVKgpXNLCaIm0ANR90=
X-Google-Smtp-Source: AGHT+IE7CylsTqdzSF2Bzjl85NlbYY5eOLUFjOWjSVdCeNlEle2uCuzBN0OwDrWEG4LT5ER3gmDyq8Y4yOzn5uaO/Rs=
X-Received: by 2002:a5d:53ce:0:b0:343:7032:7283 with SMTP id
 a14-20020a5d53ce000000b0034370327283mr3224766wrw.8.1712773194553; Wed, 10 Apr
 2024 11:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-13-linyunsheng@huawei.com> <b5c5866e626f6c90657a32b5e9adff724d5896db.camel@gmail.com>
 <c1f5a78a-3040-0cc7-f113-d5ec82c6010f@huawei.com> <CAKgT0UfZBGEVJa1O7cdNt6zy_EEPoGo=aW6ugRKy8a44qg0j8w@mail.gmail.com>
 <09d7d59b-9da3-52f7-b039-acd0344c88c8@huawei.com> <20240409062504.26cfcdde@kernel.org>
 <CAKgT0UfqDRxhUyfQhwsDrRhQmCw4qNw_7Jwq+xN1Z4f6_1Bthg@mail.gmail.com> <6517b5ae-e302-4cbe-8a4c-716e604822ce@redhat.com>
In-Reply-To: <6517b5ae-e302-4cbe-8a4c-716e604822ce@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Apr 2024 11:19:17 -0700
Message-ID: <CAKgT0UcAw8tENoS7r2YYV2vQ562PPUcgQwfJXhzi8aS+ujZEYA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 12/12] mm: page_frag: update documentation and
 maintainer for page_frag
To: David Hildenbrand <david@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 9:06=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 09.04.24 17:11, Alexander Duyck wrote:
> > On Tue, Apr 9, 2024 at 6:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >>
> >> On Tue, 9 Apr 2024 15:59:58 +0800 Yunsheng Lin wrote:
> >>>> Just to be clear this isn't an Ack, but if you are going to list
> >>>> maintainers for this my name should be on the list so this is the
> >>>> preferred format. There are still some things to be cleaned up in th=
is
> >>>> patch.
> >>>
> >>> Sure, I was talking about "Alexander seems to be the orginal author f=
or
> >>> page_frag, we can add him to the MAINTAINERS later if we have an ack =
from
> >>> him." in the commit log.
> >>
> >> Do we have to have a MAINTAINERS entry for every 1000 lines of code?
> >> It really feels forced :/
> >
> > I don't disagree. However, if nothing else I think it gets used as a
> > part of get_maintainers.pl that tells you who to email about changes
> > doesn't it? It might make sense in my case since I am still
> > maintaining it using my gmail account, but I think the commits for
> > that were mostly from my Intel account weren't they? So if nothing
> > else it might be a way to provide a trail of breadcrumbs on how to
> > find a maintainer who changed employers..
>
> Would a .mailmap entry also help for your case, such that the mail
> address might get mapped to the new one? (note, I never edited .mailmap
> myself)

Not sure. My concern is that it might undo the existing tracking for
contributions by employer as I know they use the emails for the most
basic setup for that. I suppose that is one downside of being a job
hopper.. :-P

I'd rather not make more work for someone like Jon Corbet or Jakub who
I know maintain statistics based on the emails used and such.

