Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99C4756EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGQVQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGQVQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:16:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8EB10A;
        Mon, 17 Jul 2023 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689628585; x=1690233385; i=rwarsow@gmx.de;
 bh=cp34G7n/hkObA70/N9UlcSOa+T7VU8bOugpzbbR3ask=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=FgY0op/tOBeqGVuY1Sd14E/lzYw3mPQ44ol8+HCIWeRU6p731KuejxlyxDYuAve0l2s7QTf
 suetf37qlKoFHR9NBgc1OqNh6zZb+I7U3+UP/ZQBt8MCuYGoSw2iqPViSISzBRlhkOlItH2SI
 CsmZ69lb26cYZhyr7d/2qtfAJadSsgBPpqp1CWkVlp1btI9kaBUxv6g29zQF44vODwvsJMsFV
 zb/mIsOeZKnFvkXzVmedsXB3Dh92TMMkj9B1jgIPk843pOl6O7ArOqt0qbc5p0eEQNY7YN4Dy
 kFADn8zgdXN6RAcqNmtWsfz3LShDv3qsh5Fdrg06KROZLb6tFXvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.130]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiU3-1qV9Yy16gn-00Tz8s; Mon, 17
 Jul 2023 23:16:25 +0200
Message-ID: <5b98c5e3-30cf-3cc9-f26c-e67b3f0dada0@gmx.de>
Date:   Mon, 17 Jul 2023 23:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 000/801] 6.4.4-rc3 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Vys+Z9pNk8AS7mqeHR6ZCd5aXs5T2jth02+fHajuw0w6dzJFfjE
 yOpjsPQKbC2hCHQUeZSELlSP0iLLsQDfQzfIN4ZruNVuUjLtzalFHuSL6sr+3/MCxsf6VDy
 JN1arhkyn0kZLVMYBotyTEy1UraU77UvRjAMP5lda8NzrcTkIe2D1xibqjL9Q6o4DM4QRWt
 Nv9iR6+N7sgQ4AGrkjkXQ==
UI-OutboundReport: notjunk:1;M01:P0:xnnYeCiMmvY=;9OwVnQLNsdu4pDyqlOb6Kpm3pSH
 Ab1IUOKrCfAzJkSfnHvGBxb5fY9gSdiIkVOoOUHgMKyb0wDZBFSPQD6suVbWN88dkTQIAaXi1
 Cy0X5FxpTro4xzuVfEbaPhbhdLsdBDOIDtzAu83S/u9M4Lbh/49ZV9MFzJJIbrGKiJhSeeEhU
 OzKl1oS2b1Uu2JbiJcrMwyXVurk2gOZW6aNkFEWqhVwRed7S4X8NND6DJNjdUsw056AY8dJRj
 kXJTccJaNlNhuTh0yRx+ZBPXw4OJxciBwpECnIUStsZjMLzfgfGypv1SEHTEaM6rAX/8jfg56
 8QL0UXnl3RWnLWlIO/LaSQKlZYGptyg7L6kj31aBkhrMvXs68kbsCml+8+hYkr5DoN/j5vQug
 dSqBYFE3PlZRbPDRLhWtcTeudRJ0mJxBs8XHBMBUd7q1DIyBmjexAq+1BBBVV+7yGUi0HEHMa
 ewf1SJgX9dsluR91YlJdv1RKDCOnK/IAR2CXEZyXx3nJkD/2/SMj0QmCjc9fbtq/bp0Pndu0O
 zWBuH1fEqhsHKQXKZhH1pkcPJS+j1FkBglyJrIxCQ68gh/c9nQOMlBWX4ZIPESBwJDsrhR4rr
 DXQkIYAcSSjfL8i64CIkFyGIwt6dPbIngATdIMPifDa2M4ikBrRL1Ul6lAbjgaOY39cpHA9N/
 LKVedg8DyQqnomGTIXjQM+m0DXl/7Anot2epLw4vBft3CVJf3wLiuNh0+7R9HtiGYML9m4k3U
 uv4kpDLA3q9juO91y2EYhkB0KdEec23l3sr/arvVviGvvrK+8Jd/yFSvaldFxyXTZJo6G7lat
 iDNvJ6oOFG8aAbfspPuCtSYpZAKyxn2wr4lPQyyF5lTrU/a737ZxjB1HvRVMSrHjorqAH6GEU
 FfFJg/ZdPFtac+0E8aE5EtkTl0INQHQNwEci6dc1OFpr1ONlxZUrPTv4owHwGu5EEgh2aQwQv
 J/xGpUUkWDC3UoReZdEAelWsD5g=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.4-rc3

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


