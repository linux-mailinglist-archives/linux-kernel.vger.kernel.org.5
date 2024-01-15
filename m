Return-Path: <linux-kernel+bounces-25683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F4B82D48F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A453B1F217B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043446BF;
	Mon, 15 Jan 2024 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RwXWlNmR"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B73C0E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28a6cef709so930397166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 23:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705303749; x=1705908549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xC/RFDsUvgpNYXEbYIF5IQX/d8l9YbICStp/7THUWHE=;
        b=RwXWlNmRKu9rCFX3f2BcCylLCll02ItCgp7pWwrL56uHfrX96tU0zoXvZJi0UunTNi
         q5XgHTQNFRdblECijpReLqXzWeHv9YvTyz2q7OcAHvIBZuNgOd9kAUUTQWk7DfqV9+NH
         6Gl9PGnpPbRLP1yafIvehQE2ZHVFF9E5q186KIrQg91BNWoIj4h8pXCHXJ6RxznLgZZB
         YMlrU5udDXotLLKewC1P2iNqUyOwsxUkibs/34qPrpv1Z0rMHz/hoRJb1lXMAbJ16zPI
         eJARk+BrexXvKvH7KBD8ovvtZXlumqtp2ImD/LPyGMBhCtRjRRWhEq27KY8YYReOmwCA
         X9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705303749; x=1705908549;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xC/RFDsUvgpNYXEbYIF5IQX/d8l9YbICStp/7THUWHE=;
        b=osNmYyRJ1GslM+GN+4id7WPaInTcNwJK0V5YehG5kO+cn5S2ddfbHNsz8EIGALiUCB
         vR0Z1iqzZheVc04uedxUkuNhnE0wyBiAXUBkAX/pX9SoX1jlnNxsvVwI6Rm706lOQm6T
         poI7MqATmwJCANyCAOcJ5vP8Jn5NOs1NnollCpGLfFoVAPbYpf8KmY0KhbINBPdK2qYN
         SDU4qae7BqAXdXZQz2wZSugKD6KP2Q0f+Eoqx7io3bo9WXoot/iZjfoH2Or61qHJzHLV
         VseRlccnXZi34JhKoZLXI7GG3MOYTCGZtCJhaBFSmaAivIDCQsJ1dIBCos0OAN3AJ2j5
         n6hw==
X-Gm-Message-State: AOJu0YzMfERVSQPzYzqNS3w3+JN8ZolQ8JQ2nZmfc4+GA9T0aihDkRgX
	/a5TKH5VzE5hnel3QdfQ7VGRPYj2ZI0haQ==
X-Google-Smtp-Source: AGHT+IHiZgreULCpHLf+h+i+C6Xiu2SvcyS89nvLx5LhKwlckntO3LCDt2oo9MnzZzeI852Js046wQ==
X-Received: by 2002:a17:906:27c8:b0:a2d:4d43:bef7 with SMTP id k8-20020a17090627c800b00a2d4d43bef7mr1212341ejc.71.1705303748734;
        Sun, 14 Jan 2024 23:29:08 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id w17-20020a17090652d100b00a28116285e0sm598698ejn.165.2024.01.14.23.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 23:29:08 -0800 (PST)
Message-ID: <0b03af70-7dc4-4a4f-b9dc-218ef365c237@linaro.org>
Date: Mon, 15 Jan 2024 08:29:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: add description for solidrun am642 som
 and evaluation board
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-4-1385246c428c@solid-run.com>
 <60d78882-0ec5-4cd1-b68d-f75b73cb6cdb@linaro.org>
 <1656bf68-c3b4-476d-984e-f231541058f6@solid-run.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1656bf68-c3b4-476d-984e-f231541058f6@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/01/2024 15:16, Josua Mayer wrote:
> Am 12.01.24 um 18:22 schrieb Krzysztof Kozlowski:
> 
>>> +	/* PRU Ethernet Controller */
>>> +	icssg1_eth: icssg1-eth {
>> Node names should be generic.
> This name intentionally includes the name of the ip block within am64 soc providing software-defined ethernet controller through coprocessors TI call "pru".

Why? This intentionally should not include specific name.

Also, wrap your emails at proper length so they will be manageable...

>> See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
>>
>>> +		compatible = "ti,am642-icssg-prueth";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pru_rgmii1_pins_default>, <&pru_rgmii2_pins_default>;
>>> +
>>> +		sram = <&oc_sram>;
>>> +		ti,prus = <&pru1_0>, <&rtu1_0>, <&tx_pru1_0>, <&pru1_1>, <&rtu1_1>, <&tx_pru1_1>;
>>> +		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
>>> +				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
>>> +				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
>>> +				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
>>> +				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
>>> +				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
>>> +
>>> +		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
>>> +				      <2>,
>>> +				      <2>,
>>> +				      <2>,	/* MII mode */
>>> +				      <2>,
>>> +				      <2>;
>>> +
>>> +		ti,mii-g-rt = <&icssg1_mii_g_rt>;
>>> +		ti,mii-rt = <&icssg1_mii_rt>;
>>> +		ti,iep = <&icssg1_iep0>, <&icssg1_iep1>;
>>> +
>>> +		interrupt-parent = <&icssg1_intc>;
>>> +		interrupts = <24 0 2>, <25 1 3>;
>> None of these are typical interrupt constants/flags?
>>
>>> +		interrupt-names = "tx_ts0", "tx_ts1";
>>> +
>>> +		dmas = <&main_pktdma 0xc200 15>, /* egress slice 0 */
>>> +		       <&main_pktdma 0xc201 15>, /* egress slice 0 */
>>> +		       <&main_pktdma 0xc202 15>, /* egress slice 0 */
>>> +		       <&main_pktdma 0xc203 15>, /* egress slice 0 */
>>> +		       <&main_pktdma 0xc204 15>, /* egress slice 1 */
>>> +		       <&main_pktdma 0xc205 15>, /* egress slice 1 */
>>> +		       <&main_pktdma 0xc206 15>, /* egress slice 1 */
>>> +		       <&main_pktdma 0xc207 15>, /* egress slice 1 */
>>> +		       <&main_pktdma 0x4200 15>, /* ingress slice 0 */
>>> +		       <&main_pktdma 0x4201 15>, /* ingress slice 1 */
>>> +		       <&main_pktdma 0x4202 0>, /* mgmnt rsp slice 0 */
>>> +		       <&main_pktdma 0x4203 0>; /* mgmnt rsp slice 1 */
>>> +		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
>>> +			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
>>> +			    "rx0", "rx1";
>>> +
>>> +		status = "okay";
>> Drop. Didn't you get such comments before?
> 
> Yes, but again I can point to an in-tree example of the same structure.
> I see no reason for describing the same thing differently in different places.

So if there is a bug, you are going to duplicate it.

Please provide real argument why this is needed, not "I saw it
somewhere", or drop it. Otherwise it's a NAK from me.

> 
> Please see arch/arm64/boot/dts/ti/k3-am654-idk.dtso
> There are only small differences for this feature between am65 and am64.
> It's inclusion in the tree was very recent, clearly it was good enough right?
> See also my cover letter dtbs_check remark on dmas property.

How does dmas matter? What are you talking about?



Best regards,
Krzysztof


