Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD77E469F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjKGRPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKGRPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:15:06 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBCE130;
        Tue,  7 Nov 2023 09:15:04 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a84204e7aeso69791377b3.0;
        Tue, 07 Nov 2023 09:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699377303; x=1699982103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cIon2aC/U+pjndRF0dPULvHTvHn2n3TpUOM6ACbZ2jA=;
        b=V4Gzvpi00KCHBOty/FeQg79c1KFuntAGHF//ZcVRSFIa8lLpWwP3tSVxm7ysqVZucO
         CdONqLJtWQNRRrY844JVe6U4IL++wcoQPpv7rQXTtVzKhP2uoZPUwU1adqBVxvywqDsH
         Mqs5wlug1GssGj8fgZ/Kn+fTt/A3P7e7rrSff2ixu7EA8shl1y08GJJRrM9dGlwiJ93C
         YiqCNti0noIJFcAofyzFoE6JgdTCQe1vtjXUzedCjTkgsO8dQM9FSyYpCtqzqveSY1KF
         KoV/YmDbPjGi8WfSszW/7mNxckOkNofm3hDvWuQyakKfFHL4hVUltcqXWC9VPuGx8/fe
         Tu2w==
X-Gm-Message-State: AOJu0YwpHmEL2acMyBSXTgtUXmbGLMoNp/+bBU/zjTAG9t1rJy8PEZtk
        cdKgGjO1MGidlldf7QeiwS0=
X-Google-Smtp-Source: AGHT+IFWC6f2Uj8Jdr1pY2RERI9LKb7PGdwkIwudFpTnthj8yiNCwbEHg+ZmcAd2KlWjrdFlnyH2wA==
X-Received: by 2002:a05:690c:ecf:b0:594:e97b:f6fa with SMTP id cs15-20020a05690c0ecf00b00594e97bf6famr18146260ywb.30.1699377303169;
        Tue, 07 Nov 2023 09:15:03 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id n206-20020a8172d7000000b005a7d50b7edfsm5734827ywc.142.2023.11.07.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:15:02 -0800 (PST)
Date:   Tue, 7 Nov 2023 14:15:01 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1699377300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cIon2aC/U+pjndRF0dPULvHTvHn2n3TpUOM6ACbZ2jA=;
        b=bbCnIH9Bpe0CchplrmTvTuRV2sWMi69SLdOiuwX1CAk9FTx9187LU6rZCmcLm1aEXUDQDl
        iuMQZlh7SfGxzIFIEkBiaDRuYxPGtrzdt7NaEHuSRXZuxgxxAoKnILu9RAuv8bZnQc8PpV
        jZyrONHd4I7fY/eFEgkalEd6YTbDl2ASOnhIsvDYsDmMG+W8a4Sa+GrLewDlQzTHlofw5R
        E5DLQ+uTjzj4f4txwkp9o+wTKb/B8AIMoRhE/da34xUbltuEmn1DguXmZNFEMjzdiVuPzV
        Oh6G11D1wWh5jjbgJ3mi6Ucj75h8+EamS5mrn275/jVnyb3ugi/9xevWmKbGFQ==
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
Subject: Re: [PATCH 6.1 00/62] 6.1.62-rc1 review
Message-ID: <qoak3rxpamcuiimvzixvhx7z2pgqdu3nbnvqf2alw726jojveb@2oeqwzq4t3dc>
References: <20231106130301.807965064@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/06 02:03PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.62 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.62-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

No regressions on my system.

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thank you.
