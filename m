Return-Path: <linux-kernel+bounces-11442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDD881E66E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351AB282D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B7D4CE1C;
	Tue, 26 Dec 2023 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sq9yM59e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3DE1096F;
	Tue, 26 Dec 2023 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2358a75b69so737023266b.1;
        Tue, 26 Dec 2023 01:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703583384; x=1704188184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yERtguE0Vl3cpYZcE+wHqk9HF/THyUQ0hqDgNB7OQnc=;
        b=Sq9yM59epvzRw7jKCQEf26oq42D1JsH+Y1ZuiZqKxesQutqaJooRDpDMMd/9ipxYYv
         OAdq3QYh4npTruXJerxeg5cnXVJHTk5i1iN9/V5l53tZPo8i5x7DoC+duRGSVftO7jLq
         jZRhjGnRNXPps0mYyLLgBda3wfDxjvqcW/h7jkn/136db9VGN5OAR7Oixx/tS665WVIa
         /lO38DwbKcbipDPOXZREEYuD3U2r56l8WaSx8YYruwhtbKY4cPx+9JqTzxnnLrmpEq08
         /56c0b0XSCaVOketho8ZG/IeAyzGRA7BIOrjeeFTzGgeWqZVOEF1seMEmzj0aJgSp+jz
         kHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703583384; x=1704188184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yERtguE0Vl3cpYZcE+wHqk9HF/THyUQ0hqDgNB7OQnc=;
        b=HiMCvjqBV9vFODJtMCkvSOuzQxEtUgz4f3X7EYalQhogE647nE1mSK5DidHdWJ5eoJ
         hOD+zwFTVJU51YYXw4fgdED+Zdnlktd+JqNQJhEoB5yYmD0AVo+AZWbwAAshF+wg5LnL
         ITDV5gcrWKlf/nA9vjW36GnhTTNNz8wVMwXi7w3RzXTp3vpauMaI6P8FHhTYNC3zw/wp
         X/ihzbEC08eZ7VuztEKRZlgBhUuFTOPvU9i77MBB0YQIaEgrbqngAoSnoBFyykNR2Dzu
         5cDy0xLgLidqeSHmSAKnQ6Pa5UE2lAvBl9zJ6/72ulG4AdGAfSEoX1BFCbOEc0XXYoOe
         mtPg==
X-Gm-Message-State: AOJu0YzSm0Q3mkgA8wEWNcOqEDST0j5zSCvVyzXhQW8JpyTd5frwT9Dn
	cXFX3auWT9FdX5CkeK+YFnUA2t4LOv5oUVYzxPw=
X-Google-Smtp-Source: AGHT+IFtySpHSRkwhkeCnLDAx2gCPZQArIEB+8RuXuVh2D+mS3FCB9KrdNHwRxqBUK2Bq7Pjazqmh4J+81d4lHJ2eSk=
X-Received: by 2002:a17:906:57c1:b0:a23:54aa:311b with SMTP id
 u1-20020a17090657c100b00a2354aa311bmr7499942ejr.34.1703583384105; Tue, 26 Dec
 2023 01:36:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2312121445510.24250@cbobk.fhfr.pm>
 <3a29c0a6-9b53-433d-a83d-5b68a87c1155@mailbox.org> <CAMMabwPd-m7a+EQV7zb=wU52=P1FkqFU1dg9=gyvaS1EP5tX3Q@mail.gmail.com>
 <d13694c9-4409-4566-919b-7a577afd583c@mailbox.org>
In-Reply-To: <d13694c9-4409-4566-919b-7a577afd583c@mailbox.org>
From: Yauhen Kharuzhy <jekhor@gmail.com>
Date: Tue, 26 Dec 2023 12:36:05 +0300
Message-ID: <CAKWEGV4DQRBLBrYXMvUp1aHP3bBS+WSPh0yCNZJM-58jKwtrMA@mail.gmail.com>
Subject: Re: [PATCH] HID: lenovo: Restrict detection of patched firmware only
 to USB cptkbd
To: "Uli v. d. Ohe" <u-v@mailbox.org>
Cc: Mikhail Khvoinitsky <me@khvoinitsky.org>, jkosina@suse.com, benjamin.tissoires@redhat.com, 
	iam@valdikss.org.ru, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=81, 24 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 18:51, Uli=
 v. d. Ohe <u-v@mailbox.org>:
>
> > So this means that the only reliable way is to add a sysfs parameter.
> > I'll send a patch.
>
> Thank you for the quick action!
>
> Perhaps it would be possible to modify the firmware further in order to
> facilitate reliable detection of this modified firmware? But for now the
> solution with a sysfs parameter (and defaulting to the workaround) seems
> good.
Unfortunately no, the firmware is closed-source and was patched in
binary form AFAIR (by replacing 1-2 instructions). Moreover, it cannot
be updated in the wireless version of the keyboard (ThinkPad Compact
Keyboard II).
>
> Best regards,
> Uli



--=20
Yauhen Kharuzhy

