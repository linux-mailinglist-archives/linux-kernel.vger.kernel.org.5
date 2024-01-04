Return-Path: <linux-kernel+bounces-16426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74878823E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A591F2507C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5312030A;
	Thu,  4 Jan 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fep0xAri"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69721208A3;
	Thu,  4 Jan 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a279ce3aab9so30820766b.0;
        Thu, 04 Jan 2024 01:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704359416; x=1704964216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dPBMZpIwLe97eSOARV8n7U9n/s5Z04R3IqnKQQS8rw8=;
        b=Fep0xArifMBgUG1v3XAp15oxBTKzYCyFUjLQzD1vVBZXGUuE6h3jtO0/lIVSbgVyDi
         w86qdchuWurAaxXjKN4wYG4WK4X9SBzb09OeD5I7sN2kUrVgdJidOQtAGRcdgV4Ko4I0
         okOvQNWLVfLUMqf1iTb3bThbT6iIJf5+NsASjKCBx3mgmJ42c7fVy+18daVuDBb2dsYb
         42ldz0vQwk+6+FGudqddTG37rXm7+AfiNiaRCMobLvph994Xhgn9pCzfawWsNyqjoRXZ
         g0u4BP9G4AyMts4u6TsYlTz1eRA8flHrsyrq7A5AxomkGYWIXsqDSTpBX4yCaf05y6tZ
         g8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359416; x=1704964216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPBMZpIwLe97eSOARV8n7U9n/s5Z04R3IqnKQQS8rw8=;
        b=KXLjO1Ic9tdbfli3QXP7UlrEmMyNVqWsUHwrIW+CcA9oUnnb40F6B04I+UIKgb3Guc
         ixtdPk3RuQBYdAmaw6VqG8fsgsfr7E8miMC6hoWpXFcGMpPMLRsoR1RaYrPRkFHZMUis
         RFPKFqc8aN3rBz5//sEQpcUBXm8kL2tBSMeqMD9b3TaLwpHqM7hJU4dRr0LSLy+LeKfc
         jh1JGiTAmbYlBm7jk9GpfwgV9FsfgM2KJMV6A3O0Bpmoyjlrzj00ivqX4AvMHnEPZJVa
         IxqDBdd/4rvEgoJs/UflDC4waQIAElmQCBC00qFs3qiXMmaifWAtWueFEaXv8dKrm6bO
         4+lw==
X-Gm-Message-State: AOJu0YwXmOAmrJ5HunfijZYhDdRUMcTqErWOyy5tlfaiWL+VOa7JuxIi
	SonWS6Ow/pe5R8ODqWT0xG9dOxbx/h8=
X-Google-Smtp-Source: AGHT+IH9GFQFLxaGbfTd716l9XCq8gwK4NcEI5lScAk+/vXXAtSZomgstLN/aGp2NblEnpsbdZRUPg==
X-Received: by 2002:a17:907:e8e:b0:a27:efb8:6d51 with SMTP id ho14-20020a1709070e8e00b00a27efb86d51mr114313ejc.228.1704359416289;
        Thu, 04 Jan 2024 01:10:16 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id ld11-20020a170906f94b00b00a28d1d73654sm502052ejb.207.2024.01.04.01.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 01:10:15 -0800 (PST)
Message-ID: <8c8d2d38-faf2-47f2-bfbf-2e4842dded47@gmail.com>
Date: Thu, 4 Jan 2024 10:10:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/6] dt-bindings: nvmem: layouts: add U-Boot
 environment variables layout
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>, Rob Herring <robh@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20231221173421.13737-1-zajec5@gmail.com>
 <20240104001129.GA2045237-robh@kernel.org> <20240104085839.5624c354@xps-13>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20240104085839.5624c354@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4.01.2024 08:58, Miquel Raynal wrote:
> robh@kernel.org wrote on Wed, 3 Jan 2024 17:11:29 -0700:
>> On Thu, Dec 21, 2023 at 06:34:16PM +0100, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> U-Boot env data is a way of storing firmware variables. It's a format
>>> that can be used of top of various storage devices. Its binding should
>>> be an NVMEM layout instead of a standalone device.
>>>
>>> This patch adds layout binding which allows using it on top of MTD NVMEM
>>> device as well as any other. At the same time it deprecates the old
>>> combined binding.
>>
>> I don't understand the issue. From a DT perspective, there isn't. A
>> partition is not a device, but is describing the layout of storage
>> already.
> 
> Actually I think what Rafał wants to do goes in the right direction but
> I also understand from a binding perspective it may be a little
> confusing, even more if we consider "NVMEM" a Linux specific concept.
> 
> There is today a "u-boot env" NVMEM *device* description which
> almost sits at the same level as eg. an eeprom device. We cannot
> compare "an eeprom device" and "a u-boot environment" of course. But
> that's truly what is currently described.
> 
> * Current situation
> 
> 	Flash device -> U-Boot env layout -> NVMEM cells
> 
> * Improved situation
> 
> 	Any storage device -> NVMEM -> U-Boot env layout -> NVMEM cells
> 
> The latter is of course the most relevant description as we expect
> storage devices to expose a storage-agnostic interface (NVMEM in
> this case) which can then be parsed (by NVMEM layouts) in a storage
> agnostic way.
> 
> In the current case, the current U-Boot env binding tells people to
> declare the env layout on top of a flash device (only). The current
> description also expects a partition node which is typical to flash
> devices. Whereas what we should have described in the first place is a
> layout that applies on any kind of NVMEM device.
> 
> Bonus point: We've been working the last couple years on clarifying
> bindings, especially with mtd partitions (with the partitions{}
> container) and NVMEM layouts (with the nvmem-layout{} container).
> The switch proposed in this patch makes use of the latter, of course.

Thanks Miquèl for filling bits I missed in commit description. Despite
years in Linux/DT I still struggle with more complex designs
documentation.


As per Rob's comment I think I see his point and a possible design
confusion. If you look from a pure DT perspective then "partitions" and
"nvmem-layout" serve a very similar purpose. They describe device's data
content structure. For fixed structures we have very similar
"fixed-partitions" and "fixed-cells".

If we were to design those bindings today I'm wondering if we couldn't
have s/partitions/layout/ and s/nvmem-layout/layout/.

Rob: other than having different bindings for MTD vs. NVMEM layouts I
think they overall design makes sense. A single device may have content
structurized on more than 1 level:
1. You may have fixed layout at top level (multiple partitions)
2. Single partitions may have their own layouts (like U-Boot env data)

Maybe ideally above should look more like:

flash@0 {
	compatible = "<flash-compatible>";

	layout {
		compatible = "fixed-layout";
		#address-cells = <1>;
		#size-cells = <1>;

		partition@0 {
			reg = <0x0 0x40000>;
			label = "u-boot";
		};

		partition@40000 {
			reg = <0x40000 0x10000>;
			label = "u-boot-env";

			layout {
				compatible = "u-boot,env-layout";
			};
		};

		partition@50000 {
			reg = <0x50000 0x100000>;
			label = "u-boot";
		};
	};
};

but I can clearly see a use for nested "layout"s. As I said maybe we
just shouldn't be so open in calling those MTD or NVMEM devices as that
is kind of Linux specific.

I'm not sure if we should try renaming "nvmem-layout" to "layout" or
"partitions" in similar way at this point.

