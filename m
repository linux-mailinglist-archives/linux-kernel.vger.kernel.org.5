Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE067F17FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjKTP7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjKTP7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:59:09 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0434C100
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:59:05 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a66bf80fa3so34055039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700495944; x=1701100744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBubMyXeMdXPmziILbLDJOUb23evjUP9zHHjc1m1UWU=;
        b=kgmA+AVf1bqHdCcIeq04xHRa7SIKk9mZkp0aX9jE6fjDInfjNh1/bkr4ZQjGRs0Vuf
         4WbKUfFUmZyPkW9eoVSTQSKXSBNoEvzfelmquMgjfcr5iIIurskd2j8ZOdrF+CZd/YJJ
         Nvudq3O7pGhAdLOwDFqOJB9KNEuV9NvBiRR/2MB431cqmVUh1X+mKutocpRWzejItpxJ
         fhqqF3zCpc53p8zABT0vvsjSmi1WyT5t8n9KN4NLr0zWEGMw7klF1Uba+bZL0+lzV3gd
         sCes9BBdz54oAMT3xwZJPPRCfAJw0es3VTVVtp0yzGhWLPkQ1qRWWz55ZajBwCg3E34v
         9rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700495944; x=1701100744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBubMyXeMdXPmziILbLDJOUb23evjUP9zHHjc1m1UWU=;
        b=l1iq8FwHN61Qxrr90soKH/aEjoBl2j1c8Xl2Wdc5JcSXN5NlYI84Kzz69xkC2tALPu
         /hkGmUUH/3fwJlHh8/VQLy3SUdNDTdkBZAP3FdDijP4Joffr4hAXw96sBIx2FN7xVtrB
         o7ACoNPowmCOERbEr8PI33NuAC4AQ3tBv3/+ZZhepz4UY41Iy4fpIFxo8EWFtuM6nkSL
         XGbpUjJm/JExWxRTqMfALFheLBJ0k61U+dnbbIviydfB5yJWnTop6u0ndobnRYkYrUBL
         sXkEnMXUnekqSBmzPToDHkuo2NxbZPFKi43L/7ba/Kj8T+QcVur7z55n6cyxo+dDP7bQ
         Gl9A==
X-Gm-Message-State: AOJu0Yy20b4I7kWk6QU+qMa5Hge+IPRzFWnOBIQ0RZe+ShHedqV8nxqE
        5BNgrCjV9mcoQUU74PLKxI3TmA==
X-Google-Smtp-Source: AGHT+IE5IFdCpMdxEiBvnNeLaVyJT3YUK2ggFvrK9aO4Q45E4aJI5sPQZ8IpJpBfrP5cXZo9/UGbnw==
X-Received: by 2002:a92:dc81:0:b0:35b:cd8:7785 with SMTP id c1-20020a92dc81000000b0035b0cd87785mr997896iln.1.1700495944338;
        Mon, 20 Nov 2023 07:59:04 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v10-20020a056e0213ca00b003593297c253sm2522408ilj.75.2023.11.20.07.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 07:59:03 -0800 (PST)
Message-ID: <8818a183-84a3-4460-a8ca-73a366ae6153@kernel.dk>
Date:   Mon, 20 Nov 2023 08:59:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/fs: consider link->flags when getting path for
 LINKAT
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        stable@vger.kernel.org
References: <20231120105545.1209530-1-cmirabil@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231120105545.1209530-1-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/23 3:55 AM, Charles Mirabile wrote:
> In order for `AT_EMPTY_PATH` to work as expected, the fact
> that the user wants that behavior needs to make it to `getname_flags`
> or it will return ENOENT.

Looks good - do you have a liburing test case for this too?

-- 
Jens Axboe


