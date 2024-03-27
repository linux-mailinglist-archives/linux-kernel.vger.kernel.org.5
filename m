Return-Path: <linux-kernel+bounces-121654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC7088EBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8D81C2F928
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB12514D45B;
	Wed, 27 Mar 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdznTPEg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0233014D6FE;
	Wed, 27 Mar 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558460; cv=none; b=fKOiS8djKlMkbmNnVdP2Xi2I6jzuS3e482JDPA80WthrIaAuKKhhdW/xQ+UkaAdS1pqn3U6fNYi1ibG/6bxiPoQz+JLZgIcTUMBbIsby4rdVtKFoFAfWzPd+Gnkvl8cpPNsf2IvIuS655LCGjeyK3hw/cvG6hplwfj5k04DmvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558460; c=relaxed/simple;
	bh=UuN+/yVlhFYfqrv1X4nW0lUiQAKVn7emAnsT71kKaNM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=oF3zoFyiGhkrAMuEZVx4ZIj08HX0PJoAE6526tDGg/G3kOvgcDPF6VrMCFCskLhLASxYExQSjpkixYKCTKvUtB7jPgBocNC3+K3Oy0Fh51iVdHPcWiy46leUmTtnsVc8Fe15dOQ1RpSB16/v535Gqk2hKDoeKaZwBNJ6JeFGV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdznTPEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AFCC43141;
	Wed, 27 Mar 2024 16:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711558459;
	bh=UuN+/yVlhFYfqrv1X4nW0lUiQAKVn7emAnsT71kKaNM=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=VdznTPEgYpRW2KJZteflSdemSgEbTzuadvjOPsPxT/etXe4Tp/Mi2l9GrR9WydQ0C
	 Vxx9DO2dr0szfSXJr+iijjnFWVPOQZyhZA55gSCfc33oIWhOPIEyWsmzTW8f1/mTDB
	 y29tQRHZTSoxB8pZ0RO/IQBYdAL+5eqwLxrTLSeY3vwtnV4OOD22b1MIQOkBx5/Tvv
	 FqLYdllfiSD34uHLnXph9IzqBWRVVi2ZehcMJg9bWYMjoOG2ioUk4+89PnHWjf2lgw
	 Zxfj9ieYwF33sat6lvfafnMEqN9mKNJ2lqZjZrWOBMtBEd2jNGLoNSFCvr3Kq1FKiU
	 i2aOUsIk5KjKw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Mar 2024 18:54:16 +0200
Message-Id: <D04OU424128P.22TP02GW2CJCT@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>
Cc: <linux-modules@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 "Roberto Sassu" <roberto.sassu@huawei.com>, <linux-kernel@vger.kernel.org>,
 "Ken Goldman" <kgold@linux.ibm.com>
Subject: Re: [PATCH] ima: define an init_module critical data record
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240327150019.81477-1-zohar@linux.ibm.com>
In-Reply-To: <20240327150019.81477-1-zohar@linux.ibm.com>

On Wed Mar 27, 2024 at 5:00 PM EET, Mimi Zohar wrote:
> The init_module syscall loads an ELF image into kernel space without
> measuring the buffer containing the ELF image.  To close this kernel
> module integrity gap, define a new critical-data record which includes
> the hash of the ELF image.
>
> Instead of including the buffer data in the IMA measurement list,
> include the hash of the buffer data to avoid large IMA measurement
> list records.  The buffer data hash would be the same value as the
> finit_module syscall file hash.
>
> To enable measuring the init_module buffer and other critical data from
> boot, define "ima_policy=3Dcritical_data" on the boot command line.  Sinc=
e
> builtin policies are not persistent, a custom IMA policy must include
> the rule as well: measure func=3DCRITICAL_DATA label=3Dmodules
>
> To verify the template data hash value, first convert the buffer data
> hash to binary:
> grep "init_module" \
> 	/sys/kernel/security/integrity/ima/ascii_runtime_measurements | \
> 	tail -1 | cut -d' ' -f 6 | xxd -r -p | sha256sum
>
> Reported-by: Ken Goldman <kgold@linux.ibm.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima_main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index c84e8c55333d..4b4348d681a6 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -902,6 +902,13 @@ static int ima_post_load_data(char *buf, loff_t size=
,
>  		return 0;
>  	}
> =20
> +	/*
> +	 * Measure the init_module syscall buffer containing the ELF image.
> +	 */
> +	if (load_id =3D=3D LOADING_MODULE)
> +		ima_measure_critical_data("modules", "init_module",
> +					  buf, size, true, NULL, 0);

No reason not to ack but could be just as well (passing checkpatch):

	if (load_id =3D=3D LOADING_MODULE)
		ima_measure_critical_data("modules", "init_module", buf, size, true, NULL=
, 0);

< 100 characters

> +
>  	return 0;
>  }
> =20

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

