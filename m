Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D0E7C9CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 02:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjJPAFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 20:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJPAFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 20:05:40 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2406FAD;
        Sun, 15 Oct 2023 17:05:38 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35743e88193so16078405ab.3;
        Sun, 15 Oct 2023 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697414737; x=1698019537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=taL7RPzKlYgh9tFywV2JSrqs1p7sXQbwE3+YuDDOXmI=;
        b=b7C7EVGbq/V4YsQW68uaEqXvUlOyg/4T/bYTL+RdKeV35p197JYYhscfcc6LZk8RKU
         7Xix21Cyxr5NEOKX9iZBYpAWkqN1WXeHgZi0oPZ6Q8xxZdlTNV8cGLAztRmA+PX5/bUW
         iht3tScapoU9oR04kPFD5xvRNV1HcbOWRYvVAvMW/r48PulASWm2HFIC3AMa+s4/Xs2N
         cvQAL7zgECN+xF19wqe+EziS91aqiyU03tL5ImbanrTa01PQFpG3+L9VZHTHJIJkvKWU
         GVaptnb2jkgAgn3ClU/g7tnd25hu/iU8QnHw9fF4zk5ImCt3KgCHhL7rHw1LlfZabdbT
         RjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697414737; x=1698019537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taL7RPzKlYgh9tFywV2JSrqs1p7sXQbwE3+YuDDOXmI=;
        b=lr8rOevNny//e31fzZ10hNUO9JW5m25AFZNusDVK5R1GPKN7I8O7paMDqoeQleryHT
         DUNKguN15sDFGaPRk6j9D5JUOhPFnzrodAra+0aUsT0zF4bQHoQiVswF4kQHjxGBb2oH
         LnUSH09fy6qzp8FjRPw0rO9NlUZ0nCHKN05uDLwqhlvJ25gYgDyS/q0u0NFvXw9eMfHo
         dTPg3XUBf4qPw9Ja+8pn0ij5jtfyAs3146J4jFPzMZD7jbs6jD9tH9ww0cpD1lUutWB5
         YorqfjaPn0pB4t/7u33JiCA5TanaAzKjgo3qmq1Ht3YhBm9ov/+w5q7wPHjncqp0x5tE
         Lriw==
X-Gm-Message-State: AOJu0YxteepENBPtyb3DRxQafFoYqIkDge2fXK3lQhbGbQlZ6d4MtByp
        bFCmk2XVKZHZkHmFSPvocD++mXgqP8w=
X-Google-Smtp-Source: AGHT+IHKzJRoxBsHpaDyGVn5V6QkiXFqQwLP9PFj2Y+rSUuwf7RfhiU89NI6I9sVRWp8sZgjV3yttQ==
X-Received: by 2002:a05:6e02:1354:b0:351:1311:c282 with SMTP id k20-20020a056e02135400b003511311c282mr29854195ilr.9.1697414737351;
        Sun, 15 Oct 2023 17:05:37 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id i130-20020a639d88000000b00578b8fab907sm2570541pgd.73.2023.10.15.17.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 17:05:36 -0700 (PDT)
Message-ID: <17f76abc-e247-4dda-894e-1caa28411fe6@gmail.com>
Date:   Mon, 16 Oct 2023 07:05:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Mat Martineau <martineau@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jesper Juhl <jesperjuhl76@gmail.com>
References: <20231013014010.18338-1-bagasdotme@gmail.com>
 <20231013014010.18338-2-bagasdotme@gmail.com>
 <20231013174813.5ccc3744@kernel.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20231013174813.5ccc3744@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2023 07:48, Jakub Kicinski wrote:
> On Fri, 13 Oct 2023 08:40:08 +0700 Bagas Sanjaya wrote:
>> Emails to him bounce with 550 error code:
>>
>> ```
>> 5.1.0 - Unknown address error 550-'5.1.1 <m.chetan.kumar@linux.intel.com>: Recipient address rejected: User unknown in virtual mailbox table'
>> ```
>>
>> It looks like he had left Intel, so move him to CREDITS.
> 
> The driver was very likely written by an entire team of people.
> I wouldn't bother with CREDITS. Also I think you have the entry
> in the wrong place. It's alphabetical by surname.

Will fix up in the v2, thanks!

-- 
An old man doll... just what I always wanted! - Clara

