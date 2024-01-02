Return-Path: <linux-kernel+bounces-13974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40F582163F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE21281B8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869F01C31;
	Tue,  2 Jan 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+uX7IuU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4215C5;
	Tue,  2 Jan 2024 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d480c6342dso30421395ad.2;
        Mon, 01 Jan 2024 18:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704160833; x=1704765633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIT9xyB9jvfWORYTKPL+MJa0zI7NaXZHz6Iz0Vz/t90=;
        b=W+uX7IuUcj/JRcdqhDYsr1E/NNNqFIwGW5IBRGQ6JF+dwgICwMvkcSu+04pSDPhlYf
         UU6Jk4vHdYvWKJhXFCoyepBhOio9Q164x7cqa2zxFVTZHNESo6AEv9JM2g5qnZ3wLKL/
         YBeZoaAwi80GnewAR9nhERE4vCwf+JsGggGQDX39gBL85eT/E2GPZkv99JMx6HAyC7/6
         P2XKBxl0PuJcxNe2lex6P1Usg8hDmLb1Y7rrwmc/CW/mAuMoz5u7rarSiPCSSjAT0fXI
         fsO2GBa7RGgiveDoBzSaLK3tcSWEqISjLgBcS0xX7a4SDIRnU+l3buIXfJkszgbocen1
         sJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704160833; x=1704765633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIT9xyB9jvfWORYTKPL+MJa0zI7NaXZHz6Iz0Vz/t90=;
        b=Y1yj8vZ4YFlZ+TutdLnQ2pLdm/e6bbwLwniJQQA8vYrzI0pxki7YAU08YlNlwZJNCU
         +wV7rI6+fBZGMIHAK930O9E+rS64E6rZsx4SCkUG7AfJtoVjj8LfVHZ4l5ZUTQRUMwbR
         +inLsnsxVMCIFRjW5K8kRDCqYOrlwTad/7/0fGQaWUIK5Ag9mMcRKwkckACzF/ot4QfJ
         IL7wyaaCpJuK/d3+HHvfZfnEmfoJWhEzBzyg2BQd4dITJgwWSs+ZuIFrOcOJKmT44zFT
         O9oL8owrM8skqLUmJvEU6ZB2xYeXBzeV+hcYaMDxupUlKhb/6PVbb2UobQQgHy/bSEB1
         iE6A==
X-Gm-Message-State: AOJu0YzaFqE8yPqtNY+OEgWw3MajKlpJWkvOEnk+Kv65EOcxiGPZh1rl
	ljL7NAD37sVDEG0YQJrorJaeznVo028ZuuL0
X-Google-Smtp-Source: AGHT+IGGtyE9heKavk6YKVQN4zOklIeITJMXbim9pVi/vEynpsqDd1V1mevnIuLVNWPBxqgRnayCaQ==
X-Received: by 2002:a17:903:1205:b0:1d4:ab6e:e13 with SMTP id l5-20020a170903120500b001d4ab6e0e13mr5987030plh.77.1704160832895;
        Mon, 01 Jan 2024 18:00:32 -0800 (PST)
Received: from dl3541lx.localnet ([2604:4080:1020:8032:e1f1:d56c:230e:b188])
        by smtp.gmail.com with ESMTPSA id bf8-20020a170902b90800b001d4921cbe6fsm8118118plb.8.2024.01.01.18.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 18:00:32 -0800 (PST)
From: Stan Bertrand <stanislasbertrand@gmail.com>
To: Stan Bertrand <stanislasbertrand@gmail.com>, Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add ftdi serial to gpiochip label
Date: Mon, 01 Jan 2024 18:00:22 -0800
Message-ID: <4193075.XuvPJYOev2@dl3541lx>
In-Reply-To: <ZXwmBxvQlxca8aNv@hovoldconsulting.com>
References: <20231003001135.2713961-1-sbertrand@witekio.com> <ZXwmBxvQlxca8aNv@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, December 15, 2023 2:10:15 AM PST Johan Hovold wrote:
> On Mon, Oct 02, 2023 at 05:11:35PM -0700, Stan Bertrand wrote:
> > From: Stanislas Bertrand <stanislasbertrand@gmail.com>
> > 
> > Use ftdi serial number on gpiochip label.
> > Allows to interface with gpiod utils using the serial number:
> > 
> > $ gpiodetect
> > gpiochip5 [ftdi-cbus-FTRelay2] (4 lines)
> > gpiochip6 [ftdi-cbus] (4 lines)
> > gpiochip7 [ftdi-cbus-A106TPEC] (4 lines)
> > 
> > $ gpioget ftdi-cbus-FTRelay2 2
> > 0
> 
> I don't think this is a good idea, for example, as not all devices have
> a unique serial string.

The goal is to identify the gpiochip corresponding to a known FTDI device.
If serials are not unique, it can still differentiate others.
A device serial can be set (FT Prog, Python lib, ...) for direct of access.

> Looks like the naming of gpiochips are all over the place, and ideally
> this should not have been something that was left up to individual
> driver to decide.
> 
> I see several drivers using the name of the corresponding platform
> device as label, which works in most cases, but not always either. The
> only unique and always available identifier is the gpiochip's place in
> the device tree itself.
> 
> For USB, we already encode the bus topology in the USB device names
> (e.g. 1-11.5.1) and we could possibly consider using that. But we
> already have USB serial devices with multiple GPIO chips so also that
> would require some further thought (e.g. using the interface name
> instead).

The aim is identification while being platform agnostic, device tree or x86.
The FTDI serial allows device identification regardless of the system topology.

> Johan

Thanks,
Stan



