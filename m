Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAFE7E48D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbjKGSyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKGSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:54:40 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D3499;
        Tue,  7 Nov 2023 10:54:38 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2f5aed39cso3515506b6e.1;
        Tue, 07 Nov 2023 10:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699383278; x=1699988078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGow/u7Vib+2Ht5vsLhy73C5dOs+P6UgdII5R1yP8AQ=;
        b=F0AjF5FbrskiMyaDOZFQOGKRIqWfRAF+PeNqlWZgpfc2mcn4WhqVX/JCDYOYqu1FS2
         PE178u6WKpv1kTDdIdwC4V9mRX6iTz407+UG4COkg6eTFjFMJPAYQ39ulI5RJHsSUa5z
         aDvKTDhAh3ATjgzJdhCLjgeI5gikoZlvpm2b0Ub7GNH/TTSzLfIKNMYDgPNItlngrnbf
         YiQhMGJHmP8aSFWuv3W2ao2ya7TLhjuDIPiixqAKS5awLWoBbu+mKZFmjTjV/ksSwfMp
         evBQHKUhct62ev+mjBmIGzkKSwNBUGNvLTUohlD33koLMQ9CZJHGCTc3n6VqlsiTl030
         5dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383278; x=1699988078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGow/u7Vib+2Ht5vsLhy73C5dOs+P6UgdII5R1yP8AQ=;
        b=Ix1NEwv0x077DOUReb8g4XqWUaU+gusksO97nvY0srtupdUFYTRIDlJsDVu5zjxWCw
         hLn7sdhsAu1y7p+EVj9DgxgULN1hNFgKectoHIr19DdPM79epOqSXIHDDXremHq/Akwn
         Z5zkOmId5suzIPLUZ354c1hZYj7Gog+iZr+aslsef6I4hnN0q93m6CQnWHtkvSGU8qvz
         l+nxRA8z1sJXPMe8P7zZ0mbEcm5zDi6fPWwraYJWPEdaV+NJ5oIoO4XAS6kGtazNbrTe
         TefUBBptCcz+qGXspll8JiwlsVBU9wcsDQ5l34lbbK9dYhhEZ0bPWNSku+lscfUTbawo
         Vu6A==
X-Gm-Message-State: AOJu0Yyl16DYdq0/0g/I6l6NnUZU/ZZJ0aN366ZYFDLoc3qXS35K1nTq
        d1AuF8rpu3ih7kM2SYdwU0wYgiUHFoI=
X-Google-Smtp-Source: AGHT+IEeCsmGrryvOpIbn0s3GUQ9X/I5dVQhL/HXW4hqvIOp/Kca1LSoJK6n1GlYM9BR2iVmeibqCA==
X-Received: by 2002:a05:6808:6389:b0:3ae:1e08:41fe with SMTP id ec9-20020a056808638900b003ae1e0841femr29939908oib.57.1699383277975;
        Tue, 07 Nov 2023 10:54:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3-20020a631c03000000b005891f3af36asm1666523pgc.87.2023.11.07.10.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:54:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Nov 2023 10:54:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 00/88] 6.5.11-rc1 review
Message-ID: <a27b0a21-8dac-4d23-b3c3-38382dce79b6@roeck-us.net>
References: <20231106130305.772449722@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:02:54PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.11 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
