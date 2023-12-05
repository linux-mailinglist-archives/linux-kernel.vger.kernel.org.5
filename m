Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E292D805C46
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjLEQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjLEQzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:55:46 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576CB1BF;
        Tue,  5 Dec 2023 08:55:33 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d8751c8e7eso2662176a34.3;
        Tue, 05 Dec 2023 08:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701795332; x=1702400132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sow2MusPsrtxMYHQTqvOsRCxKJ5Iv4+FAUZthKEE3HA=;
        b=hSmLL6E7HPUA6KtNRGM8NRSYM9Wioz4GM7RkxtCFVDH6Bqvn5Y3GEfouVd0n1BvAuZ
         F9jDutUnKs8gCD1JhSgFPRbRfqwixLAe/durxHEZDXbsOnohs45cVIfx0wR1UBMl2s3C
         d5AqSTnJngGyg1ll/xIdkMWiH4WCLXPV9r1McD37oSWPGOP/aVXQVJaux2P44Ozhn0Nv
         U+4W/ihTyIO04IXWfn1lfF8tAzE7jfPgnmvIFjB0zquAty4yPrpnpPp8Y736XD/vLsCt
         TQhk0VqmNDhOGdTaJH5jHXaQMme7AqWFuTiuBoMSUo9if9paRjyZKVgQZaOHycny7tby
         VUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795332; x=1702400132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sow2MusPsrtxMYHQTqvOsRCxKJ5Iv4+FAUZthKEE3HA=;
        b=w81CIz57umNa+v9ZNF+kZ+sCp2YJLDeZFoDRJBSnOiM+iOJt4LmuUuYIFYpqzUPtCq
         dTMALyzENXNU86h5/380g1aydPccnMOGZY0psJPnm+E4J6vfHpcy6e//6wxS7aXM/ZEY
         0rYyt6gRd6p6fBbDhUCr3jw6u3FahIM99vyJwRs29VNhyQ2iHNZhZaRODP/KkVFGw6El
         hO8V4gj367AnnAe1rgcGKMNvEesSJxXZMGsD1d0bEQWELLge2stwaqyMSRt4/+3z9Bbv
         NXFkeXxVQopQteZcThfvH+EumCtZuAQyrECA26+238BDcPbTth1YX+VBxTeBTbtvLfLG
         QQlw==
X-Gm-Message-State: AOJu0Yyfm7kB8OwqYNg2qmE64+WyhwrzTT9TpJ1HL4VdmtcDyDqN3lTy
        u+QnRlw6Kjll0drVCmirmn0=
X-Google-Smtp-Source: AGHT+IE4ZDce3hthWdMCRQldjC2n9Zx2iYL34DI9ZghZZy1irbLKsqvsO35LTAr7yz5hdYezZbaxLA==
X-Received: by 2002:a9d:7853:0:b0:6d8:7d67:dd96 with SMTP id c19-20020a9d7853000000b006d87d67dd96mr5094198otm.66.1701795332482;
        Tue, 05 Dec 2023 08:55:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f18-20020a9d5e92000000b006d7f41c7e11sm2271407otl.33.2023.12.05.08.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:55:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 5 Dec 2023 08:55:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
Message-ID: <8db0a771-b99c-40a2-8101-42394dd598ee@roeck-us.net>
References: <20231205031535.163661217@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 12:14:32PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 538 pass: 538 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
