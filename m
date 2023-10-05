Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D371D7BAB53
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjJEUPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjJEUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:15:35 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0B693
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:15:34 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3526ac53d43so736675ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696536933; x=1697141733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZWU1jh6kLxBzwElgHKJhAQR+SgjwYSyaey/BpJmCxQQ=;
        b=R06UfeIdAEgbhZspOtkXphL5a+v5hmPCN7+J8tlRKkw/ZY3vtRbsJbYAVQzon12Gz1
         QllTW4RQzs43xPemxqeN8R/mt1F+oDS88LygQ0LOpWPvhIFk5C0k/UsBsQLddmv9sP7N
         D5zs4zXNj524lqv0NDBFbzgR3CTKx7aG0zBo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696536933; x=1697141733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWU1jh6kLxBzwElgHKJhAQR+SgjwYSyaey/BpJmCxQQ=;
        b=erPZaOQUuFApCdqxdwiE5GfuY9hH7H8AUSJM+MLQou8zsRtodP7YYWYbMDY6KNATyx
         QwvOX7rBQCSqEh9IPV9SE9BUWVN2iN7xXCWuN+pk0FSqW/MFkN0hSya5PN1Gs2BqgTgL
         EC0JAuEab8eAgbfVpUoWlXuQNvyJ4CZreXFsXfggmAmM/4LN7y0AwRdh2ITTf1v8UKHb
         wIyagFpu9k+8vb4cZtTrravYIKvJA+OHawjCnH5lXqvC33l1BVoTS8L/FJ0U3g5H9Ilx
         +Gq+Jn8Vmm1uxcvhS6KON9dbdSKWvo2bY2VAsNpqmGlrqDrhL9G5E2JHAKFpiiEVEvX8
         Z00w==
X-Gm-Message-State: AOJu0YzRdIXdMnsPvErg2HuMPUZ2VjsYv43Mmvtjlb5XO6z1XgYnIpdm
        zSChg2oPVUVcFhyI9rkFdEJQM6SHAnbPkSJwwmI=
X-Google-Smtp-Source: AGHT+IE+/ETaJWAyImZckWEMwZ3oZQENDP8tukq1mLI91+s5QPd24lTP9NiCT6rcqn5Ylkj2EaO9Ew==
X-Received: by 2002:a92:cf41:0:b0:351:54db:c1c9 with SMTP id c1-20020a92cf41000000b0035154dbc1c9mr6165039ilr.1.1696536933102;
        Thu, 05 Oct 2023 13:15:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t22-20020a028796000000b00430245071ddsm144232jai.176.2023.10.05.13.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 13:15:32 -0700 (PDT)
Message-ID: <dcfa99da-eb3e-4c85-9e7f-092bbb1be801@linuxfoundation.org>
Date:   Thu, 5 Oct 2023 14:15:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nolibc changes since 6.6-rc1 for linux-next
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <11a790c0-f9c0-49eb-b14f-56b962af6d2d@t-8ch.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <11a790c0-f9c0-49eb-b14f-56b962af6d2d@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 10/5/23 11:00, Thomas Weißschuh wrote:
> Hi Shuah,
> 
> I'd like to test the current state of nolibc in linux-next.
> Could pull the request below into your nolibc branch?
> 
> I'll do some manual tests this weekend, too.
> 
> 
> Thanks,
> Thomas
> 
> 
> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> 
>    Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc/next
> 
> for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:
> 
>    tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)

Absolutely. Do you mind tagging and pushing the tag and send
pull request with the tag?

thanks,
-- Shuah
