Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BCE7CB713
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjJPXg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjJPXg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:36:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C53892;
        Mon, 16 Oct 2023 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697499408; x=1698104208; i=rwarsow@gmx.de;
 bh=6IvihHYt4182iZ1JPPf7XY96JwcyzEeU+3Q/kzRZ41g=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=A3lRTN7v2Y3oZ/32FoE4V4IJmQdoadJHaaENOC8+aB2q5lnDj6CkFrUlnxa40FqKDHV2lpb/Uqx
 aNiNuWLjnr65qjYJuKbyez4IsOYnw2qxij0TUKykll0ZbPcHNInJboGfdZbMonah6SUr0YcijtWgQ
 QoiQn/Ug56KOGPBQedDpW03kaGj80bk6/J4+iw8WtiKPa+rhgsyh/Bo9nDOsjbPfgJYJYKlZK9ILa
 sKOeHf+Dvec2TnV0l6wPWTeszaNeNE0VDfoHyV4E+u8hXtj2QXmgB5Mh9H71JjySY2RzLsWQCpcXU
 tbixjfQ/9c9uRZbCZ3FitnsJxC0rDAhWrFzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.211]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDnC-1qh15y2g2Q-00Cj2X; Tue, 17
 Oct 2023 01:36:48 +0200
Message-ID: <13a70e4d-77c2-4820-ad8c-be6b67ae0438@gmx.de>
Date:   Tue, 17 Oct 2023 01:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.5 000/190] 6.5.8-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ySoDl+yh+Sx83xpD59gIYZ6OcoTeZzQpADrK3o0lTeir06pZcUz
 QbZ4rcVr6D+DxdKGnoRCoUqNPDwbutS2ZllCwlVmFsi56nc/XT41F6ZDB9R5effIpgep5g7
 +h10xpbkdxQo1IRnTMuk5D7YX0MRFb5X/zX9jObLO2vX+czzFiTXAcjgWAUOh62HNFfPLqe
 8ywl3H2L5qJEd4lfcyqCA==
UI-OutboundReport: notjunk:1;M01:P0:7SbJfnle+cw=;kCl3J+0pgqlZpNIp05L8K/mtw9W
 sl4z/efFdGTJzEwTxPOKK35mdmJIGvTPfBZ7pRSiGlNmwapOzMHZyEoyfmFGpKieuNm+cWRWa
 hB8tvBE9tkK1joJYdcKxMsDSALkcLyHaaC9GrYPzcWV0SBs8LDxYY1+TdxKD7QYZegvem3yaa
 0Ht1vH4/BwoeUXdH4f1vsbHwsFRVuXGMakSCBjfRL3JoBvkJbEyYfGObFApQolKFGfEP4MtgR
 wARleWy61rZZaqnraCF/MD25hMqdwB7WFJuyU8TjN+ToobBJ7s6zGfRpT5pbHPCsq9RLOM0sT
 1CqOGjU+zTvlREGqQs0UZXBm3xpmJ84emPNKt/9bJPKkuy69XHWGn/T/MXrDbdPr7CSMN3Phv
 /RwFk6K8Ut5Fa0YwwXyEuy0w7NcEFC4mh1edI/DAAoHM9hWHGiKsDJoJTSDZWfunmASL0xKT0
 ZLef52CDnGieeFwzWdawIyudjrI594H6nbRmCuqkSGdY1mSLEqe63jSKVaeJg37ENtZ87yPLa
 r7o5aPmuZsqHRo64V+i/7pRlVawW3lPZPq7C+E5lN1lL4d7MzetcrEMOpMD1iGK1J31nM0+NA
 iE9iy4CVyS3tPF3g7zf3WcWzaM6nSQWPKUi1tfsOP5i3d/yjZ4m4N4j9LFW5Ac4SwQ00T8NWj
 IpiOsf3z7cBv+jltGKoy3yVfyDhxcwskVwzwaqzJvHGO+cDM/L6HuZq2FuGPuhBZa3051zswi
 gBtQ7DeICA/n82v8O6ARHGSw91LwyQGwepTJ7DIDTLnXboCQM/XuAvMcAzmooHGkzB1r3GOAn
 ldxynh0s4eIjzdqZL8NdNSxJqEnP68TQmOGrSvcJmS2Rqa9ePXyTTsyRY8GwU5MYGETSsAmZO
 N7uiL9ctBI8DXwVe8WepwL7xy74nFtwAPpMmBqtrE8wImTTXHrnJOinJ/esDtcMFjB8ZzzmN/
 pFsUxA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.5.8-rc2

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400, Fedora 39)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

