Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5D880AB84
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574524AbjLHSAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574590AbjLHSAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:00:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDBBD1;
        Fri,  8 Dec 2023 10:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1702058417; x=1702663217; i=w_armin@gmx.de;
        bh=jCIeWudHWYfPX0tCxiCJvcyjCWHgh2ksRM0QRawqgGA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=Mn8HAlA1aBZat4uZLhYsMhnjG2wQHpFkSTY0223bYP0uxG4DktDYe9UNbkVHFLyL
         7Q3S8o0sEtFf/JyBVaN6VtF3l5rlkSRMpunvu1k1D0TOVTBCFMb8NDqUPQ+EWw5yt
         tp1wJ8qPFODuaZZSmIu0vDkd8S8CNxRsa1UahegetRs6Yr0yDAP8heD/tmhVYuBRT
         37ApEjc1RfR5CTIdKOBchqMGCGrO1dWhDDeXqM7/NAJhlGOORqRMIV3A/CZZlcBWE
         eiTxg6SniKQyybtaZyZMpK4iTu639FI6ctiCEBbdXtbn7vhgy+hNpKfbq6bpNV4F2
         dmuqxgAuQkhDm6HcXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVN6j-1qlViA29gd-00SL1v; Fri, 08
 Dec 2023 19:00:17 +0100
Message-ID: <44b649bd-b3da-4d66-ab2f-140024db9539@gmx.de>
Date:   Fri, 8 Dec 2023 19:00:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] platform/x86: dell-smbios-wmi: Stop using WMI chardev
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, corbet@lwn.net,
        Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20231207222623.232074-1-W_Armin@gmx.de>
 <20231207222623.232074-4-W_Armin@gmx.de>
 <b4789282-920-e9e-5deb-d107d5bb4c7@linux.intel.com>
Content-Language: en-US
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <b4789282-920-e9e-5deb-d107d5bb4c7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1yEg3cwfTKNleA0AuC4aDi4P2Ck4NZZftBiMwbpGwDcfcW7B4Xl
 PE4Y4lSaszH1Q6uZ+UgE9tomytSyXrei5IAxtz02xqmz3p32kCwprVBjEEUU8OqLshe4ZJ2
 6ZJq1yatESrZ/wgwxwwMAyRNv0YLDb+rkkCIjBDm1HaX5UdhclObQT8n625vybTFMK2QK3I
 s/OGMyyKmbvEhrMeF18iQ==
UI-OutboundReport: notjunk:1;M01:P0:m/fC9DcmGuo=;ftkS8WMT3J2Mw2rmOeLiLWZOV8D
 7HA9rymgdFTwJWVLvUzoPrCkgBJAKrV07rkjFZOQOQdBawtiqOfi3e6zdOuTzhtiU3Jf/JoIm
 qvMJ0X/ztZCGSCh84eLQ1ZPqAI8wHt0p43qVUgnagyoKj9aF8qbiRuWW4fFiFjX77FK2QZcOB
 TkCrbznTGzdT0AkyDAra/Dc82wq9S1N1mkkyDs5hWHkflWKAC/iDpghL257hQzce5/LzrLRv9
 JNLvS+/Bzcvt0T/q5vfdLsWYi7NVmq/oJmWSunhMR9VNvANh8FH5pK9W/in+Wx47Ixz8WBgvV
 jPzCTvnrJsdMxYYYk2Ncqbl4siXi8gdyD7xWD37viqHR465225RSlAPrSI88eLxsq2NoWAwEM
 kyYxSIWE/fF9WOKxoIM2rclnD2GUylz510Kd13VcrHgnG4yBlsmBXj8rhQbiCv1rEXK7x9mpv
 DHClbWlyoIFcKvIoMF/rJA5LYn8tmUjc2N58A4V9BqyAZ+cBbLx1wC0TicEyA5dyIw+W8wwfZ
 uL9yhhaWuxdwisRRQ3erNHaWK1kZ24QLH0TI6MtRJfleSodx2cwJL58lmeb6/cdHHEQywhzg3
 jWnI64fKt0un84qZaZw3A/TOqqe9TDUCUrt8OrqSDZ8KLg2hd5OQWgVgN1ygjDcnKvWPHIp1m
 xhWUqoAuwEajVtUQyy7Wf+73QVB/ctQxzgtywhT6G7UBICHQ6tNmaTJYYdcGp9bH3We5XEIFr
 XcD/Sr77jZ4RpP6MsxBfa5ITzmYUwg95a8eDeKM1Wui8kdiD1DrLxqAXACThD11JiG8G1oHs0
 pYXIay715SsGXrx0nrtQMrsRrX+M9SXyFRo1IWmt8IAkanxgD5cSyTKmaDHxKlxWwI26IAp9t
 oPCpbrAG1Sud/ah192XD6vn5oz4F4JL4jdpSiN1DQPCHMPBYk4Dc8hCmP/AzqZC1Wuw2Yq9qU
 SZfdmq7BYZTBi97DdtbY/cB8+wY=
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

Am 08.12.23 um 14:41 schrieb Ilpo J=C3=A4rvinen:

> On Thu, 7 Dec 2023, Armin Wolf wrote:
>
>> The WMI chardev API will be removed in the near future.
>> Reimplement the necessary bits used by this driver so
>> that userspace software depending on it does no break.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/dell/dell-smbios-wmi.c | 163 ++++++++++++++-----=
-
>>   1 file changed, 117 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/platform/x86/dell/dell-smbios-wmi.c b/drivers/plat=
form/x86/dell/dell-smbios-wmi.c
>> index 931cc50136de..61f40f462eca 100644
>> --- a/drivers/platform/x86/dell/dell-smbios-wmi.c
>> +++ b/drivers/platform/x86/dell/dell-smbios-wmi.c
>> @@ -32,7 +35,9 @@ struct wmi_smbios_priv {
>>   	struct list_head list;
>>   	struct wmi_device *wdev;
>>   	struct device *child;
>> -	u32 req_buf_size;
>> +	u64 req_buf_size;
>> +	u32 hotfix;
>> +	struct miscdevice char_dev;
>>   };
>>   static LIST_HEAD(wmi_list);
>
>>   static int dell_smbios_wmi_probe(struct wmi_device *wdev, const void =
*context)
>>   {
>> -	struct wmi_driver *wdriver =3D
>> -		container_of(wdev->dev.driver, struct wmi_driver, driver);
>>   	struct wmi_smbios_priv *priv;
>> -	u32 hotfix;
>> +	u32 buffer_size;
>>   	int count;
>>   	int ret;
>>
>> @@ -162,39 +225,44 @@ static int dell_smbios_wmi_probe(struct wmi_devic=
e *wdev, const void *context)
>>   	if (!priv)
>>   		return -ENOMEM;
>>
>> +	priv->wdev =3D wdev;
>> +	dev_set_drvdata(&wdev->dev, priv);
>> +
>>   	/* WMI buffer size will be either 4k or 32k depending on machine */
>> -	if (!dell_wmi_get_size(&priv->req_buf_size))
>> +	if (!dell_wmi_get_size(&buffer_size))
>>   		return -EPROBE_DEFER;
>>
>> +	priv->req_buf_size =3D buffer_size;
>> +
>>   	/* some SMBIOS calls fail unless BIOS contains hotfix */
>> -	if (!dell_wmi_get_hotfix(&hotfix))
>> +	if (!dell_wmi_get_hotfix(&priv->hotfix))
>>   		return -EPROBE_DEFER;
>> -	if (!hotfix) {
>> +
>> +	if (!priv->hotfix)
>>   		dev_warn(&wdev->dev,
>>   			"WMI SMBIOS userspace interface not supported(%u), try upgrading t=
o a newer BIOS\n",
>> -			hotfix);
>> -		wdriver->filter_callback =3D NULL;
>> -	}
>> +			priv->hotfix);
>>
>>   	/* add in the length object we will use internally with ioctl */
>>   	priv->req_buf_size +=3D sizeof(u64);
>> -	ret =3D set_required_buffer_size(wdev, priv->req_buf_size);
>> -	if (ret)
>> -		return ret;
>>
>>   	count =3D get_order(priv->req_buf_size);
>>   	priv->buf =3D (void *)__get_free_pages(GFP_KERNEL, count);
>>   	if (!priv->buf)
>>   		return -ENOMEM;
>>
>> +	if (priv->hotfix) {
>> +		ret =3D dell_smbios_wmi_register_chardev(priv);
>> +		if (ret)
>> +			goto fail_chardev;
>> +	}
>> +
>>   	/* ID is used by dell-smbios to set priority of drivers */
>>   	wdev->dev.id =3D 1;
>>   	ret =3D dell_smbios_register_device(&wdev->dev, &dell_smbios_wmi_cal=
l);
>>   	if (ret)
>>   		goto fail_register;
>>
>> -	priv->wdev =3D wdev;
>> -	dev_set_drvdata(&wdev->dev, priv);
>>   	mutex_lock(&list_mutex);
>>   	list_add_tail(&priv->list, &wmi_list);
>>   	mutex_unlock(&list_mutex);
>> @@ -202,6 +270,9 @@ static int dell_smbios_wmi_probe(struct wmi_device =
*wdev, const void *context)
>>   	return 0;
>>
>>   fail_register:
>> +	if (priv->hotfix)
>> +               dell_smbios_wmi_unregister_chardev(priv);
> I don't understand how hotfix -> priv->hotfix is related to this patch n=
or
> why it's necessary?
>
> Or did you mean to use it also in dell_smbios_wmi_remove() but forgot to
> add the if (priv->hotfix) there?

I indeed forgot to add the "if (priv->hotfix)" here, good catch.

> In any case, it would be better to put that conversion into own patch
> before this one.

I could also drop the priv->hotfix related changes and instead modify the =
driver
to use devres (devm_get_free_pages() for example). This would also simplif=
y the
error handling code.

I will send a v2 soon containing the necessary patches.

>> @@ -211,6 +282,7 @@ static void dell_smbios_wmi_remove(struct wmi_devic=
e *wdev)
>>         struct wmi_smbios_priv *priv =3D dev_get_drvdata(&wdev->dev);
>>         int count;
>>
>> +      dell_smbios_wmi_unregister_chardev(priv);
>>         mutex_lock(&call_mutex);
>>         mutex_lock(&list_mutex);
>>         list_del(&priv->list);
