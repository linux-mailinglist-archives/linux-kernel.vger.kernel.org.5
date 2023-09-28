Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B707B2839
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjI1WN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjI1WNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:13:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6592719E;
        Thu, 28 Sep 2023 15:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695939212; x=1696544012; i=linosanfilippo@gmx.de;
 bh=6YXjvZ327kvgfe7ZgwF0JxtwqUgfKrPOEWMiLQRBa+Q=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=UkXBir7EKKoL6ETns/eYpZcNxS/EFybdW98pz2fkpCuwodQ/pRST0GJVnmVcQ5XErXuFxe1LYiI
 chX+mJCgJfw60gGob+0Grbq+pZN2Rz+a4FyHjzSCWDm0nAxv79URflipPGg4oATlNuzpvGkp1ydM+
 2larUeeVsRkUiQNEsUB12t1IfmrF4jrcf/nLRFwxfJoHt/EG4TO9O69xbZO8Moos9or6QXkyaWG0G
 UFiDi8IqOCEBaL8kRknnifp+G+pokLEND0RZSHjXQcz4Nyej8kQhTjEUjHe8mezHoMa2TJPn23dHh
 DX29AxMML6ztMJU8AWeBCVXLaW0SpRoTUJfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1rWHFH2Y95-00lBlB; Fri, 29
 Sep 2023 00:13:32 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH 0/6] Fixes and improvements for RS485
Date:   Fri, 29 Sep 2023 00:12:40 +0200
Message-Id: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:XYHlM2JmTJQzcsNbI6z7rvM3CB8aCcSxFT62l97yn4OV2I8LuNz
 XfspHS9pqyP64h9MXoMXaKtPVkkB6HwSzIdZMDRe1bJtjQnOvPo6zHEEALJcJ9bWnQU8zcy
 CjwVx6R3Kt41gx6DkXhKesd90wYgJ0cMFpSoIV4ic0LRZnrccqyLBlOsO+M/rTue7sdVjgs
 kHXTiAy3juLbWIc8ZRCLA==
UI-OutboundReport: notjunk:1;M01:P0:xyROAPD/bm8=;kBRi3odMGDPCMhkJ33GJl+VyJwR
 rxYEQBCoz+hY0sBr3Jr7ePE5Ai5cgBooSBBr4PCqvVtfg0Ptf7dlk3USf7g/9gDT6BLK0RBqL
 e3BGFcFYvsAXbpCB/Ghj83LaQQGxOxgLBIxAh81X1o7dCEtV2NHZkKQTErggncua5oJllgjS4
 xafbch9ckaUpdQUDUSS7hOTgyOH2StfcBVpQoUgN/xKXNXa7a4tBbD+jDP1kuypW924knSQRm
 rXexz2hxnlAT9zvUN2bLkXm47GHYKYlG9K0THoqdPRBoQmBtYKg1Z/nudTX33V+SZHXFfvMT3
 5Ex1Pg1EThS/fqmrt5Q3+4TBvJ3iN4BqtN46LdlRAIPacnHbaiX7OIqY/J/gQ4kbyf/1gtcwD
 ygSNPT250TmMt739sda2Qr9Go5rjM+UNO+vRL2Xusn8XTQ/UyvVitlF7/grFl3ti7nJSPzZL2
 zLq9Fkr7sqfxeBf88m79nJ4CH3T5+3iTPb+PNos34yYLxXSYn68jqD2mtPU/pNQthrYnCPbmj
 5EUrt0ISFNMdIylyBI3dOoBUdxboJ2GI5jGmXCQknwS77MqbIqYCxqtuJ8Iv2ViUchSiWr5hK
 lUAchrkyFuZLyduTUVY7e0wL7hd27g+4L+ZdJzk94vNZkOu+LG1HNtWqDIedZL5tbd7sKBo+u
 C4ZTZ+gjesnyrOZ+pQZoItvUd1ettoBITfhCWnwm7wyV04ZyBoPUUsTWIXkSdApa1bbyBCB9N
 Ree0L4dAPb8bb6fUg2VGTk6woktpnhvHSTaj1s7Rd83IOVZ0DAeJL2FBp4v450QStXNkOL+VO
 YHzTur+508NRFaZqobsoc2ufKK1/S6eNeuWime6wOsk7ZCTzUjQMe4u174t5Ns1IK5KDWpuuh
 OcHXDH3EznLnudRLvOXE1XGf8kx8ZMd7Sb4ckOuAlXkmR1dYpRVJUrjg+WP6pWZNIswXH5t5Z
 +OIKNA==
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClBhdGNoIDE6
IERvIG5vdCBob2xkIHRoZSBwb3J0IGxvY2sgd2hlbiBzZXR0aW5nIHJ4LWR1cmluZy10eCBHUElP
ClBhdGNoIDI6IEdldCByaWQgb2YgdXNlbGVzcyB3cmFwcGVyIHBsMDExX2dldF9yczQ4NV9tb2Rl
KCkKUGF0Y2ggMzogc2V0IG1pc3Npbmcgc3VwcG9ydGVkIGZsYWcgZm9yIFJYIGR1cmluZyBUWCBH
UElPClBhdGNoIDQ6IGZpeCBzYW5pdGl6aW5nIGNoZWNrIGZvciBSVFMgc2V0dGluZ3MKUGF0Y2gg
NTogbWFrZSBzdXJlIFJTNDg1IGlzIGNhbm5vdCBiZSBlbmFibGVkIHdoZW4gaXQgaXMgbm90IHN1
cHBvcnRlZApQYXRjaCA2OiBJTVg6IGRvIG5vdCBzZXQgUlM0ODUgZW5hYmxlZCBpZiBpdCBpcyBu
b3Qgc3VwcG9ydGVkCgoKTGlubyBTYW5maWxpcHBvICg2KToKICBzZXJpYWw6IERvIG5vdCBob2xk
IHRoZSBwb3J0IGxvY2sgd2hlbiBzZXR0aW5nIHJ4LWR1cmluZy10eCBHUElPCiAgc2VyaWFsOiBh
bWJhLXBsMDExOiBnZXQgcmlkIG9mIHVzZWxlc3Mgd3JhcHBlciBwbDAxMV9nZXRfcnM0ODVfbW9k
ZSgpCiAgc2VyaWFsOiBjb3JlOiBzZXQgbWlzc2luZyBzdXBwb3J0ZWQgZmxhZyBmb3IgUlggZHVy
aW5nIFRYIEdQSU8KICBzZXJpYWw6IGNvcmU6IGZpeCBzYW5pdGl6aW5nIGNoZWNrIGZvciBSVFMg
c2V0dGluZ3MKICBzZXJpYWw6IGNvcmU6IG1ha2Ugc3VyZSBSUzQ4NSBpcyBjYW5ub3QgYmUgZW5h
YmxlZCB3aGVuIGl0IGlzIG5vdAogICAgc3VwcG9ydGVkCiAgc2VyaWFsOiBpbXg6IGRvIG5vdCBz
ZXQgUlM0ODUgZW5hYmxlZCBpZiBpdCBpcyBub3Qgc3VwcG9ydGVkCgogZHJpdmVycy90dHkvc2Vy
aWFsL2FtYmEtcGwwMTEuYyAgfCAxNCArLS0tLS0tLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14
LmMgICAgICAgICB8IDE4ICsrKysrLS0tLS0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxf
Y29yZS5jIHwgNDUgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIGRyaXZlcnMvdHR5
L3NlcmlhbC9zdG0zMi11c2FydC5jIHwgIDUgKy0tLQogNCBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNl
cnRpb25zKCspLCA0NCBkZWxldGlvbnMoLSkKCgpiYXNlLWNvbW1pdDogOWVkMjJhZTZiZTgxN2Q3
YTNmNWMxNWNhMjJjYmM5ZDM5NjNiNDgxZAotLSAKMi40MC4xCgo=
