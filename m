Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37A802514
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 16:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjLCPAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 10:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbjLCPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 10:00:18 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC8DE8;
        Sun,  3 Dec 2023 07:00:19 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b399a6529so29110805e9.1;
        Sun, 03 Dec 2023 07:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701615618; x=1702220418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHGk2YsVkiJ77jxyvUDb9tnZQXtTKb75vareBu6hK5w=;
        b=S34Xnm0Nf5WzqTvQfTGa/2grRqSiG1Bv9oyU7bTHAnnxg49Xy+8m8/aokB1XFjQiVD
         0aoJk8MhbPxF+y7EVI++nSNMazaSV6g5jyy/CZj48Lkl/5NgQPj8sSAQ9J+TlnCZllFu
         4mw8S9vYH9/bfYyvegJR0HFBBxnBgn+Ryv4yn5BHxEUvVILi67MjA45VOAsqUEOS/bGf
         vD/ED9rZJBV77w7X9hrAHeEC3UfSJ0HlvSnxCDe0JhLgEsfsb6/iydpb6VLe/Ce5Wrvf
         0FOoPZQa4Q3uRr+qRse1Jjy8xuOnGPqxD4c1evx63vkpRihUEsaX5anGMy7rNMbo0wUm
         cEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701615618; x=1702220418;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHGk2YsVkiJ77jxyvUDb9tnZQXtTKb75vareBu6hK5w=;
        b=KhhoA6uA6ovZsu4PzOPZVo7A1c1sNY9MQNAgX6dpyN2gTNJix5ubh+4wB7l2ehtV/F
         JWeAK/44R9+oEe//8vcB2dDTK04BiZtdwpoBi2mdb/LOpDJXgS28mEsdjL2qnVluqFnh
         SF99eQ0uhBsizOjfD3qufnbUEY8ghQsymXn7anh9gDmA9cBv/lIDIaccTjTcuQvEy9AS
         CVtQyuE1TlabLl+KxuiOIxi1nO7OGjPgQuXcUephi4PFVD5iNIz6YNLbNBPwLPmfGaqR
         5ywTXQmWhi2dLZWWb/9iAdX3LWJLpEtOTcsLCNnddjcMElJBLvqt+j7nswTuAvLRLoO9
         C18A==
X-Gm-Message-State: AOJu0YyEQpUE3touBFq0Qc/yU/3JtU1t7ECeR94TBin4At6TLpnZRm1Z
        sGSYJG8KdElgz2RLFEVTHnk=
X-Google-Smtp-Source: AGHT+IGvn6nP0Rd5E0XZiJWB2kUjfm37+oyA0ouT1c6sNl147FRI7YB/mmtqtgCJKzf4WTZX/FC1Xw==
X-Received: by 2002:a05:600c:ad3:b0:40b:5e56:7b4d with SMTP id c19-20020a05600c0ad300b0040b5e567b4dmr762955wmr.150.1701615618225;
        Sun, 03 Dec 2023 07:00:18 -0800 (PST)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b0040b4b2a15ebsm11827932wmq.28.2023.12.03.07.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 07:00:17 -0800 (PST)
Message-ID: <121470f0-6c1f-418a-844c-7ec2e8a54b8e@gmail.com>
Date:   Sun, 3 Dec 2023 16:00:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     savicaleksa83@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] hwmon: Add driver for Gigabyte AORUS Waterforce AIO
 coolers
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hwmon@vger.kernel.org
References: <20231203120651.371429-1-savicaleksa83@gmail.com>
 <2a89f0b4-990a-4d0d-8e54-c4215579c23c@wanadoo.fr>
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <2a89f0b4-990a-4d0d-8e54-c4215579c23c@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-03 15:14:05 GMT+01:00, Christophe JAILLET wrote:
> Le 03/12/2023 à 13:06, Aleksa Savic a écrit :
>> This driver exposes hardware sensors of the Gigabyte AORUS Waterforce
>> all-in-one CPU liquid coolers, which communicate through a proprietary
>> USB HID protocol. Report offsets were initially discovered in [1] and
>> confirmed by me on a Waterforce X240 by observing the sent reports from
>> the official software.
>>
>> Available sensors are pump and fan speed in RPM, as well as coolant
>> temperature. Also available through debugfs is the firmware version.
>>
>> Attaching a fan is optional and allows it to be controlled from the
>> device. If it's not connected, the fan-related sensors will report
>> zeroes.
>>
>> The addressable RGB LEDs and LCD screen are not supported in this
>> driver and should be controlled through userspace tools.
>>
>> [1]: https://github.com/liquidctl/liquidctl/issues/167
>>
>> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
>> ---
> 
> Hi,
> ...

Hi Christophe!

> 
>> +/* Writes the command to the device with the rest of the report filled with zeroes */
>> +static int waterforce_write_expanded(struct waterforce_data *priv, const u8 *cmd, int cmd_length)
>> +{
>> +    int ret;
>> +
>> +    mutex_lock(&priv->buffer_lock);
>> +
>> +    memset(priv->buffer, 0x00, MAX_REPORT_LENGTH);
>> +    memcpy(priv->buffer, cmd, cmd_length);
> 
> Is memcpy_and_pad() useful here?

Looks like it is, thanks. Didn't know about that one.

> 
>> +    ret = hid_hw_output_report(priv->hdev, priv->buffer, MAX_REPORT_LENGTH);
>> +
>> +    mutex_unlock(&priv->buffer_lock);
>> +    return ret;
>> +}
> 
> ...
> 
>> +static int waterforce_read(struct device *dev, enum hwmon_sensor_types type,
>> +               u32 attr, int channel, long *val)
>> +{
>> +    int ret;
>> +    struct waterforce_data *priv = dev_get_drvdata(dev);
>> +
>> +    if (time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
>> +        /* Request status on demand */
>> +        ret = waterforce_get_status(priv);
>> +        if (ret < 0)
>> +            return -ENODATA;
>> +    }
>> +
>> +    switch (type) {
>> +    case hwmon_temp:
>> +        *val = priv->temp_input[channel];
>> +        break;
>> +    case hwmon_fan:
>> +        *val = priv->speed_input[channel];
>> +        break;
>> +    case hwmon_pwm:
>> +        switch (attr) {
>> +        case hwmon_pwm_input:
>> +            *val = DIV_ROUND_CLOSEST(priv->duty_input[channel] * 255, 100);
>> +            break;
>> +        default:
>> +            break;
> 
> Should we return an error here?

Only hwmon_pwm_input is made visible in waterforce_is_visible(),
so I'm not sure if anything else can get passed in? (Like the default case
below.) I'll add an error return here, just wondering.

> 
>> +        }
>> +        break;
>> +    default:
>> +        return -EOPNOTSUPP;    /* unreachable */
>> +    }
>> +
>> +    return 0;
>> +}
> 
> ...
> 
>> +static int waterforce_probe(struct hid_device *hdev, const struct hid_device_id *id)
>> +{
>> +    struct waterforce_data *priv;
>> +    int ret;
>> +
>> +    priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
>> +    if (!priv)
>> +        return -ENOMEM;
>> +
>> +    priv->hdev = hdev;
>> +    hid_set_drvdata(hdev, priv);
>> +
>> +    /*
>> +     * Initialize priv->updated to STATUS_VALIDITY seconds in the past, making
>> +     * the initial empty data invalid for waterforce_read() without the need for
>> +     * a special case there.
>> +     */
>> +    priv->updated = jiffies - msecs_to_jiffies(STATUS_VALIDITY);
>> +
>> +    ret = hid_parse(hdev);
>> +    if (ret) {
>> +        hid_err(hdev, "hid parse failed with %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    /*
>> +     * Enable hidraw so existing user-space tools can continue to work.
>> +     */
>> +    ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>> +    if (ret) {
>> +        hid_err(hdev, "hid hw start failed with %d\n", ret);
>> +        goto fail_and_stop;
> 
> Should this be 'return ret;' (the _start has failed, so why stop?)

Hm, yes.

> 
>> +    }
>> +
>> +    ret = hid_hw_open(hdev);
>> +    if (ret) {
>> +        hid_err(hdev, "hid hw open failed with %d\n", ret);
>> +        goto fail_and_close;
> 
> Should this be 'fail_and_stop' (the _open has failed, so why close?)

Also yes... I based this part on the nzxt-kraken2 driver in the tree,
perhaps that should be investigated as well. The aquacomputer_d5next driver
seems to be doing it correctly.

> 
>> +    }
>> +
>> +    priv->buffer = devm_kzalloc(&hdev->dev, MAX_REPORT_LENGTH, GFP_KERNEL);
>> +    if (!priv->buffer) {
>> +        ret = -ENOMEM;
>> +        goto fail_and_close;
>> +    }
>> +
>> +    mutex_init(&priv->status_report_request_mutex);
>> +    mutex_init(&priv->buffer_lock);
>> +    spin_lock_init(&priv->status_report_request_lock);
>> +    init_completion(&priv->status_report_received);
>> +    init_completion(&priv->fw_version_processed);
>> +
>> +    priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "waterforce",
>> +                              priv, &waterforce_chip_info, NULL);
>> +    if (IS_ERR(priv->hwmon_dev)) {
>> +        ret = PTR_ERR(priv->hwmon_dev);
>> +        hid_err(hdev, "hwmon registration failed with %d\n", ret);
>> +        goto fail_and_close;
>> +    }
>> +
>> +    hid_device_io_start(hdev);
>> +    ret = waterforce_get_fw_ver(hdev);
>> +    if (ret < 0)
>> +        hid_warn(hdev, "fw version request failed with %d\n", ret);
>> +    hid_device_io_stop(hdev);
>> +
>> +    waterforce_debugfs_init(priv);
>> +
>> +    return 0;
>> +
>> +fail_and_close:
>> +    hid_hw_close(hdev);
>> +fail_and_stop:
>> +    hid_hw_stop(hdev);
>> +    return ret;
>> +}
>> +
>> +static void waterforce_remove(struct hid_device *hdev)
>> +{
>> +    struct waterforce_data *priv = hid_get_drvdata(hdev);
>> +
>> +    hwmon_device_unregister(priv->hwmon_dev);
> 
> Should debugfs_remove_recursive(() be called?
> (if CONFIG_DEBUG_FS is defined)

It should. Sorry, missed it.

Thanks a lot,
Aleksa

> 
> CJ
> 
>> +
>> +    hid_hw_close(hdev);
>> +    hid_hw_stop(hdev);
>> +}
> 
> ...
> 

