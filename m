Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A827E46A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjKGRQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjKGRQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:16:01 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B9184;
        Tue,  7 Nov 2023 09:15:58 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1ea98ad294cso2483424fac.3;
        Tue, 07 Nov 2023 09:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699377356; x=1699982156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o3JkKLwAwJdKQeiiREsn2ZXGc82r7DnIspAVxlaKU+0=;
        b=oDR/6Tr5gqzEpA/5OFLbvMHQpyzKlx5BUj0l/rQvt2clNFEMlw01RSVhXsUOe2Vavk
         DhTzY8AEyAifATcU2PUaaZT47xrC78i/qhI4Q5KGIZLJFUnxFPYeZcRSK2ZN+yUmMwC2
         eQhbBPSsZx5n9llaHwzfIw86bncHEI0o4LvQ+yJX4ypEasmvzxsQIC5i0GubgxcqFZAB
         u4+B3Fdq0OdkfULZynVQ84VUC6w3JoB0RROKqQXvuLcE5prIpxAbC5hLjh9M0QxnrneO
         zlA0zftEzjNPeA4RT03DXwIiiXmvYYxbbJtLSMi2jHCvHGNyOHAlJTRXVmZQrnOnjHKo
         Vcpw==
X-Gm-Message-State: AOJu0YydUZWghmSSlkTwinfJGHyTS8tMQ/kcwQVaPri6GZrNhcqfuEr8
        1uzOoPIWsPfTXpSFRl9UIBw=
X-Google-Smtp-Source: AGHT+IGao4fOJShZIACLhtD6KQuHOGX5J+O2BcDsJBuMTHdUquuPkkev4d2UT0d5FsxOhAmLASQi/A==
X-Received: by 2002:a05:6870:32cc:b0:1e9:8a35:8635 with SMTP id r12-20020a05687032cc00b001e98a358635mr3597086oac.21.1699377356597;
        Tue, 07 Nov 2023 09:15:56 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id v17-20020a259111000000b00d7b8a1074d4sm5179434ybl.57.2023.11.07.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:15:56 -0800 (PST)
Date:   Tue, 7 Nov 2023 14:15:57 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1699377354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3JkKLwAwJdKQeiiREsn2ZXGc82r7DnIspAVxlaKU+0=;
        b=DEx/dWaxQ8ccwrSDPzBixw8L5Txa0uRanlzCRi3maelhkr8nqd6Y2/S8kyabm9NWrAa4hp
        C5oQnyxNNzXZMuoZ3PTMkTp53n7tiwj+jtKsO3lIL3CCRqb/dmPmlDEkeJqvUNK8pbmF+a
        7+vkgGBanhoVjJ7m6pt9FxVcmp1359LlVtcpA4I5K/WHwWI0ZjUJCSApQ73hsHKMDbo9xN
        P39ciTvHVMMC1cIWBPaVWaEm9a3q3ZiDwWipru6FriaAMIBikJWyF63srq+KZTHFf/G/jn
        xsytGVvSl8EJfpdx5YhjhcdlHnxOKdkHEX044m3D0YUQ5tHoYmsjpOVMLMrLbQ==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.6 00/30] 6.6.1-rc1 review
Message-ID: <2ju7wq3iidsei6szpvxahrjd7ii46ojmtiwrycdstlql3l4y66@k6scuz6argwd>
References: <20231106130257.903265688@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/06 02:03PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

No regressions on my system.

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thank you.

