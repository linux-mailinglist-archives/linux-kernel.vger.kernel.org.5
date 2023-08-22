Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3746D78486E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjHVRbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjHVRb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:31:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D568A6E525
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:31:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ff7ecd0a0dso1387406e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692725483; x=1693330283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QfKHgUSTtafoCDv9qIGxx5rTmDvawh/uB7wOQLfeuKA=;
        b=Lm7nygwsiSap6Z09Y/8KweIlb6brFubBzcq23SZTWxfuTRXe+8kS4e0IYA410F/OgF
         qC7nrZ1hp+zP6GtYf68mpBc3B/gyxRikAbFZpeko/66y1kZzTKA5KyjjC7nQMFuzuwae
         WLcXo0tKqn1TNQabSXTgFYs42Qihic5AYYfkJmJqZ/HnZjan68yxxNvXYryMaK0kCtF5
         09shWohCJRUizhD28gKpGgjoMSUt+4clMPfBG3l73cDJxLPtpNyIolPJxxdlhExNCX3T
         rGGmOwXDkUcNt8zJqAxzhfiJPRpWZxopd8Cu8r4CHGqZP2wmSg0uD8yJbRSEotXGuZJ6
         V1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692725483; x=1693330283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QfKHgUSTtafoCDv9qIGxx5rTmDvawh/uB7wOQLfeuKA=;
        b=aO3QOwYnlDHOI23Fooz7OXOtd9hdAwoEMq/bcSP+Iw71E2BHltzhSfM6Q4nBH/KtT8
         wM94Sg3MgnL3FQuHjStWmM48JFjF7RLTm734TE+MkBor8mrOiayKMnLailUcGSXIa5W9
         BJaDhIW0k2qpqR65KXcBxB4aXQDMLw8QFgIJvUDCOwRy1HVqQKsGj6xPRJlV6h3KGYL/
         KOIMns7qcQ1hU+EogAJv3fxZgFAjZzz1iynwg0pg/J3yt59OG/4L15Tvk9comKSw0J/T
         LY63IsxfKsvKmimmj07PgaL5+POX0o7GSf0/+qyXKQUuDrz7hNWWzHmCRngR6qAgKTw+
         xNkA==
X-Gm-Message-State: AOJu0YzTmqBIXYNj+m/QwpACwQeoXK6yyU7skXeGPWRE6c5MRCaeQqHa
        D3KFQKSGOs0lk4wBzPKux7I=
X-Google-Smtp-Source: AGHT+IFKsA5y+4A45gtr4oOX0jTZC3l4FhZV7lIud8i/1g+uNYS7PKF7EUvH1WKUiZXGy9HenbYx+g==
X-Received: by 2002:a19:f81a:0:b0:4fb:9477:f713 with SMTP id a26-20020a19f81a000000b004fb9477f713mr5925771lff.6.1692725482596;
        Tue, 22 Aug 2023 10:31:22 -0700 (PDT)
Received: from [192.168.0.100] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id x20-20020a05600c2a5400b003fef60005b5sm4049810wme.9.2023.08.22.10.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 10:31:22 -0700 (PDT)
Message-ID: <e5eb5935-5219-4d43-892b-96a03f8eb755@gmail.com>
Date:   Tue, 22 Aug 2023 19:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] staging: vt6655: replace camel case by snake case
Content-Language: en-US
To:     Pavan Bobba <opensource206@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZOTUCRICU6lSYfdn@ubuntu.myguest.virtualbox.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZOTUCRICU6lSYfdn@ubuntu.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/23 17:28, Pavan Bobba wrote:
> Replace formal arguments of few functions and local variables of camel case by snake case.
> Issue found by checkpatch
> 
> Signed-off-by: Pavan Bobba<opensource206@gmail.com>

Hi,

please find a unique subject so that we see it is something new.

Thanks

Bye Philipp
