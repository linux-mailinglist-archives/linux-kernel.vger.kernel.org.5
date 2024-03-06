Return-Path: <linux-kernel+bounces-93958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F187377F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470E61C21EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A2C131753;
	Wed,  6 Mar 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DpufhFl0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5C4131743
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730761; cv=none; b=qcOssI0A3u7gNujJMDNQOpSBNaejdajTNbZaV58yOQe77wNd2D+DSwSwg6NIkoPs9VM5kosWvj2zDBWVxBjDMy65xiXOgdNzS4GTBq+HZPaDQwp8ZUFSBgHtCA3pJ7NLQ+Cwja79w8s3zCh3e+YRNOU4w2jeogR8L7OZrZnGV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730761; c=relaxed/simple;
	bh=zc2zZ6M5U5YJr4cZh6IDmp+6jTvsRZlZFYiNFJlAj2M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT4V2F8KZpcIpbZT1av0NCG9tGizn7Ejz3d+clmQDfY5bY4XNKalWp/e4nzUN52eeyVIgD46kLYOuSUC4+x4ggTh85AdE1hzsblOLEMVTtXApHpZTRIWpKMZw8edncgh5ZOqcgC+kCx6UouBQz1QWcKRp8zE875RB5Xb1HWJcKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DpufhFl0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709730759; x=1741266759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zc2zZ6M5U5YJr4cZh6IDmp+6jTvsRZlZFYiNFJlAj2M=;
  b=DpufhFl0tHMBF+/bOZsP+Idw6ID45hbmOKdhES7g4N28A2Y+DUy0V3sw
   9Vquj3UQgRBIRxJBTO8cUZMF0yLvzcNtq53Jxf0bXO+AQ3Sjgrk4L4C/v
   Fg4EMlABLxpI42YBdO+1gAGWGqVTM/oxptNBjiVD9leO4/1A5BJRB0qZY
   SCg8G5iHxIY+tQU0uQ++pXu3QaqKzSJe98TQpLxsHgkrLnsxl6y4CtmiV
   zsovoigTUx36fl9dgTFEd00kkUW6s23kKlyvYDCruX0ZGqIUo5T9fNvMK
   ZCNg8kxX1ivuTN+7zOX4qtHA3TOPTZGPG/JsGNwwmzXE/WdZ4ABzWDWID
   Q==;
X-CSE-ConnectionGUID: It6AnLiDS5GINWmYX8VNaw==
X-CSE-MsgGUID: M2/mz+qiSvaT8qbC98gVHA==
X-IronPort-AV: E=Sophos;i="6.06,208,1705388400"; 
   d="asc'?scan'208";a="18925469"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2024 06:12:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 06:12:30 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 6 Mar 2024 06:12:28 -0700
Date: Wed, 6 Mar 2024 13:11:43 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang
	<jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, Eric Biggers
	<ebiggers@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr
	<lohr85@gmail.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/4] riscv: Only check online cpus for emulated
 accesses
Message-ID: <20240306-spry-retread-56d6c8dce327@wendy>
References: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
 <20240301-disable_misaligned_probe_config-v6-2-612ebd69f430@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CLY4JT0rzhj1XS62"
Content-Disposition: inline
In-Reply-To: <20240301-disable_misaligned_probe_config-v6-2-612ebd69f430@rivosinc.com>

--CLY4JT0rzhj1XS62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 05:45:33PM -0800, Charlie Jenkins wrote:
> The unaligned access checker only sets valid values for online cpus.
> Check for these values on online cpus rather than on present cpus.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwpr=
obe")

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  arch/riscv/kernel/traps_misaligned.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index 8ded225e8c5b..c2ed4e689bf9 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -632,7 +632,7 @@ void unaligned_emulation_finish(void)
>  	 * accesses emulated since tasks requesting such control can run on any
>  	 * CPU.
>  	 */
> -	for_each_present_cpu(cpu) {
> +	for_each_online_cpu(cpu) {
>  		if (per_cpu(misaligned_access_speed, cpu) !=3D
>  					RISCV_HWPROBE_MISALIGNED_EMULATED) {
>  			return;

I went looking to see what the practical differences were between
"present" and "possible", cos I'd never really seen much code using
"present". Turns out present and possible are essentially the same on
riscv. TIL.

--CLY4JT0rzhj1XS62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZehrjwAKCRB4tDGHoIJi
0nKQAQC/tSJTZ1Iyv8vL/KUSfV1d92ey0waFTZfCGSIMtUCNYgEA3wE18AO5OlwU
9ZQodv7iKYlcM9xT0XbN4zjDfJsrmAw=
=A42a
-----END PGP SIGNATURE-----

--CLY4JT0rzhj1XS62--

