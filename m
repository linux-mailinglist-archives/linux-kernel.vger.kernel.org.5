Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AFD7C6944
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjJLJRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjJLJRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:17:19 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4B791
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:17:18 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7dd65052aso10671287b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697102237; x=1697707037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6dAMz+0PBoS2XhVtGEyBlFK0C+DlTpY1GdaToHa8Jc=;
        b=hYxAFqMBmH3OmoR+nhuDhBMTGTEmnKYxp4TESq+pOlsaIWPXgUmN9EOi17P/FYmBQk
         ckZCJEI7Y1Vy0PsDee6Ud4AGN795o3oOB0O8OALUm/A0iRuw0YQxyjwwWR3ikanGjpEJ
         5A8JuTCa6Mn08m+mQkUL0z7kvknr9hbky64SSn7GDlKSVNhD9cjWDcas312URJ1MD4ip
         J+CWyMCF3V6fqdXDhN0pANPypD49aBwe28eG+XpiNiVvt70Euq4/AaCIJ/kAGd6Aq3Hh
         rImaD+sbwHjg6DSOcM7A4FEzarImSrdP223fJ7LbJ6LTB1XSppYIy7BlsaT1PMC6Da2f
         vRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697102237; x=1697707037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6dAMz+0PBoS2XhVtGEyBlFK0C+DlTpY1GdaToHa8Jc=;
        b=qdFvTkD9H5HIuC+B+TYmGBkDwKyFswSgHU0+RO0SLJcpJkovovqJGleW9T6GlZXFtK
         VlOjzIsgtmucIoOnnDshDKXDeoGRWLTnZ5Tai9sBbcU4eAf/Z/aCWujQdwa0bWIlSqLP
         UY7WExcuI7y/SAeyp9Tis9xb90IhbAuXmNTaaBW1vE5PJNe26UvGBiL3dOsPZGjOQAPZ
         lx+ZPwH/K33zRvWnswL7cbi6r8noTntij/vqggTTkMfCgPN7T48DSYvs2XBYvzTKQ9BC
         aEHwzKoQM/AO+R7iOzGCNjjFckVfLJkLySF22tWL6WX9Fs6K1jTb92ig/aI/K03zVnGn
         gGVw==
X-Gm-Message-State: AOJu0YyAjZw1Jd/zJ9KI+g3L2wODeiipTXfjr4Qok2nljX+CIfVkqlpB
        DiQcqPzpesENohEj6wHiWTU=
X-Google-Smtp-Source: AGHT+IFuQMSMzJzJH2GkD7eihBN8OFvYqFcC1HGLtYAHbbnx3UQ7tSCfZ0ufU5iKSpJBX7SkHxuqpg==
X-Received: by 2002:a81:6ec2:0:b0:5a1:db6a:6459 with SMTP id j185-20020a816ec2000000b005a1db6a6459mr23340529ywc.40.1697102237316;
        Thu, 12 Oct 2023 02:17:17 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090a2a0100b0027669cbc30asm597246pjd.1.2023.10.12.02.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 02:17:16 -0700 (PDT)
Message-ID: <1e2cfefb-c4dd-4611-867a-2b2e9e5f7467@gmail.com>
Date:   Thu, 12 Oct 2023 16:17:11 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging/wlan-ng: remove strcpy() use in favor of
 strscpy()
To:     Calvince Otieno <calvncce@gmail.com>, outreachy@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Archana <craechal@gmail.com>, Simon Horman <horms@kernel.org>,
        linux-staging@lists.linux.dev
References: <ZSeD1UojAgrsOh16@lab-ubuntu>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ZSeD1UojAgrsOh16@lab-ubuntu>
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

On 12/10/2023 12:27, Calvince Otieno wrote:
>  		if (j == -1) {	/* plug the filename */
>  			memset(dest, 0, s3plug[i].len);
> -			strncpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);
> +			strscpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);

Is this strscpy() behavior same as previous strncpy()?

-- 
An old man doll... just what I always wanted! - Clara

