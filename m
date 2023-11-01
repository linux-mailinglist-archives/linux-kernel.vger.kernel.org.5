Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42FD7DE05A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjKALbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbjKALbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:31:05 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51617118
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:31:02 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b2e07e5f3aso401503b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1698838261; x=1699443061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7w7rHXdxJsTAPtxDtkO0qqvwbI0NeIxQPhYEpYhUbaA=;
        b=G6XM+h9c65QqoRqcxkWpnB5Hg/qk+HGYAZHnDSIi5i2Iz1aAtnAXUbeWwi7tqdLvbL
         EalKkALDKRU4HjdmJcWzMVN4jhREl6tQ5sucDuQ0SwPrkj/gkwR8S2BqdmKXb2Y7jcrx
         1H3rzLYC1+rTUkfhPB8lsRATvHVof0FgRkuGxiXd1OY4uzt2BI8lv3XRiJJHJwSlQbVN
         85ldGQFxIxcOVtyBBb5rWLgA+g+qq8kGflSAFfg1Bj9nfaQYdKw9yeBfeBPfzuqJswY7
         k98E3yrHDyW8o38kEuqSimOGWMrp1wNiwqCyaJF5l74anHi0pD5Z1Gyiwsdco4yvf0CJ
         0+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698838261; x=1699443061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7w7rHXdxJsTAPtxDtkO0qqvwbI0NeIxQPhYEpYhUbaA=;
        b=jlA+0DRrqPeaWqSA6/ACzPsQLcUftWxpoNVclAWXkb5eJGEr6ewpmgnI6JPWfQZCpI
         2fTk8HIhAODojzQTjN6NqKlUOUmzp49tabA0O3aTv1d3g0IVBjDv4YIFNb5zFwdTRPef
         FCKfXJsxZxPBC27ukKTZKq9pjtQ00uUt3iSP/0dHMjhLQMOYjrRc9nBUkvM3ue2J2z9j
         cLlA2MK6qlyq2DV7Jw4j7s2VnUT+hAzK7vZae6ym9l+yysDa9erRT/Pll3IVAi8PFGF1
         hdeioNOpNubHSl6pSJ78t00OQPDy22eSPD0qW+E6H/8rsdJAeCoY85Lw/OTjR+Sd41/6
         Z2ag==
X-Gm-Message-State: AOJu0YwmtFx62/zAi6KjuSsPZ+Jjj/ImG7Y7a7GkXM/tVywmKhmLuj21
        nK2X2XbhWSYqqNHBUkcAtc76bg==
X-Google-Smtp-Source: AGHT+IFv8hoy1YDJ+q0bLje33i9CAr6/4EiUblM7nbH8gGbqCkuhruAE2/GxxYnXoLSnKJqalt8PEA==
X-Received: by 2002:a05:6808:1886:b0:3b2:db24:637d with SMTP id bi6-20020a056808188600b003b2db24637dmr3104105oib.14.1698838261592;
        Wed, 01 Nov 2023 04:31:01 -0700 (PDT)
Received: from [192.168.1.4] ([136.62.51.249])
        by smtp.gmail.com with ESMTPSA id m11-20020a056808024b00b003af732a2054sm190494oie.57.2023.11.01.04.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 04:31:01 -0700 (PDT)
Message-ID: <6dae6aa6-e6c6-89d6-f9d7-7563708f7662@landley.net>
Date:   Wed, 1 Nov 2023 06:35:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] rootfs: Use tmpfs for rootfs even if root= is given
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>
References: <20231031154417.621742-1-stefanb@linux.ibm.com>
 <2023103159-punctuate-amount-f09d@gregkh>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <2023103159-punctuate-amount-f09d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 11:56, Greg Kroah-Hartman wrote:
> On Tue, Oct 31, 2023 at 11:44:17AM -0400, Stefan Berger wrote:
>> rootfs currently does not use tmpfs if the root= boot option is passed
>> even though the documentation about rootfs (added in 6e19eded3684) in
>> Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
>> 
>>   If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
>>   default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
>>   line.
> 
> At this point in time, is there even any difference between ramfs and
> tmpfs anymore?  Why would you want to choose one over the other here?

I submitted a patch to fix this to the list multiple times, which got ignored as
always. Most recently here:

https://lore.kernel.org/lkml/8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net/

Rob
