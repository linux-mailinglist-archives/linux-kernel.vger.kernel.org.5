Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0FB8071ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378703AbjLFONG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378686AbjLFONE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:13:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272F3D5E;
        Wed,  6 Dec 2023 06:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1701871976; x=1702476776; i=wahrenst@gmx.net;
        bh=Sv4pS1rNOX5ZBKBZZYkcyVrATcEHgLY8W6Mp4iHYDog=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ueUtZbRT1JzGt5iQHDXEM/Rcyj9CHnCfm/vMjOW7mYCERJddKiNkJSZfrwr1VIDz
         rzSiN4wfbpUXRCWqBz0b3cgGAXbn9QoxSIcdZGN5VV8gVPQYQEWm12mjIkRi8GUqQ
         GEMmQyZidnxKYz1vb8OsJMyEG2qYiDhKuUeJny0Dlgf9w320cAmgr93Z3hwHb0SBb
         IEEHS1Ofzb8TQXS9xoGXfrYGIbADUbREDzFXFFoXYtsVlT4Wimc6O6ib5aDOfGLJU
         +78nDvs/QTy1XgRG5u+nX+Ulx4HYL44FSg1vqt5xfVHXyjETzjhnMkrIkMrElc1M8
         E/TJaE+K2leksiRcng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1qspfC199K-00PuoZ; Wed, 06
 Dec 2023 15:12:56 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 0/3] qca_spi: collection of major fixes
Date:   Wed,  6 Dec 2023 15:12:19 +0100
Message-Id: <20231206141222.52029-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lOxH9FnuHKmvu0ntSKxlTb7ePlsSkKbQfzxuMBsrVRsK18Pka58
 TCyzRIlxJgDyV3rZPUMTXOCi7t6jg3UxtyFBQ9UQVzfd/FgTpdWJfrs3rxy+/ZHWEnLY9Jh
 ICmQZP67FS6bIlUOsWjdb7ufbrKqE5z+kdcUQw1I0I2SG/eCk+XycAWwELLFmF4VecTq9Nl
 z1eENnV2RCp5iMsQYYBPg==
UI-OutboundReport: notjunk:1;M01:P0:99gP8A4e4hA=;6rxRPoARibxYbvYELXrceontBAW
 gaQtJ/fI4xNOM3dcl6ts4tshaydk4mSPRSpLBg4ZJQktDLU0H8lQm5FCTX8lBHCdGXuER9bsO
 gkuvo4doTRezbSXRHiP0PV6qH5wY7f8CyHhcQ5t0qbzZaR6TdgWWLtUCpciMfHABOqNx+MyC1
 SeIvKtt8OdlGeYI2NntDGLFfqEyIbu2CCX8tUM/mygN09UkdvWSJvK3xmrOZg5H28E7Yxhog5
 PQgH42tUsqx5cniFyKQ7YScFVt+LzxFwYvi2gXphLUcOkSLqNjiSH6B7rA5RCS+2eiEGiNDJG
 3bn3s2+yd0G+SSTRjE+lQfDJ9GdGR7srAU3z2FHU3lfHy4B/KudasFfROpKs0kx7YZ42VHmJ6
 /1N4ZW2HRpT49ZzYhD1fvai0M2Uh9s02zQkueSv2w5COYVZe9lfj4XMUzoz4dmWycUZp7eZ3y
 726AeaGybKKi9dmhO0qfHCD3OmvPlbit21qcuPTN6e9OLMBUtt/YoXC5ShjcGmaV6P6qlURLO
 1AdwyVS5Iudcec7tUnfrChHI+mt2UzuuQbnDTSCUQjGwQrhSNd32p3p48RL+DEY8Ox1manci+
 dCzprTFPpbdYW5codKojwDCIwmty8bC8Gb+SzbleT/BCrZAuiKj82mFcXGti3eW6ERW/AAjev
 +9i+O9fh5+yfOBZw/jTYYReV9jQtVOzqBnVnHy/zdj/haLDKl8B1tSHRrosBTDnecAaiX7+VI
 iEJsg6LCXzmlHUCM+oICXzFRdaSdR8CAk8YCSF1a1vrfVr732doNf0YYFVMDrRH7fJkIbBO0/
 aDyGwjRfpGamDiBnRMJP4lDG/+d7e8r1yNCxwSSbetti1Pls+DOIe5CEoOi6Dd3VFBa1nj23A
 TdswlKnV9ZNvN8Txp3oDp9trlEffvJFzuNMDJP6nrcTFyzq1XTDgzXgZzVEim/5+bd6CWmvdm
 0tJTHcmDFERSXevqRGsO32Lqkjo=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a collection of major fixes for the qca_spi driver,
which has been recently discovered.

Changes in V3:
- Avoid race condition in qcaspi_set_ringparam() as reported by Jakub and
  move all traffic handling within qcaspi_spi_thread
- use netif_tx_disable instead of netif_stop_queue

Changes in V2:
- Address the crashes caused by TX ring changes in a single patch
  instead of two separate ones ( resource allocation rework will
  be send in a separate series ). As suggested by Paolo the kthread
  is parked during ring parameter changes instead changing the device
  state
- As suggested by Paolo keep the ethtool get_ringparam behavior
  and just fix set_ringparam
- improve commit message in patch #2

Stefan Wahren (3):
  qca_debug: Prevent crash on TX ring changes
  qca_debug: Fix ethtool -G iface tx behavior
  qca_spi: Fix reset behavior

 drivers/net/ethernet/qualcomm/qca_debug.c | 17 +++++++++--------
 drivers/net/ethernet/qualcomm/qca_spi.c   | 20 +++++++++++++++++++-
 2 files changed, 28 insertions(+), 9 deletions(-)

=2D-
2.34.1

