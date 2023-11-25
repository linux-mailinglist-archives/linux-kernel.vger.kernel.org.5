Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C927F8F81
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 22:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjKYVfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 16:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYVfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 16:35:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C021DFF;
        Sat, 25 Nov 2023 13:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700948107; x=1701552907; i=rwarsow@gmx.de;
        bh=1ViR2q+lLHjx6xB2g8xNd9bb9wkyrg+ce5BDNw9CTwQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=S1l5Ynh7uHHxHW/3g0UuTPGX146apF/QjIj78Y6pSxP/P6o3Mem6Qui6keVa/BlK
         cNvBYH0yx/7RUjpV47w9jREpJcjaiI3qCfDzmkAU0RIcxMTyzf2zmPvrqWN+P0G9p
         uhzBPrY5qQS0qGwgSY28ga0oC4VITOX7eNo/mjJScsQS+Mw/XwCCphr49Bkz+kgGk
         PBRulqecCEzUj4w7bxL4G4Dw2DiO7fmstwZ1URjSEKoRprG22YmV9QqQZbzpWnxno
         JQPyXPNEbMC3jUF63TI/eidOljFcsuVa2r9S8dgo14NvdQDnubHLCE3ujsqqKAbE6
         iG1RiXDAE1PSkZrhMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.101]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1rI1qc3fp2-011wuj; Sat, 25
 Nov 2023 22:35:06 +0100
Message-ID: <88e0d84f-5274-4642-9b1a-362c0c45a4df@gmx.de>
Date:   Sat, 25 Nov 2023 22:35:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.6 000/527] 6.6.3-rc3 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uBKAEEz1QaldOHAwLt7VHSXQzL/ODc1+BQZzbhInhpBYKzR3i5/
 kDqCPMrXGOhV7l5EH4Wbtl6bzOEfRLoEXjKUK9CGjXRch/j1ORG8Gi9v9wJAyBfPnLGGKh+
 YsjZg1qlJEn/2mHrB3R//GExLLPQ6kMCAeazTtRnsXk5HyIrcyeGtazxMn89xODM+h5pjGj
 PTb+pChDxJgHFIOCaZ/OQ==
UI-OutboundReport: notjunk:1;M01:P0:wcprku6m8ic=;/weCsdrNdwQbUmXmtLCWIXyYO5i
 ElUzZg0SYe1C2fuXXVcZ33+CLfR9XR4cOVI9dGsMxy+UBqgvT9vb6+JYwapklVkvCWByRFTVE
 N4YODinvwPct3YFT4z1uJJxmBITtm25ZWmIKl5kQ9NFThuigjsUx/0b27rgKuhIWAEP9Y5cgf
 ZN55Emit30+D80L0SJJ9d7iv13X+2QgX8nh8APy+Hg76GhQke9woiZa5dncmzLVEg0uSgObyO
 v0BGLaBGFxRvZTpfTlVTNVFRxCg1rWKlygXjdIcI2doxYxlwedg/ttvR9z3DTtUc2Y4kcBy16
 Aq7ZA3WiL5pCF2geRKyUXTfBIFjsKOAUIEWoFaJE/SQkchfcy8Cvyw5LFxm4+fegsokFsABgL
 PPRp7KFcmsfHnH7HJAT+HOOmSWtUqn4n45o/q65pc+Xg2MNHCgbkTYBvd1n5jJACxb3RlhUAp
 mfLI7yBW02AqOxbhOcsxkSVTCsPgLnvYD3QJjzgTpROHYKNaRph1LQMFVyiF2QuaD6dwgWKzv
 KQtzwcrBFCvux0KJzz5eV+3ti8IL+x1HoJo6FDZa6M4ptz1ZKN4tjGWJSk8BK2CImwgfjOUPe
 omFYWrcHSxO1JbNwPKm7tNRANyRdbyk89hQuLEpHJDgU6xiM/BP0I9vLR4WQCju1fjrsL4w/A
 RJf14lOhAquRzio918SLxU1xyZIxHtsMje9qrzlyJbm1+bI0Dsr3eYCNmJc7yjNykVBjC0ZV/
 S1oDhS15hchmokWxkgd2A3Ska9wlwPsRgwXC9L88lltjWAGVSvcqwvXFcK6rIjydBonGiDq6s
 9f+sTWagIY3zFXp21KanomHOXUdFxql+FCbC7YbZ+eovC4DA8Cz0QsOzFUjycQah28UlYa5G9
 F2k0cC/X5nhhbJskfjP4EZKZDs5BtaHzabMEJiBMAeQ51yCI5imfUefhH6nmSRWDd4XdtjOZT
 k0JzP0mirO6Zm7Ap00SG8LBw6OM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.6.3-rc3

compiles, boots and runs here on x86_64
(Intel Rocket Lake: i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

