Return-Path: <linux-kernel+bounces-143889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 181D38A3ECE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B83FB215D6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C337356B72;
	Sat, 13 Apr 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvdjdO2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287B5473D;
	Sat, 13 Apr 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044355; cv=none; b=jnxFMr6zTn72lzPudCBZhtEL1HVlOnYvDDocVIDep64molEnk+c8pPAUAb4EGRy4tLePLdrJsOtEakEYu5YuEJWjp3/NSJxWxpRFqyyOwdZfoM/MEEBRAydsKj1ND/KY9hItEAVkk/7GT59vzW7yk0VbqNKRdOkj+jvQMtaMXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044355; c=relaxed/simple;
	bh=d/ixlUFZiWqS7w1S+uZ5bU3PvtJ6FPlMO8nl+D0Kuh4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=UZjh71N249wYX9OX/NJjZVS5Fux+Ak0FzIsBL6pdz+Cj8ss+6M4wxp0Uv30fqSY8CJr+sjRhC55YQv/SDzAzyCYcoSGWDggIl58/Knubq1QY4eAAWI0ebVcocac13PRGgzji9ETfz03nhUxV8njZYxmPMF7W8qG4Vp71wTJX++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvdjdO2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922AFC2BD10;
	Sat, 13 Apr 2024 21:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713044354;
	bh=d/ixlUFZiWqS7w1S+uZ5bU3PvtJ6FPlMO8nl+D0Kuh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvdjdO2uoJHyEoPa0msweepPXLPKa3kP4G3Wva+G8EACxTjWM0wMwboqyW/uEQ+Vs
	 knJyE5dZTYEBwXZ/OHmDWxO9PRIqMbEAShcxL86ZvENhYkvT3WZDxYlkZnRPUfpxJq
	 IW1ouwhCv7VHqK5rRvvhi/qnYhdevAPyf5H6a1S61loycKN6J2zcBBWfritq+uxTPH
	 uyc1SPKCyDBv6k66SabBflyqqxV/M7VnGFCVViDGNQ4kC92sdGAHU5Gz1VAJ6SLPAU
	 UehF5TkAEBoqshNNQuJEotlatlknYDIG9fk+Rwh46cnihDITGCKd54Syl90hA1qc1+
	 VzbB4H3ZOnYxA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Apr 2024 00:39:11 +0300
Message-Id: <D0JBJJ3ZOR1E.29NIB5RSEJRSL@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Colin Ian King" <colin.i.king@gmail.com>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>
Cc: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] tpm/eventlog: remove redundant assignment to
 variabel ret
X-Mailer: aerc 0.17.0
References: <20240411084913.305780-1-colin.i.king@gmail.com>
In-Reply-To: <20240411084913.305780-1-colin.i.king@gmail.com>

On Thu Apr 11, 2024 at 11:49 AM EEST, Colin Ian King wrote:
> Variable ret is being assigned and error code that is never read, it is
> either being re-assigned in an error exit path or never referenced again
> on the non-error path. The assignment is redundant and can be removed.
>
> Cleans up clang scan build warning:
> drivers/char/tpm/eventlog/acpi.c:145:2: warning: Value stored to 'ret'
> is never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/char/tpm/eventlog/acpi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog=
/acpi.c
> index bd757d836c5c..69533d0bfb51 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -142,7 +142,6 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> =20
>  	log->bios_event_log_end =3D log->bios_event_log + len;
> =20
> -	ret =3D -EIO;
>  	virt =3D acpi_os_map_iomem(start, len);
>  	if (!virt) {
>  		dev_warn(&chip->dev, "%s: Failed to map ACPI memory\n", __func__);


Thanks!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

