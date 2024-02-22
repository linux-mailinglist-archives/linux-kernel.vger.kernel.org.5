Return-Path: <linux-kernel+bounces-76194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3B885F40A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0223C1C20EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C9336B04;
	Thu, 22 Feb 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URAfW3qE"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753AC17BA5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593135; cv=none; b=tyZK0tCanA7SzHjnxz7H6icV4pytCkSHUZ3z3a5ng7WU8RITZTm8tzfyxwZXvcOMLiK37dHBjOGR+SNb3q5T3EwYf63KshLpR2APTta2uJLpXxLC99HPUew3f7OGJs5eg3OYO2tURl6HlBt/vJoAL+anNaUjuhJh+4opOY+xDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593135; c=relaxed/simple;
	bh=z9T05dNkM1r6NxsCZngQ+Qju6WkQcnD11AhPfxXCcnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE6pcV+SbU4iEck0F4cRh60J6p0IjyMKxJCvk1BVY4FtosKo0UHmOP4thO2AP/iEt68vJXyeXTQOOVqTHJNOcqvST303DpWAlA36q4tHiuuCj+LLwhAmooUJ3+BnjV1Jzf3bHkyviUqH3p35Zingv4ev8e08fTrH356AUskNpdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URAfW3qE; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60884277a6dso16389367b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708593133; x=1709197933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKZOJI94hns0qguJ0N4+oB2V4yWPo7fIc3jkf6/qeWI=;
        b=URAfW3qEv8ZwCFepu3H5pKPWg+9NWYpbe0s3OR3Ml5aL7x1tk8cBM2XM/GilDH2DX7
         s0EOuUZpX1EDIvhHqZzBbPxg9RocmvedOeJCcTB15AWPg04VoOolleSddfrbcHrBZZpp
         NCwTDkl2P97t8XTvj4uSslEqLP8GCzaOTZ5IrTRwarjMmz0KD1g3t1L4gsBZMuEFwE3G
         tP7OFxsrI6yOz7mHSCdEgs2FsHShq/b+z02VOcKTT6fD2To1/v1UOWjnRTKLOu4LZ4ML
         yuFHmJG6FMiQFRX4u+jfiRqrCHURKNfemrhAjoPHgdS5MTdGNXMo+sbyEQS/hOol5YDu
         d5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708593133; x=1709197933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKZOJI94hns0qguJ0N4+oB2V4yWPo7fIc3jkf6/qeWI=;
        b=TvB4k0Muouv+fCkAUNZBHM8v9ILuoBabeCtDLdAwdoio+DTYdrb1+j6cm8uLP2ljZi
         uhFWvTYTCc3VX+NkQIdodEdEKseq89vxot3Qqy1ChaeG9VWJdf9LFtLm74wwm4n3I0oS
         dNOBw6AB7/biCdRPFR6m10wMklibp/iN4wxJxN/hTQZ7P6nVQJqZ78XeCuueWx2kEbE2
         +tR1+BMNP3zzCf1P4XM4w9noDP3B95fT4Y9F9qb2t5kTbYJkKLZfVTYMGMA/p1QZAdMY
         x1k1MOEh5oeEjU3SKU1NqCY4A1nB5xw6KxxP0DhSS4UmsY9I8ep9shAXo2hNKKB50BPM
         G3fA==
X-Forwarded-Encrypted: i=1; AJvYcCWhlBFFXFcOJPsDNqldWyiiW0pQ4A6pINZQN66FoxUFfXJQ+gzKIl/cjHd1xfKpmXkVT+J4Kgx0FSdNbjYHzVd8Fn+A2ncyxiTRxffo
X-Gm-Message-State: AOJu0YyKflM18/wrVvaeWbs/JEHwjmYXrLSzjGcI+4CozGIf0RrdUml5
	SMGQ/Ms+iHiG01/AdqqV1Jas8MPPTZa/9t6truJuMDAQB3It58cTprlix+pJfj7MOL8+y9umUXT
	FB8zi3GhNLBeA5uL0KswEngWzia7dT2kAO96g/Yer
X-Google-Smtp-Source: AGHT+IGZiyqVnGzeLuwRRcGJ0RsP/nv30kjzkOKbWuJEbCEc2gzNhlwSqQreoayCLtVYURajcgaVCsgUGjjhMnTdOp4=
X-Received: by 2002:a81:9945:0:b0:607:d9fb:5144 with SMTP id
 q66-20020a819945000000b00607d9fb5144mr18703425ywg.13.1708593131796; Thu, 22
 Feb 2024 01:12:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
 <CAK1f24nk19eciysFqvTd=rqpiKePhstDWEEQ_mvT89WCDNrWNQ@mail.gmail.com> <84fc211a-075d-44c7-a4c3-698931b6dc7c@redhat.com>
In-Reply-To: <84fc211a-075d-44c7-a4c3-698931b6dc7c@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 22 Feb 2024 17:12:00 +0800
Message-ID: <CAK1f24kL_XHsOJ-m30t17bSBnV9wpam33Hmcpf7baT87Yt5FrA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, zokeefe@google.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, David!

On Thu, Feb 22, 2024 at 4:51=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 22.02.24 08:51, Lance Yang wrote:
> > Hey,
> >
> > On an Intel Core i5 CPU, the time taken by
> > khugepaged to scan the address space of
> > the process, which has been set with the
> > MMF_DISABLE_THP flag after being added
> > to the mm_slots list, is as follows (shorter is better):
> >
> > VMA Count |   Old   |   New   |  Change
> > ---------------------------------------
> >      50     |   23us  |    9us  |  -60.9%
> >     100     |   32us  |    9us  |  -71.9%
> >     200     |   44us  |    9us  |  -79.5%
> >     400     |   75us  |    9us  |  -88.0%
> >     800     |   98us  |    9us  |  -90.8%
> >
> > IIUC, once the count of VMAs for the process
> > exceeds page_to_scan, khugepaged needs to
> > wait for scan_sleep_millisecs ms before scanning
> > the next process. IMO, unnecessary scans could
> > actually be skipped with a very inexpensive
> > mm->flags check in this case.
>
> FWIW
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>

