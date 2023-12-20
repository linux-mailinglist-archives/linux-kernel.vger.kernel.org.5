Return-Path: <linux-kernel+bounces-6428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0F78198B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870CC288157
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CC4125CB;
	Wed, 20 Dec 2023 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPuP8cNp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D51640D;
	Wed, 20 Dec 2023 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f47b15fa3so19535956d6.1;
        Tue, 19 Dec 2023 22:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703054169; x=1703658969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MP0HTmjFL5ipgW8+FrullXm00FRbon6aH9dRUBk9dk=;
        b=fPuP8cNpUwG4H28bQXqOZQADG9QKkZCaOScTKikESSJWlEKvlFV4XcCY71yJ4gUBZp
         ULubZ7VlKK5xU9K7BZmdDUclh1rWodKfo+at4k5sK22l+nM/ONDcUIKCO0WLVVmmV6Wj
         IB4hz85mOQg7L12NNIh7JXX1QGuj3EQOFRH7mX0J1AaTWrZFU7OrN4bob38VsCns1Sbj
         GMwOnPjLet2h/NNQsM9p08vUniz7LnCjNwE9DBgigwwXPQ0nB8SQFzyv/Pb48qKZV85G
         1kx+vwi1Z+V5kdhJtSifUZqcbNDVC5AfAR5+t775a72BtBMJ2EAF792Fdqrme/kPpjxS
         cU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703054169; x=1703658969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MP0HTmjFL5ipgW8+FrullXm00FRbon6aH9dRUBk9dk=;
        b=UfePdz87kJuQeSxtZ9DvF5CUnyW16Xv+2z+nelJ25wq8vPg8NcW/Fq84CmjzkhDc6x
         +jBJHXHz3Z5m0jGAPKkPQEhPwpQeaIVXFSSGco7EKJf7lzSBsRgqQFwcIEKCx+r5AbGe
         kdGm8ry7aLbA/RjRry2Ovb893U6UuW9bJjna4ghmhsfSjQ7H75YJWrBTNRZZAz/cAy0S
         aJGOP/B2UnJ3Sg6UYoLpRP2JvJScUJiQYHkEzuNqxT91rsJWoHePT6D2SDiRQTybbPOj
         yZSOtHbfgBWTO0qRcy6LnL3RJxyC7fweGSGhMYMD/llmp/BBYwKWe9o24Mr/t+cJy/1Q
         Z6GQ==
X-Gm-Message-State: AOJu0Yw6zIaOfOWUlimxOfBWNcEZ4Yh4YPyPu0ay6Vi4BdLF0CplqDqf
	j+9ZGA2NcSNS1fZN6jWuPsXGtZWUZfOsBddq247opGp4h/gM/g==
X-Google-Smtp-Source: AGHT+IHIx9Sh6g+/2+1c0JEPFUM7ITb2mqzwWusSVWgJzf/URstRIrCzy4sDiQwyr3tYJDL5RYA0wtl4IOD95NttVn0=
X-Received: by 2002:ad4:4301:0:b0:67e:aa04:ddcd with SMTP id
 c1-20020ad44301000000b0067eaa04ddcdmr19455514qvs.62.1703054169024; Tue, 19
 Dec 2023 22:36:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220062446.14511-1-muzammil@dreambigsemi.com> <4155c90e-cdb1-4645-8bcc-fed4ea01ac83@infradead.org>
In-Reply-To: <4155c90e-cdb1-4645-8bcc-fed4ea01ac83@infradead.org>
From: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Date: Wed, 20 Dec 2023 11:35:58 +0500
Message-ID: <CAJHePoabyUCxwS_hTjhR+MEJ+JBm+kr2MdbP4zP_54t_geRqwQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: kernel-doc: Bug fixed for erroneous warning
To: Randy Dunlap <rdunlap@infradead.org>
Cc: corbet@lwn.net, gustavoars@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI,

1) I already have the below patch but it does not work.
https://lore.kernel.org/linux-doc/20231215001347.work.151-kees@kernel.org/

2) When I applied the below patch. It works.
https://lore.kernel.org/linux-doc/87le9rjb4y.fsf@meer.lwn.net/

On Wed, Dec 20, 2023 at 11:29=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Hi,
>
> On 12/19/23 22:24, Muhammad Muzammil wrote:
> > From: Muzammil Ashraf <m.muzzammilashraf@gmail.com>
> >
> > kernel-doc: fixed erroneous warning generated by '__counted_by'
> >
> > Signed-off-by: Muzammil Ashraf <m.muzzammilashraf@gmail.com>
> > ---
> >  scripts/kernel-doc | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> > index 1484127db104..ea9688df0e93 100755
> > --- a/scripts/kernel-doc
> > +++ b/scripts/kernel-doc
> > @@ -1661,6 +1661,7 @@ sub check_sections($$$$$) {
> >                       }
> >                       elsif (($decl_type eq "struct") or
> >                              ($decl_type eq "union")) {
> > +                next if (index("@_", "__counted_by") !=3D -1);
> >                               emit_warning("${file}:$.",
> >                                       "Excess $decl_type member " .
> >                                       "'$sects[$sx]' " .
>
> One of both of these patches should be enough. Can you test these
> instead of your patch, please?
>
> https://lore.kernel.org/linux-doc/20231215001347.work.151-kees@kernel.org=
/
>
> https://lore.kernel.org/linux-doc/87le9rjb4y.fsf@meer.lwn.net/
>
> Thanks.
>
> --
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html

