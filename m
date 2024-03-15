Return-Path: <linux-kernel+bounces-104839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E4687D462
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83E11C20FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B86D524BC;
	Fri, 15 Mar 2024 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="RDOgDofT"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932EE4CB58;
	Fri, 15 Mar 2024 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710530179; cv=none; b=TYp9MndSzTiJpQj5WaMCqx1m15zS1JO+4O4BKImQnq+33JzxfZwgB7wRpysazHokSptsbSDBJfyL8MJKP4KkUGDa6ibQ7pL8KukLLy/Oyz0SzpybRBYHujH16rOQVEG2+Hszqs8R9j+YC1itnoV0rUcl8oI3iV7Pzq5/3hcLE1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710530179; c=relaxed/simple;
	bh=2ADcnC12HSTO+U/xqectyx3NKUypGWioD/mh5sJ+rdU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOdXoTfwm8K/0YqeVW2vhy89MbTvydAv5OAiIkmz0OJvBKGIDMGbEFbTTZpoaleyzJlukaqxKgqv7yr32MOogklL4ND9Uo99iimP5txOxcIzy6xe++Ns14gVdscfiDrC3uaRAo9FNzkASGGzb7E55q9kOr1wM/zWquyMQ6AboU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=RDOgDofT; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D23C5120004;
	Fri, 15 Mar 2024 22:16:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D23C5120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710530164;
	bh=aQc6jQvAwlY+uokpPcsnqZDUHef6LtDzBUv3F9bQff4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=RDOgDofTh2vWrf+BZLHdtSrfXMRQEE31GwFwbtX7En6u9/ECYtjeemz51JA5YhM5u
	 tFh4LgoxD+B370MiNwxRtFyf0RJXSpQeE9LH+Y8ZdYYsu3kQ78KbgiaZGGKGYYWtCp
	 9+9c4FUzTbx+Wu6lWOOqubTbjMf75os3e635xIAdJ9pPk86el1WINKLQOIS96RTvqG
	 jX17+LM99uAphI9yefMmlMV6PyAysXroSocEdeWgdg7RDGve7wEvF8Gz2rASYTV/Az
	 ncKS/fjBaED1VDJVHoWvoKnGhy2fgFUqEYuDqSA4YWKVWm6Tk7s9oupLSawNnK599i
	 9Ci8wUI99BNrA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 15 Mar 2024 22:16:04 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Mar
 2024 22:16:04 +0300
Date: Fri, 15 Mar 2024 22:16:04 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Cong Liu <liucong2@kylinos.cn>
CC: <sdf@google.com>, <akpm@linux-foundation.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/Makefile: Remove cgroup target
Message-ID: <20240315191604.4sk3ifxrv5ca6w2n@CAB-WSD-L081021>
References: <ZfNXjd1ML2WJwOKX@google.com>
 <20240315012249.439639-1-liucong2@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240315012249.439639-1-liucong2@kylinos.cn>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

On Fri, Mar 15, 2024 at 09:22:48AM +0800, Cong Liu wrote:
> The tools/cgroup directory no longer contains a Makefile.  This patch
> updates the top-level tools/Makefile to remove references to building
> and installing cgroup components. This change reflects the current
> structure of the tools directory and fixes the build failure when
> building tools in the top-level directory.
> 
> linux/tools$ make cgroup
>   DESCEND cgroup
> make[1]: *** No targets specified and no makefile found.  Stop.
> make: *** [Makefile:73: cgroup] Error 2
> 
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>

Reviewed-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

> ---
>  tools/Makefile | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/Makefile b/tools/Makefile
> index 37e9f6804832..276f5d0d53a4 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -11,7 +11,6 @@ help:
>  	@echo ''
>  	@echo '  acpi                   - ACPI tools'
>  	@echo '  bpf                    - misc BPF tools'
> -	@echo '  cgroup                 - cgroup tools'
>  	@echo '  counter                - counter tools'
>  	@echo '  cpupower               - a tool for all things x86 CPU power'
>  	@echo '  debugging              - tools for debugging'
> @@ -69,7 +68,7 @@ acpi: FORCE
>  cpupower: FORCE
>  	$(call descend,power/$@)
>  
> -cgroup counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
> +counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
>  	$(call descend,$@)
>  
>  bpf/%: FORCE
> @@ -116,7 +115,7 @@ freefall: FORCE
>  kvm_stat: FORCE
>  	$(call descend,kvm/$@)
>  
> -all: acpi cgroup counter cpupower gpio hv firewire \
> +all: acpi counter cpupower gpio hv firewire \
>  		perf selftests bootconfig spi turbostat usb \
>  		virtio mm bpf x86_energy_perf_policy \
>  		tmon freefall iio objtool kvm_stat wmi \
> @@ -128,7 +127,7 @@ acpi_install:
>  cpupower_install:
>  	$(call descend,power/$(@:_install=),install)
>  
> -cgroup_install counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
> +counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
>  	$(call descend,$(@:_install=),install)
>  
>  selftests_install:
> @@ -155,7 +154,7 @@ freefall_install:
>  kvm_stat_install:
>  	$(call descend,kvm/$(@:_install=),install)
>  
> -install: acpi_install cgroup_install counter_install cpupower_install gpio_install \
> +install: acpi_install counter_install cpupower_install gpio_install \
>  		hv_install firewire_install iio_install \
>  		perf_install selftests_install turbostat_install usb_install \
>  		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
> @@ -169,7 +168,7 @@ acpi_clean:
>  cpupower_clean:
>  	$(call descend,power/cpupower,clean)
>  
> -cgroup_clean counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
> +counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
>  	$(call descend,$(@:_clean=),clean)
>  
>  libapi_clean:
> @@ -209,7 +208,7 @@ freefall_clean:
>  build_clean:
>  	$(call descend,build,clean)
>  
> -clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_clean \
> +clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
>  		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
>  		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
>  		freefall_clean build_clean libbpf_clean libsubcmd_clean \
> -- 
> 2.34.1
> 

-- 
Thank you,
Dmitry

