Return-Path: <linux-kernel+bounces-145712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1048A59EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287121F22682
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365F1143875;
	Mon, 15 Apr 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egeL/zip"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDA1428F4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205873; cv=none; b=pwKNaLhAf94DbPt/3OnDXH+n4VmPfwgwV3VRF/CIgOzMJOfeeomPwJr4spPu7xAdkn4HCPMdTUF7keA+6sAMGrDKnOH6NF+Tk/o67OPWdRKK/8wYO9g+5gS54GJ9e8kgcXEXzACqpF9/+pf4KsHqD5VjtJTzDW6SDUZm2nRXkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205873; c=relaxed/simple;
	bh=ooiKgKrfmVVf9meli4mQk0KMGxX8I7nqnD5XZE4i2o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCkiL1fZ5Y9mZIU+HkiRowIRcw7OE7Oz8J2l9WNVjIs6v+O6wx+R9L5eqaZUpgZWWuusLkHsN9kJFAHHrwd3lVW/0wevs80KOnAn0L6aZZMgyZPaMQEUtxqjpgfU0Ab+dH1a1Ely6bJurMGE+EzNz+67KjAsVejcVDpohF183Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=egeL/zip; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44ad785a44so423406866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713205870; x=1713810670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooiKgKrfmVVf9meli4mQk0KMGxX8I7nqnD5XZE4i2o0=;
        b=egeL/zipcobBlNV+gyd823khI/Lf2+FFc5Asxh3iElHpRvU7regbftKpOVBOa3wNNj
         PvO0fHuXN38NTmwRF1V7wWYt5t/4R/IZpprWktQI65qMrbQ5aC14wqNMIrfWLQV48Dm2
         HNPe47V1dP2pUEso3m5DTmWrNIHHXmNH4KcEwpmMTXXDXcUenq3bhrs2jEAkP6epJpf3
         dohnclkKNmmzcmWK0hj22mL2/DoDyonkrg3D9ySOhrsdg74zZvW1Upq1uVjhLxWkb2fU
         Dwp2Zb8PTfAH5erNlKQJ4twroyvmki/dU5QdyqW9XQQQ+zbPESk6Jcewg6m7xqDQpvJ4
         ZHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205870; x=1713810670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooiKgKrfmVVf9meli4mQk0KMGxX8I7nqnD5XZE4i2o0=;
        b=wc8G6dsskFMHkyVYTZAlwSu3s9EeziA/Q/PS3HyLDNAEJOze3f/nRCpvt8izfqLBhz
         b2De/U9BYu3dt4c93h5tx9ZLHxbmGtXRvfJO4gtbIEyzZr8mMegF02RP3xuKusoYpK3k
         n37wACChBV6pyzy1fxxyTFVOrkPPS3mTbc5l377i2Q/Wzhk0pKyxKl+MCAdp0aMrwZLr
         E5pcffD42HvJQ4dWRlGN7XDpYfXVYr/rOM9VVY8YlJ4G36Sfq1zwrUHFW7wNQBC0SyjT
         Lv2rqlWOS5maJ+9B4emyAMD7RbiyO3FMCN47GjRSDbm697nZMS4hBQ1UkqZ/BRYRQrR9
         AMTA==
X-Forwarded-Encrypted: i=1; AJvYcCX5K3VW8Rtf1UxVTyq0xircv8Zxu09KZ+9NroSjd6UNte13m9s3qI/zIdYpfuKFJGC+WLlJSpHLI4fBAevwYaWMax337Kw/KPf9GfKt
X-Gm-Message-State: AOJu0YzAwDkaHsVFkEM1NKDDZEZuXLqNGW7WqFp0+hxbiQkeulkmNxzW
	jO/wNzlJpctljlV3AxNVsdxsF3XEJ4xF50IDAWHdqGcnHcZkNB64AAwAOpqsAYDaku4cb0wMfK8
	4C7rrq/ocIFusSQOKzOb53cMqkGZTvXHd9esc
X-Google-Smtp-Source: AGHT+IFmqRyB8N1jy/PHaBJGEIjnMGOrwq67XTdJuNETsU/iMnstWTpjwpiYg6YIif6xn7l4XYQWhubtI+8Hz7Isuyc=
X-Received: by 2002:a17:906:c105:b0:a4e:cd5c:da72 with SMTP id
 do5-20020a170906c10500b00a4ecd5cda72mr7667793ejc.63.1713205869703; Mon, 15
 Apr 2024 11:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405053510.1948982-1-yosryahmed@google.com>
 <20240405053510.1948982-3-yosryahmed@google.com> <20240405152619.GA866431@cmpxchg.org>
 <CAJD7tkaSCvgs-yKXeAVoW14_LhtCrL3N9hu9xA41GCvz+RvWBw@mail.gmail.com>
 <7aec7b98-db81-4238-bdd6-afb69679f852@redhat.com> <CAJD7tkaa3P7dQys+LhuDe8kqWsUqf7PDB8Q+07+wnQ513-6NLg@mail.gmail.com>
 <69dcd33b-e8de-4927-93dd-d4ea22834a18@redhat.com> <CAJD7tkb5D6Y5OMTzpHefYgSXbw7GdPtfjSp2=nBGjJFk99GP_A@mail.gmail.com>
 <f18ecb84-31a5-4767-a8df-0c0b8be82d81@redhat.com> <CAJD7tkYMM9oDQYsWPcQNctRRH52+oM-3cUhxV+_7Qg1NNZx4cg@mail.gmail.com>
 <d4b5033a-34fd-44ed-ab57-ea2b4ed01468@redhat.com>
In-Reply-To: <d4b5033a-34fd-44ed-ab57-ea2b4ed01468@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 15 Apr 2024 11:30:31 -0700
Message-ID: <CAJD7tkacCA5JQpis=Y6zGVx+uMnwCBk3jUDA8Nch2qXnR1qrgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
To: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 8:10=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.04.24 03:05, Yosry Ahmed wrote:
> > On Fri, Apr 12, 2024 at 12:48=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 10.04.24 02:52, Yosry Ahmed wrote:
> >>> [..]
> >>>>> Do we need a separate notifier chain for totalram_pages() updates?
> >>>>
> >>>> Good question. I actually might have the requirement to notify some =
arch
> >>>> code (s390x) from virtio-mem when fake adding/removing memory, and
> >>>> already wondered how to best wire that up.
> >>>>
> >>>> Maybe we can squeeze that into the existing notifier chain, but need=
s a
> >>>> bit of thought.
> >>>
> >>
> >> Sorry for the late reply, I had to think about this a bit.
> >>
> >>> Do you mean by adding new actions (e.g. MEM_FAKE_ONLINE,
> >>> MEM_FAKE_OFFLINE), or by reusing the existing actions (MEM_ONLINE,
> >>> MEM_OFFLINE, etc).
> >>
> >> At least for virtio-mem, I think we could have a MEM_ONLINE/MEM_OFFLIN=
E
> >> that prepare the whole range belonging to the Linux memory block
> >> (/sys/devices/system/memory/memory...) to go online, and then have
> >> something like MEM_SOFT_ONLINE/MEM_SOFT_OFFLINE or
> >> ENABLE_PAGES/DISABLE_PAGES ... notifications when parts become usable
> >> (!PageOffline, handed to the buddy) or unusable (PageOffline, removed
> >> from the buddy).
> >>
> >> There are some details to be figured out, but it could work.
> >>
> >> And as virtio-mem currently operates in pageblock granularity (e.g., 2
> >> MiB), but frequently handles multiple contiguous pageblocks within a
> >> Linux memory block, it's not that bad.
> >>
> >>
> >> But the issue I see with ballooning is that we operate here often on
> >> page granularity. While we could optimize some cases, we might get qui=
te
> >> some overhead from all the notifications. Alternatively, we could send=
 a
> >> list of pages, but it won't win a beauty contest.
> >>
> >> I think the main issue is that, for my purpose (virtio-mem on s390x), =
I
> >> need to notify about the exact memory ranges (so I can reinitialize
> >> stuff in s390x code when memory gets effectively re-enabled). For othe=
r
> >> cases (total pages changing), we don't need the memory ranges, but onl=
y
> >> the "summary" -- or a notification afterwards that the total pages wer=
e
> >> just changed quite a bit.
> >
> >
> > Thanks for shedding some light on this. Although I am not familiar
> > with ballooning, sending notifications on page granularity updates
> > sounds terrible. It seems like this is not as straightforward as I had
> > anticipated.
> >
> > I was going to take a stab at this, but given that the motivation is a
> > minor optimization on the zswap side, I will probably just give up :)
>
> Oh no, so I have to do the work! ;)
>
> >
> > For now, I will drop this optimization from the series for now, and I
> > can revisit it if/when notifications for totalram_pages() are
> > implemented at some point. Please CC me if you do so for the s390x use
> > case :)
>
> I primarily care about virtio-mem resizing VM memory and adjusting
> totalram_pages(), memory ballooning for that is rather a hack for that
> use case ... so we're in agreement :)
>
> Likely we'd want two notification mechanisms, but no matter how I look
> at it, it's all a bit ugly.

I am assuming you mean one with exact memory ranges for your s390x use
case, and one high-level mechanism for totalram_pages() updates -- or
did I miss the point?

I am interested to see how page granularity updates would be handled
in this case. Perhaps they are only relevant for the high-level
mechanism? In that case, I suppose we can batch updates and notify
once when a threshold is crossed or something.

>
> I'll look into the virtio-mem case soonish and will let you know once I
> have something running.

Thanks!

