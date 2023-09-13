Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2D379EDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjIMQCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjIMQCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:02:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F13E54;
        Wed, 13 Sep 2023 09:01:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so23861985ad.1;
        Wed, 13 Sep 2023 09:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694620917; x=1695225717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pf6aIB5Ik/NE/fJOoTPJDJbQBogSiCh5cwf3Wm8aE8E=;
        b=kOejIynt0J6cVtk6+iNMTUB7QlT6d43QOS/AHomcOtNOQA7ZiKveFhvcIYzOI7I+jo
         AXfmvgBXOjz1cXFAWCgqDlKgfmzQyRXL7lRCMbhaEZU8wCTaeJNmRYIV31LiD85MsN6a
         l/YkjbbpP+ZxIEEeCZhWZipaZ+bd3hZH/LGETkvREV810IJGZEKTSIej2SXDBa1201Eb
         UVJdHIfONc4BWS0+zVkn8bfrgikv7pIu205LDIzwALChZrLE/b91/DiQ0lWRwmlMRLeo
         wob5IbBRf33fRXo7atmtCrF0OlvqIiF1PvxjAi4l20SedRVsGI+m4u6a83OCOl+/yous
         /vFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694620917; x=1695225717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pf6aIB5Ik/NE/fJOoTPJDJbQBogSiCh5cwf3Wm8aE8E=;
        b=qlKi+AfcLU/OLAa7xK4rB4X84G5na+b+fqwfM15gHOZjRamS7vttayNsL9wuDWySWl
         xKmGQ7L3/JjyOQl1aJN6ebWhwGr38hWR1gxWKQA4ZtXMkmvJu2uQ8Da4r7iFHLRVQZ66
         SuvJ0xcN66iW5hiLmzMkNuchAMBYeFsn9QS5qXgiDO3AftUt2MuoG+jtzxs47Na7BZe4
         3oqXgw03b9Jp4gnRbZYRPm7VkXlrKXQWH/BMwKcbUpS32c4QLkQZvpkq27knXLD1pvqx
         3pwjU17ZnByDMU1ctBm65NfOfEEx0f5xbBKNW7kxNAsUkGVHXD4yM62/GtLLFae8CyKz
         19WQ==
X-Gm-Message-State: AOJu0YyJzJsrCpFYotL5wqjdeissGiol9N3kkix4+tiNN8bGKbU+HlJL
        XhMeYsXpOEx/CqoMPXNNVQU=
X-Google-Smtp-Source: AGHT+IH4mRE92mVWKVjvQcjrucLZ+GEnuZexgOQYZC3s3V+ufuiMBXcN6qV7k+gemtoc92lEMsBarA==
X-Received: by 2002:a17:902:e741:b0:1bd:c931:8c47 with SMTP id p1-20020a170902e74100b001bdc9318c47mr3973662plf.68.1694620916682;
        Wed, 13 Sep 2023 09:01:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v5-20020a63bf05000000b0050f85ef50d1sm7983703pgf.26.2023.09.13.09.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 09:01:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <59bbc7c4-2caf-205e-c968-13dffccea3aa@roeck-us.net>
Date:   Wed, 13 Sep 2023 09:01:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] Why no v2?
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230913152135.457892-1-daniel.matyas@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230913152135.457892-1-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 08:21, Daniel Matyas wrote:
> This is kind of v2, but not exactly. Major changes were applied and
> commits were separated. The latter is the main reason why I did not call
> this v2.
> 

That is neither a reason nor a valid argument. Just call it v2 and mark
the added patch(es) with a changelog along the line of "v2: Added patch".

And a subject of "Why no v2?" is really useless and pointless.

Guenter

