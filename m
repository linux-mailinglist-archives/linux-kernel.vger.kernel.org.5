Return-Path: <linux-kernel+bounces-54133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA9B84AB48
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529361F2583A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5523717C8;
	Tue,  6 Feb 2024 00:59:25 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909FB1362;
	Tue,  6 Feb 2024 00:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181164; cv=none; b=DIcO4JwHfjPB3HDu7FMproLDE8Xb1eAibnZxv8ri0Ur3txTjZpEajH/M/Bufh+TWDN+es7SW3SSQk30OF7d1yxjrccBYIddmZcJtWrVIAVOpOYOVX3hwAVn3CyQsY9AIz1o/EKfaymlufEg9BRYp3nVLwMqn5q0Urqk11S5CmW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181164; c=relaxed/simple;
	bh=Y7xf4Lxsmp33npa+agCjVHW9K8VuIafv7YVcTpILm+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHnxdcjt3IferWx8brKo6xr3DJjAb8nZioU1yby8WyG7GSjP5QVmnfMeC0V78P85nMWw++2G/g92V2xO0sxsQmkvGy9/hu4Fbs3E8pzIgq2ASZTsI3985eCrIeIHA86EjovbH/mgXMsfdDTY8KUceGIFiKsj7tYP6akaMGnylGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7233f4dfcc4b423b8e585c5c2282f36d-20240206
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1a0a56ee-8a61-41af-b71f-d7becce5402e,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:1a0a56ee-8a61-41af-b71f-d7becce5402e,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:59d92780-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240204104752GUPFAA3S,BulkQuantity:10,Recheck:0,SF:66|24|17|19|44|64|
	102,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
	TF_CID_SPAM_FSI,TF_CID_SPAM_OBB
X-UUID: 7233f4dfcc4b423b8e585c5c2282f36d-20240206
Received: from node2.com.cn [(39.156.73.10)] by mailgw
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1721719044; Tue, 06 Feb 2024 08:59:09 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 803E1B80758A;
	Tue,  6 Feb 2024 08:59:09 +0800 (CST)
X-ns-mid: postfix-65C1845D-43479942
Received: from [172.30.60.202] (unknown [172.30.60.202])
	by node2.com.cn (NSMail) with ESMTPA id EFD63B807587;
	Tue,  6 Feb 2024 00:59:07 +0000 (UTC)
Message-ID: <4f48e344-7fb6-c0da-a2d5-b9067e354335@kylinos.cn>
Date: Tue, 6 Feb 2024 08:59:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] acpi: Modify ACPI_OBJECT_COMMON_HEADER
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com,
 linux-acpi@vger.kernel.org, evel@acpica.org, linux-kernel@vger.kernel.org,
 lenb@kernel.org
References: <20231215073735.3891402-1-lijun01@kylinos.cn>
 <CAJZ5v0iqDJGfM+i0T80L33Nd5y0h6KyK0JBbr8a2rMJLqba36A@mail.gmail.com>
 <c05a69a3-072b-384e-7857-1385da2fc4ec@kylinos.cn>
 <CAJZ5v0jH7q1CC_BfxYG6pQTpQu8p0PR-4Ln-QgkjpwK-q8Gsmw@mail.gmail.com>
From: lijun <lijun01@kylinos.cn>
In-Reply-To: <CAJZ5v0jH7q1CC_BfxYG6pQTpQu8p0PR-4Ln-QgkjpwK-q8Gsmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

but the different coding style casues confusion,this patch can resolve it=
.

=E5=9C=A8 2024/2/5 21:35, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Sun, Feb 4, 2024 at 3:48=E2=80=AFAM lijun <lijun01@kylinos.cn> wrote=
:
>> hi all:
>>
>>           then the acobject.h in acpica different from the kernel,
>> "ACPI_OBJECT_COMMON_HEADER" and "u8" not in the same line .
>> in the acpica  this file
>> typedef struct acpi_object_common
>> {
>>       ACPI_OBJECT_COMMON_HEADER
>> } ACPI_OBJECT_COMMON;
>> typedef struct acpi_object_integer
>> {
>>       ACPI_OBJECT_COMMON_HEADER
>>       UINT8 Fill[3]; /* Prevent warning on some compilers */
>>       UINT64 Value;
>> } ACPI_OBJECT_INTEGER;
>>
>> and in kenel this file
>> /drivers/acpi/acpica/acobject.h,"ACPI_OBJECT_COMMON_HEADER" and "u8"  =
in
>> the same line ,cause  confusion.
>> struct acpi_object_common {
>>          ACPI_OBJECT_COMMON_HEADER};
>> struct acpi_object_integer {
>>          ACPI_OBJECT_COMMON_HEADER u8 fill[3]; /* Prevent warning on s=
ome
>> compilers */
>>          u64 value;
>> };
>>
>> others just so.
>>
>>
>> On 2023/12/21 22:15, Rafael J. Wysocki wrote:
>>> On Fri, Dec 15, 2023 at 8:38=E2=80=AFAM lijun <lijun01@kylinos.cn> wr=
ote:
>>>> modify 4 macros:
>>>> ACPI_OBJECT_COMMON_HEADER,
>>>> ACPI_COMMON_BUFFER_INFO,
>>>> ACPI_COMMON_NOTIFY_INFO,
>>>> ACPI_COMMON_FIELD_INFO
>>>> they  cause  poor readability.so del the last ";"
>>>> and when use them in a single line with the ";"in the end.
>>>>
>>>> Signed-off-by: lijun <lijun01@kylinos.cn>
>>>> ---
>>>>    drivers/acpi/acpica/acobject.h | 95 +++++++++++++++++++++++------=
-----
>>> ACPICA code comes from an external project.  The proper way of
>>> modifying it is to submit a pull request to the upstream ACPICA
>>> project on GitHub.  Once this pull request has been merged upstream, =
a
>>> Linux patch containing a Link: tag to the corresponding upstream pull
>>> request can be submitted.
>>>
>>> Thanks!
>>>
>>>>    1 file changed, 64 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/ac=
object.h
>>>> index 1bdfeee5d7c5..0cd1769022aa 100644
>>>> --- a/drivers/acpi/acpica/acobject.h
>>>> +++ b/drivers/acpi/acpica/acobject.h
>>>> @@ -48,7 +48,7 @@
>>>>           u8                              descriptor_type;    /* To =
differentiate various internal objs */\
>>>>           u8                              type;               /* acp=
i_object_type */\
>>>>           u16                             reference_count;    /* For=
 object deletion management */\
>>>> -       u8                              flags;
>>>> +       u8                              flags
>>>>           /*
>>>>            * Note: There are 3 bytes available here before the
>>>>            * next natural alignment boundary (for both 32/64 cases)
>>>> @@ -71,10 +71,12 @@
>>>>     ****************************************************************=
*************/
>>>>
>>>>    struct acpi_object_common {
>>>> -ACPI_OBJECT_COMMON_HEADER};
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +};
>>>>
>>>>    struct acpi_object_integer {
>>>> -       ACPI_OBJECT_COMMON_HEADER u8 fill[3];   /* Prevent warning o=
n some compilers */
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       u8 fill[3];     /* Prevent warning on some compilers */
>>>>           u64 value;
>>>>    };
>>>>
>>>> @@ -86,23 +88,26 @@ struct acpi_object_integer {
>>>>     */
>>>>    #define ACPI_COMMON_BUFFER_INFO(_type) \
>>>>           _type                           *pointer; \
>>>> -       u32                             length;
>>>> +       u32                             length
>>>>
>>>>    /* Null terminated, ASCII characters only */
>>>>
>>>>    struct acpi_object_string {
>>>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(char) /* S=
tring in AML stream or allocated string */
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       ACPI_COMMON_BUFFER_INFO(char);  /* String in AML stream or a=
llocated string */
>>>>    };
>>>>
>>>>    struct acpi_object_buffer {
>>>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(u8)   /* B=
uffer in AML stream or allocated buffer */
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       ACPI_COMMON_BUFFER_INFO(u8);/* Buffer in AML stream or alloc=
ated buffer */
>>>>           u32 aml_length;
>>>>           u8 *aml_start;
>>>>           struct acpi_namespace_node *node;       /* Link back to pa=
rent node */
>>>>    };
>>>>
>>>>    struct acpi_object_package {
>>>> -       ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *node; =
    /* Link back to parent node */
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       struct acpi_namespace_node *node;       /* Link back to pare=
nt node */
>>>>           union acpi_operand_object **elements;   /* Array of pointe=
rs to acpi_objects */
>>>>           u8 *aml_start;
>>>>           u32 aml_length;
>>>> @@ -116,11 +121,13 @@ struct acpi_object_package {
>>>>     ****************************************************************=
*************/
>>>>
>>>>    struct acpi_object_event {
>>>> -       ACPI_OBJECT_COMMON_HEADER acpi_semaphore os_semaphore;  /* A=
ctual OS synchronization object */
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       acpi_semaphore os_semaphore;    /* Actual OS synchronization=
 object */
>>>>    };
>>>>
>>>>    struct acpi_object_mutex {
>>>> -       ACPI_OBJECT_COMMON_HEADER u8 sync_level;        /* 0-15, spe=
cified in Mutex() call */
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       u8 sync_level;  /* 0-15, specified in Mutex() call */
>>>>           u16 acquisition_depth;  /* Allow multiple Acquires, same t=
hread */
>>>>           acpi_mutex os_mutex;    /* Actual OS synchronization objec=
t */
>>>>           acpi_thread_id thread_id;       /* Current owner of the mu=
tex */
>>>> @@ -132,7 +139,8 @@ struct acpi_object_mutex {
>>>>    };
>>>>
>>>>    struct acpi_object_region {
>>>> -       ACPI_OBJECT_COMMON_HEADER u8 space_id;
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       u8 space_id;
>>>>           struct acpi_namespace_node *node;       /* Containing name=
space node */
>>>>           union acpi_operand_object *handler;     /* Handler for reg=
ion access */
>>>>           union acpi_operand_object *next;
>>>> @@ -142,7 +150,8 @@ struct acpi_object_region {
>>>>    };
>>>>
>>>>    struct acpi_object_method {
>>>> -       ACPI_OBJECT_COMMON_HEADER u8 info_flags;
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       u8 info_flags;
>>>>           u8 param_count;
>>>>           u8 sync_level;
>>>>           union acpi_operand_object *mutex;
>>>> @@ -178,33 +187,41 @@ struct acpi_object_method {
>>>>     */
>>>>    #define ACPI_COMMON_NOTIFY_INFO \
>>>>           union acpi_operand_object       *notify_list[2];    /* Han=
dlers for system/device notifies */\
>>>> -       union acpi_operand_object       *handler;       /* Handler f=
or Address space */
>>>> +       union acpi_operand_object       *handler        /* Handler f=
or Address space */
>>>>
>>>>    /* COMMON NOTIFY for POWER, PROCESSOR, DEVICE, and THERMAL */
>>>>
>>>>    struct acpi_object_notify_common {
>>>> -ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       ACPI_COMMON_NOTIFY_INFO;
>>>> +};
>>>>
>>>>    struct acpi_object_device {
>>>> -       ACPI_OBJECT_COMMON_HEADER
>>>> -           ACPI_COMMON_NOTIFY_INFO struct acpi_gpe_block_info *gpe_=
block;
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       ACPI_COMMON_NOTIFY_INFO;
>>>> +       struct acpi_gpe_block_info *gpe_block;
>>>>    };
>>>>
>>>>    struct acpi_object_power_resource {
>>>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO u32 system=
_level;
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       ACPI_COMMON_NOTIFY_INFO;
>>>> +       u32 system_level;
>>>>           u32 resource_order;
>>>>    };
>>>>
>>>>    struct acpi_object_processor {
>>>> -       ACPI_OBJECT_COMMON_HEADER
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>>               /* The next two fields take advantage of the 3-byte sp=
ace before NOTIFY_INFO */
>>>>           u8 proc_id;
>>>>           u8 length;
>>>> -       ACPI_COMMON_NOTIFY_INFO acpi_io_address address;
>>>> +       ACPI_COMMON_NOTIFY_INFO;
>>>> +       acpi_io_address address;
>>>>    };
>>>>
>>>>    struct acpi_object_thermal_zone {
>>>> -ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       ACPI_COMMON_NOTIFY_INFO;
>>>> +};
>>>>
>>>>    /****************************************************************=
**************
>>>>     *
>>>> @@ -226,17 +243,22 @@ ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_I=
NFO};
>>>>           u32                             base_byte_offset;   /* Byt=
e offset within containing object */\
>>>>           u32                             value;              /* Val=
ue to store into the Bank or Index register */\
>>>>           u8                              start_field_bit_offset;/* =
Bit offset within first field datum (0-63) */\
>>>> -       u8                              access_length;  /* For seria=
l regions/fields */
>>>> +       u8                              access_length   /* For seria=
l regions/fields */
>>>>
>>>>
>>>>    /* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */
>>>>
>>>>    struct acpi_object_field_common {
>>>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_=
operand_object *region_obj; /* Parent Operation Region object (REGION/BAN=
K fields only) */
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       ACPI_COMMON_FIELD_INFO;
>>>> +       union acpi_operand_object *region_obj;
>>>> +       /* Parent Operation Region object (REGION/BANK fields only) =
*/
>>>>    };
>>>>
>>>>    struct acpi_object_region_field {
>>>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u16 resourc=
e_length;
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       ACPI_COMMON_FIELD_INFO;
>>>> +       u16 resource_length;
>>>>           union acpi_operand_object *region_obj;  /* Containing op_r=
egion object */
>>>>           u8 *resource_buffer;    /* resource_template for serial re=
gions/fields */
>>>>           u16 pin_number_index;   /* Index relative to previous Conn=
ection/Template */
>>>> @@ -244,12 +266,15 @@ struct acpi_object_region_field {
>>>>    };
>>>>
>>>>    struct acpi_object_bank_field {
>>>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_=
operand_object *region_obj; /* Containing op_region object */
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       ACPI_COMMON_FIELD_INFO;
>>>> +       union acpi_operand_object *region_obj;  /* Containing op_reg=
ion object */
>>>>           union acpi_operand_object *bank_obj;    /* bank_select Reg=
ister object */
>>>>    };
>>>>
>>>>    struct acpi_object_index_field {
>>>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       ACPI_COMMON_FIELD_INFO;
>>>>               /*
>>>>                * No "RegionObj" pointer needed since the Index and D=
ata registers
>>>>                * are each field definitions unto themselves.
>>>> @@ -261,7 +286,9 @@ struct acpi_object_index_field {
>>>>    /* The buffer_field is different in that it is part of a Buffer, =
not an op_region */
>>>>
>>>>    struct acpi_object_buffer_field {
>>>> -       ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO u8 is_creat=
e_field;    /* Special case for objects created by create_field() */
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       ACPI_COMMON_FIELD_INFO;
>>>> +       u8 is_create_field;     /* Special case for objects created =
by create_field() */
>>>>           union acpi_operand_object *buffer_obj;  /* Containing Buff=
er object */
>>>>    };
>>>>
>>>> @@ -272,7 +299,8 @@ struct acpi_object_buffer_field {
>>>>     ****************************************************************=
*************/
>>>>
>>>>    struct acpi_object_notify_handler {
>>>> -       ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *node; =
    /* Parent device */
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       struct acpi_namespace_node *node;       /* Parent device */
>>>>           u32 handler_type;       /* Type: Device/System/Both */
>>>>           acpi_notify_handler handler;    /* Handler address */
>>>>           void *context;
>>>> @@ -280,7 +308,8 @@ struct acpi_object_notify_handler {
>>>>    };
>>>>
>>>>    struct acpi_object_addr_handler {
>>>> -       ACPI_OBJECT_COMMON_HEADER u8 space_id;
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       u8 space_id;
>>>>           u8 handler_flags;
>>>>           acpi_adr_space_handler handler;
>>>>           struct acpi_namespace_node *node;       /* Parent device *=
/
>>>> @@ -307,7 +336,8 @@ struct acpi_object_addr_handler {
>>>>     * The Reference.Class differentiates these types.
>>>>     */
>>>>    struct acpi_object_reference {
>>>> -       ACPI_OBJECT_COMMON_HEADER u8 class;     /* Reference Class *=
/
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       u8 class;       /* Reference Class */
>>>>           u8 target_type;         /* Used for Index Op */
>>>>           u8 resolved;            /* Reference has been resolved to =
a value */
>>>>           void *object;           /* name_op=3D>HANDLE to obj, index=
_op=3D>union acpi_operand_object */
>>>> @@ -340,7 +370,8 @@ typedef enum {
>>>>     * Currently: Region and field_unit types
>>>>     */
>>>>    struct acpi_object_extra {
>>>> -       ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *method=
_REG;       /* _REG method for this region (if any) */
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       struct acpi_namespace_node *method_REG; /* _REG method for t=
his region (if any) */
>>>>           struct acpi_namespace_node *scope_node;
>>>>           void *region_context;   /* Region-specific data */
>>>>           u8 *aml_start;
>>>> @@ -350,14 +381,16 @@ struct acpi_object_extra {
>>>>    /* Additional data that can be attached to namespace nodes */
>>>>
>>>>    struct acpi_object_data {
>>>> -       ACPI_OBJECT_COMMON_HEADER acpi_object_handler handler;
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       acpi_object_handler handler;
>>>>           void *pointer;
>>>>    };
>>>>
>>>>    /* Structure used when objects are cached for reuse */
>>>>
>>>>    struct acpi_object_cache_list {
>>>> -       ACPI_OBJECT_COMMON_HEADER union acpi_operand_object *next;  =
    /* Link for object cache and internal lists */
>>>> +       ACPI_OBJECT_COMMON_HEADER;
>>>> +       union acpi_operand_object *next;        /* Link for object c=
ache and internal lists */
>>>>    };
>>>>
>>>>    /****************************************************************=
**************
>>>> --
> Yes, it is a different code base with different coding style etc.

