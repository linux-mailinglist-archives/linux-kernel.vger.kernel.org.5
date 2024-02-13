Return-Path: <linux-kernel+bounces-64355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC58853D69
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D821F21435
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D82A62A07;
	Tue, 13 Feb 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="hbXXMyCc"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7FE626DB;
	Tue, 13 Feb 2024 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860424; cv=none; b=pCt5nSyZb7EWMSuYv2cq78nQWHs3LV6VzgV4/9dBXaOiKjW9aVMYsg48pRGz/P9OWiM6XNL/7shpur2eHOU5nqLT7DREzKxnykhFRgq+Indu3eP9DWB/2aUHZG9J3ooC2KpmY5F1YkUlJqd1rruW8cjW2jNBNBJe7fS7Uq1zMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860424; c=relaxed/simple;
	bh=Am0SdY5XDfkfN9XClvIWzxvrMD3Ma/uMq9rRKBz1zVM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=N3hXwcOya6zAjAvPwBj/xuZSkphJPBdtQfgHuwvXDrLv/hONLDhfq2OV4JYyxbeJ7U15c9vcTihlr0byHH0l20S8lMphV0WJ5g0H1UroL97czyqHgPMXG2m1aJS1t5iS6NB7L6Nyzq9i3uceOQoxdqXerBQXqGpEHFxMqJi+gmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=hbXXMyCc; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 549859C4408;
	Tue, 13 Feb 2024 16:40:13 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 0AR89831jv7z; Tue, 13 Feb 2024 16:40:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AB8A99C48F2;
	Tue, 13 Feb 2024 16:40:12 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com AB8A99C48F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1707860412; bh=OLowQGLdyAKcj7Y0FKOcf7tGXW+sq0JROGANmY0A+Wo=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=hbXXMyCcnSbiDOis84z1rPH366GZ/q0jOZVSHbHn0xnHvkXnwSMCSxR9jgMzNWM+v
	 +WBSNXUDBCfLaVYa3cibhNRdQnV+nbladEQVdqH1XFbrPlQH50Uf7zIIf2AqEIlmHG
	 nKBMswF0NeFMsaz29PxRdtEsZbldtvsEj9SQdOEexxvDh7V+CtSfjg6t9s0AkOPpAg
	 8scqu6e+i2ymw+OOB+BEv63fKn2ieEptqDJdssZT/Ecsi9jJ390xwrmKcNpTnzUIDU
	 e81yECbOHQTVxhu3+VBA5TCIQKeBAYkDYZrQPDlG16O4FHzEqDneUJ1HiMPSil3Wri
	 r/bW5/g7MlgCw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id W4wzPNlSx12O; Tue, 13 Feb 2024 16:40:12 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6FBCD9C4408;
	Tue, 13 Feb 2024 16:40:12 -0500 (EST)
Date: Tue, 13 Feb 2024 16:40:12 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>, 
	Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>, 
	yilun xu <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, 
	kishore Manne <nava.kishore.manne@amd.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <1139371633.970589.1707860412394.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <69679d9a-02e9-498f-8f5a-7c029059a8c1@linaro.org>
References: <20240207180142.79625-1-charles.perry@savoirfairelinux.com> <20240207180142.79625-3-charles.perry@savoirfairelinux.com> <69679d9a-02e9-498f-8f5a-7c029059a8c1@linaro.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: fpga: xlnx,fpga-slave-serial:
 rename gpios
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF120 (Linux)/8.8.15_GA_4581)
Thread-Topic: dt-bindings: fpga: xlnx,fpga-slave-serial: rename gpios
Thread-Index: JNVv3qISWN3DobtT0S2yFs/0J3QuiQ==

On Feb 11, 2024, at 10:39 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org wrote:
> On 07/02/2024 19:01, Charles Perry wrote:
>> By convention, gpio consumer names should not contain underscores
>> (prog_b here) and shouldn't contain active low suffixes (-b here).
>> 
>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>> ---
>>  .../bindings/fpga/xlnx,fpga-slave-serial.yaml        | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml
>> b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml
>> index 614d86ad825f3..650a4d8792b64 100644
>> --- a/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml
>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml
>> @@ -36,7 +36,7 @@ properties:
>>    reg:
>>      maxItems: 1
>>  
>> -  prog_b-gpios:
>> +  prog-gpios:
> 
> Please deprecate old property and add allOf excluding the usage of both.
> Driver still parses old property, so we should have it documented.
> 
> https://lore.kernel.org/all/20230118163208.GA117919-robh@kernel.org/
> 
> Best regards,
> Krzysztof

Ok. Thank you for the example.

Regards,
Charles

