Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476107D2837
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjJWB7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjJWB7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:59:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2010CFB
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 18:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Ba2f+0UDqFPeuImgDHgf0xYmLL/b2p92ulH7+tnDnco=; b=gSV5otR4Rf50WVGv6GWWLynHU1
        0ExQmqrApl5JKObVE4o980DVCeKlaWyrmuovRgv67EVov1OlLjeoEXHMcCoMdjyGlYM5vqOJ3OQ8g
        T/lkr5qSp9WMRBXGDePbxLZ4pnF8BTyLn/tUsZxqDUpK//r80E4rhe0J0CgBsGUgvj/rvRAa4sRhL
        u79Zlr8WkpG2kguWLuP7T8AwnfHDORQLvuHSqNZ/6qJgWHxxJxILaCOvZ2GWnMfHzdbrybo/iHHL8
        Iq5CyDaltlmUx1QQS4CsMBqz5kEAQeMu/j97BM+JsrFDyBRfG9Aoazs3kdty+03VdcXhUxeYkSbn3
        pNMgl2sg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qukEI-006DrY-2J;
        Mon, 23 Oct 2023 01:59:42 +0000
Message-ID: <89f666dc-e7b3-44ad-846c-b1f1ee278940@infradead.org>
Date:   Sun, 22 Oct 2023 18:59:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How can I add "busybox sh" as init during boot of the custom
 kernel?
Content-Language: en-US
To:     gmssixty gmssixty <gmssixty@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <CAOx-CDUwV0d0+2UdZW+vdUcjwAg2+Hanf1-iNSYFRWOW2yQugg@mail.gmail.com>
 <6675c47a-d258-41ae-b506-88d7ae74b551@infradead.org>
 <CAOx-CDVn7Ub31yiRpoZh4RhJBCvgZhb8Ca=cH9b0xWPjk5FNQA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAOx-CDVn7Ub31yiRpoZh4RhJBCvgZhb8Ca=cH9b0xWPjk5FNQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Mon, Oct 23, 2023 at 6:15 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 10/22/23 16:56, gmssixty gmssixty wrote:
>>> How can I add "busybox sh" as init during boot of the custom kernel? I
>>> have compiled the kernel and put the bzImage in /dev/sda3 (/mnt/sda3).
>>> Booted that kernel. After booting, I got a message to set the init
>>> process. I have put the busybox in /bin. Now I want to add this
>>> "busybox sh" as an init process. How can I do this?
>>>
>>> Note that, I did not install any other software in that /dev/sda3
>>> (/mnt/sda3). I have only bzImage and busybox.
>>
>> from Documentation/admin-guide/kernel-parameters.txt:
>> (or https://docs.kernel.org/admin-guide/kernel-parameters.html)
>>
>>         init=           [KNL]
>>                         Format: <full_path>
>>                         Run specified binary instead of /sbin/init as init
>>                         process.
>>

On 10/22/23 17:34, gmssixty gmssixty wrote:
> I tried this: init=/bin/busybox sh, but it got Kernel panic and
> failed. On the other hand, what should I write in /sbin/init?
> 

Please don't top-post.

You need a file name after init=.
"/bin/busybox sh" is not a file name AFAIK.

To use /sbin/init, enter
	init=/sbin/init

To use bash (e.g.), enter
	init=/usr/bin/bash

The kernel init code already tries to use /sbin/init if that file is
present, along with /etc/init, /bin/init, and /bin/sh .


-- 
~Randy
