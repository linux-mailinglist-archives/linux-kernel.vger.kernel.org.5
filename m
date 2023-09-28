Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D427B2346
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjI1RI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1RIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:08:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E4AE5;
        Thu, 28 Sep 2023 10:08:48 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SGf7Am018949;
        Thu, 28 Sep 2023 17:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xvRgDNK0FQ7LSRCKrQlq/sE+oWhUVu8+tPCpEWnnXVI=;
 b=PNN4Sakm7E895hX6caLDB4/mtsoWr4Ni8Z9swUErbAdsVly4p2h2wqa7oY+ULbM/EZhv
 a4xm+xUjiuPUF1NmUkO/wappfNTHapzqT2SAzrzqGCDfaQr8xmtxhTqL5w16rH8plp8+
 DCEqiI0BOsQYRlGmB43By7uOhsQvTHo4oO+1BKFLcHCYgXbiZPmW+5k2L8FKlqNSk4e8
 73Uuhw9bwjjHyYzON8U3TiRMXgUNAJHPbPvcJt6jjGPi7+f7IR/0jjZxWhIEUPbYdS4A
 C3HQo4Jt+9Zt0pGLT2R/zkaMXxkabW6Y9Go8uJCTEiVx2pOd3AC/9kDUYdErCv8OPGbT Qw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tcmqebe78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 17:08:43 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38SH8gEF014324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 17:08:42 GMT
Received: from [10.110.102.158] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 28 Sep
 2023 10:08:38 -0700
Message-ID: <e30498f0-4876-4d47-ad41-d140c2a7639a@quicinc.com>
Date:   Thu, 28 Sep 2023 10:08:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] firmware: qcom: move Qualcomm code into its own
 directory
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230928092040.9420-1-brgl@bgdev.pl>
 <20230928092040.9420-2-brgl@bgdev.pl>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230928092040.9420-2-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1J8Rn1d4ZHl_lwRZBiwAQHbhjWKKk9BK
X-Proofpoint-GUID: 1J8Rn1d4ZHl_lwRZBiwAQHbhjWKKk9BK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2023 2:20 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We're getting more and more qcom specific .c files in drivers/firmware/
> and about to get even more. Create a separate directory for Qualcomm
> firmware drivers and move existing sources in there.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Acked-by: Elliot Berman <quic_eberman@quicinc.com>

> ---
>  MAINTAINERS                                   |  4 +-
>  drivers/firmware/Kconfig                      | 48 +---------------
>  drivers/firmware/Makefile                     |  5 +-
>  drivers/firmware/qcom/Kconfig                 | 56 +++++++++++++++++++
>  drivers/firmware/qcom/Makefile                |  9 +++
>  drivers/firmware/{ => qcom}/qcom_qseecom.c    |  0
>  .../{ => qcom}/qcom_qseecom_uefisecapp.c      |  0
>  drivers/firmware/{ => qcom}/qcom_scm-legacy.c |  0
>  drivers/firmware/{ => qcom}/qcom_scm-smc.c    |  0
>  drivers/firmware/{ => qcom}/qcom_scm.c        |  0
>  drivers/firmware/{ => qcom}/qcom_scm.h        |  0
>  11 files changed, 69 insertions(+), 53 deletions(-)
>  create mode 100644 drivers/firmware/qcom/Kconfig
>  create mode 100644 drivers/firmware/qcom/Makefile
>  rename drivers/firmware/{ => qcom}/qcom_qseecom.c (100%)
>  rename drivers/firmware/{ => qcom}/qcom_qseecom_uefisecapp.c (100%)
>  rename drivers/firmware/{ => qcom}/qcom_scm-legacy.c (100%)
>  rename drivers/firmware/{ => qcom}/qcom_scm-smc.c (100%)
>  rename drivers/firmware/{ => qcom}/qcom_scm.c (100%)
>  rename drivers/firmware/{ => qcom}/qcom_scm.h (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 861a16b4586c..88c2186b4975 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17887,13 +17887,13 @@ QUALCOMM QSEECOM DRIVER
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> -F:	drivers/firmware/qcom_qseecom.c
> +F:	drivers/firmware/qcom/qcom_qseecom.c
>  
>  QUALCOMM QSEECOM UEFISECAPP DRIVER
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> -F:	drivers/firmware/qcom_qseecom_uefisecapp.c
> +F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
>  
>  QUALCOMM RMNET DRIVER
>  M:	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 817e011a8945..74d00b0c83fe 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -188,53 +188,6 @@ config MTK_ADSP_IPC
>  	  ADSP exists on some mtk processors.
>  	  Client might use shared memory to exchange information with ADSP.
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
>  config SYSFB
>  	bool
>  	select BOOT_VESA_SUPPORT
> @@ -320,6 +273,7 @@ source "drivers/firmware/efi/Kconfig"
>  source "drivers/firmware/imx/Kconfig"
>  source "drivers/firmware/meson/Kconfig"
>  source "drivers/firmware/psci/Kconfig"
> +source "drivers/firmware/qcom/Kconfig"
>  source "drivers/firmware/smccc/Kconfig"
>  source "drivers/firmware/tegra/Kconfig"
>  source "drivers/firmware/xilinx/Kconfig"
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index cb18fd8882dc..5f9dab82e1a0 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -17,10 +17,6 @@ obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
>  obj-$(CONFIG_MTK_ADSP_IPC)	+= mtk-adsp-ipc.o
>  obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
>  obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
> -obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
> -qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
> -obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
> -obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
>  obj-$(CONFIG_SYSFB)		+= sysfb.o
>  obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
>  obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
> @@ -36,6 +32,7 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
>  obj-y				+= efi/
>  obj-y				+= imx/
>  obj-y				+= psci/
> +obj-y				+= qcom/
>  obj-y				+= smccc/
>  obj-y				+= tegra/
>  obj-y				+= xilinx/
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
