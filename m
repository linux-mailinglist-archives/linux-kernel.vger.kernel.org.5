Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5407C5DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376303AbjJKUBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjJKUBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:01:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3498BA9;
        Wed, 11 Oct 2023 13:01:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31f71b25a99so203403f8f.2;
        Wed, 11 Oct 2023 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697054500; x=1697659300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJroCQ5f7MWlIlaijqfjlzkCzCi0InBWPA+64vhHzGc=;
        b=IE40i2pL4u0LhBFcVQOHdK8moClhihC6wbzg12+hRTBgW8tbS0Z7M8qfUMjj78mJD2
         aXt8i1SqBAfn1VY4rOzMZIc/+9tPotXQReXW32UdxWgjB8Be0sjGpLbzHEaq7VFxHtPW
         8x32W3J0ZWIVk0+QX5vKT22oF4bYA+Rne7/Aayb9nI1mMZhY2t/YtjOdMRM+dzYjIlbj
         bbrcevldr7UbOKtvxkmV4YelIv0ocyuNQG+tJTonF4OPRqH05S/UAKs94k9Jbh3PZNGm
         UKO/wWhxniv3wYsI27vW5jQF3d1vEXhCZ62GC4CQ9rEb4Q9TmwwoQi0fSuyh1jT2cxsx
         edLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697054500; x=1697659300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJroCQ5f7MWlIlaijqfjlzkCzCi0InBWPA+64vhHzGc=;
        b=GUvDBOHIrdjpIYfHfsJjEgJWqkrVZjW0KQW4k52IL2OMuQbLCYuQirWZ31+OpBLKhl
         GWo9Ppq8rFo9GLsWrfX7vt3gNg4ML5S9ClMFA9ae1GbGJ/EVmKjFL7tEuFnMo9SDHcj8
         yhrKovkr+jdS9ck9di1e7iyR3NJzT72QodNARwQaedfZPSbIkfw8CPt+0/Xbpn9oTcqx
         n0b36y/7HWfpv7TOX2GPbLyNA8rcNyV/e5mU2CZRUufzi0AdCcP3CWWUZC6tJKtpb5Sx
         Ku4LqAv7VOcsEfWKVLdmIWbv7ykud12I2FVgTx9WK5nM19AQyGMENbnRqbry9ZVGT0Nf
         FjTQ==
X-Gm-Message-State: AOJu0Yy7tSHQpOhwzQxRavS7iXbRtBgnr6QNH7qQfpASYY80kBERBgKl
        0ngjTA9a6ElkUiX5OuYv/rwwKkrWwns=
X-Google-Smtp-Source: AGHT+IEYYG1g8e0+HZgSWRaku+rRsiOSJnc04Ze6VUY+cqtVVM63VjUX6K7a9c5dGy9q/VUE9K3TJA==
X-Received: by 2002:adf:dd8f:0:b0:313:f45f:74a1 with SMTP id x15-20020adfdd8f000000b00313f45f74a1mr20263516wrl.51.1697054500257;
        Wed, 11 Oct 2023 13:01:40 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d604f000000b003259b068ba6sm16437370wrt.7.2023.10.11.13.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:01:39 -0700 (PDT)
Message-ID: <1388bb68-dc55-489d-bb3c-517ffcf4443d@gmail.com>
Date:   Wed, 11 Oct 2023 22:01:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] firmware: qcom: move Qualcomm code into its own
 directory
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-2-brgl@bgdev.pl>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231009153427.20951-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 17:34, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We're getting more and more qcom specific .c files in drivers/firmware/
> and about to get even more. Create a separate directory for Qualcomm
> firmware drivers and move existing sources in there.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Elliot Berman <quic_eberman@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   MAINTAINERS                                   |  4 +-
>   drivers/firmware/Kconfig                      | 48 +---------------
>   drivers/firmware/Makefile                     |  5 +-
>   drivers/firmware/qcom/Kconfig                 | 56 +++++++++++++++++++
>   drivers/firmware/qcom/Makefile                |  9 +++
>   drivers/firmware/{ => qcom}/qcom_qseecom.c    |  0
>   .../{ => qcom}/qcom_qseecom_uefisecapp.c      |  0
>   drivers/firmware/{ => qcom}/qcom_scm-legacy.c |  0
>   drivers/firmware/{ => qcom}/qcom_scm-smc.c    |  0
>   drivers/firmware/{ => qcom}/qcom_scm.c        |  0
>   drivers/firmware/{ => qcom}/qcom_scm.h        |  0
>   11 files changed, 69 insertions(+), 53 deletions(-)
>   create mode 100644 drivers/firmware/qcom/Kconfig
>   create mode 100644 drivers/firmware/qcom/Makefile
>   rename drivers/firmware/{ => qcom}/qcom_qseecom.c (100%)
>   rename drivers/firmware/{ => qcom}/qcom_qseecom_uefisecapp.c (100%)
>   rename drivers/firmware/{ => qcom}/qcom_scm-legacy.c (100%)
>   rename drivers/firmware/{ => qcom}/qcom_scm-smc.c (100%)
>   rename drivers/firmware/{ => qcom}/qcom_scm.c (100%)
>   rename drivers/firmware/{ => qcom}/qcom_scm.h (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c934244acc31..0d032572cce0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17930,13 +17930,13 @@ QUALCOMM QSEECOM DRIVER
>   M:	Maximilian Luz <luzmaximilian@gmail.com>
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained
> -F:	drivers/firmware/qcom_qseecom.c
> +F:	drivers/firmware/qcom/qcom_qseecom.c
>   
>   QUALCOMM QSEECOM UEFISECAPP DRIVER
>   M:	Maximilian Luz <luzmaximilian@gmail.com>
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained
> -F:	drivers/firmware/qcom_qseecom_uefisecapp.c
> +F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
>   
>   QUALCOMM RMNET DRIVER
>   M:	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 817e011a8945..74d00b0c83fe 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -188,53 +188,6 @@ config MTK_ADSP_IPC
>   	  ADSP exists on some mtk processors.
>   	  Client might use shared memory to exchange information with ADSP.
>   
> -config QCOM_SCM
> -	tristate
> -
> -config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> -	bool "Qualcomm download mode enabled by default"
> -	depends on QCOM_SCM
> -	help
> -	  A device with "download mode" enabled will upon an unexpected
> -	  warm-restart enter a special debug mode that allows the user to
> -	  "download" memory content over USB for offline postmortem analysis.
> -	  The feature can be enabled/disabled on the kernel command line.
> -
> -	  Say Y here to enable "download mode" by default.
> -
> -config QCOM_QSEECOM
> -	bool "Qualcomm QSEECOM interface driver"
> -	depends on QCOM_SCM=y
> -	select AUXILIARY_BUS
> -	help
> -	  Various Qualcomm SoCs have a Secure Execution Environment (SEE) running
> -	  in the Trust Zone. This module provides an interface to that via the
> -	  QSEECOM mechanism, using SCM calls.
> -
> -	  The QSEECOM interface allows, among other things, access to applications
> -	  running in the SEE. An example of such an application is 'uefisecapp',
> -	  which is required to access UEFI variables on certain systems. If
> -	  selected, the interface will also attempt to detect and register client
> -	  devices for supported applications.
> -
> -	  Select Y here to enable the QSEECOM interface driver.
> -
> -config QCOM_QSEECOM_UEFISECAPP
> -	bool "Qualcomm SEE UEFI Secure App client driver"
> -	depends on QCOM_QSEECOM
> -	depends on EFI
> -	help
> -	  Various Qualcomm SoCs do not allow direct access to EFI variables.
> -	  Instead, these need to be accessed via the UEFI Secure Application
> -	  (uefisecapp), residing in the Secure Execution Environment (SEE).
> -
> -	  This module provides a client driver for uefisecapp, installing efivar
> -	  operations to allow the kernel accessing EFI variables, and via that also
> -	  provide user-space with access to EFI variables via efivarfs.
> -
> -	  Select Y here to provide access to EFI variables on the aforementioned
> -	  platforms.
> -
>   config SYSFB
>   	bool
>   	select BOOT_VESA_SUPPORT
> @@ -320,6 +273,7 @@ source "drivers/firmware/efi/Kconfig"
>   source "drivers/firmware/imx/Kconfig"
>   source "drivers/firmware/meson/Kconfig"
>   source "drivers/firmware/psci/Kconfig"
> +source "drivers/firmware/qcom/Kconfig"
>   source "drivers/firmware/smccc/Kconfig"
>   source "drivers/firmware/tegra/Kconfig"
>   source "drivers/firmware/xilinx/Kconfig"
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index cb18fd8882dc..5f9dab82e1a0 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -17,10 +17,6 @@ obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
>   obj-$(CONFIG_MTK_ADSP_IPC)	+= mtk-adsp-ipc.o
>   obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
>   obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
> -obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
> -qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
> -obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
> -obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>   obj-$(CONFIG_SYSFB)		+= sysfb.o
>   obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
>   obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
> @@ -36,6 +32,7 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
>   obj-y				+= efi/
>   obj-y				+= imx/
>   obj-y				+= psci/
> +obj-y				+= qcom/
>   obj-y				+= smccc/
>   obj-y				+= tegra/
>   obj-y				+= xilinx/
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> new file mode 100644
> index 000000000000..3f05d9854ddf
> --- /dev/null
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# For a description of the syntax of this configuration file,
> +# see Documentation/kbuild/kconfig-language.rst.
> +#
> +
> +menu "Qualcomm firmware drivers"
> +
> +config QCOM_SCM
> +	tristate
> +
> +config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> +	bool "Qualcomm download mode enabled by default"
> +	depends on QCOM_SCM
> +	help
> +	  A device with "download mode" enabled will upon an unexpected
> +	  warm-restart enter a special debug mode that allows the user to
> +	  "download" memory content over USB for offline postmortem analysis.
> +	  The feature can be enabled/disabled on the kernel command line.
> +
> +	  Say Y here to enable "download mode" by default.
> +
> +config QCOM_QSEECOM
> +	bool "Qualcomm QSEECOM interface driver"
> +	depends on QCOM_SCM=y
> +	select AUXILIARY_BUS
> +	help
> +	  Various Qualcomm SoCs have a Secure Execution Environment (SEE) running
> +	  in the Trust Zone. This module provides an interface to that via the
> +	  QSEECOM mechanism, using SCM calls.
> +
> +	  The QSEECOM interface allows, among other things, access to applications
> +	  running in the SEE. An example of such an application is 'uefisecapp',
> +	  which is required to access UEFI variables on certain systems. If
> +	  selected, the interface will also attempt to detect and register client
> +	  devices for supported applications.
> +
> +	  Select Y here to enable the QSEECOM interface driver.
> +
> +config QCOM_QSEECOM_UEFISECAPP
> +	bool "Qualcomm SEE UEFI Secure App client driver"
> +	depends on QCOM_QSEECOM
> +	depends on EFI
> +	help
> +	  Various Qualcomm SoCs do not allow direct access to EFI variables.
> +	  Instead, these need to be accessed via the UEFI Secure Application
> +	  (uefisecapp), residing in the Secure Execution Environment (SEE).
> +
> +	  This module provides a client driver for uefisecapp, installing efivar
> +	  operations to allow the kernel accessing EFI variables, and via that also
> +	  provide user-space with access to EFI variables via efivarfs.
> +
> +	  Select Y here to provide access to EFI variables on the aforementioned
> +	  platforms.
> +
> +endmenu
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> new file mode 100644
> index 000000000000..c9f12ee8224a
> --- /dev/null
> +++ b/drivers/firmware/qcom/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the linux kernel.
> +#
> +
> +obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
> +qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
> +obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
> +obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> diff --git a/drivers/firmware/qcom_qseecom.c b/drivers/firmware/qcom/qcom_qseecom.c
> similarity index 100%
> rename from drivers/firmware/qcom_qseecom.c
> rename to drivers/firmware/qcom/qcom_qseecom.c
> diff --git a/drivers/firmware/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> similarity index 100%
> rename from drivers/firmware/qcom_qseecom_uefisecapp.c
> rename to drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
> diff --git a/drivers/firmware/qcom_scm-legacy.c b/drivers/firmware/qcom/qcom_scm-legacy.c
> similarity index 100%
> rename from drivers/firmware/qcom_scm-legacy.c
> rename to drivers/firmware/qcom/qcom_scm-legacy.c
> diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
> similarity index 100%
> rename from drivers/firmware/qcom_scm-smc.c
> rename to drivers/firmware/qcom/qcom_scm-smc.c
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> similarity index 100%
> rename from drivers/firmware/qcom_scm.c
> rename to drivers/firmware/qcom/qcom_scm.c
> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
> similarity index 100%
> rename from drivers/firmware/qcom_scm.h
> rename to drivers/firmware/qcom/qcom_scm.h
