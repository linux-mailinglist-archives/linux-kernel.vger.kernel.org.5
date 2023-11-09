Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BAA7E6FAE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344171AbjKIQvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbjKIQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:51:03 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4458E1FD6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:51:01 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a6889f33b9so37669139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 08:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1699548660; x=1700153460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PG9M5IVX+twC/myn0L7liPfYhahLJKBqAQG1eqriSRk=;
        b=wrDBAtpohcNkfyYS06BN5InXnduQFCHVCj1eUOrw8WdXnPcwgE6hffX5UIFSQbfF2A
         81RxdlXt4FOQ/u9qSp80KOrqOjecTz2SvXA95KHZzCNZnA+uynCJoAZjE/uKosf3igKj
         PNndqr9gR7JdRC6si7u4NvHEnkB5Y8c01HIm+EhYdEjaCpKCHaztSiZZJdHc8/GsfLlT
         zD1hipfyghXjHC9Ki2uPngmyBA2wFFjaiGW2nsJAOnYFagccsegdTM6/++Rj/veyzX+z
         I22L4EY3IlEqDZHq4LQaTiWtdHe6MtLaiq0WtQDypDkw3jClSpCu9eivwSbjaG/BPLV3
         cLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699548660; x=1700153460;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PG9M5IVX+twC/myn0L7liPfYhahLJKBqAQG1eqriSRk=;
        b=Yxn3LRjSYt5I329YvR/niBIMuUTiU4SdP5BUpeaz3kUApp3GFRpLgL3IUEkxm95k/d
         Zqn3hkBtuhrNWNR956Va2ZTDi6MGbiimJilWh5UwgIHUJw/Ce7zxDYlyNNqLMx0zl4HZ
         e6Oxc/iPoeX80yxI2L5Rzsmu+BGWfiksYcf+Zkep8azyUaFX7b5T+yf5AbG0H2+AVnIk
         jfXz7r1Y9VN9fh2yAAiO1+4Zncq52j8TqnOR77AsxJpeGBuihzzZMQhnp2EXlCQzgBI7
         MQx9AtAc/Yqkk5e4M8/Rn/oJ/H0jfHizV74PxEgra6LvlcNPCjBTJ5ykVlwgeUTrJBan
         1zLg==
X-Gm-Message-State: AOJu0YxuRJgSDGXmcHquROjWw6CHQb0hTivwaGAhbWbbk8FQs985h9aa
        Vo5/ym4GM+8d4D2jiMuOlt1TYwhuN523HRguVT0=
X-Google-Smtp-Source: AGHT+IHWG1XdSu0eM8cVfiGQr0AIcATpnXyhB2eEO39KPVHg2UCcsKGwJIBGMOXoIwa9Fzk6UMPy8w==
X-Received: by 2002:a5d:870a:0:b0:7aa:125a:b0c4 with SMTP id u10-20020a5d870a000000b007aa125ab0c4mr2557520iom.5.1699548660666;
        Thu, 09 Nov 2023 08:51:00 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id z19-20020a6b6513000000b007911db1e6f4sm4210476iob.44.2023.11.09.08.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 08:51:00 -0800 (PST)
Message-ID: <446f4f85-feb9-3071-9445-d6b6cf74f476@landley.net>
Date:   Thu, 9 Nov 2023 10:55:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] fix rootfstype=tmpfs
Content-Language: en-US
From:   Rob Landley <rob@landley.net>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
 <8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net>
 <f9d57ae7-6dd6-4854-b9cf-1eec4cfa2a92@linux.ibm.com>
 <b74ea810-5b6c-404d-8cee-7d3d3922205e@linux.ibm.com>
 <8f027b47-e778-15fc-0306-a5ae094f1070@landley.net>
 <c70e31a5-35fa-a6f8-923a-61909e6a1b6b@landley.net>
In-Reply-To: <c70e31a5-35fa-a6f8-923a-61909e6a1b6b@landley.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/23 10:46, Rob Landley wrote:
> On 11/9/23 10:42, Rob Landley wrote:
>> On 11/8/23 16:05, Stefan Berger wrote:
>>> Can you repost this patch or should I do it?
>> 
>> They're more likely to listen to you.
> 
> P.S. I have a pile of local kernel patches (accidentally attached to the
> _previous_ message, but decided this part was not good to post to lkml)

Thank you, Thunderbird, for not actually updating the "to" list with changes
you've made until you click away to give focus to a different GUI field, and
clicking "send" does not count.

Rob
