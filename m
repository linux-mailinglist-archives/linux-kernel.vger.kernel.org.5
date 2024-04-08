Return-Path: <linux-kernel+bounces-135557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457E789C787
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AC3285931
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E8B13F428;
	Mon,  8 Apr 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkNuRhb4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D16213F003;
	Mon,  8 Apr 2024 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588009; cv=none; b=Ts0Ls5n9xtwDLxvPsw0zy638cL2CsTjf+Xvzr8YI5O/M9Mt8cphuEhteqym/E2smT3hgSHyB28qk/lfue7NbDVIlxMbdEAYnxRrag70CxZjIYKU3rdNFCrBwVrMCRxsLTrNiPaZk1XIlL5J82ddbFGYzrvpGNMt0Bb909x0Pzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588009; c=relaxed/simple;
	bh=EJKmClGOLTwGgOoI4kPrV72MkeX58tQy3x9xMp7XPwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgDiAJChYW0ZujZaoREnLghjgY3yc14X9Wgx6rHFMlGOLAj9OtdPBpyKAos+ICgW3KSm41XvRKjMDqLlgfMB7qp9x28LETpjGyxIp0G/FXpR24dnP7ClUI6W9bBRRPz8jJ671vHrFSH4p/H3O2I5onP5ol/F/I40fBIxZcfo0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkNuRhb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D3BC433C7;
	Mon,  8 Apr 2024 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712588009;
	bh=EJKmClGOLTwGgOoI4kPrV72MkeX58tQy3x9xMp7XPwk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MkNuRhb4+q5zEcb4A7E8KO6CGRYOMc1QxHmZkGOmKvCUSmQTv6+7HHRsDVM2U2NUz
	 6tUP22UvSLGjJyGEM645HJuWGcQurszayiuiXDf01ebSWsJrRvgZvvN4eUYa7MicwA
	 UOs2ftLtJmzKglWnrf/Xi//Ramdslmj5BDZGvvBgqKd80yOQ0ZYyAwnG6Gt5YqtYE3
	 aGZKs0AFlYBa/SpMaPJgiJhPeOklgSyMfHPQhIXV2n004ShYpbL9d7k8pq5pAvu/MR
	 F6WdKb//dpBvFspnjD+BYVWvz326NGvioArCNCU0nqj3x9qmyaTAMGBah/OT3Ehddl
	 4BNbph5AutOkg==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ea0b7a563aso383365a34.1;
        Mon, 08 Apr 2024 07:53:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGGa9SnK7yX9VeGGpMpnmZo4ZEzxuqBK8neoQZN1X5sDSDTtTeoTw3i8ykwDQcUPeqhbknvfefp+hIQ8+76LJnAFfMMvNlPBuxlmw3v7ZJTCn/HN+BQvLRfYcLxVhcEYDZ4Rv5LeE6eg==
X-Gm-Message-State: AOJu0Yzx4vieqzRr/eiDbPGqgHU/XrYH6xez509qZkl2RVJiq1khE2Tu
	qEWcH0UVHLR/kh/11kKqPUFAf4O8L2WDNrv3TxTLKKUemS3XXNPSx+LrbCM83J56eOFQvseDUW3
	5y/JZVDo7X6KUCK069/WZ1N05EW4=
X-Google-Smtp-Source: AGHT+IHuy0/nFe/FoemhdxiE/Em9tOWu3urCFSmO0lgMwYUZ6nSQ2VTdzo8E2XACROhl1KCN3d/aCFuxQVdMPhBJ/Nk=
X-Received: by 2002:a05:6870:968b:b0:22e:6e96:ed41 with SMTP id
 o11-20020a056870968b00b0022e6e96ed41mr9073414oaq.2.1712588008208; Mon, 08 Apr
 2024 07:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407032456.4079002-1-lijun01@kylinos.cn>
In-Reply-To: <20240407032456.4079002-1-lijun01@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 16:53:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0goUZCwTaTqSvD=RfzyMf6QBS_rCGsvtoNN-VboptCNjA@mail.gmail.com>
Message-ID: <CAJZ5v0goUZCwTaTqSvD=RfzyMf6QBS_rCGsvtoNN-VboptCNjA@mail.gmail.com>
Subject: Re: [PATCH] acpi: Modify ACPI_OBJECT_COMMON_HEADER
To: lijun <lijun01@kylinos.cn>
Cc: robert.moore@intel.com, linux-acpi@vger.kernel.org, evel@acpica.org, 
	linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 5:25=E2=80=AFAM lijun <lijun01@kylinos.cn> wrote:
>
> modify 4 macros:
> ACPI_OBJECT_COMMON_HEADER,
> ACPI_COMMON_BUFFER_INFO,
> ACPI_COMMON_NOTIFY_INFO,
> ACPI_COMMON_FIELD_INFO
> they  cause  poor readability.so del the last ";"
> and when use them in a single line with the ";"in the end.
>
> Link: https://github.com/acpica/acpica/pull/924

This hasn't been merged upstream AFAICS, has it?

> Signed-off-by: lijun <lijun01@kylinos.cn>
> ---
>  drivers/acpi/acpica/acobject.h | 95 +++++++++++++++++++++++-----------
>  1 file changed, 64 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobjec=
t.h
> index 1bdfeee5d7c5..0cd1769022aa 100644
> --- a/drivers/acpi/acpica/acobject.h
> +++ b/drivers/acpi/acpica/acobject.h
> @@ -48,7 +48,7 @@
>         u8                              descriptor_type;    /* To differe=
ntiate various internal objs */\
>         u8                              type;               /* acpi_objec=
t_type */\
>         u16                             reference_count;    /* For object=
 deletion management */\
> -       u8                              flags;
> +       u8                              flags
>         /*
>          * Note: There are 3 bytes available here before the
>          * next natural alignment boundary (for both 32/64 cases)
> @@ -71,10 +71,12 @@
>   ***********************************************************************=
******/
>
>  struct acpi_object_common {
> -ACPI_OBJECT_COMMON_HEADER};
> +       ACPI_OBJECT_COMMON_HEADER;
> +};
>
>  struct acpi_object_integer {
> -       ACPI_OBJECT_COMMON_HEADER u8 fill[3];   /* Prevent warning on som=
e compilers */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       u8 fill[3];     /* Prevent warning on some compilers */
>         u64 value;
>  };
>
> @@ -86,23 +88,26 @@ struct acpi_object_integer {
>   */
>  #define ACPI_COMMON_BUFFER_INFO(_type) \
>         _type                           *pointer; \
> -       u32                             length;
> +       u32                             length
>
>  /* Null terminated, ASCII characters only */
>
>  struct acpi_object_string {
> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(char) /* String=
 in AML stream or allocated string */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       ACPI_COMMON_BUFFER_INFO(char);  /* String in AML stream or alloca=
ted string */
>  };
>
>  struct acpi_object_buffer {
> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(u8)   /* Buffer=
 in AML stream or allocated buffer */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       ACPI_COMMON_BUFFER_INFO(u8);/* Buffer in AML stream or allocated =
buffer */
>         u32 aml_length;
>         u8 *aml_start;
>         struct acpi_namespace_node *node;       /* Link back to parent no=
de */
>  };
>
>  struct acpi_object_package {
> -       ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *node;     /=
* Link back to parent node */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       struct acpi_namespace_node *node;       /* Link back to parent no=
de */
>         union acpi_operand_object **elements;   /* Array of pointers to a=
cpi_objects */
>         u8 *aml_start;
>         u32 aml_length;
> @@ -116,11 +121,13 @@ struct acpi_object_package {
>   ***********************************************************************=
******/
>
>  struct acpi_object_event {
> -       ACPI_OBJECT_COMMON_HEADER acpi_semaphore os_semaphore;  /* Actual=
 OS synchronization object */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       acpi_semaphore os_semaphore;    /* Actual OS synchronization obje=
ct */
>  };
>
>  struct acpi_object_mutex {
> -       ACPI_OBJECT_COMMON_HEADER u8 sync_level;        /* 0-15, specifie=
d in Mutex() call */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       u8 sync_level;  /* 0-15, specified in Mutex() call */
>         u16 acquisition_depth;  /* Allow multiple Acquires, same thread *=
/
>         acpi_mutex os_mutex;    /* Actual OS synchronization object */
>         acpi_thread_id thread_id;       /* Current owner of the mutex */
> @@ -132,7 +139,8 @@ struct acpi_object_mutex {
>  };
>
>  struct acpi_object_region {
> -       ACPI_OBJECT_COMMON_HEADER u8 space_id;
> +       ACPI_OBJECT_COMMON_HEADER;
> +       u8 space_id;
>         struct acpi_namespace_node *node;       /* Containing namespace n=
ode */
>         union acpi_operand_object *handler;     /* Handler for region acc=
ess */
>         union acpi_operand_object *next;
> @@ -142,7 +150,8 @@ struct acpi_object_region {
>  };
>
>  struct acpi_object_method {
> -       ACPI_OBJECT_COMMON_HEADER u8 info_flags;
> +       ACPI_OBJECT_COMMON_HEADER;
> +       u8 info_flags;
>         u8 param_count;
>         u8 sync_level;
>         union acpi_operand_object *mutex;
> @@ -178,33 +187,41 @@ struct acpi_object_method {
>   */
>  #define ACPI_COMMON_NOTIFY_INFO \
>         union acpi_operand_object       *notify_list[2];    /* Handlers f=
or system/device notifies */\
> -       union acpi_operand_object       *handler;       /* Handler for Ad=
dress space */
> +       union acpi_operand_object       *handler        /* Handler for Ad=
dress space */
>
>  /* COMMON NOTIFY for POWER, PROCESSOR, DEVICE, and THERMAL */
>
>  struct acpi_object_notify_common {
> -ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
> +       ACPI_OBJECT_COMMON_HEADER;
> +       ACPI_COMMON_NOTIFY_INFO;
> +};
>
>  struct acpi_object_device {
> -       ACPI_OBJECT_COMMON_HEADER
> -           ACPI_COMMON_NOTIFY_INFO struct acpi_gpe_block_info *gpe_block=
;
> +       ACPI_OBJECT_COMMON_HEADER;
> +       ACPI_COMMON_NOTIFY_INFO;
> +       struct acpi_gpe_block_info *gpe_block;
>  };
>
>  struct acpi_object_power_resource {
> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO u32 system_leve=
l;
> +       ACPI_OBJECT_COMMON_HEADER;
> +       ACPI_COMMON_NOTIFY_INFO;
> +       u32 system_level;
>         u32 resource_order;
>  };
>
>  struct acpi_object_processor {
> -       ACPI_OBJECT_COMMON_HEADER
> +       ACPI_OBJECT_COMMON_HEADER;
>             /* The next two fields take advantage of the 3-byte space bef=
ore NOTIFY_INFO */
>         u8 proc_id;
>         u8 length;
> -       ACPI_COMMON_NOTIFY_INFO acpi_io_address address;
> +       ACPI_COMMON_NOTIFY_INFO;
> +       acpi_io_address address;
>  };
>
>  struct acpi_object_thermal_zone {
> -ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
> +       ACPI_OBJECT_COMMON_HEADER;
> +       ACPI_COMMON_NOTIFY_INFO;
> +};
>
>  /***********************************************************************=
*******
>   *
> @@ -226,17 +243,22 @@ ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
>         u32                             base_byte_offset;   /* Byte offse=
t within containing object */\
>         u32                             value;              /* Value to s=
tore into the Bank or Index register */\
>         u8                              start_field_bit_offset;/* Bit off=
set within first field datum (0-63) */\
> -       u8                              access_length;  /* For serial reg=
ions/fields */
> +       u8                              access_length   /* For serial reg=
ions/fields */
>
>
>  /* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */
>
>  struct acpi_object_field_common {
> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_opera=
nd_object *region_obj; /* Parent Operation Region object (REGION/BANK field=
s only) */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       ACPI_COMMON_FIELD_INFO;
> +       union acpi_operand_object *region_obj;
> +       /* Parent Operation Region object (REGION/BANK fields only) */
>  };
>
>  struct acpi_object_region_field {
> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u16 resource_len=
gth;
> +       ACPI_OBJECT_COMMON_HEADER;
> +       ACPI_COMMON_FIELD_INFO;
> +       u16 resource_length;
>         union acpi_operand_object *region_obj;  /* Containing op_region o=
bject */
>         u8 *resource_buffer;    /* resource_template for serial regions/f=
ields */
>         u16 pin_number_index;   /* Index relative to previous Connection/=
Template */
> @@ -244,12 +266,15 @@ struct acpi_object_region_field {
>  };
>
>  struct acpi_object_bank_field {
> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_opera=
nd_object *region_obj; /* Containing op_region object */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       ACPI_COMMON_FIELD_INFO;
> +       union acpi_operand_object *region_obj;  /* Containing op_region o=
bject */
>         union acpi_operand_object *bank_obj;    /* bank_select Register o=
bject */
>  };
>
>  struct acpi_object_index_field {
> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO
> +       ACPI_OBJECT_COMMON_HEADER;
> +       ACPI_COMMON_FIELD_INFO;
>             /*
>              * No "RegionObj" pointer needed since the Index and Data reg=
isters
>              * are each field definitions unto themselves.
> @@ -261,7 +286,9 @@ struct acpi_object_index_field {
>  /* The buffer_field is different in that it is part of a Buffer, not an =
op_region */
>
>  struct acpi_object_buffer_field {
> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u8 is_create_fie=
ld;    /* Special case for objects created by create_field() */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       ACPI_COMMON_FIELD_INFO;
> +       u8 is_create_field;     /* Special case for objects created by cr=
eate_field() */
>         union acpi_operand_object *buffer_obj;  /* Containing Buffer obje=
ct */
>  };
>
> @@ -272,7 +299,8 @@ struct acpi_object_buffer_field {
>   ***********************************************************************=
******/
>
>  struct acpi_object_notify_handler {
> -       ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *node;     /=
* Parent device */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       struct acpi_namespace_node *node;       /* Parent device */
>         u32 handler_type;       /* Type: Device/System/Both */
>         acpi_notify_handler handler;    /* Handler address */
>         void *context;
> @@ -280,7 +308,8 @@ struct acpi_object_notify_handler {
>  };
>
>  struct acpi_object_addr_handler {
> -       ACPI_OBJECT_COMMON_HEADER u8 space_id;
> +       ACPI_OBJECT_COMMON_HEADER;
> +       u8 space_id;
>         u8 handler_flags;
>         acpi_adr_space_handler handler;
>         struct acpi_namespace_node *node;       /* Parent device */
> @@ -307,7 +336,8 @@ struct acpi_object_addr_handler {
>   * The Reference.Class differentiates these types.
>   */
>  struct acpi_object_reference {
> -       ACPI_OBJECT_COMMON_HEADER u8 class;     /* Reference Class */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       u8 class;       /* Reference Class */
>         u8 target_type;         /* Used for Index Op */
>         u8 resolved;            /* Reference has been resolved to a value=
 */
>         void *object;           /* name_op=3D>HANDLE to obj, index_op=3D>=
union acpi_operand_object */
> @@ -340,7 +370,8 @@ typedef enum {
>   * Currently: Region and field_unit types
>   */
>  struct acpi_object_extra {
> -       ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *method_REG;=
       /* _REG method for this region (if any) */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       struct acpi_namespace_node *method_REG; /* _REG method for this r=
egion (if any) */
>         struct acpi_namespace_node *scope_node;
>         void *region_context;   /* Region-specific data */
>         u8 *aml_start;
> @@ -350,14 +381,16 @@ struct acpi_object_extra {
>  /* Additional data that can be attached to namespace nodes */
>
>  struct acpi_object_data {
> -       ACPI_OBJECT_COMMON_HEADER acpi_object_handler handler;
> +       ACPI_OBJECT_COMMON_HEADER;
> +       acpi_object_handler handler;
>         void *pointer;
>  };
>
>  /* Structure used when objects are cached for reuse */
>
>  struct acpi_object_cache_list {
> -       ACPI_OBJECT_COMMON_HEADER union acpi_operand_object *next;      /=
* Link for object cache and internal lists */
> +       ACPI_OBJECT_COMMON_HEADER;
> +       union acpi_operand_object *next;        /* Link for object cache =
and internal lists */
>  };
>
>  /***********************************************************************=
*******
> --
> 2.34.1
>
>

