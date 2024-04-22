Return-Path: <linux-kernel+bounces-153752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6508AD2B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8461C20A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8879153839;
	Mon, 22 Apr 2024 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lflyN/ci"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D4D2EB11;
	Mon, 22 Apr 2024 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804656; cv=none; b=bymiJm/t5pVoSqE5WsZc2iXdcJdNjpm04FvY0uZJzSjsDrTkVpx+S4BTv5qmXlTkNyX1u2Bv8KhBs2StmyUGiLiFyXJxSk+inMMwt/CQpK06AkcPPM5Q+6BtBGT30QvSTq0Ym+2PhdpqrXm84aFAkGRUou3M2cMjeX+8fYwm+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804656; c=relaxed/simple;
	bh=koG30J16hJxMk0BUTwzMwigR3YDlojTJv13N+OCDpWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOFjGg9KJFCMlIH1x290I7i0jNl29fN2Iy57F46/EKz9ouh+Npz+s2wL/UM5wjWSHgnU2+7UYsH3yvccwZ9v6W5F45DaB6sB51RAxK4nq7g2cdglZJauk8RoYM5eLDCvkDHg8NQUm3+/GMnfSueYrBJf+kdiK7uwT0y/P2ikW0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lflyN/ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAF4C113CC;
	Mon, 22 Apr 2024 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713804655;
	bh=koG30J16hJxMk0BUTwzMwigR3YDlojTJv13N+OCDpWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lflyN/cilobaLJUQnemxbKSDSBeqOJV+Hhob2U7qDThrALjsOsmxqHTheNdsUXn0X
	 bocoGYwWPP290XWzEMGXfREnACgRW9z97LQKVte8iuga/899ssKqQPBeTPa45gSNQq
	 gjnk2tv+NfX9FeR1TtMEQTf/w6Zs/bhYP3m/RfQvd1c/FWkHTMZ0ns9G+lypbA5hTx
	 UNW3PQLLVcGK8SQcIHQHzcGTZdWNPPsdvY2zeaj3UwZefAWeTr86WLcYVek8GVE+3J
	 cZI2S1kuAEQmBrugwEhxb8EVtAAMyBTrxGFRhjoP8QGBG6G3JUGXfI+z/rEpxwOQEU
	 QAf1YHCRUrMvg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5acdbfac114so57075eaf.2;
        Mon, 22 Apr 2024 09:50:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWB7QX7/VzN1w4vgfHGVVSXWaJ3F4mVR1/Ngaov5XgyND3On457ntLgZ0O6F1fWYWNxVNANYrqea4T2XsPnjRrM7tPY8nO1oq5uR68L37nXaHxG3i5kBG60R1Hq9dHy4X6KNZhHENppGw==
X-Gm-Message-State: AOJu0YxyrfUu8Ktb5LywW/IuFoJcmRJ0RSrwblNjj1YXzcw0+Al+UDaJ
	VZQeMRjy2CfYX3eKfo6/pVLKCLf5RUebL15sPa6PT5RLIwXLZKJ8DZXRNwU6yAf8WhTP6lwqzdM
	Tw/dyTTrQ2CgkUO4OP84NyYx33Lg=
X-Google-Smtp-Source: AGHT+IFuxQvy+MALG85uCki9NkvAR5axgAmv2/Jha/og3GaldGkSnK8tYRSOk+ef9cofpd5FJWaYcueMx0+tqAz+qIk=
X-Received: by 2002:a05:6820:2884:b0:5aa:241a:7f4b with SMTP id
 dn4-20020a056820288400b005aa241a7f4bmr11300744oob.1.1713804655220; Mon, 22
 Apr 2024 09:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410063602.41540-1-tianruidong@linux.alibaba.com> <20240410063602.41540-3-tianruidong@linux.alibaba.com>
In-Reply-To: <20240410063602.41540-3-tianruidong@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 18:50:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7n1N31B5hRPMmHJAKBQcy1BeuP+vU-qQ94WFzONf3mQ@mail.gmail.com>
Message-ID: <CAJZ5v0h7n1N31B5hRPMmHJAKBQcy1BeuP+vU-qQ94WFzONf3mQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPICA: AEST: Add support for the AEST V2 table
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:36=E2=80=AFAM Ruidong Tian
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
> index f89b23b3d2aa..d1670ab93fc6 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -77,8 +77,8 @@
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
> @@ -108,7 +108,9 @@ struct acpi_aest_hdr {
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
> @@ -180,6 +182,12 @@ struct acpi_aest_vendor {
>         u8 vendor_specific_data[16];
>  };
>
> +struct acpi_aest_vendor_v2 {
> +       char acpi_hid[8];
> +       u32 acpi_uid;
> +       u8 vendor_specific_data[16];
> +};
> +
>  /* 4: Gic Error */
>
>  struct acpi_aest_gic {
> @@ -195,6 +203,18 @@ struct acpi_aest_gic {
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
>  struct acpi_aest_node_interface {
> @@ -209,11 +229,57 @@ struct acpi_aest_node_interface {
>         u64 addressing_mode;
>  };
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
> @@ -226,6 +292,16 @@ struct acpi_aest_node_interrupt {
>         u8 reserved1[3];
>  };
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

This does not apply for me, can you please rebase on top of linux-next
and resend?

