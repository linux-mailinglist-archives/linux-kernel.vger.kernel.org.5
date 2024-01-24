Return-Path: <linux-kernel+bounces-37735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB383B49B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2421F1F242C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFA1135A51;
	Wed, 24 Jan 2024 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWRlVUz6"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B6135A41;
	Wed, 24 Jan 2024 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135078; cv=none; b=E1T23ME4j8BOJWUsOl78E9mM1orR/aylYxlhuKeEGjddJ/uNu7234OY9oH3aTuaPSbD206fT7CzWbJ24GrTUP+5OT+DiW0Vc5LpdLBBMxUKAcmn8zi6rSUsU+TS98Ttn+rXjiccxleg1mTORnVkuGoA8EMH7ajVZ0/CGMwIHops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135078; c=relaxed/simple;
	bh=6aFoet48IEnWBwMN0oFvWdhYR1O5XItpGbgY5wNmtlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVIEHUEPDd66wOx5bhnZ44RxdXSfXa8ZI18t/pY0N5I2lSk8lEipCMSGVI2GNBed+3IbqON17gIwrKEaWJItxeTEwm+9vu4HMP/c2p/wPcIqoK/BF3VDqiFG0WPfqGCECMHxDm3FbSb5P28u/fVWB0bcNt2z/D13D4cZWdy+Bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWRlVUz6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a271a28aeb4so653680266b.2;
        Wed, 24 Jan 2024 14:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706135075; x=1706739875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsxxqHwtyuN+pDO2NqY66GmiknEtFe2BpKT5Y2BjYXY=;
        b=TWRlVUz6+DZhWF74tDNxHOx52164EgmVWnOmXVwTi13zW2Ive1SFbnquzeEgK03hv4
         8VOCWZ59W+yCFGjtSOJecPKM2VMgU6ou1ob8Ia/mtkpNTNeNGhy2gTSCd/niiTDNYvTr
         g/kPy4nGvB49VI/eWrHcpeDXtsZX7hUyg4hWGqECe5os5KBICN3c8EAbZvt9kUfOTa6K
         WTcB5eBHYrTiTW0ytq8iSoaRm77izPKLPXD7Ng7YeiTzue2qD96UnUq33pGf38jEZ9aL
         KitBKyVCJLM93uLULFZDwCUERuJSTSxY7sWT6IwmPty4ICML4W0l2urwt6Q8TLxZwPjy
         RFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706135075; x=1706739875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsxxqHwtyuN+pDO2NqY66GmiknEtFe2BpKT5Y2BjYXY=;
        b=n+ciaEG/4ctK3eMqbfhrOwQCxvuZymKLnT3P7/xJlK2r5Ur+mVSS4Wr/F/YL1xnoiF
         rtCXLNr6UK1G5DsIE85cfmyLxeXrlNPxBMsZWbQKfCBGIBMVDdmhgCXtB6R0o8BUV70K
         rhZTrVZ+sccfJqq4WE/QdAc5SzX8GvLxyuHSs8L/l0mN17JrdbCBtAWkHJHtjryASnDi
         Q1l1RstK6gskEiIqyljXHdKDS1QhZLRLLtUgeMD3k2Z0BpO2VIg9fghNwKDS28SxgEZ5
         Yo8DHeRLwxkUIjnKX5jBhV7GAid0duJ7ZWmc2Nj5vWySghw4e+4zJVzBp0LC/oMVudqh
         zbYw==
X-Gm-Message-State: AOJu0YzSg2qPzQYTCJvtTXaYAbU9/oPGM2hvCEF06XWA7hiJ7vLVIaqR
	KAXkMEXXXbeoEjCmGcJrt5ae0LHtmj4R6Jooy5Uuk6RUjftPDqOViqJeRe2nb3Qr5aHa2XIyBoP
	qSLClHfpBx6TB3iO30InZIlyfcdQ=
X-Google-Smtp-Source: AGHT+IG6kTMS24ukkyWs3GfHfagkvUoflx+1XQepoXScIKL1r/dk58wW+DsGtxCF5L4aN9JvPLqwxB5264iXYnp212M=
X-Received: by 2002:a17:907:8747:b0:a31:ce3:6ca1 with SMTP id
 qo7-20020a170907874700b00a310ce36ca1mr1056927ejc.95.1706135074605; Wed, 24
 Jan 2024 14:24:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115144538.12018-1-max@enpas.org> <nycvar.YFH.7.76.2401231047140.29548@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2401231047140.29548@cbobk.fhfr.pm>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Wed, 24 Jan 2024 14:24:22 -0800
Message-ID: <CAEc3jaATA-Z86jh=njR6yctguQBRp1BQEFcBQhYT0rYKcA4f2w@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] HID: playstation: DS4: LED bugfix, third-party
 gamepad support
To: Jiri Kosina <jikos@kernel.org>
Cc: Max Staudt <max@enpas.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 1:51=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Mon, 15 Jan 2024, Max Staudt wrote:
>
> > Dear hid-playstation maintainers,
> >
> > Could you please have a look at the enclosed patches for the DualShock =
4
> > driver in hid-playstation, and upstream them if possible?
> >
> > There is one bugfix, and a few small patches to enable third-party
> > controllers. They sometimes don't implement features that they
> > semantically "don't need", but which currently trip the driver.
> >
> > For example, for the DualShock 4, we don't actually need to know the
> > firmware version in order to work with the gamepad - unlike with the
> > DualSense, which has different driver logic depending on the version.
> >
> > Finally, there are two patches to add a DS4 compatible controller with
> > an unassigned VID/PID - I'd appreciate your thoughts on that.
> >
> > If I can make it easier to upstream these patches, please let me know.
> >
> > Thanks!
> >
> > Max
> >
> > Patches in this series:
> >   [PATCH v1 1/7] HID: playstation: DS4: Fix LED blinking
> >   [PATCH v1 2/7] HID: playstation: DS4: Don't fail on MAC address
> >   [PATCH v1 3/7] HID: playstation: DS4: Don't fail on FW/HW version
> >   [PATCH v1 4/7] HID: playstation: DS4: Don't fail on calibration data
> >   [PATCH v1 5/7] HID: playstation: DS4: Parse minimal report 0x01
> >   [PATCH v1 6/7] HID: playstation: Simplify device type ID
> >   [PATCH v1 7/7] HID: playstation: DS4: Add VID/PID for SZ-MYPOWER
>
> Roderick, any word on this series, please?
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
>

Sorry for the late reply. I had glanced over them, but didn't have an
opportunity for a detailed review yet.

I will have some input (there was a goto I remember not being needed).
My general fear is a balance between supporting clone devices vs
reliability. This driver is heavily used in devices (phones, tablets,
TVs, cars). There have been bug reports in the past and just getting
the fixes downstream takes a lot of time (e.g. Android devices).

One of the key things I really would like to see enhanced are the unit
tests (hid-tools / kernel side now). To really make sure we emulate
behavior of these other devices well. The tricky part is that they
don't always support all the HID requests of the real device (which is
weird as the game console does use those HID reports and others and I
don't know how it would have worked there).

That's in general the key feedback about the tests. A question for
Max: do you have access to all the devices being added?

Thanks,
Roderick

