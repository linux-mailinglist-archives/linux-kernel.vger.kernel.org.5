Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FFB7CB134
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjJPRTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPRTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:19:47 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0899B9F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:19:44 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a24c86aae3so57918439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697476783; x=1698081583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgUa+mKvmsmGKgSXxgXS6XuuY5vQ/8sgjMNQWn66qJU=;
        b=ZAgpocJEXXYkm5caiZ4CN5fHG0ZSWLSXEMEztK+uOTyjLaleHYlZv7xdtNvdSCwCg2
         iMKfbhtopRFsabF0LDQ3GFWRBNaV9YtqfI2g1olPMxEWp7WcmkdE4iGYlDzFYRJ0zqwL
         APMZM31DZMdAKAt6KFELS5NVdlvfsWWftF75E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697476783; x=1698081583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgUa+mKvmsmGKgSXxgXS6XuuY5vQ/8sgjMNQWn66qJU=;
        b=bJ4m71Git9nEaYNrlncM4NNICwqehtx6gnWVv0qQ1m61055yFlbSWOFCm7f1XwmsIS
         cJ7/CuLta6TErZ4/AcJWnj7CPk3K1NbpqGYPz40o/8wuG4ssC9E8DuAE5LddlzUMyswp
         krvjNMIObHjg96g51u6QUsv4WdlYYwSoF+buyHyLUY9KGq6H4jPY+jxo+kN1+j25GGAC
         w+EX6XV3TZWfx5Hosxo6lDB0iSoMimcD/tB9ijO50TCowHH+oaeRa7ViORz1S0ChTpsy
         J+sp8ZEoSyaN+1k/Cs5O9bF8/1Jd4IHha06CK1t/BRPpbF636/sEKfClxEcqwY4dXM6+
         qAXg==
X-Gm-Message-State: AOJu0YyzU1wmngiamFklnUlgb0O1bQU4wwdG0hPfqeGm08lCngmr4zPw
        PyxwT6TFilpNl6H1uQs4NFCVp/9UqDOD1AIS2ts=
X-Google-Smtp-Source: AGHT+IH01KOJB7womZ3bhd3IAY5anUtTZrEzFuuJ1qqL/RrjkhKbEMdf0j89Pwsvv9woipq/08kmpQ==
X-Received: by 2002:a92:cac7:0:b0:351:54db:c1bc with SMTP id m7-20020a92cac7000000b0035154dbc1bcmr98759ilq.0.1697476783349;
        Mon, 16 Oct 2023 10:19:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r2-20020a92c502000000b00350b7a9f0c1sm3498858ilg.62.2023.10.16.10.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 10:19:42 -0700 (PDT)
Message-ID: <8328df87-67d0-43a8-aa6a-4b9587089e3a@linuxfoundation.org>
Date:   Mon, 16 Oct 2023 11:19:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] usb/usbip: fix wrong data added to platform
 device
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hongren Zheng <i@zenithal.me>
Cc:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, Shuah Khan <skhan@linuxfoundation.org>
References: <ZSpHPCaQ5DDA9Ysl@Sun> <ZSzo816RQEP1ha/l@smile.fi.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZSzo816RQEP1ha/l@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 01:40, Andy Shevchenko wrote:
> On Sat, Oct 14, 2023 at 03:46:04PM +0800, Hongren Zheng wrote:
>> .data of platform_device_info will be copied into .platform_data of
>> struct device via platform_device_add_data.
> 
> platform_device_add_data()
> 
>> However, vhcis[i] contains a spinlock, is dynamically allocated and
>> used by other code, so it is not meant to be copied. The workaround
>> was to use void *vhci as an agent, but it was removed in the commit
>> suggested below.
>>
>> This patch adds back the workaround and changes the way of using
>> platform_data accordingly.
> 
> Good learning to me, thank you for the fix!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Thank you both.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
