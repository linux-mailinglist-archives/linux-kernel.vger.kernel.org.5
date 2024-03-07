Return-Path: <linux-kernel+bounces-95556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E34874F6B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCB91C2376D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783A912BEB1;
	Thu,  7 Mar 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSosD+AY"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C402AD17;
	Thu,  7 Mar 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815811; cv=none; b=rSQqtyIhPf8k6/pL3ue799umuTYdTBaw3j4qgSXCyWaeY/f5xY5BTx+wkVSL/irgJQPkg6knMDbZMPM3l1kD9vYGI4dfh/UgVKQsUINsXpK0ACB9yoiWt3AOv4/zGrbWKtHHl4P7mEEOodWQLtYmZmZlndelCZLwS9keDd6ATTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815811; c=relaxed/simple;
	bh=P1ANr6WZoM+rU9Iqi1I71/cCCVASl1XhewCDlvQP138=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7dtInDb7m9Gv6QxReMwoUbeOjfRWl1OYyRYEeYxs05LlLIHOOV91aQ6XDA7wToml+s0iZvDZ7bKSVwno0hzjh51nc2cHiX7MtjMMW6nMgYa00E2eAywOeTIOrdIC42+pQOnNj8GAAcfz0CncTIBJ5LSlpJrkl7JB5arRw185l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSosD+AY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a45b6fcd5e8so111269366b.1;
        Thu, 07 Mar 2024 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709815808; x=1710420608; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P1ANr6WZoM+rU9Iqi1I71/cCCVASl1XhewCDlvQP138=;
        b=FSosD+AYwArtN40L5lPrhfLpvSrlf1qRRJ9mzmohSTwBxVk6JADkX9/4FQxyBGj4+e
         TUEF2E1OLu/q9tAtM9ALUYTN93zdPIeGiVVDB/NgQyFE9rtfaCfbmQJbFgSGmE1ZA+eI
         hN7L+t4CMtEhfc4DwCm1xuFTSYZyd6BZ526mqETw1hhRVokcmnbUgkYT9040lmOovl4P
         uXP2Mv1fXTYxUsM2goUzBZex73q+p0vZI4zaw70QzPQu/8YqVYe1FLfX0OCUctYP2H4L
         clbPPXZfNJ9ibRGIcPRoPUtGwvvnNXQbJOtj8AxM+QrJIp409vck4Jjew6LNHlbBDfJC
         lvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709815808; x=1710420608;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1ANr6WZoM+rU9Iqi1I71/cCCVASl1XhewCDlvQP138=;
        b=Vbv5ZVfnjljC9f9D9G08oEYDbmySK3ctU3dX71E+VIxj0AH2KpiO80V9wmrPQWw4NS
         xxFRrtSjn6jAZyyI45mqY9auWnW9J3jSGAlICefoTrWBK4pSZOZoc4y3uvYamq9CLpfb
         VdT+kVHANtE71CJjcN4am0jNTddYcwOjtQ//S4PKSW7SsxzYXhzXTYRZZj+YEwNEbLys
         xn8Pg7SePNINZbfdWcefeLxTHJgFVYfSnBnQDA2tjaDIdELwRIg0m8Sfx4xZTpod1C98
         OUEeiKKlcWFshwHMBeg76vDTgvT5hnF+CTyLWQu7Xnir5eny9Z9N2RUhY8+Wx8oGu7r8
         c+cA==
X-Forwarded-Encrypted: i=1; AJvYcCUWj7osqc0V1XmneICFsA6Wh+/KQ5hPpVK3oGTWfAyKKY/3roKqQT/nOAFurrErR0R5FQOi4MjWkQdMyf5DcL5IreSV+zrhhNMGfGSJKYMtYNTTNkmlCtgD82j6CCJsYcXSOzzqptnJWA==
X-Gm-Message-State: AOJu0YxhhV78yoZb93wxk4NTjXr23r7HqzR39i8A4f4UWtZhrm3jBqG1
	hiTrEdc2EOIHp773hWndnC3YMDq0pK/vECJIIxfmRUDejYv3wuA7
X-Google-Smtp-Source: AGHT+IG9ZVxbwyRUEJbKjydiMKrvS4cfisnOt/lKjep9dUtwykGrPVXC4KkE+9YhHMnF3V2pXxeLSw==
X-Received: by 2002:a17:906:6954:b0:a45:8f10:50c6 with SMTP id c20-20020a170906695400b00a458f1050c6mr6309296ejs.57.1709815808292;
        Thu, 07 Mar 2024 04:50:08 -0800 (PST)
Received: from [10.176.235.119] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id k13-20020a1709067acd00b00a44f3fb4f07sm5708077ejo.191.2024.03.07.04.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:50:07 -0800 (PST)
Message-ID: <0bd1df398ab552931b854934ba15d98fa9400a34.camel@gmail.com>
Subject: Re: [PATCH v2 3/4] scsi: ufs: Re-use compose_dev_cmd
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <avri.altman@wdc.com>, "James E . J . Bottomley"
 <jejb@linux.vnet.ibm.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 Mar 2024 13:50:06 +0100
In-Reply-To: <20240305210051.10847-4-avri.altman@wdc.com>
References: <20240305210051.10847-1-avri.altman@wdc.com>
	 <20240305210051.10847-4-avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 23:00 +0200, Avri Altman wrote:
> Move out some of the dev_cmd initializations so it can be used
> elsewhere.
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Reviewed-by: Bean Huo <beanhuo@micron.com>

