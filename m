Return-Path: <linux-kernel+bounces-14304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD710821B1A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DB21C21E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEEFF9DF;
	Tue,  2 Jan 2024 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K5kxsNkc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF87F9CF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e7b51b0ceso5751554e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 03:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704195552; x=1704800352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xrexN7AjIT8/bBjygEtpkIwY//a4OJyt2takyL4czo=;
        b=K5kxsNkcQhB6FLLt5bshi1c1n/NaJpOEuwdt2n/HBpcBMeRst4eoM+cvlVluugNjEy
         Vt4kKnK0NMYx3R3lgG9xfahj/+0LIIXID5aGEWTqdx2Hakr0cl1169iGRAM/NGit/e7v
         VHWy+dQyY/Nb4cLowFRfU5zNrbvCnjn8yfxXwhfcfbaXZO0qn4R4wPD8UUOhqpWzpTuf
         JV3Idfijyd3PiXsJ93uuyR6HbSSLjOyX/CStw08a1EvIaAmMEYAp6yH1+WD2HNIVvnFm
         sNGsxHsKcJ+A2v0sOG8AiYgPWGnqT50m8YeATD6CiJXAUbCR1hmimo0H09LBpV6wiuW0
         LpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704195552; x=1704800352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xrexN7AjIT8/bBjygEtpkIwY//a4OJyt2takyL4czo=;
        b=RsddpDCM9jKFzWgBzSSniFb35Mlrls2asBF4U5g5WmrmNflUKoY1GgOD/GIx9AAUYP
         R8HoKcimvxExtysdD+M+7eAXag3R+hrGJ9kbFTNhxNHpd47zQP/Df84koTt8oiZTu2di
         Gj3/wUlEGwVz7PjJ7nRLQbwgbIH+NS9B9XboPrhs6mXTltmYkdSqY73+YiIiwm4Qa8iA
         e/DXKF9YagMZfGwFt/iGDl0hx/fRPVXSSyJkYuSqBt/cmHyujprPPxJV2veb0079FR4p
         7jfNiQh5JwEpmiwU378u12pV11IdkGemLXZS7nhQ5p4ITKw9jQNiyshdruFZ4CKXsTJi
         hmCw==
X-Gm-Message-State: AOJu0YxUF89QnQbe/fxgRgFTcbBmGunWeKHTfUPtM2kY6FMYTTUFngYI
	45sGjoBD6P5KpIAv7xxBUxrhGn4GB+srd5dHoDb41gzb6dbORg==
X-Google-Smtp-Source: AGHT+IFbko5i8RH8Vg0vZ4pxb7kzTc7ul8NUW8obTIRqTyaRi54CPtExu7HRi7nRM5xXeMBBJcX0lgK8wbOWkXJVzio=
X-Received: by 2002:a05:6512:1254:b0:50e:754c:84ff with SMTP id
 fb20-20020a056512125400b0050e754c84ffmr8987199lfb.11.1704195552502; Tue, 02
 Jan 2024 03:39:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com> <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
In-Reply-To: <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Tue, 2 Jan 2024 19:39:00 +0800
Message-ID: <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 10:09=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Oct 24, 2023 at 7:27=E2=80=AFAM Zhongkun He
> <hezhongkun.hzk@bytedance.com> wrote:
> >
>
> My apologies for the delayed response. I have a couple of questions.
>
> > The zswap_writeback_entry() will add a page to the swap cache, decompre=
ss
> > the entry data into the page, and issue a bio write to write the page b=
ack
> > to the swap device. Move the page to the tail of lru list  through
> > SetPageReclaim(page) and folio_rotate_reclaimable().
> >
> > Currently, about half of the pages will fail to move to the tail of lru
>
> May I ask what's the downstream effect of this? i.e so what if it
> fails? And yes, as Andrew pointed out, it'd be nice if the patch
> changelog spells out any observable or measurable change from the
> user's POV.
>

The swap cache page used to decompress zswap_entry should be
moved  to the tail of the inactive list after end_writeback, We can release
them in time.Just like the following code in zswap_writeback_entry().

   /* move it to the tail of the inactive list after end_writeback */
   SetPageReclaim(page);

After the writeback is over, the function of
folio_rotate_reclaimable() will fail
because the page is not in the LRU list but in some of the cpu folio batche=
s.
Therefore we did not achieve the goal of setting SetPageReclaim(page), and
the pages could not be free in time.

> > list because there is no LRU flag in page which is not in the LRU list =
but
> > the cpu_fbatches. So fix it.
>
> This sentence is a bit confusing to me. Does this mean the page
> currently being processed for writeback is not in the LRU list
> (!PageLRU(page)), but IN one of the cpu folio batches? Which makes
> folio_rotate_reclaimable() fails on this page later on in the
> _swap_writepage() path? (hence the necessity of lru_add_drain()?)
>

Yes, exactly.

> Let me know if I'm misunderstanding the intention of this patch. I
> know it's a bit pedantic, but spelling things out (ideally in the
> changelog itself) will help the reviewers, as well as future
> contributors who want to study the codebase and make changes to it.
>

Sorry,my bad.

> >
> > Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
>
> Thanks and look forward to your response,
> Nhat
>
> P/S: Have a nice holiday season and happy new year!

Here are the steps and results of the performance test=EF=BC=9A
1:zswap+ zram (simplified model with on IO)
2:disabel zswap/parameters/same_filled_pages_enabled (stress have same page=
s)
3:stress --vm 1 --vm-bytes 2g --vm-hang 0   (2Gi anon pages)
4: In order to quickly release zswap_entry, I used the previous
     patch (I will send it again later).
https://lore.kernel.org/all/20231025095248.458789-1-hezhongkun.hzk@bytedanc=
e.com/

Performance result=EF=BC=9A
   reclaim 1Gi zswap_entry

time echo 1 > writeback_time_threshold
(will release the zswap_entry,  not been accessed for more than 1 seconds )

Base                                 With this patch
real    0m1.015s               real    0m1.043s
user    0m0.000s              user    0m0.001s
sys     0m1.013s               sys     0m1.040s
So no obvious performance regression was found.

After writeback, we perform the following steps to release the memory again
echo 1g > memory.reclaim

Base:
                     total        used        recalim        total        u=
sed
Mem:           38Gi       2.5Gi       ---->             38Gi       1.5Gi
Swap:         5.0Gi       1.0Gi       ---->              5Gi        1.5Gi
used memory  -1G   swap +0.5g
It means that  half of the pages are failed to move to the tail of lru list=
,
So we need to release an additional 0.5Gi anon pages to swap space.

With this patch:
                     total        used        recalim        total        u=
sed
Mem:           38Gi       2.6Gi       ---->             38Gi       1.6Gi
Swap:         5.0Gi       1.0Gi       ---->              5Gi        1Gi

used memory  -1Gi,  swap +0Gi
It means that we release all the pages which have been add to the tail of
lru list in zswap_writeback_entry() and folio_rotate_reclaimable().


Thanks for your time Nhat and Andrew. Happy New Year!

