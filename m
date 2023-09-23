Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB847ABEEE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjIWIa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjIWIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:30:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786FD83;
        Sat, 23 Sep 2023 01:30:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A71C433C7;
        Sat, 23 Sep 2023 08:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695457851;
        bh=/8TgiVvhyoEQjmMNICoH2j+HfPup1Rblzd+bjpUol3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASEhycr2FAMdWrL/OB4mh3/h0p+L6i4+5LKvAnpuQz27PcVDgubdC5KgU2vI+psv5
         Ysx1hX+tPcroZK2hrCo6gwJgUuKG0ADca/2U7gDYEqCGKPeSEeVlqetEubaBkM5Zyp
         YiILXRIcPgVC4Pm9zFCDcFKnF0FsZoxosDQDYHZY=
Date:   Sat, 23 Sep 2023 10:30:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 5.4 000/367] 5.4.257-rc1 review
Message-ID: <2023092342-shading-wrongful-84de@gregkh>
References: <20230920112858.471730572@linuxfoundation.org>
 <CA+G9fYsM0Lr8TNQJxsZFDZwcH-rEzkVV+y+x5FX18oH5wm5dRg@mail.gmail.com>
 <cab7d157-946e-6b8f-1b29-5618a0ac0da6@loongson.cn>
 <741fb6da-3a77-84de-0f03-b925defd7f52@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <741fb6da-3a77-84de-0f03-b925defd7f52@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 09:16:57PM +0800, Sui Jingfeng wrote:
> Hi,
> 
> 
> On 2023/9/21 21:10, Sui Jingfeng wrote:
> > return -ERR_PTR(-ENOMEM)
> 
> 
> return ERR_PTR(-ENOMEM);

Thanks, now fixed up.

greg k-h
