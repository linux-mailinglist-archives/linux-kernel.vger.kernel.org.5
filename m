Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B271477E521
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344081AbjHPP2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344169AbjHPP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:28:17 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B102102
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:28:14 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 6D4DA100004;
        Wed, 16 Aug 2023 18:28:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6D4DA100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1692199692;
        bh=WE0hIh5RLBABYfVTZR+pWZ3G2DbPLavvbNDma5RqYUQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=OCAU+WoGGr5mo0/LaK5uScFYuclofAwnb4U5NcZP09BHntYjGIu+wflQrFBroWvHX
         wJXcFYrNS+P+oYbadIOkI+K1ukx0KDD3WdsxRllCeGkwstPc4fOMHBDonmbQUVJq2Y
         FVX9BdLrBGSUUx4USXQuqqzzi8PLJsHZpQGb/c/+y6rAeqXkxExUaTiatMonfuswXb
         wCydyTOKhrCwFcvCAqJZWJqLljy4nmWCWWTMtkOTzoyv48zxHHkDlWcVKeafb+blkF
         YaIvFDD1+MqmXtKvrpTc4X4hCGweaFQ5n+8suyqCAH7f5S9cKF94F0CyznkhPfL55V
         jRqXxwJxEaquA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 18:28:12 +0300 (MSK)
Received: from [192.168.1.146] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 16 Aug 2023 18:28:11 +0300
Message-ID: <b619ef58-06c3-c61a-bb0f-ba243a4a2ade@sberdevices.ru>
Date:   Wed, 16 Aug 2023 18:28:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1] mtd: spinand: micron: correct parameters
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>
References: <20230815161024.810729-1-mmkurbanov@sberdevices.ru>
 <0f54b3dd-1fce-4f81-8652-d50fe1bb3873@kontron.de>
Content-Language: en-US
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
In-Reply-To: <0f54b3dd-1fce-4f81-8652-d50fe1bb3873@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179287 [Aug 16 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: MMKurbanov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 526 526 7a6a9b19f6b9b3921b5701490f189af0e0cd5310, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/08/16 12:02:00 #21629266
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder.

On 16.08.2023 10:21, Frieder Schrempf wrote:
> I'm okay with 1. and with adjusting region->offset to 4. But I don't
> really get why we want to restrict the free oob data to the
> non-ECC-protected area only. Is this specific to Micron? Other SPI NAND
> drivers also spread the free area over both, the ECC-protected and the
> non-protected bytes. Why do it differently here?

We encountered a problem with the JFFS2 file system: JFFS2 marks erased
blocks with a marker to avoid re-erasing them. To do this, it writes
a special marker (cleanmarker) in the free OOB area. And if this OOB
area is protected by ECC, the ECC will be written. However, during
the next write to the main area of the same block, the ECC will be
incorrect because it's necessary to program both the main area and
the OOB area at one programming time, so that the ECC parity code can
be calculated properly. Other SPI NAND flash also susceptible to
this problem.

-- 
Best Regards,
Martin Kurbanov
