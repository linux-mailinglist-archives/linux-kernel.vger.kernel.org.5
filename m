Return-Path: <linux-kernel+bounces-127621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0F9894E7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA1C284853
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169E057873;
	Tue,  2 Apr 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKmj4fwj"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9D1E525
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049517; cv=none; b=emVH8cBFU+TLwn87W2tJtQBjK36na6HEfvCTGwBOrV5PBZZmU9oMkawzEQ2qb9niiMUE9LWmCUJ7ScbOcDmTFiyd6tDDfRjGwqisDAK1x1f4Io7KOZb0CcCHayhN9M8ng77ROUh7hFp4XYWfdaQDRHPk8kJAXDR+uqNV8PeFA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049517; c=relaxed/simple;
	bh=o/P8asTQgXNr+LtSR/rVKgTHlr8EJ1cZ5yL0HTpm700=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kg4fxCbTpgvpdP1a0MxAlInZnZtRtsrQjLVwRpZOhbU5RkVeWsIhBI7DDTmCgdjK0+/lYEqvpyyiImk+xG3V8XCL2S8CnemkqQpJ5JF95s2rFjdMTThw/SCZDOPIv9P631aYyg7Yl0FPhQEKPlzxG2fBD7HFvU/PdQJXQsCD2E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FKmj4fwj; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7e074f8ac06so1390423241.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712049515; x=1712654315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r66TFNSLT4YD94GnwLNWPiQzwjcsChSUIFxq6D9Qnwo=;
        b=FKmj4fwj3REf8DnlBaqVaNpn5QcmnM8MKLTgTSpsmnLHQbc/rblgX/KauxDLzGyRva
         asE6lADwlYba8uEnvJ60bsnMPNA4G3B6dXTLO/1aXSZGu41vWVrqZUR0bGovN5prDQ7H
         s9NYq3L9XJ3OeGE6B64C4gjL+YFzKbKxuYXmAM8DQEA1a1PE+JWdFHjGUjdSFO8H2LH/
         5MhoRvtqdVuJZjvJ9p99bQxxlpm6p+5/jZR/NXmBxJYcyHneyN2c+rrwgnq1KlvG3CR+
         q/KXXyj5DPsdOImhwcA6Bbb7mIZzFrIhQjpdflfyEdibs7AcvV/qTz3AHI2PG26Boyac
         sKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712049515; x=1712654315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r66TFNSLT4YD94GnwLNWPiQzwjcsChSUIFxq6D9Qnwo=;
        b=IE1L5rV9YY7XaKt+T355r4bXBjakgF9avVPHhQew0BdSNBcCTWw2ZSGlyOZJDTRwHL
         G6o2bsbeqblh9ppFGKpnXVCTLJCFIHgEECRsnSGBL2s41NPJ4xCeZGmhv2thD+ZkdK2y
         F1tGkR70BJ9twACNR6G1pIT+7Ndhe7JUqII4Z9l71iQ9woguC3v4zUZfdas45KgOPQPg
         GD6AtHD27BkgQQeI6Wqn1yhQVuRjiuduZoETgGZuGhveH1fdqwEOUU/vaZa/113Azfr6
         bGYF7q6iabGqLrSxpT/HxlGwbuU6+FMoDrslj42sAH7OhG5jasBj1Q4WTZE7yVAGIO8e
         zdOg==
X-Forwarded-Encrypted: i=1; AJvYcCVs9TW2CIztBne+ZQMbyqby+tmbnHSNJ/VLbrlMnBBLw13o93TnchbBxFsLm3yXAJ2xkj1RxGlePM6hdGBkyv1O49CpIRYN9zxVOG7w
X-Gm-Message-State: AOJu0YyZaQwKIiL5F2j+9ntPhnjRJRGYX1c7u8YkKMwt9+RhDF14c4M1
	P8vF1KgD9KUC6hGpZms1GT7Fy9eulScmfSeJfDtL+JBJUhMVSNLbPKxVn4844fhe6z1kQRhr8Mh
	ushsYyEWvP2FEeeVBPAS/EvRy+Db+lkyMmAzSYg==
X-Google-Smtp-Source: AGHT+IHQ73nyKalKwygD4j92nMTrgX97gI21W8eoJIJZkooD2dfv2lbsfKe7svLrUcejklRdqZgrt81nkzCspg1NleI=
X-Received: by 2002:a05:6102:2459:b0:475:111d:c0dc with SMTP id
 g25-20020a056102245900b00475111dc0dcmr8809724vss.14.1712049514705; Tue, 02
 Apr 2024 02:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152547.867452742@linuxfoundation.org>
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Apr 2024 14:48:23 +0530
Message-ID: <CA+G9fYuiYQk8FrF=1kvMW-7jeNskkL309+3qtmgoMjF8KMQnxA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Stefan Wahren <wahrenst@gmx.net>, 
	Kent Gibson <warthog618@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2024 at 22:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.24-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64, and i386 with libgpiod tests.

libgpiod test regressions noticed on Linux stable-rc 6.8, 6.7 and 6.6
and Linux next and mainline master.

Anders bisected and found this first bad commit,
  gpio: cdev: sanitize the label before requesting the interrupt
  commit b34490879baa847d16fc529c8ea6e6d34f004b38 upstream.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

LKFT is running libgpiod test suite version
  v2.0.1-0-gae275c3 (and also tested v2.1)

libgpiod
  - _gpiod_edge-event_edge_event_wait_timeout
  - _gpiod_edge-event_event_copy
  - _gpiod_edge-event_null_buffer
  - _gpiod_edge-event_read_both_events
  - _gpiod_edge-event_read_both_events_blocking
  - _gpiod_edge-event_read_falling_edge_event
  - _gpiod_edge-event_read_rising_edge_event
  - _gpiod_edge-event_read_rising_edge_event_polled
  - _gpiod_edge-event_reading_more_events_than_the_queue_contains_doesnt_bl=
ock
  - _gpiod_edge-event_seqno
  - _gpiod_line-info_edge_detection_settings

Test log:
-------
ok 16 /gpiod/edge-event/edge_event_buffer_max_capacity
**
gpiod-test:ERROR:tests-edge-event.c:52:_gpiod_test_func_edge_event_wait_tim=
eout:
'_request' should not be NULL
# gpiod-test:ERROR:tests-edge-event.c:52:_gpiod_test_func_edge_event_wait_t=
imeout:
'_request' should not be NULL
not ok 17 /gpiod/edge-event/edge_event_wait_timeout
ok 18 /gpiod/edge-event/cannot_request_lines_in_output_mode_with_edge_detec=
tion
**
gpiod-test:ERROR:tests-edge-event.c:125:_gpiod_test_func_read_both_events:
'_request' should not be NULL
# gpiod-test:ERROR:tests-edge-event.c:125:_gpiod_test_func_read_both_events=
:
'_request' should not be NULL
not ok 19 /gpiod/edge-event/read_both_events

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.=
6.23-397-g75a2533b74d0/testrun/23254910/suite/libgpiod/tests/

--
Linaro LKFT
https://lkft.linaro.org

