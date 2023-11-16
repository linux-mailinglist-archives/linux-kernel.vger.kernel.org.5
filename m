Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9477EDBE5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344146AbjKPHWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjKPHWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:22:17 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4539DD;
        Wed, 15 Nov 2023 23:22:12 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 2EC2FC023; Thu, 16 Nov 2023 08:22:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1700119327; bh=UGteBNk1MfmhOR9aXzCP79/I0BC+ccGkg1SeZSW7BUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdEHqgA/vvJqykCo6La5SMb3UL3Z4dmvZ+YrSJxI/7DcFomPhl8zFFvGU29aZF6QJ
         Ce7uFDSsya5faNQMCuLvxrpqApXVAa9Sj2kGe3m6/qEDPxlYLY/D40FXL3KLQ7/0rS
         gOlW5xk0yiVUe1UwGjeTH/z46bScz9N549OSdjaA2nR8MrmV+SbLBQQ5qds1yDJLpq
         TsOqQelaad6uypxPpWtSrtKykXL+mnm6ANwm17Ufu2l1h3Ub46QQRc2QvPVAgfn85P
         iMh9pBS8biDRCa04tIkvUE33e8zG9YlW49GnXBxWpMrJBq11nSbnjf1pB3VrXuOTE+
         ma9UL/YbORnGA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 1E26AC009;
        Thu, 16 Nov 2023 08:22:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1700119325; bh=UGteBNk1MfmhOR9aXzCP79/I0BC+ccGkg1SeZSW7BUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDte+n079n7PTU601fuxNcjLBrTKvnVs1mbSaaEt6o8MdgrpRDBE5ZuThOEzUCi0i
         rGwo9fPlT9gZVAKu7k/uUlHXJVtm3LpiDcTWbbl48W0yK1d9Lq7qr22ALeiEP/1pSb
         qVHIAFzoPsbKlv9rqpikFE/Zja3tHY36iqddMK/7J+JGDDjOGTP9w4V9TWmwPcYgpg
         YyBemiKaqc32YZRTX3PzEvOsYYemHGI7mw9N8wDBxH3A673UuVd9cWIBy+WDje7Co3
         0BY1RsUE9wmHab8v6y0RB02Bil+BxYBanyRJYCsLtwaY3fN4hstpGZrQY3Wvujiz13
         vX7YlQ+1h4qPQ==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id a19c72eb;
        Thu, 16 Nov 2023 07:21:57 +0000 (UTC)
Date:   Thu, 16 Nov 2023 16:21:42 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.10 000/191] 5.10.201-rc1 review
Message-ID: <ZVXDBtXJS7kWUqNG@codewreck.org>
References: <20231115204644.490636297@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote on Wed, Nov 15, 2023 at 03:44:35PM -0500:
> This is the start of the stable review cycle for the 5.10.201 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 20:46:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.201-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

-- 
Dominique Martinet | Asmadeus
