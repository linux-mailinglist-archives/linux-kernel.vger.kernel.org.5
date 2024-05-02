Return-Path: <linux-kernel+bounces-165888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8598B92FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6F3284238
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5891172C;
	Thu,  2 May 2024 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tugMIuPB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94E611E;
	Thu,  2 May 2024 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714611306; cv=none; b=HYpPWT8Qo+JsMaGEBmLEIiwXwk3O+3m0OahWZvGYlMVDxLuDdUlg9y2vhAEbstMOT5TpnUU73Feb/I9smzDDppIUvjdNN6CbdzuItnHPYWNo7J/txJ7wwXc9aJyhrEXGWXf1JlzNXfsHryCJC9B9Ba3Sv10OSykgDv/JI+yr+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714611306; c=relaxed/simple;
	bh=GklK4yTgkFlnxlWT//xyWXtmzZrzJQjUd2bgLzM+u8g=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=HCFVSL6qzLL/Pq1DQ9272j90wcQLUmUW7n9lW/pt48OsTly/+RgpKHArbaGezOC1jKWxvCpcpJ0EdMxMbmbxD2ZEITS+jlNtIfO3bHCTzNNFMuNE3TifrNbkAk2UelcnFmJFalhMd4fO6MUMrrSls7q7IPZMH5u2f3jXzv+WUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tugMIuPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653A6C072AA;
	Thu,  2 May 2024 00:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714611305;
	bh=GklK4yTgkFlnxlWT//xyWXtmzZrzJQjUd2bgLzM+u8g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tugMIuPBuBNFKchBKTJkl+6kQxDpq/5EoyZ/9DcLD0bCf1jY3bsQ55f1ytujiXqo5
	 bBXtgGyj4V9XfYrsSw2c+vr3nl1wt5vxj0cYozDn5C+f6XN4kWp0rlcSNvwCVEsmW7
	 Nf9AtmpXcjXi+ogdEF0+We+55XNIQhWMpfgXUiWkSr3kBwzy99GoneDnnkakFzFZEL
	 DW0OL9mMNllJpgmn8Mh2z2pkkxUjHllWN4fI4U/hcNQ35F+6kqYCtUL+45nzKoFgDk
	 Z+GmYauYQbavOTi6naEDDkF4CjGc4ofANoQVmNyT/9M6vXuF354xr0wmst92/gvu0i
	 GRNRoVhjF/Dtw==
Message-ID: <0d26a80d9b595954aabd8f6c6e18c710.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <53c31752-c8a2-4098-837e-2f84f03c8748@moroto.mountain>
References: <53c31752-c8a2-4098-837e-2f84f03c8748@moroto.mountain>
Subject: Re: [PATCH] spmi: pmic-arb: Fix of_irq_get_byname() error checking
From: Stephen Boyd <sboyd@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Abel Vesa <abel.vesa@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Date: Wed, 01 May 2024 17:55:03 -0700
User-Agent: alot/0.10

Quoting Dan Carpenter (2024-04-24 04:42:46)
> There are two bugs in this code:
> 1)  The "irq" variable needs to be signed for the error handling to
>     work.
> 2) The of_irq_get_byname() also returns zero on error so change the
>    comparison from < 0 to <=3D 0.
>=20
> Fixes: 932282f154ac ("spmi: pmic-arb: Register controller for bus instead=
 of arbiter")

Sadly this isn't stable because I just send patches over email.

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Applied to spmi-next

