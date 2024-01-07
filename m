Return-Path: <linux-kernel+bounces-18991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E162B826621
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2A11F21580
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709271173A;
	Sun,  7 Jan 2024 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBzuJ8Ug"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DDD11712
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7b913830d8eso75018039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 13:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704662962; x=1705267762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+A9E7kevV/RA3nngibl71YMsf/zK8ry/8PO6emuYBQ=;
        b=eBzuJ8UgOZgqgSIK1unRUGuQHXMiTLjW45ECAEHDUAfX+rPDh62Abk2d7leMJUuRBY
         /cxDI9D3/E9ajNc18+RWdSqQnAbQUSvH01YUH1FxnL4/o/iqPCFAQa+5/y4AgdLUE1iR
         Z0BIYlGQYnt7j197EQTRItOzHotUz8726E6wrqJP3at/HvFw5rLx9T78d8vfm9d+vBN4
         vCykAxs26k4LGHD8I2d2L8D+eleUsUeNQrZHNu56PKmNSP55d0f/sNrSOCdGZ/W9I03i
         WLslkql5SZyMkiCs5nXBtFb1GVNiLdcp956tZlr3NJtupR78AL2ibq+QUtue/b8C7TLj
         owng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704662962; x=1705267762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+A9E7kevV/RA3nngibl71YMsf/zK8ry/8PO6emuYBQ=;
        b=hRvwVCb2BMLU7RKnhFSnx7HfNJgKeGXOk/zYjrmh2OZQgyx+GgMmOupzFG6ktAmdtb
         yblIABTm5l3EaHcNU2PraOvtgAg2tNdN+MNZnFdCDCy8HW/jds2BYTsytnYlu9mKADgx
         34G7zy6xcmTOxoPb+RqUKxz860OWwqVqJa/Hecj20WV6n8gz2kyjoqzDHIRsergwnc/T
         ICtw57T9Ora1P1WifayCyNO1JB6Uth95Pe5rI7hAlkn2evNCNkyZsJW9JQ4KzGhuTfOW
         KHnulHfvrfpCC1dvB3r8YlQLEEFmeD90SrbUMYseKwqtqJYIFHu2216+pCE1XY6LZfsV
         ez1w==
X-Gm-Message-State: AOJu0YyHi//wpw3fm+QMwRtzLPmn/g3eZvGavShM7xx4V/OFqshdDTmg
	XtO0075RUbUhzuGhLA63p4p3lfsKpQHmlrO8fYU=
X-Google-Smtp-Source: AGHT+IG5qDMpUKh4eFvjrtkXIIIvLbkauOykKNFxNFJAPWhbBgDPUuBPa2vo9QUlGerGEOkPE8DsMjU7YnV+HdX+N/4=
X-Received: by 2002:a6b:ef09:0:b0:7ba:9a74:731a with SMTP id
 k9-20020a6bef09000000b007ba9a74731amr3555049ioh.8.1704662962484; Sun, 07 Jan
 2024 13:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
 <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
 <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
 <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
 <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com> <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
In-Reply-To: <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 7 Jan 2024 13:29:11 -0800
Message-ID: <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, weijie.yang@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 6:10=E2=80=AFAM Zhongkun He <hezhongkun.hzk@bytedanc=
e.com> wrote:
>
> > > There is another option here, which is not to move the page to the
> > > tail of the inactive
> > > list after end_writeback and delete the following code in
> > > zswap_writeback_entry(),
> > > which did not work properly. But the pages will not be released first=
.
> > >
> > > /* move it to the tail of the inactive list after end_writeback */
> > > SetPageReclaim(page);


Ok, so I took a look at the patch that originally introduced this
piece of logic:

https://github.com/torvalds/linux/commit/b349acc76b7f65400b85abd09a5379ddd6=
fa5a97

Looks like it's not for the sake of correctness, but only as a
best-effort optimization (reducing page scanning). If it doesn't bring
any benefit (i.e due to the newly allocated page still on the cpu
batch), then we can consider removing it. After all, if you're right
and it's not really doing anything here - why bother. Perhaps we can
replace this with some other mechanism to avoid it being scanned for
reclaim.

I would cc Weijie as well, as he is the original author of this.

