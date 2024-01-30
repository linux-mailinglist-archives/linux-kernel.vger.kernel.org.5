Return-Path: <linux-kernel+bounces-45031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CF8842AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D437D288C77
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116C512BEBE;
	Tue, 30 Jan 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV1DFHzY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992512836C;
	Tue, 30 Jan 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635173; cv=none; b=SQlx9ARxMTm7Ano0jF8EgKHpE7MlUo0PE8K7JMfEXUfoysPhrKKvcusU8ryTT8vy5SfAsiRYAYdUQZM74LQif+jPWGXSK4dWzNrAH9ufQQqjVh/G4e/BGU15IdU/tB+eRzACduUntZ4yLNQ3ZVhsLCF3fOjsoreY1vL7rJ2Ql20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635173; c=relaxed/simple;
	bh=V7diJ4YqO6S1GcyDtkgjCTNRmeE4ZsUI1fbKWHRDOzA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GsKXGFy8KbrAmRtdHGQO3PA+pCfji268zombttv58rYNpl9ptuhjF3uDr6OFft8YxtnNEnwyNOGNmbwTCzeWibMZwGxyU84KMtfQRmPSCjFgMCqL0pgrsoS7urQfYSqwUgnrXuXSnciwSEph4opzuit0n6Ehf+6767xw2BRB91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV1DFHzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709EFC433C7;
	Tue, 30 Jan 2024 17:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706635172;
	bh=V7diJ4YqO6S1GcyDtkgjCTNRmeE4ZsUI1fbKWHRDOzA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=TV1DFHzYDZhW59OLkmEAT5zHp3Om+RiE56/Rs+zzt2cYC51I696Ozv4XqGyYhfvLs
	 DiMhVVHFj37CPiUvZdXlMkSTNCyTF43+XZPTAny/wk4lgvcxXTU8ynkhZy5m7EqyYa
	 LTJrrhFygZkqmEFYNAQ7/MAYdFxl29FT5xcXmYYPZ9P2JQRNHgqpd9kp1C+N4smMr9
	 r5ontZ1b86UZ82H6/KIlrEPWd0eieYpSNHwHLZnKHA9YCpp+usbxb7LfQsqwyDs9zb
	 Ahk84q+dt3xhTMzPIzA+m+C65eIWL/j+4uwnP4s+wpzO3N82ossDdMVCL2hnK/Xv+u
	 Qmzjuli3IDvew==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jan 2024 19:19:27 +0200
Message-Id: <CYS7OCDQ54WZ.3RS9IWCQG4Y5L@suppilovahvero>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Williams, Dan J"
 <dan.j.williams@intel.com>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "nvdimm@lists.linux.dev"
 <nvdimm@lists.linux.dev>
Subject: Re: [PATCH] KEYS: encrypted: Add check for strsep
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "zohar@linux.ibm.com"
 <zohar@linux.ibm.com>, "paul@paul-moore.com" <paul@paul-moore.com>,
 "dhowells@redhat.com" <dhowells@redhat.com>, "yaelt@google.com"
 <yaelt@google.com>, "serge@hallyn.com" <serge@hallyn.com>,
 "nichen@iscas.ac.cn" <nichen@iscas.ac.cn>, "sumit.garg@linaro.org"
 <sumit.garg@linaro.org>, "jmorris@namei.org" <jmorris@namei.org>
X-Mailer: aerc 0.15.2
References: <20231108073627.1063464-1-nichen@iscas.ac.cn>
 <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>
In-Reply-To: <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>

On Wed Jan 24, 2024 at 8:21 PM EET, Verma, Vishal L wrote:
> On Wed, 2023-11-08 at 07:36 +0000, Chen Ni wrote:
> > Add check for strsep() in order to transfer the error.
> >=20
> > Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-
> > provided decrypted data")
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > ---
> > =C2=A0security/keys/encrypted-keys/encrypted.c | 4 ++++
> > =C2=A01 file changed, 4 insertions(+)
> >=20
> > diff --git a/security/keys/encrypted-keys/encrypted.c
> > b/security/keys/encrypted-keys/encrypted.c
> > index 8af2136069d2..76f55dd13cb8 100644
> > --- a/security/keys/encrypted-keys/encrypted.c
> > +++ b/security/keys/encrypted-keys/encrypted.c
> > @@ -237,6 +237,10 @@ static int datablob_parse(char *datablob, const
> > char **format,
> > =C2=A0			break;
> > =C2=A0		}
> > =C2=A0		*decrypted_data =3D strsep(&datablob, " \t");
> > +		if (!*decrypted_data) {
> > +			pr_info("encrypted_key: decrypted_data is
> > missing\n");
> > +			break;
> > +		}
>
> Hello,
>
> This patch seems to break keyring usage in CXL and NVDIMM, with the
> "decrypted_data is missing" error path being hit. Reverting this commit
> fixes the tests. I'm not sure if there are valid scenarios where this is
> expected to be empty?
>
> Here's an strace snippet of where the error occurs:
>
>    keyctl(KEYCTL_SEARCH, KEY_SPEC_USER_KEYRING, "user", "nvdimm-master", =
0) =3D 76300785
>    openat(AT_FDCWD, "/sys/devices/platform/cxl_acpi.0/root0/nvdimm-bridge=
0/ndbus0/nmem0/state", O_RDONLY|O_CLOEXEC) =3D 3
>    read(3, "idle\n", 1024)                 =3D 5
>    close(3)                                =3D 0
>    keyctl(KEYCTL_SEARCH, KEY_SPEC_USER_KEYRING, "encrypted", "nvdimm:0", =
0) =3D -1 ENOKEY (Required key not available)
>    uname({sysname=3D"Linux", nodename=3D"fedora", ...}) =3D 0
>    newfstatat(AT_FDCWD, "/etc/ndctl/keys/nvdimm_0_fedora.blob", 0x7fff23f=
bc210, 0) =3D -1 ENOENT (No such file or directory)
>    add_key("encrypted", "nvdimm:0", "new enc32 user:nvdimm-master 32", 31=
, KEY_SPEC_USER_KEYRING) =3D -1 EINVAL (Invalid argument)
>   =20

I think removing the klog message does not make sense meaning
that the recent revert was wrong action taken.

Instead necessary actions to retain backwards compatibility
must be taken, meaning that the branch should set "ret =3D 0;".

Motivation to keep it is dead obvious: your examples show that
it can reveal potentially incorrect behaviour in user space
software packages. It is info-level to mark that it can be
also false positive. I.e. the revert commit takes away
functionality that previously caused kernel masking a
potential bug.

Please revert the revert.

BR, Jarkko


