Return-Path: <linux-kernel+bounces-22184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A9D829A98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B37A1C25912
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329CF482FA;
	Wed, 10 Jan 2024 12:49:02 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76760481BB;
	Wed, 10 Jan 2024 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ddf73f0799so114026a34.1;
        Wed, 10 Jan 2024 04:49:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704890939; x=1705495739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7wdR/Eyk4uZr26rU209ZZ1Q0iKlXSFwBwzNCr/1V7s=;
        b=YnxaX9gnXkVxz7pPvXCzGjhIFfnyNEaGErYNbDhUa9d7/uTucN/nleC9GU5NPt+9jv
         cUtkDYkDH+EbBdibXNxAq6LOgs2ulQqb71ne6ovYbjoV8RytgmojiZecBY31hl/Qibyu
         FPQD+rhxEiZnmDqxQaIk45jRmhQiL0kH2GzG0LK1rs4UK7EFcLhpl+8BBssHLxISF1rZ
         lIytbR2L1zMDshEQI4VhZwDizur7zmrqEn3J/OSIocz/hlU3+hF2E3qa/KwLjDp48ZF8
         0Z3Ql+5xeyZHKKomHR8N1SQhYQU2l4KLpdV9E9xrm+JSJ5fH51YVzi3Y+PJddcHVcndp
         MN+A==
X-Gm-Message-State: AOJu0YzL6P7o0JPxibg8Fi5H3sRhPTHW9glWDBI6KuC6f0Tb2QI4iZCk
	Ks0vO5WuzWTsvVHT20HumvBr/Ym2Q3rIMCIQ5u0=
X-Google-Smtp-Source: AGHT+IF0IOWk05Q5ngkC2ZGOhj+GKS4NW7UmshCWEOYCffNKsK5wjkmkscmprDJBqxda1cmk5+zf1oPzBh2QV59oiT0=
X-Received: by 2002:a4a:e1b5:0:b0:598:76c6:7085 with SMTP id
 21-20020a4ae1b5000000b0059876c67085mr1827065ooy.1.1704890939515; Wed, 10 Jan
 2024 04:48:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106191502.29126-1-quic_manafm@quicinc.com>
 <CAJZ5v0gE6eEpALrfxHvCd5TRqjB+v8pffG4CKLTVXiSvuiWhHg@mail.gmail.com> <d7b82fc8-0ed8-80b8-9eb8-c77f9277178f@quicinc.com>
In-Reply-To: <d7b82fc8-0ed8-80b8-9eb8-c77f9277178f@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jan 2024 13:48:47 +0100
Message-ID: <CAJZ5v0g4hnRqRCseRnTjfEF+-2=ZT8U9=2m9FODqh3G8eDd=Sw@mail.gmail.com>
Subject: Re: [PATCH] thermal/sysfs: Always enable hysteresis write support
To: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manaf,

On Wed, Jan 10, 2024 at 9:17=E2=80=AFAM Manaf Meethalavalappu Pallikunhi
<quic_manafm@quicinc.com> wrote:
>
> Hi Rafael,
>
> On 1/9/2024 7:12 PM, Rafael J. Wysocki wrote:
>
> On Sat, Jan 6, 2024 at 8:16=E2=80=AFPM Manaf Meethalavalappu Pallikunhi
> <quic_manafm@quicinc.com> wrote:
>
> The commit 2e38a2a981b2("thermal/core: Add a generic
> thermal_zone_set_trip() function") adds the support to update
> trip hysteresis even if set_trip_hyst() operation is not defined.
> But during hysteresis attribute creation, if this operation is
> defined then only it enables hysteresis write access. It leads
> to a case where hysteresis sysfs will be read only for a thermal
> zone when its set_trip_hyst() operation is not defined.
>
> Which is by design.
>
> I think it is regression after recent re-work. If a sensor is registered =
with thermal framework via thermal_of,
>
> sensor driver doesn't need to know the trip configuration and nothing to =
do with set_trip_hyst() in driver.
>
> Without this change, if a sensor needs to be monitored from userspace(tri=
p/hysteresis),

What exactly do you mean by "monitored" here?

> it is enforcing sensor driver to add  dummy set_trip_hyst() operation. Co=
rrect me otherwise

With the current design, whether or not trip properties can be updated
by user space is a thermal zone property expressed by the presence of
the set_trip_* operations, so yes, whoever registers the thermal zone
needs to provide those so that user space can update the trip
properties.

> For some thermal zone types (eg. acpi), updating trip hysteresis via
> sysfs might lead to incorrect behavior.
>
> To address this issue, is it okay to  guard  hysteresis write permission =
under CONFIG_THERMAL_WRITABLE_TRIPS defconfig ?

Not really, because it would affect all of the thermal zones then.

TBH, the exact scenario in which user space needs to update trip
hysteresis is not particularly clear to me, so can you provide some
more details, please?

Thanks!

