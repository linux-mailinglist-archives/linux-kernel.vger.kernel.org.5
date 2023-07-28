Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225D17669A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjG1KAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjG1KAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:00:31 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E33A94;
        Fri, 28 Jul 2023 03:00:30 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7907d03b0aeso3783339f.3;
        Fri, 28 Jul 2023 03:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690538430; x=1691143230;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYXdlsQto59N+qOsgizsXhnZeTGMmsgMUbVA8ztPdWQ=;
        b=aHefiETL4Akp0qM06eTNacvkc8f8HKl8q1ews7dzmibtTWhK+prLcyxveeLTs8Bumd
         P1HNe/jMXsGE+QeA6oMR4cKZsQdera4ymlEmKJpOGbstbgjUiYfb3QokGDeqbngOVOul
         +bqJljrkIumPOT+VOnLBjof1cUP3EuEokK8eCLqQP9rfFMpBnAhDhhcaGEGjA0GbfJIA
         H2/ff/i9yDMjntBH8QPZnNn5A8s0MYvHM96rQlfX4rTuXGIbdKlnQUjLyezZPlKNDKGD
         AUhEB6MVSt/kKw9dKxFI2JyI0j+lNvdkM2mMwSV9GC5hYFzo2L+UC79bEGlS6Bjw91BP
         BXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690538430; x=1691143230;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYXdlsQto59N+qOsgizsXhnZeTGMmsgMUbVA8ztPdWQ=;
        b=Xd1KxQ5Ntb39+j0Utz72lwmIoHGh737BNTrcPEK6oMGgNlkpnvpkuZVMcBdn8haSB6
         N78GY2WhvL351JXjxIJqdQAY/wQp0jh69V7TXYbTHvHVZQ6rz4dE5bWfvxrHIqJuxRbu
         8MFz3V3UVVJMSLPSERJPHVrofZdluRs/UY4dVc+MncjKOQ9E5GxeASfP84+DlsVWCoDi
         EJLIrzDGtfTKPn8eldFhxZClOKXK2Oxbdr64JsfrrAlpbXlHeLfWrz2MlDJOWCsGcV/j
         0YzO8p1/+0OjvkSPjmaNWSCPVlu4AHu7OD+tyUAvTvxOYd/zNlPu+YcPIB8sa10BlY43
         6Oyw==
X-Gm-Message-State: ABy/qLZ6IJFQ6N5mntw3RmBs5Z4LngMouyeDv1GAZtLTsrTgAIY3x8gc
        yZEJifedwpjzsWpyPJOGvx8PXVzsfEc=
X-Google-Smtp-Source: APBJJlHY5xMZETE/p7ghrMbZ6XCDtc+EHNCKu76F4xacN1bnbu28RgN13vMuwvFaibjnkz4LvGXyaw==
X-Received: by 2002:a05:6602:2773:b0:783:47cd:27b5 with SMTP id l19-20020a056602277300b0078347cd27b5mr2419334ioe.3.1690538429649;
        Fri, 28 Jul 2023 03:00:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u20-20020a02c054000000b0042b4f9ddecasm1006280jam.85.2023.07.28.03.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:00:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1cc12337-759e-c932-0303-b1b78e254c27@roeck-us.net>
Date:   Fri, 28 Jul 2023 03:00:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20230728082527.3531940-1-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD
In-Reply-To: <20230728082527.3531940-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/23 01:25, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> MPS returns PGOOD instead of PB_STATUS_POWER_GOOD_N.
> Fix that in the read_word_data hook.
> 
Datasheets are not public, so I can not verify, but the code below
only handles MP2973 and MP2971. What about MP2975 ?

Either case, this appears to affect most Monolithic chips, but
not all of them. Please limit the statement to known to be affected
chips.

> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>   drivers/hwmon/pmbus/mp2975.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
> index 28f33f4618fa..410b6eae6d02 100644
> --- a/drivers/hwmon/pmbus/mp2975.c
> +++ b/drivers/hwmon/pmbus/mp2975.c
> @@ -297,6 +297,10 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
>   	int ret;
>   
>   	switch (reg) {
> +	case PMBUS_STATUS_WORD:
> +		ret = pmbus_read_word_data(client, page, phase, reg);

		if (ret < 0)
			return ret;

Please add a comment explaining what is going on.

> +		ret ^= PB_STATUS_POWER_GOOD_N;
> +		break;
>   	case PMBUS_OT_FAULT_LIMIT:
>   		ret = mp2975_read_word_helper(client, page, phase, reg,
>   					      GENMASK(7, 0));
> 
> base-commit: a4bb1ce5b9e3ca403c04e20ebeae77fd6447cb11

