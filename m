Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30FC7BB00D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 03:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjJFBX2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 21:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjJFBX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 21:23:26 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E1DDE;
        Thu,  5 Oct 2023 18:23:22 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3961MSNK01139866, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3961MSNK01139866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Oct 2023 09:22:28 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 6 Oct 2023 09:22:29 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Oct 2023 09:22:28 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Fri, 6 Oct 2023 09:22:28 +0800
From:   Max Chou <max.chou@realtek.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Hilda Wu <hildawu@realtek.com>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Regression: devcoredump patch broke Realtek usb bluetooth adapter
Thread-Topic: Regression: devcoredump patch broke Realtek usb bluetooth
 adapter
Thread-Index: AQHZ9iZZqIk9cnxrEkOIPrwHFnXgfLA4N/0AgAA1ZDCAABycgIAAkrXQgAAclfD//8ULgIAC/Ddg
Date:   Fri, 6 Oct 2023 01:22:28 +0000
Message-ID: <732012844f544d0daf790434025c8fb3@realtek.com>
References: <20231003182038.k57nirtt4sonvt7c@box.shutemov.name>
 <ZRyqIn0_qqEFBPdy@debian.me> <b2ef2f1c457a4cf7a246b2e8b8598a30@realtek.com>
 <20231004044947.vgegwvxxindkjo7g@box.shutemov.name>
 <7507ad6c8a964b179bf2b3318104a124@realtek.com>
 <20231004114609.dca6ebtmx37fsx5l@box.shutemov.name>
In-Reply-To: <20231004114609.dca6ebtmx37fsx5l@box.shutemov.name>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.132.197]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! 
Realtek will send a patch to fix this issue.

BRs,
Max


> -----Original Message-----
> From: Kirill A. Shutemov <kirill@shutemov.name>
> Sent: Wednesday, October 4, 2023 7:46 PM
> To: Max Chou <max.chou@realtek.com>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>; Hilda Wu
> <hildawu@realtek.com>; alex_lu@realsil.com.cn; Luiz Augusto von Dentz
> <luiz.von.dentz@intel.com>; Marcel Holtmann <marcel@holtmann.org>;
> Johan Hedberg <johan.hedberg@gmail.com>; Juerg Haefliger
> <juerg.haefliger@canonical.com>; Linux Bluetooth
> <linux-bluetooth@vger.kernel.org>; Thorsten Leemhuis <linux@leemhuis.info>;
> Linux Regressions <regressions@lists.linux.dev>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>
> Subject: Re: Regression: devcoredump patch broke Realtek usb bluetooth
> adapter
> 
> 
> External mail.
> 
> 
> 
> On Wed, Oct 04, 2023 at 07:28:45AM +0000, Max Chou wrote:
> > Hi! Kirill,
> > I guess the root cause is as below.
> > ===
> > static int btrtl_register_devcoredump_support(struct hci_dev *hdev) {
> >         int err;
> >
> >         err = hci_devcd_register(hdev, btrtl_coredump, btrtl_dmp_hdr,
> > NULL);
> >
> >         return err;
> > }
> > ===
> > If CONFIG_DEV_COREDUMP is not enabled, it would return -EOPNOTSUPP
> for hci_devcd_register().
> > Unfortunately, btrtl_register_devcoredump_support() will return it.
> > Finally, -EOPNOSTUPP will be returned for btrtl_setup_realtek().
> >
> > Could you have the following workaround for the root cause checked?
> > Please share dmesg as well. Thanks,
> 
> Yes. It works and I see
> 
> [    3.640539] Bluetooth: hci0: RTL: btrtl_register_devcoredump_support():
> err = -95
> 
> in dmesg. -EOPNOTSUPP indeed.
> 
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
