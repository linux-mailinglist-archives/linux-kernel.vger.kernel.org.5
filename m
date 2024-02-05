Return-Path: <linux-kernel+bounces-53142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D4D84A132
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C86281D63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3671482E3;
	Mon,  5 Feb 2024 17:45:14 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EBD481C4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155114; cv=none; b=grBfoEG6+m65wIOuxrEMV1e+uMtixwBXaxuvgQbx2Eo+sJqpuTjMm3pONG7uXaQuYp8kyBDcwDcdjMOOSJ9vxHxEJlnMA9uFGdbyxkCbS/ps74NdcuWVbxE8rJUh7RWWQwfSSiPN5u6ocb+s0JbU/38geXmzPnw5bRiB8mA++wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155114; c=relaxed/simple;
	bh=PiZXJ4aaxYl7ZK+CabntQb2voak7lEXwYk8HlmxDXXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8ftpAMccDZ4Psx1pVLblxkvOxfn8tGXNPkdFsjRszEcy2yoavOep5F5bU7iPhnpbt4DRfr7k8GoPxfVw4uAmEaImwKR7i6dfU4aHoSTxgdrcqmxQ6VEUmvWJNlBS043qSv9aBvG0ukDatdQGKkloUq5hCdBokJoyvtjwL49h8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 4122F1C130E;
	Mon,  5 Feb 2024 17:37:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 516E81C;
	Mon,  5 Feb 2024 17:37:12 +0000 (UTC)
Message-ID: <b340ab43a1dfed3349843c7cc694ab28cb316d7b.camel@perches.com>
Subject: Re: [PATCH] const_structs.checkpatch: add bus_type
From: Joe Perches <joe@perches.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Andy Whitcroft
 <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	 <linux@weissschuh.net>
Date: Mon, 05 Feb 2024 09:37:10 -0800
In-Reply-To: <20240204-bus_cleanup-checkpatch-v1-1-8d51dcecda20@marliere.net>
References: <20240204-bus_cleanup-checkpatch-v1-1-8d51dcecda20@marliere.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: gzao3ew1nwxzqfxqs649qff4qf9xhq7x
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 516E81C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18kztLeVUC3pfHfcsg6EZsVrzry7sGTt1Y=
X-HE-Tag: 1707154632-481124
X-HE-Meta: U2FsdGVkX181c3Gj3JIqM/bS7UYTXF5mUhx6oxdqTdsQ6uUth8qH8HrK7GSTHEw8lIDPHR1G41BzNzjSovjnkX62rYb8Qa8n3xustrJDAIQuFqAwrcnKLPyS3LHpurwUF16LqTl8x+IyoAhvaiO8fhAvOW7KjZKj4t13rVb26IXUPq68+fT+oSEMxhxKH9nGXCt+4Q69GIVce4mf2MpYkryzAKeQrRMdygeZRe5KGUQSmEd+EWYQC70t/piNG1Rx3tMcRd6A551WY3/ztw4isB95WgAwUSrRU76WioTen3SvLpiDXw+aH06TgtzYRQdDWXqM2E911KUU2e2BP0SPhdi1ZLx50bXnM7GEKfru3m6wRdlE9iTEb6G4xUybkPRiAWe6hS54g6BCPgX6W28wXbSDGiq3wSA6UTfoeo7QW3nJsLgcmvWaRL655dBkcu7Z

On Sun, 2024-02-04 at 19:39 -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> a const *"), the driver core can properly handle constant struct
> bus_type. Make sure that new usages of the struct already enter the tree
> as const.
>=20
> Suggested-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Andrew?  Can you please pick this up?

> ---
>  scripts/const_structs.checkpatch | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.che=
ckpatch
> index 188412aa2757..7427313adc7a 100644
> --- a/scripts/const_structs.checkpatch
> +++ b/scripts/const_structs.checkpatch
> @@ -2,6 +2,7 @@ acpi_dock_ops
>  address_space_operations
>  backlight_ops
>  block_device_operations
> +bus_type
>  clk_ops
>  comedi_lrange
>  component_ops
>=20
> ---
> base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
> change-id: 20240204-bus_cleanup-checkpatch-719a62209250
>=20
> Best regards,


