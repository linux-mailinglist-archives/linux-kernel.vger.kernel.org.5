Return-Path: <linux-kernel+bounces-13834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABC2821338
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 09:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6379282704
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F8753AA;
	Mon,  1 Jan 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+WXxqMO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752F4A0C;
	Mon,  1 Jan 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78106c385a1so837251985a.0;
        Mon, 01 Jan 2024 00:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704096139; x=1704700939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rJnDmzlUj/s6A95/HoZSsfVtTM//vdjgKa3suazdZU=;
        b=j+WXxqMOdFTb5plAhN4UXZ3B4xe4OKXuszgp4gXyjMCwkRrrH8l/OcPxlQPP5mooII
         txg/fEJMuSnRwhuowqhTHOOsp3rDY+uxd5FPvz+GTGedXsurweiFI1+NgNpF18e5VHiB
         dN8zueb8eMbgAXS+CmA5ZHrm0eOQrO2tSiWh73I+eMgbezatDECyqsMyFPBoCZOIe62P
         Fh22FD/4XK03k2uFCnHA9nqS6GvARhqQ/beBVwV+A4hPVHsyLFiLT/d/YeXIAlsrgi0/
         OM5mr5q95MVGFtiSn8ORYcxvz/UcLnjoQ2shvIO+8jSP3QXHdGdOm1sS8meMud0M+N+e
         qNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704096139; x=1704700939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rJnDmzlUj/s6A95/HoZSsfVtTM//vdjgKa3suazdZU=;
        b=dmgIbzqHtg4hXvC2sQTtw0u250py39RQajpJxPWWNxAZKQILPqHQr35Ll8h+zPaDro
         /G2PixJf9BSvXEIqdUG8IxksaNZXqtrEAvjXy/v09R2jZWVIL1Ip/h8us+868xagzGgl
         upX+sve1og2rgLS4oUIMIvrvBAr7Ubo8IdmFGx98wOox5pz5QSDM4hd5WsrdQUqz412n
         Vp5kkOEvdxtb33I8ALut9d8SGDyybBqRXocIE1vpfLLFZ9PzDWYMWmNfBQl4yGtUkE4d
         a4rgq4bOAhQFEH58ZTXyrA+tNSGqNKQseYTkCu6mnlCIgXxNugbREbcHkaSpjYE+31Hh
         961A==
X-Gm-Message-State: AOJu0YzxeQbDm5X1Bu7J2/81XKWIzIVeQKgMKKzmkwMOZSn+bRNf8cWo
	mMV0PBHcKvO6OMv3hblDXXwsqOkCG9d4LgpLEqLXy5whsRBykZsq
X-Google-Smtp-Source: AGHT+IGzStSNwCQg7DOE6sSUb75JH7fuWQQZ76dLolrSuMj6vDv3gR6Vt9WDoQ6lpEYdRNE/DRqyPdIsN5IZ1ULw3W0=
X-Received: by 2002:ad4:4ea5:0:b0:680:b224:2e5c with SMTP id
 ed5-20020ad44ea5000000b00680b2242e5cmr2445509qvb.128.1704096139203; Mon, 01
 Jan 2024 00:02:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231050300.122806-1-sergeantsagara@protonmail.com> <20231231050300.122806-3-sergeantsagara@protonmail.com>
In-Reply-To: <20231231050300.122806-3-sergeantsagara@protonmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 1 Jan 2024 19:02:05 +1100
Message-ID: <CAGRGNgWgki7_3e8Zk=kURo4ZxC13DqDM7P96g_o2ptAhUA6nNQ@mail.gmail.com>
Subject: Re: [PATCH wireless v2 2/4] wifi: b43: Stop/wake correct queue in PIO
 Tx path when QoS is disabled
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Kalle Valo <kvalo@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>, 
	=?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>, linux-wireless@vger.kernel.org, 
	b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rahul,

On Sun, Dec 31, 2023 at 4:03=E2=80=AFPM Rahul Rameshbabu
<sergeantsagara@protonmail.com> wrote:
>
> When QoS is disabled, the queue priority value will not map to the correc=
t
> ieee80211 queue since there is only one queue. Stop/wake queue 0 when QoS
> is disabled to prevent trying to stop/wake a non-existent queue and faili=
ng
> to stop/wake the actual queue instantiated.
>
> Fixes: 5100d5ac81b9 ("b43: Add PIO support for PCMCIA devices")
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

LGTM

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

