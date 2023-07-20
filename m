Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA69A75AFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGTNZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjGTNZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:25:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780B410F5;
        Thu, 20 Jul 2023 06:25:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666e916b880so472599b3a.2;
        Thu, 20 Jul 2023 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689859545; x=1690464345;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRRcMB5yAn+iRHKY8/2fsMAGDsr+Kvy2hWESkGb1AVk=;
        b=PRO4wTIKxgQpBXlLrrq0svkM8pfOmbGBroQEN5aNJkru3Hr24zi44RN0ZNnXb3Wa95
         l7DMkvUnYk7UrDIIBkvS4DQ9szJ+oDwdplymxme9JTroLHjuXQ7sMpJ+QicL8wJmsSF2
         EO5ZzzggUXvgnvZHHk7olcPUIzQUXfwr3tK4U2A02pYTGxjXfNKToaS0+9VRYMPwKpg7
         Qmht4JSSvnDsQjgX71P8SRTBhIGMFd2Ro2V1TOdD9bPNPq6Z92odplQ+rp+MvREdkqqW
         Nif8hPZ1u4pB9V/fN7KaVJFn8sYfRUgHjENAWIedykwYir01uoUCqnt95r1ZISRxMeTv
         JURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859545; x=1690464345;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRRcMB5yAn+iRHKY8/2fsMAGDsr+Kvy2hWESkGb1AVk=;
        b=dhAJnazxt/iHmRV7rwLluNWb3Bvq/hAe99r7XZrQkKLbfm6Lr3uyj7gnqLgzew7ufZ
         531izWUBQ4yIzQj6Q0ZETZdk7YT67OSn6gO9zS9FlW1LUWRvaEiB48YKh1iAN/2ZfYDZ
         KEz0eU2aWLGyKslCtjTIepNs0jwkhVJZCg0Oj/nkcLk8TVscQ3fkWH5pNOJ6T2VA+5JC
         NI0tzd5q33xlR5j8fgoOnuMS+T8JIckn99+vPS2m4MHrmYzbmsUapqIYn0DE+/eeJMrk
         TlpvLUWQ07xkD4oHgQKwR6xJc1oBu+IKQjS4RTmANAVCFMtceTyeru20iB9AJvpuNRcs
         FPYg==
X-Gm-Message-State: ABy/qLa1yj56wX3XweGfZIHFFjn/qtE9tjr+L4gEBrS14g75imiRqcFH
        +1Cfs8YsIrSHLfm7jRnzNZua9cUnH+M=
X-Google-Smtp-Source: APBJJlF5Hfhep/S9A63bqIzn+5vfFywvccKs8h8DOsOPM75E+Y/oYOted0rNSbjDtU+T/CVzf2LrtQ==
X-Received: by 2002:a05:6a20:6a0c:b0:12c:b10d:693d with SMTP id p12-20020a056a206a0c00b0012cb10d693dmr23992084pzk.6.1689859544799;
        Thu, 20 Jul 2023 06:25:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h14-20020aa786ce000000b0063d44634d8csm1156882pfo.71.2023.07.20.06.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 06:25:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3f5b8483-5a84-a41d-99b6-3c7a0c95b4e5@roeck-us.net>
Date:   Thu, 20 Jul 2023 06:25:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Thomas R <seatommyboy@gmail.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b1a0bd3b-a32d-aff0-db4e-d9ba770e3a49@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Driver for Nuvoton NCT6687D eSIO chip
In-Reply-To: <b1a0bd3b-a32d-aff0-db4e-d9ba770e3a49@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 04:09, Thomas R wrote:
> To whom it may concern,
> 
> I am trying to submit a patch for driver Driver for Nuvoton NCT6687D eSIO chip under drivers/hwmon. This driver is confirmed to be working for motherboards series B550 and B650.
> 
> Credits for creating this driver should go to Frederic BOLTZ https://github.com/Fred78290/nct6687d
> 
> Attached is my patch


This is not the way to submit patches into the Linux kernel.

Anyway, this is pretty much just taking the existing nct6683 driver,
extending it with an additional ID for NCT6687 (0xd451), removing
customer ID checks, and claiming new authorship. No, this is not how
kernel development works. If those motherboards use an NCT6687 with
ID 0xd451, or if the boards use a new customer ID, submit patches updating
the existing driver. If there are other changes improving the existing
driver, submit patches for it. I am not going to accept a second driver
for the same chip.

Guenter

