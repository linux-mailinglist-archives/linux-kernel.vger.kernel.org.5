Return-Path: <linux-kernel+bounces-90484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE15086FFF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9201C22EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC4D383B6;
	Mon,  4 Mar 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNWUp4Qv"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF6381CF;
	Mon,  4 Mar 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550608; cv=none; b=Xk0yo8m7iEgBYF8fHef1BpSA6yUggpwTz6nCrYt39WI2zVg1r/09UtvI8XoDI4kP4v/2VGi6nHrQekgmF4m0/DDb9hvh8RjXo5w+YCDPjjwqwx2AvD1pag8JNp/ZqeGyEHLKq5toOfNyo8Plv7h9rqD4J2g0SheuCUWP/nvV99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550608; c=relaxed/simple;
	bh=8rBw+8lavQNu3WP5WN/y/f26LqjJAVlqi+HMskTiDyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JG6SMmJUotaQL86mqxyWiRTVm5lkr1JtCAlmGZtRTJh2zJyTXUadKbD5ExQ1T7bynGS7GBL2ayhSvAWpo8+QoODRFIm9mPApeR7wumOtPnXknwijzLmtIrb//qls+Oe/CE8BmHO6ZGIP2CZkLFh2akp41e1NWJ5Hg5D5m4gtYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNWUp4Qv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e5769aa0b3so934037b3a.1;
        Mon, 04 Mar 2024 03:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709550606; x=1710155406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rBw+8lavQNu3WP5WN/y/f26LqjJAVlqi+HMskTiDyI=;
        b=LNWUp4QvW/D0pgdACBps4jjF89rNliM51ukJC1qNQSyN+NKzASrSH2x2U26VFNqsFS
         VpeZBH7U3AGH327xgrdLE1eSnMNCWSa4WRgBtbBFfNlXdRZ7ViglDmuIszjOU+I9JMor
         uWqhDaRPAFPRbZyOyD43WH81rnB1TI570XGErT/lL4flPHIhRbakD4ZwG1nW9fqD8dv/
         BFJOTUi2dhwJoXmAM6zvfnCbzDXq0rsdD+i4GVAriJAfBOkDtkPDZrSNxNsDS7nl8526
         RXi8v7GTJfK4mYcfaVbTeIiYEB4cRJBqsqipOpW4zZJi2gNjINaLVmcLvAR23LRe+MwO
         lxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550606; x=1710155406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rBw+8lavQNu3WP5WN/y/f26LqjJAVlqi+HMskTiDyI=;
        b=KpYanH+QlX6e+SWyUhFMtTnyPM3rVZkkFAXNFPEWayUwoKoL9uw661N8w9RtcGjL7l
         l4wtM0LQVaFamEDWWkqCj+5cy+296zBehKmYN1zyPJu3+3XUSZYuxpsNm/VzLuvI5tzJ
         It86OgQBSR9rwKjPDELlysFsLXz2oYkJ4YaRuv7x8e1qGvFLucFHgCvEZUAFmEpRAqHX
         PI4MtgGFnXTABX/OrO7BQYrRSMB27pN31vdBvOt+lgWXpyCIqEjXzjXmZ5dp1ksoUuoq
         k4lKtgXkAGF+27HPDnp6El7UpN1EUa2phxY1UVisak8QznQGB4JMtaIZhYuXkVz6uuMw
         aktw==
X-Forwarded-Encrypted: i=1; AJvYcCWm+VPDL7FmbTVDrM0BMr+x1lWqE0mGj9X3PA5NAv1MdJ7ETevys32PeJmEFaTt9sy+iV+WYSXQYAv9BccZ+S8ylEIF1Tv+UJX34nh4jWH0smZIgxiDLOK+mugX53BrOkk1mfDX6yaokLjZ
X-Gm-Message-State: AOJu0YxW1YOy9lWWLDqLhzX59hpOU9xLwt3Sl+P3GbSnYz8UgzxbonuP
	Al6Hv9F2Gn4N7T1pJFuq2kEbWxMx0ONCyDP84FgfXIAseq5Rzv3D4AQ0M+GyL8yVqRnlep6+GLi
	r9yqoqInD2VXOvQC3C50vIrZe/w0=
X-Google-Smtp-Source: AGHT+IGw9TbaXB4OiBViXULChFw8ceMuWOdi0bShk6CdU+4WddPSCqd7UQSgJO1Yt6fZTZdAk8xHZza2uny5nD0L8Fs=
X-Received: by 2002:a05:6a20:3ca8:b0:1a1:276b:e116 with SMTP id
 b40-20020a056a203ca800b001a1276be116mr11760741pzj.3.1709550606198; Mon, 04
 Mar 2024 03:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304020712.238637-1-sherry.sun@nxp.com> <2e1b1eae2e9d3cedcd270e35cfcf8086b914b7ff.camel@siemens.com>
 <AS8PR04MB8404FEA637E51E3B258BC28C92232@AS8PR04MB8404.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8404FEA637E51E3B258BC28C92232@AS8PR04MB8404.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Mar 2024 08:09:54 -0300
Message-ID: <CAOMZO5AUFsC87fivJ7UhLGpoqy+-rfSx8Jipp5QGjQ9uGOngTw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: avoid idle preamble pending if
 CTS is enabled
To: Sherry Sun <sherry.sun@nxp.com>
Cc: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>, 
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>, "robh@kernel.org" <robh@kernel.org>, 
	Shenwei Wang <shenwei.wang@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "robert.hodaszi@digi.com" <robert.hodaszi@digi.com>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sherry,

On Mon, Mar 4, 2024 at 4:32=E2=80=AFAM Sherry Sun <sherry.sun@nxp.com> wrot=
e:

> Hi Alexander, good catch, I will move the "/* restore control register */=
" message to the appropriate place in V2. Thanks!

Please add a Fixes tag in v2.

