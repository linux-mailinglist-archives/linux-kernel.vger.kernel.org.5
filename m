Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831B778773F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242883AbjHXRp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 13:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242850AbjHXRpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:45:45 -0400
X-Greylist: delayed 610 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Aug 2023 10:45:40 PDT
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FF81BD8;
        Thu, 24 Aug 2023 10:45:40 -0700 (PDT)
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
        by relay01-mors.netcup.net (Postfix) with ESMTPS id 4RWqwv29Mdz8xFh;
        Thu, 24 Aug 2023 19:35:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zint.sh; s=key2;
        t=1692898527; bh=uDdCBJw05B5DvjBOJKfmweBC8bPeek5YyqTp773ZeBc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fBlbdGLUHouoJ0rPmcoiiKT5kiqFl27p/aSw5iUur1hopBm/A0AnW+YDAxtKsov5i
         WcRQwJtdIW0m78hEJ8yb0pJtjv2iz/dT6QJtNPnhdQDi8b0sKw5XZ9q3ZSkq3nF+dT
         4IOxQ26AZxYeurfq8Pe5JY37/hT0LV6k4bQBeGgyoXE/yVcX69E0ABervmirLdg/qD
         N1kstyRNtRreGffHGN+5zxpeBA2WJHLXAmfoBwTE8tQ905Z2m5S/BMeXiZhjv3o8y7
         eyQYRQuUg7hx3sfAOuTH4o/12XETX6joY5ewXVzmgMfAkP/A7b4RRSZWm4Uour4EjT
         FVRqFC0C6+g2g==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
        by relay01-mors.netcup.net (Postfix) with ESMTPS id 4RWqwv1VCnz7v9g;
        Thu, 24 Aug 2023 19:35:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from mxe217.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy01-mors.netcup.net (Postfix) with ESMTPS id 4RWqwl2Q7Mz8sYl;
        Thu, 24 Aug 2023 19:35:19 +0200 (CEST)
Received: from [192.168.33.30] (p5dcce04c.dip0.t-ipconnect.de [93.204.224.76])
        by mxe217.netcup.net (Postfix) with ESMTPSA id D5F5C81990;
        Thu, 24 Aug 2023 19:35:04 +0200 (CEST)
Message-ID: <1813ff8c-e192-4873-a22b-5ee48a6f9185@zint.sh>
Date:   Thu, 24 Aug 2023 19:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] backlight: hid_bl: Add VESA VCP HID backlight
 driver
Content-Language: de-DE, en-US
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20230820094118.20521-1-julius@zint.sh>
 <20230820094118.20521-2-julius@zint.sh> <20230821163631.GA214013@aspen.lan>
From:   Julius Zint <julius@zint.sh>
In-Reply-To: <20230821163631.GA214013@aspen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D5F5C81990
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: MAl9D4VvBFNVUZn19yuNCMkWaMu7XFKNF+zKd+WI
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.08.23 18:36, Daniel Thompson wrote:
>> @@ -472,6 +472,14 @@ config BACKLIGHT_LED
>>   	  If you have a LCD backlight adjustable by LED class driver, say Y
>>   	  to enable this driver.
>>
>> +config BACKLIGHT_HID
>> +	tristate "VESA VCP HID Backlight Driver"
>> +	depends on HID
>> +	help
>> +	  If you have an external display with VESA compliant HID brightness
>> +	  controls then say Y to enable this backlight driver. Currently the
>> +	  only supported device is the Apple Studio Display.
> This contradicts the description which says you write the driver to the
> standard but only tested on Apple Studio Display. There is no need to
> spell what has been tested in the Kconfig text. Remove the final
> sentence!
Will remove it in v4.
>> diff --git a/drivers/video/backlight/hid_bl.c b/drivers/video/backlight/hid_bl.c
>> new file mode 100644
>> index 000000000000..b40f8f412ee2
>> --- /dev/null
>> +++ b/drivers/video/backlight/hid_bl.c
>> <snip>
>> +static void hid_bl_remove(struct hid_device *hdev)
>> +{
>> +	struct backlight_device *bl;
>> +	struct hid_bl_data *data;
>> +
>> +	hid_dbg(hdev, "remove\n");
> This message probably should be removed (if you want to know if a function was
> executed use ftrace).
>
>
>> +	bl = hid_get_drvdata(hdev);
>> +	data = bl_get_data(bl);
>> +
>> +	devm_backlight_device_unregister(&hdev->dev, bl);
>> +	hid_hw_close(hdev);
>> +	hid_hw_stop(hdev);
>> +	hid_set_drvdata(hdev, NULL);
>> +	devm_kfree(&hdev->dev, data);
>> +}
>> +
>> +static int hid_bl_get_brightness_raw(struct hid_bl_data *data)
>> +{
>> +	struct hid_field *field;
>> +	int result;
>> +
>> +	field = data->input_field;
>> +	hid_hw_request(data->hdev, field->report, HID_REQ_GET_REPORT);
>> +	hid_hw_wait(data->hdev);
>> +	result = *field->new_value;
>> +	hid_dbg(data->hdev, "get brightness: %d\n", result);
> To be honest I'm a little dubious about *all* the hid_dbg() calls. They
> add very little value (e.g. they are useful to get the driver working
> but not that important to keeping it working). As such I don't think
> they are worth the clutter in a CONFIG_DYNAMIC_DEBUG kernel.
>
> Note this is strictly for the hid_dbg() stuff... the hid_err() stuff in
> the probe error paths are much more useful!
You are right, I will remove all hid_dbg calls in v4.

Thank you very much for the review.

Julius
