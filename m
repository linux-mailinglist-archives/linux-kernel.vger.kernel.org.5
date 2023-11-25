Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F67F88D9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjKYHgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYHgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:36:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079B510F4;
        Fri, 24 Nov 2023 23:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700897776; x=1701502576; i=deller@gmx.de;
        bh=Jwgibb2fomrjAzXkh7r2S8EujKwqMStjdoKTR4kUDYA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=bkv3YOmjVLDcn3pGWVTAnfr6rPNSeEHmCIKHWuorz5iTbIOhb6rMB2EGzH0haVh6
         8k0ndsKZTmk1sfj0fW00ofyQPXUSA59eH3GLJm52bN6GAK3Yv9/6/SHdgOuKd12ir
         msgj+rlOcymNc2y3raFVrRPilfrSApBSshoEVy3xx/EXE2OG0rEsat9Zl5eGWEQ5N
         CQk+CZEd2FqE21lIpWV+9hWbHjt1onMlubTdxI33K4hRPvx6Y34Rw967oM+jEZVJn
         /IXgSAOlSGeSNAYrqpM0LsGUfRRRtM/7oE4bJLQyZNl/HMkGu6Kr10irs2pOXptSC
         xwn9bWEILSR0jfjoAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.47]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1rd5Tq0mzm-00oFqm; Sat, 25
 Nov 2023 08:36:16 +0100
Message-ID: <f745c363-7efa-404d-94c8-b9ea64c11814@gmx.de>
Date:   Sat, 25 Nov 2023 08:36:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/297] 5.15.140-rc1 review
Content-Language: en-US
To:     =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        hca@linux.ibm.com
References: <20231124172000.087816911@linuxfoundation.org>
 <c0a5a523-708b-431c-b212-df1af5ad7bc0@linaro.org>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <c0a5a523-708b-431c-b212-df1af5ad7bc0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IjQ7ctRhaIh1L3MmjBlnLlXaZ0lZPOIo8bmKz7UIVVdFcKzHVot
 gm9JECq0qsDnPF8noJxYRTLXGv1IJg1fWNA1xKTyL1zByoOL+cr8ho7S7T5DXbPnt92rMdW
 bCa7w1L7va/CXJA1Yfb4en5pxALfi+GnC4itlEL4LmYdspwusrB06+4zlwfUI602QmGh0Iz
 20TYpBSTZ1LVTavhgxPxA==
UI-OutboundReport: notjunk:1;M01:P0:l7lBwklm00w=;KelamkbzJpWeTf7/PvqTW92fhuX
 4I3cms1NQ/oVSBnBS71fGHF+x4Zx1A4iqMh/3BKOFn3cSxcH5QhNRH6RCGmH7kO/AjzuW0qjb
 vDypzBm7v/P2e3JFMc7UOs1WEGKdhVW0UtZJBps/BE96tDpIEHN7IWxDJRqiVZfFd8pp/OYWE
 m6D+ANblGGmz4ZKHGgzR8gt1zBfSyI60crDpa8ozRRwENFBo6WOcTquP8AvPNMWwQt+RmhQLe
 gCk6CgRQ1SWLe+FAzYJzIYK+J6oM2dnLsLHnlvcpssCR6jvanDWPoCiSERkrQL2G2Sj5IMGWO
 diQd22ZN7gsXM803Hn/bAmPXsGkhvBg0sXAcqQKXLiI74hpy7Zbzwaap93eBykVS2SnaBlMEw
 Ie+ckPNWl1hXryG2SBzH8bTB6B7Q2YOphj4fhDmMMUJGS+ew/1Dm9aUJlv+ZGTjB9GaR1zVyz
 IyOun614j+Fk8j45iFL/YnHvJjivJ6nkd9Q3a5CKNMSIlGZc/rUOw+HwltUmRpHRwFgY1oRVW
 10BfQljKoHin+tXmevqAiiwLnF1TkHisyC4ShNhwD5+PQWMp7Y2aC+ajFMZ6ORVVjo5WNIIYv
 20gnzl5rqJQkn9OBvhU/Fim70V0ima98x8yYB7NNbYEUaIfPBNrceNNGQ3RlEIg4Gq5oc0RA+
 3Ju0NFuGeeP3BQVkxZdvQ0UDlMu6akKsOKIJMwjzZWX8/i0uoNsMcgurcBdVuyam23klGAKG8
 7eDYzBLv836DPxEjZNlMOdAhmsT6IIjqND8bhW5EcdT7QRGDk4ZoLFPGMgbRKykaZbKa5tYRa
 o6n3uk20dMSHqarzoeqgk6Xkuy2VfcsgLq25OU7Tx17lQFSPiAVTDPZSSUVjvfyO5f6/co2Yp
 6wu3gzdMSi7yYUZSL4ElBM+DVjeD1Bny7DOh4wID2cuVpMbe17mDrOYbdam1OfrdosCAnBRj6
 zQ+MLuupzj8mLP/Gi6xJrBcTNxU=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/23 00:21, Daniel D=C3=ADaz wrote:
> On 24/11/23 11:50 a.=C2=A0m., Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.15.140 release.
> ...
> There are problems with PA-RISC:
>
> -----8<-----
>  =C2=A0 /builds/linux/drivers/parisc/power.c:201:34: warning: 'struct sy=
s_off_data' declared inside parameter list will not be visible outside of =
this definition or declaration
> ...
>
> Bisection points to:
>
>  =C2=A0 commit 065a7d0b92c0f1ef4160e2129d835eb6093cc675
>  =C2=A0 Author: Helge Deller <deller@gmx.de>
>  =C2=A0 Date:=C2=A0=C2=A0 Tue Oct 17 22:19:53 2023 +0200
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parisc/power: Add power soft-off when ru=
nning on qemu
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit d0c219472980d15f5cbc5c8aec736848b=
da3f235 upstream.

Right.

I already asked Greg to drop two patches from all queues where kernel < 6.=
0:

- parisc-power-add-power-soft-off-when-running-on-qemu.patch
- parisc-power-fix-power-soft-off-when-running-on-qemu.patch

Helge
