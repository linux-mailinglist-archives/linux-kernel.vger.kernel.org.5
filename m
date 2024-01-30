Return-Path: <linux-kernel+bounces-44866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B1842851
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55493B24986
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8587D85C56;
	Tue, 30 Jan 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="M26pTAT9"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E7EAC7;
	Tue, 30 Jan 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629551; cv=none; b=ut9aB9ZpSnmXhujLv4VfAP1sMJsm9siVITmwYcI6koL9siMDGna7ngfMOygO8XQ3juUUwALcXPI5rYxRIRbZ/dYjEG5dhesBtscq8eQOupzOZO75f0cUz/reisffl+UWo/d+P8RAbo1+NwbmL4i8oIfAQcZ82ZKx5BaQlzo2U9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629551; c=relaxed/simple;
	bh=FTaGDNHcCeLLBNj/d8cQDz2yks44PUV9sCuyE0dIX+o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JlF8XRy6yuuuWlnEccMiQiVeLDyj/aBHfaoPx6kQ4+JqzklU+bfB7otYyQsQppeTMpQx5Z9fX9NmQKlOwkg1J/A+7CclUIM7Fu/1xCg/C98zs9s2bEmm2uuZlEmA5lovyDfBGvo117w3uITYNQW+T70vRKr2YBDpmBU3VXs6T+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=M26pTAT9; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 329579C284E;
	Tue, 30 Jan 2024 10:45:46 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id FDOnLaQgPFiq; Tue, 30 Jan 2024 10:45:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6AC039C4511;
	Tue, 30 Jan 2024 10:45:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 6AC039C4511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1706629545; bh=SzY2unIXzbKsDcuS0h9mD4sGTR0fjuGWifdJQrRoGLE=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=M26pTAT9GP9CpPa/EIHX/JmJDfY4jnFVX3j/UyuFhexulR118iUlJzjgUmJmhOpLQ
	 VM8C2r1wMaU8SE74bzDdcwOwCxY9+3dO7VcTl+7wO1E99bPgo6q80Eo92Lj+HVTicl
	 bJhdnaTd7kqD/DSFdA768UkopX98hb4NFWXKFisQbCPhkDZX40+QVFrCosNW9+18C/
	 NR0RrAN2iOYR1bxC+PPmdym95vOo4QTfOPJr1VfzRK0s3A4Egl8PMIhplaLJOLYhCs
	 7wi2OWRrzVqy8uaSJNatGZ2WMuKE/ULh0JjIL6EZCSK5YlGWq+QCZxYkRTQMrF5zcI
	 2TJssUIXL1izQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 3Hg2NgrQhhBc; Tue, 30 Jan 2024 10:45:45 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 154029C284E;
	Tue, 30 Jan 2024 10:45:45 -0500 (EST)
Date: Tue, 30 Jan 2024 10:45:44 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mdf@kernel.org, hao wu <hao.wu@intel.com>, yilun xu <yilun.xu@intel.com>, 
	trix@redhat.com, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Brian CODY <bcody@markem-imaje.com>, 
	Allen VANDIVER <avandiver@markem-imaje.com>, 
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Message-ID: <1489222458.382780.1706629544559.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <f3cfffa0-5089-4bf7-b424-d5e949e36d67@linaro.org>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com> <20240129225602.3832449-2-charles.perry@savoirfairelinux.com> <f3cfffa0-5089-4bf7-b424-d5e949e36d67@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add
 DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF120 (Linux)/8.8.15_GA_4581)
Thread-Topic: dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT schema
Thread-Index: /XNXbd6Eoqkwp5+V9vA2kJJ0vFwOwg==

----- On Jan 30, 2024, at 2:52 AM, Krzysztof Kozlowski krzysztof.kozlowski@=
linaro.org wrote:

> On 29/01/2024 23:56, Charles Perry wrote:
>> Document the slave SelectMAP interface of Xilinx 7 series FPGA.
>>=20
>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>> ---
>>  .../fpga/xlnx,fpga-slave-selectmap.yaml       | 85 +++++++++++++++++++
>>  1 file changed, 85 insertions(+)
>>  create mode 100644
>>  Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml
>>=20
>> diff --git
>> a/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml
>> b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.yaml
>> new file mode 100644
>> index 0000000000000..20cea24e3e39a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-selectmap.y=
aml
>> @@ -0,0 +1,85 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-slave-selectmap.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx Slave SelectMAP FPGA
>> +
>> +description: |
>> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over =
a
>> +  parallel port named the slave SelectMAP interface in the documentatio=
n. Only
>> +  the x8 mode is supported where data is loaded at one byte per rising =
edge of
>> +  the clock, with the MSB of each byte presented to the D0 pin.
>> +
>> +  Datasheets:
>> +
>> https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_C=
onfig.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - xlnx,fpga-slave-selectmap
>=20
> You did not test bindings, so only limited review.
>=20

I had issues installing pylibfdt but that's fixed now, will do.

>> +
>> +  reg:
>> +    description:
>> +      At least 1 byte of memory mapped IO
>> +    maxItems: 1
>> +
>> +  prog_b-gpios:
>=20
>=20
> No underscores in names.
>=20

This is heavily based on "xlnx,fpga-slave-serial.yaml" which uses an unders=
core.
I can use a dash instead but that would make things inconsistent across the=
 two schemas.=20

>=20
>> +    description:
>> +      config pin (referred to as PROGRAM_B in the manual)
>> +    maxItems: 1
>> +
>> +  done-gpios:
>> +    description:
>> +      config status pin (referred to as DONE in the manual)
>> +    maxItems: 1
>> +
>> +  init-b-gpios:
>=20
> Is there init-a? Open other bindings and look how these are called there.
>=20

No, the "-b" is there to denote that the signal is active low. I think its =
shorthand
for "bar" which is the overline (=E2=80=BE) that electronic engineer put on=
 top of the name of the
signal on schematics. It comes from the datasheet.

>=20
>> +    description:
>> +      initialization status and configuration error pin
>> +      (referred to as INIT_B in the manual)
>> +    maxItems: 1
>> +
>> +  csi-b-gpios:
>=20
> Where is csi-a?
>=20

No "csi-a", this is the CSI signal which is active low.

>> +    description:
>> +      chip select pin (referred to as CSI_B in the manual)
>> +      Optional gpio for if the bus controller does not provide a chip s=
elect.
>> +    maxItems: 1
>> +
>> +  rdwr-b-gpios:
>> +    description:
>> +      read/write select pin (referred to as RDWR_B in the manual)
>> +      Optional gpio for if the bus controller does not provide this pin=
.
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - prog_b-gpios
>> +  - done-gpios
>> +  - init-b-gpios
>> +
>> +additionalProperties: true
>=20
> Nope, this cannot bue true.
>=20

Ok, I'll put this to false but I'm not quite sure I understand the implicat=
ions.

My reasoning behind assigning this to true was that the FPGA is an external
device on a bus that needs to be configured by a bus controller. The bus co=
ntroller
would be the parent of the fpga DT node and the later would contain propert=
ies
parsed by the bus controller driver.

>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    &weim {
>=20
> Drop or use some generic soc
>=20

Ok

>> +      status =3D "okay";
>=20
> Drop
>=20

Ok

>> +      ranges =3D <0 0 0x08000000 0x04000000>;
>=20
> Drop
>=20

Ok

>> +
>> +      fpga_mgr: fpga_programmer@0,0 {
>=20
> No underscores in names, drop label.
>=20
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
>=20
>=20

Ok, will use "fpga-mgr" as this seems to be the most common one for fpga ma=
nagers.

>> +        compatible =3D "xlnx,fpga-slave-selectmap";
>> +        reg =3D <0 0 0x4000000>;
>> +        fsl,weim-cs-timing =3D <0x00070031 0x00000142
>> +              0x00020000 0x00000000
>> +              0x0c000645 0x00000000>;
>=20
> NAK.
>=20
> Please run your patch through Xilinx folks before sending.
>=20
> Best regards,
> Krzysztof

Thank you,
Charles

