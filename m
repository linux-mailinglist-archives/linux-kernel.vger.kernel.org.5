Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AC97EEA10
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345586AbjKPXnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPXnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:43:39 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75C4C2;
        Thu, 16 Nov 2023 15:43:36 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso1291516b3a.3;
        Thu, 16 Nov 2023 15:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700178216; x=1700783016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOLzRp1jFV4lvEHHrJt5+/etVwFfd72UkkZsGfejAIM=;
        b=IbCnnVuJs0ERBhH/162g+DBcmI1Rk/8cHQyOB/pC4N2CpwNps08/GxWFVqmHLd4ESM
         /kPvkQSH4jt7D8LMmX8ct505vaBneXPbnxiE0mGnlXVEox//vQJA/2RsP5c7KipYDZ0D
         OBOinCnBSRuF8643a9cGN54Xyi+BhxAj+HHQLkUk2pNfXnhZP1eZ0Bi5H1DlNWL6Nj5R
         wLVzzkLEkqE6ag1GrCsDgBZWs6a/UHllS4U2uqT39Q/wpU8Vjxyn5Vomse9b+glic2wu
         bAqag1RRXcqO75uTfYHOEd5aFBtSuYnwGYjANt37XbVmeUvf7CNfzmgHtp70YOxKKEXd
         Ozrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700178216; x=1700783016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOLzRp1jFV4lvEHHrJt5+/etVwFfd72UkkZsGfejAIM=;
        b=fHGcPKccIb5ct40V5XgNSbksjQbbiaipJXgb/NI1UoEc8KrqJm+0w5Tm7eZxALNVrB
         hIPInMRebmcLmYniJTGSXG/3cmRv8LWyzufn3kzPflNb9acVcGK1HWsZzhNnoV/i2N2t
         NloGMQg/DogbK87pY3aw7NLcey+WVZUZZanAQKzQEIinFg6ZgvjarmCu/uyoe+sB0EcW
         9bEE9n6AKezM1OZqGd3wIKTU3m99r4ZAavFPwh910fQzov+lWloU9zfau4/5m7WsHprJ
         bdQsHJK81u50eh7mwafJmN2wD0MonazBErhOgdmaEb/p3Lbuds3XBqDPa+zHoc41ArCw
         Va4g==
X-Gm-Message-State: AOJu0Ywdi2i7n8GbJvlnMt5avIPIU8nULuww+PDiBPBv8I1Z94Og1xsn
        Bd6mTDc5+r1HuedlMwKOYlw=
X-Google-Smtp-Source: AGHT+IEsnogbn0w5gfWapOzjXy1LB76mKSieHFNS5GzGCdx7PaFaWqobcYGd9UzXeGygXqXWJ3zxig==
X-Received: by 2002:a05:6a00:93a6:b0:6c3:3bf9:217e with SMTP id ka38-20020a056a0093a600b006c33bf9217emr17557480pfb.19.1700178216221;
        Thu, 16 Nov 2023 15:43:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y10-20020a62f24a000000b006c69851c7c9sm267380pfl.181.2023.11.16.15.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 15:43:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Nov 2023 15:43:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/379] 6.1.63-rc1 review
Message-ID: <ea986ccb-c09d-43f1-b2a1-18468735585d@roeck-us.net>
References: <20231115192645.143643130@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
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

On Wed, Nov 15, 2023 at 02:21:15PM -0500, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.63 release.  There
> are 379 patches in this series, all will be posted as a response to this one.
> If anyone has any issues with these being applied, please let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 19:25:27 +0000.  Anything
> received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 529 pass: 529 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
