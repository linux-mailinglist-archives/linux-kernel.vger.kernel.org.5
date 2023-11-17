Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1807F7EEB45
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 03:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbjKQC6s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Nov 2023 21:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQC6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 21:58:46 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3AFD4A;
        Thu, 16 Nov 2023 18:58:39 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AH2wFfuD2828931, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AH2wFfuD2828931
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 10:58:15 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Nov 2023 10:58:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 17 Nov 2023 10:58:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 17 Nov 2023 10:58:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Kalle Valo <kvalo@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
        "Larry Finger" <Larry.Finger@lwfinger.net>,
        =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Bither <jonbither@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH] wifi: rtlwifi: drop unused const_amdpci_aspm
Thread-Topic: [PATCH] wifi: rtlwifi: drop unused const_amdpci_aspm
Thread-Index: AQHaGLeBWrapeatKh0yfAlT9pSLygbB90jaA
Date:   Fri, 17 Nov 2023 02:58:14 +0000
Message-ID: <d370746955d347a88cccc953caa87551@realtek.com>
References: <20231116180529.52752-1-helgaas@kernel.org>
In-Reply-To: <20231116180529.52752-1-helgaas@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
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
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, November 17, 2023 2:05 AM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; Jian-Hong Pan <jhp@endlessos.org>; Larry Finger
> <Larry.Finger@lwfinger.net>; Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>; Jonathan Bither
> <jonbither@gmail.com>; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; Bjorn Helgaas
> <bhelgaas@google.com>
> Subject: [PATCH] wifi: rtlwifi: drop unused const_amdpci_aspm
> 
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Remove the unused "const_amdpci_aspm" member of struct rtl_pci and
> struct rtl_ps_ctl.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


