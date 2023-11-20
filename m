Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D113A7F1F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjKTVaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjKTVaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:30:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E9ECD;
        Mon, 20 Nov 2023 13:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700515792; x=1701120592; i=w_armin@gmx.de;
        bh=MBFtfZvwqMvy+UFHwM+JQ/gvlSJjJXWpeGnzAD21e2I=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=rFEGZiN+4Cjlje5zYwAlJCyHudK/cfPBfuTJy8a+k6nY2rEfkQztf0EFazZwAZFP
         h7cDOW7rtmKWYuj+ntvKCoT+WlB5+PjZN2XxSfnfIjG2FT8bxcnXKkhr+3REdFLKP
         C9WUeU8LrJpOv4+8pRdKeCLOOaGUQ5A3y6ZdK8co3KRZ+C8qGKg2YmjS6dlv2f8SL
         d7nMaYIyXDarIRkG/sTG+g7CyxfH4fuz/TgQ+grG+q+bIywlU6QkVyWNaJgII4L8Q
         Vkw6Ldgjbb6cCMMIvRHeanslMxY2NdX65xLrVd/RIEldwhZom1wlSR+ZpRtUuiOhD
         acMsXgqMktdQHyUDSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDj4-1rCMJy0Dvi-00CfGz; Mon, 20
 Nov 2023 22:29:52 +0100
Message-ID: <4512f55b-8dce-40b0-a207-7c3463ca4e01@gmx.de>
Date:   Mon, 20 Nov 2023 22:29:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] platform/x86: wmi: Add wmidev_block_set()
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, jithu.joseph@intel.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231103182526.3524-1-W_Armin@gmx.de>
 <4eb8e035-26f1-44e6-ae32-61d843c61f13@redhat.com>
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <4eb8e035-26f1-44e6-ae32-61d843c61f13@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZX+IkWGdT7MGRB6uOQq3mabLrYDspwDXef3MskS3BFYnoih0L5R
 wU4PmmVrFHwJXwDf1Rr0lY0mT3zQmetFRe/5JArNi/aTiTo7/95Dh9rcQQ/0OFdggthnBoT
 +6dlEzCF1iI7HBy76F/4foaV1eAjaVG8LXyeAbhUSBNqLkLNzLICrW/HihM95n0O74s4N8f
 WOEx912uJMxtQtB63/pwQ==
UI-OutboundReport: notjunk:1;M01:P0:zYzwr6bAKuE=;ZMY5Zx+InrqPDrT8LoFtEiuz9e0
 YXlc0FxHeuFjebm1bv+eRR7Ioa40hL7W5UVLPkWQ4WjhQQKoo0XCYZRFjffxVgsrlg447MidV
 o9mgr6fl7q5TAQHpY/nYowut+AQ+2RTXaMEf/f4cp+gBWV3fIboLl3fArEjEcP3J4vzS8x2yj
 TdMqATjXD9JPulcEM+5W7gXYqqFCrGXc9/iYHGN8zAPp4gMnOeQN1nM+rbBd3MwUqC0ejPeMI
 LuUo3IOCG8A6T6SSPhazJZe4oxp8290SNtRYwPFTy0bcp6Jey6gnEnYHPAMyv9SHLNkERfYMx
 FIlUqTdjAPbCm6B9kDAoBaD+6JW5uVmEDsO/UlSBEjB5P1bH5bJalKP6bbF2GhCjP5vHuKngA
 X+40M49z/cMwH32G6lzfxr0F1nOhl9qaVT9//oHB2yZNKpm3Odnccdi7MPl3zgtd+8NHzndDG
 6BA4lrm+0saqnembzP98fX9OjSkM2CXDaotTGK8b18hWZjjcoz4JptVMR6pilgoDHz31TPlXO
 8GjkHqBw+9Hmq/ENJhCANNaYolEtCy2Q8qDaUXCzEdxGnrLBoWS+isnBXwBYrShzuz4IKZkeE
 Y7FxpW9mo8Qjxe6LaoYasM8ePCsKIC4kGteUaW5dv2WrPph9ovQxWOpShwD41DZmUyOumIntU
 6VqRJ6yq2Atumy/0KADG13V6gB9k4n6gcUXuEBqaCcmwMTwcrmjen9rP8byAIa/uL1XF+p8ts
 4Lml1fBCVZw6NUwhMk7AlptIBvDwubpcDnMEGIwK7gF8dxiYzFftfEewFGZuKdnwBwKX2Isc3
 7oCvDHS049gk+JgB4Csj29nH8JMV0ZLdG7GGk3ZymOAJIFuajl6Is4pEih6OeMwiOcDtXU9zx
 24xa1T0LpPMvL3Gq8nl1GpCmOt409y36ONg1LDX1fya+D7Nich6aDb08K5ZylslDOT1P4e6tq
 p+Li2R3gn4BOhWnml2BUomzRKDo=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.11.23 um 13:00 schrieb Hans de Goede:

> Hi Armin,
>
> On 11/3/23 19:25, Armin Wolf wrote:
>> Currently, WMI drivers have to use the deprecated GUID-based
>> interface when setting data blocks. This prevents those
>> drivers from fully moving away from this interface.
>>
>> Provide wmidev_block_set() so drivers using wmi_set_block() can
>> fully migrate to the modern bus-based interface.
>>
>> Tested with a custom SSDT from the Intel Slim Bootloader project.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>
> One thing which I noticed during review of patch 3/4 is that
> some WMI drivers might benefit from having a wmidev_block_query_typed()
> similar to how we have a acpi_evaluate_dsm_typed() which takes an
> ACPI type and returns a NULL pointer instead of a wrongly typed
> ACPI object when the type does not match. Specifically this
> would allow dropping the return obj type checking from
> sbl-fw-update.c : get_fwu_request() .
>
> Now adding a wmidev_block_query_typed() wrapper around
> wmidev_block_query () just for this is not really a win,
> but it might be useful in the future ? Anyways just an idea.
>
> Regards,
>
> Hans

Good idea, i am already working one something similar:

The ACPI-WMI mapper on Windows translates the ACPI object into an standard WMI buffer, see
https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/driver-defined-wmi-data-items for details.

This "normalization" of the buffer content is necessary since for example WMI strings can
be expressed either thru an ACPI string or thru an utf16 ACPI buffer. Such a problem already
affected the HP WMI sensor driver, and i am planning to solve this with an new API.
This API would decouple WMI drivers from the ACPI subsystem.

However i am currently busy cleaning up the WMI subsystem (suspend fixes come next), so
it might take some time. But i have it on my (increasingly long) list.

Thanks,
Armin Wolf

>
>
>
>> ---
>> Changes in v2:
>> - applies on pdx86/for-next
>> ---
>>   drivers/platform/x86/wmi.c | 64 ++++++++++++++++++++------------------
>>   include/linux/wmi.h        |  2 ++
>>   2 files changed, 36 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
>> index 5c27b4aa9690..9d9a050e7086 100644
>> --- a/drivers/platform/x86/wmi.c
>> +++ b/drivers/platform/x86/wmi.c
>> @@ -536,41 +536,50 @@ EXPORT_SYMBOL_GPL(wmidev_block_query);
>>    *
>>    * Return: acpi_status signaling success or error.
>>    */
>> -acpi_status wmi_set_block(const char *guid_string, u8 instance,
>> -			  const struct acpi_buffer *in)
>> +acpi_status wmi_set_block(const char *guid_string, u8 instance, const struct acpi_buffer *in)
>>   {
>> -	struct wmi_block *wblock;
>> -	struct guid_block *block;
>>   	struct wmi_device *wdev;
>> -	acpi_handle handle;
>> -	struct acpi_object_list input;
>> -	union acpi_object params[2];
>> -	char method[WMI_ACPI_METHOD_NAME_SIZE];
>>   	acpi_status status;
>>
>> -	if (!in)
>> -		return AE_BAD_DATA;
>> -
>>   	wdev = wmi_find_device_by_guid(guid_string);
>>   	if (IS_ERR(wdev))
>>   		return AE_ERROR;
>>
>> -	wblock = container_of(wdev, struct wmi_block, dev);
>> -	block = &wblock->gblock;
>> -	handle = wblock->acpi_device->handle;
>> +	status =  wmidev_block_set(wdev, instance, in);
>> +	wmi_device_put(wdev);
>>
>> -	if (block->instance_count <= instance) {
>> -		status = AE_BAD_PARAMETER;
>> +	return status;
>> +}
>> +EXPORT_SYMBOL_GPL(wmi_set_block);
>>
>> -		goto err_wdev_put;
>> -	}
>> +/**
>> + * wmidev_block_set - Write to a WMI block
>> + * @wdev: A wmi bus device from a driver
>> + * @instance: Instance index
>> + * @in: Buffer containing new values for the data block
>> + *
>> + * Write contents of the input buffer to an ACPI-WMI data block.
>> + *
>> + * Return: acpi_status signaling success or error.
>> + */
>> +acpi_status wmidev_block_set(struct wmi_device *wdev, u8 instance, const struct acpi_buffer *in)
>> +{
>> +	struct wmi_block *wblock = container_of(wdev, struct wmi_block, dev);
>> +	acpi_handle handle = wblock->acpi_device->handle;
>> +	struct guid_block *block = &wblock->gblock;
>> +	char method[WMI_ACPI_METHOD_NAME_SIZE];
>> +	struct acpi_object_list input;
>> +	union acpi_object params[2];
>>
>> -	/* Check GUID is a data block */
>> -	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD)) {
>> -		status = AE_ERROR;
>> +	if (!in)
>> +		return AE_BAD_DATA;
>>
>> -		goto err_wdev_put;
>> -	}
>> +	if (block->instance_count <= instance)
>> +		return AE_BAD_PARAMETER;
>> +
>> +	/* Check GUID is a data block */
>> +	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD))
>> +		return AE_ERROR;
>>
>>   	input.count = 2;
>>   	input.pointer = params;
>> @@ -582,14 +591,9 @@ acpi_status wmi_set_block(const char *guid_string, u8 instance,
>>
>>   	get_acpi_method_name(wblock, 'S', method);
>>
>> -	status = acpi_evaluate_object(handle, method, &input, NULL);
>> -
>> -err_wdev_put:
>> -	wmi_device_put(wdev);
>> -
>> -	return status;
>> +	return acpi_evaluate_object(handle, method, &input, NULL);
>>   }
>> -EXPORT_SYMBOL_GPL(wmi_set_block);
>> +EXPORT_SYMBOL_GPL(wmidev_block_set);
>>
>>   static void wmi_dump_wdg(const struct guid_block *g)
>>   {
>> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
>> index 763bd382cf2d..207544968268 100644
>> --- a/include/linux/wmi.h
>> +++ b/include/linux/wmi.h
>> @@ -35,6 +35,8 @@ extern acpi_status wmidev_evaluate_method(struct wmi_device *wdev,
>>   extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
>>   					     u8 instance);
>>
>> +acpi_status wmidev_block_set(struct wmi_device *wdev, u8 instance, const struct acpi_buffer *in);
>> +
>>   u8 wmidev_instance_count(struct wmi_device *wdev);
>>
>>   extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);
>> --
>> 2.39.2
>>
