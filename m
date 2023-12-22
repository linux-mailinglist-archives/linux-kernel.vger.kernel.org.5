Return-Path: <linux-kernel+bounces-10060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1158881CF4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99308B21848
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D631E500;
	Fri, 22 Dec 2023 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdfPnRG8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D01DDD9;
	Fri, 22 Dec 2023 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6da4894a8d6so1392038a34.2;
        Fri, 22 Dec 2023 12:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703277254; x=1703882054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v9AGtrpk9mhnPkcDUK7l2V4SwmO/cK0FW1ar5CBt55w=;
        b=VdfPnRG8OQSOGMD8iFXVnKZsCHjVvgdk7RKkbLejsz/ZfqoBDHabc/nEgqS2S1Ul0Y
         7UeavkgWhs/fS7vB90MurqMnIZME3PEFiUCv1CKTiZooAQU895sJc4zwsaULq5m7EqCZ
         X3YePMsZdtIanNQxtgmIGakKS32VvLSVgPMKIKzfhVPFNTM0uEPlYT3M9o5YcgZV5oKW
         zhN5DipS+C99Z+/sHEh0Hvqk6iYcVE90mW/E8gy0XY7902nEKI+9xUDqNy0ZFyuRSAJG
         AR7wjD/6s6kl8tGSc5TCt5oEUm3ZY1bj3zqoC6ur7r/3Hkw7T6FD+ts+X8Mptkl4Ht3Q
         bxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703277254; x=1703882054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9AGtrpk9mhnPkcDUK7l2V4SwmO/cK0FW1ar5CBt55w=;
        b=YhYA5h3jNZmfj7Xk+ZTrpbeKpnNxzZIsX3ghu94kl6vCzbjy3ji3vasWoco++b45D7
         t4XuIsO15ccdxQCaFyT4YipmDhIm5lLByFg7+iiErPMs0LBJQvY1iL4cP+dVECYy2D/P
         ZOZ/9l803hXQ/2gUVTR0dcK+FOTOBUfZAEmaovVvelrZL++SRFsFnLibxX1D2I3N3/jB
         PIdj0a29r7quj2QW84HHSqUsep1JuMa/yNC0xLroJCu5cz5O3buhEaCq2rLhpDZqcuJ1
         HunagAfuKmIs93DdwcN8y994KFRzas3ju/9TITRBBdwFcCbo/E2t9fFQL36PkX9a8XMw
         xS/w==
X-Gm-Message-State: AOJu0Yz871x+tP8bpuAMhPzIImog4ekgTyZU+32NttIHdXXWDRUFHJ0h
	Nh/2U78IAgqeO1fXsxt86sQgGVppWUDKbTnhJWA=
X-Google-Smtp-Source: AGHT+IGJN7J5vr00bGcCmpBPu9O5udn3QTr35DetlYFkKB9omxFqKHM3YQ2mCBuNJgq3oYdYUvxBSjvmxRiBHJi8qOA=
X-Received: by 2002:a9d:67c6:0:b0:6da:f9:ae99 with SMTP id c6-20020a9d67c6000000b006da00f9ae99mr1474742otn.0.1703277254389;
 Fri, 22 Dec 2023 12:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222200350.2024-1-kdipendra88@gmail.com> <b4ad9a64-53cf-449a-aa18-d19ff3c72c52@infradead.org>
 <CAEKBCKO4uGKxXPZHO9iqYZ_8ibgY3HS3C8Rsogcv1XU+qGkudA@mail.gmail.com> <a0945bf2-72a4-4ad9-ad94-74d539555862@infradead.org>
In-Reply-To: <a0945bf2-72a4-4ad9-ad94-74d539555862@infradead.org>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Sat, 23 Dec 2023 02:19:03 +0545
Message-ID: <CAEKBCKM3nHYS6V8RzM1f8wuTsGWxpm+b9qXz9wd1vAPpc+66Yg@mail.gmail.com>
Subject: Re: [PATCH] staging: media: atomisp: pci: Fix spelling mistake in ia_css_acc_types.h
To: Randy Dunlap <rdunlap@infradead.org>
Cc: hdegoede@redhat.com, mchehab@kernel.org, sakari.ailus@linux.intel.com, 
	gregkh@linuxfoundation.org, hpa@redhat.com, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Dec 2023 at 02:16, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 12/22/23 12:29, Dipendra Khadka wrote:
> > On Sat, 23 Dec 2023 at 01:57, Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> Hi--
> >>
> >> On 12/22/23 12:03, Dipendra Khadka wrote:
> >>> The script checkpatch.pl reported a spelling error
> >>> in ia_css_acc_types.h as below:
> >>>
> >>> '''
> >>> WARNING: 'cummulative' may be misspelled - perhaps 'cumulative'?
> >>>         u32 padding_size;       /** total cummulative of bytes added due to section alignment */
> >>>                                           ^^^^^^^^^^^
> >>> '''
> >>>
> >>> This patch corrects a spelling error,
> >>> changing "cummulative" to "cumulative".
> >>>
> >>
> >> 'codespell' reports this one as well:
> >>
> >> drivers/staging/media/atomisp/pci/ia_css_acc_types.h:411: descibes ==> describes
> >>
> >> Thanks.
> >>
> >
> > Thanks for the reply. Do you want the spelling mistakes reported by
> > codespell in the same patch with this change as well or you will
> > consider
> > it in the next patch?
>
> That's up to some maintainers, but I would prefer to see all of the
> spelling errors fixed in one patch.
>
> Thanks.
>
Ok sure,give me some time and I will send the v2 patch.
Thanks.
> >
> >>> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> >>> ---
> >>>  drivers/staging/media/atomisp/pci/ia_css_acc_types.h | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> >>> index d6e52b4971d6..ac6fb0eb990a 100644
> >>> --- a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> >>> +++ b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> >>> @@ -84,7 +84,7 @@ struct ia_css_blob_info {
> >>>               memory_offsets;  /** offset wrt hdr in bytes */
> >>>       u32 prog_name_offset;  /** offset wrt hdr in bytes */
> >>>       u32 size;                       /** Size of blob */
> >>> -     u32 padding_size;       /** total cummulative of bytes added due to section alignment */
> >>> +     u32 padding_size;       /** total cumulative of bytes added due to section alignment */
> >>>       u32 icache_source;      /** Position of icache in blob */
> >>>       u32 icache_size;        /** Size of icache section */
> >>>       u32 icache_padding;/** bytes added due to icache section alignment */
> >>
> >> --
> >> #Randy
> >> https://people.kernel.org/tglx/notes-about-netiquette
> >> https://subspace.kernel.org/etiquette.html
>
> --
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html

