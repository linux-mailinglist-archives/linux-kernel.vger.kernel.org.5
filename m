Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611798064A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjLFCLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376635AbjLFBzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:55:42 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C992CBA;
        Tue,  5 Dec 2023 17:55:48 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 7C56CC01B; Wed,  6 Dec 2023 02:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1701827746; bh=w04/oDIBtpK1gN2WKAOLZcgCdqrueDoJ2tN/IfXA+tY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJSU66scY8SRyyxY5IALugmRpeK4O+1IQDp7057uLa8Ao5FXZfOvtEzUWgaa2aJK7
         6rfn+m+o7a/PZ8xXnblwgW1pad3SKV3Vrw6Q81hESmMGTAD3ryTk73wOOleXUvph9Q
         Qd4PmQz17li35ctIRmLkN3zaRcPLYrhQhd6ftE07rmUG6AH8cOLbCnFfOBhsPzjoRj
         Xw+En7Qv1KVyTcMIKVc+nZ9dm1ybGVTDkaLZLr1SC7MGu4PjSE1EVqEsPzp6DXpXeG
         UCkVPPIps40GFKnzTPU1D0BDfXQbGy77xek5//0Vbsr7YNedN/ouwZQQM3LTiZNvEo
         m2Ov9o0cCE4sQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 03B4BC009;
        Wed,  6 Dec 2023 02:55:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1701827743; bh=w04/oDIBtpK1gN2WKAOLZcgCdqrueDoJ2tN/IfXA+tY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TSTKfgWtRHEX+X6eX+Pg4rgkOipdjk7TA3DZri/pEgJdl5oPJc4XN/+oH0uPfCc65
         RynEzN9rLFSVzd2efW/meXojC/5oaaO1Cx4qLJv3X2yjGf7RDb3Ityye7TYLerf1gd
         FqH5l8UuZ+9dfZg9Bmb0bI2TobcI4c/cRi/txEMiS3HccbsnAge6U/mfPCN8cip6NJ
         qu7RUs6QWmMatXyYzl+LYLcnOQBHgfc+nbj9Wg+N83EN+8d89FgZ/EAfFbKtc5W94U
         puI1xtcCYY8p01BH0ZAMgowMfHlHG/iX3FNsV20vczdl+QR6oryP0Ad/5jyYPz8wWG
         MpduHB/J3OPEw==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 95a0808f;
        Wed, 6 Dec 2023 01:55:35 +0000 (UTC)
Date:   Wed, 6 Dec 2023 10:55:20 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
Message-ID: <ZW_UiI6iA_KZ8v0D@codewreck.org>
References: <20231205183249.651714114@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205183249.651714114@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote on Wed, Dec 06, 2023 at 04:22:23AM +0900:
> This is the start of the stable review cycle for the 5.10.203 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
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
