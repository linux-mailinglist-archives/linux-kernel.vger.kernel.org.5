Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3646B7A6993
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjISRZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISRY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:24:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB404A6;
        Tue, 19 Sep 2023 10:24:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c44c7dbaf9so33575905ad.1;
        Tue, 19 Sep 2023 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695144293; x=1695749093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/N2md2M7nXWWXpgrRbLMOxtkw920HRjxh6JKIMeSsI0=;
        b=EVYxHIX3inL8h6qaQFyqpExPgbxwpEaAvJmPkCQbm+YstMemDgltulCA0R6WZCAsNm
         lrXNOpGacT1DdiBSk/yMDY3d7dIr21nhF2KmSaSbRbIvwtflV6mNeXXBwqGNqdIFPRGf
         v0Gvj/8fIxdHvjheuOI1cH+TZrJik3+nKnUvmauZZS1pjIcDSRzJhUR6ErFU3uki8YTH
         2D0RsiygEUhBWO3+emJiELRCwWDxq3WKUbga2lrwY3LwBQ8FbhvXDfAfu9T5R2f6Cc5G
         jRtXTQj3cD16nBHj7sfW57k1o1r8K7QatkLfPc0cr12jhR54VPuBhLfaN/A0pFP32h4G
         MVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695144293; x=1695749093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/N2md2M7nXWWXpgrRbLMOxtkw920HRjxh6JKIMeSsI0=;
        b=Ih0j7S0ZeznRgL2bLEC9+KxXHQ4ZBqQdr8pXmwl90WW28ePXxS5WwQarLsroBBA2Kn
         OR3zc6fTj7Fx2gI/u7LvPSfKFjVoTjCA3zZvYNJEqvv2THDlbZWroORU6t1PZxooSfLr
         WbEe+E4Ewd5ZhJ5w8aU7tWgUZDPSrSs3rMDL139PfWQK6KHz4t7iM0lWlqQIbfDTEH3B
         tLdwR0Doz7JOk1XvvvzhsUSwNJcyVRCPvETbF9Z5HBBzWROFH0dzSrgBTXgxN/CdMWci
         1ZE4wU3X+iZRk7dRZyltG6pvqoyW69rGIs0HWdq3EY6lG2kP/piBQri0F8PvFuRrUIBY
         wtbA==
X-Gm-Message-State: AOJu0YxlOAzjkgXHq9+uT9deb8E8B/MpmXMia3Tf+XV3zsEcP0XYjZRO
        Rf3dUCUUzTnn+OZ9oCn+J6pgE0hIEp4=
X-Google-Smtp-Source: AGHT+IG5E5w8H/vrWfUsBTBuCJewzcS7QTCc/rhYKyLI29acjO52zzP9Um+4l6uHORhmCGPREDEFOw==
X-Received: by 2002:a17:902:d4c4:b0:1bf:2e5c:7367 with SMTP id o4-20020a170902d4c400b001bf2e5c7367mr86736plg.42.1695144293110;
        Tue, 19 Sep 2023 10:24:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id li11-20020a170903294b00b001b89466a5f4sm10258021plb.105.2023.09.19.10.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 10:24:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9925e0a8-3793-9785-5b43-9811c66a890e@roeck-us.net>
Date:   Tue, 19 Sep 2023 10:24:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] hwmon: powerz: add support for ChargerLAB KM002C
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>
References: <20230911-powerz-km002c-v1-1-898bd79b9bae@weissschuh.net>
 <6e5eff10-949c-4f17-a3f3-347b85b89e11@roeck-us.net>
 <5fb278c7-df91-4f02-ab5f-baa47d27507f@t-8ch.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <5fb278c7-df91-4f02-ab5f-baa47d27507f@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/23 10:15, Thomas Weißschuh wrote:
> On 2023-09-18 12:05:19-0700, Guenter Roeck wrote:
>> On Mon, Sep 11, 2023 at 07:44:42AM +0200, Thomas Weißschuh wrote:
>>> The KM002C is similar to the KM003C and seems to use the same
>>> protocol and firmware.
>>>
>>> Reported-by: Douglas Gilbert <dgilbert@interlog.com>
>>> Closes: https://lore.kernel.org/lkml/290ebce4-54f0-8ac1-2a13-cbc806d80d64@interlog.com/
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>> ---
>>>
>>> This patch is based on hwmon-next,
>>> commit 80369d9e1f2f ("hwmon: (sch5627) Document behaviour of limit registers").
>>>
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>
>> Applied, but please be more careful with your comments and Signed-off-by:
>> tags. There should only be one '---', and one signature.
> 
> Thanks,
> 
> the duplicate Signed-off-by is indeed an oversight which I'll
> try to avoid in the future.
> 
> As for the '---':
> 
> Two of them are generated by the 'b4' tool and I added one manually with
> the hwmon-next information.
> For other subsystems this wasn't an issue so far.
> 
> Are these duplicate sections a problem for your personal tooling or is
> it affecting something more widespread?
> 

I don't know. All I know is that checkpatch complained about the double signature,
which causes my scripts to fail. I don't know what "git am" does if it encounters
a double "---" because my scripts bailed out due to the double signature.

Guenter

