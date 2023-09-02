Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4967904F5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 06:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348462AbjIBEUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 00:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350898AbjIBEUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 00:20:15 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E35170D;
        Fri,  1 Sep 2023 21:20:11 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c504386370so1747340fac.1;
        Fri, 01 Sep 2023 21:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693628410; x=1694233210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BeF0qo1QDa7OIOcRTZpHC/vNEQNnCtwtVp6krVTuy8=;
        b=V14XuII5Vc5mr490QWhnFwH1KHSLVxjze05GSxtF2CN/dTCl2MNmn5l9pwgs8XBH/e
         McO9Lb99ZVpitLSabLRxBEFzUHTj92gy1hp4QFCOpyUWe5qHo+BFc0LFa0b60mxKNfDV
         Di/u9THg1R2P54rtIX8WChvYHIz34hL+/6eaH5SoBW6PQyVtrMgWS+mXKwcxg4EJmvpR
         kJ5YI0V4tysdPWHf2N4c9+d+yz7kzYOBJ6gUF3z7kUWFcyWQiaav67uNMsGUVQs96N/6
         ByrOl3N5bHARrwCGu7TxqQzRnKni99rlkEbzo+uaAZD2Uqwa4BkmLVPScx8VYS5lBtDD
         8hqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693628410; x=1694233210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BeF0qo1QDa7OIOcRTZpHC/vNEQNnCtwtVp6krVTuy8=;
        b=dt2uNHXNThfl3fhTlUNItgXPaCv6wUNNF1YodWX1rBdJ75oHENnxGdmpH/uVG6qzNz
         qNui5L0fkDmpf0dq+4kqCfDgCTGempk+pliTacF6QsYgaRHSfpYJaESxmWEh0BskgzBs
         JpVNZZNfQo9LpVNQ7LpPuYFXl5ZGySX/6bJwNC10f/FeBjoHZ9v8WMLM/yHXBTKjSVVK
         32nPaELbWIFlsIgOcS0z9BpnVIdZg9zvUcyElYvT39BEF9WUDFWWcP3E5GgwrVXEof43
         W2//0WMem6pXAg9M4yoCAW4lJef+T0qDZ5WVAmaleEpwNeeVvw9eZR2G/wrVFOWAx5Qq
         eBKg==
X-Gm-Message-State: AOJu0YwjcUmh2CWLWlWQ9V/5ekCOd5xYkElVaI4J+v0XyusDEhl9u3yR
        hmH1tKU7edvhe+XmAyk6h8g=
X-Google-Smtp-Source: AGHT+IG2LY3kqoImoMbvUvRg1Kays39XG+1y7t3IDVJEhS5vu+CS3AHHd1b7mL4lK3G4rF5rT9IksA==
X-Received: by 2002:a05:6871:892:b0:1c0:1caf:3324 with SMTP id r18-20020a056871089200b001c01caf3324mr5558212oaq.44.1693628410004;
        Fri, 01 Sep 2023 21:20:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g7-20020a02b707000000b0042b34d4d07fsm1511337jam.156.2023.09.01.21.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 21:20:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 1 Sep 2023 21:20:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 0/8] 6.5.1-rc1 review
Message-ID: <0b487032-17bd-4b57-9e84-e98e63a05a7c@roeck-us.net>
References: <20230831110830.817738361@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110830.817738361@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 01:10:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.1 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 522 pass: 522 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
