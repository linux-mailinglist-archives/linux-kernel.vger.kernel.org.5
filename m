Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564FF7F51DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjKVUtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjKVUtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:49:09 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C54110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:49:05 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso214474276.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700686144; x=1701290944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4H1N3wUMFFgburbm5dXTGcW3MLFGgcqhOobufDfmiaI=;
        b=gef6JK/YlHzcmQO6Q8swfGowiZncoOBa82dNp86IleAJKi3/yGJYAwgcOmdgWv1Ua/
         LIqm1QV/GrOTCEZNXWwp44iezPX98DOXNAafv1e6JGfGCGrcTcPfQXzjneB3y5EC8afR
         k2x6+EJ8RXwq2DF/JKvib4pNAAaB+hfp2ny3w91xWj0aJWMvAgqzZJNj6NJ90uJyqdS7
         CK8dT6kX1J2L43ib8xPm9vFHUF2KV+dSMBlYg9o5u9oTNy2VPKamAcN4ypBkOsWazANw
         aMFVwZX2cwaYkbIsieO9lJ5yLg/k9qnRBcS4SlUm4idbhkeKN2U8W9cS9skxpEsaVGL7
         rb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700686144; x=1701290944;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4H1N3wUMFFgburbm5dXTGcW3MLFGgcqhOobufDfmiaI=;
        b=v4HKcCN+K9hgBTQ0F27GJ/Ww/FyWWcsDzGdP48ufBkgIVFTxdafgxRZjycTgfBcUNm
         g7FLDjq7LUvlvA00OUIx2j2ycfUAYq9P/UkjVY8QyuUSYxVdo67Ymj/Ds2mv6dnuxodz
         JCzcyQTIpvhMYjgDuPP5pKqaqE4ujv1fhYWvkVWyukw59wHI9Evl0feM6ItbKW9HmGXV
         oghocNq43dvKCb+/gSt4Etyo+aJGNtXHj7/qGO9lSK9+7TncLJYC5+6Dhgea3Yaay/Ir
         rD5UzQjLrNXP/t4jNT4+/m4u/esb0OURskZftaxq6r+Z2biq1hjG51k2zK3lsvN1wxUy
         4ZwQ==
X-Gm-Message-State: AOJu0Yyz5hXYVfSJmWYIVijU51zq3PpJV1JNQppv6SxxHyjLbiugkqha
        ifjgy9uI1KHBaGsGOL1v7g==
X-Google-Smtp-Source: AGHT+IFUuE1uEagxC49igXqfNVcU9CcbfHcTV3HFIuVON9vaVCEPlC4d2jsvke7jE+DBIKs6MTD/sQ==
X-Received: by 2002:a25:258b:0:b0:da0:d0e6:905d with SMTP id l133-20020a25258b000000b00da0d0e6905dmr3460562ybl.59.1700686144511;
        Wed, 22 Nov 2023 12:49:04 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id q8-20020a25f908000000b00d9caecd5c86sm1518023ybe.62.2023.11.22.12.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:49:03 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:4b88:896b:27a8:aa33])
        by serve.minyard.net (Postfix) with ESMTPSA id 86804180047;
        Wed, 22 Nov 2023 20:49:02 +0000 (UTC)
Date:   Wed, 22 Nov 2023 14:49:01 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Emilio Perez <emiliopeju@gmail.com>
Cc:     "moderated list:IPMI SUBSYSTEM" 
        <openipmi-developer@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipmi: Use regspacings passed as a module parameter
Message-ID: <ZV5pPW9RsGsazy4i@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20231122203433.443098-1-emiliopeju@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122203433.443098-1-emiliopeju@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 08:34:28PM +0000, Emilio Perez wrote:
> regspacings parameter is currently ignored and the platform data uses a
> default value of 0, this has been fixed by setting the appropriate field
> in the platform data.

Yep, queued for next release.  Thank you.

-corey

> 
> Fixes: 3cd83bac481d ("ipmi: Consolidate the adding of platform devices")
> Signed-off-by: Emilio Perez <emiliopeju@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_si_hardcode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_hardcode.c b/drivers/char/ipmi/ipmi_si_hardcode.c
> index ed5e91b1e040..0c92fa3eee88 100644
> --- a/drivers/char/ipmi/ipmi_si_hardcode.c
> +++ b/drivers/char/ipmi/ipmi_si_hardcode.c
> @@ -80,10 +80,10 @@ static void __init ipmi_hardcode_init_one(const char *si_type_str,
>  	}
>  
>  	p.regsize = regsizes[i];
> +	p.regspacing = regspacings[i];
>  	p.slave_addr = slave_addrs[i];
>  	p.addr_source = SI_HARDCODED;
>  	p.regshift = regshifts[i];
> -	p.regsize = regsizes[i];
>  	p.addr = addr;
>  	p.space = addr_space;
>  
> -- 
> 2.39.3
> 
