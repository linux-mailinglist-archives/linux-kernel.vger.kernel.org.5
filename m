Return-Path: <linux-kernel+bounces-153659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160208AD141
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9742C1F2191D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B654915356C;
	Mon, 22 Apr 2024 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WBHK4xk1"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7B15351B;
	Mon, 22 Apr 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800979; cv=none; b=ONIJ3Bkf0sH5b7JhXL//o5+MHrTmBV52R/dfRXsZnme4iaR/bypctp1oHzpUTKmZqR+KIz8jnobOJ6/9696BVAzA7SJ4eKLFcF2qCO/jnDj7L9sTdgruPvcLnY33wHq49G4h1Efxs7zh5h5tU9kjaytrEfaRDaRvHwWOPe6Dq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800979; c=relaxed/simple;
	bh=FpzbmKBpBfnfyXLW7Lh81wIxgPVTiibsmpdt34q20oU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=u7EIi19fwckjM6T0YThuI9+Fux7dxKEexShl8LhrokXo4nLyM7WlgujA5J87plEoKHJzijUknKMhJZCq8+iBAyPkk/ln4WFFdVcnomH3xs+6noYUbsB/J+q7qlAs5HVYBjWHZBtp2pyEdOksUZ0MK3amRnZT1MMCI2Y+oRhuaac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WBHK4xk1; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Content-Type:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JDno8J617+nBHiH5IZPbxomNEQjErTff64KRZAzwmq4=; t=1713800977; x=1714232977;
	 b=WBHK4xk1KOxJFae+d8IJ4IEMFRbwNZ91GcMOzdOITzcCUXt9X6CpHcH+xu0NWYfm5/ovqcL9AS
	HhZdowmcot6cfu9iOdzAfxA01GH2AciM0oz6jOM8VCC32KVKzcrqj5HF93O2/KGjTtHxdp/O8XXGR
	7BpiUIaeZonCiOBeiw8aguarW6jZPLhgACeRexg1pxs99JeRhU4yX0SJ8w384O2KFzERiBU+w8tvG
	ESEI2BhbcW3hGeh4PWRtk4ZhKUdWQCUKGz7BVY8dNGmqkj5LTYwvPqixSh+S6kqfuOmRtPWXOAQvF
	fWENLebIFFjfHLQR1dm3vZvi1CI2oriefW6TQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ryvv8-0003u6-1S; Mon, 22 Apr 2024 17:49:30 +0200
Content-Type: multipart/mixed; boundary="------------sqA6wv5J0ekkT5wmPbH0C3p2"
Message-ID: <655ce2a3-eb04-4ade-999e-23fc5dc5fb3a@leemhuis.info>
Date: Mon, 22 Apr 2024 17:49:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 helpdesk@kernel.org, "workflows@vger.kernel.org"
 <workflows@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
 <20240417-lively-zebu-of-tact-efc8f3@lemur>
 <e7318984-7ef4-48cd-aae4-1deda3d711a5@leemhuis.info>
 <2024041734-gleeful-freewill-b24b@gregkh>
 <d4853f43-2538-4a92-9ac4-aff5c7b0893e@leemhuis.info>
 <2024041830-karaoke-aspirate-df00@gregkh>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <2024041830-karaoke-aspirate-df00@gregkh>
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1713800977;06866295;
X-HE-SMSGID: 1ryvv8-0003u6-1S

This is a multi-part message in MIME format.
--------------sqA6wv5J0ekkT5wmPbH0C3p2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[CCing Sasha]

On 18.04.24 15:20, Greg KH wrote:
> On Thu, Apr 18, 2024 at 09:04:53AM +0200, Thorsten Leemhuis wrote:
>> On 17.04.24 15:38, Greg KH wrote:
>>> On Wed, Apr 17, 2024 at 03:21:12PM +0200, Thorsten Leemhuis wrote:
>>>> On 17.04.24 14:52, Konstantin Ryabitsev wrote:
>>>>> On Wed, Apr 17, 2024 at 09:48:18AM +0200, Thorsten Leemhuis wrote:
>>>>>> Could you please create the email alias
>>>>>>
>>>>>>> How about:
>>>>>>> 	cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present
>>>>>>>
>>>>>>> and we can make that address be routed to /dev/null just like
>>>>>>> <stable@kernel.org> is?
>>>>
>>>> FWIW, we could go back to what I initially proposed: use the existing
>>>> stable tag with a pre-defined comment to mark patches that AUTOSEL et.
>>>> al. should not pick up:
>>>> https://lore.kernel.org/all/c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info/
>>>
>>> If you can pick a better string, possibly, yes.
>>
>> What did you think of Konstantin's
>>
>> Cc: stable+noautosel@kernel.org # Reason

@Greg, BTW: should this be stable+noautosel@kernel.org or have a 'vger.'
in it, e.g. stable+noautosel@vger.kernel.org? I assume without 'vger.'
is fine, just wanted to be sure, as
Documentation/process/stable-kernel-rules.rst in all other cases
specifies stable@vger.kernel.org, so people are likely to get confused.
:-/ #sigh

>> That looked like a good solution -- and I wondered why I did not come up
>> with that idea myself. Sure, "autosel" would also imply/mean "the
>> scripts/tools that look out for Fixes: tags", but does that matter?
> 
> We can live with this, sure. 

In that case I guess I now also have to fix the scripts to honor that tag.

@Greg: something like the attached for scripts/fixes_search perhaps? Was
that the right one and are there any other scripts that might need
something similar?

@Sasha: are the scripts around autosel online somewhere? They need a
similar change.

Ciao, Thorsten
--------------sqA6wv5J0ekkT5wmPbH0C3p2
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-scripts-fixes_search-honor-noautosel-tag.patch"
Content-Disposition: attachment;
 filename="0001-scripts-fixes_search-honor-noautosel-tag.patch"
Content-Transfer-Encoding: base64

RnJvbSAxZTk3M2EwNjliMDdmOGMwNDU0MDFhN2QzZDIwZWE3NjBhMjc0MjJmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9yc3RlbiBMZWVtaHVpcyA8bGludXhAbGVlbWh1
aXMuaW5mbz4KRGF0ZTogTW9uLCAyMiBBcHIgMjAyNCAxNzozMTowMSArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIHNjcmlwdHMvZml4ZXNfc2VhcmNoOiBob25vciBub2F1dG9zZWwgdGFnCgpJ
Z25vcmUgY29tbWl0cyB0aGF0IGNvbnRhaW4gYSBzb29uIHRvIGJlIGRvY3VtZW50ZWQgdGFn
IHRoYXQgaXMKbWVhbnQgdG8gZXhjbHVkZSBjb21taXRzIGZyb20gcHJvY2Vzc2luZyBieSBz
Y3JpcHRzIGxpa2UKc2NyaXB0cy9maXhlc19zZWFyY2guCgpMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyNDA0MTgzMC1rYXJhb2tlLWFzcGlyYXRlLWRmMDBAZ3JlZ2to
LyBbMV0KU2lnbmVkLW9mZi1ieTogVGhvcnN0ZW4gTGVlbWh1aXMgPGxpbnV4QGxlZW1odWlz
LmluZm8+Ci0tLQogc2NyaXB0cy9maXhlc19zZWFyY2ggfCA3ICsrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zY3JpcHRzL2ZpeGVzX3Nl
YXJjaCBiL3NjcmlwdHMvZml4ZXNfc2VhcmNoCmluZGV4IGFhYTEyZWMuLjk1MDUwOWYgMTAw
NzU1Ci0tLSBhL3NjcmlwdHMvZml4ZXNfc2VhcmNoCisrKyBiL3NjcmlwdHMvZml4ZXNfc2Vh
cmNoCkBAIC0xMzEsNiArMTMxLDEzIEBAIGZvciBjb21taXQgaW4gJChnaXQgcmV2LWxpc3Qg
LS1yZXZlcnNlIC0tbm8tbWVyZ2VzICIke2dpdF9yYW5nZX0iKTsgZG8KIAkjIGxvZ24gImNv
bW1pdCA9ICR7dHh0Z3JufSR7Y29tbWl0fSR7dHh0cnN0fQkiCiAJbG9nbiAiJHt0eHRncm59
JHtjb21taXR9JHt0eHRyc3R9CSIKIAorCSMgQ2hlY2sgaWYgd2UgYXJlIHN1cHBvc2VkIHRv
IGlnbm9yZSB0aGUgY29tbWl0CisJbm9fYXV0b3NlbD0kKGdpdCBsb2cgLTEgLS1mb3JtYXQ9
JyVCJyAiSEVBRCIgfCBncmVwIC1pICdeW1s6c3BhY2U6XV0qW0NjXVtDY106W1s6c3BhY2U6
XV0qPHN0YWJsZStub2F1dG9zZWxAJykKKwlpZiBbICIke25vX2F1dG9zZWx9IiBdIDsgdGhl
bgorCQlsb2cgIiR7dHh0Ymx1fWNvbnRhaW5zIG5vYXV0b3NlbCB0YWcke3R4dHJzdH0iCisJ
CWNvbnRpbnVlCisJZmkKKwogCSMgVHJ5IHRvIGZpbmQgIkZpeGVzIiB0YWcgaW4gY29tbWl0
CiAJZml4ZXNfbGluZXM9JChnaXQgbG9nIC0xIC0tZm9ybWF0PSclQicgIiR7Y29tbWl0fSIg
fCBncmVwIC1pICdeW1s6c3BhY2U6XV0qRml4ZXM6JykKIAlpZiBbICIke2ZpeGVzX2xpbmVz
fSIgPT0gIiIgXSA7IHRoZW4KLS0gCjIuNDQuMAoK

--------------sqA6wv5J0ekkT5wmPbH0C3p2--

