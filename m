Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DFC7BA5F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242834AbjJEQWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbjJEQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:07 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FE022CA3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:37:55 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231005083927epoutp028c08e34f25ddb05a09334b83926cfe49~LKV3GWfNm2134421344epoutp02k
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:39:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231005083927epoutp028c08e34f25ddb05a09334b83926cfe49~LKV3GWfNm2134421344epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696495167;
        bh=HP4BL2iglEA1eJQlZHUrpKwMlDoT20QcCBtnPatJzkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BWrn62Jrlg+ELH5ly6lhkHHZ/W4mPG5VZWhjz8AI9+uePapv677OrVb9B26ZYLPfd
         lkTAKWjQi2FBi3ud68qHDkhSSzPCLcj4cHJH0ZbZyUFV9IR7n/oRdJkTSXkCGC0EL0
         i9qrdJ1MW1nHP/C0/uyxKIrAHjAuA7DPLmNC7R5U=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231005083926epcas2p46ca3c36aca47528894cf62bcdc972c4e~LKV2kA-FF0280402804epcas2p4q;
        Thu,  5 Oct 2023 08:39:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S1Q323CgBz4x9Q2; Thu,  5 Oct
        2023 08:39:26 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.70.09693.E367E156; Thu,  5 Oct 2023 17:39:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231005083925epcas2p3baeb8107f2bd65e3ac836d5828e9c297~LKV1qJHYz1270012700epcas2p3o;
        Thu,  5 Oct 2023 08:39:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231005083925epsmtrp2cb41f8d43a45aa73353d305eeedb20c9~LKV1pLsFV0926809268epsmtrp2k;
        Thu,  5 Oct 2023 08:39:25 +0000 (GMT)
X-AuditID: b6c32a45-84fff700000025dd-71-651e763e4c33
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.6C.08742.D367E156; Thu,  5 Oct 2023 17:39:25 +0900 (KST)
Received: from jtpark-7920 (unknown [10.229.83.56]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231005083925epsmtip1066be9634756f22caa9d5d337c24e935~LKV1Y_VYw1747217472epsmtip1L;
        Thu,  5 Oct 2023 08:39:25 +0000 (GMT)
Date:   Thu, 5 Oct 2023 17:42:21 +0900
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>
Subject: Re: [PATCH v2 0/7] cxl: Fix checkpatch issues
Message-ID: <ZR527XYR2WKRRapQ@jtpark-7920>
MIME-Version: 1.0
In-Reply-To: <2023100506-arena-sip-e5da@gregkh>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHd3nt60PX+axV7lBJ88BkoJSWUngSIdtQU93MiLrgtmzwRm9a
        pLRNX1ExcetWFKgbSkgDLdTIcMOUCpF1gij+4IebBiIBgxbtMGpWfggD61iyZc1KH1v873PO
        /X7vufecewlMNIjHEkV6MzLpGR2Fr+Bd6ktUJmcfikOyyoZ1tP/pME5ba5sBXWcfBvQvvq9w
        utXnAfTXrX4+bW1ux+n55yEefWPGIqAHh6b4tLtpDKebB+oxeuAqQd913uHRo92NOD1++lYU
        fXFiDn97teqy0y9QlffP8lXNV6eiVB3uKlx13eURqKq9bqCyN3ypCnbE5RIfF2/TIkaNTBKk
        LzSoi/SaLOq9ffk5+cp0mTxZvpXOoCR6pgRlUdvfz03eWaQL34KSHGJ0peFULsOyVEr2NpOh
        1IwkWgNrzqKQUa0zZhilLFPCluo1Uj0yZ8plslRlWFhQrL3oDPKM09FHAg3f4RZwkrABgoBk
        GrR5hDYQTYjILgBb7Fk2sCLMLwC8veDEuGARwKmq8/iSasngarADbqEHwPFOn4ALJgG0Tzp4
        SyoemQBD988Llhgnk2Cdw8JfYjGpgKeGnBEDRk7yoPNPd0S0hkyH9XN9EZEwbBjy3wccr4a3
        Hc8im0aTKbDpL0ekNCQHCdgTnMC4M22Hs/2LAo7XwOmfvcscC4NzPThnsAI4E7jH44JyANse
        di2rFHDOF4iUxkgtrHvZiHOtiYf94zwu/Qas7PtHwKWFsPKEiHNS8Mz3Z5bPAOGIy7vMKnhv
        emK5R14AF2+2gdMgzvnKhZyvVON4Czx75UWYiTCvhy0hgsNE2N6dchbw3WAdMrIlGsSmGuX/
        j7jQUNIBIs86aUcXqJ2dl/aCKAL0AkhglFiosWxAIqGaKTuKTIZ8U6kOsb1AGR5PDRa7ttAQ
        /hd6c748bassLT1dnpGqlGVQMcJfj7vUIlLDmFExQkZk+s8XRUTHWqJEm6jLdiywG+tF8bs8
        Bwo0UlupZDTxQF51Ass3LTxEK7sLRE/2Pu2ouL7/A9zRJH182PMHMgaGU088+DTm3fm9My/T
        P3lka0luenytUwx2PHpQUcCIV0nHFJv3UIaf/t5/Y/MPsTFlI+7cZ8dyDipCNeOK1xb7SexS
        b4W/8Nrvg5lTd3JqL5yiazYGqFaV+8K5dzLxb+p/vNvxbdXwWytlt3aNVh/s2XkyRMxfWVxb
        0fbZ50eO+ryu5yMuyTnrgBnm7QvNBVPimpWd7a9rHd6P8C/6XHnZEx+++Zv1WGJ8cEPK7sML
        6vWzCY1PxIaEUctY/h6ybNWm9pja8trjkpu6jVsoHqtl5EmYiWX+BZtFcuhfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnK5tmVyqwfaFmhZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmsfjoDGaL
        o3s4LM7POsVicXnXHDaLWxOOMVlsvP+OzUHQY+esu+weLUfesnos3vOSyWPTqk42j/1z17B7
        9G1ZxegxdXa9x+dNcgEcUVw2Kak5mWWpRfp2CVwZ2x6tZC9YxV4x9+QhtgbGJ6xdjJwcEgIm
        EnNnT2UEsYUEdjNKrN5sARGXkFi+4QUThC0scb/lCFA9F1DNM0aJKa8WgTWzCKhI/Lu+gh3E
        ZhPQkpg+swEsLiJgLNF/dhY7SAOzwAcWiYY5y8A2CAuYScx4dxisiBeo4ezd64wQU7cwShxu
        bmWHSAhKnJz5hAXEZgYquvHvJdAZHEC2tMTyfxwgYU4BfYmFv2YyTmAUmIWkYxaSjlkIHQsY
        mVcxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTHmpbmDsbtqz7oHWJk4mA8xCjBwawk
        wpveIJMqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1Oqgemc
        Wt7m9XunrDtnIiW4I/ahwWzO3NUv/1re2fV9z4M9yjd3vos7pXPbuOfVpuADPW82hRtItRXx
        aWy+FDfd7t1fn6kTvlyc1b7PY07jN5NtfALPenPcTueWz+LiWJEyRyqyov6b9A/B7+9+TO5M
        jUzWeHHz69HZE86Feqb3attHvrY4c8Bl0ullXByih3WmqmSu4z/qMdtzV6P7BmXpl098IrZf
        Kp9bmHm9tjXg9k29IyU3Lk0z65APeisf6nyWf13F2RerGra2R628GuIreX6fd8mFJdMX1n5i
        evTtiuynGy0Hj5TIL5E2vXlD+N02BruQRX9fX8ncdvXHQ7V+scsLvSIPXT0o533cb6KI9/uL
        EkosxRmJhlrMRcWJAKNuuqIkAwAA
X-CMS-MailID: 20231005083925epcas2p3baeb8107f2bd65e3ac836d5828e9c297
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----W0Xmz0KnCHm4AUy7D1SfHXLrd_ueEv6xw0V41DtFjSLTJg.k=_9a853_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922113157epcas2p212c253d8fe4f6935ee5cbe284254cc68
References: <CGME20230922113157epcas2p212c253d8fe4f6935ee5cbe284254cc68@epcas2p2.samsung.com>
        <20230922113443.3297726-1-jtp.park@samsung.com>
        <2023100506-arena-sip-e5da@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------W0Xmz0KnCHm4AUy7D1SfHXLrd_ueEv6xw0V41DtFjSLTJg.k=_9a853_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Oct 05, 2023 at 10:08:42AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 22, 2023 at 08:34:43PM +0900, Jeongtae Park wrote:
> > Changes since v1: [1]
> > - Seperate a fix for whitespace error/warnings in memdev (Dave)
> > - Drop a fix for a traceevent macro (Dave)
> > - Add reviewed-by tags
> > 
> > [1]: https://lore.kernel.org/lkml/20230921025110.3717583-1-jtp.park@samsung.com/
> > 
> > ---
> > Cover letter same as v1
> 
> None of these emails were properly threaded (look at lore.kernel.org for
> proof.)
> 
> Please fix your email client to do this properly, your v1 of this series
> was threaded correctly, so something changed here :(

Hello Greg,
Sorry about the problem, I guess it's a internal system problem but
I didn't figure out the root cause. So, I'll always test internally
before sending the patch series until resolving the internal problem.

Thanks!

> 
> thanks,
> 
> greg k-h

------W0Xmz0KnCHm4AUy7D1SfHXLrd_ueEv6xw0V41DtFjSLTJg.k=_9a853_
Content-Type: text/plain; charset="utf-8"


------W0Xmz0KnCHm4AUy7D1SfHXLrd_ueEv6xw0V41DtFjSLTJg.k=_9a853_--
