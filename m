Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A908876B4A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjHAMV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHAMV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:21:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B76710C7;
        Tue,  1 Aug 2023 05:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690892512; x=1691497312; i=rwarsow@gmx.de;
 bh=mktVTINu2XoBBO2DUti5V416Vyw65PoMqn/e/11azKw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=qyzJHP9UYtMhWe+o5l1hJq0yVj+T+tdDQSpexKkMQaVewquVVve33GoklsgjJspf1oJbItl
 UYjahc2eky+BjmEiDLcGVIQes7a2X+wK1YMhTLNS1jTdj0deVXCEPg6rUoubRJxj+1FYTi7sE
 2zak8fw6cCxqkSbTOx/skPY365t/0pdttGpb4SU7aBMUm6MdhkdJY4V3J6yOrJtJj7Qy6+yxw
 dqIiw6QoFKZDYw38z+unOrPvDnaytFmludvQdVYsfNlcV2cHGreLvo12gJg688/qknh88f+DX
 ZPdFHXVwftjOP5QkDV7pM939bVmtRMDBiqNOO2KHFTQBrlQoW5uw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.0]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC34X-1qYkSz3F09-00CNrG; Tue, 01
 Aug 2023 14:21:52 +0200
Message-ID: <d8d90867-4365-d670-76b5-207f2267e1fc@gmx.de>
Date:   Tue, 1 Aug 2023 14:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 000/239] 6.4.8-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6nMkuufbWqz3i7bzxm4ksUbxQl2/jTes0bMkUVYO4gV22JxiIlh
 DhcrNLs2TkttS2pctvMUJIoA5+HaHvAI133EHtglWW3CICAT0ynoqzuff20soUYdd3RYgL0
 dVT5XGVkGfIShfTMAeHNCuWwSWS54gzNJebXcLM1R1245iz1lXcPCL/DkXpMS/Ik3TFIzU4
 JK8IOhmcgpSQDt7PYcHCA==
UI-OutboundReport: notjunk:1;M01:P0:JjKJ+UlwOnc=;fD/UoziHHd3WtDTdL0GWjyOrRVO
 4xcJkKM8dFzdVAXFdydtITaLRTF5ghL13PmRsVqKAWw2SDZZIiDOOL70+i9mBWR+Lkt6y9o0V
 oxn1Jle75I8NSyaTFwU+BxVAb131ihfG2dI4ayGTJwY5HKLXuxvCCcCUuWHA/yAstB00hPTQg
 zUHnPi9VVB3b+/dzsKWYGw9+lGXuEXduVzNxvKgKjmXpoQBp5ezSxIfLp2G/esaw1mOcl2q4n
 2x+rPpux+KhktqNz4EbniD5ya9Ee8gd4xHSg/Bm/Btvh2/1yzfb0/ErSwYcEPhV/PsLONOy0r
 jocHlldVU79eucpjeX0+R0kXPNnxrrXl+TQO/PX/yBhrJqrxmYvxsOTP9Zqo4OzaxD8D7btJ7
 GADSoLU1jtKFd4NWJw6UhaSHktR95nXCvaJvfq+IB/5GIX8UQMxKYxj5x/qZQYQ2sZfRkJmzz
 ycm7gBLLfatIzVjlnrdVXX1eJVT+dHcIkodmHMepzMAfJCS8TNfIVrjfTorafRKn32L4VWdBE
 6Ir9QVJtJodbn6NstHGSiBsstCJl0XXzaljDGbm0OZSJeW0I5tz36tyczbW/ZaJTZI+7KTKdD
 7bKIEwvw16ASzanrQ8wSJMT4zhl/TkBbdfgkpBcQY0ge5ZXH5evUayZgA/fd5qhxrqgYHqssv
 BIofz4OTUtGkLgEWcnP3UbYngSchDf22JymesRviJnd1t26121x8KVnljIM5StdnKrB7xi8Xg
 qNe12I9hQ7SZtGFN5eFgxcaBmttSiCExuLxBGT/oebwiKSeBQdtzos2XWY7eHbUPuBkvyiPfJ
 HMRH7GxBIyYw4HYbxCShGj7GcwVabNn15PmL3tl56gp96SkN3cixBcDk2mQbeOFpLUjvYpOM7
 4UwFAIijLYo4OVxvjSyXU7Il66HhfcwGh6fdEmKukLEabx1BxFcivXpCu4Il8pVZaN3RVhChJ
 +DRdew==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.8-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

