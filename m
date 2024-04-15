Return-Path: <linux-kernel+bounces-144818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693278A4B20
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E07DFB24AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F893C062;
	Mon, 15 Apr 2024 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chQsQvPp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7413383A6;
	Mon, 15 Apr 2024 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713172132; cv=none; b=JnGmveDIvDN3n9Sx1XBwO4t22KrwpgqOqjRQLXzr8eAcDiuBV5hG3+t3c9vXqPqBZIc1RrTbrkibHLJ4MuV5oCcil+mg1UZo7Eqo7/OdALv3N9kr8FI12pdcFq71iI2NUpwtXWGnS5XZs1/wmIfPLy/lr7Hb+ih7Z3EpUqS9ujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713172132; c=relaxed/simple;
	bh=pzZhZpLPSuewVTIczsuOUqqpSFOIX99c+RIFP4sWCXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Parc0I/zICQWAQjX40T3KgQMTLXrYhkWdU8JgJQOEubi5FIHdafvsy8jRODsYHZ1UAP87Gce1d6N2fL4cBAel/79d4QUAPAMykRC8Xtss37CW6PlEg/D33UD6CUdCoMMFVTdtcpJYmnYiwwkjNZrEAC4dW9p9GvthUVhqhkbxPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chQsQvPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3811DC113CC;
	Mon, 15 Apr 2024 09:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713172132;
	bh=pzZhZpLPSuewVTIczsuOUqqpSFOIX99c+RIFP4sWCXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chQsQvPpwYPBfVxtUAk2XrMDL/PtSyv/c7FHpwrt5ZKFlDTOYjsW8ov28gJQSM/WQ
	 yPYW4YxD2qqJjqQdjstcUKicDIlsHjY4347pn4ALmLnLk3gQuAhHZ9/3cTmW3wpLQq
	 m4JpYvsGyDFxB1lCjpc4SFU6jNARd1y1Ucw+qAk2zcjBqREzzwnWcOfGn37fJ90t9s
	 53PJAoy/J1E4GUtHmljjstPJXQq+uI+ZPYL/WlAxzaFt6E9yoKGU6fjxSuA6Xd2D2e
	 UuEF9d50+T2KN8EmpRnI5VU+F54/ikQm4tsxLRUaZ6O5JUH124VoN2kIPt98Vntdum
	 qYj/MRKYNZlUg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwIKX-000000007k0-3Ma6;
	Mon, 15 Apr 2024 11:08:49 +0200
Date: Mon, 15 Apr 2024 11:08:49 +0200
From: Johan Hovold <johan@kernel.org>
To: =?utf-8?Q?=C5=81ukasz?= Majczak <lma@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
Message-ID: <ZhzuoWgA88CeenMC@hovoldconsulting.com>
References: <20240405102436.3479210-1-lma@chromium.org>
 <ZhOccGFkTFkUkRUI@hovoldconsulting.com>
 <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>
 <ZhVix-HJrqQbiPrB@hovoldconsulting.com>
 <CAE5UKNp3uS9cqDbQjcP3SbfxVi3wPFG4LtP6z=WU_V+M9x6LtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE5UKNp3uS9cqDbQjcP3SbfxVi3wPFG4LtP6z=WU_V+M9x6LtQ@mail.gmail.com>

On Thu, Apr 11, 2024 at 04:23:27PM +0200, Łukasz Majczak wrote:
> > Sure, but what about other transactions that are initiated by the host
> > (e.g. SET_POWER)?
> >
> Somehow it is problematic only on reboot and works just fine on
> suspend/resume and
> set_power.
> I will dig more and try to find out what the difference is.

Sounds like it may be related to the i2c_hid_set_power() on shutdown()
then as Kai-Heng pointed out.

That function already handles a similar retry for I2C_HID_PWR_ON during
resume.

> > Perhaps this hack at probe is enough for your use case, but is an
> > incomplete hack and at a minimum you'd need to add a comment explaining
> > why it is there.
> >
> You mean a comment in the code ?

Yes, if this turns out to be needed then there should be a comment
explaining why it is there (and currently also as the delays you used
seem specific for your particular platform).

But hopefully you can find a generic solution to this.

Johan

