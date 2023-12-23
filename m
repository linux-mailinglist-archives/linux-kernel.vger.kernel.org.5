Return-Path: <linux-kernel+bounces-10437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7271481D45E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BD71C2139E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA3ADDB6;
	Sat, 23 Dec 2023 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/6JQxzn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF4D529;
	Sat, 23 Dec 2023 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bb732e7d78so1965338b6e.0;
        Sat, 23 Dec 2023 05:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703339959; x=1703944759; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gFN/JWUQNBbz2Rt0TnEnzTMVqwHhg8TmRPTdu1IMZhk=;
        b=c/6JQxzn1GWxS+lECvv7jY6u57GVg0oD5AK51lYM5HQrz2aeNrwxmK51RZFK2Wryh6
         wWmPWuamb0jJ8RAwrrQjrtD3QLIfGq8sWnqCfFWAezfQ92gHw9ziXCyCESZHpLBkKjW0
         H86HNKtXKpmfG2AmNjHWihKEM/OMAVFKxNd9PWEWt8sQ11p39rr/tyc+naK6cbKfcMuW
         RvySS28S+1A/sqwL8uJnjyK3qa1iS4+CItPlABVx7rHRwexXN/6yt/ztPVPEJpyl530H
         iedcy8fDX/qi7bBoUzv+3nPZb6ZyexeALoH1kWc+Rp2UY8IQMvOmoMHTjEIMWXnsfx5Y
         qr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703339959; x=1703944759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFN/JWUQNBbz2Rt0TnEnzTMVqwHhg8TmRPTdu1IMZhk=;
        b=cYkhtjrnDoIVhSDtA0Z2PetphXO5Py2CV9/fctBf8DdS2nBKXawe4MqEqoVguYe7eI
         Ip/ro+5TaPazUEz0rMMkoVIHfoiyTrtl33tXs/rmfGaJBYalNUJR5Xeqmw94gHAOwNye
         oBgxY9d4Kgc8P8tLdGPbaQBvybW9BiT0wdzc3YKGuTrlobZxNofzwiqA7RBJmH5Gx2oo
         a0IgBS0GYuldurla6O6GRaA/SalFvzz/sJRhO/7vghMtm4cF+T/bDEwkhC57DIOgZddg
         PFXpA2fXsccFYfnoBxT5SrUmboeOviowh9nbno0cKx5KjNL1FIJQH6ZnpRpWqVARaFkh
         cDTQ==
X-Gm-Message-State: AOJu0YysMX8c0H9luOuEcrEZDL6IuzN33bLqh0VP99NayQ0HScPFyJQb
	+9AbhDiY9+jUj9N6arVQsO7TL8u7M7Lc9xubNd8=
X-Google-Smtp-Source: AGHT+IHwz+pyBOWd/p0WXliaxQNFzW48D6/37njGjyW5fHA3ep7uDmOJXRWiBiR23Yq9jf7X7MRC/eVJww1g5qgf9YI=
X-Received: by 2002:a05:6808:1303:b0:3b8:b063:6665 with SMTP id
 y3-20020a056808130300b003b8b0636665mr2526149oiv.92.1703339959003; Sat, 23 Dec
 2023 05:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223051108.74711-1-kdipendra88@gmail.com> <d1c18155-9c8e-4164-a2bf-5eab3d42995d@infradead.org>
 <e7a46035-9c5e-495d-8f20-73dca4fec068@redhat.com>
In-Reply-To: <e7a46035-9c5e-495d-8f20-73dca4fec068@redhat.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Sat, 23 Dec 2023 19:44:07 +0545
Message-ID: <CAEKBCKPA0-VKA_r+YsGVb0cTKEQpV0dXwU8ARZ07LGmWuH2_OQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: media: atomisp: pci: Fix spelling mistake in ia_css_acc_types.h
To: Hans de Goede <hdegoede@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, mchehab@kernel.org, sakari.ailus@linux.intel.com, 
	gregkh@linuxfoundation.org, hpa@redhat.com, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sat, 23 Dec 2023 at 16:10, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/23/23 06:18, Randy Dunlap wrote:
> > Hi Dipendra,
> >
> > On 12/22/23 21:11, Dipendra Khadka wrote:
> >> codespell reported spelling mistakes in
> >> ia_css_acc_types.h as below:
> >>
> >> '''
> >> ia_css_acc_types.h:87: cummulative ==> cumulative
> >> ia_css_acc_types.h:411: descibes ==> describes
> >> '''
> >>
> >> This patch fixes these spelling mistakes.
> >>
> >> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> >
> > This patch is an improvement so it could be merged as is IMO.
> > But...
> >
> >> ---
> >> v2:
> >>  - Previously only corrected spelling  mistake reported by checkpatch.pl.
> >>  - All spelling mistakes reported by codespell are fixed.
> >> v1: https://lore.kernel.org/lkml/20231222200350.2024-1-kdipendra88@gmail.com/
> >>
> >>  drivers/staging/media/atomisp/pci/ia_css_acc_types.h | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> >> index d6e52b4971d6..1dc2085ecd61 100644
> >> --- a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> >> +++ b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
> >> @@ -84,7 +84,7 @@ struct ia_css_blob_info {
> >>              memory_offsets;  /** offset wrt hdr in bytes */
> >>      u32 prog_name_offset;  /** offset wrt hdr in bytes */
> >>      u32 size;                       /** Size of blob */
> >> -    u32 padding_size;       /** total cummulative of bytes added due to section alignment */
> >> +    u32 padding_size;       /** total cumulative of bytes added due to section alignment */
> >
> > I apologize for not looking at your v1 patch carefully.
> > The comment above would be much better as
> >
> >                               /** total accumulation of bytes added due to section alignment */
>
> I agree that that is better. Dipendra can you please send a v3
> using the new text suggested by Randy ?

Sure,let me send a v3 with the new text suggested by Randy.

Regards,

Dipendra

>
> Regards,
>
> Hans
>
>
>
> >>      u32 icache_source;      /** Position of icache in blob */
> >>      u32 icache_size;        /** Size of icache section */
> >>      u32 icache_padding;/** bytes added due to icache section alignment */
> >> @@ -408,7 +408,7 @@ struct ia_css_acc_sp {
> >>  };
> >>
> >>  /* Acceleration firmware descriptor.
> >> -  * This descriptor descibes either SP code (stand-alone), or
> >> +  * This descriptor describes either SP code (stand-alone), or
> >>    * ISP code (a separate pipeline stage).
> >>    */
> >>  struct ia_css_acc_fw_hdr {
> >
>

