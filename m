Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8298B7929BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352491AbjIEQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354240AbjIEKSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:18:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E8118D;
        Tue,  5 Sep 2023 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693909109; x=1694513909; i=rwarsow@gmx.de;
 bh=c4fHQPHws65JO89LsQ/Laf/HVZ2SdFLhfCFFbpfOw8w=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=fP25vM4CT4E7mSTUD4Dt+87cvQ2V3s0/aE+MQR2LqJUewxQGrovC8CCMkv0uxBJaL1ig7BK
 6kRdUD3mIEyT9lxMKnNoGzgFnYXT0jrdo/3IJSHSiOkLzxzhaQz4l8ZbzN7rdH49QjpKoNcfH
 HXkoD27gyier4Zesd4QjvQMebWSK/zolHMU9QltclVZm42mn9EDTt29/TSFyufblgMnkUjZdY
 /KpL+3ELTE62f429OUmxg7QOi1T9TFSDS1jIh63J2+j6N4S7hOahHiU5R7CmA0jgc9UdPtkRc
 Br4QAFeEI2oRRKx8knVTroT1eBw+Xk+71vqalNRdKOXBMaYXsCQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([92.116.253.191]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs4f-1pqzI53awj-00moGv; Tue, 05
 Sep 2023 12:18:28 +0200
Message-ID: <1dde4946-491b-08f5-c9df-dca35e160101@gmx.de>
Date:   Tue, 5 Sep 2023 12:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.5 00/34] 6.5.2-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:q2aS8QFtm2CXKtpfL7K6p6oL1iaMUDH2NdwbHycXeWMozZ5tDN4
 qZ+sLzg68Iie/pFVs71eWvZDhE+jpwY3lUl1sUrQdoak/fNc3tKaZwqKxruEkEFIWyiwxBO
 A2HeUFAs/SREjZBwEpJAtnyRF/dJeJmyIASMWVd5/vcjON07uWBMxGGVwYrR9xTlFfSGDqq
 FhEugzd0hRVH5dzvk8t4Q==
UI-OutboundReport: notjunk:1;M01:P0:B2buhQqn1KY=;WYY8I11vu93zEImuZD1NSTd7NA1
 h9eiuXSHrsWzpl2sAYC8Ji4tCrGdSgYr85pQ5tvZzjTGlRV0DWQEXBO8mELcZfLANGsN96seK
 vWctQke/jlZX6tZmO1zfc/7mX4u42BNb3p7FoayL4vuh5Vl2gFte7MPBcCeCF00ZOCeC99vq+
 mLcqJlUHgrX4OylZySbYk3PUA+WwdC2OjeF6S+MeGYleXbRWqo3rNCGNCydMg9XlTW9lSeJSL
 GqAL62J5M+/kTo3SAYQAOkgaM60ejcPM5HvF+wa37ZVF/1lumgdgukI6EXy/385YwLTmXCMoO
 leW6QPw+eUIeWFNCo3ZjoOYCy3YERgSofNyufWTtwAaX+5tv/bdDtAzxb3CdDKR8JFkH73Xwe
 2wuttnfEeNLxbh+fq0tPJx50TtxZXKNiD/g7NDJLwm/rnthTs55+Qrgnnuowo1ZJ2RliVKVqD
 GX60xBN0lPhlRMDkpZA4306Ydpaq/gALdP8dbRo2tlmd6P/4RAr3JQpFtnBqfe5+dtqBYl3Ie
 yF3OjCi+O6wIAOajSK3dlGORf4RFOsVQObrbJszl/gO+CUn8XEKqgPBe2Lg4IiRbZZTaCXwfS
 xM/4rwiNKA62hepas/SOojZbnr5QqXa3d4DDXweomx9LYkFCSm7fDOcPLItk50+Sz0QzXZYxq
 YsDHrjI9LQvHMdgbjUEAVKk48XtMFfCpjIHsITGuYg5SdKWHPlUZc3o3iMrtenb5nEwTVyYRp
 +6k47dzrHKxp5ZNo99NqHoL+TD/OrVACfHbWKsZSzGe6B4FOxV8lnbdzr7Xa++sbVUV9hkpog
 da5DADfMJ45tqtPNuQkZgVUKIh4cwlkPCBfcabAXpbEzETT6qiTvUAtb33GIZAwkmLUeIuDNs
 B7bmzhbfDFoEY2wSdw/lWUYIFVLB/FQYOtYWaGO3QvpzdZ9NHIPB3zbPVBP41g4QTEkKffGb8
 y6VnIw==
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

6.5.2-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

