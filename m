Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE41B76278D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGYXvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjGYXvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:51:47 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9BFE2;
        Tue, 25 Jul 2023 16:51:46 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a04e5baffcso4226093b6e.3;
        Tue, 25 Jul 2023 16:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690329106; x=1690933906;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmL3jdsD2794K6zfOGkD4whNhD1loW+1ORVFHG9hOz4=;
        b=KHoom7OjBgwQ22Ucv09mRZlfO1w8XMPFHSagwVgOf8fF6NWFF+ANefSBctT7SHKcwL
         ySDGnb9TFpNQ8vTcssXQgA8tZfzTqN1pB8pdFSlw5qczSJgfn8Mxvbiy7owCcsdQvtNL
         799bDw8eTtQf67CTrF22jJMqCh5BHEHLMVLl/De0kjgHx63BVzq5zxHYETwtOxXSUr0A
         uPvM/RQiFnboXqpCaX9oskf2oQfTOpZ4WHu7Q0fh9axY79G/lYjU6Svtway80enGYVyI
         3rLs2Aej735lotxTIr2+1kitPowVHY9Cg4TXWoGfMVzTJAvUF00cmUGEHV0FTZR+6/H3
         i3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690329106; x=1690933906;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmL3jdsD2794K6zfOGkD4whNhD1loW+1ORVFHG9hOz4=;
        b=QE33FnFyqJJ7DC/szR3yE/1NS3aD/CUMVOrAhMvDKhVgeG9tQ1cUTR6eQwqwzgzf4G
         YSYJJaxFGkkfyM3K//I5+19XJylvlibEG+VWeNw8mdQr2VaFQhjjYEt8iHhfbk4bZg5Z
         IGIMey3UdMRHkg2xfKICEhgUVSRbHu7gs7rvXkYAWp0FjGIsnxDucl6vjFwWVHTKWqFf
         c5fUb7COfsfbHrDYW9hFCz0yfI+DhlmSv2iJg4F8jIz+hWCysar/iIcd5ncbej2/U9au
         U5tumjX/P7hR7/mtl47t5JjrPsso6qmuMY+8BkD7OxIPEahPCy7kheAHnVkrJJEUbBkF
         9Lrw==
X-Gm-Message-State: ABy/qLbLIsJKU4eC0EbedGFF08RCi+TIovfAkPwJab9PBJ8wNgZpE/Kj
        wZzX1anbk9fkoBRs31e7hns=
X-Google-Smtp-Source: APBJJlGUZvJeQlbNa6wi+9fDLG0eijp0Kze6XwcxOJGA287A9uJXVYWSfQJg6Y3Gevq38sU/87eczA==
X-Received: by 2002:a05:6808:f03:b0:3a3:61fc:f913 with SMTP id m3-20020a0568080f0300b003a361fcf913mr602994oiw.0.1690329105778;
        Tue, 25 Jul 2023 16:51:45 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id o5-20020a05680803c500b003a41484b23dsm5657475oie.46.2023.07.25.16.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 16:51:45 -0700 (PDT)
Message-ID: <11603db1-97c7-cfa0-ab1e-dbf5225ea6eb@gmail.com>
Date:   Tue, 25 Jul 2023 18:51:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     james@equiv.tech
Cc:     corbet@lwn.net, jdelvare@suse.com, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net
References: <20230504075752.1320967-4-james@equiv.tech>
Subject: Re: [RFC 03/11] hwmon: (core) Revise kerneldoc comments
Content-Language: en-US
From:   Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20230504075752.1320967-4-james@equiv.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -888,18 +891,25 @@ hwmon_device_register_with_groups(struct device *dev, const char *name,
>  EXPORT_SYMBOL_GPL(hwmon_device_register_with_groups);
>  
>  /**
> - * hwmon_device_register_with_info - register w/ hwmon
> - * @dev: the parent device (mandatory)
> - * @name: hwmon name attribute (mandatory)
> - * @drvdata: driver data to attach to created device (optional)
> - * @chip: pointer to hwmon chip information (mandatory)
> - * @extra_groups: pointer to list of additional non-standard attribute groups
> - *	(optional)
> + * hwmon_device_register_with_info - Register a hardware monitoring device.
> + * @dev: A pointer to the parent device (mandatory).
> + * @name: The ``hwmon`` device name (mandatory).
> + * @drvdata: A pointer to the private driver data structure.
> + * @chip: A pointer to the chip descriptor (mandatory).
> + * @extra_groups: A pointer to a ``NULL``-terminated list of additional
> + *	non-standard ``sysfs`` attribute groups.

This function has no @groups parameter, only @extra_groups.

>   *
> - * hwmon_device_unregister() must be called when the device is no
> - * longer needed.
> + * Creates the standard ``sysfs`` attributes in the hardware monitoring core,
> + * letting the driver focus on reading from and writing to the chip instead of
> + * having to bother with ``sysfs`` attributes.
>   *
> - * Returns the pointer to the new device.
> + * The result is a newly allocated ``hwmon`` device with standard ``sysfs``
> + * attributes as specified by @name and @groups and additional attributes as

But here a @groups parameter is mentioned.

> + * specified by @extra_groups.
> + *
> + * Return: On success, a pointer to the new ``hwmon`` device.
> + * hwmon_device_unregister() must be called on it when it is no longer needed.
> + * On failure, a &PTR_ERR.
>   */
>  struct device *
>  hwmon_device_register_with_info(struct device *dev, const char *name,

