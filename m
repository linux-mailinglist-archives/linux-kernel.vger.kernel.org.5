Return-Path: <linux-kernel+bounces-157205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A039A8B0E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4DD28AA79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B380916C6AD;
	Wed, 24 Apr 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NcyXqTRX"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5B16ABCD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972699; cv=none; b=g7oPYY+szYYL6Zp4ibry/R01nAEK+gU220gade9DjlI60aptD+TRG8FnwKbpTjxscLNmkCR+M+GhsHivfFBKmRmubM5hCabo11nBYjcxhcD5VaHg4Hfrs7OMSDc6xMKadq6+WjV34igP7cD8mL3GagwGvqNVbjNUofXguxfkYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972699; c=relaxed/simple;
	bh=2dqCM/xCTD7FcNV/KZwKBJW+6IbT5B/PeUeIw5FT9GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8R+SyPlPQGKv6+Rl6L0uvPjEys5MUpKzybkI7tBWQmliIdvhyOnLIzE7Jx1seHJUzHwutgZzF7mSZ2mTbFSB4v/xUSuYZ9aZuGuFZH3qBUs59gKBYr6kPgU6vsUOHzft6ZvCtWzDlDCO/flpxFgCv+dWQJBUKoNwh5Jx1Fv4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NcyXqTRX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518931f8d23so7659465e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713972696; x=1714577496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pXfD8B337N7EHi0wfzwHaL89O2gJmXL/tsSWnKMJV4=;
        b=NcyXqTRXi9RIkoUmcBnTcA10IagyjHDz+yX012Irc57cGECCABuTGjcRQOGg1mb5dc
         /rCWoisvubPaUD6mOioqXGZTQWY215f2bWiVEpkz/bpwgTzVFDAUAJCk8JprXxQ2nJJa
         16n2S4ZwCpe95htxUyQijy8HwdOgU/xb7no1S4e46lUaHxVxOQtNIdS6eYw4OfBM7Oox
         TicYI6R7KGcGVP1B724V/LyqrrsCH2FOwpES9M0Dmua5YpolDCmBvG0eR8vob2ACsoBA
         N4hmPUu2hUqE5S6vsVsHh0+zPpgZnqJWyI45WYHd1qUlo2AXWZMUnHy4WSq0gjxTXC1h
         Qhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713972696; x=1714577496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pXfD8B337N7EHi0wfzwHaL89O2gJmXL/tsSWnKMJV4=;
        b=ooDMjEK8gR6XEXVNLiRAEyCs3J9mtEmJlfSK5HBqRimw8WjcReQ0WJwKuWeN5SytVO
         QC729kA42Hni6gokUEOCTmDKwjlLfBrAuad4x94qPRH8ejBZ9MdxHkVglD0FjdBQjC+o
         R4rcT07/cgNOmWJMkz9h/wqO5rXOqNqefyxodu4LpLdkbN/osoRK41+I+diFzDY3FGO2
         88s/Lwt7LgXmwAldSBc9qV5LzI2fOe61wKSwXrFSEwewYzjYRUkLSd/JsUCKRHhzgL4J
         54NhLsvaYaRNoUVMTEoAFBCTgw4i7dsmQtoF9AtTgaH2LozZsaruKeTgHu7XGGorOk88
         wGyw==
X-Forwarded-Encrypted: i=1; AJvYcCWBkN11eMOkG+4OYfz816w7XT5VopebunI56dKifLA5QQ+SosL2s96rPCD7Mb7kbT/N8NxvbO/w8dICpw0+dL+yUJ3dUAGUWx/nK02G
X-Gm-Message-State: AOJu0YwE+CZx5enUlvw+7yX9NX2wdZqZEKWFFd9QTsvNyc0zqu47s3sl
	uqf8lBa/9b9pF45k03PSDfTybXTQsHohyItrPkSZ5ZoRqqLWdC9TK2JoOSt7rNJqbRzStdkdP9Z
	RfsWgsm4Ua65Hn1lUy4OZnHqwBc3QSOnGmIXHhA==
X-Google-Smtp-Source: AGHT+IFDhZCdERcU/y9xRR2D5CtIUm3fbtyvENsRdmp4bxWNgSa90oIHrXp3ea6H68oHXmxyV9q+ePSSkgPM/31+I8M=
X-Received: by 2002:a19:e01a:0:b0:51a:a400:785e with SMTP id
 x26-20020a19e01a000000b0051aa400785emr2198475lfg.43.1713972695700; Wed, 24
 Apr 2024 08:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122932.79120-1-brgl@bgdev.pl> <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
 <CACMJSeuBCkNyaD60qGVpAq91DqD_OA=tCVEY0t+JNK2vcWBc+Q@mail.gmail.com>
 <d82c2e39-d2b8-4de0-a11a-6ab2420f8f95@quicinc.com> <f4bffd0e-0d9b-4fb9-926e-c75a20c92b50@quicinc.com>
In-Reply-To: <f4bffd0e-0d9b-4fb9-926e-c75a20c92b50@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Apr 2024 17:31:24 +0200
Message-ID: <CAMRc=MfqKsRqKck5Wb052zuUURxqRykjbu+c3K9oFPMHaHuiJA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wren Turkal <wt@penguintechs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 5:30=E2=80=AFPM quic_zijuhu <quic_zijuhu@quicinc.co=
m> wrote:
>
> On 4/24/2024 11:24 PM, quic_zijuhu wrote:
> > On 4/24/2024 10:52 PM, Bartosz Golaszewski wrote:
> >> On Wed, 24 Apr 2024 at 16:46, Krzysztof Kozlowski
> >> <krzysztof.kozlowski@linaro.org> wrote:
> >>>
> >>> On 24/04/2024 14:29, Bartosz Golaszewski wrote:
> >>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>>
> >>>
> >>>>               qcadev->susclk =3D devm_clk_get_optional(&serdev->dev,=
 NULL);
> >>>>               if (IS_ERR(qcadev->susclk)) {
> >>>> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_de=
vice *serdev)
> >>>>               qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev=
, "enable",
> >>>>                                              GPIOD_OUT_LOW);
> >>>>               if (IS_ERR(qcadev->bt_en)) {
> >>>> -                     dev_warn(&serdev->dev, "failed to acquire enab=
le gpio\n");
> >>>> -                     power_ctrl_enabled =3D false;
> >>>> +                     dev_err(&serdev->dev, "failed to acquire enabl=
e gpio\n");
> >>>> +                     return PTR_ERR(qcadev->bt_en);
> > please think about for QCA2066. if it is returned from here.  BT will
> > not working at all.  if you don't return here. i will be working fine
> > for every BT functionality.
> sorry, correct a type error, it is QCA6390 not QCA2066.

Doesn't matter. If enable-gpios is not there, gpiod_get_optional()
will return NULL and we will not return.

Bart

> > NAK again by me.
> >
> >>>>               }
> >>>>
> >>>> +             if (!qcadev->bt_en)
> >>>> +                     power_ctrl_enabled =3D false;
> >>>
> >>> This looks duplicated - you already have such check earlier.
> >>>
> >>
> >> It's under a different switch case!
> >>
> >> Bartosz
> >
> >
>

