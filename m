Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723897F1D20
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjKTTJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjKTTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:09:20 -0500
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 11:09:17 PST
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FFBD9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:09:16 -0800 (PST)
Received: from tux.applied-asynchrony.com (p5b07e88b.dip0.t-ipconnect.de [91.7.232.139])
        by mail.itouring.de (Postfix) with ESMTPSA id 94066CF27A5;
        Mon, 20 Nov 2023 20:01:02 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 3AF53F01608;
        Mon, 20 Nov 2023 20:01:02 +0100 (CET)
Subject: Re: [PATCH 5.10 000/191] 5.10.201-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231115204644.490636297@linuxfoundation.org>
 <b5367845-8d70-4fcf-861a-ff9b8849c9c9@roeck-us.net>
 <2023112039-reverse-careless-e646@gregkh>
 <ffd98a9d-6db8-4d1e-b3ab-0c7159f91b6b@roeck-us.net>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <b4ec1c4a-bf03-0a2c-52a3-04e11ffe6c66@applied-asynchrony.com>
Date:   Mon, 20 Nov 2023 20:01:02 +0100
MIME-Version: 1.0
In-Reply-To: <ffd98a9d-6db8-4d1e-b3ab-0c7159f91b6b@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-20 19:17, Guenter Roeck wrote:
> On 11/20/23 02:05, Greg Kroah-Hartman wrote:
>> On Thu, Nov 16, 2023 at 05:13:39PM -0800, Guenter Roeck wrote:
>>> On 11/15/23 12:44, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 5.10.201 release.
>>>> There are 191 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Fri, 17 Nov 2023 20:46:03 +0000.
>>>> Anything received after that time might be too late.
>>>>
>>>
>>> Build results:
>>>     total: 159 pass: 155 fail: 4
>>> Failed builds:
>>>     arm:allmodconfig
>>>     arm64:allmodconfig
>>>     i386:tools/perf
>>>     x86_64:tools/perf
>>> Qemu test results:
>>>     total: 495 pass: 495 fail: 0
>>>
>>> with:
>>>
>>> Building arm64:allmodconfig ... failed
>>> --------------
>>> Error log:
>>> drivers/interconnect/qcom/osm-l3.c:6:10: fatal error: linux/args.h: No such file or directory
>>>
>>> There is no linux/args.h in v5.10.y.
>>>
>>> Caused by "interconnect: qcom: osm-l3: Replace custom implementation of COUNT_ARGS()".
>>
>> Now dropped, thanks.
>>
> 
> v5.10.201 fails to build arm:allmodconfig and arm64:allmodconfig with
> 
> drivers/interconnect/qcom/sc7180.c:158:10: error: 'struct qcom_icc_bcm' has no member named 'enable_mask'
> 

Sam sent a note about that as well, probably got lost in the pile:
https://lore.kernel.org/stable/87fs10k1ee.fsf@gentoo.org/

Looks like it's missing a prerequisite patch.

-h
