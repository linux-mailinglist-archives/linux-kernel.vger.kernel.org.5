Return-Path: <linux-kernel+bounces-97066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC5D87650E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64E2281C89
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0655C225CE;
	Fri,  8 Mar 2024 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="Z4ifZzY7"
Received: from outgoing1.flk.host-h.net (outgoing1.flk.host-h.net [188.40.0.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4432C1EEE9;
	Fri,  8 Mar 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904118; cv=none; b=qL4oGsnHUVYHX4cUtHUOtP2voqE/AlWZt3J0AMYoxfyS3PAN+Hw/iyFRF3zKENlj4pkwRf6gs7fTGFy/RtRVk71hPa4ulAl13Sht9acSE4dtxt+fC2eOZsrPZ25+4rF2lqHqJB+cLuSkdZ+zvJsxBUTz4drMJ006WbMproKzbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904118; c=relaxed/simple;
	bh=zeUib85jZcQhoa3IiCkBV25TPD8WzpxP7R4+2D41mEo=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=GDlGz80/1286vIHxVu29iFAlgneW+JKWJp6K9YeOXYJUGAwNjXncbjTKnzPRep7cg2K57jT82GXVcOEUhViwmYA5ZYMqe57Bz8qEZmfxcJiS0TamRxxp0nvWP+mIUbDb6FL0DbaZe15E4whqNuV9D1pjAsvjSQYtDQY1PSGwbO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=Z4ifZzY7; arc=none smtp.client-ip=188.40.0.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=ObvZZnhqWGMMI4j2NDLft9bUQX4DpsXHSeMG4OORKkw=; b=Z4ifZzY7EFOSBl
	bfNwVlfUzqlHP03HuxgoOCSCCl48qdE9/Ah2FQxCue3ZJbiJ37e4wOro0gYTKoXY9vk9CISeT1aAY
	vVC62HCa5+G5FRinzgL/kYqFCKf5TESpoL3Wz80oQ5q3c4X2pEsW+QS4pQICN5rfl8b1BigPAI6D5
	+k7VO2Ensq0vUZBxlAPKm++oMmnwk8slRia+WEpmMYxsoJUg24MzvFv3kytpz3vw4ROjB3EKebJiR
	9rfyBbCo1eNf+Lpz7VNqOi8D4PFvjo1FlOijNII1qXfaQAEMjHAUFLZydPVxinWJddty6o4Cf45Q1
	42HAVyVxPoJy3RiR4/4A==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam3-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1riaAT-004l26-AV; Fri, 08 Mar 2024 15:21:48 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1riaAS-0000N5-92; Fri, 08 Mar 2024 15:21:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Fri, 08 Mar 2024 15:21:44 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] mips: dts: ralink: mt7621: add cell count properties
 to usb
In-Reply-To: <c445fd12-f8a8-41df-bee8-8b126b26110b@arinc9.com>
References: <0001-mips-dts-ralink-mt7621-add-cell-count-properties-to-.patch>
 <20240307223756.31643-1-justin.swartz@risingedge.co.za>
 <c445fd12-f8a8-41df-bee8-8b126b26110b@arinc9.com>
Message-ID: <067071a9d57ffb09f437718cf905b121@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+eZKPMCAkNhsVy7Wze5JuSPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJ3345q/s6ySNrGnXycmhg3OV3zLgvFM9V92BlAE9xGCJ0
 xYCHwzEoZpUBagq+YQPMLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz30+tdk6yIuh9K7v+Nq0Cm3JVhle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVAT1rE1/vP68Bb4z3v3h3gCdXrv2+9GnNX30LKqXb
 fwFKgm/rnYBl+Mj5KqOl6Jzub/f3QhLRbOgisvi5VU9eNBtgo6zjiatjNO/pnMCjuIvXs/AyV/Ns
 URB/R+FlEHyAzksgfaRvdgw0WK34QWnzHHMcN6qoXPjenLhIOF1oeRYbjF1Hp647mOWoQlc3hL3c
 dBMSQgQtiTUcJp5roVy0aeRaEElbOe2fP+D3ZzQfg594u/m4iBmYb1/LCV4/EuVHup06w3Vwxf9C
 F7D6LKKRTfdjzQ6YC7Heg3Xf7O1TOd6RcY/MXB8eEq3bCN2QohZvyS03iBmgsz450Kmjd3fGV9di
 8pECEDQlq6/G7i+xG+VFX/95gERVFH1TbKdKoLY3Ibtf63VNbf0lrvssY+k7AHGi1NevGWTo2+h8
 Lhk4HCeZR7ymlGVRtthBJ2y8A5arx6JItKpFaUNPGMMlvbMX0nyK1NiAJ0y2Qvvn6ds6mor35w4f
 SfHzQbABJfgy21HclcZkPRq7NhoxyMwqi8Q23Rgadfh5T5n5D4OHHpbEIgsllZKWnzc5M5WlNtVJ
 qo05MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net


On 2024-03-08 14:01, Arınç ÜNAL wrote:
> On 8.03.2024 01:37, Justin Swartz wrote:
>> Add default #address-cells and #size-cells properties to the
>> usb node, which should be suitable for hubs and devices without
>> explicitly declared interface nodes, as:
>> 
>>    "#address-cells":
>>      description: should be 1 for hub nodes with device nodes,
>>        should be 2 for device nodes with interface nodes.
>>      enum: [1, 2]
>> 
>>    "#size-cells":
>>      const: 0
>> 
>> -- Documentation/devicetree/bindings/usb/usb-device.yaml
>> 
>> This version of the patch places the properties according to
>> the order recommended by:
>> 
>>     Documentation/devicetree/bindings/dts-coding-style.rst
>> 
>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>> ---
>>   arch/mips/boot/dts/ralink/mt7621.dtsi | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi 
>> b/arch/mips/boot/dts/ralink/mt7621.dtsi
>> index 5a89f0b8c..7532e17dd 100644
>> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
>> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
>> @@ -289,10 +289,10 @@ usb: usb@1e1c0000 {
>>   		reg = <0x1e1c0000 0x1000
>>   		       0x1e1d0700 0x0100>;
>>   		reg-names = "mac", "ippc";
>> -
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>>   		clocks = <&sysc MT7621_CLK_XTAL>;
>>   		clock-names = "sys_ck";
>> -
> 
> Please keep the empty lines. It's easier to read. I don't see anything 
> on
> the Devicetree Sources (DTS) Coding Style that would restrict this.

The reason I removed them was due to the SoC DTSI example shown in [1]
lacking empty lines between properties, but then using them instead as
visual separation between properties and child nodes, or at least that's
how I understood it when I looked at it.

Personally, I prefer the look of the SoC DTSI example - but I don't mind
recreating the patch set with the empty lines between the properties 
left
entact.

As there is a mix of property spacing and ordering styles in mt7621.dtsi
already - what is the consensus on what a node in this file should look
like?

I also don't mind following that pattern and cleaning up the whole dtsi
according to that if it'll save us all time and energy in future.

Regards
Justin

[1] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

