Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A97B4908
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbjJASNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 14:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjJASNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 14:13:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E1BC;
        Sun,  1 Oct 2023 11:13:44 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-692779f583fso11713363b3a.0;
        Sun, 01 Oct 2023 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696184024; x=1696788824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMj01fiCMchmpOFI6pg14GedO51sLHMCkjaQsCK6pDM=;
        b=kggSocivqwv1ntXtLBlqPimDLxjuQ0r8qrHhRCdx6r/cl+7DV0NW2tsyIwispQPK7H
         3T41zyPDy/c0eFxpSx5UnYQcBVxOkyolJolYeZ34Bv8L16kDB3BTNzIt20/Culd5AwBx
         PHG6frWKAie0N/lpru0aeyXGYod8Ee6X74PX2Ug30Opmx9wJ8LV6gVB4II89jiQ1lbjv
         fuMKoEb1ABtn5hdB0EeuqsABBBR0kaLJHoM0lU14jS1VxtHUAW6qJna6gEfZKYWxmJTy
         Oq2DVtQjaPZTk9PS8+8vj65IzkAe+DJX7BqcOAbF5v61WPFtnmP8QMsSNpkvVXIgF5da
         e4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696184024; x=1696788824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMj01fiCMchmpOFI6pg14GedO51sLHMCkjaQsCK6pDM=;
        b=LuOurGuYKQvXBwZ5/sJQA+mSExg6UJs9rhUNv9bkkJiAO8Q73Ghf8dZv9sVEABk3kU
         fZUUtreNJJnYBOR/v3hngb2AmtBurR97DHKTeXhWGD+qySPTCSBCa0ss5dA2QnZR5nZB
         guXoCw4UWBZPRthN6LsDPMczFnAKq4I1/2YDr4lhF2WfMqzwoq3JkKwgYeDqg3+GhjyJ
         xCGFvkqBrBgmSEphQspiE2XRoeMReCrDnddrN+z18FzJ4y9m1oIsSR2ElKWV0DsRljqZ
         JDxPTv1J79xL1MyFMTFFltOdIRqMs0shVSg1Ka4Nc3D7UyM2IyAT/lt3RVFO4yNOwfbA
         G77g==
X-Gm-Message-State: AOJu0YzXNdvdLcuEofW2TfiOg06xYz2pbccLDqjKpcb8JUAs0C+UbHwR
        bVfIjkzcnidG3AiwdeEcqKf6p+/MNfVx8g==
X-Google-Smtp-Source: AGHT+IH+QzGsLJ3GCTpB6XfJ4ivzoU357fMauno1Q+QAtY+opNqUqihkD2RFpKSnRz/tRFolPHYyEQ==
X-Received: by 2002:a05:6a00:2341:b0:68c:4e22:8f78 with SMTP id j1-20020a056a00234100b0068c4e228f78mr9219967pfj.25.1696184023793;
        Sun, 01 Oct 2023 11:13:43 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id q25-20020a62e119000000b0069337938be8sm7729216pfh.110.2023.10.01.11.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 11:13:43 -0700 (PDT)
Message-ID: <66fbd8d1-8b1a-50b5-c442-23847dc3d42f@gmail.com>
Date:   Sun, 1 Oct 2023 23:43:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 2/3] greybus: Add BeaglePlay Linux Driver
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
Content-Language: en-US
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <11888c25-466b-2c28-1265-578736182846@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
>
> Best regards,
> Krzysztof
>
So I just wanted to confirm, but I think spaces after tab are fine for 
alignment, right? I found this 
(https://www.mail-archive.com/kernelnewbies@kernelnewbies.org/msg13354.html) 
message in mailing list stating that it is fine.

It seems clang-format adds spaces for alignment less than 8 spaces. And 
checkpatch doesn't seem to complain as long as spaces are used for 
alignment (not indentation).


Sincerely,

Ayush Singh

