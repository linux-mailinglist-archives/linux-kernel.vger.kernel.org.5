Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E70679AFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjIKUuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbjIKQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:01:27 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4878D1AE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:01:20 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 9CFDF100015;
        Mon, 11 Sep 2023 19:01:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9CFDF100015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1694448077;
        bh=MroP4rwnsamgJLJnZYVtPvV46wh4z7pTWxArWfdDHq4=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=QnKewWnmeMtPyX16ACf/TBj8I81H+/b99Mhbily/nj8kLg82A/FRFTfTbCVCs/P9q
         3d5NkywuHl+yNWpd9+uO3lV9sfa1e/Mmv6YiVHeExm5kO9SvBgDQMmHNZ8IKWfa74S
         oG0UNYNLBQ7+KA31uPIXA8wLaYfto2+anzaYjrqL9bSc7YqN8at/AUU26qpzyaljcy
         18l52HVhXekxOVfb8B5QgxtWgEw+RCVaD9xtc5lbGFsk8vFULKWahqgoKtoWNeXyAl
         LYhHVciV2wceJ3xaggB46hYM9TC9unTKwJeTWwt3+xp4yhx4lbv7OknHRnuOEfiSdW
         JhjOSoLkLd0Xw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 11 Sep 2023 19:01:17 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 11 Sep 2023 19:01:17 +0300
Message-ID: <23fdbc3d-415b-32cd-988d-54c2dac43341@salutedevices.com>
Date:   Mon, 11 Sep 2023 18:54:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: remove 'nand_exit_status_op()' prototype
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Johan Jonker <jbx6244@gmail.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230823105235.609069-1-AVKrasnov@sberdevices.ru>
 <7ab06111-5208-77b2-0f09-0751de23ae66@salutedevices.com>
 <20230911151110.09cf4c00@xps-13>
From:   Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20230911151110.09cf4c00@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179781 [Sep 11 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 530 530 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/09/11 06:02:00 #21866861
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.09.2023 16:11, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@salutedevices.com wrote on Mon, 11 Sep 2023 13:30:00 +0300:
> 
>> Please, ping
> 
> Please, -rc1 was tagged yesterday night...

Got it, thanks!

Thanks, Arseniy

> 
>> Thanks, Arseniy
>>
>> On 23.08.2023 13:52, Arseniy Krasnov wrote:
>>> This function is exported and its prototype is already placed in
>>> include/linux/mtd/rawnand.h.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>>  drivers/mtd/nand/raw/internals.h | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
>>> index e9932da18bdd..b7162ced9efa 100644
>>> --- a/drivers/mtd/nand/raw/internals.h
>>> +++ b/drivers/mtd/nand/raw/internals.h
>>> @@ -106,7 +106,6 @@ int nand_read_page_raw_notsupp(struct nand_chip *chip, u8 *buf,
>>>  			       int oob_required, int page);
>>>  int nand_write_page_raw_notsupp(struct nand_chip *chip, const u8 *buf,
>>>  				int oob_required, int page);
>>> -int nand_exit_status_op(struct nand_chip *chip);
>>>  int nand_read_param_page_op(struct nand_chip *chip, u8 page, void *buf,
>>>  			    unsigned int len);
>>>  void nand_decode_ext_id(struct nand_chip *chip);
