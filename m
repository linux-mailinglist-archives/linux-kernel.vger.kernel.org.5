Return-Path: <linux-kernel+bounces-85776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF2E86BA9D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859F528B6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E31361A9;
	Wed, 28 Feb 2024 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwNdZ/f6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471E1361AE;
	Wed, 28 Feb 2024 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158491; cv=none; b=TUIvgnB/E/aDTUcDbwnRwOo0M6Qmm83zd+4bXPkkmZNx1xSE0llBSsl9v64kOF/0jstV8WzgrD059iGL7rMJ+ICKCatKSmEoNYIDpuO7JG8JvDOnzcm9kRDwHThGlySPLQ2af4fSm95lCC1Gy1415LtLXDqU2qdMib97HlYQSyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158491; c=relaxed/simple;
	bh=EFKm7abarpkXzv8/wcmcMD5nBO5+BHxOxUJcwzjgsmc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=gRqZGj+PFWF3b5FKE0YEOeICfQFB9wqVUJVpJDRj7847CICskLBjFuH87uRpYrNrppO2bdZ9P+2KcB/I4jAhUn5jNDzYGE/dXq3C+pUZsTtfj9df00PcG66Lt6AHD200tTgEEfuy3aNkamEFz6dTGR8vmRB5UaKUP1P/l7GcnOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwNdZ/f6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C7FC433C7;
	Wed, 28 Feb 2024 22:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709158490;
	bh=EFKm7abarpkXzv8/wcmcMD5nBO5+BHxOxUJcwzjgsmc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=KwNdZ/f6BmKcNXsuczUcBIPmBZQaWK+bL2u14JVCKX8g9xnhU3MiMKtMrsgclTLIi
	 BbvHVZlisvOq4RcFlCEUez6ketYN+LRYhYFoOD5byuzQxPOZNr738Jjiw+ABbNnrta
	 wpiyJWMWWqPS7N8dKdF0Es4K531SHeHrNHNFlejtN2eNKVWMb6PjiikNT90NVlypFK
	 RF3DpHUf6KuZP8lxIsYmNMIn6G02nrBiEqf5AQGRMJaERhwUsE8kVag/4a5Qeg8N6S
	 XTWnQDv6vpctF6Zij1LQ4YekhhFojMZGQaYif0QXX8FUAy7JQkRc/F4zorJaY2Q36J
	 JZ+FKAK/8l5rA==
Message-ID: <24963d5f5a964f7620a4aa1cf5769d62.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240223202556.2194021-1-michael.j.ruhl@intel.com>
References: <20240223202556.2194021-1-michael.j.ruhl@intel.com>
Subject: Re: [PATCH v3] clkdev: Update clkdev id usage to allow for longer names
From: Stephen Boyd <sboyd@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Michael Turquette <mturquette@baylibre.com>, andriy.shevchenko@linux.intel.com, Michael J. Ruhl <michael.j.ruhl@intel.com>, Russell King <rmk+kernel@armlinux.org.uk>
To: Michael J. Ruhl <michael.j.ruhl@intel.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 28 Feb 2024 14:14:48 -0800
User-Agent: alot/0.10

Quoting Michael J. Ruhl (2024-02-23 12:25:56)
> clkdev DEV ID information is limited to an array of 20 bytes
> (MAX_DEV_ID).  It is possible that the ID could be longer than
> that.  If so, the lookup will fail because the "real ID" will
> not match the copied value.
>=20
> For instance, generating a device name for the I2C Designware
> module using the PCI ID can result in a name of:
>=20
> i2c_designware.39424
>=20
> clkdev_create() will store:
>=20
> i2c_designware.3942
>=20
> The stored name is one off and will not match correctly during probe.
>=20
> Increase the size of the ID to allow for a longer name.
>=20
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> ---

Applied to clk-next

