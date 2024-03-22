Return-Path: <linux-kernel+bounces-111117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D1886821
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1401F24CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFAB17541;
	Fri, 22 Mar 2024 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uGcudsYy"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FF2F46;
	Fri, 22 Mar 2024 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095701; cv=none; b=gJRVbmBCScH+8DRWGuRWdnAyz6Z9HLCOho/ttHiDUFeHyz2NW9Onr4ZtSfOMJS0ZcsmRIYLTtdHgZbB0RVqOUPSZfDy5uX4LP2xHUzqKhoFxsbbduyCzGd4Slxw7xWEHBQNlV5EYBzNUkFbDNERzc8+yzu5rgCIVllUpR2xc50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095701; c=relaxed/simple;
	bh=ewmhF8p2BNAziJBnUqjLrvpzmasBxbmMDhQfQVcxowM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cnObhiXgWuP+PPMScdbxdGJquIfdwQF5+R5RvPMOD3EbI7R21IuuZ3yeFFp3yDAWEin2Qa6OhFKX6NnFR9FSwfwmzctxPpOCUVlGKGItgnDmJrvekyoxhLTKYqUzepCGOjtCM55AFTUl4oh16DZ2KoM41dI2sKhW4waur27xODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uGcudsYy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ewmhF8p2BNAziJBnUqjLrvpzmasBxbmMDhQfQVcxowM=; b=uGcudsYy3H2ntIDuq0eEz77iFD
	Ven69N2B6Vj6u+ZKVa2d90QgdJJBso7GMNTguAr/m8nh0s1Jffgg4D4v5FBqFhquAziDm9fSGHUu3
	S3xr87CC1CUklaIX/qTuLCw7GFk9wQMXs0DmAyvBGJDa6ZiKb5yjofTxv5HMexRIAmsEJTNDRRUMq
	5vFb2IvKG3zK2Yjaht1qEGs0TzL7P4lHByWhQpTzst0knJWXfGWg4pj5/rSNhZ3t+8YEO/xVYx5+y
	kP+ljH8qiw6HXTZaGUvjzN4pd37RBV71t016knNBCxsUlJ8VzGwNRcRj7RG2ZIcOMO7zZtI339WI9
	Bg5gu4wA==;
Received: from [2001:8b0:10b:5:9bbb:2be8:b21a:e5b8] (helo=u3832b3a9db3152.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rna9X-00000008otV-3VHG;
	Fri, 22 Mar 2024 08:21:27 +0000
Message-ID: <ee688cca986d95148a55e32fee48ceed8567f128.camel@infradead.org>
Subject: Re: [PATCH v1 0/4] virt: vmgenid: Add devicetree bindings support
From: David Woodhouse <dwmw2@infradead.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Landge, Sudan"
	 <sudanl@amazon.co.uk>, Rob Herring <robh@kernel.org>
Cc: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com, 
	dan.j.williams@intel.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, graf@amazon.de, bchalios@amazon.es, 
	xmarcalx@amazon.co.uk, ardb@kernel.org, benh <benh@kernel.crashing.org>
Date: Fri, 22 Mar 2024 08:21:27 +0000
In-Reply-To: <17611183-f288-47fe-a5e1-91ee16168db0@linaro.org>
References: <20240319143253.22317-1-sudanl@amazon.com>
	 <23692c07-98bd-477d-b244-bba14c50352c@linaro.org>
	 <38aad6c0e698c8e804694276d1762d61f2068ce8.camel@infradead.org>
	 <20240320161531.GA1810860-robh@kernel.org>
	 <60404403932a984d1f75d111ff53b9053af03579.camel@infradead.org>
	 <20240321133250.GA1600070-robh@kernel.org>
	 <db5a1027-93b7-4630-b679-8a654905dc48@amazon.co.uk>
	 <17611183-f288-47fe-a5e1-91ee16168db0@linaro.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-wTI71qcujqj3QPvFd8ky"
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-wTI71qcujqj3QPvFd8ky
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-03-22 at 06:40 +0100, Krzysztof Kozlowski wrote:
> On 21/03/2024 18:39, Landge, Sudan wrote:
> >=20
> >=20
> > On 21/03/2024 13:32, Rob Herring wrote:
> > > CAUTION: This email originated from outside of the organization. Do n=
ot click links or open attachments unless you can confirm the sender and kn=
ow the content is safe.
> > >=20
> > >=20
> > >=20
> > > On Wed, Mar 20, 2024 at 04:55:45PM +0000, David Woodhouse wrote:
> > > > On Wed, 2024-03-20 at 11:15 -0500, Rob Herring wrote:
> > > > > On Wed, Mar 20, 2024 at 01:50:43PM +0000, David Woodhouse wrote:
> > > > > > On Tue, 2024-03-19 at 16:24 +0100, Krzysztof Kozlowski wrote:
> > > > > > > On 19/03/2024 15:32, Sudan Landge wrote:
> > > > > > > > This small series of patches aims to add devicetree binding=
s support for
> > > > > > > > the Virtual Machine Generation ID (vmgenid) driver.
> > > > > > > >=20
> > > > > > > > Virtual Machine Generation ID driver was introduced in comm=
it af6b54e2b5ba
> > > > > > > > ("virt: vmgenid: notify RNG of VM fork and supply generatio=
n ID") as an
> > > > > > > > ACPI only device.
> > > > > > > > We would like to extend vmgenid to support devicetree bindi=
ngs because:
> > > > > > > > 1. A device should not be defined as an ACPI or DT only dev=
ice.
> > > > >=20
> > > > > This (and the binding patch) tells me nothing about what "Virtual
> > > > > Machine Generation ID driver" is and isn't really justification f=
or
> > > > > "why".
> > > >=20
> > > > It's a reference to a memory area which the OS can use to tell whet=
her
> > > > it's been snapshotted and restored (or 'forked'). A future submissi=
on
> > > > should have a reference to something like
> > > > https://www.qemu.org/docs/master/specs/vmgenid.html=C2=A0or the Mic=
rosoft
> > > > doc which is linked from there.
> > >=20
> > > That doc mentions fw_cfg for which we already have a binding. Why can=
't
> > > it be used/extended here?
> > QEMU has support for vmgenid but even they do not pass vmgenid directly=
=20
> > to the guest kernel using fw_cfg. QEMU passes the vmgenid/UUID via=20
> > fw_cfg to an intermediate UEFI firmware. This UEFI firmware, running as=
=20
> > a guest in QEMU, reads the UUID from fw_cfg and creates ACPI tables for=
=20
> > it. The UEFI firmware then passes the UUID information to the guest
> > kernel via ACPI.
> > This approach requires yet another intermediary which is UEFI firmware=
=20
> > and adds more complexity than ACPI for minimalist hypervisors that do=
=20
> > not have an intermediate bootloader today.
>=20
> What stops you from passing fw_cfg not to UEFI FW? BTW, no actual VM
> name was used in your posting, but now suddenly it is a talk about QEMU.

That would be possible. But not ideal. Just as exposing it via PCI
would be possible, but not ideal. Or forcing ACPI onto the guests in
question, and various other less efficient options.

If what we're really looking at here is a hostile takeover of the DT
bindings repository, with a blanket "No, DT is dead. Go use something
else, preferably ACPI", than all those other options are possible. We
*never* have to add a new binding to DT ever again. Let's just set the
existing bindings in stone and move on.

But hopefully that isn't the case. DT is the simplest and most
effective way to provide discovery, especially for embedded and microVM
systems. It isn't just a *workaround* for broken hardware which *can't*
do a slower and more complex form of discovery.=20

And it's absolutely the right thing to do for exposing the equivalent
of the ACPI vmgenid device in a system which isn't afflicted by ACPI
and doesn't *want* to be.


--=-wTI71qcujqj3QPvFd8ky
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwMzIyMDgyMTI3WjAvBgkqhkiG9w0BCQQxIgQg1PXPqx1Z
N9g6brBG2/tUztKugkIFwDG4Ra3BueK6j7gwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgA47szUmKKGscMO/vw4xvRgcqLIwRpJcbHh
xbHN6WMSE8WLMV0WHVYszwTV6Np8Fw2YO1t3f6tEO0infknoDQcJXmdRhZ91aHex1cT2THqfxT49
djot5kYlxgb1ETPX75KIEJ2arUsX3aK4rpWgYhZc13efAY7qRqyoxKWo33OBEK/0sAYHdJoEMoUp
Hupt72xTmBVHgV9DslcDAD/2ZHas+YXvfFF2Ss/PLgGNio3DM6AyTSXVwh9Lo7pmLGywi/9OG+Fv
6/3TnuqeyQexS+Gsq6eBfgLOaT3N36EqENKnT5t8xIgQdqn1eiDDpb4Q4DDjb2FPE9OCMaxBUp4j
MGCi0PIRescw4q/05yL4yBXS3EArjEe7VP5op5SkNMR4R6YY+ZcziRfU3+0OGjvhYV1mRdr1ec3M
SQB/CH9zcbg03hdloP2iQ0JaL13rLaQvkaApKHimOAOWD2nS+obnvckTgxDhXRMqwh7SXc/RFgew
tKJ7PTvA5przi9N0bFuNo8oqk3rhwqGkabqcYNq6tCcZI9ps7OX94trxSHPrBYzXKxOluPL8b66h
jh5I2YOwvCCvppHxLPakJ1+yW3l3/ZXNuuKGPxcwTNwlnNNYM84KPLJTKgNaBpWhpcbryQ8tebgj
y1ygAWOtFemQUsVYz/PsnmTNTPaoT46YlvSBx5eu8wAAAAAAAA==


--=-wTI71qcujqj3QPvFd8ky--

