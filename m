Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466D979AE46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbjIKVOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239893AbjIKObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:31:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AEDE4D;
        Mon, 11 Sep 2023 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694442654; x=1695047454; i=rwarsow@gmx.de;
 bh=kqEiy54vHn9A4hNDsY9RHpQci3bLlNR1YiGevJHTVVY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=uf3gdlve24u9lyCpemVAxC1VET+HgN1VCnUvOop78pCXTjVEfxRya6vSsC3J4PRLFHQq5iJ
 K8XJNOmT/Rg87EzqFfh5pPkV9ggPm5JQSzZ70r6X/JDw1pYQ7tUtDEJT+tU4E8brQgWjC155e
 DaW37iqVL989WA95O+Bjkyqts0IwVd0hJDE0d0bTL1QjtVFTRAfy9FxYipbv+9ceCJ5T4IHMs
 qnJKnJp7K7EEzkxWbpksX7hf2/EYWCwVYm4X5fr8vCQBUSxkLgQKxjSC08hjliJm15gW3Ak2W
 mLNMSr9+Ba6rFcFcWCSg4GGgWyuW6Od4rtgghVW2tyX7zMD1mG2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.50]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDEg-1pxoTu1HpA-00iEBd; Mon, 11
 Sep 2023 16:30:54 +0200
Message-ID: <800b38d5-c66a-bb9b-1d86-385dd796b34f@gmx.de>
Date:   Mon, 11 Sep 2023 16:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jx3m3w0du9Nmk20OGQaMPYAk/aAHTmJHb4zV8o6DROZNTjxQrjJ
 Wfe8l4igtZuWpAEEJTmEv7y1gdFevXYo9ag/TrkFd1Y7bBZZSKzqJvT5g4t9e201EQSsKuc
 ITuJH/4eQ0mixlQcyM+oYcDXvwPHjMBtGqXoGO31I2VGPikhKFRKo32Z7xoTAddShINKZze
 yOsKN1w11iNr9mTMeD0TA==
UI-OutboundReport: notjunk:1;M01:P0:jEE64T2UVY4=;AtX7Q+Q2xBzwRKEYY7RcT5D86ij
 CLYS+rqMA+rGjsSYfr2f6iup3wbGgV19hGRmjIp18GTe6hF7GpUNzy6uUeQXCjsj6PcclCd/u
 me7rmgIoIp3XYRtI/zGk+ska1STBYRpbVk8qYODHpCJvncfVLinuPNbsrIuuk2x1vvKHTZdfV
 dL2CLz5gu3oHztVqXzhr2lePPk2navUY3li9Fg977w3LN8DCEuvtCFrRg3EgMmuu3yvM4aPdt
 jS9mudFwOzx4fgEbKrA4DZV0Hnvp6DrV17F39MJC5Go4TYMiPwfTq2p2cqEa5a+ZNN1fXca6i
 a5XCBu36Q4VSWa6R5OZuEPpGZdP4XvoYLtzQj+/1uT6hfezOBOF2cS+1vwuM82tBrpPhQkye6
 YYETZbJchNddXvlRJ7kClP/b30amA4HAoqduZVZtQpLt0B6MAG6kw9lFxxGaIdJNH8VXOuFJW
 HluJ9BmBymysCwMipqQUCT2sgZ61YZ5EUY8WndimBEJQQDqCEwL0kFrdKQ/ACACEOjhWmU9TW
 PGfRUeZKHc0UyVvIsWCR4GzVcGJ919GYa/iRVfR2zJQgGPDx2ePY9aLFQXAPzvt6XO4a2p0vL
 /KsWGE4FIN2mzhE40YGTTaIWa10T82pVamRBbdClYZM/XzJaUZskKI1y0b1MEbiTvdRd7mjO9
 hlakBfuQQQUAlCPwMHv/sgZjTMSIdazlzJgy7K2ZfcDcL4/g5Bf/ZYZ4X1DHVs5fTPlXvyaZ3
 Ffrbvmbcb+NR2mbBMrn7xV712vbrC/YwpiJiPuz0oFxSRleetDR2wxTPjRrSRAFWJb9GePbZe
 GEPnrSJku4nS7hOvSBxjPBfOp2y535rONADjZs5rQn3eWyir4o68r/pYoWUA1dN4JTlimULMt
 sd/xIhn4Br8S6yuQOQF/lG6RIPv83ZwYwl7d/uSgd3iwm8aouRftgay7rGwn/2X4AeHHMggbL
 oPWRdw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.5.3-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

