Return-Path: <linux-kernel+bounces-37881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B9F83B6FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F7E1C226BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EECC1860;
	Thu, 25 Jan 2024 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NTF2TQcT"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78F5232
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706148104; cv=none; b=gicbU8iDDaJ+4ljVrx4smbFvJtQbSoyUjW88td4HoA4UbMeeGLiOVbLqiZXJ5wEXS3M9Y+w8ksq4k00sYXITz0IbLjq9vc+al3+8g7UjaIDQIirG9O21CXDR2w6Eqvwo5UFDfmmHfIRTbl0f9ZLXyjg92TWIzzfTyw99e4Uk0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706148104; c=relaxed/simple;
	bh=L7rScDUkadYh/d3KjQe+8iZDG+h1qvpPwU7H3rKarec=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=tkn3BTmJvxjCMWWXp2pp5zWuPrsyb15/c8u9AUvYK9lo6fFozflrR3t/ExKhscV2/tPGQRyuH+FliVwVZJzOUbH81Aqk5Fq/smzy914B91jlJC4AFUikrISUj/hFX8g8e0TNfwIaYQzntBejnum7kMG3UEPmEt9rhpR2wf5IzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=NTF2TQcT; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40P20Mnt3949992
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 24 Jan 2024 18:00:24 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40P20Mnt3949992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706148038;
	bh=TP3gvB4O5zzE+BiCm9r/NxlSK6kkV76UP5ZO27vK2UY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NTF2TQcTpvHV4G03Pm0IxnZuLBynT0eNo1Jfpl4Hy+dRtU1s7ykadj7YBn80WVTn4
	 Hm8Y5YlTwd+KLAzthH39wGQIst2fScBZeai9iq9BoZy+EnWivKHXj8S6inBMO8BEQ8
	 scWHPscBNMg7pIUk1kCI5ADgpcVZviVkqVXYnY+Lo2PsuvYEAf9C6eygeDKZuPt0vU
	 Q4sdLdn4LQqoDD712ismRkG2aFd6dAsRARxeS5cjCvBpfwjJ1rjJh3Wto0cNplNK2m
	 ZizSy8boNKSsL5qbTxqPyuLRDg/757Tp2gwLlwQ8ebQ58i4mHk6Xqg6X7bRhJFPSPl
	 WJuKb+lWO3f4g==
Content-Type: multipart/mixed; boundary="------------lQrJ9OFVI4N0V27GzGVY0R30"
Message-ID: <c0527ca3-22c3-4b92-a34f-adf0cae78146@zytor.com>
Date: Wed, 24 Jan 2024 18:00:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/boot: Add a message about ignored early NMIs
To: =?UTF-8?B?Tk9NVVJBIEpVTklDSEko6YeO5p2RIOa3s+S4gCk=?=
 <junichi.nomura@nec.com>,
        Borislav Petkov <bp@alien8.de>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "nikunj@amd.com" <nikunj@amd.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "debarbos@redhat.com" <debarbos@redhat.com>,
        "jlelli@redhat.com" <jlelli@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "dzickus@redhat.com" <dzickus@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ZaEe8FC767f+sxRQ@jeru.linux.bs1.fc.nec.co.jp>
 <20240112120616.5zjojjmjeqg5egb7@box>
 <ZaTziftQSSg/v5Np@jeru.linux.bs1.fc.nec.co.jp>
 <20240123112624.GBZa-iYP1l9SSYtr-V@fat_crate.local>
 <TYCPR01MB8389C46BF755C31EACE8DB37837B2@TYCPR01MB8389.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <TYCPR01MB8389C46BF755C31EACE8DB37837B2@TYCPR01MB8389.jpnprd01.prod.outlook.com>

This is a multi-part message in MIME format.
--------------lQrJ9OFVI4N0V27GzGVY0R30
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/24/24 03:44, NOMURA JUNICHI(野村 淳一) wrote:
>> From: Borislav Petkov <bp@alien8.de>
>> On Mon, Jan 15, 2024 at 08:57:45AM +0000, NOMURA JUNICHI(野村 淳一) wrote:
>>> +	if (spurious_nmi_count) {
>>> +		error_putstr("Spurious early NMI ignored. Number of NMIs: 0x");
>>> +		error_puthex(spurious_nmi_count);
>>> +		error_putstr("\n");
>>
>> Uff, that's just silly:
>>
>> Spurious early NMIs ignored: 0x0000000000000017
>>
>> Would you like to add a error_putnum() or so in a prepatch which would
>> make this output
>>
>> Spurious early NMIs ignored: 23.
>>
>> ?
>>
>> So that it is human readable and doesn't make me wonder what that hex
>> value is supposed to mean?
> 
> Yes, it would be nicer to print that way.  I used the existing error_puthex() just
> to keep the patch minimal.  I will try to add error_putnum().
> 
>> Btw, please use this version when sending next time:
> 

Here is a *completely* untested patch for you...

	-hpa

--------------lQrJ9OFVI4N0V27GzGVY0R30
Content-Type: text/x-patch; charset=UTF-8; name="putnum.diff"
Content-Disposition: attachment; filename="putnum.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9taXNjLmMgYi9hcmNoL3g4
Ni9ib290L2NvbXByZXNzZWQvbWlzYy5jCmluZGV4IGI5OWUwOGU2ODE1Yi4uYmYyYWFjNGYx
OTVlIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvbWlzYy5jCisrKyBi
L2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9taXNjLmMKQEAgLTE2NCwyMSArMTY0LDM0IEBA
IHZvaWQgX19wdXRzdHIoY29uc3QgY2hhciAqcykKIAlvdXRiKDB4ZmYgJiAocG9zID4+IDEp
LCB2aWRwb3J0KzEpOwogfQogCi12b2lkIF9fcHV0aGV4KHVuc2lnbmVkIGxvbmcgdmFsdWUp
CitzdGF0aWMgbm9pbmxpbmUgdm9pZCBfX3B1dG51bSh1bnNpZ25lZCBsb25nIHZhbHVlLCB1
bnNpZ25lZCBpbnQgYmFzZSwKKwkJCSAgICAgIGludCBtaW5kaWcpCiB7Ci0JY2hhciBhbHBo
YVsyXSA9ICIwIjsKLQlpbnQgYml0czsKKwljaGFyIGJ1Zls4KnNpemVvZih2YWx1ZSkrMV07
CisJY2hhciAqcDsKIAotCWZvciAoYml0cyA9IHNpemVvZih2YWx1ZSkgKiA4IC0gNDsgYml0
cyA+PSAwOyBiaXRzIC09IDQpIHsKLQkJdW5zaWduZWQgbG9uZyBkaWdpdCA9ICh2YWx1ZSA+
PiBiaXRzKSAmIDB4ZjsKKwlwID0gYnVmICsgc2l6ZW9mKGJ1Zik7CisJKi0tcCA9ICdcMCc7
CiAKLQkJaWYgKGRpZ2l0IDwgMHhBKQotCQkJYWxwaGFbMF0gPSAnMCcgKyBkaWdpdDsKLQkJ
ZWxzZQotCQkJYWxwaGFbMF0gPSAnYScgKyAoZGlnaXQgLSAweEEpOworCXdoaWxlIChtaW5k
aWctLSA+IDAgfHwgdmFsdWUpIHsKKwkJdW5zaWduZWQgY2hhciBkaWdpdCA9IHZhbHVlICUg
YmFzZTsKKwkJZGlnaXQgKz0gKGRpZ2l0ID49IDEwKSA/ICgnYSctMTApIDogJzAnOworCQkq
LS1wID0gZGlnaXQ7CiAKLQkJX19wdXRzdHIoYWxwaGEpOworCQl2YWx1ZSAvPSBiYXNlOwog
CX0KKworCV9fcHV0c3RyKHApOworfQorCit2b2lkIF9fcHV0aGV4KHVuc2lnbmVkIGxvbmcg
dmFsdWUpCit7CisJX19wdXRudW0odmFsdWUsIDE2LCBzaXplb2YodmFsdWUpKjIpOworfQor
Cit2b2lkIF9fcHV0ZGVjKHVuc2lnbmVkIGxvbmcgdmFsdWUpCit7CisJX19wdXRudW0odmFs
dWUsIDEwLCAxKTsKIH0KIAogI2lmZGVmIENPTkZJR19YODZfTkVFRF9SRUxPQ1MKZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9taXNjLmggYi9hcmNoL3g4Ni9ib290
L2NvbXByZXNzZWQvbWlzYy5oCmluZGV4IGJjMmYwZjE3ZmI5MC4uNjUwMmJjNjlkMWI4IDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvbWlzYy5oCisrKyBiL2FyY2gv
eDg2L2Jvb3QvY29tcHJlc3NlZC9taXNjLmgKQEAgLTYzLDggKzYzLDEwIEBAIHZvaWQgKm1h
bGxvYyhpbnQgc2l6ZSk7CiB2b2lkIGZyZWUodm9pZCAqd2hlcmUpOwogdm9pZCBfX3B1dHN0
cihjb25zdCBjaGFyICpzKTsKIHZvaWQgX19wdXRoZXgodW5zaWduZWQgbG9uZyB2YWx1ZSk7
Cit2b2lkIF9fcHV0ZGVjKHVuc2lnbmVkIGxvbmcgdmFsdWUpOwogI2RlZmluZSBlcnJvcl9w
dXRzdHIoX194KSAgX19wdXRzdHIoX194KQogI2RlZmluZSBlcnJvcl9wdXRoZXgoX194KSAg
X19wdXRoZXgoX194KQorI2RlZmluZSBlcnJvcl9wdXRkZWMoX194KSAgX19wdXRkZWMoX194
KQogCiAjaWZkZWYgQ09ORklHX1g4Nl9WRVJCT1NFX0JPT1RVUAogCg==

--------------lQrJ9OFVI4N0V27GzGVY0R30--

