Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A330876179C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjGYLuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjGYLuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:50:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB21FFF;
        Tue, 25 Jul 2023 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690285776; x=1690890576; i=rwarsow@gmx.de;
 bh=NpgYHY92yhV2ghhqvnhRZPVQ8bxQDuTD6hTJWP8TYdc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=gE+y/NKTe3o5dRCCb8hq6xVu32ZaPoXV7eFJqtuHDDFfWXjpyluFI6glF3ZqK8sak52Qmuk
 4Y3dW9HT39Z+rhTM0pKrP9VYySBa30A6mPXveONOs1dDwlJNP72mwLnouQtkevuPMZ5dYYnPM
 WHZCT+DGtdCZmS064aKjhQLAU5PXzwyc5w1tmR7DZm//Har1EQBX6SkE937Xy/ZoRP6Jfgux4
 ZePc3u3Eis+1SlLmBU7q1rCma6vy4vrGoXYFZiPPH4Pqi6wrkn9PfFBBTcFnkxfYUIVjvWU44
 htxRokk8KO8A6PD8/lV08utRS5GRtiYsZaOCIID1/DVmvPNnPe/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.33.156]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1pkVsl3Zjs-00dnR9; Tue, 25
 Jul 2023 13:49:35 +0200
Message-ID: <c2f6b497-873c-cd0d-ea36-4d8c6ebe4f39@gmx.de>
Date:   Tue, 25 Jul 2023 13:49:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1uLTZrxHFwwSE5x+jFwl5SSnFtvfxBgotAsj0XJVKmc1faTAKvB
 w2RSRjL71j3vfxhfK6UKJaJk10bsV5+GxYjnQHZP1W667QAW4VMqRLOnHTMdgEqbidGoWv8
 bk0ZXAWn8YuPVyNLkmL1MdHtOGbPosjUpPR2Frr6Vrr6a7Gc+9LUUf4ie1JIVXfM+ErVR5K
 sOy1I+skfLmJsTRUwqT6w==
UI-OutboundReport: notjunk:1;M01:P0:vGgSNf3lHVk=;9KTRvt63Rlr3Ki1DZijNpMG+bwO
 axHoHk9itTrBagkbt9YY9EMbrCfGJ3JKVF+cB8kve0CGMtYB7J84vBKb9N9+oB5HeS9axD9mM
 z6GX729HJiM2TRTNKeHg3CJBxEN/svYM3Oea4/xqaKqWZox9EhTzQzLMfRncFrYs4Xtyy2aze
 EPejHA59g+5FKmRY+QVV+VCqOAQakFJl9kJuXX3Eih7rS/n+kplv80McMd1TSPqnsBzbbZPY0
 HQbSo+ADcJctkTnp1ygahMfV62KRXTwPLcqTCjknEPnltEqjQkIqaEygRfcnsFf62E+/aISbz
 JUT8KFHYUDv3ESqN8G+6BLp7HaBDX7XSGBpaQdZN+gsKwMMwVZ4sEpR/5fyhp6JCU9s5EeRrE
 BOHezYvSQ0ewyKR987JEixPpRQg1D/pdIC/u6T2xZYh9tMI0mzetfSUIOcvPdvVkePd36ufC/
 saC0n1E/rWgohWn1HeXxCG/M0l7Usemd5LRWTt+ih7g6YdkXagP/cC4v/5yizpYntjrhZMxzS
 AQClXaRSlRiMdV+1iB+ziwdB9qqD7WnVniJYpRdeOSD40puR+k9ehjK3wMskFdXtnkmOxsO+7
 IjpB0YLVOduvyzFxmwZMgbmTq5/axLwV4nk7ZMfWlEvxdBIMujscUEqrzAikB8/2rFoAH5GSZ
 bHKIkhUkxlC2JEg0oRqy1hur8BYUxrKUOjKDZt/m5sKBzfk3A/lBxxcMLskQ1ERJBUtUC9QxY
 2kH9aYUbxGagY/HvZMSEI3XCODZkN984aQpz2gxb+MElGhG+TkwagHdP+/LyXruCIVvKm50+T
 vwmqxPdK/FgPhP28tocomc+pbrfgexfVZ6qt+37TcsCfQorq2RumrJNgaaXZc0igsh+YAHCY/
 R1iFL+cb56iRFriT1HPDeM17WCcgVRoUH++yh7YZjMcAoYfFdhdVh1nFHVirSPRMggEWDYYDI
 QpCzJn7cQOGxhDSHMFp6s4boPLU=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.7-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

