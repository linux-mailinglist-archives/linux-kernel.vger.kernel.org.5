Return-Path: <linux-kernel+bounces-148787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D58A876A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8431F23391
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257861474DB;
	Wed, 17 Apr 2024 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD9/fE6s"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF81422B6;
	Wed, 17 Apr 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367315; cv=none; b=rDSjacCj/O1ZSsKXikKIaZonfK2Tvw1PhRChcGc5fn8vA8ZrgbRiEw6SKZwU+UX1fDOXHtIoJfaXjz88u4yXLslYZjXD4gQhoy/ajYTguSQ8lYD+QijBXUkIpfL2cTeJp39C29I7dkfF93j0TZGVqHWK0GN3hVEToOPvYy1b2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367315; c=relaxed/simple;
	bh=eaGY130EEfNXK73Gt7yZNiqyMJf/fKU75Cs6qodOdYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oY9r+siyoUP4GX2TDo24lolzCeE+wFsU+UJqKXj/VxIXVjtsXTWI3ueyQok0Kib3c4sXfc/hQb2cVcuXx5h5cpJWZxJTWE6wvhcoqUkM7EUrK6FT9LHrpm1WFZowMA1IhkaPCRiAWXjq4txzg6o1Hf1e0WPQYdWTlI0VDnsVRM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD9/fE6s; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e51398cc4eso53103975ad.2;
        Wed, 17 Apr 2024 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713367313; x=1713972113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UHqy/YNAwuIo5hSIvZMWYfCNqZ6Gl94Xq9snb/hWpDM=;
        b=QD9/fE6sP5J+G9qgZ5cyd4tWtiAESl6R9XLjO6yyCqvmJ9jTyo91Qi34QUE3X0I7EH
         DBCgOu4hfNsY2umLtXlXVTUQwbVbMbBlFiSRFPVMRAsUs3UND//f3KrDjBm+bQWPFGEE
         yBv21jo0yfo4XRP4K6rTnZB5HRjAYBk3DDCQgjdOmcEO2NLU8X6NINleyT4/3NGvLi81
         xvqA2XfTYDCQIySqijC6haJNNc5JBSqwKSaZG/8mMwgq92jGk2r5V6h7RXMc85ttjmUe
         qOwoYZtWowQEYjRUgKRMcMfkpHEUNuj931Wn9h2T5ARDVLZ4A4Fsu5tthpqqdulPvmwd
         ppHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713367313; x=1713972113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHqy/YNAwuIo5hSIvZMWYfCNqZ6Gl94Xq9snb/hWpDM=;
        b=rV6PMdUhJw4rRmNvWtYDU1ilE95mFe+KAVOCut0s0HQIowDFp9NBgyDPDwSsmvTcDi
         3jVB42tWXDLxiwbkKDNnVGlV9+QkZdw9Oz1E7Oo6QvdJKoG9Y9nFpWRnpzZIYwWzU/SZ
         FmDSqe0tSAf1Ryqg3h09xptoA5NmP3+IcW/WELpY+sIrElzm/KVPmvqplzJ8f1EdrkTh
         PqixwwN0WJlllO9k2NmjPLqkGHusuIf6+vE9EP52PoApJ6p7iKaRxaZjmo2x7qsvcIK9
         R0JaIg+/4Evv06y8Vl6nH8XOPtnzGGxVSlJAkdfyWi+cSWRZCaNFhA9aOCEgGncibX2W
         hTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoOwYUvS0ZELB+A+fVNGJ9vzjuYG+/5gUlxketnpoRJRrspV3WHUGI2xlabEwgIA9OycanvGAX38zmV073DwU0l2TpMbURjWawQs0Mo489EnHvDynN91yFJcGzXkhBmeTSZE4P1x5kzdZg8ASaTXlh0fW1pyWnv67VBj8Px6Xi
X-Gm-Message-State: AOJu0YzHHcp027/PXqRv2MMGfIxo6Oh2EIMIW9axV13u6sK2dx28y4LC
	RzzUKf5OnPo1V7uTX3j3Cwv5S2+6KBiBbqoAIlT0yOKbbnut/n0mtaCDvRqIpdZsb7xjt7IMAwi
	Ll+HPpS4UEx8oTbHGsb8UCOaMB4E=
X-Google-Smtp-Source: AGHT+IFH0RxVWSWvxx7Od2F5Bjl9fNOEbOopFEH/T64IAZv/Jx37DVoXUhgbLBomLUTUmvQhXUEHJDp07NpWEJm0XTw=
X-Received: by 2002:a17:90a:f309:b0:2a4:ac8a:ca05 with SMTP id
 ca9-20020a17090af30900b002a4ac8aca05mr18818244pjb.34.1713367313228; Wed, 17
 Apr 2024 08:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com> <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
 <9f5ad308-f2a0-47be-85f3-d152bc98099a@hartkopp.net> <CAMZ6RqKGKcYd4hAM8AVV72t78H-Kt92NXowx6Q+YCw=AuSxKuw@mail.gmail.com>
 <64586257-3cf6-4c10-a30b-200b1ecc5e80@hartkopp.net> <Zh6qiDwbEnaJtTvl@fedora> <d4a55991-0ccc-4e8f-8acb-56077600c9e0@hartkopp.net>
In-Reply-To: <d4a55991-0ccc-4e8f-8acb-56077600c9e0@hartkopp.net>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Thu, 18 Apr 2024 00:21:40 +0900
Message-ID: <CAMZ6RqJUHJdq30CrAzT26_RqpDOH_iMP8A6SKSAYrWBe-T+Oww@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO 15765-2:2016
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Francesco Valla <valla.francesco@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, fabio@redaril.me
Content-Type: text/plain; charset="UTF-8"

On Wed. 17 Apr. 2024 at 02:19, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Francesco and Vincent,
>
> On 16.04.24 18:42, Francesco Valla wrote:
> > On Sun, Apr 14, 2024 at 10:21:33PM +0200, Oliver Hartkopp wrote:
> >> On 14.04.24 06:03, Vincent Mailhol wrote:
>
> >>> Regardless, here is a verbatim extract from the Foreworld section of
> >>> ISO 15765-2:2024
> >>>
> >>>     This fourth edition cancels and replaces the third edition (ISO
> >>>     15765-2:2016), which has been technically revised.
> >>>
> >>>     The main changes are as follows:
> >>>
> >>>       - restructured the document to achieve compatibility with OSI
> >>>         7-layers model;
> >>>
> >>>       - introduced T_Data abstract service primitive interface to
> >>>         achieve compatibility with ISO 14229-2;
> >>>
> >>>       - moved all transport layer protocol-related information to Clause 9;
> >>>
> >>>       - clarification and editorial corrections
> >>>
> >>
> >> Yes, I've checked the release notes on the ISO website too.
> >> This really looks like editorial stuff that has nothing to do with the data
> >> protocol and its segmentation.
> >>
> >
> > The :2016 suffix is cited both here and inside the Kconfig. We can:
> > - keep the :2016 here and then update both the documentation and the
> >    Kconfig once the standard has been checked
> > - move to :2024 both here and inside the Kconfig
> > - drop the :2016 from everywhere (leaving only ISO 15765) and move to
> >    ISO 15765:2024 only inside the "Specifications used" paragraph
> >
> > What do you think? Shall the modifications to the Kconfig be done as part of
> > this series?

If we bump the version to :2024, then I suggest to:

  - add a first patch in this series to update Kconfig.
  - add your documentation as a second patch directly with the :2024 version.

Generally speaking, when a feature requires any kind of clean-up, I
think it is better to do that clean-up first, prior to introducing the
feature.

I am also supportive of your idea to drop the year suffix in most
places and only keep it once.

> So here is my completely new view on this version topic ... ;-D
>
> I would vote for ISO 15765-2:2016 in all places.
>
> The ISO 15765-2:2016 is the first ISO 15765-2 standard which supports
> CAN FD and ISO 15765-2:2024 does not bring any functional change neither
> to the standard nor to the implementation in the Linux kernel.
>
> For that reason ISO 15765-2:2016 is still correct and relevant (due to
> the CAN FD support) and does not confuse the users whether the 2024
> version has some completely new feature or is potentially incompatible
> to the 2016 version.

ISO publications are backward compatible (if you dig enough, you may
find exceptions, but it is *extremely* uncommon that a newer revision
would break the specification from a prior publication). Without prior
knowledge, if I see ISO 15765-2:2024, I would know that it is the
latest and that I can thus expect support for both ISO 15765-2:2016
and ISO 15765-2:2024. If I see ISO 15765-2:2016, I may think that the
newer ISO 15765-2:2024 is not supported.

I can also use ISO 11898-1 as an example. Our documentation says that
we support ISO 11898-1:2015. The previous version: ISO 11898-1:2003 is
not mentioned a single time in the full kernel tree. Yet, I do not
think that any one was ever confused that the kernel may not be
compatible with ISO 11898-1:2003.

If you really think that there is a risk of confusion, then maybe just
adding a sentence to say that we support ISO 15765-2:2024 and all
previous versions would be enough?

But overall, I do not see the benefit to keep the older version.

> Best regards,
> Oliver

