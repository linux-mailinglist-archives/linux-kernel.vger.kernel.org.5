Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE217EBD04
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjKOGXJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 01:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOGXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:23:07 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47E3B8;
        Tue, 14 Nov 2023 22:23:04 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AF6Mj3421501206, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AF6Mj3421501206
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:22:45 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 15 Nov 2023 14:22:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Nov 2023 14:22:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 15 Nov 2023 14:22:43 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v10 09/13] net:ethernet:realtek:rtase: Implement pci_driver suspend and resume function
Thread-Topic: [PATCH net-next v10 09/13] net:ethernet:realtek:rtase: Implement
 pci_driver suspend and resume function
Thread-Index: AQHaDaOV4m3XpMTIGEaYaPZneRFztLBqD3yAgBDta/A=
Date:   Wed, 15 Nov 2023 06:22:43 +0000
Message-ID: <cb31aabbf5104992b299682f5ba0e064@realtek.com>
References: <20231102154505.940783-1-justinlai0215@realtek.com>
 <20231102154505.940783-10-justinlai0215@realtek.com>
 <0af3a54f-09da-4a8b-b385-c6968334ace4@lunn.ch>
In-Reply-To: <0af3a54f-09da-4a8b-b385-c6968334ace4@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Sunday, November 5, 2023 3:52 AM
> To: Justin Lai <justinlai0215@realtek.com>
> Cc: kuba@kernel.org; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> Ping-Ke Shih <pkshih@realtek.com>; Larry Chiu <larry.chiu@realtek.com>
> Subject: Re: [PATCH net-next v10 09/13] net:ethernet:realtek:rtase: Implement
> pci_driver suspend and resume function
> 
> 
> External mail.
> 
> 
> 
> > +static int rtase_resume(struct pci_dev *pdev) {
> > +     struct net_device *dev = pci_get_drvdata(pdev);
> > +     struct rtase_private *tp = netdev_priv(dev);
> > +     int ret;
> > +
> > +     pci_set_power_state(pdev, PCI_D0);
> > +     pci_restore_state(pdev);
> > +     pci_enable_wake(pdev, PCI_D0, 0);
> > +
> > +     /* restore last modified mac address */
> > +     rtase_rar_set(tp, dev->dev_addr);
> > +
> > +     if (!netif_running(dev))
> > +             goto out;
> > +
> > +     rtase_wait_for_quiescence(dev);
> > +     netif_device_attach(dev);
> > +
> > +     rtase_tx_clear(tp);
> > +     rtase_rx_clear(tp);
> > +
> > +     ret = rtase_init_ring(dev);
> > +     if (ret)
> > +             netdev_alert(dev, "unable to init ring\n");
> 
> If you fail to init the ring, is it safe to keep going?
> 
>         Andrew


Thanks for your reply, I will add error handling of rtase_init_ring()
