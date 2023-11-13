Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0D7EA418
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjKMT5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjKMT5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:57:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EF591;
        Mon, 13 Nov 2023 11:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699905429; x=1700510229; i=w_armin@gmx.de;
        bh=/B/pwQdH4AT1mvUUIUkmOQHN3jBCeaHqDQ6gFlPUOrU=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
         In-Reply-To;
        b=ng/Vi0mHF2mpLlavmShOSB9Z3HZ61SuY/2wfoN7zmuyeKTmhYLghgWOk1soygfUQ
         VA/cdB+0gB3oc7OXBrf5pLwPqz8Jmw1esCU+WsizWOPUAF55Hx51rZkxnD24Gu65w
         4uBXVV7v9tJ21EBN1bXzcqXJcCgSy00BYy3yy7Ir+45ku9g0puTUfrEhdF/Q3NLqN
         /XHfj2/fi09OJ/yYPYGhphuFIJKe87XqolSAEnpAzKvxRxafxv1pUW8buN+qTYQ1k
         iS5tiFegflpg+Ed6+WgN7ZRqtHutNmozllMkBSOeg7aDtRGry/m6JaVIrLo7YR6Yb
         nRX1L2woGCezzcxQcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvcG-1qpJGm3n7I-00UuvY; Mon, 13
 Nov 2023 20:57:08 +0100
Message-ID: <7b78eed3-eb78-4870-ae12-51219a07ef80@gmx.de>
Date:   Mon, 13 Nov 2023 20:57:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] platform/x86: wmi: Add wmidev_block_set()
Content-Language: en-US
From:   Armin Wolf <W_Armin@gmx.de>
To:     jithu.joseph@intel.com, hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231103182526.3524-1-W_Armin@gmx.de>
In-Reply-To: <20231103182526.3524-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OhTAUrtCnYwL/HJEo1UsETM+/EIPTdz+hybDK9EFIX2ZkHcJ1lh
 Fgi0zXGquVBbbCU7oIZKhZoATqMmSUmoGxKWi7mlb1/7cQloSbGZoiR+wBOH/aA7o2Prwr3
 9xVbu716KWWP1Bb/yOTWtNmRaSqc2erY1HIGnubcvyp+rLDCrLAV1Be/CrdkuIBLPfDJRJX
 MhK6exJQa3GhD/Zd1LuMw==
UI-OutboundReport: notjunk:1;M01:P0:QZQVYjW/MOY=;xBzPffITxr98bJC/Bbb2jMHzJ9R
 s2rOZHdav4q60ZgQnJChI54Qh4QAdNkCn+R+FwpVKOJz8I6bnCsx563hpV7gFecgZMvjMEite
 qDBauMKhBHKIldxnd/eRV3z9rczTN7Ru6MHrK2L3wkWSpEPhw8jRwbSaKuoUujKr/MGhggkoD
 AlE8UHQOm1XZI9ROTZljvX+lGE/Q/DYqr1OruHbxaB4R/LpskBKc0i8oREZX4r1R7btzqwJd6
 +ahcoITklglGdI/9uTuFIS14blm22ir0/jcZgHQA6fLUu4moxZwOqeyjcB8I1W+N4UKcIMDOZ
 YGFuYoPuRcbYqnuLelKq0uTSFrI0PCttC8SGzaSPXSYKf7u60DbWQhvQxwqAJEmd2mehcyrn7
 XDT45LXNvcY/VaerGUwU9sV/1tioEd+G3P8r03ZBHlP4uAV6c8Grhn7tUEh1HVPgK3QC4Z15T
 7UmrCqU6U4wHnz3hyEzD3jKvnGYW5nfyrS9opiD+V1rgbTpqMMMEaifmHGKFfjhpI/u8sZrbV
 0rrPN91GdvWJPrFJuS0KRWTcKZcPpqkzd47gAkNEVcF9+ZGlfbBXvPQLzBw2AMWomLz3Eg4Dg
 ZZYtJrugMdOcbe7/8QsdCupOnJibgpVSkx9dhYpYgVdA0NxoykrUH1TEna07R+lpZKuf7wUaB
 FxcgOE6IysDhT+28nvAtOBC9WTq7zrOmTVBQ9qRx+ZkK2tPKHrAwWUv8WhCa7nlly+nAcVpXf
 2kPsIQgtnBeifOx9XwmafsUlgKKCIbGXi3lan45SeTBaTIMKXGujp4F0qlqnLC8s7XnkEgopM
 gji0OZYQ0eMtRfUQqEn53pURpWKjv8Z4lr12mEqC59xAh6lHMDIlqcaNwgumL2mK2NsvxhWgd
 cbW+ENEsSXHyEcEZrtYHqRw8QLRYARh4MsYhqYR7vV1iNv7xyqCZf5uchriWGfbYIRWe9Rxq0
 qMAsRi5TKmId9Uv1HRmJu7SlsxA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.11.23 um 19:25 schrieb Armin Wolf:

> Currently, WMI drivers have to use the deprecated GUID-based
> interface when setting data blocks. This prevents those
> drivers from fully moving away from this interface.
>
> Provide wmidev_block_set() so drivers using wmi_set_block() can
> fully migrate to the modern bus-based interface.
>
> Tested with a custom SSDT from the Intel Slim Bootloader project.

Any thoughts on this?

Armin Wolf

>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes in v2:
> - applies on pdx86/for-next
> ---
>   drivers/platform/x86/wmi.c | 64 ++++++++++++++++++++------------------
>   include/linux/wmi.h        |  2 ++
>   2 files changed, 36 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 5c27b4aa9690..9d9a050e7086 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -536,41 +536,50 @@ EXPORT_SYMBOL_GPL(wmidev_block_query);
>    *
>    * Return: acpi_status signaling success or error.
>    */
> -acpi_status wmi_set_block(const char *guid_string, u8 instance,
> -			  const struct acpi_buffer *in)
> +acpi_status wmi_set_block(const char *guid_string, u8 instance, const struct acpi_buffer *in)
>   {
> -	struct wmi_block *wblock;
> -	struct guid_block *block;
>   	struct wmi_device *wdev;
> -	acpi_handle handle;
> -	struct acpi_object_list input;
> -	union acpi_object params[2];
> -	char method[WMI_ACPI_METHOD_NAME_SIZE];
>   	acpi_status status;
>
> -	if (!in)
> -		return AE_BAD_DATA;
> -
>   	wdev = wmi_find_device_by_guid(guid_string);
>   	if (IS_ERR(wdev))
>   		return AE_ERROR;
>
> -	wblock = container_of(wdev, struct wmi_block, dev);
> -	block = &wblock->gblock;
> -	handle = wblock->acpi_device->handle;
> +	status =  wmidev_block_set(wdev, instance, in);
> +	wmi_device_put(wdev);
>
> -	if (block->instance_count <= instance) {
> -		status = AE_BAD_PARAMETER;
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(wmi_set_block);
>
> -		goto err_wdev_put;
> -	}
> +/**
> + * wmidev_block_set - Write to a WMI block
> + * @wdev: A wmi bus device from a driver
> + * @instance: Instance index
> + * @in: Buffer containing new values for the data block
> + *
> + * Write contents of the input buffer to an ACPI-WMI data block.
> + *
> + * Return: acpi_status signaling success or error.
> + */
> +acpi_status wmidev_block_set(struct wmi_device *wdev, u8 instance, const struct acpi_buffer *in)
> +{
> +	struct wmi_block *wblock = container_of(wdev, struct wmi_block, dev);
> +	acpi_handle handle = wblock->acpi_device->handle;
> +	struct guid_block *block = &wblock->gblock;
> +	char method[WMI_ACPI_METHOD_NAME_SIZE];
> +	struct acpi_object_list input;
> +	union acpi_object params[2];
>
> -	/* Check GUID is a data block */
> -	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD)) {
> -		status = AE_ERROR;
> +	if (!in)
> +		return AE_BAD_DATA;
>
> -		goto err_wdev_put;
> -	}
> +	if (block->instance_count <= instance)
> +		return AE_BAD_PARAMETER;
> +
> +	/* Check GUID is a data block */
> +	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD))
> +		return AE_ERROR;
>
>   	input.count = 2;
>   	input.pointer = params;
> @@ -582,14 +591,9 @@ acpi_status wmi_set_block(const char *guid_string, u8 instance,
>
>   	get_acpi_method_name(wblock, 'S', method);
>
> -	status = acpi_evaluate_object(handle, method, &input, NULL);
> -
> -err_wdev_put:
> -	wmi_device_put(wdev);
> -
> -	return status;
> +	return acpi_evaluate_object(handle, method, &input, NULL);
>   }
> -EXPORT_SYMBOL_GPL(wmi_set_block);
> +EXPORT_SYMBOL_GPL(wmidev_block_set);
>
>   static void wmi_dump_wdg(const struct guid_block *g)
>   {
> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
> index 763bd382cf2d..207544968268 100644
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -35,6 +35,8 @@ extern acpi_status wmidev_evaluate_method(struct wmi_device *wdev,
>   extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
>   					     u8 instance);
>
> +acpi_status wmidev_block_set(struct wmi_device *wdev, u8 instance, const struct acpi_buffer *in);
> +
>   u8 wmidev_instance_count(struct wmi_device *wdev);
>
>   extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);
> --
> 2.39.2
>
