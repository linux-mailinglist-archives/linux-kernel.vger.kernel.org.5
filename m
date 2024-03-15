Return-Path: <linux-kernel+bounces-104517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A3387CF04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591F428484C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B72A2FE28;
	Fri, 15 Mar 2024 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIn3iE9h"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFDF1C2A6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513305; cv=none; b=kk+RblfMF9ea4ZTA518CzmI54JxIdSh/cTbwNjWQjafNjwLrgL8bRNC94sRcdifPwA1bhpboM+ypcy0waSWm7FlrB+cjwMpECrFqUAlgGrxbDiKTOdGtFyOWhy0KC5uMiKl1MuojOxz/eTYeSOrnZlIyrT+ltNWXPvM8Dj1MozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513305; c=relaxed/simple;
	bh=D+OJRpthu47w/vwvrjl98uCHax3VPg4eeJQbl+Xm4sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRqxQ3Etvnmuof2PJUSU20JdYu3EJREhpbO+a8NVW90soqjj1NRvPjnxdRsI5rVwYuFzNa8JeshFbAIECCKkeJW3eYwkrDUdhCJsOz+Y9+c2A+J88UWPyedzho7/kuRkISrbRrle+Cx6+E+9voj+jEbqvZr2y1wDT66Am1Dmkws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIn3iE9h; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609fb19ae76so23313027b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710513302; x=1711118102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwqyQci+Qv5wQVFizJMySjy8YLel0qJTAAMVU6QGVyo=;
        b=eIn3iE9h3pVODpLy4Lu+C9HHg+/wJjZepXSO9NH+0oL88JfNO719OvtVZ64R4kupvj
         WZ0rRIVxuR5/Bgia9qRLSzwTcUIzl3OEPyluEgGgur3YMl+QfspHgn6rAt3iq9dFmWoj
         kYZWXdtP8ftp7WN5qef8GkWt1XJwFTmkWxdh/+YHad8LqF896CObFI0eqHaJ+PT7urD7
         vsHsC7g0MWOA1xFAvP/9GLdijPw3q85T46Uwnt7HSJFGFx9D6w0uwZ3cYgmkl5V7GUPa
         dpu2yVmUunXD45RhlHatQkz/Rb/NpKdAcp1a2kOxAhT6AZQ0Zv8IOglds3DZZNoozqAv
         Yoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710513302; x=1711118102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwqyQci+Qv5wQVFizJMySjy8YLel0qJTAAMVU6QGVyo=;
        b=b7TVd7pfyAOrk27L5nOHU0vjt+RitQHiE5VUxrWMLZCTf7X5iYWCQ+d+LXy6SC2gMR
         M23vFnz5qOCHu4yH192pYpmEtCyb161HeaD/Hpi7nFZMqtOZucXzsVDcEztANoa1wwnF
         Nx1AtWkkt6UOeQdmC8VI4JcAgeqf9alICggLU6JpcEfGKFHiT2tmNTRkDPF13uTFbYZy
         DQgS9hLiVT9tcYRZJ7yn90Il5zIYwzotht+x9h9xxc15v3Kz12elPVJG8VF07B0vTJV7
         xlkkVdxk2EhnYIy6l+kIuBaoAgvSnRdT1ZTVZpx/L9dP9ID+Ge7lbNa4BlHzQUqmn/9r
         drgQ==
X-Gm-Message-State: AOJu0YxFadc+gDJ2CXAQovMelPQmO8kS8GZVh07if7AyHbXUngd//OqW
	yW6ofxEnbD87yQVqyV5wGXDGCVQFXT7CiCcDe92n7xvvLZi7Q5tGOgeQiuqVVJ6YLfVoGyDKl68
	eOBK3CJIm7Dac6oX8zih81ca404fRNh3V
X-Google-Smtp-Source: AGHT+IEpGNdGpcpKcc0vYWAjYe97nIyH66VlxPZLHExVRcsuL1X5kLKlrcivmUv1o+UzZ+DVFxD6y01ladoDj+KPplg=
X-Received: by 2002:a81:df10:0:b0:60a:243:547c with SMTP id
 c16-20020a81df10000000b0060a0243547cmr3842987ywn.44.1710513302494; Fri, 15
 Mar 2024 07:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315140433.1966543-1-hjl.tools@gmail.com> <5f0620c55a01d6a195154783a477ec295cbb4b1c.camel@intel.com>
In-Reply-To: <5f0620c55a01d6a195154783a477ec295cbb4b1c.camel@intel.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Fri, 15 Mar 2024 07:34:26 -0700
Message-ID: <CAMe9rOrgAtQvA=Tj0=T095JmdoRZ8pLuNOY3sT_RwwnznJN2Ow@mail.gmail.com>
Subject: Re: [PATCH] x86/shstk: Enable shadow stack for x32
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 7:20=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2024-03-15 at 07:04 -0700, H.J. Lu wrote:
> > 1. Add shadow stack support to x32 signal.
> > 2. Use the 64-bit map_shadow_stack syscall for x32.
> > 3. Set up shadow stack for x32.
> >
> > Tested with shadow stack enabled x32 glibc on Intel Tiger Lake.
> >
> > Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>
> > Tested-by: H.J. Lu <hjl.tools@gmail.com>
> > Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
>
> How many people do you think will use this?
>
> I would have thought it would require more changes for basic x32

This is all needed.

> operation. What was the testing exactly?

I configured x32 glibc with --enable-cet, build glibc and
run all glibc tests with shadow stack enabled.  There are
no regressions.  I verified that shadow stack is enabled
via /proc/pid/status.

--=20
H.J.

