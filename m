Return-Path: <linux-kernel+bounces-22188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEEA829AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0313B1F25DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41494482FE;
	Wed, 10 Jan 2024 12:49:56 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C51482E4;
	Wed, 10 Jan 2024 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-598a2136259so44221eaf.1;
        Wed, 10 Jan 2024 04:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704890993; x=1705495793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbBz5SSqpLsC3Oz7qcffbBzeLsEQlLQDj8J0KmYAFR0=;
        b=kLAS2qz/6pFoZCcCvBnTrpWFDTC3y/ys2ZAGAlilCh/WBkX+80qiU8/9rq03ARvPUu
         6gZURV6v8Pdc5Wnu2Qgk8PZBzcbFri1CgtDXIeqCFJjtH71cz6mo5S8rZagTm6oV1KPl
         kIY1nefq+38pGiaq+LiVMnzTmfPgskwPLXsqGLZMXKvAtrI89yFdMMdt2OzFZbZnVuzm
         vPWsdceEpwN89zlRrc9UbezyduQ2/200FdTXfp3NFSHlA53odfDVBvS0JgjPM6YIVb7D
         XavpMWmc7sgXLzHEKzG/TriiDeNu/HtW/FVYbB7s8+ClGZIJuQzoFNwJdvKqqCkovNic
         d8OQ==
X-Gm-Message-State: AOJu0Yxs1OzrR2XbsMDwx9Hwn2y2aZcf+77QbvNP55AzXDzzeurx4r3X
	5LbO6FPwA03Pz9uxNicRIjombVkzeFKgYtkIvis=
X-Google-Smtp-Source: AGHT+IF2xnditctp35zvn9RWugIkWYfcW/RhSsOY5v+PZOvVVQvVwHaMsyG1L9tKmINzD3i9hlXj1M0awncGJW1O6VM=
X-Received: by 2002:a05:6820:80d:b0:598:81b7:4d25 with SMTP id
 bg13-20020a056820080d00b0059881b74d25mr2123776oob.1.1704890993641; Wed, 10
 Jan 2024 04:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106191502.29126-1-quic_manafm@quicinc.com>
 <CAJZ5v0gE6eEpALrfxHvCd5TRqjB+v8pffG4CKLTVXiSvuiWhHg@mail.gmail.com> <90c0a34a-2640-d6b7-0eb3-19fe789d2998@quicinc.com>
In-Reply-To: <90c0a34a-2640-d6b7-0eb3-19fe789d2998@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jan 2024 13:49:41 +0100
Message-ID: <CAJZ5v0hmv_KKPODjzxFuvs=4qvr5-BNh-HCxzHyokT+rw4y9_Q@mail.gmail.com>
Subject: Re: [PATCH] thermal/sysfs: Always enable hysteresis write support
To: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:48=E2=80=AFPM Manaf Meethalavalappu Pallikunhi
<quic_manafm@quicinc.com> wrote:
>
> Resending to reflect to format
>
> Hi Rafael,
>
> On 1/9/2024 7:12 PM, Rafael J. Wysocki wrote:
> > On Sat, Jan 6, 2024 at 8:16=E2=80=AFPM Manaf Meethalavalappu Pallikunhi
> > <quic_manafm@quicinc.com> wrote:
> >> The commit 2e38a2a981b2("thermal/core: Add a generic
> >> thermal_zone_set_trip() function") adds the support to update
> >> trip hysteresis even if set_trip_hyst() operation is not defined.
> >> But during hysteresis attribute creation, if this operation is
> >> defined then only it enables hysteresis write access. It leads
> >> to a case where hysteresis sysfs will be read only for a thermal
> >> zone when its set_trip_hyst() operation is not defined.
> I think it is regression after recent re-work.  If  a sensor  is
> registered witht thermal framework via thermal_of,  sensor driver
> doesn't need to  know the trip configuration and nothing to do with
> set_trip_hyst() in driver. Without this change, if  a sensor needs to be
> monitored from userspace(trip/hysteresis), it is enforcing sensor driver
> to add  dummy set_trip_hyst() operation. Correct me otherwise.
> > Which is by design.
> >
> > For some thermal zone types (eg. acpi), updating trip hysteresis via
> > sysfs might lead to incorrect behavior.
>
> To address this, is it okay to guard hysteresis write permission under
> CONFIG_THERMAL_WRITABLE_TRIPS flag ?

I've already sent a reply to the original message.

