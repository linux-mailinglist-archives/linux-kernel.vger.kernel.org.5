Return-Path: <linux-kernel+bounces-45011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63070842A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29020285773
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1C7129A86;
	Tue, 30 Jan 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="eqES57fC"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF91272B3;
	Tue, 30 Jan 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634348; cv=none; b=m/0ZA5KnP6X4lj6SgHXpxacxwJxxtAAfT/XCrMM5tcIY39IR6AwEXDn5jB6UPxZnJE81yRIc7Z83VbsbFgMWE0KC93FvSb4gFnApXgueGmRXIyDaANLsXxEP9UU5XpHkh8iB8yoMMs4uzU9iTmZj6SCf9D6TqPLdWWtWasypNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634348; c=relaxed/simple;
	bh=hpDRdXzHEo7dqJPrheRt+XnM62iW2iSoYjncPoUe3Yg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=C7o8btyds331Coh398ju3phY5xygnQjzhSgs+8mOcjQQO7j8mt5GpInWDjy0Ve43zpO1X76VsZIMFJsXPE4PaJRl+Hs3uc10GuYNvCoTHRpA0o3X8gqZXytIBrCIBGQODeXUItFEmFuuFuHV2NUTKu3FwCDqGga1bI1mlrmu5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=eqES57fC; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AEFB59C2AFE;
	Tue, 30 Jan 2024 12:05:42 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id hUzHhLT9IF8K; Tue, 30 Jan 2024 12:05:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1D5979C43DE;
	Tue, 30 Jan 2024 12:05:42 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 1D5979C43DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1706634342; bh=XXd7XiuvbCRYYqsWJYmmkuqPRSOSc2fWYgYpeZCmzxI=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=eqES57fCdoNJ30MYLcVtr2jFm8qBeKKBsLrfB0ppmcKTNKtHwyzfr20LLfI0nmmk6
	 X2cWVeY9HGC9nrKp4lindTKuXujFaz5j/Zb4r7OcGa5qM6aE47G7rT3Qm+Nsv8AHeF
	 9zi1kZrbGmUyDKyh5UZbb4GHJx8NCJSY23SacZYZrx6VR1WMyrRev0EiP/C6H1dbGC
	 frpLgSUcMRUzxJPZkfhht6bFc/orY8toDdzQgcYEqYYcIEdv7zxrHkA1kcYp//ghQT
	 j50z4+YU5AsTdmGZ9foz6Ccjco4Gk8NHZg82Pco3Sq2JXjEfI9rHdj1sz4gFjVLsCX
	 xrAjWP1flWdaw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id hU5IVIrtvwir; Tue, 30 Jan 2024 12:05:42 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E68719C2AFE;
	Tue, 30 Jan 2024 12:05:41 -0500 (EST)
Date: Tue, 30 Jan 2024 12:05:41 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mdf <mdf@kernel.org>, hao wu <hao.wu@intel.com>, 
	yilun xu <yilun.xu@intel.com>, trix <trix@redhat.com>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Brian CODY <bcody@markem-imaje.com>, 
	Allen VANDIVER <avandiver@markem-imaje.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <154341320.386005.1706634341891.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <32669bc7-90b5-48d9-8845-2e072a477c6e@linaro.org>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com> <20240129225602.3832449-2-charles.perry@savoirfairelinux.com> <f3cfffa0-5089-4bf7-b424-d5e949e36d67@linaro.org> <1489222458.382780.1706629544559.JavaMail.zimbra@savoirfairelinux.com> <32669bc7-90b5-48d9-8845-2e072a477c6e@linaro.org>
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
Thread-Index: JqmEycYRB0Gse9pTEDZu2SmsjtJ+PA==



----- On Jan 30, 2024, at 11:05 AM, Krzysztof Kozlowski krzysztof.kozlowski=
@linaro.org wrote:

> On 30/01/2024 16:45, Charles Perry wrote:
>>=20
>>>> +
>>>> +  reg:
>>>> +    description:
>>>> +      At least 1 byte of memory mapped IO
>>>> +    maxItems: 1
>>>> +
>>>> +  prog_b-gpios:
>>>
>>>
>>> No underscores in names.
>>>
>>=20
>> This is heavily based on "xlnx,fpga-slave-serial.yaml" which uses an und=
erscore.
>> I can use a dash instead but that would make things inconsistent across =
the two
>> schemas.
>=20
> Inconsistency is not a problem. Duplicating technical debt is.
>=20
>>=20
>>>
>>>> +    description:
>>>> +      config pin (referred to as PROGRAM_B in the manual)
>>>> +    maxItems: 1
>>>> +
>>>> +  done-gpios:
>>>> +    description:
>>>> +      config status pin (referred to as DONE in the manual)
>>>> +    maxItems: 1
>>>> +
>>>> +  init-b-gpios:
>>>
>>> Is there init-a? Open other bindings and look how these are called ther=
e.
>>>
>>=20
>> No, the "-b" is there to denote that the signal is active low. I think i=
ts
>> shorthand
>> for "bar" which is the overline (=E2=80=BE) that electronic engineer put=
 on top of the
>> name of the
>> signal on schematics. It comes from the datasheet.
>=20
> Then just "init-gpios"
>=20
> ...
>=20
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - prog_b-gpios
>>>> +  - done-gpios
>>>> +  - init-b-gpios
>>>> +
>>>> +additionalProperties: true
>>>
>>> Nope, this cannot bue true.
>>>
>>=20
>> Ok, I'll put this to false but I'm not quite sure I understand the impli=
cations.
>>=20
>> My reasoning behind assigning this to true was that the FPGA is an exter=
nal
>> device on a bus that needs to be configured by a bus controller. The bus
>> controller
>> would be the parent of the fpga DT node and the later would contain prop=
erties
>> parsed by the bus controller driver.
>=20
> Which bus controller? MMIO bus does not parse children properties.
> Anyway, if that's the case you miss $ref to respective
> peripheral-props.yaml matching your bus and then "unevaluatedProperties:
> false".

This one: https://elixir.bootlin.com/linux/v6.8-rc2/source/Documentation/de=
vicetree/bindings/bus/imx-weim.txt#L56

>=20
> Best regards,
> Krzysztof

Regards,
Charles

