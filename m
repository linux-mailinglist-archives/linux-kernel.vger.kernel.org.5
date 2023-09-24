Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E63D7AC835
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjIXNIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIXNIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:08:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8DCFC;
        Sun, 24 Sep 2023 06:08:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690d9cda925so3462675b3a.3;
        Sun, 24 Sep 2023 06:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695560918; x=1696165718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9MDNJDXW7eYgtZbRuK/v5AVHiUe1pWF40nA44SwFSMs=;
        b=abPU7kMctujhKWEfRmM4CR4uiFmUcC94AGet1OFeyMAbv22VlTghpiEfKMn/Wnuht0
         c4z4pbmQUw7ju4j9b8A1QwhX2iTVNqz5ATmyqPIkIIpr6n6jepQoEU1gjKXqevWpM6mR
         Ipt4Zm+J7A0mgWnS92QOAJEpxwC9crKDTw5eEIDU6Ek2vqoVvkpW53QA+cWqgJyqh6nq
         Cm2JoBW/np6Kzyy2VBSdr/Go8B7ek26/ytnDEfHZn5HeyPRlytd07t62aePK5MTBwWLT
         aXVcxoMwK6+KoTbR2b4ezsoibY8hvSkhr3EuwMDt2Y6tf058OVAchAXxZZ8EwR8WIO+d
         EWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695560918; x=1696165718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MDNJDXW7eYgtZbRuK/v5AVHiUe1pWF40nA44SwFSMs=;
        b=N7UvWvF/cvwQBASAia3PoTR2mUck6b5CEF1A/rIUrchcoOuoVNgbCR8+mTVAnCD1NW
         t6j9yvGGKkq63ThmhatHzJvGpmxRwQSWAF+ISqkI5MBDfw2VymZ7N1s/jzW0NIsRXp4l
         MfZWSvQYB5K/5f1jQCiFoeQ3nDpr19Pf6puksNyGD6/ejVha98A5t2vNr2YCkYsGCF7p
         hwX1c7EJzCQEjyA7lVtsrtgrlFV5ELUyXd2mDGCj+hx2acaHAMfETZXantZ6/DbLkSwP
         /A3zmFj9Q00njwXtUdUrNtC1AJcdeSlY1uZIik+HR3nHpjRC+DkbddUj5bQkH31BaOpZ
         SQMw==
X-Gm-Message-State: AOJu0YwRhRIUHZ1fMR3Rh2FZlFJroyvFqhLSX8Yy8Qo5iIAoeg100Xzb
        SlRpP42jsiLdMMMdjtTcQ1Y=
X-Google-Smtp-Source: AGHT+IHIQF9Tk5+ZLyiP8V1HkeUuxHs065A/VB0hZArVJ4KIbOv5iT5IOxZlV8tcvidoTDuuucEssA==
X-Received: by 2002:a05:6a00:1748:b0:690:c1a6:1c3b with SMTP id j8-20020a056a00174800b00690c1a61c3bmr3306583pfc.33.1695560917915;
        Sun, 24 Sep 2023 06:08:37 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id q16-20020a62e110000000b0069028bdd24dsm6305220pfh.34.2023.09.24.06.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 06:08:37 -0700 (PDT)
Message-ID: <36d8a626-f4a6-fe51-5726-be32aabd519d@gmail.com>
Date:   Sun, 24 Sep 2023 18:38:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/3] greybus: Add BeaglePlay Linux Driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, johan@kernel.org,
        elder@kernel.org
References: <20230924113725.164948-1-ayushdevel1325@gmail.com>
 <20230924113725.164948-3-ayushdevel1325@gmail.com>
 <6ce74c42-d1d0-d9cb-9d90-68989933d1d4@linaro.org>
 <62f5671d-738b-997c-798f-7e6cc00f7ef9@gmail.com>
 <11888c25-466b-2c28-1265-578736182846@linaro.org>
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <11888c25-466b-2c28-1265-578736182846@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +	spinlock_t tx_producer_lock;
>>>> +	/* tx_consumer_lock: HDLC consumer lock */
>>>> +	spinlock_t tx_consumer_lock;
>>>> +	struct circ_buf tx_circ_buf;
>>>> +	u16 tx_crc;
>>>> +	u8 tx_ack_seq;
>>>> +
>>>> +	u16 rx_buffer_len;
>>>> +	u8 rx_in_esc;
>>>> +	u8 rx_buffer[MAX_RX_HDLC];
>>>> +};
>>>> +
>>>> +struct hdlc_payload {
>>>> +	u16 length;
>>>> +	void *payload;
>>>> +};
>>>> +
>>> ...
>>>
>>>> +
>>>> +static int gb_serdev_init(struct gb_beagleplay *bg)
>>>> +{
>>>> +	u32 speed = 115200;
>>>> +	int ret;
>>>> +
>>>> +	serdev_device_set_drvdata(bg->serdev, bg);
>>>> +	serdev_device_set_client_ops(bg->serdev, &gb_beagleplay_ops);
>>>> +	ret = serdev_device_open(bg->serdev);
>>>> +	if (ret) {
>>>> +		return dev_err_probe(&bg->serdev->dev, ret,
>>>> +				     "Unable to Open Serial Device");
>>>> +	}
>>> Please run scripts/checkpatch.pl --strict and fix reported warnings.
>>> Some warnings can be ignored, but the code here looks like it needs a
>>> fix. Feel free to get in touch if the warning is not clear.
>> So I do not actually get any errors here in checkpatch. I am running the
>> follwing:
>>
>> `scripts/checkpatch.pl --codespell --strict patch/*`
>>
>> I only get a warning in coverletter due to that path of DT bindings
>> being more than 75 character long and ` Lines should not end with a '('`.
>>
>>>> +	if (!bg)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	bg->serdev = serdev;
>>>> +	ret = gb_serdev_init(bg);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = hdlc_init(bg);
>>>> +	if (ret)
>>>> +		goto free_serdev;
>>>> +
>>>> +	ret = gb_greybus_init(bg);
>>>> +	if (ret)
>>>> +		goto free_hdlc;
>>>> +
>>>> +	gb_beagleplay_start_svc(bg);
>>>> +
>>>> +	return 0;
>>>> +
>>>> +free_hdlc:
>>>> +	hdlc_deinit(bg);
>>>> +free_serdev:
>>>> +	gb_serdev_deinit(bg);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void gb_beagleplay_remove(struct serdev_device *serdev)
>>>> +{
>>>> +	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
>>>> +
>>>> +	gb_greybus_deinit(bg);
>>>> +	gb_beagleplay_stop_svc(bg);
>>>> +	hdlc_deinit(bg);
>>>> +	gb_serdev_deinit(bg);
>>>> +}
>>>> +
>>>> +static const struct of_device_id gb_beagleplay_of_match[] = {
>>>> +	{
>>>> +		.compatible = "beagle,play-cc1352",
>>>> +	},
>>>> +	{},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, gb_beagleplay_of_match);
>>>> +
>>>> +static struct serdev_device_driver gb_beagleplay_driver = {
>>>> +	.probe = gb_beagleplay_probe,
>>>> +	.remove = gb_beagleplay_remove,
>>>> +	.driver = {
>>>> +	      .name = "gb_beagleplay",
>>>> +	      .of_match_table = gb_beagleplay_of_match,
>>> This is still wrongly aligned. Spaces after tab. Are you sure checkpatch
>>> does not complain bout it?
>> Again, it doesn't seem to for me. Am I missing some environment
>> variables or options? Or maybe something wrong with my editor config
>> (neovim)?
> You have spaces after tab, so how can this be properly aligned?

Well, I will try to fix all of them. They might be remnants from when I 
was developing this out-of-tree. Still, it's strange for checkpatch to 
not complain. Will look into that as well if I get time.


Yours Sincerely,

Ayush Singh

