Return-Path: <linux-kernel+bounces-4437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7975B817D15
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067281F20CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579CB740B0;
	Mon, 18 Dec 2023 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bklji33K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1E740B2;
	Mon, 18 Dec 2023 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so432762566b.1;
        Mon, 18 Dec 2023 14:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702936945; x=1703541745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j78u/AxbFW/PvB7ob0xH35r+RLxqVn7NFYykJEfCNm4=;
        b=bklji33KAfGRayu3WeeoF2gNBQubDvJJ3YXQwnFBbQdSEDTa++BzKMRheAezkjQlvq
         e2u+7LFcAbI8P8QTK3dtFMQax/0zqzI042H0CKUM2+5W1haHRmqN0ZpibJS9DyvEnaxt
         FG8A+inDwhJZlBhicL8hzP7GcrVvck0310iwINCSpQLDs1ttbQXdEfUc0BZU52xHGPJ+
         G2funOpAFb89peO/oc/ByERN8/+QiotFQV8d/hK1/b6uFIJLS+j04LSBcOVWEyrHs5NM
         y0rlidS1Fx+JVl1nKsr4ZWNK4QpZ51kBDcuCZ/nvrv/LoxdxJo7buMfhpKGkGDRx3ofa
         ZXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702936945; x=1703541745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j78u/AxbFW/PvB7ob0xH35r+RLxqVn7NFYykJEfCNm4=;
        b=DEZxRNV8juvAykrrVMTtrZdFun5WIwQc6zULjexCkiGjCpmo27uBM8NM5hfkdRt+0Q
         sqDmzDMNlGRrYd7XcEas6tnapywHatkjYQLo0Sl5wPvI3S7VfkXJ+L0rFf8QierMmTq8
         vxjlzS/MaXFuKbKZi4Tc1/Ve3AwlhIjyqCwoB7esXfR6dUezHl1zinlGq+013J6kYMeZ
         r9s7OAyB372C63hZVFEG3bQ0PXHXiIoSUT0Djv8zgiThYdghqT7SJtHloSLRXYfaG++X
         OaXGhmjhe+d5AAp8FIMRvVX93B7gc57wjkllc0GRYXItTkxiALHwWOnhUW0y1JoMCQmJ
         C8Og==
X-Gm-Message-State: AOJu0YyZdk/IxtPzVshOU/IHPx6GGeckjM+0qJ+fDv26jt09siV7c643
	MV4jknikbhivfP+FgqA1Mc8=
X-Google-Smtp-Source: AGHT+IEPZqXlfacA0u2n1vljM6X29jA54J6/WAEvQI9gh7KtlZMgF3FICfR713o6WiYGui2vKNrWNQ==
X-Received: by 2002:a17:906:7386:b0:a14:b151:72e6 with SMTP id f6-20020a170906738600b00a14b15172e6mr7515981ejl.21.1702936945048;
        Mon, 18 Dec 2023 14:02:25 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id tg10-20020a1709078dca00b00a178b965899sm14647993ejc.100.2023.12.18.14.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 14:02:24 -0800 (PST)
Message-ID: <1b4feb5d-f03c-44b3-9474-901534db5eb7@gmail.com>
Date: Mon, 18 Dec 2023 23:02:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] dt-bindings: nvmem: u-boot, env: add any-name MAC
 cells compatible
To: Simon Glass <sjg@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 u-boot@lists.denx.de, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20231214153620.23998-1-zajec5@gmail.com>
 <CAPnjgZ31AAauR876W1RmU4JPzKUD8XAMCZrJDumE+Dr4miqABQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <CAPnjgZ31AAauR876W1RmU4JPzKUD8XAMCZrJDumE+Dr4miqABQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.12.2023 22:27, Simon Glass wrote:
> On Thu, 14 Dec 2023 at 08:36, Rafał Miłecki <zajec5@gmail.com> wrote:
>>
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> So far we had a property for "ethaddr" NVMEM cell containing base
>> Ethernet MAC address. The problem is vendors often pick non-standard
>> names for storing MAC(s) (other than "ethaddr"). A few names were
>> noticed over years:
>> 1. "wanaddr" (Edimax, ELECOM, EnGenius, I-O DATA, Sitecom)
>> 2. "et1macaddr" (ASUS)
>> 3. "eth1addr" (Buffalo)
>> 4. "athaddr" (EnGenius)
>> 5. "baseMAC" (Netgear)
>> 6. "mac" (Netgear)
>> 7. "mac_addr" (Moxa)
>> and more ("HW_LAN_MAC", "HW_WAN_MAC", "INIC_MAC_ADDR", "LAN_MAC_ADDR",
>> "RADIOADDR0", "RADIOADDR1", "WAN_MAC_ADDR", "lan1_mac_addr", "wanmac",
>> "wmac1", "wmac2").
>>
>> It doesn't make sense to add property for every possible MAC cell name.
>> Instead allow specifying cells with "mac" compatible.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> List of devices and their U-Boot MAC variables:
>> alphanetworks,asl56026) wanmac
>> asus,rt-ac65p) et1macaddr
>> asus,rt-ac85p) et1macaddr
>> belkin,f9k1109v1) HW_WAN_MAC + HW_LAN_MAC
>> buffalo,ls220de) eth1addr
>> buffalo,ls421de) eth1addr
>> checkpoint,l-50) lan1_mac_addr
>> dovado,tiny-ac) INIC_MAC_ADDR
>> dovado,tiny-ac) LAN_MAC_ADDR + WAN_MAC_ADDR
>> edimax,ra21s) wanaddr
>> edimax,rg21s) wanaddr
>> elecom,wrc-2533ghbk-i) wanaddr
>> elecom,wrc-2533ghbk2-t) wanaddr
>> engenius,ecb1200) athaddr
>> engenius,ecb1750) athaddr
>> engenius,epg5000) wanaddr
>> engenius,epg600) wanaddr
>> engenius,esr1200) wanaddr
>> engenius,esr1750) wanaddr
>> engenius,esr600) wanaddr
>> engenius,esr600h) wanaddr
>> engenius,esr900) wanaddr
>> enterasys,ws-ap3705i) RADIOADDR0 + RADIOADDR1
>> iodata,wn-ac1167dgr) wanaddr
>> iodata,wn-ac1167gr) wanaddr
>> iodata,wn-ac1600dgr) wanaddr
>> iodata,wn-ac1600dgr2) wanaddr
>> iodata,wn-ac733gr3) wanaddr
>> iodata,wn-ag300dgr) wanaddr
>> iodata,wnpr2600g) wanaddr
>> moxa,awk-1137c) mac_addr
>> netgear,wax220) mac
>> netgear,wndap620) baseMAC
>> netgear,wndap660) baseMAC
>> ocedo,panda) wmac1 + wmac2
>> sitecom,wlr-7100) wanaddr
>> sitecom,wlr-8100) wanaddr
>>
>>   .../devicetree/bindings/nvmem/u-boot,env.yaml | 33 +++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
> 
> Are these upstream U-Boots, or just vendor forks?

I guess most of those devices don't have upstream U-Boot support. Please
note that while upstreaming vendors changes would be great in most cases
it doesn't happen. Most vendors sadly don't care and most end users
don't have enough time for that. In practice we often stick with vendor
provided bootloader to flash and boot self build Linux system (like
OpenWrt).

I'm not sure if/how does it help with this PATCH but please note that
upstream U-Boot code also supports few extra variables.

There is generic eth_env_get_enetaddr_by_index() that supports variables
like "<%s><%d>addr" and "<%s>addr". Right now it's used only for
"eth<%d>addr" and "ethaddr" so that mostly limits us to "ethaddr",
"eth1addr", "eth2addr" and "eth3addr".

 From some rare cases: there are also "usbnet_devaddr" and "wolpassword".

So given that U-Boot oficially supports at least 6 env variables for
MAC and there are many used with custom U-Boots and firmwares this
binding would help a lot.

