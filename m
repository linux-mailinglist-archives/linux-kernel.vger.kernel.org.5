Return-Path: <linux-kernel+bounces-97122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A83788765C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19DC8B23A77
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD593FBB9;
	Fri,  8 Mar 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="SRSXzERu"
Received: from outgoing1.flk.host-h.net (outgoing1.flk.host-h.net [188.40.0.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666D38387;
	Fri,  8 Mar 2024 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906271; cv=none; b=BGQdIOtyeXd7/fifhc6a/4MJ3g9RiklRGAVXKCW+pvwELXJbUd8AuWslHrZ3HtwUGzrLezKdwoPb/XOistknV1kHe6RHnmSRj56jfmFOx7uP2C3QU1fAp6HTlzCATCB+3+gSBUKrGoV2v8cJqRNdSrvOce8sknUF5mUrhtKiSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906271; c=relaxed/simple;
	bh=s1yRWFU/8a5J/AuyuFdQnIru5Py6AN63sQIEhF2K4Z4=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=WMt7eaPUFjemhvHe0onNMcCUX1yptA8pMqpLlqmGz5I9flxR7onqgDgg7aTrwb2eOzC/HhmF8Q728D46MbnXcqlvt4l3wbRmCf4qo5VFVhJShgSPJgsbs2njHoXI5curRuwPeCksS1xyJWS4tsPQs41SswNa2IyK8WdezG6+GIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=SRSXzERu; arc=none smtp.client-ip=188.40.0.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=mblih+4aRiBhJNw99bnE5slZmsY2YvDP13y7ErXtuoU=; b=SRSXzERuTXXSsb
	AeuUkB8vc5rker87kqmefLj1SruVVlLnyP6JkTWSTxKuSTO3KZYsGzcajBzNFJQDxoEzmLk/B3bnA
	OhwjnPDupK2CM/bPj7zTUgmoTQbcxTiJDiurAhN7LkiN8WTqKrXWiPEeRqgzBhDvtV0JkPt28jjw2
	YWOftRtv0QRvsb04zWpyJMi3dspNYb3quHySberinV3A5dJmdXdqeTqBro7gsRfCl5Q2iTCSsWDjw
	LL6vnAIbsWlZDIgpfpE/1Qh+qK7nCNEMeFx0V/ib+IFHRmoZORfs2Xij037RfoslogfMCCiLrIZFW
	k3Ebe8K9o5dEJXSbauKg==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam3-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1riajH-0054fZ-My; Fri, 08 Mar 2024 15:57:45 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1riajH-0007lj-3t; Fri, 08 Mar 2024 15:57:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Fri, 08 Mar 2024 15:57:42 +0200
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
In-Reply-To: <7e9221ae-e53b-475f-9b6f-4cab58b2d109@arinc9.com>
References: <0001-mips-dts-ralink-mt7621-add-cell-count-properties-to-.patch>
 <20240307223756.31643-1-justin.swartz@risingedge.co.za>
 <c445fd12-f8a8-41df-bee8-8b126b26110b@arinc9.com>
 <067071a9d57ffb09f437718cf905b121@risingedge.co.za>
 <7e9221ae-e53b-475f-9b6f-4cab58b2d109@arinc9.com>
Message-ID: <59b0b2084ea1322c3db2bfe9f2c2c702@risingedge.co.za>
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
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT91LYmA7WyhHcEQsf7WsZ3VPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIFDZRrTGv3rxiw9tFrqFSCFNiLZt/QXQnOBRD+jq1HsKsDh/6
 Srgk2K3gr1VBfJbChkYH6fbrypLNrde+UooQVNLReLErukdelEOHUIpaBbp5GdnsN8+UvimwMinK
 0+Txhz2u9qvrL2PODYgMZQApJXOjDLkqunZ9NcY2bHZn7CfFscMZZf3sCkN20I5vMh4akiObI7Kj
 vK7X04QEin24qbfMFd8eGjnYW8aSH5qj4ujh/13psIvqSqJFa1CcANErDW/w69saM9prk3jNnHtn
 nuEt/J9wDZeQfiNOYsLDFBdwYt2XtlLzy7G7T4kla0JNnAWQx3FS11bhwUa9HCIwKB+TroNcRY33
 oNmH4nRQzHQazgY7lmveanvOdQzf6IMJ3345q/s6ySNrGnXycmhg3FDRRzisL1oin/zKhywqX9/w
 bOl0qtP5EgfDRdSDhnwOLtBcNrQxKZYuPe8bdCyw79zlPbqLQkZr26Lcxdvj8cqI+CogZdOhX7v3
 ClXzrmMENhJLl6MBfhzHVBR0wHQZxzIUka7Uq615Mik1qzcz30+tdk6yIuh9K7v+Nq0Cm3JVhle6
 F/kpBdN+oWjoATjEFDwcaiz0R34rhTN+GTbl4uS+pZovX9cex7Ac4fawcerGI7TrGXpM/B/M0BZd
 PfIU1BX7pZc1sE3vsz58auH/srM2fgZ9JmgLbj7sqoEiwv7LCxIiAE5ODMnmwjvj2589zjbyZCiM
 WpBpW8YvoIIqmZcWhL/r/eFjMjJnMHeiAPOVAT1rE1/vP68Bb4z3v3h3gCdXrv2+9GnNX30LKqXb
 fwFKgm/rnYBl+Mj5KqOl6Jzub/f3QhLRbOgisvi5VU9eNBtgo6zjiatjNO/pnMCjuIvXs/AyV/Ns
 URB/R+FlEHyAzksgfaRvdgw0WK34QWnzHHMcN6qoXPjenLhIOF1oeRYbjF1Hp647mOWoQlc3hL3c
 dBMSQgQtiTUcJp5roVy0aSDnJVDNCxo62e2RFzS2kkd4u/m4iBmYb1/LCV4/EuVHup06w3Vwxf9C
 F7D6LKKRTfdjzQ6YC7Heg3Xf7O1TOd6RcY/MXB8eEq3bCN2QohZvyS03iBmgsz450Kmjd3fGV5Pc
 rZPg14lcNaSs4Fwukty8QMQa7L0bD+vL0NiZJ28dIbtf63VNbf0lrvssY+k7AHGi1NevGWTo2+h8
 Lhk4HCeZR7ymlGVRtthBJ2y8A5arx6JItKpFaUNPGMMlvbMX0nyK1NiAJ0y2Qvvn6ds6mor35w4f
 SfHzQbABJfgy21HclcZkPRq7NhoxyMwqi8Q23Rgadfh5T5n5D4OHHpbEIgsllZKWnzc5M5WlNtVJ
 qo05MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

On 2024-03-08 15:48, Arınç ÜNAL wrote:
> On 8.03.2024 16:21, Justin Swartz wrote:
>> 
>> On 2024-03-08 14:01, Arınç ÜNAL wrote:
>>> On 8.03.2024 01:37, Justin Swartz wrote:
>>>> Add default #address-cells and #size-cells properties to the
>>>> usb node, which should be suitable for hubs and devices without
>>>> explicitly declared interface nodes, as:
>>>> 
>>>>    "#address-cells":
>>>>      description: should be 1 for hub nodes with device nodes,
>>>>        should be 2 for device nodes with interface nodes.
>>>>      enum: [1, 2]
>>>> 
>>>>    "#size-cells":
>>>>      const: 0
>>>> 
>>>> -- Documentation/devicetree/bindings/usb/usb-device.yaml
>>>> 
>>>> This version of the patch places the properties according to
>>>> the order recommended by:
>>>> 
>>>>     Documentation/devicetree/bindings/dts-coding-style.rst
>>>> 
>>>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
>>>> ---
>>>>   arch/mips/boot/dts/ralink/mt7621.dtsi | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>> 
>>>> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi 
>>>> b/arch/mips/boot/dts/ralink/mt7621.dtsi
>>>> index 5a89f0b8c..7532e17dd 100644
>>>> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
>>>> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
>>>> @@ -289,10 +289,10 @@ usb: usb@1e1c0000 {
>>>>           reg = <0x1e1c0000 0x1000
>>>>                  0x1e1d0700 0x0100>;
>>>>           reg-names = "mac", "ippc";
>>>> -
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <0>;
>>>>           clocks = <&sysc MT7621_CLK_XTAL>;
>>>>           clock-names = "sys_ck";
>>>> -
>>> 
>>> Please keep the empty lines. It's easier to read. I don't see 
>>> anything on
>>> the Devicetree Sources (DTS) Coding Style that would restrict this.
>> 
>> The reason I removed them was due to the SoC DTSI example shown in [1]
>> lacking empty lines between properties, but then using them instead as
>> visual separation between properties and child nodes, or at least 
>> that's
>> how I understood it when I looked at it.
>> 
>> Personally, I prefer the look of the SoC DTSI example - but I don't 
>> mind
>> recreating the patch set with the empty lines between the properties 
>> left
>> entact.
>> 
>> As there is a mix of property spacing and ordering styles in 
>> mt7621.dtsi
>> already - what is the consensus on what a node in this file should 
>> look
>> like?
> 
> There's no precise spacing style I maintain here. I simply group 
> together
> properties that describe a single attribute, and separate those that
> describe different attributes.

I'll recreate v3 accordingly.


>> I also don't mind following that pattern and cleaning up the whole 
>> dtsi
>> according to that if it'll save us all time and energy in future.
> 
> If you'd like to improve the ordering style of the MT7621 device tree
> sources accordingly with
> Documentation/devicetree/bindings/dts-coding-style.rst, I'd be happy to
> review those patches.

Thanks, I'll make an attempt at this sometime soon.


Regards
Justin

