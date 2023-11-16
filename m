Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14E57EE205
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbjKPN6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbjKPN57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:57:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C33A9;
        Thu, 16 Nov 2023 05:57:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A26C433C8;
        Thu, 16 Nov 2023 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700143075;
        bh=trIak2e01GTSVtFwt0TCkoCaGt8nqBem6cBgWsLd4vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3+te0JfbgDwKvbCGqhgYL0pyyxMCoOsz0gqXpyr5Po8tCi3Wzt2EX7wKDT3xCxk0
         8VLhZjhaBR3GHq+UDG8P4coUBh4rYT+/S4k4nrSZPIsnFd0Qujv6T/44PTZ/BbzTKY
         lKgV1Vd7tgevw887IVa+Zprc7oYF5OD1/wG1VfoJtzN/TnoHqilafPlTr/0TPSXQO0
         QSWfYF0B0J+rVj5qHS+wFOm5ztqlZ72/wnLJVT4Wyl34P67GXp+wkDtTEz4+LuBx24
         PR2ZNsRhw3fZvGx3X3NIYJq+Qo5axdeu0xFfHPilMENp9t1eQ1eIdcadNJAQivterk
         bjcJZZik0U5xg==
Date:   Thu, 16 Nov 2023 08:57:41 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 5.15 000/244] 5.15.139-rc1 review
Message-ID: <ZVYf1VZ1xKQF23Qr@sashalap>
References: <20231115203548.387164783@linuxfoundation.org>
 <77fb5f38-d4d4-4334-aee9-e5af585728f0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <77fb5f38-d4d4-4334-aee9-e5af585728f0@oracle.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 04:04:10PM +0530, Harshit Mogalapalli wrote:
>Hi Greg,
>
>On 16/11/23 2:03 am, Greg Kroah-Hartman wrote:
>>This is the start of the stable review cycle for the 5.15.139 release.
>>There are 244 patches in this series, all will be posted as a response
>>to this one.  If anyone has any issues with these being applied, please
>>let me know.
>>
>>Responses should be made by Fri, 17 Nov 2023 20:34:45 +0000.
>>Anything received after that time might be too late.
>>
>>The whole patch series can be found in one patch at:
>>	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.139-rc1.gz
>>or in the git tree and branch at:
>>	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>>and the diffstat can be found below.
>>
>
>As Florian pointed:
>
>I am also seeing build failure with perf, which is same as the 
>previous cycle.
>
>BUILDSTDERR: util/evlist.c: In function 'evlist__add_aux_dummy':
>BUILDSTDERR: util/evlist.c:266:31: error: implicit declaration of 
>function 'evlist__dummy_event'; did you mean 'evlist__add_sb_event'? 
>[-Werror=implicit-function-declaration]
>BUILDSTDERR:   266 |         struct evsel *evsel = 
>evlist__dummy_event(evlist);
>BUILDSTDERR:       |                               ^~~~~~~~~~~~~~~~~~~
>BUILDSTDERR:       |                               evlist__add_sb_event
>BUILDSTDERR: util/evlist.c:266:31: error: initialization of 'struct 
>evsel *' from 'int' makes pointer from integer without a cast 
>[-Werror=int-conversion]
>
>I think we should drop:
>3dcc2e4843277 perf evlist: Avoid frequency mode for the dummy event
>4898cce349953 perf tools: Get rid of evlist__add_on_all_cpus()
>a6157c9aa899a perf evlist: Add evlist__add_dummy_on_all_cpus()

Dropped, thanks!

-- 
Thanks,
Sasha
