Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6414C7DE9A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbjKBArP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Nov 2023 20:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjKBArO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:47:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F61DE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:47:11 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A20kiqeF2130566, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A20kiqeF2130566
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Nov 2023 08:46:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Nov 2023 08:46:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 2 Nov 2023 08:46:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 2 Nov 2023 08:46:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     kernel test robot <lkp@intel.com>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>
Subject: RE: drivers/net/wireless/realtek/rtw89/coex.c:1448:17: warning: writing 8 bytes into a region of size 0
Thread-Topic: drivers/net/wireless/realtek/rtw89/coex.c:1448:17: warning:
 writing 8 bytes into a region of size 0
Thread-Index: AQHaCyb77GwApLO1gkiavUd4YVAIPrBmM1uQ
Date:   Thu, 2 Nov 2023 00:46:44 +0000
Message-ID: <92fba00735f3483cbbc77ad986cd7c16@realtek.com>
References: <202310301908.Wrj0diqe-lkp@intel.com>
In-Reply-To: <202310301908.Wrj0diqe-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antivirus-attachment-filter-interceptor-info: license violation
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Monday, October 30, 2023 7:48 PM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org; Kalle Valo <kvalo@kernel.org>
> Subject: drivers/net/wireless/realtek/rtw89/coex.c:1448:17: warning: writing 8 bytes into a region of size
> 0

   drivers/net/wireless/realtek/rtw89/coex.c: In function '_append_tdma':
>> drivers/net/wireless/realtek/rtw89/coex.c:1448:17: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
    1448 |                 memcpy(v, &dm->tdma, sizeof(*v));
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1442
> e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1443    tlv = (struct rtw89_btc_btf_tlv *)&btc->policy[len];
> e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1444    tlv->type = CXPOLICY_TDMA;
> ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1445    if (chip->chip_id == RTL8852A) {
> ce986f3dc4fc69 Ching-Te Ku  2022-07-25  1446            v = (struct rtw89_btc_fbtc_tdma *)&tlv->val[0];
> e3ec7017f6a20d Ping-Ke Shih 2021-10-11  1447            tlv->len = sizeof(*v);
> e3ec7017f6a20d Ping-Ke Shih 2021-10-11 @1448            memcpy(v, &dm->tdma, sizeof(*v));

This statement is to append a struct named rtw89_btc_fbtc_tdma to value field of
a TLV struct, but compiler warns dst of memcpy() because of tlv->val[]. Maybe,
this is a false alarm?

Anyway, for this case, a simple assignment "*v = dm->tdma;" would be easier to
understand what it wants and also avoid compiler warnings. Then, I sent a
patch [1] for this.

[1] https://lore.kernel.org/linux-wireless/20231102003716.25815-1-pkshih@realtek.com/T/#u

