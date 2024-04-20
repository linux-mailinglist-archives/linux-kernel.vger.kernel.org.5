Return-Path: <linux-kernel+bounces-152140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6983B8AB9C5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125951F21710
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD001E57F;
	Sat, 20 Apr 2024 04:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3vLrHXh"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286CD518
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 04:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713589162; cv=none; b=O/z/fmH/9gZOlNucyQMyolg30dR2/Hwub9MYL1D/APPIXRSjtd/HO1tBM8KzDwOHYcTWPN9BbHK41n1XGQuKdmTdpw9Tn83Es1IXM/lhKnTsWnw2vmrNLC0thPzWe8KpXzxsFZXva8lVDpX9F+QnytAKGKs2fbzO0BjOWfkjI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713589162; c=relaxed/simple;
	bh=m5aCjfDYAspWHPoa2c50RyGOgoc3AT1QDTrWoAFGudM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSggo1MRoYIe6syapChsBJNztRR2mFrr+b6f+E1yCndgXMkjKrsrgdzV11ogQZOrEua7BdO5f2eftSardZa3CsTVE4wRcGux7+QOhU03lqJ16KN4ERvgYW2BfKwjcN6BLn+hInRSR7hBytLPccmxvpat9ExQLHTut8gjP4vWbvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3vLrHXh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571bddddbc2so2257434a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713589158; x=1714193958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/1dchsiKHqQnftO3k9Fm2LPLU40YwOV21SPiuYZLbA=;
        b=S3vLrHXhYf4TJ4AMQbAKdYa/cGTd3tlz+SdrZT+R4aWpySN9W/13r99el2x+Ci7wEK
         9NH21PkDnESZkCGXrHfPoCi/b6K/uyjPyMbFf1+7F0aowwN1wi2FlTeduoISORpT0YKj
         TmV0uNO33Cv5/Y+yB3RUCJSRPJPZSTEZssUXtRc/CKexO3rfBgq5o7YasBpEGL8DBebD
         sdXiKxLnzsosZjXI8/P7f2r7/ogO+Lc8BA+u4Z2MO9+2ueB/knUQ7mVGfjuDdASkzD4H
         YFQE12PIn06nrLDJZ+bioDReDgHqYwcwCgOvVZpzzv4S0rlkh5iEJFZYtuIE4niUrGmM
         osfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713589158; x=1714193958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/1dchsiKHqQnftO3k9Fm2LPLU40YwOV21SPiuYZLbA=;
        b=EvmNEP+ikmGgPTTpCR75sNBDpxh1KpnapTxKMNu3z70wDdsAejAvrAaz9iesOoAv51
         QFeOlczyK0zoPHUBOndPDHJTsv7GRrHOq3CtzTJwjMnIQguIWSuvo6zvc5eXu2PD8Ed5
         ezaiPLIkqv9xDC1iOoDsPeGMpo+QsOzArdOgOexc8amG2XblA/PYC1mIx6uPP/A0U1Oc
         KCUbJbGDhhDgB9GyjphD/iTdE9jeyrOKL+R4hn8cMGCV5TikptmVGy+4WdW/8Lh+uj4O
         tSjI48fh139755EvYbWBdmpUHLPZYGEgsYr1TZITbTU1IJDqlgNgdDZ+CMgcWSqof/wD
         niCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFXM0wUXQ4hqrf6R9rD4n97SNb6VTZk7p8vIpDC+tAcVpix4a+IS/k6sWbfls+0jQnbFcp7W2UmLqV7oNxIG6RftXwLPZPGu0YNYQy
X-Gm-Message-State: AOJu0YwPZVITZSxRVTtQsrkeHqLTwlM/BxkZhmQRdGzwMhAxcuxsuHxP
	XIu2FffI+XGE+kSs3fa2Oe8eLfpnm89RIbAXOliiv+ZRVGAiYgB6VejmOtgHu95MlYllYqZWfev
	jC/Yedz2VwtseXYjESo12/UJx2/E=
X-Google-Smtp-Source: AGHT+IGLkDbsI//dCTQQt5xhkGJlKQ0ZNmyIyQaEarWAoM/l2VzchI4N48Ogohi0S2JVG/u4X4QB+/2xGA2IRFxt/o8=
X-Received: by 2002:a50:a447:0:b0:568:a30c:2db5 with SMTP id
 v7-20020a50a447000000b00568a30c2db5mr1949648edb.40.1713589158444; Fri, 19 Apr
 2024 21:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417141111.77855-1-ioworker0@gmail.com> <Zh_mBxJmYe6eCA29@casper.infradead.org>
In-Reply-To: <Zh_mBxJmYe6eCA29@casper.infradead.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 20 Apr 2024 12:59:07 +0800
Message-ID: <CAK1f24=Mrk7TFnDd=ouCrHaDH9K3VGCUAJbLH9cbn0pGncP+Hw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/vmscan: avoid split PMD-mapped THP during shrink_folio_list()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Matthew,

Thanks for taking time to review!

On Wed, Apr 17, 2024 at 11:09=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, Apr 17, 2024 at 10:11:11PM +0800, Lance Yang wrote:
> > When the user no longer requires the pages, they would use madvise(madv=
_free)
> > to mark the pages as lazy free. IMO, they would not typically rewrite t=
o the
> > given range.
> >
> > At present, a PMD-mapped THP marked as lazyfree during shrink_folio_lis=
t()
> > is unconditionally split, which may be unnecessary. If the THP is exclu=
sively
> > mapped and clean, and the PMD associated with it is also clean, then we=
 can
> > attempt to remove the PMD mapping from it. This change will improve the
> > efficiency of memory reclamation in this case.
> >
> > On an Intel i5 CPU, reclaiming 1GiB of PMD-mapped THPs using
> > mem_cgroup_force_empty() results in the following runtimes in seconds
> > (shorter is better):
> >
> > --------------------------------------------
> > |     Old       |      New       |  Change  |
> > --------------------------------------------
> > |   0.683426    |    0.049197    |  -92.80% |
> > --------------------------------------------
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  include/linux/huge_mm.h |  1 +
> >  include/linux/rmap.h    |  1 +
> >  mm/huge_memory.c        |  2 +-
> >  mm/rmap.c               | 81 +++++++++++++++++++++++++++++++++++++++++
> >  mm/vmscan.c             |  7 ++++
> >  5 files changed, 91 insertions(+), 1 deletion(-)
>
> I'm confused why we need all this extra code.  If we remove a folio

Thanks for pointing that out!

I've added a lot of extra code to rmap.c, and we don't need it
for file pages - sorry. I'll reconsider where to place this code.

> from the pagecache, we can just call truncate_inode_folio() and
> unmap_mapping_folio() takes care of all the necessary unmappings.
> Why can't you call unmap_mapping_folio() here?

Thanks for your suggestion.

But this change only avoids the splitting of *anon* large folios
(PMD-mapped THPs) that are marked as lazyfree during
shrink_folio_list().

IIUC, in some cases, we cannot unmap the THP marked as lazyfree
here, such as when it's not exclusively mapped, dirty, pinned, etc.
In such situations, we still need to return to try_to_unmap_one(), and
then call split_huge_pmd_address() to split it.

Thanks again for the review.
Lance

