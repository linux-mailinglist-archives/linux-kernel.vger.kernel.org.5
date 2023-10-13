Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC2B7C856B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjJMMMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJMMMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:12:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AECBD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:12:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40666aa674fso21005965e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697199167; x=1697803967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ommulkgo6kT/ecNae2/W+LpZutQGK9Ntv8cEwiwSQYM=;
        b=RRFPZhZbzewTHqk0XPKeBXIwUGC+ATX6lo2EsRxrr0MTYWYoLFHQN+kedsfWVE82d6
         iX5iQ0883Phfy5u/Ax3e5hrV+GsQeqRYpAWIgedF6q8qEr5zKnhVpcevXX8nsA+z7OyD
         lmkQmGLwOFT1hXzG2VQJJt46hghaxue/UgY4JIH2evrlSKVhTPPyk8UiX26IQdugz+iW
         WAwV05mW2feKnt9hVdkeO5D26z51GxCd5LfuZvRnVmi7lJ3sPPD0baKSfLOsFNouLlTa
         zwlkmqmgcLP8QbKCwRQfEq3auw3Vf2VIjl8MG6VsY7UkU1OqM1wfAhAzqNsbzuTaCgMb
         tr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199167; x=1697803967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ommulkgo6kT/ecNae2/W+LpZutQGK9Ntv8cEwiwSQYM=;
        b=hSWVX1lw7qIBA7BXt1wPBuX7+t9fBZVW0B+dgoMBlVfchTgYkt6jCSp+JxBNMU4n7E
         CJw3vgEOTC8ed90zjdb9joPG5XYZWff+OnUYLIDIp69HrdnulTNABtDhUDt8FhNwauzM
         yMWf8oRJacVN9Y7RPJnMCG5wGv569lbpYT85b4rvk7s5rwhlRbGqg7Iw8q/jxQZ3aIk5
         7TQFSKkDsRhtCiTOi/NdECqBaP0fITrFNxWyJJrGmy6cC2vCJKW0BCUOSSQKAokpmH7U
         xMCirryq0N2tOldSmCCDn1xBlxEl38/NoR+CunH+98bLGWzDrNh+Zplu8pnDHGW6rMJ9
         +6Dg==
X-Gm-Message-State: AOJu0YyLaVFMQf7xk5MOIe7tmedgBEOHWc8kUR1wmsN8EXmqiWtVryN1
        K1MUJ6ClILTKQf4YYRhRKBn6XrRPT0cGzv4AAm4=
X-Google-Smtp-Source: AGHT+IGGOPZWWwiRVHRk5yzraMQzyDHn0Hvvv7JodPr2iDjHtiNDH11qdqY3ba27geC5ZqN9VJdrGA==
X-Received: by 2002:a05:600c:2146:b0:401:daf2:2735 with SMTP id v6-20020a05600c214600b00401daf22735mr22563494wml.31.1697199167422;
        Fri, 13 Oct 2023 05:12:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n8-20020a7bcbc8000000b00405c7591b09sm2399240wmi.35.2023.10.13.05.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:12:47 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:19:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Subject: Re: [PATCH v6] staging: wlan-ng: replace strncpy() with strscpy()
Message-ID: <ce6c3d81-d75d-40e7-a6df-7abd4e8250a5@kadam.mountain>
References: <ZSkm34Sy/n2yxBqi@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkm34Sy/n2yxBqi@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 02:15:43PM +0300, Calvince Otieno wrote:
> Checkpatch suggests the use of strscpy() instead of strncpy().
> The advantages are that it always adds a NUL terminator and it prevents
> a read overflow if the src string is not properly terminated. One
> potential disadvantage is that it doesn't zero pad the string like
> strncpy() does.
> In this code, strscpy() and strncpy() are equivalent and it does not
> affect runtime behavior. The string is zeroed on the line before
> using memset(). The resulting string was always NUL terminated and
> PRISM2_USB_FWFILE is string literal "prism2_ru.fw" so it's NUL
> terminated.
> However, even though using strscpy() does not fix any bugs, it's
> still nicer and makes checkpatch happy.
> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---

It's still white space damaged and can't apply.  :/  Try save the email
and do `cat raw_email.txt | patch -p1`.

regards,
dan carpenter

