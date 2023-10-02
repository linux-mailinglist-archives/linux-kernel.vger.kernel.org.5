Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5470E7B5005
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjJBKS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjJBKS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:18:26 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE069B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:18:22 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 78439120003;
        Mon,  2 Oct 2023 13:18:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 78439120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696241899;
        bh=gihR/S1DCyiMxC/Vg/56xeeYgkpAuulABcEXgW/J6P8=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=AjgTCszjnCfvQ1BGCY1Es5tdB1mwau0qeJ0FUcLWPMwnY13IavSJDsP0+0i5oqwb6
         O0JlRzJjC3A340H3nbA66kYfj6OPdO1FKdP9819nlV3ruu+LLL57ePJM6TYeqcLU3l
         T6eSghFaTAptoCrZDZoS8PnKJ4WncNy5aN8jU6tyo6jIBQkwQ6F5U/07eLfhwjSRm9
         GWUMDA/q2gd+jM7ILCdBpsG6GCihQ7EDQ4cVaetVOYUWm6jeAtoSgQiZ7qI5vX9W40
         8sxL4kQUNAsVujDyHaGI3wOmfs2ZRE3IRTLO/scHi6MMVw+TKnGxYe4k/8V8ElpPOy
         TtUr0Sjg/zP1Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  2 Oct 2023 13:18:19 +0300 (MSK)
Received: from [192.168.1.146] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 2 Oct 2023 13:18:19 +0300
Message-ID: <54227489-519b-3268-885f-cf7a9687822b@salutedevices.com>
Date:   Mon, 2 Oct 2023 13:18:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] mtd: spinand: add support for FORESEE F35SQA002G
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <kernel@sberdevices.ru>
References: <20230929144934.192649-1-mmkurbanov@salutedevices.com>
 <20231002114450.4ce69141@xps-13>
Content-Language: en-US
From:   Martin Kurbanov <mmkurbanov@salutedevices.com>
In-Reply-To: <20231002114450.4ce69141@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180264 [Oct 02 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/02 04:45:00 #22022763
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,
Thanks for your review.

On 02.10.2023 12:44, Miquel Raynal wrote:
> Hi Martin,
>> +static int f35sqa002g_ooblayout_free(struct mtd_info *mtd, int section,
>> +				     struct mtd_oob_region *region)
>> +{
>> +	/* XXX: It is not possible to partially write to this OOB area, as both
>> +	 * the main and OOB areas are protected by ECC. The user needs to
>> +	 * program both the main area and OOB area at one programming time,
>> +	 * so that the ECC parity code can be calculated properly.
>> +	 */
> 
> Is this comment really needed? I believe it could be dropped, unless
> you are really experiencing strange subpage write attempts?

If you write separately to the main area and the OOB area. This is the
case with many SPI NAND chips, I agree that this comment can be dropped.

-- 
Best Regards,
Martin Kurbanov
