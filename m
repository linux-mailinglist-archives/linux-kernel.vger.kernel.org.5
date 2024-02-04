Return-Path: <linux-kernel+bounces-51384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5626848AB5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1D81F2270D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624317CE;
	Sun,  4 Feb 2024 02:48:05 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3926EDC;
	Sun,  4 Feb 2024 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707014884; cv=none; b=n+ZJ4ZEXytTxlD6p/JqA9Afi+7ebN6inj6MLwqPlBiaLQHhA+AlfVPkyMyJQwVeZz7tz1y9qrFbmmUl+v6fKfgIKJUluYRyroYa2X7fO0JjIXu0MM9DF/qO9v41QFGU8NP3zxN5nJTKUVQvSNlhb6LH488i5Q5/var4zBoXzOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707014884; c=relaxed/simple;
	bh=1IWmLL9FUuPlahEu2XMYvbRhFCCBfylbmKYXfJVyd7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/02UogPqWEMnTtCGSc8lqoJLtH/0p5pRfzDeaKCcifDeOaLwcGpxIbJI6URi+9lvBKFvdrVy9j6OhgDvPpCmbZQ+1W9kjx5cuQXWzFMlW4g7/5NL9kD+loYHghThhVW08DM38DdiJBaQvDWp+i+VuQT0rIbE6Yk5OU8093537k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7957bcb8e1564beea4d213f1304cbca6-20240204
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:62a27eed-7137-4a6c-bdc3-dc27dea17c6a,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:62a27eed-7137-4a6c-bdc3-dc27dea17c6a,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:5cf69683-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240204104752GUPFAA3S,BulkQuantity:0,Recheck:0,SF:44|64|66|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: 7957bcb8e1564beea4d213f1304cbca6-20240204
Received: from node2.com.cn [(39.156.73.10)] by mailgw
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1741473514; Sun, 04 Feb 2024 10:47:51 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 6C297B807587;
	Sun,  4 Feb 2024 10:47:51 +0800 (CST)
X-ns-mid: postfix-65BEFAD7-357957128
Received: from [172.30.60.202] (unknown [172.30.60.202])
	by node2.com.cn (NSMail) with ESMTPA id 0D99DB807587;
	Sun,  4 Feb 2024 02:47:48 +0000 (UTC)
Message-ID: <c05a69a3-072b-384e-7857-1385da2fc4ec@kylinos.cn>
Date: Sun, 4 Feb 2024 10:47:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] acpi: Modify ACPI_OBJECT_COMMON_HEADER
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com,
 linux-acpi@vger.kernel.org, evel@acpica.org, linux-kernel@vger.kernel.org,
 lenb@kernel.org
References: <20231215073735.3891402-1-lijun01@kylinos.cn>
 <CAJZ5v0iqDJGfM+i0T80L33Nd5y0h6KyK0JBbr8a2rMJLqba36A@mail.gmail.com>
Content-Language: en-US
From: lijun <lijun01@kylinos.cn>
In-Reply-To: <CAJZ5v0iqDJGfM+i0T80L33Nd5y0h6KyK0JBbr8a2rMJLqba36A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

hi all:

 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 then the acobject.h in acpica diff=
erent from the kernel,=20
"ACPI_OBJECT_COMMON_HEADER" and "u8" not in the same line .
in the acpica=C2=A0 this file
typedef struct acpi_object_common
{
 =C2=A0=C2=A0=C2=A0 ACPI_OBJECT_COMMON_HEADER
} ACPI_OBJECT_COMMON;
typedef struct acpi_object_integer
{
 =C2=A0=C2=A0=C2=A0 ACPI_OBJECT_COMMON_HEADER
 =C2=A0=C2=A0=C2=A0 UINT8 Fill[3]; /* Prevent warning on some compilers *=
/
 =C2=A0=C2=A0=C2=A0 UINT64 Value;
} ACPI_OBJECT_INTEGER;

and in kenel this file=20
/drivers/acpi/acpica/acobject.h,"ACPI_OBJECT_COMMON_HEADER" and "u8"=C2=A0=
 in=20
the same line ,cause=C2=A0 confusion.
struct acpi_object_common {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ACPI_OBJECT_COMMON_HEADER};
struct acpi_object_integer {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ACPI_OBJECT_COMMON_HEADER u8 fill[3=
]; /* Prevent warning on some=20
compilers */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 value;
};

others just so.


On 2023/12/21 22:15, Rafael J. Wysocki wrote:
> On Fri, Dec 15, 2023 at 8:38=E2=80=AFAM lijun <lijun01@kylinos.cn> wrot=
e:
>> modify 4 macros:
>> ACPI_OBJECT_COMMON_HEADER,
>> ACPI_COMMON_BUFFER_INFO,
>> ACPI_COMMON_NOTIFY_INFO,
>> ACPI_COMMON_FIELD_INFO
>> they  cause  poor readability.so del the last ";"
>> and when use them in a single line with the ";"in the end.
>>
>> Signed-off-by: lijun <lijun01@kylinos.cn>
>> ---
>>   drivers/acpi/acpica/acobject.h | 95 +++++++++++++++++++++++---------=
--
> ACPICA code comes from an external project.  The proper way of
> modifying it is to submit a pull request to the upstream ACPICA
> project on GitHub.  Once this pull request has been merged upstream, a
> Linux patch containing a Link: tag to the corresponding upstream pull
> request can be submitted.
>
> Thanks!
>
>>   1 file changed, 64 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acob=
ject.h
>> index 1bdfeee5d7c5..0cd1769022aa 100644
>> --- a/drivers/acpi/acpica/acobject.h
>> +++ b/drivers/acpi/acpica/acobject.h
>> @@ -48,7 +48,7 @@
>>          u8                              descriptor_type;    /* To dif=
ferentiate various internal objs */\
>>          u8                              type;               /* acpi_o=
bject_type */\
>>          u16                             reference_count;    /* For ob=
ject deletion management */\
>> -       u8                              flags;
>> +       u8                              flags
>>          /*
>>           * Note: There are 3 bytes available here before the
>>           * next natural alignment boundary (for both 32/64 cases)
>> @@ -71,10 +71,12 @@
>>    *******************************************************************=
**********/
>>
>>   struct acpi_object_common {
>> -ACPI_OBJECT_COMMON_HEADER};
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +};
>>
>>   struct acpi_object_integer {
>> -       ACPI_OBJECT_COMMON_HEADER u8 fill[3];   /* Prevent warning on =
some compilers */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       u8 fill[3];     /* Prevent warning on some compilers */
>>          u64 value;
>>   };
>>
>> @@ -86,23 +88,26 @@ struct acpi_object_integer {
>>    */
>>   #define ACPI_COMMON_BUFFER_INFO(_type) \
>>          _type                           *pointer; \
>> -       u32                             length;
>> +       u32                             length
>>
>>   /* Null terminated, ASCII characters only */
>>
>>   struct acpi_object_string {
>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(char) /* Str=
ing in AML stream or allocated string */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       ACPI_COMMON_BUFFER_INFO(char);  /* String in AML stream or all=
ocated string */
>>   };
>>
>>   struct acpi_object_buffer {
>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(u8)   /* Buf=
fer in AML stream or allocated buffer */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       ACPI_COMMON_BUFFER_INFO(u8);/* Buffer in AML stream or allocat=
ed buffer */
>>          u32 aml_length;
>>          u8 *aml_start;
>>          struct acpi_namespace_node *node;       /* Link back to paren=
t node */
>>   };
>>
>>   struct acpi_object_package {
>> -       ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *node;   =
  /* Link back to parent node */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       struct acpi_namespace_node *node;       /* Link back to parent=
 node */
>>          union acpi_operand_object **elements;   /* Array of pointers =
to acpi_objects */
>>          u8 *aml_start;
>>          u32 aml_length;
>> @@ -116,11 +121,13 @@ struct acpi_object_package {
>>    *******************************************************************=
**********/
>>
>>   struct acpi_object_event {
>> -       ACPI_OBJECT_COMMON_HEADER acpi_semaphore os_semaphore;  /* Act=
ual OS synchronization object */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       acpi_semaphore os_semaphore;    /* Actual OS synchronization o=
bject */
>>   };
>>
>>   struct acpi_object_mutex {
>> -       ACPI_OBJECT_COMMON_HEADER u8 sync_level;        /* 0-15, speci=
fied in Mutex() call */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       u8 sync_level;  /* 0-15, specified in Mutex() call */
>>          u16 acquisition_depth;  /* Allow multiple Acquires, same thre=
ad */
>>          acpi_mutex os_mutex;    /* Actual OS synchronization object *=
/
>>          acpi_thread_id thread_id;       /* Current owner of the mutex=
 */
>> @@ -132,7 +139,8 @@ struct acpi_object_mutex {
>>   };
>>
>>   struct acpi_object_region {
>> -       ACPI_OBJECT_COMMON_HEADER u8 space_id;
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       u8 space_id;
>>          struct acpi_namespace_node *node;       /* Containing namespa=
ce node */
>>          union acpi_operand_object *handler;     /* Handler for region=
 access */
>>          union acpi_operand_object *next;
>> @@ -142,7 +150,8 @@ struct acpi_object_region {
>>   };
>>
>>   struct acpi_object_method {
>> -       ACPI_OBJECT_COMMON_HEADER u8 info_flags;
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       u8 info_flags;
>>          u8 param_count;
>>          u8 sync_level;
>>          union acpi_operand_object *mutex;
>> @@ -178,33 +187,41 @@ struct acpi_object_method {
>>    */
>>   #define ACPI_COMMON_NOTIFY_INFO \
>>          union acpi_operand_object       *notify_list[2];    /* Handle=
rs for system/device notifies */\
>> -       union acpi_operand_object       *handler;       /* Handler for=
 Address space */
>> +       union acpi_operand_object       *handler        /* Handler for=
 Address space */
>>
>>   /* COMMON NOTIFY for POWER, PROCESSOR, DEVICE, and THERMAL */
>>
>>   struct acpi_object_notify_common {
>> -ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       ACPI_COMMON_NOTIFY_INFO;
>> +};
>>
>>   struct acpi_object_device {
>> -       ACPI_OBJECT_COMMON_HEADER
>> -           ACPI_COMMON_NOTIFY_INFO struct acpi_gpe_block_info *gpe_bl=
ock;
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       ACPI_COMMON_NOTIFY_INFO;
>> +       struct acpi_gpe_block_info *gpe_block;
>>   };
>>
>>   struct acpi_object_power_resource {
>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO u32 system_l=
evel;
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       ACPI_COMMON_NOTIFY_INFO;
>> +       u32 system_level;
>>          u32 resource_order;
>>   };
>>
>>   struct acpi_object_processor {
>> -       ACPI_OBJECT_COMMON_HEADER
>> +       ACPI_OBJECT_COMMON_HEADER;
>>              /* The next two fields take advantage of the 3-byte space=
 before NOTIFY_INFO */
>>          u8 proc_id;
>>          u8 length;
>> -       ACPI_COMMON_NOTIFY_INFO acpi_io_address address;
>> +       ACPI_COMMON_NOTIFY_INFO;
>> +       acpi_io_address address;
>>   };
>>
>>   struct acpi_object_thermal_zone {
>> -ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       ACPI_COMMON_NOTIFY_INFO;
>> +};
>>
>>   /*******************************************************************=
***********
>>    *
>> @@ -226,17 +243,22 @@ ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INF=
O};
>>          u32                             base_byte_offset;   /* Byte o=
ffset within containing object */\
>>          u32                             value;              /* Value =
to store into the Bank or Index register */\
>>          u8                              start_field_bit_offset;/* Bit=
 offset within first field datum (0-63) */\
>> -       u8                              access_length;  /* For serial =
regions/fields */
>> +       u8                              access_length   /* For serial =
regions/fields */
>>
>>
>>   /* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */
>>
>>   struct acpi_object_field_common {
>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_op=
erand_object *region_obj; /* Parent Operation Region object (REGION/BANK =
fields only) */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       ACPI_COMMON_FIELD_INFO;
>> +       union acpi_operand_object *region_obj;
>> +       /* Parent Operation Region object (REGION/BANK fields only) */
>>   };
>>
>>   struct acpi_object_region_field {
>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u16 resource_=
length;
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       ACPI_COMMON_FIELD_INFO;
>> +       u16 resource_length;
>>          union acpi_operand_object *region_obj;  /* Containing op_regi=
on object */
>>          u8 *resource_buffer;    /* resource_template for serial regio=
ns/fields */
>>          u16 pin_number_index;   /* Index relative to previous Connect=
ion/Template */
>> @@ -244,12 +266,15 @@ struct acpi_object_region_field {
>>   };
>>
>>   struct acpi_object_bank_field {
>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_op=
erand_object *region_obj; /* Containing op_region object */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       ACPI_COMMON_FIELD_INFO;
>> +       union acpi_operand_object *region_obj;  /* Containing op_regio=
n object */
>>          union acpi_operand_object *bank_obj;    /* bank_select Regist=
er object */
>>   };
>>
>>   struct acpi_object_index_field {
>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       ACPI_COMMON_FIELD_INFO;
>>              /*
>>               * No "RegionObj" pointer needed since the Index and Data=
 registers
>>               * are each field definitions unto themselves.
>> @@ -261,7 +286,9 @@ struct acpi_object_index_field {
>>   /* The buffer_field is different in that it is part of a Buffer, not=
 an op_region */
>>
>>   struct acpi_object_buffer_field {
>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u8 is_create_=
field;    /* Special case for objects created by create_field() */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       ACPI_COMMON_FIELD_INFO;
>> +       u8 is_create_field;     /* Special case for objects created by=
 create_field() */
>>          union acpi_operand_object *buffer_obj;  /* Containing Buffer =
object */
>>   };
>>
>> @@ -272,7 +299,8 @@ struct acpi_object_buffer_field {
>>    *******************************************************************=
**********/
>>
>>   struct acpi_object_notify_handler {
>> -       ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *node;   =
  /* Parent device */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       struct acpi_namespace_node *node;       /* Parent device */
>>          u32 handler_type;       /* Type: Device/System/Both */
>>          acpi_notify_handler handler;    /* Handler address */
>>          void *context;
>> @@ -280,7 +308,8 @@ struct acpi_object_notify_handler {
>>   };
>>
>>   struct acpi_object_addr_handler {
>> -       ACPI_OBJECT_COMMON_HEADER u8 space_id;
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       u8 space_id;
>>          u8 handler_flags;
>>          acpi_adr_space_handler handler;
>>          struct acpi_namespace_node *node;       /* Parent device */
>> @@ -307,7 +336,8 @@ struct acpi_object_addr_handler {
>>    * The Reference.Class differentiates these types.
>>    */
>>   struct acpi_object_reference {
>> -       ACPI_OBJECT_COMMON_HEADER u8 class;     /* Reference Class */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       u8 class;       /* Reference Class */
>>          u8 target_type;         /* Used for Index Op */
>>          u8 resolved;            /* Reference has been resolved to a v=
alue */
>>          void *object;           /* name_op=3D>HANDLE to obj, index_op=
=3D>union acpi_operand_object */
>> @@ -340,7 +370,8 @@ typedef enum {
>>    * Currently: Region and field_unit types
>>    */
>>   struct acpi_object_extra {
>> -       ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *method_R=
EG;       /* _REG method for this region (if any) */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       struct acpi_namespace_node *method_REG; /* _REG method for thi=
s region (if any) */
>>          struct acpi_namespace_node *scope_node;
>>          void *region_context;   /* Region-specific data */
>>          u8 *aml_start;
>> @@ -350,14 +381,16 @@ struct acpi_object_extra {
>>   /* Additional data that can be attached to namespace nodes */
>>
>>   struct acpi_object_data {
>> -       ACPI_OBJECT_COMMON_HEADER acpi_object_handler handler;
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       acpi_object_handler handler;
>>          void *pointer;
>>   };
>>
>>   /* Structure used when objects are cached for reuse */
>>
>>   struct acpi_object_cache_list {
>> -       ACPI_OBJECT_COMMON_HEADER union acpi_operand_object *next;    =
  /* Link for object cache and internal lists */
>> +       ACPI_OBJECT_COMMON_HEADER;
>> +       union acpi_operand_object *next;        /* Link for object cac=
he and internal lists */
>>   };
>>
>>   /*******************************************************************=
***********
>> --
>> 2.34.1
>>
>>

