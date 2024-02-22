Return-Path: <linux-kernel+bounces-76140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F27CF85F364
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E77B21536
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CB724A04;
	Thu, 22 Feb 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="t3k1AkUk"
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C294F2BB0E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.182.159.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591623; cv=none; b=H41n/ZuEp72SmsuhE7UdREN/1ZJopHvTs7BSFt8A6aA47J9FP1UAK/afzTRGnzWocWRT52FQJ2gLuHsu7a7h7r95P3G7sQspZsg3uXuvE3VyV2mhj0lPADfO3/lka9KBLD4mQYW5mu+QqGzdZZ5+Py5KGnfNSgBNw6qTKltc9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591623; c=relaxed/simple;
	bh=MOul7ErOlWpjXnFjZIeLDDx5Cyk2pRkzCt3A0Ne8lVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFWRrST/4pt0HYNdr5Yk6sLW6m6vcUB+JsjETrxLBUH+/DaO/8CxOzlJeNuaT4ge/eC0nBJ6APatN6MXqZQ0vHVOBjA6gkelrqHBgHqh2qqB23nNGbNt06UAsOgp0RvINcaWAlhATc7OnOg1m5ppPH/yByX6zvyAYGj95YIGlAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=t3k1AkUk; arc=none smtp.client-ip=62.182.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BEC21145D8;
	Thu, 22 Feb 2024 08:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1708591613; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=mkwao/Eo5HsXt33cPrj25cBHf9f0LM2OJqHCNPBQoQk=;
	b=t3k1AkUk93ro0Ha1DPQNiZFeqgLomxTYKcAOxje6QiAdWw51Uzna9GrUk980vJL0c2IFHn
	FvTKp1PMbJFrWNc3X2/jN1KTnOf237CShPYYyzddXxFIFyyQfogOIKtXkDzyNDek5cEe+v
	V60hi+9OjpdAc1RB6wzkYra0g/xXbLjgrG4r/i3xczjo+pCywI4v91kS3sWnA9r0mRGwSG
	28ePQQ3ajLTRE5zS7XIA+eFrBXMYOCzCh4oOSGvBY9f1uWfcUNKcXJy9T9vcKNgyJjTwdL
	B3NJDQXn6VUdIS/me1HU6ebpIUsZJ/GFYakXXKNnRNKHU/47rn1roMOlruGRqQ==
Message-ID: <16891eb5-ee2e-4b0d-a82d-517adf028474@lexina.in>
Date: Thu, 22 Feb 2024 11:46:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] soc: amlogic: meson-gx-socinfo-sm: Add Amlogic
 secure-monitor SoC Information driver
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev
References: <20240221143654.544444-3-adeep@lexina.in>
 <202402221322.ifGMGQa6-lkp@intel.com>
Content-Language: en-US, ru-RU
From: Viacheslav <adeep@lexina.in>
Autocrypt: addr=adeep@lexina.in; keydata=
 xsDNBF+1fsQBDADh4przgt1LU4l+B6rIWel42Mg3hgdgbZ2nlIkKnaaNLXkm5rK0EJJeStd7
 8sxsdk9n7UQFB3mkmgjc89zyAG+CDG/+KZQMWOsc5IvWlDebKlefieyvf9yvV4qcQTeudr3C
 CgUxq8qsp1fDX9jdSjz5/OMJKrxCElMxLxJTFF+FHtWvUIMr4txesE8NP7f7VnIYILEeMM8q
 gvptNUrWQr6KTv4XnRD/BvsRZJWnQ/a5MzMGQWzw7LeT4vhV4lYqJsXmxbGLUOKi+5ZpslR3
 Ffby2kdL1Xyq6Y7Gi70RhUpKP0xGJ6gDVs6SjFSb9UxgrjwNBWZcFeSJkc6pR5JbgbYMRvdA
 W5CNnA8TzdfhPgO3HEDFlsVqberSBI/tMiwHWPze7jkv7ttx/Wg9+RZybFfCkGm4XvKh7aP4
 jG3Td43mqhyHGzOd/EUxNITebqxqpEJTmRCisgpjr3M76aht4UFz11tP/QEuCrpDX0bOMPYA
 4aohmhw5FLyWUPg0JllH6kEAEQEAAc0SIDxhZGVlcEBsZXhpbmEuaW4+wsDwBBMBCgAaBAsJ
 CAcCFQoCFgECGQEFgl+1fsQCngECmwMACgkQ7jaxEAJajfrgvAwA051C6jUKS6Wp4oy2Or0i
 B1HXCDDaCS2zgWDCa+nuI+8qVDzTx0TAlurt+S3AUv8+DHjkc4XjEHtDdigabp2nGsk51w3C
 WyGD7NKUQz8/mpN7Fb2OV79etE3PTMayUrXRZh7ZuvQ7vkUemKM8rRw0PFPu3kqwZPDPapYH
 rPyJZjnNFuvFULli/xIcc8+WklaYgOKg4nmsVBT4NigiV2Y4Mb4yVBWl58mErRH5pv08NYb4
 1JFD2FZnTGhEeumQDl9p6Kd+rZETRgkMEHw+HMwdXl5ZXv5ci4NTigiH77UvfN8FetuAdl3x
 6EM+1bJkgab6TMyWdNPPmF6e5BPHtBduk9gzmU5+xUlTbur0gun662oFi1oWwbAqhBDueDyL
 xCi8qjycOJaehBcPRtksQeTZrp+fDYne7hq3ywMBdlqhdz4Sfm7urLHvA/bApgJKlWylkqkl
 sG82QPh63ZnNw2lORTGEQTO3tBMY5RLKnrvZjtZR7W06pVZXyQQXZceEmpCazsDNBF+1fsQB
 DACy2kiiKt2bTSl4u/z1en+BhP16c/RbjnDXVkbapyZRCf3OmjfpRXprje4Z0+HAHReWgnOc
 sC6vNk+SWimoE/qyXQTNnUDS7KYdFaof14UmU2rA9pf1oXHOgMRzlwinCe+6NCgkjsqOr3e5
 8XNo+cxmQy1bhHt1LDwixBFU6v65umJpZAVUd1F624wU+UeRZCjymMB80ePxF9ppnfcYc+Yp
 aM70LFwDzxCmeLGv0uMb0jfgJ8j2k2LS5nOQ4AX+WoOb98vFuqW7oYA9oCCKDG0Gp/w9QxG5
 RKjMytZIUxQA2JDq0jUN90pK0mtZJn7/Dr8GRM+W+UpeKiK7wW9iTFH+hTIRtbCC8vO8JDGz
 umW65BFtZfH2cEQDU2nbdsf/SstszPDMuyDiCHmxh8MKN/fn55osvJvjXgqpsH48tz9O7262
 P5xK4nMpsWWj7W6OhHGTQTHgMrKsiYoDx9+5NGt8n+MbLO5DUvyOSvfAiE+hRaf97R9vtoSy
 BoyahDXmCH0AEQEAAcLA3wQYAQoACQWCX7V+xAKbDAAKCRDuNrEQAlqN+ra3C/95TV1Fjy//
 t6FvNIgLy0e+5LnTegejiCaGbxklGFIWkGamX/DOm3QF+ZaKsoXUf/kmpL10dnsExiGHTeGw
 7zR8+rOkVnK6fq0ady43a7RxKP5nW0pDVclTvsAWr1CcdFrCVpH2idj7fjtAmZlMbuiEMXoo
 kaDXdhJtS60VrwS4xUlw4ZPQjMZdQdvpu4vGtZUfJr+8vJ757d9N3EGpFUrk+5QWozjktLVm
 gdQ0nlD9ji3RpwjhQWCIoi6GmdWpfdj3LzDO/DwWRLlz8iAdZG3pHSGsCmM2MJ16HbPnsSxr
 YrKwM/HVpqTSVsprnQogPL/xM0AH11uAbqNvIvm6sUkEmx2kdBzTKjY0YdSkpUgTauWn13bg
 Ay+0xfqxRvYBSsHpWpnSnsI12861OVGnYsnB8gJlJLSQjOl3Kwq36MeWbAg6Bs4PnNU4i+uO
 rz9PJ4vHmMYfmMDJLYWJI6pcLyAoZSE/bSTLaRV73/zjtlX85mtEL3fvh6G342uRCvAwqgI=
In-Reply-To: <202402221322.ifGMGQa6-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi!

Will be fixed in next version with new Kconfig dependencies:

     depends on (ARM64 && ARCH_MESON || COMPILE_TEST) && MESON_SM=y
     default ARCH_MESON && MESON_SM

22/02/2024 08.35, kernel test robot wrote:
> Hi Viacheslav,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 9fc1ccccfd8d53dc7936fe6d633f2373fc9f62e8]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Viacheslav-Bocharov/soc-amlogic-meson-gx-socinfo-move-common-code-to-header-file/20240221-224803
> base:   9fc1ccccfd8d53dc7936fe6d633f2373fc9f62e8
> patch link:    https://lore.kernel.org/r/20240221143654.544444-3-adeep%40lexina.in
> patch subject: [PATCH v2 2/3] soc: amlogic: meson-gx-socinfo-sm: Add Amlogic secure-monitor SoC Information driver
> config: arm64-randconfig-002-20240222 (https://download.01.org/0day-ci/archive/20240222/202402221322.ifGMGQa6-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402221322.ifGMGQa6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402221322.ifGMGQa6-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     aarch64-linux-ld: Unexpected GOT/PLT entries detected!
>     aarch64-linux-ld: Unexpected run-time procedure linkages detected!
>     aarch64-linux-ld: drivers/soc/amlogic/meson-gx-socinfo-sm.o: in function `socinfo_get_chipid':
>>> meson-gx-socinfo-sm.c:(.text+0xac): undefined reference to `meson_sm_call_read'
>     aarch64-linux-ld: drivers/soc/amlogic/meson-gx-socinfo-sm.o: in function `meson_gx_socinfo_sm_probe':
>>> meson-gx-socinfo-sm.c:(.text+0x438): undefined reference to `meson_sm_get'
> 

