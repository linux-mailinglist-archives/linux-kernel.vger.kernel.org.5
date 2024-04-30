Return-Path: <linux-kernel+bounces-163203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD58B6722
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC8E1F23C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F46FB0;
	Tue, 30 Apr 2024 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMJfN3+J"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408CB1FBA;
	Tue, 30 Apr 2024 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439078; cv=none; b=NttFJoev4rSE0b+91Ry2K4W6Tz1xQ42GDVov7TGph/ZB7cOap8N2rpTrfQxXQEAYPrXLjLBT+akqihoxQljGQkWj2++E7cbSDTbgE8kqCiarpOCXxwgD4m0pibudmEyNKadNUDI4L/Xu5k2w8s0eLPgePueWVUErHbg697I7m1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439078; c=relaxed/simple;
	bh=PfIZ2OzMF7H5BdktCnUKZd+MnhBoRHx3h3/g+0pDVmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYYE0RCskJSEL+1NoR7DpmNL87PM84/VlZ5PyMsq9fBMrPtWn2E+tqCRKTRZN1YHnSa7VUMwN+yyGb6mWmmn4AXPSVBMmLxKdRIr7lza7w6I9mbhM/ZgVabzP2s6r+keVXQIMvOtaSiL4O87OlTT3kQ8Ifdrl2ewjF4pMn6W150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMJfN3+J; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5726716a006so3819093a12.2;
        Mon, 29 Apr 2024 18:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714439075; x=1715043875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmlXHYTP1JU1chg3YaCZTEhfqyjw0+XCv0tIk9SD3Mg=;
        b=kMJfN3+JVJ3HvHeUx5tK00p1FTS2Uv9RpTDzgz+GcWDkR+Sew+9NY7ryukSpFxFzMe
         ydp1Y0cQOxWKBhphtadlu0Xuzz5k95iCF4GFUHVl4IrldfXoy5CNbMcUcD7iQDkgU3NX
         tUP/zMWWI5xccmov19mdHVzjiNokry29YykE6ESeyiVS/UfRswdWMG65H77ns6lCiEAP
         LzFaaBGCW29KWarwPz+UpbQT65R8Wxv0wWoIjRoOJN7u2D4cbylbQoJ4dFkMc53TpS7m
         /q39YAJiooMkkLITTLfkbTXBr8MqRUqWpXhGe98VXCyVz0pwrYBa9XUo3JpexGKAh5IN
         CloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714439075; x=1715043875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmlXHYTP1JU1chg3YaCZTEhfqyjw0+XCv0tIk9SD3Mg=;
        b=Si3ztAIDNjFAKjTe/oB568F8IzJn9U0JQ7HBcjrXDxgtXlc98hL7QmbS9F65xN5ZjT
         CxOgoa5oAe91P0W6Tjxo5YGngq7Q5OEjlpjKycdEhpCOJ74vdDX+7PnYggGXCl0+M5FF
         sFb//NDUbYQ8/iTaGXhybGY8rwKAd8kyaB0+rmr73bETH0mCdlpH84eRmUubxsrGGzTd
         8EaMl31ZRy124n66B1i5v9xFaLVzHyk1luWdwAHs+nJ4Oqw3+bssi6nouBMx2ykDJnFC
         rivw84RHKOZSTULHRu6AphjBOgZV8I1TnnFN3Ii651UFlzmajcThQDrEmx9fCXNFaTjy
         kKzg==
X-Forwarded-Encrypted: i=1; AJvYcCWxTXGFvgCWRHhhUsiySi+1A9NQguBWu1Q6LbGNonWPWMctjyqQ/ujEfG0nghptr4kov2cyI7TRQunneeVrFfFEgZRfprHD8hbU4faI
X-Gm-Message-State: AOJu0Yw9fPEVrF3bdPNoh/XT4ai2BdTcl86wVAEbY01kYZ4Ghlp/amOB
	QWBPByZSjI0iRxb7W6e5IR12XKDiziDx9ClbYwKaCe0kmEgH6z7wi1M22mJPXkrS5BVrxV7xtP/
	QOxI9bDUT1IT5A0vCJeQZK5Lkqfc=
X-Google-Smtp-Source: AGHT+IGrM7nX4xycFTF6rLoZ9A5f96CoTvHTE2HEqPMJ05yvBCkg7o9L/Cb8ibqoN8mRlt/tvkeBzd09DEOm2VGWjzQ=
X-Received: by 2002:a50:bb26:0:b0:572:7089:7f78 with SMTP id
 y35-20020a50bb26000000b0057270897f78mr5396986ede.34.1714439075311; Mon, 29
 Apr 2024 18:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjAWMQCJdrxZkvkB@google.com>
In-Reply-To: <ZjAWMQCJdrxZkvkB@google.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 29 Apr 2024 21:04:23 -0400
Message-ID: <CAKf6xpvzrCHAsbokGu_+7P0H=n4T=dsRN81msJjW6yVMcEZi6g@mail.gmail.com>
Subject: Re: [PATCH v2] Input: try trimming too long modalias strings
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 5:50=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> If an input device declares too many capability bits then modalias
> string for such device may become too long and not fit into uevent
> buffer, resulting in failure of sending said uevent. This, in turn,
> may prevent userspace from recognizing existence of such devices.
>
> This is typically not a concern for real hardware devices as they have
> limited number of keys, but happen with synthetic devices such as
> ones created by xen-kbdfront driver, which creates devices as being
> capable of delivering all possible keys, since it doesn't know what
> keys the backend may produce.
>
> To deal with such devices input core will attempt to trim key data,
> in the hope that the rest of modalias string will fit in the given
> buffer. When trimming key data it will indicate that it is not
> complete by placing "+," sign, resulting in conversions like this:
>
> old: k71,72,73,74,78,7A,7B,7C,7D,8E,9E,A4,AD,E0,E1,E4,F8,174,
> new: k71,72,73,74,78,7A,7B,7C,+,
>
> This should allow existing udev rules continue to work with existing
> devices, and will also allow writing more complex rules that would
> recognize trimmed modalias and check input device characteristics by
> other means (for example by parsing KEY=3D data in uevent or parsing
> input device sysfs attributes).
>
> Note that the driver core may try adding more uevent environment
> variables once input core is done adding its own, so when forming
> modalias we can not use the entire available buffer, so we reduce
> it by somewhat an arbitrary amount (96 bytes).
>
> Reported-by: Jason Andryuk <jandryuk@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Tested-by: Jason Andryuk <jandryuk@gmail.com>

I don't have the gdm setup available to test, but loginctl looks good
showing the Xen Virtual Keyboard assigned to a seat:
# loginctl seat-status seat0
seat0
         Devices:
                  =E2=94=9C=E2=94=80/sys/devices/LNXSYSTM:00/LNXPWRBN:00/in=
put/input0
                  =E2=94=82 input:input0 "Power Button"
                  =E2=94=9C=E2=94=80/sys/devices/LNXSYSTM:00/LNXSLPBN:00/in=
put/input1
                  =E2=94=82 input:input1 "Sleep Button"
                  =E2=94=9C=E2=94=80/sys/devices/platform/i8042/serio0/inpu=
t/input2
                  =E2=94=82 input:input2 "AT Translated Set 2 keyboard"
                  =E2=94=9C=E2=94=80/sys/devices/platform/i8042/serio1/inpu=
t/input4
                  =E2=94=82 input:input4 "ImExPS/2 Generic Explorer Mouse"
                  =E2=94=9C=E2=94=80/sys/devices/virtual/input/input5
                  =E2=94=82 input:input5 "Xen Virtual Keyboard"
                  =E2=94=82 =E2=94=94=E2=94=80/sys/devices/virtual/input/in=
put5/event4
                  =E2=94=82   input:event4
                  =E2=94=94=E2=94=80/sys/devices/virtual/input/input6
                    input:input6 "Xen Virtual Pointer"

Thanks,
Jason

