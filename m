Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D578459C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbjHVPc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbjHVPcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:32:24 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F810E4A;
        Tue, 22 Aug 2023 08:32:12 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-68a3582c04fso1708185b3a.1;
        Tue, 22 Aug 2023 08:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718332; x=1693323132;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8wZdxWbycC9I8GX1y8VIxcmurfgvtjAzcfBkiFKhZg=;
        b=AV3t433BSMWzJOZL9db+31Ubw9RsY7daY7xNQWsGgEEc7LPpczrx5w9GU7KcqXct5T
         mdpFoYS91f/5PIuJOUYpc7O9JcH6uOdd9k6xEAhJaQriZ0j57rHCykQiDysgupYFcDr/
         mfFsoN0jFuEpMUjsO6pQRjM64iQKd87RQ9WoKgfzezJMAB/XFAhjtnRyyB0Jm0mPW0Pr
         A0N2ULWIS+8DWIDTJ12HfU/d6JrSKVp0JYxXqVh/MqCybaoQ4wcDK1Z25ayrTJ7RMMpJ
         wu6NlOXxYGF3x6x9HEjzeWIrRBEEOpmFDWhlIKK+P24lJvAi/hF+nosmBqPL0gGk4dkq
         oDJQ==
X-Gm-Message-State: AOJu0Yy+W4gsTmDUoG/UXuO5Gt28jFpVG4zgJ8d87Ff1IMM1HE7IuO69
        ZwRPAmWqHdunGeFJG1io6JQ=
X-Google-Smtp-Source: AGHT+IE+MpF+/WhYsbWd1rZf45WT+vbjRO7NWBn8H7z6pdMPZGByeujeTWlmLnRDAXa5LGdI2seSew==
X-Received: by 2002:a05:6a20:454:b0:149:5195:c94a with SMTP id b20-20020a056a20045400b001495195c94amr3394451pzb.56.1692718331898;
        Tue, 22 Aug 2023 08:32:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:88be:bf57:de29:7cc? ([2620:15c:211:201:88be:bf57:de29:7cc])
        by smtp.gmail.com with ESMTPSA id a21-20020aa780d5000000b00689f10adef9sm8015666pfn.67.2023.08.22.08.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:32:11 -0700 (PDT)
Message-ID: <faf37166-5194-a907-686e-ecf7a7a328d0@acm.org>
Date:   Tue, 22 Aug 2023 08:32:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH -next v2] scsi: Remove raid_component_add()
Content-Language: en-US
To:     Zhu Wang <wangzhu9@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, john.g.garry@oracle.com,
        bblock@linux.ibm.com, dan.carpenter@linaro.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230822015254.184270-1-wangzhu9@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230822015254.184270-1-wangzhu9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 18:52, Zhu Wang wrote:
> The raid_component_add() function was added to the kernel tree via
> patch "[SCSI] embryonic RAID class" (2005). Remove this function since
> it never has had any callers in the Linux kernel. And also
> raid_component_release is only used in raid_component_add(), so it is
> also removed.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
