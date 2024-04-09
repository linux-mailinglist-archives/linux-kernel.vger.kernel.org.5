Return-Path: <linux-kernel+bounces-137658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C8E89E537
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80748B22F5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FE4158D69;
	Tue,  9 Apr 2024 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSYjtN00"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D4156F4E;
	Tue,  9 Apr 2024 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699674; cv=none; b=ROHgxviK7KSgQmRFFAuSWaBIUkCh3FfL/zei99ppN4g2nZVYZKb8LhKiHn6eXGZ6Q7VSjtDamIMmD+bYz5fMWRPOB1CSbjT8/pBhwXZiXcey+ipoLhFeDDGIaZmGGWFGw0X7uyTn7EJ62sNrjgUARYfxnNOK3Z5g3q0T1tztkuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699674; c=relaxed/simple;
	bh=9FxYcLrgGPDwV1m139PePOKoq7GSScv8tNDEPdPqbSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlMVt0YGck99rnnwigMqlOP6ikHSVNjjqV5oiiwDI6jVT8oRjupkgVlHnMYZOuKfTD6s6mGQNn9WmA/vaKwPINh66vRs0+ao9B5IjPDinmEUkt1M1QHzkpI1yLYCaK9zud5e+fJC1KYHr+Kb2ib6rQ7RxcjEDl81t/vmn+8xH5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSYjtN00; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso4875842a12.3;
        Tue, 09 Apr 2024 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712699671; x=1713304471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yCfI2jgQUvfRfEGyH3IDCFlAWQqz4TVgXDFmhrEpoSM=;
        b=DSYjtN00TW3/GiBgP1UrNhWBR20LU/JNH3wtvGdWub5GeRrrKN4a+u9M5ULh/oacbS
         QaNGwNlH3/I2VMneMmwlp2vROuRPnk4r1YysoCgtA+dA4vGMCY/BjoM+w9l8K9bZYMSA
         oPyrQ+rROAHIOx5b7ZZqmg0fggKmSd2wNWBxv3CbCz27hnRGcBpMS12BCZLIYcwI6ZfA
         V97vaaJejLXVKsyDrDVyOhpswRPPHwD9C5Q1DarFJhMQovqTIvpJ4g4tDLCdf9yU/YJ7
         +fr/8HZUnmeGtirOpbyxyldlQbKBD2jAqEogZpYkwBinYBtq8wu5x3qK51XJkBE9+a21
         ps/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699671; x=1713304471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCfI2jgQUvfRfEGyH3IDCFlAWQqz4TVgXDFmhrEpoSM=;
        b=vfyE+sXstqbLORq+3mWnXhHYFbUjtuAuvJFRsGc9GvhJUOYS3ff/DlWl36BCOvuNwf
         Fo+dnU8rXkS1eKZlvalSLgt3ml1BjD0/Wg08chj985+IG82R4lvZCgTtRmuD17QSzPCP
         K/VPrA1SHmYkjcnR6HllAi7Alfd9/5VrfjG+S6gBYv5ZSS5x1FsSIYMlPP+qJwe0VKTi
         +uhYMau2XgjxoRJ+LKT08MCbAXmVIna+k2e7KRiP6rOGTBNah8b8ubJa8Etg96SFrhII
         jJZzvUeoHL3uFArlObrKwcRIvtqI1X/9UUcQbos4023Okos27t0G4UNAJmj+ZJpYAy8y
         u9yw==
X-Forwarded-Encrypted: i=1; AJvYcCWdIXdherCcmJTSPRAKwcIt9FOFoNx74HX2ytdlt1jkk4Aml5mtgz76A2gk3jaizROUzR1WQrpKUaLe8RWAWMsiIEhwz/gXxX6j4d6Alxm88fa/63aTx7cACRDbe/QjcvvVfFUXuGvceF+CwUNZPZzWe62CqelcJf469codmdwzraknMs+6GSa/mpJVMUqO
X-Gm-Message-State: AOJu0YxLJeLsZFXB3ghUnjjJBv3x5CA2+SDvukAJFpbo6iA0ahMt/Nme
	LhUzypt0HhfL4TJVrAtQ0j/3L9bPXoC/Dpcb4GDnlGE9dYYFoKmI
X-Google-Smtp-Source: AGHT+IFcbN+2aYJc/Io8VR3Z+BFQfIej1rUjuUP+5CgmtZ6i7zjKfAAbI9t5PT3XN32ZcufGHn9N1g==
X-Received: by 2002:a05:6a20:12c1:b0:1a8:587d:6268 with SMTP id v1-20020a056a2012c100b001a8587d6268mr1215807pzg.62.1712699671528;
        Tue, 09 Apr 2024 14:54:31 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6c8c:a143:d391:6ace])
        by smtp.gmail.com with ESMTPSA id c16-20020a170903235000b001dba98889a3sm9339701plh.71.2024.04.09.14.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:54:31 -0700 (PDT)
Date: Tue, 9 Apr 2024 14:54:28 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	ibm-acpi-devel@lists.sourceforge.net,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nitin Joshi1 <njoshi1@lenovo.com>,
	Vishnu Sankar <vsankar@lenovo.com>,
	Peter Hutterer <peter.hutterer@redhat.com>
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug
 info keycodes
Message-ID: <ZhW5FGmkQ-ed15Yc@google.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <c6427b27-3c9d-4aa4-abfa-c3588b5d9a42@app.fastmail.com>
 <dded171e-4cb4-47cc-aece-d5afd229060a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dded171e-4cb4-47cc-aece-d5afd229060a@redhat.com>

On Tue, Apr 09, 2024 at 12:16:04PM +0200, Hans de Goede wrote:
> Hi Dmitry,
> 
> On 4/9/24 2:00 AM, Mark Pearson wrote:
> > Hi Dmitry
> > 
> > On Mon, Apr 8, 2024, at 7:31 PM, Dmitry Torokhov wrote:
> >> Hi Mark,
> >>
> >> On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
> >>> Add support for new input events on Lenovo laptops that need exporting to
> >>> user space.
> >>>
> >>> Lenovo trackpoints are adding the ability to generate a doubletap event.
> >>> Add a new keycode to allow this to be used by userspace.
> >>
> >> What is the intended meaning of this keycode? How does it differ from
> >> the driver sending BTN_LEFT press/release twice?
> > 
> > Double tapping on the trackpoint is a unique event - it's not the same as BTN_LEFT twice. The BIOS will send a new ACPI event for it and it's not meant to be the same as mouse button clicks.
> 
> To extend a bit on this, this double-tap event is not reported through
> the PS/2 trackpoint interface at all. Instead it is reported to
> the OS by the ACPI hotkey notifier, which is used to report various
> multi-media hotkeys and things like that, this is handled by
> the thinkpad_apci driver which sofar only reports key-presses.

Ah, I see, so this is just an arbitrary action not connected with the
pointer handling in any way.

For such actions we typically assign keycodes based on their intended
behavior, so instead of KEY_DOUBLECLICK which conveys user gesture but
not the intent you should consider using KEY_CONFIG (with is typically
mapped to Application Launcher - Consumer Control Configuration in HID
spec) or KEY_CONTROLPANEL (Application Launcher - Control Panel).

Thanks.

-- 
Dmitry

