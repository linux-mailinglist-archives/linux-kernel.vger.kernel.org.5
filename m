Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7D7D3FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjJWTJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjJWTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:08:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9526894;
        Mon, 23 Oct 2023 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698088131; x=1698692931; i=rwarsow@gmx.de;
        bh=Vwi4d8U2WvHM9a1gBvzV+bFasTgXN5c/Ui5gdhlG6vw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=mfColSN843shqALpswDQpgyUzNTRyglDU3kHMOC+Tr1zKsdgv5HYrBLwGsYOXC5P
         9ugpN1BpKKi3BytE6wY7cI4GKRf4NAGFGBLe2Iv8U2aH2zp0RYPtBWJvaq/YCEtGx
         J8tRBuUgOA4oCkZYEIwY1ikCHnloJyP9r5DPuuSf41GHQYMOQ3kV2St92ZubtWo2K
         lqp7kznzILw0t/hHieMaQF0rdf8s2X45QkeIu7djRUg5uMT1blz3Kc+uEh9HM9ZNn
         BNnq2P6xbkdGnYEuEDR95FOns3OH4F4Z5hQZX2T0yM79MGBAZzjkzc4JYzP30v9hK
         Q15ZtSRQz0kfKYOH2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([92.116.253.225]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqaxU-1rGurC3nGa-00mfUM; Mon, 23
 Oct 2023 21:08:50 +0200
Message-ID: <d7bfd814-91bc-4455-8a07-854eec908466@gmx.de>
Date:   Mon, 23 Oct 2023 21:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.5 000/241] 6.5.9-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jlqcWaTAtIZAVMLIwJPaSfMwi7bV05GnLrdIutsSqTEZaLMfCh5
 0YsyOIS+aJdo79o5IHYhNrLdQUuy5A85RMpykjkoeE23yWtm3Dc7dQ6gOA9taHjp8CC6SIi
 1G5uAXEj8pUXfQoIDbeR8GBrsY9YuOD2jkRfirvATGn9jqWHVeIcKWNN8MnRsNiPrq5P/hh
 khN/n/o3Om//+53jMgz4A==
UI-OutboundReport: notjunk:1;M01:P0:GpPTMPAX57U=;YAnuBFsjwcAH1pRVIKy4ifHhnQk
 eDcORdaYjg3d9VWf6RNi2LfSg0KFlxkcR41JpnvHWm/0ATa/FbeR2ye6jSpZdDjx+QYsIIqV7
 8cQBhalYvMuCeGj1d5qfKnOIB1CYJKpLOPUcbD/OF3ak/5LsuXhxoliu9hUBcADgWV4daKavT
 R/lqmskJeFouB+EJFiumBdZMrR86pjpHDbxRhADOWej4+wGPBP0QjjbcnaAf7hsORoYGuuFdC
 w17StnPmj56o6P4+elgSalJpzkg+gknlqFDZ4HdLdfpA+mmo8eEIle+U2JKCQFPssxXbeJD9K
 c4UbppWm4HXJA2GIFzBj77eJHwbZzZCKFTxOvifmaD6YbGX1n2XK6OMEWG14gclSQ3UVJEXnX
 qGUTK6k8ZZJIuV/AgMuR4ybNuh5k758CqXWQHPzcwGj2D0JTm6A0PbnPBCOV0SLuev/LQCf+a
 ekbzP/Jv7hz4SiB6oGVfuBiWdpf4dwPpWH+vk0EtD16C27ahfcCPoXebDotyvIebafzpiKFmy
 4PgoJ3IDjUYiNoP9ix9gVbd2n2KddhlK2KnfrrGjGM54q7gfcx59QQViL06KveMYar1b0JvTi
 Zi6xbUc4SmXg5s5Rlo0bbRlzTuGKrPqylSMfA90BFEolBoIq7i2L8DHcqLp2fXfpavpXpIwa3
 ww/uvYfqctcj6nbNbAtQWSWR6fRIj57hQr9pDet+B6duTDxWFoqSpgxVZFXfmO7SHTiJEgfs2
 7sbL+W4g8ydMwlNE6o5DUgIwOyBwSmw0vipIZp+hpf65jYBvIyl68GroyG5wB2HSS6jLks12D
 eqieud4GSzBZr5mItcIhBO3PVvlvVfYGu+J7wF4aCWFv/52iPGES1MgmG9/UCSlfYM0/Avyyz
 s1g23NqVFedy1361+HtthHhhPdTEtdWb7xQolMkfIuAb5j8z7NtozR+AJ4w8MsTmxumZy+h4M
 W2xnAZjWWXQRqEzq9PD8mTU5zvk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.5.9-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

