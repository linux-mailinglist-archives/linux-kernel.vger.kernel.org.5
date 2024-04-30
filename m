Return-Path: <linux-kernel+bounces-164635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B3D8B8075
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89C11F23E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631EC199E84;
	Tue, 30 Apr 2024 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGivK6Xd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F34A180A85;
	Tue, 30 Apr 2024 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714504875; cv=none; b=t439x8EfymXvVQvBOoUHJ0jz0w9ZdX7aTD8Nc5qt8ekMnd9AO4eMVC/WRaUsIVQq9cUgecqgcfn7ycME1QDRD7qratNUle96wBd/TLS7KO7osrUdFwhpEIr9ZVNpr4F0SzI/p7dHKhXwZwPL6wvp++9+1paUkCs9/v/OiJkXc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714504875; c=relaxed/simple;
	bh=NwCpJ4/aGdZMBhntTpNF2is84X693tSgQ+YYuyWOaN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaRHe6G0EpFc3nfaLid0gEXxIqJd2NmA91jKrCGLluEsgbwYtu74kg4NVcbMchTn4QjssnAXZ588pZL2kYCZsf40Xj3X03xO3hZr7ZIpBx3SOdN7TDCaO/XvIYJxxhv8rBvZF9pBbu15f3xNYdMOkRDxhB5VU5z/ZTX2j1ExSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGivK6Xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3528BC4AF19;
	Tue, 30 Apr 2024 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714504875;
	bh=NwCpJ4/aGdZMBhntTpNF2is84X693tSgQ+YYuyWOaN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FGivK6XdMlE8GYQL9XYMPwVUArMvu1ZGE7XvPUSsLtq5SEaC6Fm8+ly6La5ICit2F
	 3Nm62Sfe4F5uIupBOychwZIpUXRIORhiW0UmuOUjsonataTQy1cz2p7MRoW7C9Py2s
	 K26e7OXc3FHXpn7W89ezL63lgPkUPTjb6HYr5YFrNfW2x1Sd4o8RnljytkWcfTTjeq
	 7p4KZRhkpLqr+1+HDH26WGwCkhywKnowDxayb817fX9CBcZJgbDvghv7Y6vj0Wqst5
	 5pw4Yu9CPHVpyagzXWMJ8ebnaMoDyQ7mjCx1t6zDkESE47vfjFmDfSairuKZgBEdgm
	 xrh3bZH3OehgA==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c73b33383aso543375b6e.3;
        Tue, 30 Apr 2024 12:21:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5QWJuBQ19MgDgQROhaBl21AN1B7/mbvb9/BXGSS8H12xYI2NuDeLk36hqmhbX3yQWGJbHtND3uok1RuMQ5qyUk0Tcl0taBbkOciqDpDrPa/1lw72lLy1hF1yzixcmZNvwBRAegpFm5A==
X-Gm-Message-State: AOJu0YxnFvsTCKTAns3fR+/L2iGRARSNDL2JFB5uHIY2wXPNzTNZS2Mu
	E4aF/r6EovvGH4GmtXg+s+gd7NELt0XB1gip/Nt1qk8jHp1on8iRchKo1erMB9wpKPZaESQAJgl
	wkLo/ey7JTVHm+S4VJB3C36dwjlk=
X-Google-Smtp-Source: AGHT+IFj1FZy70S4ykIy+b2SrpBWlxIdXPP5QjFwuFLgwuOnQk3mWrQ7e+Wppfq3P/0JuOtNcJYrZswXSnHuEGZMa+M=
X-Received: by 2002:a4a:654d:0:b0:5aa:241a:7f4b with SMTP id
 z13-20020a4a654d000000b005aa241a7f4bmr397384oog.1.1714504874373; Tue, 30 Apr
 2024 12:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425093426.76130-1-tianruidong@linux.alibaba.com> <20240425093426.76130-2-tianruidong@linux.alibaba.com>
In-Reply-To: <20240425093426.76130-2-tianruidong@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 21:21:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i8=oTCXhAMRAckaVrTqCfOPxyYucpEguMF0tH2orY3aA@mail.gmail.com>
Message-ID: <CAJZ5v0i8=oTCXhAMRAckaVrTqCfOPxyYucpEguMF0tH2orY3aA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ACPICA: AEST: Add support for the AEST V2 table
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	rafael@kernel.org, sudeep.holla@arm.com, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 11:34=E2=80=AFAM Ruidong Tian
<tianruidong@linux.alibaba.com> wrote:
>
> ACPICA commit ebb49799c78891cbe370f1264844664a3d8b6f35
>
> AEST V2 was published[1], add V2 support based on AEST V1.
>
> [1]: https://developer.arm.com/documentation/den0085/latest/
>
> Link: https://github.com/acpica/acpica/commit/ebb4979
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>  include/acpi/actbl2.h | 88 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 82 insertions(+), 6 deletions(-)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 007cfdfd5d29..ae747c89d92c 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -78,8 +78,8 @@
>   *
>   * AEST - Arm Error Source Table
>   *
> - * Conforms to: ACPI for the Armv8 RAS Extensions 1.1 Platform Design Do=
cument
> - * September 2020.
> + * Conforms to: ACPI for the Armv8 RAS Extensions 1.1(Sep 2020) and
> + * 2.0(May 2023) Platform Design Document.
>   *
>   ***********************************************************************=
*******/
>
> @@ -109,7 +109,9 @@ struct acpi_aest_hdr {
>  #define ACPI_AEST_SMMU_ERROR_NODE           2
>  #define ACPI_AEST_VENDOR_ERROR_NODE         3
>  #define ACPI_AEST_GIC_ERROR_NODE            4
> -#define ACPI_AEST_NODE_TYPE_RESERVED        5  /* 5 and above are reserv=
ed */
> +#define ACPI_AEST_PCIE_ERROR_NODE           5
> +#define ACPI_AEST_PROXY_ERROR_NODE          6
> +#define ACPI_AEST_NODE_TYPE_RESERVED        7 /* 7 and above are reserve=
d */
>
>  /*
>   * AEST subtables (Error nodes)
> @@ -188,6 +190,12 @@ typedef struct acpi_aest_vendor {
>
>  } acpi_aest_vendor;
>
> +struct acpi_aest_vendor_v2 {
> +       char acpi_hid[8];
> +       u32 acpi_uid;
> +       u8 vendor_specific_data[16];
> +};
> +
>  /* 4: Gic Error */
>
>  typedef struct acpi_aest_gic {
> @@ -204,6 +212,18 @@ typedef struct acpi_aest_gic {
>  #define ACPI_AEST_GIC_ITS                   3
>  #define ACPI_AEST_GIC_RESERVED              4  /* 4 and above are reserv=
ed */
>
> +/* 5: PCIe Error */
> +
> +struct acpi_aest_pcie {
> +       u32 iort_node_reference;
> +};
> +
> +/* 6: Proxy Error */
> +
> +struct acpi_aest_proxy {
> +       u64 node_address;
> +};
> +
>  /* Node Interface Structure */
>
>  typedef struct acpi_aest_node_interface {
> @@ -219,11 +239,57 @@ typedef struct acpi_aest_node_interface {
>
>  } acpi_aest_node_interface;
>
> +/* Node Interface Structure V2 */
> +
> +struct acpi_aest_node_interface_header {
> +       u8 type;
> +       u8 group_format;
> +       u8 reserved[2];
> +       u32 flags;
> +       u64 address;
> +       u32 error_record_index;
> +       u32 error_record_count;
> +};
> +
> +#define ACPI_AEST_NODE_GROUP_FORMAT_4K          0
> +#define ACPI_AEST_NODE_GROUP_FORMAT_16K         1
> +#define ACPI_AEST_NODE_GROUP_FORMAT_64K         2
> +
> +struct acpi_aest_node_interface_common {
> +       u32 error_node_device;
> +       u32 processor_affinity;
> +       u64 error_group_register_base;
> +       u64 fault_inject_register_base;
> +       u64 interrupt_config_register_base;
> +};
> +
> +struct acpi_aest_node_interface_4k {
> +       u64 error_record_implemented;
> +       u64 error_status_reporting;
> +       u64 addressing_mode;
> +       struct acpi_aest_node_interface_common common;
> +};
> +
> +struct acpi_aest_node_interface_16k {
> +       u64 error_record_implemented[4];
> +       u64 error_status_reporting[4];
> +       u64 addressing_mode[4];
> +       struct acpi_aest_node_interface_common common;
> +};
> +
> +struct acpi_aest_node_interface_64k {
> +       u64 error_record_implemented[14];
> +       u64 error_status_reporting[14];
> +       u64 addressing_mode[14];
> +       struct acpi_aest_node_interface_common common;
> +};
> +
>  /* Values for Type field above */
>
> -#define ACPI_AEST_NODE_SYSTEM_REGISTER      0
> -#define ACPI_AEST_NODE_MEMORY_MAPPED        1
> -#define ACPI_AEST_XFACE_RESERVED            2  /* 2 and above are reserv=
ed */
> +#define ACPI_AEST_NODE_SYSTEM_REGISTER                 0
> +#define ACPI_AEST_NODE_MEMORY_MAPPED                   1
> +#define ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED     2
> +#define ACPI_AEST_XFACE_RESERVED                       3   /* 2 and abov=
e are reserved */
>
>  /* Node Interrupt Structure */
>
> @@ -237,6 +303,16 @@ typedef struct acpi_aest_node_interrupt {
>
>  } acpi_aest_node_interrupt;
>
> +/* Node Interrupt Structure V2 */
> +
> +struct acpi_aest_node_interrupt_v2 {
> +       u8 type;
> +       u8 reserved[2];
> +       u8 flags;
> +       u32 gsiv;
> +       u8 reserved1[4];
> +};
> +
>  /* Values for Type field above */
>
>  #define ACPI_AEST_NODE_FAULT_HANDLING       0
> --

Applied as 6.10 material, thanks!

