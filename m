Return-Path: <linux-kernel+bounces-2079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA826815797
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE981C21458
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974CB12B8B;
	Sat, 16 Dec 2023 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmnLoZbo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A312B68
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso3509a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 20:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702702653; x=1703307453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5r42U06zmunbWwBQuRS+1tlAJPPjNMyHaDfp+o76tE=;
        b=NmnLoZbohHQCCB2YWwb67Yb4oWNk7vUQ5MffOQE02gmUmPhC8tf9WWj7jqkWgweRbn
         gjtqI/t9RPrauUg+JipHQ6uXBeg7T22JHLZThDwS+nmZGiEV2m//OFsajuEL9Fav8T3Y
         QgGm6eekNK6W+LPpVZhNL70CWOm/u6FuJ8wYfGS9N2lEE3cDPSgw+vuGWwHumUNBWowW
         7AmdstHG7PtYtFRETHunjOE7iIb+wyX/z8UZDE0dlh85ajtkVjnnJd83ubHPamSIJoiR
         qpU2mAJEGJSfLAJlA6w9r2prKiHeoRdbkH/De8H+uwNjEPW36qjdyTIL12hxllVtzUE3
         HNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702702653; x=1703307453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5r42U06zmunbWwBQuRS+1tlAJPPjNMyHaDfp+o76tE=;
        b=rmN8WKlbcKhTje2NOtwj6Jyksv62e9BDQrivmKU6cxtzFq9Q/ElAGRmms0u/SAVphI
         Fm2ymQl1EgcWOy0Q+J14N/qlyExVWq36iX1GyLP+2TyVA7gPNasWGpMOodyVaYs/IX5j
         1VAkwZqUO79mLrqqVgyN/krmKN2QmKwKOhb2iFWVHvGYVldQ1mxMJHeSHxlOCgZ1j9VI
         qvuGn5jKUoQNagCrXNRJPlrznnfo5R8q8RLgddZwpcBu6syqUci9AT5eRRMQ2JGFgD/t
         nWSGA97Qst9iLotosIdJ2eQm/GCowbcE1pcxCmx5PgoAObtWcLEwv2fJRPKkV78B335j
         7kRA==
X-Gm-Message-State: AOJu0YxE48OMisqELnu701dz+4Au2jTOsVXzEmMN4AVrXAYhaHbjM9q6
	gALzVainKsog7pO8dRY/gA5i1IGlKdZhzGojpnecQ6RXMix/
X-Google-Smtp-Source: AGHT+IGDQoqZr+tLvBUv37AVP1fUI7zVcpLX+LHrxlY6DcLl8N+7C1M0uLgBDd7QLevCsjlz75FP01b7eN9KBYMz3Yc=
X-Received: by 2002:a50:cdc6:0:b0:551:9870:472 with SMTP id
 h6-20020a50cdc6000000b0055198700472mr72839edj.1.1702702653461; Fri, 15 Dec
 2023 20:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215071604.946a433bbc05a6409faf5a33@linux-foundation.org>
 <CAHk-=wjWJgWzOf9MCuiE0oDsF6cCCn7KKDc_xDN6Q3kWNEHKLQ@mail.gmail.com> <20231215122251.bad09400b337dfb1965f6976@linux-foundation.org>
In-Reply-To: <20231215122251.bad09400b337dfb1965f6976@linux-foundation.org>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 15 Dec 2023 21:56:54 -0700
Message-ID: <CAOUHufbcB9Lxeez=NcUY4uzxyX6x71dy2N0SMgj=ALooq+MetQ@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.7-rc6
To: Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jesse Barnes <jsbarnes@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Guru Anbalagane <gurua@google.com>, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 1:22=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 15 Dec 2023 12:11:42 -0800 Linus Torvalds <torvalds@linux-foundat=
ion.org> wrote:
>
> > On Fri, 15 Dec 2023 at 07:16, Andrew Morton <akpm@linux-foundation.org>=
 wrote:
> > >
> > > Yu Zhao (4):
> > >       mm/mglru: fix underprotected page cache
> > >       mm/mglru: try to stop at high watermarks
> > >       mm/mglru: respect min_ttl_ms with memcgs
> > >       mm/mglru: reclaim offlined memcgs harder
> >
> > Entirely unrelated to this pull request (which I already pulled and
> > pushed out, as noted by pr-tracker-bot), since I looked at these it
> > just reminded me about a question I've had for a while...
> >
> > Do we have any long-term (or even short-term?) plans to just make
> > mglru be the one and only model?
>
> I hope so, but I haven't heard specific plans.

I don't know when we'll get there, if we can get there at all. But we
have been steadily moving toward that goal:
1. We worked with all major distros that follow the mainline closely
to switch to MGLRU this summer (Arch, Debian, Fedora, Gentoo and
Ubuntu).
2. We hired more kernel developers after we demonstrated the ability
to substantially lower hardware cost by overcommitting memory at
scale.

There has been a short-term plan, i.e., moving some of folio->flags to
the lower bits of folio->lru so that we can drop the Kconfig
constraint. I have discussed this with Willy but never acted on it. My
priority has been to surface more of our ideas that can potentially
save users money on memory to the community. I'm CC'ing our team
leads. Please feel free to let us know your preference on the
priority. Thanks.

