Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE421813421
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573716AbjLNPKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573667AbjLNPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27726120;
        Thu, 14 Dec 2023 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702566601; x=1703171401; i=wahrenst@gmx.net;
        bh=aUZN9Ijekl/DgdJ1Nx0Xjkr/d4rjzMLWEFZI+tiOk58=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=allC7b3smS9jqnp3tsB6109ja6LuV3e7M+2GS+mcg9C5JQq6LHxynDQPNKwpHh4V
         tzt5Ag3sSjMN3v1765B8lt2uKNUb67m68cGUOLgiaJSx1DTQN+A+uyhOIUFuLU4Qs
         6HXwtVxHTIUafIuqoLvjT/JMPzmWV27MApxUBth3HHWhxX6Qvld6uhLzc+il7P7Gb
         MZgy1dpEFD2f78LQkvXjx1hLv4wMdeFxemzE2lBsEYIRvZJ4GypmU4A0MyuAnQl6s
         u+24Ioxbm9kGwAlbpRlHNDbZVMcPeJCNmfMr5rQo5mWi17LrWA8Am/DfVJ++/iELU
         EgSpyJHu8z8UGzQPxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wPb-1r6LMg0iQV-007S3v; Thu, 14
 Dec 2023 16:10:01 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 00/12 net-next] qca_spi: collection of improvements
Date:   Thu, 14 Dec 2023 16:09:32 +0100
Message-Id: <20231214150944.55808-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vpvI5oqNtjLr/ORfeHZV8Fno96ycQesm/UeTNY8EvTrg6FdbSRb
 vPscjvrUVVu+tJ+uwhJpYedUrMahS5s5gZ9UAecWBDU/glenTWAMx+9Db/4q38QovgvwJl3
 ITu3a4zGIV09a4UhODa6L1SmYovQXxRl6PojnMfo7Adk86BmWqVkZwkNEvhrjXleYeEGo+9
 QQo21BmyrIg8aCQWRzvEg==
UI-OutboundReport: notjunk:1;M01:P0:VQAWmS7UqfM=;WS1sChCUdFo0AQtAI5AB8Euurq3
 /qNbOq5dSCG44zJegCdJiSMEpHFZv/ippX65uf13qCYkNhC1xph5mCS53c+8Q7khHJoS6kM/8
 9U8tMghYMj4yIovfM2eVR2wfpc/KqctnHJLBN2DMMAuIYbzeh2oY9Azd+16OqOJRYg8J2z4pT
 gSem+3/lbH7tHjSfGoJ3WX7NIaqfIaw9kjFUORvhSaZLAE0zdviI7464/w1Ey/zPAzHbuwhKx
 9Ty2pk0Ggn5RArRokgAty9IusMm3/c8WCyvdElkdxrormkTbR1zfQJ5wpGiaCpUAVAiGM+GEb
 OrdebS1iCw5nymX5C0TH+zV/uo+pndRq54J5jBai62BcgRjxAX4PFp9OiDAbc9UaKalYAuYb7
 8w9gJP7TbsbAfXM8RNfotCQGIQWUvPRKFe8vvurW3dztmoPHFqNg0b+qV18gB3Rbopad8bqBi
 XJbm8INjssqwSUMtEgm24ctjj3X14uuBs68e37pFD9N/VOvqTNSFbTy0YwSpKV/oH1jdXnL1A
 I82G5UYTGEhyeSOUWGTqbVG5o4Ie9me2MxImOQvC88+yq1RNvYHXbBo6n7IBx92lOHV0SjlAv
 vf3y6Xa59+Aslbvw+yyLhBqL6DA1h7ynTZL4LA6hI5v2H0aRREJmKhtEKrCOcw/2khI/QoMVK
 DV3yWOhjRjcdGXFuZva9FqFr3+ZLrC/1L0q+Gj/nL7iy9VoQI3j4hki6VK8h1q24X9+KRGGgo
 QnyF+ueTWbkpgXDA5HrWwG+kvA0uI0wPrMlMSHJZYnKhq3kZj0fLFy4hPGg7FLp6Eth8S2IS2
 lg4NBfV01MWdiDB3xbDIVDnQAEXcbrkoZDASiOejramVPvqFHbYbYnb7UjX0N1Yrj4nklOppW
 884OEImM6wRx3kKdxktnCXKGucqObAng7j4CrOny9cYdvGKr8U+w4oMVifYUlgNp9wlDxp6lN
 uDrRzA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a wild collection of improvements for the
qca_spi driver. This is a follow-up series to the recent bugfixes.

Stefan Wahren (12):
  qca_spi: Improve SPI thread creation
  qca_spi: Improve SPI IRQ handling
  qca_spi: Avoid skb_copy_expand in TX path
  qca_7k_common: Drop unnecessary function description
  qca_7k_common: Drop unused len from qcafrm_handle
  qca_spi: Add QCASPI prefix to ring defines
  qca_spi: Introduce QCASPI_RX_MAX_FRAMES
  qca_spi: Improve calculation of RX buffer size
  qca_spi: Log expected signature in error case
  qca_spi: Adjust log of SPI_REG_RDBUF_BYTE_AVA
  qca_7k: Replace BSD boilerplate with SPDX
  qca_7k: Replace old mail address

 drivers/net/ethernet/qualcomm/qca_7k.c        | 17 +---
 drivers/net/ethernet/qualcomm/qca_7k.h        | 16 +---
 drivers/net/ethernet/qualcomm/qca_7k_common.c | 17 +---
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 29 +------
 drivers/net/ethernet/qualcomm/qca_debug.c     | 21 +----
 drivers/net/ethernet/qualcomm/qca_debug.h     | 15 +---
 drivers/net/ethernet/qualcomm/qca_spi.c       | 86 +++++++++----------
 drivers/net/ethernet/qualcomm/qca_spi.h       | 22 ++---
 drivers/net/ethernet/qualcomm/qca_uart.c      | 17 +---
 9 files changed, 57 insertions(+), 183 deletions(-)

=2D-
2.34.1

