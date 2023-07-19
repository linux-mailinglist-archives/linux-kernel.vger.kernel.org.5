Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B52F759765
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjGSNvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGSNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:51:16 -0400
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 06:51:09 PDT
Received: from m1555.mail.126.com (m1555.mail.126.com [220.181.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C78E1FC4;
        Wed, 19 Jul 2023 06:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=1wDCcxJ1w2AtqlkQNleD4anymCd6473rPCzyWLIebZc=; b=l
        4YLfix191onlE6lUD/7AbDbkRbzvXpIlTPF96DhTBIitjov3QlWchKSb4GFlh8XV
        e3iif5hjLxc+MqAeW13M2GOoJ6t1B9LmO9W2y8AsGVYk7W70kY5iJOnlbstWKgYl
        5z3NJs/V7/na2t6AQphuRsrD43lsYmwqdUxcEfRaAs=
Received: from zbsdta$126.com ( [111.18.41.154] ) by ajax-webmail-wmsvr55
 (Coremail) ; Wed, 19 Jul 2023 21:35:47 +0800 (CST)
X-Originating-IP: [111.18.41.154]
Date:   Wed, 19 Jul 2023 21:35:47 +0800 (CST)
From:   "Zhang Bo" <zbsdta@126.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     paolo.valente@unimore.it, axboe@kernel.dk
Subject: bfq io scheduler fifo_expire_sync have no function
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 126com
X-NTES-SC: AL_QuyTC/ucvE8v4SKfZekXkkYTgOs/XMW2v/0m3YFXPp80vSr/wzgff05TEGT3wsCSLB+tgSmYdDlzwMRiWqBYdI/Y57bisGtKsR6Q79GYdtTG
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <57b197f2.440d.1896e5d2c48.Coremail.zbsdta@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: N8qowABHMp205rdkqpoDAA--.34084W
X-CM-SenderInfo: h2evv3bd6rjloofrz/1tbikBSxSVpEEYTHlwAAsn
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_05,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gYmZxX2NoZWNrX2ZpZm8oLi4uKSBmdW5jdGlvbiwgIGJmcV9iZnFxX2ZpZm9fZXhwaXJlKGJm
cXEpIGlzIGNoZWNrZWQgYXQgZmlyc3QsIGFuZCB0aGVuICBiZnFfbWFya19iZnFxX2ZpZm9fZXhw
aXJlKGJmcXEpIGxhdGVyLiAKSSB0aGluayBiZnFfY2hlY2tfZmlmbyByZXR1cm4gTlVMTCBiZWNh
dXNlIG9mIGJmcV9iZnFxX2ZpZm9fZXhwaXJlKGJmcXEpIHJldHVybiB0cnVlLiBTbyBleHBpcmVk
IHJlcXVlc3QgaXMgbm90IGRpc3BhdGNoLgpDb3VsZCBhbnkgb25lIGV4cGxhaW4gdGhpcyBwcm9i
bGVtPwoKc3RhdGljIHN0cnVjdCByZXF1ZXN0ICpiZnFfY2hlY2tfZmlmbyhzdHJ1Y3QgYmZxX3F1
ZXVlICpiZnFxLAoJCQkJICAgICAgc3RydWN0IHJlcXVlc3QgKmxhc3QpCnsKCXN0cnVjdCByZXF1
ZXN0ICpycTsKCglpZiAoYmZxX2JmcXFfZmlmb19leHBpcmUoYmZxcSkpIHsKCQlyZXR1cm4gTlVM
TDsKCX0KCgliZnFfbWFya19iZnFxX2ZpZm9fZXhwaXJlKGJmcXEpOwoKCS4uLi4uLi4uLi4uLi4u
Li4uLi4KfQ==
