Return-Path: <linux-kernel+bounces-165703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D176A8B8FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880741F22973
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D41160877;
	Wed,  1 May 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtJEbuOv"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334437E;
	Wed,  1 May 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714590563; cv=none; b=NysMiZHSsRMdPbYq6XJByom9IkLh1lWyJeRCbqOnPCL9Pw6599Y2zJkRTZNEa1VUW+W3730GdAuhlf7QrD99mUjkaKlTLj2KBpnnyzZ8cH3fVLF03qF+hZLuzEiFdvY+n/AqLfLWnL3UovhKyy7L6MDQxkMp5Dre3bnA9MTamKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714590563; c=relaxed/simple;
	bh=n5pYTyvFni944oaVibayAqa80uMHIsdKECpSvi5360E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFIIjYWo7rNqAMHRX/1bdiDrvmE+rL6JM2L2IcjkTG/EiQ+I16wn4xOON2juWnW68VscLXLvSTFOE8b+TvDu/9lidaIeiUQrKPb0A24vmM+JCzOZQdkDIZf9fY4eQywq8vGgOSWWTSYFrdpGGlLAf9m2fSTmq0tlVozKy+3ueRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtJEbuOv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so71147145ad.1;
        Wed, 01 May 2024 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714590561; x=1715195361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iodSlTyJGn2wkptHN8yi6myJ+vX1z0AKpyPf47Fk2gk=;
        b=UtJEbuOvEX/KdIvUGDWguXdqdgdDIqAV5MZdW5fWlNYCe8R8BH21OEbxW2CGI7TLL2
         YmiVOT0Fsxv8lS8DKt5ofw/pMKcjDsiup8TUS3mNDaEuv6N76g7bJKIm0X75a26yfDxX
         QFx1w4LeBnjrXLh2FiH/16elOdZ81rpSHU6iphTl0hDqXARdURXwahp2Jrl7SN03x+03
         XJLUDBOo2sLgVWjcOi4UEtqfuXLp8JZ4V8jXzK8YOEPE+ynP1R79csPqjiSRz2nf4Tn3
         U9NPd+5xdSHlN4GkB2ylkKyryeq21Uxgydx1gIvlGrpQ2jsVvj8GAw3sx+N+waw4y9m2
         Ba0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714590561; x=1715195361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iodSlTyJGn2wkptHN8yi6myJ+vX1z0AKpyPf47Fk2gk=;
        b=YhPIYDfc5Dww3E90/vr1GUp3VK1BPZjTERhVlZwS5xeur3E/Y/n9zqTsVvmT/k2O+e
         wCiDtAx9bMZtBR7/n/8x8w4RLcs2l03ePWXrLPq5v0EIvOmps+V5N47wZmJmQ1m38Sqq
         8ygGGYEMUN+mBNFNgNKrqDCAD2RckxBA7Ze7cs1g7CWPCKwHYMI18kbxiukg8O72q/Z3
         Sz6xGvIYnemR02c7r0ByGH9ZbaW15r67/dRPoxgnFec3w4BhgftHUnW6od2Tvbdmhari
         2xV0dpcGVPS6hl1ZMLEtmtrsBAfX9TUHODbq/eVjNa/yz6mgGU7cL+JqwkM+oTAjXKo2
         fp+g==
X-Forwarded-Encrypted: i=1; AJvYcCUHWVw5Mvs/wDzCWufoJaBGSApiRWUVBkzPD+A8Z6M3ZanZ4lUZ9gDQBvceKhwluUrBLWGvdre9X3l6VVJWt16xm4CRcAR85Qfyu2zCKQ+KmeI2kE3CeLJHldSpSSIi8Kmh0UYN33lZOxU=
X-Gm-Message-State: AOJu0Yzk40I0Fzd7Plbn17HI5QehE3kGQ5HkXooz11TnI8Svw979ZwS0
	2a2hq8bSG8nUocxJ/S69ArI4zVJZhM0h0aAOvVumE28JUs9BM4EQAMaQYg==
X-Google-Smtp-Source: AGHT+IFBRTGo3q2l+2CV+0YqPCSPL25JiEqdpXw1p9Y6qwypLs/r9eOYqEu6HtVbpxqlgqGe0xR64Q==
X-Received: by 2002:a17:902:ec8a:b0:1e3:999a:9726 with SMTP id x10-20020a170902ec8a00b001e3999a9726mr3985060plg.29.1714590561209;
        Wed, 01 May 2024 12:09:21 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1cb4:dd50:d6f1:6308])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001e604438791sm24506880plg.156.2024.05.01.12.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:09:20 -0700 (PDT)
Date: Wed, 1 May 2024 12:09:17 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kenny Levinsen <kl@kl.wtf>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>,
	Lukasz Majczak <lma@chromium.org>
Subject: Re: [PATCH v3 1/3] HID: i2c-hid: Rely on HID descriptor fetch to
 probe
Message-ID: <ZjKTXaBrb1vs4har@google.com>
References: <20240426225739.2166-1-kl@kl.wtf>
 <20240426225739.2166-2-kl@kl.wtf>
 <ZixvUNooESC02cJK@google.com>
 <5aa9f745-7f6a-4873-90ba-79c55335905c@kl.wtf>
 <ZjFli4zOalXkDWx_@google.com>
 <26070c7a-4005-4bb4-b4af-779bfc415dea@kl.wtf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26070c7a-4005-4bb4-b4af-779bfc415dea@kl.wtf>

On Wed, May 01, 2024 at 07:24:08AM +0200, Kenny Levinsen wrote:
> On 4/30/24 11:41 PM, Dmitry Torokhov wrote:
> > I actually believe there is. On Chromebooks we may source components
> > from several vendors and use them in our devices. The components
> > are electrically compatible with each other, have exactly the same
> > connector, and therefore interchangeable. Because of that at probe time
> > we do not quite know if the device is there at given address, or not
> > (i.e. the touchpad could be from a different vendor and listening on
> > another address) and we need to make a quick determination whether we
> > should continue with probe or not.
> 
> Maybe I should clarify what I meant: All I2C operations start with the
> master writing the slave address to the bus. When a slave reads its own
> address off the bus, it pulls the data line low to ACK. If no device is
> present on the bus with the specified address, the line stays high which is
> a NACK. This means that on the bus level, we have a clear error condition
> specifically for no device with the specified address being present on the
> bus.
> 
> Whether the operation used is a dummy read or our first actual write should
> not matter - if the address is not acknowledged, the device is not present
> (or able to talk I2C).

Is it possible for a device to be wedged so hard that it refuses to
acknowledge the address?

> The problem lies in whether this "no device present
> on bus" error is reported clearly to us: Some drivers use -ENXIO
> specifically for this, some use it also for NACKs on written data, some
> report it but use other return codes for it, etc.
> 
> Even if we stick to the smbus probe in the long run, if we get to the point
> where we can rely on the error codes from I2C drivers we would be able to
> correctly log and propagate other error classes like bus errors or I2C
> driver issues which are all currently silenced as "nothing at address" by
> the smbus probe.

I think this depends on the answer to the question above. If there is
potential that the chip may stop responding, I still see benefit in
differentiating initial "soft touch" poke vs. hard errors once we
established that there is/was a device and it started misbehaving.

Thanks.

-- 
Dmitry

