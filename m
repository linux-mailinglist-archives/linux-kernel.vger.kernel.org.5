Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26F876D394
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjHBQY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHBQY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:24:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A72102;
        Wed,  2 Aug 2023 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690993461; x=1691598261; i=rwarsow@gmx.de;
 bh=cq4ElQGiX8L/DIAYdvWjKqUUNUqQdGiDkVhdL9ofxLY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=U8KHNwM+b2CTk6TO8V/6wwRIo+dldO0w84iaFpYedKT5RH8F8yyY+a4verKAbjYhHJQ3H0n
 v/JqiF0ChjXhFnWjoWqyHuCBS1MmEgEQ/Q/wVv3K1YoFijjWgGeY/OvJp/15r8H8LNCUqFASQ
 mVU8+WtvQ9K23IIhNlZSVYNs1shaNR5QPBM2wZFOgF/hTOIYRgqMzLb04NrmbPhhuP93X8LOd
 Ba2BPWR1nwlu6BFniVivnVIYOS34zrprGxD1pelZHcBEL8zReEmN+lc5Bu08vZs3yKWY87MVv
 ADAOaMKug6Rti7xwCBwF6A4DM4a9AskaFnQWyxFg6H5jEguS1sNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.0]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1qSL6f0nPo-001CjS; Wed, 02
 Aug 2023 18:24:21 +0200
Message-ID: <4681f49e-03dd-a553-431d-8756a3f9fcef@gmx.de>
Date:   Wed, 2 Aug 2023 18:24:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.4 000/235] 6.4.8-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cGF5WdyJZyEIToD6oe3+u4BWOMCPnN2qfrYw//lQ99KsYWmbBBl
 kSxif2oMP06h7tPBWCUD1J4fO73ptRwYaxZu4U3Fk3uXt0pUE79N3gTDFiB8h7tjHIR1s82
 JhHadw8IO0xc6VzHGpTT3hR8/aPIRmahIFZkEcclnf+b3N7cJrDIWzxxS1yngYhSBtvIqUm
 TJOwzMDcYtDgXnndHrGDQ==
UI-OutboundReport: notjunk:1;M01:P0:fm28WEnRfS4=;aS19RNFSKGwbU/GoxG9TjAKP9jc
 0KsEOWqQ390s0MzBW38JkMFz6sYciL1qZVuAyL82j1/u7kpK0i8mNFYn3q4nH1W0RMC+u0all
 ulUdK7l4osfdCAdzn/03INMUG1EztQVNNjjlGJQuLBqUxWgDcA5sZ4inyLPeyNwGAgalwjUtw
 I9zPZz880h9LXvYxTmxI3NSC/J3QbUDPD8ERcWkMv5evWBT3hiepkLkzL+HtPwRNQ2BC6rtJr
 aEP1dXQK9dBnGsHze+dNJHObj1Od7fIp9ZqzOkz5kNKejsDkVhbkUgKuLeGHWKx6V/hm11M3k
 8ECmyauMoIxZ2OcmeiW6xjNtkEZDttB6UbEMxsbhrZfCpw9Ur2pqXQkwbprQK0e9RLHD27zxL
 +YSS2+S88YctSaqf6bZr/Z5nw3UfZS5NsQGV2uTQmijc3WmgkAbGzP3me/2RZoC2+7u/HQCGR
 IsDO6Hcz1btohtOVKGNWdraMOYmhjS3hvfCRypSDEjWmlUVBPbKsIVdx2oMfDKj5JlGkqbxpz
 y6GQ8oAE3mybvma+oXlLhbzmlZMHvUrCC8X4u3zWC8fJMMs6SoBNUXPpingPPSk6F6XEE/U+A
 9fGF2fGS9xPLw2MWw74p8G33MHiWRlzmQUj6KwgJgAvKgxXnY6PBVYzrt5tAldsAGuvFwR68p
 HqQcTsYQLZ/tfK1lOOTN5eMhZKrfh8NpxD6uX6InYvjxNL0oErP8mgfz5ZMMGzmVL2yqTN9FO
 AXX1bVV2b499uWYsHCwia6QrU6c46J9+gnEtAamLodbnc7N7BTeP3QrJ13uo4Z+IhfyewdnJF
 soOWrXgBaS/19NZ2hdS5j6QRtQQTA2JIURkjq4/MynY+koz/kxrNh8ZeVk/b8JdRzo1fs1zyb
 WXh2HJSdEWjo6XRwNl4v4QaT+AWFJxUysYDLfYP5UDjrGU49qH7myTRIhxwqarf5dkxucFmOK
 LQ56Ij5z9S6tXvs/DUiMNHC17l8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.4.8-rc2

compiles, boots and runs here on x86_64
(Intel Rocket Lake, i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

