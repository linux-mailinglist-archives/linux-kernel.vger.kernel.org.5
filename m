Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A76B7D86FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjJZQtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZQto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:49:44 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB1A4;
        Thu, 26 Oct 2023 09:49:43 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7af20c488so8761167b3.1;
        Thu, 26 Oct 2023 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698338982; x=1698943782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a4/dheoJ9dWHv5mUFQEViTi9AUYQK1a6PHdzoT/e6yo=;
        b=nUrI6pIPYWF2GXXIolYsKFuJCIWkJ7eKE6aPSAQrZBk8BlieRdtYOWMIyysyz6Erbu
         c4YUjPqypeMCwqoVgg90Er9ElfIaOcwBsxed0dOA1wC5dGJc85XBVGPbfLVGwXM30NXm
         o6T1g3vAAJRawLr2iHLmrhpU2eaEgrrMFwrDykQ5NHV5tXHNQjrnEPGAklX9nrwSZhAz
         VKTHhS7OVwkq+/n5SPEhGCjtDp2OEnl2vKPszstduOMWA9xomQozwRw8ZoXTdhayRHKw
         b1J5WYIKC5hXf3uL1UOJ7k/BERpCq201QfNZzRAhpgWR5ayJ83OZd1+M276PpeuXcOOd
         K95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698338982; x=1698943782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4/dheoJ9dWHv5mUFQEViTi9AUYQK1a6PHdzoT/e6yo=;
        b=ZQF2ej9mUoP2WzaLU67z/H62K5F7otkUBSsjZbb+kHGwvjCuNvZMvHt4CDkbbLQZ4u
         LCmebJ357J927kp7UJeYiWfrrRXM5oOO01rJ6h+rGZyE0w3Se28dQfpWAAahdbS6Y0bU
         MTDY81jA1XHvTcF/Uci2Cn1rzPf26EdPXQCddIZLQLuR91wXF2w1wRlxdCf1Fk5laGzo
         IEthHJFq3NKQw8xuXg1ACWGFvZ1gYoSCPHsqdjyBdlwjut3iKpocn/nv/DYGuSB8PC24
         nLBPo6EqlmTZ0UevfGTT8/7aIG4tQ++LBWlUZnnGqoYdJY1581P0bJRN4Y7r/1XAdYN9
         g5jA==
X-Gm-Message-State: AOJu0Yx3APZ16/GGBnxxonpsonMkaKlJ9QBaCDn9XRqxXX5JVvtwz+qZ
        0WIZAOOzApILJgbZflKX0A61Gk32vJE=
X-Google-Smtp-Source: AGHT+IEZH5OKoPGaiv6CJCTTJp/omGpCAA5guxIyAY5G6BFI5PG7LpEBLMTaAvAPxhZu9EyZWL0V1w==
X-Received: by 2002:a0d:e20a:0:b0:59b:fb69:1639 with SMTP id l10-20020a0de20a000000b0059bfb691639mr20136914ywe.32.1698338982254;
        Thu, 26 Oct 2023 09:49:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t78-20020a818351000000b0059b4e981fe6sm6083009ywf.102.2023.10.26.09.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 09:49:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fd996a28-99e6-ea69-df0e-49cf68780d16@roeck-us.net>
Date:   Thu, 26 Oct 2023 09:49:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] hwmon: (pmbus/max31785) Add delay between bus accesses
Content-Language: en-US
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "ninad@linux.ibm.com" <ninad@linux.ibm.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231023180804.3068154-1-lakshmiy@us.ibm.com>
 <bbbf3668-aa7a-4489-85b0-333cf394abe9@roeck-us.net>
 <25390DC7-E8FF-4706-B241-C45E6DFDF444@us.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <25390DC7-E8FF-4706-B241-C45E6DFDF444@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 07:48, Lakshmi Yadlapati wrote:
> Thank you Guenter!
> Should I fix and send the patch again?
> 

Please do. And don't top-post.

Thanks,
Guenter

> ﻿On 10/25/23, 7:48 PM, "Guenter Roeck" <groeck7@gmail.com <mailto:groeck7@gmail.com> on behalf of linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
> 
> 
> On Mon, Oct 23, 2023 at 01:08:03PM -0500, Lakshmi Yadlapati wrote:
>> Changes since V1:
>> 1. Changed the max31785_wait macro to a function, following the conventions
>> used in other drivers that had the same issue.
>> 2. Changed the function names from max31785_i2c_smbus* to max31785_i2c_* and
>> from max31785_pmbus_* to _max31785_*, making them more concise.
>>
> 
> 
> Please check Documentation/process/submitting-patches.rst
> for the expected patch format, specifically details on how
> description and change log are supposed to look like.
> 
> 
> Guenter
> 
> 
> 

