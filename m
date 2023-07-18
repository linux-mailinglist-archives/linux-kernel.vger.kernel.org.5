Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4427577BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjGRJVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjGRJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:20:56 -0400
Received: from 10.mo563.mail-out.ovh.net (10.mo563.mail-out.ovh.net [46.105.78.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC1B186
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:20:54 -0700 (PDT)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
        by mo563.mail-out.ovh.net (Postfix) with ESMTPS id CBC5422AAA;
        Tue, 18 Jul 2023 09:04:17 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <lee@kernel.org>; Tue, 18 Jul 2023 09:04:17 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.108.4.132])
        by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 9CED7107972;
        Tue, 18 Jul 2023 09:04:17 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 11:04:17 +0200
Message-ID: <d5a6a3d3-f91d-2aae-6961-550f284d0691@traphandler.com>
Date:   Tue, 18 Jul 2023 11:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 3/5] leds: class: store the color index in struct
 led_classdev
To:     Lee Jones <lee@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230624084217.3079205-1-jjhiblot@traphandler.com>
 <20230624084217.3079205-4-jjhiblot@traphandler.com>
 <20230713095328.GH10768@google.com>
Content-Language: en-US
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <20230713095328.GH10768@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG4EX1.emp2.local (172.16.2.31) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 6165709368042535387
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepieejfedukeevudfghfetudevhffhhfekjeeiudegtdehueevgfdvgeeivdeifedvnecukfhppedtrddtrddtrddtpdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopeguihhrvggtthhorhefrdguvghrphdrmhgrihhlqdhouhhtrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhlvggushesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeife
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/2023 11:53, Lee Jones wrote:
> On Sat, 24 Jun 2023, Jean-Jacques Hiblot wrote:
>>   
>> +static ssize_t color_show(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
>> +	const char *color_text = "invalid";
>> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> 
> Can this be NULL?
Thanks for your feedback.

No it can't be NULL.

> 
>> +	if (led_cdev->color < LED_COLOR_ID_MAX)
>> +		color_text = led_colors[led_cdev->color];
> 
> '\n'
