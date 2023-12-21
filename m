Return-Path: <linux-kernel+bounces-8559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B581B966
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105C41F241A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500DF6D6EC;
	Thu, 21 Dec 2023 14:16:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF96D6D2;
	Thu, 21 Dec 2023 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-593f182f263so90458eaf.0;
        Thu, 21 Dec 2023 06:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703168165; x=1703772965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJWe53PLKRcJPzFEq6WgWjbnt4D/cFYXfuYN0Wbt/3o=;
        b=gjGyaFit5NSDbAdfwxfKqktfvWg9S3DjAvt5oGtrWrVIbH+mHNCzXJ0MMDL1m85/jn
         0WoEHB3NP+wdsvNZs1N3CNK0YVVIdOud2jCgr/HUciqZNnb/C3CtKTXcfPB9+nKLiKsX
         ocgtOvW83DBxfRskK2zk6pz3Fu11hU+1vNUFEHc+NSOnGvz2ybBUaLJngXfB/RzrFJTB
         WQwR/kF79YB1Efm1zkb22Cfnn1AU7Tride3UW+ZFg4nqwSJRhK/ZxQb9qbHuOkNaeFCm
         kGkhSM+Zm5Bid8BREJPqkRl1Imc6ZJKy8BrpdKR51NNczbxmjMNK0oYn03p1sZNpsVra
         mv3A==
X-Gm-Message-State: AOJu0Yx4H5zbNSWqoJmQiDPqeJjzrsE1r6mCgyO7UB8oTqSwHtQ2wKEt
	4BL9zmH2dp2dZCzWepxy5QZDIxojvnmgqRP4K/eqqH7L
X-Google-Smtp-Source: AGHT+IG9I2/eM615mITnBArwwTlCtP2SBQNEw/tidRfGi+gJtE5Q7vs1j0Gfg8CS7Cr9Chio6KVewJL5F+rElk1mRZ8=
X-Received: by 2002:a4a:d195:0:b0:594:177d:8bd6 with SMTP id
 j21-20020a4ad195000000b00594177d8bd6mr3550133oor.1.1703168165212; Thu, 21 Dec
 2023 06:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215073735.3891402-1-lijun01@kylinos.cn>
In-Reply-To: <20231215073735.3891402-1-lijun01@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 15:15:54 +0100
Message-ID: <CAJZ5v0iqDJGfM+i0T80L33Nd5y0h6KyK0JBbr8a2rMJLqba36A@mail.gmail.com>
Subject: Re: [PATCH] acpi: Modify ACPI_OBJECT_COMMON_HEADER
To: lijun <lijun01@kylinos.cn>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, 
	linux-acpi@vger.kernel.org, evel@acpica.org, linux-kernel@vger.kernel.org, 
	lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 8:38=E2=80=AFAM lijun <lijun01@kylinos.cn> wrote:
>
> modify 4 macros:
> ACPI_OBJECT_COMMON_HEADER,
> ACPI_COMMON_BUFFER_INFO,
> ACPI_COMMON_NOTIFY_INFO,
> ACPI_COMMON_FIELD_INFO
> they  cause  poor readability.so del the last ";"
> and when use them in a single line with the ";"in the end.
>
> Signed-off-by: lijun <lijun01@kylinos.cn>
> ---
>  drivers/acpi/acpica/acobject.h | 95 +++++++++++++++++++++++-----------

ACPICA code comes from an external project.  The proper way of
modifying it is to submit a pull request to the upstream ACPICA
project on GitHub.  Once this pull request has been merged upstream, a
Linux patch containing a Link: tag to the corresponding upstream pull
request can be submitted.

Thanks!

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

