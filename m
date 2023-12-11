Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73B080DB24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344912AbjLKTyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344862AbjLKTyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:54:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D635D2;
        Mon, 11 Dec 2023 11:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1702324477; x=1702929277; i=rwarsow@gmx.de;
        bh=8KlHJnuA72R9SrdvXZ8yaMIvL3ImxkLdW597YLJpmfw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=Wv14qILkgA1kJfOEMIh3A+rwRa55J/viWqnZ8ELb/ulK4xOhsUy1rLzMtc70ij/+
         gDkehuFb7xZQ4MDdjlg4cuQD+GCto25FN47+3EB02E3KhSUWrLYxsDYFbwSDsH65o
         ENMWPB4VIJMoiJZCuve7y8Be1NxeZXRUkJlfzFcwAowRB9AEcHIPM09P2rZpM+o47
         sgkDi8msKQ+EKVoM7Og0mdQ3Dl8Qw4cZZJ9N9y2VZutGMu7FfyHXV/7IdCyP2P9zs
         lUErbJron2ijFHQTleP8l6FUV6leBSozZn6ofyjtc7D+jPq7jfg+TssgF10HXy3ZC
         xcfBH0fyhS5N4RALow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.40]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhhX-1r21mM0cy7-00Ak41; Mon, 11
 Dec 2023 20:54:37 +0100
Message-ID: <3ef81819-bf8f-41d6-b7ca-056a5e504c4a@gmx.de>
Date:   Mon, 11 Dec 2023 20:54:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:u1lQ37dKsqvvot9YOsyRd22BFMTNHILRsVxzqV9Q+gz9tz8qCIE
 dR6jBQsMPvResC5kFud+RK4PBGJd0rxIa1fYzuD+qvIorobaEK6CZFu0w1OmFzY5FzNs1uM
 UBmvq2z34RYyb4WICNP1rWnE5CukaqGRSk3UodWWLklvbflaCUGv9koqT4XpYdw0sVXmSi0
 vWHX9vUM6RC5qPobNrUaA==
UI-OutboundReport: notjunk:1;M01:P0:/EUavIKcD0s=;Y25OqtS4TecCNE05RDaMg71CRRx
 02FEu5PLeDvS8BSUje+Wn0hI6KW6pgOrciCq5tD/Bpibbpw6EuyNihg2HomQQZgJ1RjrwAsvn
 uvvZ6ZUMzAQ2vKHLdF8u2vOrF2Bv92Dyi94BsNN/vm87vjqAAqQYT37DjTmjku00WuI337rnT
 0mD/rg9z87ukEs7gSSXwycNtS16VauGzsOPEknDbRYIrvKclQ8YE1d2wfemw2Mv4VDwbBZEjb
 WOi0xIiybB4O6ZmmEcjRCzUm6Zv8z2kWN3xCSabaxmnrTAfBsgWzXh5L/S01a2WuPH//vTSDn
 dUvAJhxduFY1TTH0hyr5AjfjQOixrPKocKGWop9e0cx/cYngx98E5hC5wFIS6GMx+HcrxhOOQ
 kfqrTxqkIRVBf2WdVfnREe10bzlaOvEm136GjZHwj1J7AP0sgfcBaPxwPidJhtjAeM3elrEc0
 OLAgSriutldB1G70yed/dQQzJ1xUORfpIyloH2CxuBo8SB5h934aRYKJmVoAXX5z70fQplLvt
 XbQ3vsxPKMGAJhEZu0CUQ/Zu+yq3CVWRcGFtznXh/DXQp8dwWEleGYp5NGo28DKuiTbF4aqv2
 ONn6UA7uTt+LimuE+hOYm7eGbY7ymVMTjPGS5cUAxcIQ1JwUv+ZZ0uuGp9Ax814/uCpmJke5s
 nUVE8AQDWRsrnOv8yv+CoRcb0UnvDNHLz0VFf+kiBRSRJYf9A5A/+5sLj1DZdkYj0LCwbkxyS
 fxo1IXnszXDe0q9HJgkg3GrlMkGFiyF4ab2WHIdyWqOCKOtwU38faUgMoubAqJTEx/ABBhMS6
 FE1qpF090DhQSkyC7nsN8+jZetT0Qaf5cWe9jYHE4+vT8m6EJE7bgEaXsHrqDz5ZpHe5yXBJi
 Q9S5CJdcqdo4eAnklULQuLAL/oSk+SIIBPXE2D4wSrSCKkdX1THcVRBM38bRLiGPkEJIvEh1U
 WRA5Bg==
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

6.6.7-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake: i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

