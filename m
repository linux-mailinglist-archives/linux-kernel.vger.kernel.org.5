Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3153F7D6F92
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344846AbjJYOKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344845AbjJYOKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:10:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5E11B4;
        Wed, 25 Oct 2023 07:10:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ca74e77aecso7041285ad.1;
        Wed, 25 Oct 2023 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698243011; x=1698847811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwCCg0zYUH23+/vvuvizMO+mdvRxbuXkqJpOtLR+Ay0=;
        b=InNhNqtY+Y0tKn1P4BqDxaZJJ3fEZebg+kt2gg0yDXjFG+SwwckyNN/9BSusmKckrQ
         21wQHjbt20Hl7hstyv0CtN49FJS1m5c2ldyyKDLdD7Zygp0ZvCkp9V4UaLEwQ7FgGqSj
         Ygs100joUshtwk88HR7jWnBzLr8uDCrH2XzSsd6MGhh5sS3LicpQ5QPLQiYJwfD0g3xX
         INcFWzyrL70k2AXUuZwxZdGGXJXENIcZ0vO96gIZsW+bTYkKPLorYI854L+P0TakE43j
         tj7Z2tzmkh85x/6HCdpd6/8Mdpy/vPnqMvqal2DZwUhcFhlSQVR3USI+mt2pehA4voux
         NXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698243011; x=1698847811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwCCg0zYUH23+/vvuvizMO+mdvRxbuXkqJpOtLR+Ay0=;
        b=sAh5JVBkpNJgxZyhQxWIrYYwslvTHa1IDMQa/QmDgRjpFvdnoslWsO0K/IKCWlBOfc
         JYEILiQAy7XG4uJgeRtp5CPgacVKYifz0ONaMF8koVnvIzwFWF5BfT7lnnpO0j+6GlpE
         uacPLIFu8fGUEbGfHo6XQnJE7DG5UCHnyUqCS6ZetOgf6zBW3fuVN/OPO4Kn+S3y3W9b
         WeJNV8JSbVDqxCWmz1o4oFTtHvgPCZTla7dHe21fkuvZn3PISiL1h6wz9W2KN+NxncXe
         6UT4lFjR0PH5z0mYJdqWylSn3hm6TUbBtt9ikl153ny3HfptAWRDuAXIpPo6J5oFbrVr
         IdVg==
X-Gm-Message-State: AOJu0YxSOWxZkPDjaKR19kcADygE1TvG3b5TEg8XTQBFkpgN5Z2Gqgez
        krXwd0OgwauC7O0FKFU/y+tWsC9lMPw=
X-Google-Smtp-Source: AGHT+IE2dLjPRinhmA1aidV7HT0AcVSzY2h3ldw9Kbea13Z+t/1WdM7tlZ0o1EsIiKhnE40R3oqncg==
X-Received: by 2002:a17:903:2447:b0:1c5:ecfc:2650 with SMTP id l7-20020a170903244700b001c5ecfc2650mr24331933pls.14.1698243010686;
        Wed, 25 Oct 2023 07:10:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p14-20020a63fe0e000000b0058ac101ad83sm549603pgh.33.2023.10.25.07.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:10:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 07:10:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/135] 5.15.137-rc2 review
Message-ID: <a25e016d-322c-4d27-b252-77f8784cd51c@roeck-us.net>
References: <20231024083327.980887231@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024083327.980887231@linuxfoundation.org>
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

On Tue, Oct 24, 2023 at 10:36:50AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.137 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:55 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 509 pass: 509 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
