Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF417AF11C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjIZQr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZQr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:47:56 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF414BF;
        Tue, 26 Sep 2023 09:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695746866; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=OnQd4WqA2GB6Lcrp0tFFUy691/vlPbhqVqVDzstcpIvdbVVAer/fmVv9jBsIAzad7KDsQSZ+buY3M5qDg/b7nowrhVRO7MPCQVFRIAN6V40rraG1iByOL7YuxySqItwFZL6RzO+Ie8GhZWgxi9z56EB840ACL2GE615cR+sN128=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1695746866; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=Fxku4X/pFN8SumO4OH+NUMweW6lMrpUaYAPaOCQumfE=; 
        b=MtNbtARd2NaG3jdiorYYfKqwht/9mTLG5d5E26ZS7CPuSBjqyw+hPF7JYukKqwcEVFkpJBsg0CRNYEGPOZ5AjOuUE12lMmoKY0buXqFrtagkJ5lNmqjvpZYW/gbm2APBgcLPPnqJ7zQFwbg/h0DWrDeXpzri+t26hRi2EQwA0xw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=marliere.net;
        spf=pass  smtp.mailfrom=ricardo@marliere.net;
        dmarc=pass header.from=<ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1695746866;
        s=zmail; d=marliere.net; i=ricardo@marliere.net;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=Fxku4X/pFN8SumO4OH+NUMweW6lMrpUaYAPaOCQumfE=;
        b=E4Kzuh7vOT7GLR7/DoeGfL1ELP7BGusNE4CNOSp+xTcArdopYJYTp2n4HYHwCWLG
        9eqZrffaLF64Y5ZtfPA+uWH7AKuu7cezc4B5fXWxlt6oDum+tcjGAkPqXUeKFjOA+A4
        2B98La42m2zgxABXiktFpfMmsvlqtY3H4BcW1Lmk=
Received: from localhost (177.104.93.54 [177.104.93.54]) by mx.zohomail.com
        with SMTPS id 1695746863564397.6564975775259; Tue, 26 Sep 2023 09:47:43 -0700 (PDT)
Date:   Tue, 26 Sep 2023 13:47:47 -0300
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     syzbot <syzbot+1c41b2e045dc086f58be@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, sean@mess.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] [media?] WARNING in imon_probe
Message-ID: <mrce6emi7jvmoe4fgxt7lgrgkswkinc5u3hpl57gr5oaxau55o@fdvuaqxcsgu6>
References: <kwwrx7p4nfr4qkv5xxpo5nidyyjdbytsulpu7lj6yujmzrnxb6@q63vtmlo3dqa>
 <0000000000009a28dd0606455a6b@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mrz4i3ueryb5h6h4"
Content-Disposition: inline
In-Reply-To: <0000000000009a28dd0606455a6b@google.com>
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mrz4i3ueryb5h6h4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a48fa7efaf1161c1c898931fe4c7f0070964233a

--mrz4i3ueryb5h6h4
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-media-imon-fix-access-to-invalid-resource-for-the-se.patch"

From de69b3143facb3280f144fe88e1a7e6dfae9f97e Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 22 Sep 2023 14:38:07 +0200
Subject: [PATCH] media: imon: fix access to invalid resource for the second
 interface

imon driver probes two USB interfaces, and at the probe of the second
interface, the driver assumes blindly that the first interface got
bound with the same imon driver.  It's usually true, but it's still
possible that the first interface is bound with another driver via a
malformed descriptor.  Then it may lead to a memory corruption, as
spotted by syzkaller; imon driver accesses the data from drvdata as
struct imon_context object although it's a completely different one
that was assigned by another driver.

This patch adds a sanity check -- whether the first interface is
really bound with the imon driver or not -- for avoiding the problem
above at the probe time.

Reported-by: syzbot+59875ffef5cb9c9b29e9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000a838aa0603cc74d6@google.com/
Tested-by: Ricardo B. Marliere <ricardo@marliere.net>
Link: https://lore.kernel.org/r/20230922005152.163640-1-ricardo@marliere.net
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/rc/imon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 74546f7e3469..5719dda6e0f0 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -2427,6 +2427,12 @@ static int imon_probe(struct usb_interface *interface,
 		goto fail;
 	}
 
+	if (first_if->dev.driver != interface->dev.driver) {
+		dev_err(&interface->dev, "inconsistent driver matching\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
 	if (ifnum == 0) {
 		ictx = imon_init_intf0(interface, id);
 		if (!ictx) {
-- 
2.40.1


--mrz4i3ueryb5h6h4--
