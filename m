Return-Path: <linux-kernel+bounces-157264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0385F8B0F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348641C23560
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E10A1607B8;
	Wed, 24 Apr 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baoMUWEX"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7713DBB2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974107; cv=none; b=n6esy72TuZnh7Bz4dlDt+blJYg6l7ij13249sRU6SoqaUueHWYMBsF5rf19bFhzIgRP7BUR5NoUiYeU6vzSTdg16Owgm67T3h+w1u9UA61M+3ET5sGElfTAfwSH1yekMQNrAp4Xs35yHFHgI/5vDdA4Dv/J7LHKDL0phlW+hXoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974107; c=relaxed/simple;
	bh=HsMZly62yk0LjIJdFSVMMZ+wh/E5GqErZg/3nEX6vN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZQA52b7TV5nOEHv684rNE4R1iJenK6rRYOsw4rzygl6ZrXy5Z+ktTkp4thOlGa/rTFJp4kTzOrhLMu5HF8bgMx9vlUwvvtgZEvlBCkeUZKQM8fPq5yLlYRS3bvk5NU+SHDxqZY/fPeWg/8v87UkcU97kFyS9pGli2MB8NED9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baoMUWEX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ddc2ea2091so32188191fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713974104; x=1714578904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSeaEGRQ8F1CsZI2HaJ9BuNExNEc6Cm+h6xnz6hKmCA=;
        b=baoMUWEXgw4BI7A2oVUcYwcjJA6/xe68U61DzoTIZxFdbdpe3QLRoTOVYlHgZx4/cK
         knSqFqyQfbm+XtWFsQXs5xT5i/saFwuvjcjc1fKr2JShktq3iK0e5//0lmKZj4HqWn8b
         FLRRvNY0aVdzogCQ7QQdXpnBYx4to7WH2aPNRnGaoAc0t42mvHeNA3HnEDZD9Dy5tqD+
         8P0mEekk6f0OlobZMz9ASkrFqyYL9XX1/laYdyJDQLll8N2j12bU2adCGV5Hzrdgru/F
         LZyzIuLkwss2ZssF48BonuYSICmWutEsdqW7rWN4a35n1xELB3owHwt4qOkIi0JHInPv
         tj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974104; x=1714578904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSeaEGRQ8F1CsZI2HaJ9BuNExNEc6Cm+h6xnz6hKmCA=;
        b=Vji6akldtctwRhzTDsPOB2Ra1gqEsS0Kgia2SMUEjZrNg56DExpZnna2cGOBCa6FZJ
         /CVNmPLFJl9zCk6CxdGg5u4Jn6FMod95/ljE8ruqirjYLMZM7veUT/hkvab8LFnE50kg
         m5X31E+uxezwD11ybiZjybmJNrzSMNByccQFpuTjylQlkca9Wha7hkkiLlasbxhRhNNQ
         sqHV6b/FtYo3Az31zN8WXqn0Wx3L/KK5pMb1CClCo7r+IvygVi07Eb54Seud+uE2lXh6
         nfOZj5+0jEv2MSnxXPtkuZX1NUZDp24dBdVo0TioI4SmantZ4ZhXdETH10k8Mk7vhSv5
         GPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVefW/WlOoyYEZTkKzSxkrfz+4PiPJAvplyDmdrLUTgZ33l9sCWNEsu40MsR7OJFiqr/NeydNgeQUZeFroMBl9AWtA6ZQTIpEuCVPSs
X-Gm-Message-State: AOJu0Yw0uYTfimSglcwofrVrHz5Zm5WCqAJhidDtz6fzymi+UWw6oKic
	m4c7fiikNkbW2sjrbhJwWovMXPYsmO6CaPvQBj8DhDHYY/D7pLAH/RRR6ZRYCaxGBNy+HaxOgWC
	7Gnw9ZrPaAXn4isE8lILh7zjNWPE=
X-Google-Smtp-Source: AGHT+IF3YYSs7Ve/Rrkw+AlyXQbdbQ7qJxbV6EtZApf4/yUkBYGePByNQAXisyiD/WNZhzbAMwBZBaCW8ifgNeAL9gA=
X-Received: by 2002:a2e:9799:0:b0:2da:af46:2fb with SMTP id
 y25-20020a2e9799000000b002daaf4602fbmr1842270lji.15.1713974104091; Wed, 24
 Apr 2024 08:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424135148.30422-1-ioworker0@gmail.com> <ab18a4b1-bcbf-4417-b43a-5feae3b5ba66@redhat.com>
 <11455268-d522-4b3a-8961-892e42cc50f0@arm.com>
In-Reply-To: <11455268-d522-4b3a-8961-892e42cc50f0@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 24 Apr 2024 23:54:53 +0800
Message-ID: <CAK1f24ncrREvYTajnzfm0r6oE1LqZQkx=yKMs7TtsxJpBmcLaA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: introduce per-order mTHP split counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 21cnbao@gmail.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 11:20=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 24/04/2024 16:00, David Hildenbrand wrote:
> > On 24.04.24 15:51, Lance Yang wrote:
> >> Hi all,
> >>
> >> At present, the split counters in THP statistics no longer include
> >> PTE-mapped mTHP. Therefore, we want to introduce per-order mTHP split
> >> counters to monitor the frequency of mTHP splits. This will assist
> >> developers in better analyzing and optimizing system performance.
> >>
> >> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >>          split_page
> >>          split_page_failed
> >>          deferred_split_page
> >>
> >> Thanks,
> >> Lance
> >> ---
> >>
> >> Lance Yang (2):
> >>   mm: add per-order mTHP split counters
> >>   mm: add docs for per-order mTHP split counters
> >>
> >>   Documentation/admin-guide/mm/transhuge.rst | 16 ----------------
> >
> > We really have to start documenting these, and what the sementics are.
>
> I think the diffstat is backwards; the series definitely adds more lines =
than it

Good spot! I'll sort it out.

Thanks,
Lance

> removes. And patch 2 is adding 16 lines of docs, not removing them. How a=
re you
> generating this? `git format-patch` should do it correctly for you.
>
> >
> > E.g., is split_page_failed contained in split_page? Is deferred_split_p=
age
> > contained in split_page?
> >
> > But also: just don't call it "split_page". Drop the "_page".
> >
> > split
> > split_failed
> > split_deferred
>
> I guess we are back in "should we be consistent with the existing vmstats=
"
> territory, which uses split_page/split_page_failed/deferred_split_page
>
> But here, I agree that dropping _page is nicer.
>
> >
> > ?
> >
>

