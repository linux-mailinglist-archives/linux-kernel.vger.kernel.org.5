Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D9F75AD01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjGTLba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGTLb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:31:28 -0400
Received: from ir1.moh53n.ir (unknown [178.22.121.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153D6BB;
        Thu, 20 Jul 2023 04:31:26 -0700 (PDT)
From:   Mohsen Tahmasebi <moh53n@moh53n.ir>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moh53n.ir; s=mail;
        t=1689852681; bh=NZGHI5T/zzMbFiaNzKqeLSzUzjtjUhcS1RDGMu1Zgtc=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=S34XyKUDwN5gwc7azgPcfsLha6idNQyfjqWRY3rib/pWBN3XkNIUbL7N097gkiPz1
         wfpORUUK4OjN/lMxJWUUnK6SK7s5ElAUAvXeL70QVwGXOlQ53QmvFuvDAYP50LqhfF
         u6/R8nF+k59aZlVRA5acfkepzR0NRh2+e5uw0+yA+mwvqzX5cgNyAUKIsLF22TB9yx
         IrqC0PYkjFnIm2/Dc2eZhQ/DoaEOQY8SfWWdNW+cDG8LFYbBobF32DGz0tmoF/xdvn
         TlpMvvEG3xsdSY0R3XwsLECUdASOs8NhHdod684hDWSY18IherjAsZCKVrw+ll2YoJ
         8Ia6pwiimdlI9YeWvLY7duSw2hytBjrmJwo/hHE/ntm7dF5mqTsqXHcRiAGDo1NCrD
         1HJBdYzuibb3s1suqEcRpm6w3E0Bp/FD1PtY6x/4Uznuv1ybd3OPYnOYR9Xse98ILU
         pgWKV2wjQh3L8iul2ht7qNphn1Z98QcQoOTwvXBBq6fYWwUibet/UfTDJ6HFfyIeCh
         fp0Oa0CMdnhTw8vdPSt04vJVo/9d7gDO+NWRVHGwItUIDYSyFxrESzIpJfK+dvx7ax
         4C5/BThIddQuQuMrgwUEv5kIaIpBQDGLvMiOpSE0KgtZAEQndx7jnLaW4j/sz7RyBO
         Y6xVz+kbGqMgGxIvqxwwqaYI=
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, moh53n@moh53n.ir, mostafaghrr@gmail.com
Subject: Re: [PATCH v2] USB: serial: option: add Quectel EC200A module support
Date:   Thu, 20 Jul 2023 15:00:25 +0330
Message-ID: <20230720113105.20320-1-moh53n@moh53n.ir>
In-Reply-To: <ZLjkC88x39tEX28c@hovoldconsulting.com>
References: <ZLjkC88x39tEX28c@hovoldconsulting.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the tips Johan, I'll do better next time.
Yes, the device supports RNDIS mode with the same PID and you can switch with a AT command, so I think it should be ECM/RNDIS.

usb-devices output in RNDIS mode:

Bus=01 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  6 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=6005 Rev=03.18
S:  Manufacturer=Android
S:  Product=Android
S:  SerialNumber=0000
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
I:  If#=0x1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option

usb-devices output in ECM mode:

Bus=01 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  6 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=6005 Rev=03.18
S:  Manufacturer=Android
S:  Product=Android
S:  SerialNumber=0000
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
