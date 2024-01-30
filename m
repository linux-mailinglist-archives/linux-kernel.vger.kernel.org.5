Return-Path: <linux-kernel+bounces-45032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9F2842ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF6D1C24FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C1F1292D0;
	Tue, 30 Jan 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uB/iUg4J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8159364AC;
	Tue, 30 Jan 2024 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635224; cv=none; b=TUqcOmtKeoKppyr2f3VspgB5WTiVuEetHanGOBFS6PSp/+KbSMRhSHCUp9Klh1FaY3CkivHFubC50VTTUJmaNrVUXTtWukUreqoWor2u3BQ9MgbpfhRu9sYUmuE8ZKoBIQoGMMT97aLEvMsUai4mxJpuAKBMaOVNNBpt7DzgfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635224; c=relaxed/simple;
	bh=yd0LIoYb6RMZkeRHe2+uLX6chAwA3W/kYb0I/6Z7rbA=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jFr/xRnUple4EqTVHWCqVbvDBh7jkB/LRPJhUkXE9gzNVo1x8Oly568FW8Hos9JoG1qUWDQ7gHmuCW8C45mNos6jtN1r691lcYQJpjHLVVCqAJ+mST0RoHr21p22grvSY5509JWRCXjKIjb5DxsVBEqGSNzf6IsvFmxzDTZYEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uB/iUg4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8217AC433C7;
	Tue, 30 Jan 2024 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706635224;
	bh=yd0LIoYb6RMZkeRHe2+uLX6chAwA3W/kYb0I/6Z7rbA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uB/iUg4JZ4B+omyXHjyZK2SGuWHBL7QKCZuMAke6JmpTJS6pi+MOueBbl+9O8EWSa
	 Qi9Po5utKks8La3c7HYPvSR0WgPetrYXDWjLHgLV09FPUq8povDcj5Z5Wh/lON/oHJ
	 0R+Dq8wvy/FF0BwSzdzlkITTclCwiYEpzdPyw/Z/eQoowZ8y0qrOmazIBq4YT8vKlp
	 lrJEgfsHmJbBTGWxll1+JcmTSf5pe75TMHIDwjk0GWGooIfgcWWHqdELTxruLdzMwB
	 XZGEbd7eCgkShwBtQpwoS4BqhAbGvnFYcIJH5aJK4bF0Qsrzbib+o2TW6sGWv6RJhC
	 pI4onO9EZ1MwA==
Content-Type: multipart/mixed;
 boundary=cd8ba6b13b7a1f2b1f2526f12f6cd200967ddb0152adf8a67df1cb348e72
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 30 Jan 2024 19:20:18 +0200
Message-Id: <CYS7OZUB3DQZ.5DGIZ3CKSM8G@suppilovahvero>
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
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Verma, Vishal L"
 <vishal.l.verma@intel.com>, "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
 "paul@paul-moore.com" <paul@paul-moore.com>, "dhowells@redhat.com"
 <dhowells@redhat.com>, "yaelt@google.com" <yaelt@google.com>,
 "serge@hallyn.com" <serge@hallyn.com>, "nichen@iscas.ac.cn"
 <nichen@iscas.ac.cn>, "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
 "jmorris@namei.org" <jmorris@namei.org>
X-Mailer: aerc 0.15.2
References: <20231108073627.1063464-1-nichen@iscas.ac.cn>
 <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>
 <CYS7OCDQ54WZ.3RS9IWCQG4Y5L@suppilovahvero>
In-Reply-To: <CYS7OCDQ54WZ.3RS9IWCQG4Y5L@suppilovahvero>

--cd8ba6b13b7a1f2b1f2526f12f6cd200967ddb0152adf8a67df1cb348e72
Content-Type: multipart/alternative;
 boundary=881a4053c71afff8675be592295d16a64045cfd6f860722a752edc836342

--881a4053c71afff8675be592295d16a64045cfd6f860722a752edc836342
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Tue Jan 30, 2024 at 7:19 PM EET, Jarkko Sakkinen wrote:
> On Wed Jan 24, 2024 at 8:21 PM EET, Verma, Vishal L wrote:
> > On Wed, 2023-11-08 at 07:36 +0000, Chen Ni wrote:
> > > Add check for strsep() in order to transfer the error.
> > >=20
> > > Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-
> > > provided decrypted data")
> > > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > > ---
> > > =C2=A0security/keys/encrypted-keys/encrypted.c | 4 ++++
> > > =C2=A01 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/security/keys/encrypted-keys/encrypted.c
> > > b/security/keys/encrypted-keys/encrypted.c
> > > index 8af2136069d2..76f55dd13cb8 100644
> > > --- a/security/keys/encrypted-keys/encrypted.c
> > > +++ b/security/keys/encrypted-keys/encrypted.c
> > > @@ -237,6 +237,10 @@ static int datablob_parse(char *datablob, const
> > > char **format,
> > > =C2=A0			break;
> > > =C2=A0		}
> > > =C2=A0		*decrypted_data =3D strsep(&datablob, " \t");
> > > +		if (!*decrypted_data) {
> > > +			pr_info("encrypted_key: decrypted_data is
> > > missing\n");
> > > +			break;
> > > +		}
> >
> > Hello,
> >
> > This patch seems to break keyring usage in CXL and NVDIMM, with the
> > "decrypted_data is missing" error path being hit. Reverting this commit
> > fixes the tests. I'm not sure if there are valid scenarios where this i=
s
> > expected to be empty?
> >
> > Here's an strace snippet of where the error occurs:
> >
> >    keyctl(KEYCTL_SEARCH, KEY_SPEC_USER_KEYRING, "user", "nvdimm-master"=
, 0) =3D 76300785
> >    openat(AT_FDCWD, "/sys/devices/platform/cxl_acpi.0/root0/nvdimm-brid=
ge0/ndbus0/nmem0/state", O_RDONLY|O_CLOEXEC) =3D 3
> >    read(3, "idle\n", 1024)                 =3D 5
> >    close(3)                                =3D 0
> >    keyctl(KEYCTL_SEARCH, KEY_SPEC_USER_KEYRING, "encrypted", "nvdimm:0"=
, 0) =3D -1 ENOKEY (Required key not available)
> >    uname({sysname=3D"Linux", nodename=3D"fedora", ...}) =3D 0
> >    newfstatat(AT_FDCWD, "/etc/ndctl/keys/nvdimm_0_fedora.blob", 0x7fff2=
3fbc210, 0) =3D -1 ENOENT (No such file or directory)
> >    add_key("encrypted", "nvdimm:0", "new enc32 user:nvdimm-master 32", =
31, KEY_SPEC_USER_KEYRING) =3D -1 EINVAL (Invalid argument)
> >   =20
>
> I think removing the klog message does not make sense meaning
> that the recent revert was wrong action taken.
>
> Instead necessary actions to retain backwards compatibility
> must be taken, meaning that the branch should set "ret =3D 0;".
>
> Motivation to keep it is dead obvious: your examples show that
> it can reveal potentially incorrect behaviour in user space
> software packages. It is info-level to mark that it can be
> also false positive. I.e. the revert commit takes away
> functionality that previously caused kernel masking a
> potential bug.
>
> Please revert the revert.
>
> BR, Jarkko

See the attached patch.

BR, Jarkko

--881a4053c71afff8675be592295d16a64045cfd6f860722a752edc836342--

--cd8ba6b13b7a1f2b1f2526f12f6cd200967ddb0152adf8a67df1cb348e72
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=0001-KEYS-encrypted-Return-0-for-empty-decrypted-data.patch
Content-Type: text/x-patch; charset=utf-8;
 name=0001-KEYS-encrypted-Return-0-for-empty-decrypted-data.patch

RnJvbSBjZGZhNDIwM2M4NjQxMmFmMzliMjMyZWFhNzQwMTU5MTQ1MTY1OWRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgpE
YXRlOiBUdWUsIDMwIEphbiAyMDI0IDE5OjExOjUwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gS0VZ
UzogZW5jcnlwdGVkOiBSZXR1cm4gMCBmb3IgZW1wdHkgZGVjcnlwdGVkIGRhdGEKClJldHVybiAw
IHRvIHJldHVybiBiYWNrd2FyZHMgY29tcHRpYmlsaXR5IGJ1dCAqZG8ga2VlcCogdGhlIGtsb2cg
ZW50cnkKZm9yIGZvcmVzaW5jcyBzYWtlLgoKRml4ZXM6IGI0YWYwOTZiNWRmNSAoIktFWVM6IGVu
Y3J5cHRlZDogQWRkIGNoZWNrIGZvciBzdHJzZXAiKQpMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9rZXlyaW5ncy80ZDM0NjViNDhiOWM1YTg3ZGViMzg1YjE1YmY1MTI1ZmMxNzA0MDE5LmNh
bWVsQGludGVsLmNvbS8KU2lnbmVkLW9mZi1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2Vy
bmVsLm9yZz4KLS0tCiBzZWN1cml0eS9rZXlzL2VuY3J5cHRlZC1rZXlzL2VuY3J5cHRlZC5jIHwg
MSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9zZWN1cml0
eS9rZXlzL2VuY3J5cHRlZC1rZXlzL2VuY3J5cHRlZC5jIGIvc2VjdXJpdHkva2V5cy9lbmNyeXB0
ZWQta2V5cy9lbmNyeXB0ZWQuYwppbmRleCA3NmY1NWRkMTNjYjguLmUzMTczMTQxMDI3ZSAxMDA2
NDQKLS0tIGEvc2VjdXJpdHkva2V5cy9lbmNyeXB0ZWQta2V5cy9lbmNyeXB0ZWQuYworKysgYi9z
ZWN1cml0eS9rZXlzL2VuY3J5cHRlZC1rZXlzL2VuY3J5cHRlZC5jCkBAIC0yMjUsNiArMjI1LDcg
QEAgc3RhdGljIGludCBkYXRhYmxvYl9wYXJzZShjaGFyICpkYXRhYmxvYiwgY29uc3QgY2hhciAq
KmZvcm1hdCwKIAkJKmRlY3J5cHRlZF9kYXRhbGVuID0gc3Ryc2VwKCZkYXRhYmxvYiwgIiBcdCIp
OwogCQlpZiAoISpkZWNyeXB0ZWRfZGF0YWxlbikgewogCQkJcHJfaW5mbygiZW5jcnlwdGVkX2tl
eToga2V5bGVuIHBhcmFtZXRlciBpcyBtaXNzaW5nXG4iKTsKKwkJCXJldCA9IDA7CiAJCQlnb3Rv
IG91dDsKIAkJfQogCX0KLS0gCjIuNDAuMQoK
--cd8ba6b13b7a1f2b1f2526f12f6cd200967ddb0152adf8a67df1cb348e72--

