Return-Path: <linux-kernel+bounces-92349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C7C871EEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACB11F2214D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52B45A4E0;
	Tue,  5 Mar 2024 12:19:59 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A95491A;
	Tue,  5 Mar 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641199; cv=none; b=KhDuQvm/Nvu7WKB65ueSgNmiEUFw90VnAIVDeEnClvBZNz+9YLfP30w2Oh8F/pefzCO35SwKlyYwgkuU36a2ZLosTLf9AcawlZXcqzuKdf+jc3ho+43MUbdEiM4bS0WH0oj9dszjmRNE+f9UoJ4hkgyLawuwnkBAmq/PNvdn7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641199; c=relaxed/simple;
	bh=t7G6/MWaKhUpkJGYR2nv7zyPxCl67C3iIy4Q5igOeyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hk0SpiSZn0lkuNUCUEti8wmdZl1fiiYmKGqma6+mHVThuFb8rNhHeAOpDhvh697t8tg4XIkSUx8/xdGAMM5D6tLLE5J5swlni1FQyxq3MAhK4erqgBXFDMFgsvqvE9AQnepJ0c6h9CbnOJShIOWbs4mJr7VCj5BRr/C1U46Wr0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e4ea48972cso647206a34.0;
        Tue, 05 Mar 2024 04:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641197; x=1710245997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USUd0ct6oWtFiJJKkDLxwnqmJJ4eaIKl5+V8V0LyqG8=;
        b=F9lh8mKUEwDSyCrd3sHkefWNrXIG67tksjkv4OwfuVEEuRBWGrDyKmZSj6AImBa0qk
         Q+nIqOCENudPMJwf+kuyLyPtuhoEJ5AnYInzei1koI/hg64xWIlzLS78me4O43FRqoVN
         LD/lxJcgf/OFy3WYgyQ3XGal6XcVdVJbeW5OO9GhA8SNqnDxQrdusM3Nyn60m7DbuoDL
         edy9WTMrKM1Iwp0vv8rdpu56erkgKfTwXKtJwtXmgX3/XIq8Lcjor6BLuxbSVUlNGGbd
         afsVUnaqsaxZCFDbv96JgpBXzoM7mlxTcsRZfCVFKz+SaPPWcgs3GBreYf0VAekb+yq/
         MLlg==
X-Forwarded-Encrypted: i=1; AJvYcCXu+kncpmG8mRr4WAC7tSZVqlUWWztZ+Njmr+KVsBPEvHwsfArLiNjUaD8O0XHxCAV/sVjpRaDRo2WkXQsCZTQCqCghiSaFiVmuMixhikUwAAQYSOWcnyn8w4Jo3EyBUnP6FFWvY0A=
X-Gm-Message-State: AOJu0YzC6gUpYRasrx42mDkQk2YikqPtygW/1eWq8JsUq62RWJhSkX17
	pNtrHfWnB504P9baIXQQAEuM20CcJNO1Ss8al0+LsOV8AlQk/rx+UGa5aqfqY/yStH8IZV+ghlF
	qgiZ5PQkMLJ4HJI64EYeSBiE0nfA=
X-Google-Smtp-Source: AGHT+IFcXSd1Q4b/7ORXmqWybZddPHIog/msNO6Xl1S/GfqeTG5omlz/dqSzQKJjfBAqNq+eFNVtjb5DgXhaLttYqso=
X-Received: by 2002:a05:6820:1c10:b0:5a1:4b90:19ab with SMTP id
 cl16-20020a0568201c1000b005a14b9019abmr281109oob.0.1709641196934; Tue, 05 Mar
 2024 04:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304110022.2421632-1-f.suligoi@asem.it>
In-Reply-To: <20240304110022.2421632-1-f.suligoi@asem.it>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Mar 2024 13:19:45 +0100
Message-ID: <CAJZ5v0iff7siAAxzp_n4yTb5yzDBwH=iYUi4Zf8s5Cxmvyw+VQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: remove superfluous line in comment
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 12:01=E2=80=AFPM Flavio Suligoi <f.suligoi@asem.it> =
wrote:
>
> The first and the third lines of the comment of function:
>
> thermal_zone_device_set_polling()
>
> belong to the same sentences, so they have to be joined together.
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  drivers/thermal/thermal_core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index f7a7d43809e7..34a31bc72023 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -273,7 +273,6 @@ static int __init thermal_register_governors(void)
>
>  /*
>   * Zone update section: main control loop applied to each zone while mon=
itoring
> - *
>   * in polling mode. The monitoring is done using a workqueue.
>   * Same update may be done on a zone by calling thermal_zone_device_upda=
te().
>   *
> --

Applied as 6.9 material with some edits in the subject and changelog, thank=
s!

