Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD35D75A4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjGTDXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjGTDXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:23:02 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E74F92;
        Wed, 19 Jul 2023 20:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=IY+RAcc1GIlfkxtLHhXfiV6sRGLtLR6DNqK46NMbrwg=;
        b=InoTSa1nthHTskV/3OhpZy5KvDbQi69GsoTuARVtap3P9xlNy0klQsXf5E+nl7
        Z3fvVp/7wSU/+XMZsoDfUYsGvsmu6y1CS5ujDlIouJOQBRa5oIaVjsbKfQY/u0PW
        aegiDYQpxbvKTcVDzTbx61ltQ54ID++PbYIaZ6N+2G7Mc=
Received: from [172.20.10.2] (unknown [39.144.138.239])
        by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wA3Le70pLhk5wATAw--.40526S3;
        Thu, 20 Jul 2023 11:07:39 +0800 (CST)
Message-ID: <7b8435c9-36ad-9b69-7357-94cb5fcadc99@163.com>
Date:   Thu, 2 Mar 2023 21:48:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, henning.schild@siemens.com,
        xingtong.wu@siemens.com
References: <20230529025011.2806-1-xingtong_wu@163.com>
 <20230529025011.2806-2-xingtong_wu@163.com>
 <CACRpkdaLyEmdhutqsMUoV3ObW8bFePtNGHFqr5qiKV3w0ripug@mail.gmail.com>
From:   "xingtong.wu" <xingtong_wu@163.com>
In-Reply-To: <CACRpkdaLyEmdhutqsMUoV3ObW8bFePtNGHFqr5qiKV3w0ripug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3Le70pLhk5wATAw--.40526S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr1fZF47ZF18uF18uw1DGFg_yoWxCFg_ur
        4I9Fn7Jr48GF47Ca909F4kGr4SqFykXF1DCr9xtr4fZw15AF1rKan5JrZ2gF12g3WUCFyS
        gFna9F1Iyry7XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU80_M3UUUUU==
X-Originating-IP: [39.144.138.239]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbCfgSy0GDcOxu-gAAAs7
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/29 21:02, Linus Walleij wrote:
> On Mon, May 29, 2023 at 4:55 AM <xingtong_wu@163.com> wrote:
> 
>> From: "xingtong.wu" <xingtong.wu@siemens.com>
>>
>> switch pin base from static to automatic allocation to
>> avoid conflicts and align with other gpio chip drivers
>>
>> Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> If this platform does not have a ton of userspace using the obsolete
> sysfs this should be fine to apply. I say let's apply and see what happens.
> 
> Yours,
> Linus Walleij

Hi

Seems it has been a while since our last discussion, I guess it might
be fit in.

-- XingTong Wu

