Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CF07E58F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjKHOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjKHOaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:30:15 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B1F1FDC;
        Wed,  8 Nov 2023 06:30:02 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bde80aad05so292829a12.2;
        Wed, 08 Nov 2023 06:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699453802; x=1700058602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5r62nWKwDfONQMJ66AMQvvLX2yCKdSI9eJHGPUzZILU=;
        b=FiMfM9Mcwde11/WQem3U0EV15TqvDTJHHMXaMKGhzrr81ymR4+W1DHn1ofgRqBTHWy
         j/RC56mtHEcpzWU9RBar26Khhn4gEVbQr1PWg9cjt4yoQMrynkCEozPOAtsrZpkUl9LC
         9ShWB2y8qyTH0ip2YU8jtWxGs/rSk2rurUDE+VqHHqjlpkl9YsbZDbts6RhB7BZNdJ0K
         /cOzpIt65sXKSxJ5JcaYldCQW5Kn3+uQxGsAj82rzD5aLwXbftrnpvjh982EcBTYQG6O
         bwMVTPFjBqxgjMbBGtXSGFBU2Giz+uZDuLE6lscNS4LpTAfpuuxjGin46LwAhPP551Ag
         fylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699453802; x=1700058602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5r62nWKwDfONQMJ66AMQvvLX2yCKdSI9eJHGPUzZILU=;
        b=VvBx7nEFEGdgb3j/EJcREzuoxoKXI7wuqMN7yLRRSkaOICjvTXmylSsmQx7M6Pwui6
         BGbfe2A5sTxhMBkrj1OutWpxSXwthcjpiVx4CBSpFyA7SSr0bUSLAtu/I10iSxaSkVH/
         bHaOUX9XxpJXDQdlj1/ipK6nTuZKfauXQfVCiCtYjUZyuPMLD2STYR9mNFceaBPnJg2Y
         yNtildAF6MZ+/e5+KVYCZ5v7VE+BsjpuV068QYhax2pit8WsfJUOkT6IIfrTbM6OaYml
         3Lan+q8wNaWNVc84JHEX6Xr3ko2GT2TJb7EH/2/jiDsCafsyTVWvFgTGPWzsM+oAm093
         m5Aw==
X-Gm-Message-State: AOJu0YwjCXXT1ZQKxuG8jGr/F0VRKdL1X4HKtm4SOZgCD50PRSX5jJ6h
        uy/IZw1vCrxBIlC/AqoNn8sYEkiIt+U=
X-Google-Smtp-Source: AGHT+IGmOMFjCukRUS3HWfPOUnknRplkS5cOhkKtG1cm09+kwxFXYl3tmxYae0piPhtvGBsGI65uqA==
X-Received: by 2002:a17:90a:b112:b0:27d:549b:3e65 with SMTP id z18-20020a17090ab11200b0027d549b3e65mr1486663pjq.49.1699453801593;
        Wed, 08 Nov 2023 06:30:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pj10-20020a17090b4f4a00b00274922d4b38sm1652200pjb.27.2023.11.08.06.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 06:30:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 8 Nov 2023 06:29:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/91] 5.10.200-rc2 review
Message-ID: <6c739b87-8a1e-4c8d-a2fe-570646c8fa1a@roeck-us.net>
References: <20231107202447.670990820@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107202447.670990820@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:24:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.200 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Nov 2023 20:24:28 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 495 pass: 495 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
