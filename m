Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ECE7D17D6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjJTVK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTVKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:10:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889C8D6A;
        Fri, 20 Oct 2023 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697836208; x=1698441008; i=w_armin@gmx.de;
        bh=3ddrfE6JYEXsgMVAp506yioBhbR2EzhTXBgPYYk895Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ca+xZL1RxmSQO/AvPpqr6zzsV7cXoHLzyB3/6f9qzhIBC7Gf9Nx4+ur6zCrMkrde
         geQmjydg9zFqEgKi2yrm//fwQsyyKW9+UOHlYOm1p2sdFEhRYiYKEq1HnskNFVzRv
         bvYcnOOeXBTx5BZNJhL0nOmmmnt+cPJZNdzQNEb9IWI5GcBUPYiE9IMopDSim5+oC
         F8fkCY9pxLfCGEvTajyMPx3bazX1ogmfPX/GDljNbskfpc5IKX8dBZJJuioGs1TIN
         cZMDzVrqTKQyjJrq4+ykGmCsdFEDHsyCIB2CIhJfo3k3+mcWvgZWJUoK+7PxRGCNY
         p/aNXA/qd4x6LoIXcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MUXtY-1r2dw81wZ6-00QSwM; Fri, 20 Oct 2023 23:10:08 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Preparations for fixing WMI reprobing issue
Date:   Fri, 20 Oct 2023 23:10:00 +0200
Message-Id: <20231020211005.38216-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yqf1x4joDwJxtIBBEMwVWJLx2/qsuDYHJS4xhkx73cUb5eMXU+L
 pkmGl14m2BCyGsOZabdZeXtq/2qvatBs8s7PnA/8TidAiNu4ECNvfrxzDf8jUsV0TIIp/t+
 0kzWAstzInErActQzJLAohgXW1wYxYvI72K1N8FxwJF26hGR1u5wBNG38o8kpTKz/eUL573
 eixuA+D0qj8ci2PuhRxFQ==
UI-OutboundReport: notjunk:1;M01:P0:fl0Pk1VwYRI=;OeWuR771DoPOx5HhSkVJ4dPxIbd
 7gS2UU56UwMb0gfSpFR39odEOg7ED15u0q/wi8NTxeu21sA7iOVnWTfUgxIuTXdh7ggEQVTsT
 mbg1UH0FrjjLvK5uFYNLWt0TeKUvRbvwkqXP1s6OIc7+udoXhuoWbqEu5MMnRXl+dJG5q220p
 zlbUnscHuFPODBJTrOeu9gbQPRW1DY+5aRyjmjfcxBHxtes7Acxw7gDvl5eieiDU2yohYDXoC
 CGcIC/QqyuCrP2G2YeRvDygJnEZYc+kh1lmADrCA/kUnPNvaR3n1ex2ri56qh7KUnxYuK5s9D
 ebNH5sYyd8S1NRby629pcr4JClE6N0oe8oJ8oNkkmOC9fbs4ikQGUjvIlHkUFiodUPmO91lrb
 jONGLTqEu1KTo9PsMfQyMY6/n+LuiktmSEij2lKf3+y2yPfn5SRMD+QiN8w3rKk0C3oQj/csG
 EKOTJDDQN+VmG5APXnBuZlj/TsyonZFgfCUEwgkcjo7jR2j0PK497ALOyR9fdvoOq1EaLInlj
 rMGqqA0Stm39vzWKy/q7nC6io6Df15Ywq8nj7zYrBZx2sK0uqxTXTAae+StyY+YfIuFoDUQCy
 tDi/djhCoPrPLI7I+afcAlYi/PBbmDGTndc1P7CvkqSsp6miCwW97+syKyksjq/jS55bZSl7T
 MWItnReNiD+xks/vuDlbcY3C7S9LR5yTpZTYTmdTQKvdkuU5dLMAHffmby2XebHz9gjE+BxCU
 1ktQ0fhuypcshTtucBPLmUpwL2bxEvbUH/PzmjaWtThopez41oQEbetWrm7bslB2OcyDTsciy
 Xi1kG5osC0AzmKrb+mPc7jQ49dTKpHxSVaGH7GKue/dOY3fuou7dQvHjxh7EYz7p98qWkdI8W
 McbBVmNslfh4OwLKHxxVYefCQmI0OS24FossPyNChrojJCOvmzwCDfUoHCVwsgxrGmnY+xsm/
 oWENDnkeb7px+kbOm0nAke60FDM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains preparations for fixing the WMI reprobing
issue discussed here:

https://lkml.kernel.org/1252c8fb-8d5f-98ad-b24a-5fabec2e1c8b@gmx.de

It mainly aims to decouple some parts of the WMI subsystem from the
wmi_block_list, which is going to get replaced in the future. It also
fixes some issues, like a probe failure when failing to register WMI
devices and a potential issue when opening the wmi char device.

The changes where tested on a Dell Inspiron 3505, a Lenovo E51-80,
a Acer Aspire E1-731 and a Asus PRIME B650-Plus motherboard and appear
to work, but additional feedback especially on the third patch
is appreciated.

Changes since v2:
- Drop already merged first patch
- break the paragraphs of the second patch with an empty line

Armin Wolf (5):
  platform/x86: wmi: Decouple probe deferring from wmi_block_list
  platform/x86: wmi: Fix refcounting of WMI devices in legacy functions
  platform/x86: wmi: Fix probe failure when failing to register WMI
    devices
  platform/x86: wmi: Fix opening of char device
  platform/x86: wmi: Decouple WMI device removal from wmi_block_list

 drivers/platform/x86/wmi.c | 263 ++++++++++++++++++++++---------------
 1 file changed, 157 insertions(+), 106 deletions(-)

=2D-
2.39.2

