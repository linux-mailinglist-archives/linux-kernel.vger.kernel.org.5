Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4407C86D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjJMN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJMN2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:28:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9755CC0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:28:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27d153c7f00so1522719a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697203720; x=1697808520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nu1H4LZBKYsS6+OEzpbpZBdBf+RzObohI0qR4WVPoqc=;
        b=FXOtomZy9YwNlo4HJoG+HhwuUU5t9aDSQz6bMJ8T0WIMYgskhLzgDOjuH3/HFWJHPw
         GOXVciOEUtGHFQo26XItQAVC4DT3RG4/dndmH3epA44UdQAfzDD/E8PbKTQblr4YQak8
         KQ5hxuqxUaRXaIYA9KM10x79wCNMfeoAdiQcqR24GVvdF5y1jp7gYDrNsQGh3lgATD6J
         l8NximvSp5XfH7g9WFG5sVnpy/vL5kTnw6GSZsQiLxiNdlQ1m4AO4LxUHL+oiyXDy9WH
         aZBslZNuOZQ+gx17nwkL1tOhNWeS7ljWyZjlQndP1CiUVmEMunBp9InDVFLRQrnRRiJu
         9YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697203720; x=1697808520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nu1H4LZBKYsS6+OEzpbpZBdBf+RzObohI0qR4WVPoqc=;
        b=sXa6ebiF9bSzBXLQaOZt4qySmaFh42hrt5JmYCQW1cE1U6Sgzy+pNBenIfn2WKF3pU
         ebzK9eY7jl78qwYulobTB+BUlNJhQug2zrpjBGTmU9GDfdfTe0de93ypCLOvdbkYHJR/
         ZloXbtjLoxhURBUsiocjTF33DQtREjYXfwfZDFJKqRDJyVx+sus+2fiL5siCZt0AQrEj
         Lz3JIhHtTfyyh+Zn/qjZAoDtHCZ2ZPGwzZyy7JtrC+eUEXAkpOPOU8QaOgavWNEapEEw
         lgpZkjIJESbV5KPGNqlC3Hz+xqsYSpYVh2FxWUxlziM/FMRVLOlJrpHvadg44UwnzR44
         nfKg==
X-Gm-Message-State: AOJu0YzEGc8JygtPt9jsqNzzElSrdVNb6OpPiyb9sNJxTLW6EE4cx1ba
        4oAm4Sqpm0QiIMwu4icJrcI=
X-Google-Smtp-Source: AGHT+IEJYovCWvXgqaaiHkZHtiuMbMUnM92EYMOFfSzfvM9khXLAwSVNGYupln1fYCNkdGfuH3CsIg==
X-Received: by 2002:a17:90a:b00a:b0:268:3b8b:140d with SMTP id x10-20020a17090ab00a00b002683b8b140dmr21495491pjq.35.1697203719841;
        Fri, 13 Oct 2023 06:28:39 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a1a5d00b0027d0de51454sm94071pjl.19.2023.10.13.06.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 06:28:39 -0700 (PDT)
Message-ID: <05a668db-118c-4568-b2cf-49febb04a6d2@gmail.com>
Date:   Fri, 13 Oct 2023 20:28:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] staging: wlan-ng: replace strncpy() with strscpy()
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
References: <ZSkm34Sy/n2yxBqi@lab-ubuntu>
 <ce6c3d81-d75d-40e7-a6df-7abd4e8250a5@kadam.mountain>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ce6c3d81-d75d-40e7-a6df-7abd4e8250a5@kadam.mountain>
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

On 13/10/2023 18:19, Dan Carpenter wrote:
> On Fri, Oct 13, 2023 at 02:15:43PM +0300, Calvince Otieno wrote:
>> Checkpatch suggests the use of strscpy() instead of strncpy().
>> The advantages are that it always adds a NUL terminator and it prevents
>> a read overflow if the src string is not properly terminated. One
>> potential disadvantage is that it doesn't zero pad the string like
>> strncpy() does.
>> In this code, strscpy() and strncpy() are equivalent and it does not
>> affect runtime behavior. The string is zeroed on the line before
>> using memset(). The resulting string was always NUL terminated and
>> PRISM2_USB_FWFILE is string literal "prism2_ru.fw" so it's NUL
>> terminated.
>> However, even though using strscpy() does not fix any bugs, it's
>> still nicer and makes checkpatch happy.
>>
>> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
>> ---
> 
> It's still white space damaged and can't apply.  :/  Try save the email
> and do `cat raw_email.txt | patch -p1`.
> 

And better yet, use git-send-email(1) to send patches. But don't rush,
as you have sent five versions of this patch today. Please wait for a day
to a week and then reroll.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

