Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F77776B27
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjHIVln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjHIVll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:41:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BEA1BD9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691617298; x=1692222098; i=toralf.foerster@gmx.de;
 bh=cwSe+WBA5H0XhlY3bhmd2dg9cqpyzUft1setqAtjoWs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dnl0ks3bknx0qfMujdp1+lWghRQwqVfOzINrxe8ew64YYL8b1XsaGIH9Izo0qqc3WNaLfwj
 b5rVXzPEnKEZKMFIIBMu61ftWl7SR1djJ4Guq+cR4ziKbt8HXiiB0sjUJfbxODWBKT2u4vRTE
 pntWWu8riGztnfFIBOyMjuQqsHlGQ1+Fr3GlxzTOGOl3yQukazYCdNqQ2T+hpE2Ko500x/rBo
 VqD7TR8847E2M66fPPePm/F3+350DAgYwD+o8qkGIUX0jzt2WnJM5bG/gKpAF8hk08v2HyL2s
 m8ePnIbqaH9KWYIC3gYkftHekhEKpRaJ9w2wgDTXDLhsAym3y57w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.31] ([95.112.75.254]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QWA-1qPTDG0kQC-004UPc; Wed, 09
 Aug 2023 23:41:38 +0200
Message-ID: <aa25aa16-a99c-6b92-b15a-403eaf62f811@gmx.de>
Date:   Wed, 9 Aug 2023 23:41:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: few dozen pollfress.t segfaults messages in system log
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
References: <5890bdee-ead3-a5c9-46e0-7abb7de1fb15@gmx.de>
 <0072e883-1c09-4a8d-86f8-a3de26b18b1e@t-8ch.de>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
In-Reply-To: <0072e883-1c09-4a8d-86f8-a3de26b18b1e@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7lgbiU85O+v8B42ggqrgqgTBTUEVrcS8VVEeG3iXBecIxc5wr1s
 u5OVXs47btK/Owq82F8mVeJkf1blNowrLHgxptjvjvF9bmlY6rVq6eKaT3XHsep1P6/Z76d
 V/4QC/Skmhtc93YLyx5vtVmAAp91YzloW6IrLLSx8OSLDGA/PnuI2RSx4Du+RE3qHIJI6Xk
 +2lRUQYG33jNuVhgb5gNw==
UI-OutboundReport: notjunk:1;M01:P0:BHUBTdjNCHg=;q0P63uWLAeFi30Qniy4yjse06H8
 9qN6NJCyoaKdVPC8YPLzd5+waUJLcWAJEve5x4TG+IHhw8svbLW+Ab71ENszoKsNPAyKo9HuZ
 UKnc6QTOJ9aotCQ80oicDlIHQeseLmYvWWtDojq88eVUJGO8v/gE/xDWL9sMkWjCxHNMiQNES
 SoXJwNnHU1uI1LFnFlOtcyrLwfACZh8Idj+GpIYmbyluAZza8RMEhDd6whEizlT0kN6IYuO49
 QuAtlu5yxlMkg3dybfyP2DDkdPjjYMhFxYbrAIMtCG002Yf6Vb6y4eOmEcnrg7GrLZVG4eVxI
 2gIr0jZecXe7QS0ngP54mmY60owUuQvb5IMx0gpCXFNtB6YEI466X4xSXyWJjXsG0pLcSoqgW
 nbYjWiFENgbvKzs8BH3uqUJkPL1wAA86b/AS+z3jhYcX++gAvmT4d/pXzy6PjyROpVKy84lBK
 HyRaPnVFG38HCoHfOaWF+J75CpT1kDqJhEbeJ5r+gPWuvt4K6LBBgyEBw3BxKxD39RA9TaZjq
 lhvPMjEU+fOSAhtLVVYLuN6TwzATyrvVk8MICfD0LuWAOxH4G5vy4QSr9SOx0ddWwQoxlUDkn
 TzgaCZA9X1WikT94R8utjUYGhHpxw5I9qELyvVw1fJmUiZs5oJjgiZWZkNkilgpjkjA/24IHu
 /USgRKWRnP7vZbM6W9MtCBMx1Gev896SNruQWeKMFgE1xNObwVppA5tm9CSc3BBAZ9EryOodu
 bxacWdSXH1ATAoDAbWeBUjK2PSrX0tRRK42EXF1bOGnw24OEfQh0aSELTenpwO3vBecjdSm7u
 KdIFnOB8Ck3FWBAUI7VIdeJHD/jqlRVEvItGvFf/0cObheQnFWZ8rrMDdwebfI8nt/4f/S/lK
 17zgDggU6xfr8LaxxWDf+243GEI8pPNoxiF+X9HHZr/A5Uz9Q7mtS6NtV3vAURv5+s735+Kzb
 jngysfXlOLQb9Q4j832CnrilMUI=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 23:07, Thomas Wei=C3=9Fschuh wrote:
> Probably from the "pollfree" test of liburing [0].
>
> Thomas
>
> [0]https://github.com/axboe/liburing/blob/master/test/pollfree.c

Indeed, matches this:

/home/tinderbox/run/17.1_desktop_gnome_test-20230807-075536/var/log/emerge=
.log
2023-08-09T02:12:59 >>> sys-libs/liburing-2.4: 1 minute, 46 seconds

=2D-
Toralf

