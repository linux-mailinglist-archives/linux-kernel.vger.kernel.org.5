Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4597D8C03
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjJZXC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZXCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:02:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B63F128;
        Thu, 26 Oct 2023 16:02:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so1376730b3a.1;
        Thu, 26 Oct 2023 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698361342; x=1698966142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8VMHg2dbZC6m4HFrqo+Py57nY4d2BX9cNIAaKURpnOA=;
        b=TE6WTpr4FLsQZPu3fP9j9RLmQyoqrznPBAP6l58kDkhk1NaifE4PkfgdpqZnEhqRmh
         g+ePj969IJNUFUmMITst8WUdQFDFsJkHMv5Zw7CAo3VHrRSropQmjYEmJaC/dqTa7xn4
         PjXkY3IfC8sV27McR6/EgR4y72/d8cpr7CiX09L0WgLqpl8LZKp+pd4TbSol6lauzMpK
         LArt75mEb9KxA/2Sxojv8C2+4cihNfpuKSZaW1IS6DQcdu0oJdbbhsZ/aH1/HwKmSkUM
         J+0dWm45dc+YHMaBgGyDarbPmFt5+A0gqiQYtHS/HPoGs3bn7qm/oWu5DVfZwzGuK4Jr
         moog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698361342; x=1698966142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VMHg2dbZC6m4HFrqo+Py57nY4d2BX9cNIAaKURpnOA=;
        b=FDw8uDnVx7IG3cSwpaHjqLbRnSWUc2xmQJIL+gAnur5uMVuSHwiWV8xK/O8zBHNDQ1
         uCV8HUxgsYvrRNvizbP0qFtLF8Ubyg0S/CwkHi8r/r28QKUETxIFWLetl2amhy6edfUX
         FzbuDhZuRA7Ef0XVx89UebgWajLa00Mbl0idRvcTWxVktBBkd7GQWourPDWQeNQ3odyj
         84TyWRZk8PT/lTzQldnZVfbj1lbamRFk77d+jm7guNHZNJ74g24kbA7h4M45rgYw7OO7
         hsAX4Ox21qPW9kYExE5oK5yPJkjMjTYFQAsz8a0RqVdexynZ60XJQJ5jX4Zrld9/Laa0
         l7UQ==
X-Gm-Message-State: AOJu0Yw/vCeh3+69alypafa6blWTWLD64XKhLfHRKIwJXmzmdz2C5CfK
        clZxJXhGLZ6x1mwAPsFEVN4=
X-Google-Smtp-Source: AGHT+IGHVcvHzGB2Z/WdoFN0mPwuW9c5skY/VQkMsVlC+4qBJ41bb+OaI8ONZFB8/0IU9rF8Zo9qmA==
X-Received: by 2002:a05:6a20:728f:b0:135:1af6:9a01 with SMTP id o15-20020a056a20728f00b001351af69a01mr1546913pzk.8.1698361342523;
        Thu, 26 Oct 2023 16:02:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k19-20020aa79733000000b006be2927ca7esm118854pfg.85.2023.10.26.16.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 16:02:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0bd4fede-2d11-c781-98af-5a27ba454346@roeck-us.net>
Date:   Thu, 26 Oct 2023 16:02:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] hwmon: (pmbus/max31785) Add delay between bus accesses
Content-Language: en-US
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>, joel@jms.id.au,
        andrew@aj.id.au, eajames@linux.ibm.com, ninad@linux.ibm.com,
        jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231026221708.1582518-1-lakshmiy@us.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20231026221708.1582518-1-lakshmiy@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 15:17, Lakshmi Yadlapati wrote:
> The MAX31785 has shown erratic behaviour across multiple system
> designs, unexpectedly clock stretching and NAKing transactions.
> 
> Experimentation shows that this seems to be triggered by a register access
> directly back to back with a previous register write. Experimentation also
> shows that inserting a small delay after register writes makes the issue go
> away.
> 
> Use a similar solution to what the max15301 driver does to solve the same
> problem. Create a custom set of bus read and write functions that make sure
> that the delay is added.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
> V3 -> V4: Fixed warnings realted to this commit

I also asked about the use of udelay() instead of usleep_range() or fsleep().
I see you did not change the code. Fine, but please explain why the use of
udelay() instead of the alternative is desirable or needed here, and don't
just ignore review feedback.

Thanks,
Guenter

