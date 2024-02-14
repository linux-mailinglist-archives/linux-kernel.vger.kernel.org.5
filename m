Return-Path: <linux-kernel+bounces-65600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCCB854F50
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04CC5B22021
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B7C60868;
	Wed, 14 Feb 2024 17:00:46 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD07604AA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930045; cv=none; b=UxCnSLNz9UDOFdhvd5b5WVaJHcoHzLUQrAXDGexnqjLPDSZMxQMdXbrwLSa/9CjNqppFWu3as7pWOEKmAXWGoEPxc4MSdPg2ud5XFD1sIiGJzQGHEoiFRHr1GGeE9/Yub1vnn264Hqtt7oq5XCAD60ZysOVe1Ebupf7XCG4wru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930045; c=relaxed/simple;
	bh=NOkU71yqzXKejggrb0c8+aBapQXzv06cCw+LUfANygM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNbTjIhS/yfox98cAOgJGdCB246mXb9QeREzB42ciWF+BTRAF3DzK2X023Y8Hw3Ea+eaXa2YESQ4bYT6MvDhjAghcMMIIh8w4P84Pnpi4bYLgdt24bX5gfQ8rT9W+4EUrF1fCTOY+xyN5io+vo+zZC+XuaZghEwJwQx6+leWs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6077444cb51so7753087b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707930043; x=1708534843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DILsFp6O5FPmI48oRSyT/Mf/hZlkZDrEMNrxCJYzTXU=;
        b=qz6kf/1L2c382DXXFLsbkggRv/+7PO6OwsHB8SSj9KFUuIEUrgp7wQbb1saG0ZfXUR
         ZcNEF4kMK+5Cd0A6z3FUF8qhxOy+ZciNy6Gh4gpp+CO7/qM9eEHx84k0axyq0vo/lYAH
         zZklbVT0RDdHLSF0rbFuVmmUF8UhtY6ZkDSV9W8CDi4Zg9zHibk/9qcmf5UljCCmOmUy
         EuKJ8sfZrhDXykW6QLiwlTt6BHoYNc5DG8Libeqbn/10T9puGiGOCvYHdyeasMjvOGxB
         FkvqclKFkB98l+gnHKISD8CDQ4fRqgajqSHRFzukwxVo54FlhxivNmKrw9/3DBLExTMm
         sc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUrs8uUFZruQFwtJldnmDZkUlyq90/SPyB4yYIs5VyvCwqrAEBOGo/b6r48uo24dusceB3jGY/UWaAStJJss9qpXQLPbHlFcu4pkJG
X-Gm-Message-State: AOJu0YzWmqTuXxBMGAKqDYxjXPFK4xHIrWS+JHDQWIj5jVxK0ziiSqyI
	ewgkBihwtnrRtOy7Qw9JMasi1afYmHXt/At6P35wyc0dgY8KkXTHlovlTe8qTOs=
X-Google-Smtp-Source: AGHT+IEl818PLQBSnxoTHAAEzD10mgrz99fRsw5z70k3XRsApsY12LIYRY3Klpzlxy7DLB3Ix2pwCw==
X-Received: by 2002:a0d:ebc3:0:b0:607:7953:8c8f with SMTP id u186-20020a0debc3000000b0060779538c8fmr1896728ywe.6.1707930042878;
        Wed, 14 Feb 2024 09:00:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9l3Oqg3tcIq6o88WHJO8rYSHqTZO0tOVJOhzy/L+oXA18zmXZjxOBIN3335f+IRT+lG7YZZGkMwTOetQ0lTWUmRzH9bLpBCLe8iQ5
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id f126-20020a0dc384000000b006041f5a308esm2275291ywd.133.2024.02.14.09.00.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 09:00:42 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso909574276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:00:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXH2RR284FcVL74fh7JgdAlss9/kXgjSm4XxKphh2SoC7MI5JNwU8iWu7vRlnD6z2nAlS6jGAk2zt+SO1YVqBfOEJITLMuX20YTcARQ
X-Received: by 2002:a25:bfcb:0:b0:dc6:ab85:ba89 with SMTP id
 q11-20020a25bfcb000000b00dc6ab85ba89mr1851619ybm.25.1707930042035; Wed, 14
 Feb 2024 09:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com> <20240212132515.2660837-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212132515.2660837-5-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 18:00:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdViuEhr94SrQyTHG1BzswNzJuZba1zWphX85baFB+LVGA@mail.gmail.com>
Message-ID: <CAMuHMdViuEhr94SrQyTHG1BzswNzJuZba1zWphX85baFB+LVGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] auxdisplay: Add 7 and 14 segment mappings to MAINTAINERS
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 2:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The mapping files are tightly related to auxdisplay subsystem.
> Add them to the MAINTAINERS database.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

