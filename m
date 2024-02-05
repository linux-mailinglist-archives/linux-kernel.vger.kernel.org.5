Return-Path: <linux-kernel+bounces-52727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379B4849BF1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29AE284FD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D6328E26;
	Mon,  5 Feb 2024 13:35:42 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5EE2263E;
	Mon,  5 Feb 2024 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140141; cv=none; b=lUj+RAfE/B0QC9j6OxZrFgOPMc7rVVOBDcCIQF1hAJOoZKmtlENNp2auzT3wNM4QDs3wrt2X/KNrj3HZVjydEA56J3snPa67bhsCK/rnMmZVtXO7scZjfKwLWloxq+/HazKPbfLu9j0msHtE2TNVLXjjUEM7m0VvtaAg+BlcjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140141; c=relaxed/simple;
	bh=Ese21tF3bjGyOHITBFLrq6+VOIEA4ohuiivv4qv/22Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P31ax0WD3RJeRYHTS3A/R3htfUGoaPA3LbtL/9PsD29LtuVLHVABP1vm0UQPC5o+nP2J1bNIH+rOO8fRJ3I16RmL7LUsVsQte1DyPe3VaUWmkRe80wwfC5ReABzR56RJ+DYCLRK2bPXiaX/gzIsl7m2dd34aQURbDWhnBChL82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3be110bbff9so1300700b6e.1;
        Mon, 05 Feb 2024 05:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140138; x=1707744938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqJwor4hMEJvsIfdTuBFtW9pwxx2V8Qjehn9U8/dKQk=;
        b=E6KTZOd2Ugwl1Iq4Q/YRMK2QJzKm5X8gJc1ZD2klzf+SllmfW1zQ9zMGFDqm01/Cdg
         mUhyGZMyRYy8sdZRYrNo0l9zC6N4bG9TKrtU67SzGT4ez+M4TaJmreIUhupNrPgEsmYT
         wACVCNpmRNwOOJOSHjCtNORDruwET2Z7LQnT3EF5T99OZgFjMDbP2Zp8Xcm0TDkf7IEp
         M/HSVIlZ7aBZUQWdWwxCKYQF/6Nu35EBp1OEvBbErE+yrGjlEal0/okjWMlLhRoPJI6f
         WhAeJAkkh1xfrQLYYOUpEkdzq8FEjrbNj3e9gkQpoGaye/8C8aS7bw1APShclo4/uFaG
         aqUA==
X-Forwarded-Encrypted: i=0; AJvYcCWGNtho0gJIdGwF808tT5ldeXp0pnvQxGCMWPfXfrPRssXDkvLYVF25iTZmKCr1KfQ4UIlq38y6tC28RoJkVJTVoxuQHlGN2c1wJir6gLN5H0O3crcSUh6ObaRwdg13lvsvgkpmru4N8w==
X-Gm-Message-State: AOJu0YyyBXiMOpJYoycUv9Wt6grOaaq9O1YGSs8Uvx+edJuEO6Dq+OYQ
	BFhHeDwKD9vEx5bQS85d202nuHpWFeRvWC3Ok3T/Wd/nHk+koY3c6S/Gj0B71NI9WfkXu+qFr3P
	uPJhkPGIl0qm03HkgwMOkQG6G08U=
X-Google-Smtp-Source: AGHT+IEYpQ1CNQ8fzhs6xXqaRvj01t/5HiL4Ff/9zU5oWncMCgvKLgm8sfUj8yQPTxieYOX8oturQfuf87PtpzZBIaA=
X-Received: by 2002:a05:6870:7f15:b0:219:95ec:1a17 with SMTP id
 xa21-20020a0568707f1500b0021995ec1a17mr1493096oab.0.1707140138177; Mon, 05
 Feb 2024 05:35:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215073735.3891402-1-lijun01@kylinos.cn> <CAJZ5v0iqDJGfM+i0T80L33Nd5y0h6KyK0JBbr8a2rMJLqba36A@mail.gmail.com>
 <c05a69a3-072b-384e-7857-1385da2fc4ec@kylinos.cn>
In-Reply-To: <c05a69a3-072b-384e-7857-1385da2fc4ec@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Feb 2024 14:35:26 +0100
Message-ID: <CAJZ5v0jH7q1CC_BfxYG6pQTpQu8p0PR-4Ln-QgkjpwK-q8Gsmw@mail.gmail.com>
Subject: Re: [PATCH] acpi: Modify ACPI_OBJECT_COMMON_HEADER
To: lijun <lijun01@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, robert.moore@intel.com, rafael.j.wysocki@intel.com, 
	linux-acpi@vger.kernel.org, evel@acpica.org, linux-kernel@vger.kernel.org, 
	lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 3:48=E2=80=AFAM lijun <lijun01@kylinos.cn> wrote:
>
> hi all:
>
>          then the acobject.h in acpica different from the kernel,
> "ACPI_OBJECT_COMMON_HEADER" and "u8" not in the same line .
> in the acpica  this file
> typedef struct acpi_object_common
> {
>      ACPI_OBJECT_COMMON_HEADER
> } ACPI_OBJECT_COMMON;
> typedef struct acpi_object_integer
> {
>      ACPI_OBJECT_COMMON_HEADER
>      UINT8 Fill[3]; /* Prevent warning on some compilers */
>      UINT64 Value;
> } ACPI_OBJECT_INTEGER;
>
> and in kenel this file
> /drivers/acpi/acpica/acobject.h,"ACPI_OBJECT_COMMON_HEADER" and "u8"  in
> the same line ,cause  confusion.
> struct acpi_object_common {
>         ACPI_OBJECT_COMMON_HEADER};
> struct acpi_object_integer {
>         ACPI_OBJECT_COMMON_HEADER u8 fill[3]; /* Prevent warning on some
> compilers */
>         u64 value;
> };
>
> others just so.
>
>
> On 2023/12/21 22:15, Rafael J. Wysocki wrote:
> > On Fri, Dec 15, 2023 at 8:38=E2=80=AFAM lijun <lijun01@kylinos.cn> wrot=
e:
> >> modify 4 macros:
> >> ACPI_OBJECT_COMMON_HEADER,
> >> ACPI_COMMON_BUFFER_INFO,
> >> ACPI_COMMON_NOTIFY_INFO,
> >> ACPI_COMMON_FIELD_INFO
> >> they  cause  poor readability.so del the last ";"
> >> and when use them in a single line with the ";"in the end.
> >>
> >> Signed-off-by: lijun <lijun01@kylinos.cn>
> >> ---
> >>   drivers/acpi/acpica/acobject.h | 95 +++++++++++++++++++++++---------=
--
> > ACPICA code comes from an external project.  The proper way of
> > modifying it is to submit a pull request to the upstream ACPICA
> > project on GitHub.  Once this pull request has been merged upstream, a
> > Linux patch containing a Link: tag to the corresponding upstream pull
> > request can be submitted.
> >
> > Thanks!
> >
> >>   1 file changed, 64 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acob=
ject.h
> >> index 1bdfeee5d7c5..0cd1769022aa 100644
> >> --- a/drivers/acpi/acpica/acobject.h
> >> +++ b/drivers/acpi/acpica/acobject.h
> >> @@ -48,7 +48,7 @@
> >>          u8                              descriptor_type;    /* To dif=
ferentiate various internal objs */\
> >>          u8                              type;               /* acpi_o=
bject_type */\
> >>          u16                             reference_count;    /* For ob=
ject deletion management */\
> >> -       u8                              flags;
> >> +       u8                              flags
> >>          /*
> >>           * Note: There are 3 bytes available here before the
> >>           * next natural alignment boundary (for both 32/64 cases)
> >> @@ -71,10 +71,12 @@
> >>    *******************************************************************=
**********/
> >>
> >>   struct acpi_object_common {
> >> -ACPI_OBJECT_COMMON_HEADER};
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +};
> >>
> >>   struct acpi_object_integer {
> >> -       ACPI_OBJECT_COMMON_HEADER u8 fill[3];   /* Prevent warning on =
some compilers */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       u8 fill[3];     /* Prevent warning on some compilers */
> >>          u64 value;
> >>   };
> >>
> >> @@ -86,23 +88,26 @@ struct acpi_object_integer {
> >>    */
> >>   #define ACPI_COMMON_BUFFER_INFO(_type) \
> >>          _type                           *pointer; \
> >> -       u32                             length;
> >> +       u32                             length
> >>
> >>   /* Null terminated, ASCII characters only */
> >>
> >>   struct acpi_object_string {
> >> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(char) /* Str=
ing in AML stream or allocated string */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       ACPI_COMMON_BUFFER_INFO(char);  /* String in AML stream or all=
ocated string */
> >>   };
> >>
> >>   struct acpi_object_buffer {
> >> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(u8)   /* Buf=
fer in AML stream or allocated buffer */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       ACPI_COMMON_BUFFER_INFO(u8);/* Buffer in AML stream or allocat=
ed buffer */
> >>          u32 aml_length;
> >>          u8 *aml_start;
> >>          struct acpi_namespace_node *node;       /* Link back to paren=
t node */
> >>   };
> >>
> >>   struct acpi_object_package {
> >> -       ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *node;   =
  /* Link back to parent node */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       struct acpi_namespace_node *node;       /* Link back to parent=
 node */
> >>          union acpi_operand_object **elements;   /* Array of pointers =
to acpi_objects */
> >>          u8 *aml_start;
> >>          u32 aml_length;
> >> @@ -116,11 +121,13 @@ struct acpi_object_package {
> >>    *******************************************************************=
**********/
> >>
> >>   struct acpi_object_event {
> >> -       ACPI_OBJECT_COMMON_HEADER acpi_semaphore os_semaphore;  /* Act=
ual OS synchronization object */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       acpi_semaphore os_semaphore;    /* Actual OS synchronization o=
bject */
> >>   };
> >>
> >>   struct acpi_object_mutex {
> >> -       ACPI_OBJECT_COMMON_HEADER u8 sync_level;        /* 0-15, speci=
fied in Mutex() call */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       u8 sync_level;  /* 0-15, specified in Mutex() call */
> >>          u16 acquisition_depth;  /* Allow multiple Acquires, same thre=
ad */
> >>          acpi_mutex os_mutex;    /* Actual OS synchronization object *=
/
> >>          acpi_thread_id thread_id;       /* Current owner of the mutex=
 */
> >> @@ -132,7 +139,8 @@ struct acpi_object_mutex {
> >>   };
> >>
> >>   struct acpi_object_region {
> >> -       ACPI_OBJECT_COMMON_HEADER u8 space_id;
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       u8 space_id;
> >>          struct acpi_namespace_node *node;       /* Containing namespa=
ce node */
> >>          union acpi_operand_object *handler;     /* Handler for region=
 access */
> >>          union acpi_operand_object *next;
> >> @@ -142,7 +150,8 @@ struct acpi_object_region {
> >>   };
> >>
> >>   struct acpi_object_method {
> >> -       ACPI_OBJECT_COMMON_HEADER u8 info_flags;
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       u8 info_flags;
> >>          u8 param_count;
> >>          u8 sync_level;
> >>          union acpi_operand_object *mutex;
> >> @@ -178,33 +187,41 @@ struct acpi_object_method {
> >>    */
> >>   #define ACPI_COMMON_NOTIFY_INFO \
> >>          union acpi_operand_object       *notify_list[2];    /* Handle=
rs for system/device notifies */\
> >> -       union acpi_operand_object       *handler;       /* Handler for=
 Address space */
> >> +       union acpi_operand_object       *handler        /* Handler for=
 Address space */
> >>
> >>   /* COMMON NOTIFY for POWER, PROCESSOR, DEVICE, and THERMAL */
> >>
> >>   struct acpi_object_notify_common {
> >> -ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       ACPI_COMMON_NOTIFY_INFO;
> >> +};
> >>
> >>   struct acpi_object_device {
> >> -       ACPI_OBJECT_COMMON_HEADER
> >> -           ACPI_COMMON_NOTIFY_INFO struct acpi_gpe_block_info *gpe_bl=
ock;
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       ACPI_COMMON_NOTIFY_INFO;
> >> +       struct acpi_gpe_block_info *gpe_block;
> >>   };
> >>
> >>   struct acpi_object_power_resource {
> >> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO u32 system_l=
evel;
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       ACPI_COMMON_NOTIFY_INFO;
> >> +       u32 system_level;
> >>          u32 resource_order;
> >>   };
> >>
> >>   struct acpi_object_processor {
> >> -       ACPI_OBJECT_COMMON_HEADER
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >>              /* The next two fields take advantage of the 3-byte space=
 before NOTIFY_INFO */
> >>          u8 proc_id;
> >>          u8 length;
> >> -       ACPI_COMMON_NOTIFY_INFO acpi_io_address address;
> >> +       ACPI_COMMON_NOTIFY_INFO;
> >> +       acpi_io_address address;
> >>   };
> >>
> >>   struct acpi_object_thermal_zone {
> >> -ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       ACPI_COMMON_NOTIFY_INFO;
> >> +};
> >>
> >>   /*******************************************************************=
***********
> >>    *
> >> @@ -226,17 +243,22 @@ ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INF=
O};
> >>          u32                             base_byte_offset;   /* Byte o=
ffset within containing object */\
> >>          u32                             value;              /* Value =
to store into the Bank or Index register */\
> >>          u8                              start_field_bit_offset;/* Bit=
 offset within first field datum (0-63) */\
> >> -       u8                              access_length;  /* For serial =
regions/fields */
> >> +       u8                              access_length   /* For serial =
regions/fields */
> >>
> >>
> >>   /* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */
> >>
> >>   struct acpi_object_field_common {
> >> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_op=
erand_object *region_obj; /* Parent Operation Region object (REGION/BANK fi=
elds only) */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       ACPI_COMMON_FIELD_INFO;
> >> +       union acpi_operand_object *region_obj;
> >> +       /* Parent Operation Region object (REGION/BANK fields only) */
> >>   };
> >>
> >>   struct acpi_object_region_field {
> >> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u16 resource_=
length;
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       ACPI_COMMON_FIELD_INFO;
> >> +       u16 resource_length;
> >>          union acpi_operand_object *region_obj;  /* Containing op_regi=
on object */
> >>          u8 *resource_buffer;    /* resource_template for serial regio=
ns/fields */
> >>          u16 pin_number_index;   /* Index relative to previous Connect=
ion/Template */
> >> @@ -244,12 +266,15 @@ struct acpi_object_region_field {
> >>   };
> >>
> >>   struct acpi_object_bank_field {
> >> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_op=
erand_object *region_obj; /* Containing op_region object */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       ACPI_COMMON_FIELD_INFO;
> >> +       union acpi_operand_object *region_obj;  /* Containing op_regio=
n object */
> >>          union acpi_operand_object *bank_obj;    /* bank_select Regist=
er object */
> >>   };
> >>
> >>   struct acpi_object_index_field {
> >> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       ACPI_COMMON_FIELD_INFO;
> >>              /*
> >>               * No "RegionObj" pointer needed since the Index and Data=
 registers
> >>               * are each field definitions unto themselves.
> >> @@ -261,7 +286,9 @@ struct acpi_object_index_field {
> >>   /* The buffer_field is different in that it is part of a Buffer, not=
 an op_region */
> >>
> >>   struct acpi_object_buffer_field {
> >> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u8 is_create_=
field;    /* Special case for objects created by create_field() */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       ACPI_COMMON_FIELD_INFO;
> >> +       u8 is_create_field;     /* Special case for objects created by=
 create_field() */
> >>          union acpi_operand_object *buffer_obj;  /* Containing Buffer =
object */
> >>   };
> >>
> >> @@ -272,7 +299,8 @@ struct acpi_object_buffer_field {
> >>    *******************************************************************=
**********/
> >>
> >>   struct acpi_object_notify_handler {
> >> -       ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *node;   =
  /* Parent device */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       struct acpi_namespace_node *node;       /* Parent device */
> >>          u32 handler_type;       /* Type: Device/System/Both */
> >>          acpi_notify_handler handler;    /* Handler address */
> >>          void *context;
> >> @@ -280,7 +308,8 @@ struct acpi_object_notify_handler {
> >>   };
> >>
> >>   struct acpi_object_addr_handler {
> >> -       ACPI_OBJECT_COMMON_HEADER u8 space_id;
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       u8 space_id;
> >>          u8 handler_flags;
> >>          acpi_adr_space_handler handler;
> >>          struct acpi_namespace_node *node;       /* Parent device */
> >> @@ -307,7 +336,8 @@ struct acpi_object_addr_handler {
> >>    * The Reference.Class differentiates these types.
> >>    */
> >>   struct acpi_object_reference {
> >> -       ACPI_OBJECT_COMMON_HEADER u8 class;     /* Reference Class */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       u8 class;       /* Reference Class */
> >>          u8 target_type;         /* Used for Index Op */
> >>          u8 resolved;            /* Reference has been resolved to a v=
alue */
> >>          void *object;           /* name_op=3D>HANDLE to obj, index_op=
=3D>union acpi_operand_object */
> >> @@ -340,7 +370,8 @@ typedef enum {
> >>    * Currently: Region and field_unit types
> >>    */
> >>   struct acpi_object_extra {
> >> -       ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *method_R=
EG;       /* _REG method for this region (if any) */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       struct acpi_namespace_node *method_REG; /* _REG method for thi=
s region (if any) */
> >>          struct acpi_namespace_node *scope_node;
> >>          void *region_context;   /* Region-specific data */
> >>          u8 *aml_start;
> >> @@ -350,14 +381,16 @@ struct acpi_object_extra {
> >>   /* Additional data that can be attached to namespace nodes */
> >>
> >>   struct acpi_object_data {
> >> -       ACPI_OBJECT_COMMON_HEADER acpi_object_handler handler;
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       acpi_object_handler handler;
> >>          void *pointer;
> >>   };
> >>
> >>   /* Structure used when objects are cached for reuse */
> >>
> >>   struct acpi_object_cache_list {
> >> -       ACPI_OBJECT_COMMON_HEADER union acpi_operand_object *next;    =
  /* Link for object cache and internal lists */
> >> +       ACPI_OBJECT_COMMON_HEADER;
> >> +       union acpi_operand_object *next;        /* Link for object cac=
he and internal lists */
> >>   };
> >>
> >>   /*******************************************************************=
***********
> >> --

Yes, it is a different code base with different coding style etc.

