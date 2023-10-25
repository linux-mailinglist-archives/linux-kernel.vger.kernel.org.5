Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27D67D603D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjJYDH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjJYDHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:07:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B009B11F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:07:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9c145bb5bso58965ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698203238; x=1698808038; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5OBfrRrnZGN6Vmra3/pgADB2J78zcEJ7mL4TGGjs1I=;
        b=sZeSA7r8BqmvraxzITJzd6AZxNy4OBo+C0L2l0ig8duStVgZ18qyPJq34o+PjkZrRK
         blnnjfBJaQBu9OBMllkTBgJu4XPB6ExoNRBmicJBlyw0cChjDmJMA8cwEyb79xS44QsA
         f1vDHwx7S5+b4njl+w3XiRTUK54GE+wXX4SnA94wOAYbDrVZO1z2cKKSnEv2mQc1MnUM
         FkbiyREwSur+1Vit3jY9vyDdupYUuzyUHFWpJWAIcD64SopVpDiKa0ypC4CXXZHNl3z0
         5ERkogGAEo/PC268rRky6II9LDKjv0NRkFo9BnAJ/KMyBk5ZnkJwUdQpQIvvQS419uFE
         DFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698203238; x=1698808038;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5OBfrRrnZGN6Vmra3/pgADB2J78zcEJ7mL4TGGjs1I=;
        b=rkEmIpMk8RouL9VhOTJT4V9M7bVzNs7l0EEvdjgfD1GczA5aijy2E6VaSfHYZuvwb0
         b5rtQFDvrycLAcA/CkFcrrTNLYpq+aXTKZm6kEvyaY98ACpwf0QQiPHgf5XUVr8dmEvp
         OWz3w9YFkHpz4lBMdbqfnKnpn/1fwhDiGQYZsRZ6D/BzHKDTQaI6z3GwPjyX6R4I3p/a
         BYOf9yJ+/DC+NbmE9VaI+n/BNHKycfW1VDyR1tquHrXtxWo9NyhY3bryWRboJVuA552g
         1G4zlPjQ6051dqvkRgO2N+2iqqenlcFKQvu0a6rMz+0Q2bZ1ys3vFBDrFPGmI/0Q3nJ7
         GLGw==
X-Gm-Message-State: AOJu0Yw8Ydq63cXgoYQfzOnrZ+Mr8nDN2bQBnpDjIkvdNdSQ3BW+rU42
        aaCzRXPnZTPjHrhXje/LtgXCu/OXcNOyQ/egnmUGeQ==
X-Google-Smtp-Source: AGHT+IExAoce5cC1RemqpIYphu1NEZNrM6Dz7lB4iABPLWVGXlcSJRuk3NxQxzY/Y8WXsJmH00gKuQ==
X-Received: by 2002:a17:902:9f98:b0:1bd:9c78:8031 with SMTP id g24-20020a1709029f9800b001bd9c788031mr51938plq.9.1698203237373;
        Tue, 24 Oct 2023 20:07:17 -0700 (PDT)
Received: from smtpclient.apple ([2601:600:847f:d220:9dfb:2c2:7c62:20c3])
        by smtp.gmail.com with ESMTPSA id bz20-20020a056a02061400b005703a63836esm6708076pgb.57.2023.10.24.20.07.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Oct 2023 20:07:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [tip: x86/tdx] virt: Add TDX guest driver
From:   Qinkun Bao <qinkun@google.com>
In-Reply-To: <166872140395.4906.7561084756424988264.tip-bot2@tip-bot2>
Date:   Tue, 24 Oct 2023 20:07:05 -0700
Cc:     linux-tip-commits@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <31439861-FE58-424E-A583-63BC8A830757@google.com>
References: <166872140395.4906.7561084756424988264.tip-bot2@tip-bot2>
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the TSM ABI getting merged, I was wondering if the /dev/tdx_guest =
will stay in the=20
kernel?

> On Nov 17, 2022, at 1:43 PM, tip-bot2 for Kuppuswamy Sathyanarayanan =
<tip-bot2@linutronix.de> wrote:
>=20
> The following commit has been merged into the x86/tdx branch of tip:
>=20
> Commit-ID:     6c8c1406a6d6a3f2e61ac590f5c0994231bc6be7
> Gitweb:        =
https://git.kernel.org/tip/6c8c1406a6d6a3f2e61ac590f5c0994231bc6be7
> Author:        Kuppuswamy Sathyanarayanan =
<sathyanarayanan.kuppuswamy@linux.intel.com>
> AuthorDate:    Wed, 16 Nov 2022 14:38:19 -08:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Thu, 17 Nov 2022 11:04:23 -08:00
>=20
> virt: Add TDX guest driver
>=20
> TDX guest driver exposes IOCTL interfaces to service TDX guest
> user-specific requests. Currently, it is only used to allow the user =
to
> get the TDREPORT to support TDX attestation.
>=20
> Details about the TDX attestation process are documented in
> Documentation/x86/tdx.rst, and the IOCTL details are documented in
> Documentation/virt/coco/tdx-guest.rst.
>=20
> Operations like getting TDREPORT involves sending a blob of data as
> input and getting another blob of data as output. It was considered
> to use a sysfs interface for this, but it doesn't fit well into the
> standard sysfs model for configuring values. It would be possible to
> do read/write on files, but it would need multiple file descriptors,
> which would be somewhat messy. IOCTLs seem to be the best fitting
> and simplest model for this use case. The AMD sev-guest driver also
> uses the IOCTL interface to support attestation.
>=20
> [Bagas Sanjaya: Ack is for documentation portion]
> Signed-off-by: Kuppuswamy Sathyanarayanan =
<sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Wander Lairson Costa <wander@redhat.com>
> Link: =
https://lore.kernel.org/all/20221116223820.819090-3-sathyanarayanan.kuppus=
wamy%40linux.intel.com
> ---
> Documentation/virt/coco/tdx-guest.rst   |  52 ++++++++++++-
> Documentation/virt/index.rst            |   1 +-
> Documentation/x86/tdx.rst               |  43 ++++++++++-
> drivers/virt/Kconfig                    |   2 +-
> drivers/virt/Makefile                   |   1 +-
> drivers/virt/coco/tdx-guest/Kconfig     |  10 ++-
> drivers/virt/coco/tdx-guest/Makefile    |   2 +-
> drivers/virt/coco/tdx-guest/tdx-guest.c | 102 +++++++++++++++++++++++-
> include/uapi/linux/tdx-guest.h          |  42 +++++++++-
> 9 files changed, 255 insertions(+)
> create mode 100644 Documentation/virt/coco/tdx-guest.rst
> create mode 100644 drivers/virt/coco/tdx-guest/Kconfig
> create mode 100644 drivers/virt/coco/tdx-guest/Makefile
> create mode 100644 drivers/virt/coco/tdx-guest/tdx-guest.c
> create mode 100644 include/uapi/linux/tdx-guest.h
>=20
> diff --git a/Documentation/virt/coco/tdx-guest.rst =
b/Documentation/virt/coco/tdx-guest.rst
> new file mode 100644
> index 0000000..46e316d
> --- /dev/null
> +++ b/Documentation/virt/coco/tdx-guest.rst
> @@ -0,0 +1,52 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +TDX Guest API Documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +1. General description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The TDX guest driver exposes IOCTL interfaces via the /dev/tdx-guest =
misc
> +device to allow userspace to get certain TDX guest-specific details.
> +
> +2. API description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In this section, for each supported IOCTL, the following information =
is
> +provided along with a generic description.
> +
> +:Input parameters: Parameters passed to the IOCTL and related =
details.
> +:Output: Details about output data and return value (with details =
about
> +         the non common error values).
> +
> +2.1 TDX_CMD_GET_REPORT0
> +-----------------------
> +
> +:Input parameters: struct tdx_report_req
> +:Output: Upon successful execution, TDREPORT data is copied to
> +         tdx_report_req.tdreport and return 0. Return -EINVAL for =
invalid
> +         operands, -EIO on TDCALL failure or standard error number on =
other
> +         common failures.
> +
> +The TDX_CMD_GET_REPORT0 IOCTL can be used by the attestation software =
to get
> +the TDREPORT0 (a.k.a. TDREPORT subtype 0) from the TDX module using
> +TDCALL[TDG.MR.REPORT].
> +
> +A subtype index is added at the end of this IOCTL CMD to uniquely =
identify the
> +subtype-specific TDREPORT request. Although the subtype option is =
mentioned in
> +the TDX Module v1.0 specification, section titled "TDG.MR.REPORT", it =
is not
> +currently used, and it expects this value to be 0. So to keep the =
IOCTL
> +implementation simple, the subtype option was not included as part of =
the input
> +ABI. However, in the future, if the TDX Module supports more than one =
subtype,
> +a new IOCTL CMD will be created to handle it. To keep the IOCTL =
naming
> +consistent, a subtype index is added as part of the IOCTL CMD.
> +
> +Reference
> +---------
> +
> +TDX reference material is collected here:
> +
> =
+https://www.intel.com/content/www/us/en/developer/articles/technical/inte=
l-trust-domain-extensions.html
> +
> +The driver is based on TDX module specification v1.0 and TDX GHCI =
specification v1.0.
> diff --git a/Documentation/virt/index.rst =
b/Documentation/virt/index.rst
> index 2f1cffa..56e003f 100644
> --- a/Documentation/virt/index.rst
> +++ b/Documentation/virt/index.rst
> @@ -14,6 +14,7 @@ Linux Virtualization Support
>    ne_overview
>    acrn/index
>    coco/sev-guest
> +   coco/tdx-guest
>    hyperv/index
>=20
> .. only:: html and subproject
> diff --git a/Documentation/x86/tdx.rst b/Documentation/x86/tdx.rst
> index b8fa432..dc8d9fd 100644
> --- a/Documentation/x86/tdx.rst
> +++ b/Documentation/x86/tdx.rst
> @@ -210,6 +210,49 @@ converted to shared on boot.
> For coherent DMA allocation, the DMA buffer gets converted on the
> allocation. Check force_dma_unencrypted() for details.
>=20
> +Attestation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Attestation is used to verify the TDX guest trustworthiness to other
> +entities before provisioning secrets to the guest. For example, a key
> +server may want to use attestation to verify that the guest is the
> +desired one before releasing the encryption keys to mount the =
encrypted
> +rootfs or a secondary drive.
> +
> +The TDX module records the state of the TDX guest in various stages =
of
> +the guest boot process using the build time measurement register =
(MRTD)
> +and runtime measurement registers (RTMR). Measurements related to the
> +guest initial configuration and firmware image are recorded in the =
MRTD
> +register. Measurements related to initial state, kernel image, =
firmware
> +image, command line options, initrd, ACPI tables, etc are recorded in
> +RTMR registers. For more details, as an example, please refer to TDX
> +Virtual Firmware design specification, section titled "TD =
Measurement".
> +At TDX guest runtime, the attestation process is used to attest to =
these
> +measurements.
> +
> +The attestation process consists of two steps: TDREPORT generation =
and
> +Quote generation.
> +
> +TDX guest uses TDCALL[TDG.MR.REPORT] to get the TDREPORT =
(TDREPORT_STRUCT)
> +from the TDX module. TDREPORT is a fixed-size data structure =
generated by
> +the TDX module which contains guest-specific information (such as =
build
> +and boot measurements), platform security version, and the MAC to =
protect
> +the integrity of the TDREPORT. A user-provided 64-Byte REPORTDATA is =
used
> +as input and included in the TDREPORT. Typically it can be some nonce
> +provided by attestation service so the TDREPORT can be verified =
uniquely.
> +More details about the TDREPORT can be found in Intel TDX Module
> +specification, section titled "TDG.MR.REPORT Leaf".
> +
> +After getting the TDREPORT, the second step of the attestation =
process
> +is to send it to the Quoting Enclave (QE) to generate the Quote. =
TDREPORT
> +by design can only be verified on the local platform as the MAC key =
is
> +bound to the platform. To support remote verification of the =
TDREPORT,
> +TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT =
locally
> +and convert it to a remotely verifiable Quote. Method of sending =
TDREPORT
> +to QE is implementation specific. Attestation software can choose
> +whatever communication channel available (i.e. vsock or TCP/IP) to
> +send the TDREPORT to QE and receive the Quote.
> +
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index 87ef258..f79ab13 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -52,4 +52,6 @@ source "drivers/virt/coco/efi_secret/Kconfig"
>=20
> source "drivers/virt/coco/sev-guest/Kconfig"
>=20
> +source "drivers/virt/coco/tdx-guest/Kconfig"
> +
> endif
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index 093674e..e9aa6fc 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_NITRO_ENCLAVES)	+=3D =
nitro_enclaves/
> obj-$(CONFIG_ACRN_HSM)		+=3D acrn/
> obj-$(CONFIG_EFI_SECRET)	+=3D coco/efi_secret/
> obj-$(CONFIG_SEV_GUEST)		+=3D coco/sev-guest/
> +obj-$(CONFIG_INTEL_TDX_GUEST)	+=3D coco/tdx-guest/
> diff --git a/drivers/virt/coco/tdx-guest/Kconfig =
b/drivers/virt/coco/tdx-guest/Kconfig
> new file mode 100644
> index 0000000..14246fc
> --- /dev/null
> +++ b/drivers/virt/coco/tdx-guest/Kconfig
> @@ -0,0 +1,10 @@
> +config TDX_GUEST_DRIVER
> +	tristate "TDX Guest driver"
> +	depends on INTEL_TDX_GUEST
> +	help
> +	  The driver provides userspace interface to communicate with
> +	  the TDX module to request the TDX guest details like =
attestation
> +	  report.
> +
> +	  To compile this driver as module, choose M here. The module =
will
> +	  be called tdx-guest.
> diff --git a/drivers/virt/coco/tdx-guest/Makefile =
b/drivers/virt/coco/tdx-guest/Makefile
> new file mode 100644
> index 0000000..775cb46
> --- /dev/null
> +++ b/drivers/virt/coco/tdx-guest/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_TDX_GUEST_DRIVER) +=3D tdx-guest.o
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c =
b/drivers/virt/coco/tdx-guest/tdx-guest.c
> new file mode 100644
> index 0000000..5e44a0f
> --- /dev/null
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TDX guest user interface driver
> + *
> + * Copyright (C) 2022 Intel Corporation
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +
> +#include <uapi/linux/tdx-guest.h>
> +
> +#include <asm/cpu_device_id.h>
> +#include <asm/tdx.h>
> +
> +static long tdx_get_report0(struct tdx_report_req __user *req)
> +{
> +	u8 *reportdata, *tdreport;
> +	long ret;
> +
> +	reportdata =3D kmalloc(TDX_REPORTDATA_LEN, GFP_KERNEL);
> +	if (!reportdata)
> +		return -ENOMEM;
> +
> +	tdreport =3D kzalloc(TDX_REPORT_LEN, GFP_KERNEL);
> +	if (!tdreport) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (copy_from_user(reportdata, req->reportdata, =
TDX_REPORTDATA_LEN)) {
> +		ret =3D -EFAULT;
> +		goto out;
> +	}
> +
> +	/* Generate TDREPORT0 using "TDG.MR.REPORT" TDCALL */
> +	ret =3D tdx_mcall_get_report0(reportdata, tdreport);
> +	if (ret)
> +		goto out;
> +
> +	if (copy_to_user(req->tdreport, tdreport, TDX_REPORT_LEN))
> +		ret =3D -EFAULT;
> +
> +out:
> +	kfree(reportdata);
> +	kfree(tdreport);
> +
> +	return ret;
> +}
> +
> +static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	switch (cmd) {
> +	case TDX_CMD_GET_REPORT0:
> +		return tdx_get_report0((struct tdx_report_req __user =
*)arg);
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +static const struct file_operations tdx_guest_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.unlocked_ioctl =3D tdx_guest_ioctl,
> +	.llseek =3D no_llseek,
> +};
> +
> +static struct miscdevice tdx_misc_dev =3D {
> +	.name =3D KBUILD_MODNAME,
> +	.minor =3D MISC_DYNAMIC_MINOR,
> +	.fops =3D &tdx_guest_fops,
> +};
> +
> +static const struct x86_cpu_id tdx_guest_ids[] =3D {
> +	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
> +
> +static int __init tdx_guest_init(void)
> +{
> +	if (!x86_match_cpu(tdx_guest_ids))
> +		return -ENODEV;
> +
> +	return misc_register(&tdx_misc_dev);
> +}
> +module_init(tdx_guest_init);
> +
> +static void __exit tdx_guest_exit(void)
> +{
> +	misc_deregister(&tdx_misc_dev);
> +}
> +module_exit(tdx_guest_exit);
> +
> +MODULE_AUTHOR("Kuppuswamy Sathyanarayanan =
<sathyanarayanan.kuppuswamy@linux.intel.com>");
> +MODULE_DESCRIPTION("TDX Guest Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/tdx-guest.h =
b/include/uapi/linux/tdx-guest.h
> new file mode 100644
> index 0000000..a6a2098
> --- /dev/null
> +++ b/include/uapi/linux/tdx-guest.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Userspace interface for TDX guest driver
> + *
> + * Copyright (C) 2022 Intel Corporation
> + */
> +
> +#ifndef _UAPI_LINUX_TDX_GUEST_H_
> +#define _UAPI_LINUX_TDX_GUEST_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/* Length of the REPORTDATA used in TDG.MR.REPORT TDCALL */
> +#define TDX_REPORTDATA_LEN              64
> +
> +/* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
> +#define TDX_REPORT_LEN                  1024
> +
> +/**
> + * struct tdx_report_req - Request struct for TDX_CMD_GET_REPORT0 =
IOCTL.
> + *
> + * @reportdata: User buffer with REPORTDATA to be included into =
TDREPORT.
> + *              Typically it can be some nonce provided by =
attestation
> + *              service, so the generated TDREPORT can be uniquely =
verified.
> + * @tdreport: User buffer to store TDREPORT output from =
TDCALL[TDG.MR.REPORT].
> + */
> +struct tdx_report_req {
> +	__u8 reportdata[TDX_REPORTDATA_LEN];
> +	__u8 tdreport[TDX_REPORT_LEN];
> +};
> +
> +/*
> + * TDX_CMD_GET_REPORT0 - Get TDREPORT0 (a.k.a. TDREPORT subtype 0) =
using
> + *                       TDCALL[TDG.MR.REPORT]
> + *
> + * Return 0 on success, -EIO on TDCALL execution failure, and
> + * standard errno on other general error cases.
> + */
> +#define TDX_CMD_GET_REPORT0              _IOWR('T', 1, struct =
tdx_report_req)
> +
> +#endif /* _UAPI_LINUX_TDX_GUEST_H_ */
>=20

