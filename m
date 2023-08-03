Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D5976E9F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbjHCNWI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Aug 2023 09:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjHCNWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:22:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFEDFE46;
        Thu,  3 Aug 2023 06:22:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 373DLOonC021118, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 373DLOonC021118
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Aug 2023 21:21:24 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 3 Aug 2023 21:20:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 3 Aug 2023 21:20:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 3 Aug 2023 21:20:46 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     Jiri Pirko <jiri@resnulli.us>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driver
Thread-Topic: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driver
Thread-Index: AQHZxeQMA/4O5CExTkOPXZ48NozVXK/XvyuAgADLZRA=
Date:   Thu, 3 Aug 2023 13:20:46 +0000
Message-ID: <14e094a861204bf0a744848cb30db635@realtek.com>
References: <20230803082513.6523-1-justinlai0215@realtek.com>
 <ZMtr+WbURFaynK15@nanopsycho>
In-Reply-To: <ZMtr+WbURFaynK15@nanopsycho>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jiri Pirko

Our device is multi-function, one of which is netdev and the other is character device. For character devices, we have some custom functions that must use copy_from_user or copy_to_user to pass data.

-----Original Message-----
From: Jiri Pirko <jiri@resnulli.us> 
Sent: Thursday, August 3, 2023 4:57 PM
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org; davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; linux-kernel@vger.kernel.org; netdev@vger.kernel.org
Subject: Re: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driver


External mail.



Thu, Aug 03, 2023 at 10:25:13AM CEST, justinlai0215@realtek.com wrote:
>This patch is to add the ethernet device driver for the PCIe interface 
>of Realtek Automotive Ethernet Switch, applicable to RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.
>
>Signed-off-by: justinlai0215 <justinlai0215@realtek.com>

[...]


>+
>+static long rtase_swc_ioctl(struct file *p_file, unsigned int cmd, 
>+unsigned long arg)

There are *MANY* thing wrong in this patch spotted just during 5 minutes skimming over the code, but this definitelly tops all of them.
I didn't see so obvious kernel bypass attempt for a long time. Ugh, you can't be serious :/

I suggest to you take couple of rounds of consulting the patch with some skilled upstream developer internaly before you make another submission in order not not to waste time of reviewers.


>+{
>+      long rc = 0;
>+      struct rtase_swc_cmd_t sw_cmd;
>+
>+      (void)p_file;
>+
>+      if (rtase_swc_device.init_flag == 1u) {
>+              rc = -ENXIO;
>+              goto out;
>+      }
>+
>+      rc = (s64)(copy_from_user(&sw_cmd, (void *)arg, sizeof(struct 
>+ rtase_swc_cmd_t)));
>+
>+      if (rc != 0) {
>+              SWC_DRIVER_INFO("rtase_swc copy_from_user failed.");
>+      } else {
>+              switch (cmd) {
>+              case SWC_CMD_REG_GET:
>+                      rtase_swc_reg_get(&sw_cmd);
>+                      rc = (s64)(copy_to_user((void *)arg, &sw_cmd,
>+                                              sizeof(struct rtase_swc_cmd_t)));
>+                      break;
>+
>+              case SWC_CMD_REG_SET:
>+                      rtase_swc_reg_set(&sw_cmd);
>+                      rc = (s64)(copy_to_user((void *)arg, &sw_cmd,
>+                                              sizeof(struct rtase_swc_cmd_t)));
>+                      break;
>+
>+              default:
>+                      rc = -ENOTTY;
>+                      break;
>+              }
>+      }
>+
>+out:
>+      return rc;
>+}

[...]

------Please consider the environment before printing this e-mail.
