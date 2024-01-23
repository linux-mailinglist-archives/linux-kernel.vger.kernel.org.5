Return-Path: <linux-kernel+bounces-35036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC069838AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C99928A211
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F10259B7A;
	Tue, 23 Jan 2024 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO9/a1pX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11F59B61;
	Tue, 23 Jan 2024 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003265; cv=none; b=If5eM3Vehvd8dyoCqSncFUoI2ndSTjkhdwwSoI7gOZDtDgPYJTkuvvTNgg1ZXdmshnerBig3Y48sKzD7DD0N2sMmRJ3PO1Aq93cBLQQ0jDIeUUnjI9kzW/qOiBc4YUQ2R0cTjDnonBzASXIepiEIbgkz3T8XCCrp85PnpIR97yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003265; c=relaxed/simple;
	bh=E5DDSd9jInVCIwSyg7EZ4ScsPQilv7OKc3YaWEfLIg0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bQpgeGdghwtpbEr2/zSqizNigADn/x0l+GjRiTCBh+iVf6SuFnYoeM3Ttdp9werpaPod6E7oYsTVEX81HYrTeD3Vdf/4uus02zOqUa/5ZhtdiLYDdduJoB/T8DR8gWI3lXPYADnYMbWgzMzSmGkIK2spz03DpQTI/C67JMMjZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO9/a1pX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB58AC433C7;
	Tue, 23 Jan 2024 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706003265;
	bh=E5DDSd9jInVCIwSyg7EZ4ScsPQilv7OKc3YaWEfLIg0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cO9/a1pXRI5mzyLjPgHxSlg8GuGevociP60sK8stsTxCpRx/QWO7jSFOe2+nHHMTy
	 JIhRL1y3m7pEBhs7wy17Eh9p4neCUaWGJAsoq5LF/BTN8RevLeo57QrS89REjGclM6
	 axhjBOZHvuhF4vv4SVhSmL/kB5y0W/zVQ/PLryLT2GMgXvCKseLk7uSXcgdvHOep8R
	 xlWnH1sRwaXALwJe615rjmEKaVl4J28CCJ1Ad3lKGeRZx6rg1SIMZgObWnDmywycFC
	 Rdqr/qtbe4345nWZmFbSrqPaKkKathELPXHGxL8SaNMF7qYwtLlTeRvGR03EKxBN/M
	 6/jnbQT1EhnCQ==
Date: Tue, 23 Jan 2024 10:47:45 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Max Staudt <max@enpas.org>
cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/7] HID: playstation: DS4: LED bugfix, third-party
 gamepad support
In-Reply-To: <20240115144538.12018-1-max@enpas.org>
Message-ID: <nycvar.YFH.7.76.2401231047140.29548@cbobk.fhfr.pm>
References: <20240115144538.12018-1-max@enpas.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 15 Jan 2024, Max Staudt wrote:

> Dear hid-playstation maintainers,
> 
> Could you please have a look at the enclosed patches for the DualShock 4
> driver in hid-playstation, and upstream them if possible?
> 
> There is one bugfix, and a few small patches to enable third-party
> controllers. They sometimes don't implement features that they
> semantically "don't need", but which currently trip the driver.
> 
> For example, for the DualShock 4, we don't actually need to know the
> firmware version in order to work with the gamepad - unlike with the
> DualSense, which has different driver logic depending on the version.
> 
> Finally, there are two patches to add a DS4 compatible controller with
> an unassigned VID/PID - I'd appreciate your thoughts on that.
> 
> If I can make it easier to upstream these patches, please let me know.
> 
> Thanks!
> 
> Max
> 
> Patches in this series:
>   [PATCH v1 1/7] HID: playstation: DS4: Fix LED blinking
>   [PATCH v1 2/7] HID: playstation: DS4: Don't fail on MAC address
>   [PATCH v1 3/7] HID: playstation: DS4: Don't fail on FW/HW version
>   [PATCH v1 4/7] HID: playstation: DS4: Don't fail on calibration data
>   [PATCH v1 5/7] HID: playstation: DS4: Parse minimal report 0x01
>   [PATCH v1 6/7] HID: playstation: Simplify device type ID
>   [PATCH v1 7/7] HID: playstation: DS4: Add VID/PID for SZ-MYPOWER

Roderick, any word on this series, please?

Thanks,

-- 
Jiri Kosina
SUSE Labs


