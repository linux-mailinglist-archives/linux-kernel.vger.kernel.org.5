Return-Path: <linux-kernel+bounces-167496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A48BAA6D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4091C21F9B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4107314F9DA;
	Fri,  3 May 2024 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwhsyTO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882BC14F12E
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730484; cv=none; b=o3F9DIar6aLeBd2WKMIT6xr/dT7ocZjADgm2Ybdf6RiS08jflwJe38FZzTXJNdRD1S+/Q9edGfouZmc4wYa2EAsbo1i9QcvfROmDFf0xnRy691xVIhn6PYnWzbdlVNj2EQKbRqJxeGnwGOnQhqgLsMQtsXpqHytsMD8hdK5gL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730484; c=relaxed/simple;
	bh=YsZoQ9keCvGXlELIZ57R9Il7ofNDtmEsE7RjpnUM+38=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q8XDwwOy6tOSY6rI3Ua3J8zyB8TocYisHDysDRTniXKrDp7hP8iR1mIPXSUqptkpGbuIlOy5+cPz7puIbYV4I3QUuP6bnCiJwJ6D3oTDUzYfu6Y6R/rdPQKogWInKqk5IV3aEoNMNbyt8I7tawY3lir0CFW6xrRpZjBsO+CKbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwhsyTO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B41C116B1;
	Fri,  3 May 2024 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714730484;
	bh=YsZoQ9keCvGXlELIZ57R9Il7ofNDtmEsE7RjpnUM+38=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TwhsyTO8hgIMsm/XD0zCEsARQ7Jm6RKSYfiRkF2U1IK6Y8FyyQ++RnMQRgXpPvEWV
	 +mSvdvDrsp7wxSdFXkmBDsso8AK5bcgi9IB0C6Uipkungyk1D9W56ZDbhVJIoVlIHl
	 G1aGRFu7X1ZY2p44KnVTprllTrpbWBzDb303Vb5qW+5yTA80P0OxMMNXcfYKuYDy7E
	 Ft8pYshwcm+RurDttAo4dsHY6juPscezoDMlcJnB+r1MMTNGmH9U5UfLOE3ipYYH1v
	 9x3AO6E3AW1bgmGoPMlcbzHdcJ0fdnNev0vKQ7zugNxoYd07PQzvyWwT116zR9Rzw2
	 /RAPNz9Ahw7fw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Min Li <lnimi@hotmail.com>
Cc: linux-kernel@vger.kernel.org, Min Li <min.li.xe@renesas.com>
In-Reply-To: <LV3P220MB12021342F302AADEB6C1601CA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
References: <20240501163256.28463-1-lnimi@hotmail.com>
 <LV3P220MB12021342F302AADEB6C1601CA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Subject: Re: (subset) [PATCH mfd v2 1/2] mfd: rsmu: support I2C SMBus
 access
Message-Id: <171473048291.1337417.9821677602108528247.b4-ty@kernel.org>
Date: Fri, 03 May 2024 11:01:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 01 May 2024 12:32:55 -0400, Min Li wrote:
> 8a3400x device implements its own reg_read and reg_write,
> which only supports I2C bus access. This patch adds support
> for SMBus access.
> 
> 

Applied, thanks!

[1/2] mfd: rsmu: support I2C SMBus access
      commit: 189ebd7b49a441b1f8c35c57fdb5b81ba25d5d12

--
Lee Jones [李琼斯]


