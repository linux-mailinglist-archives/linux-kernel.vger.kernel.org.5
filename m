Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CAE7CE076
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbjJRO4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjJRO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:56:01 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B52FF7;
        Wed, 18 Oct 2023 07:55:59 -0700 (PDT)
Received: from toolbox.int.toradex.com ([213.66.31.70]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N0WTY-1rn0IY3znQ-00wY2T;
 Wed, 18 Oct 2023 16:55:47 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sherry Sun <sherry.sun@nxp.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v1 0/2] Bluetooth: btnxpuart: Fixes
Date:   Wed, 18 Oct 2023 16:55:38 +0200
Message-Id: <20231018145540.34014-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DUOOhv0QMn3wZtheDCUXhx4UBZC2JUGUoj2XJkcuMddCJ7/kHDs
 c8TnEahp6okShhCPqSvHENPJnMQ4ZOsJ3XU4CVXVUjIioTz9lQ+M9NIRbNmh7DPT+zr+w2r
 8Tdh+qNpHEAaoG9fRF4tsASufep1AfSXxLgOb30scz95YUIa8apZQeYFvUchzDMmBDwOZjg
 K9ArvxaMwvcO70DmSE5zw==
UI-OutboundReport: notjunk:1;M01:P0:mJ3tn8v1UJs=;K+luYltt0sMZgdForv7OfxnSI4c
 te/R8RWRpeMNXpmzj0LoK6IxO+npW+HHOAiHCccqI5Cp4u0V57Xl2/j7OIhJwnQSXK0on+Yqw
 biKJuVBKcTlMExZp0Qfxj2Lp43kvOhE9gc+uhT3BiaKCEUkbWXtiQsgXofrg/GKR9czUsGKos
 2LyK/IOG5lqF+zcmKCO6N9QV2vW49wmUAmokgIxOOF65/9bGrZvlVte1z2O3l7DdnJz115XrO
 THBo7fKzotbAVWXQiaiH2amjfuYmlOcnMi/a7RWsHXwS6bcRnuZG45yIFG4dPDpgnH3e5NHmr
 uE8niaf1SZ7KyPJTJUlFL3DQU9FwrtF9083rIzW9TH85G0Iuiia6Udo4o7fPGIG1iC8KwJEI/
 SXQkpDLotOIll6mnPdJdT73Tr1SkQ31IIja0msI0vYJp6Z0V8qWX+gZjheTSwSCTDYYEKC23A
 OVNdCNSNGs8IfDxABojpHjnr7Nqf1Gm3UG2HESQug4AEtipBmqMwunW+KWCa2ghhEk+W6R4oJ
 qzgjHNWHzjPNW6uoXUN9S7psp0JigFnAi+6Z2rPPWeXeclJlo9zfaai5E1uQkMGtBoRnzjf9H
 mZFP5NIqkH0g7JNrFYTaOUCtm3G43tEDrhfTQVYZCJqcXZoQr/1OXfv9dzCTHS5783M7YolWf
 uIefgaXmR1Ct+OEaxsCnTgPHapFBrP4Wb23HeJodImk/GCZHgxDFvfFmjQeDc0X9gEZ6PgN+M
 UqhtP4IkfZR1B25UlU/aFVyhVENCan9xyX04pf0c+wFYFslHjVggKN8j9gJYqoC/nu+O6gO0F
 ACnYW9tFHjQn/XrvnErggyXFB+pDA7sMNg0nvW6fgVOohC2JuZtS+8qLM6fyRHHlhz+6yy5tN
 1ZOdnKaNfV1rNAg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


This series fixes a few issues we have seen during bring-up of Bluetooth
on the Verdin AM62 which uses a NXP IW416 based u-blox MAYA-W1.


Marcel Ziswiler (2):
  Bluetooth: btnxpuart: Fix btnxpuart_close
  Bluetooth: btnxpuart: Fix nxp_setup

 drivers/bluetooth/btnxpuart.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.36.1

