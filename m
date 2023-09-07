Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D06E797019
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 07:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbjIGF1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 01:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbjIGF1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 01:27:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322C51BC6;
        Wed,  6 Sep 2023 22:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694064412; x=1694669212; i=w_armin@gmx.de;
 bh=SDoJ1qMnGGCF705mx2danL58jWUrhbUadtlO+JoIdEg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PDDWwnf0seZYJElIw75lF/kUOmMKVt10AhhpSrnhITidM+DAYyOVogvgol+NXWNj7iHbk85
 FJVYmhh7PZCLO3JGg3MDS7bBHsgs89lS+L3t+5FRqM0BE/9rXAJdxQmhinNv3hriMEfUg4ANH
 8L1fOGvQwUBNKHBp7ibWesxNtSYxTi2h4i2RhiA45arvAeXd244NKpJQA8IFEz9vpP6cIhh1z
 W6WDR9Qpccdzka6pPKKs7c0vMLjJG5qDJHhrio3YbQl0MG2NvegL9FBmOmXgG+i7EJ3xuYhXr
 CHfw1HJDCv+yh+5xgtO8q7R0oWJ1yMpvBHtCIvvoFVgT9lmvFwGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2O6Y-1qdYVW2D7u-003yhB; Thu, 07 Sep 2023 07:26:52 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] hwmon: (sch5627) Document behaviour of limit registers
Date:   Thu,  7 Sep 2023 07:26:39 +0200
Message-Id: <20230907052639.16491-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907052639.16491-1-W_Armin@gmx.de>
References: <20230907052639.16491-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MediO2xoNHuYZ+J2gpFvJo5Yw3HQt7z9lo3eGzlWwPV0L/tDwYr
 d5DNXYjIRdAQmg3KNeEEKSjBjD5Yj/4e4kzTXbwIxLboyYi6Yp4gSDfeNZlqd25yEwyizAw
 da/U4RBJAPjMfypfk3aNZfKN0831a3GW3Yq3JPCK/r1V2xVRkRjT+A5z2TSxP9IT4zVZGXQ
 81Rrh3twPrseMpxpV4hNw==
UI-OutboundReport: notjunk:1;M01:P0:0CYJA/7Oxe0=;szh2cPWMDtxCBza8+eBbie74N2g
 qo1q/xGRFJjv8bVE9PdyT2aMSE4aUEZliud5ECymbhtBVkfUlPINfFV4OwhkHG714znuyUuvU
 E5gEswzc8F2kDZhE+I7LGq+3AzzJMJhFTeiUkHQkqMRrcX7mWwMqinu454UWpoBBc3bb8+dv2
 RIO7sC6WcDYAsRqxWkre4J0U9azsD7P6T2khafrirLKgNrIQPZ4yaHAN71g8ZTcF4+9jbwxGn
 CObACG9X37Aj+gGB2R/qJk0DGr56MngLhbIcJqt079Qt4oENWIc2/PzL2ozbM4wuFucDBaSvK
 praTHqcOUgOSyxNvu1h5NAkhVO+21YIpCPw1F1Qo2YkXhImQV9L45p0ceTwC2CVVzzPw+1S4U
 CRyE9TkIsnZ6fjYdRYBeEkzNq64u8CvHSu0J/BvwFbtHEqGZGdtmoNT6f95ZYA4tsBMd+Q/iY
 AoswUPU9se+Zv0RIQPn6Zi9uX+CGNugNvpDzpkwj8+8cFIUrpb4aYt/tk7/zjHRS8pWgB28U2
 3glaU81cbFr+mPdyVpdYrpdK/3FVFLX9U/jcRvXPJ+gi46NN+GMckRTHCh4yRnIrbpLeqpH8l
 HpkCwZwtpJ/A5rXmG9sjPvBkFeDowyM7DvT/N135o6p7clmvem6AmFLtejyjEhKnbcdRCfI5j
 lir9s6roAcYL/+Poi+1itEDDiGL0dp7I3/MbUV3SAhnp2qxA54ZbIEffrLo75CGBrdA48DNje
 Os4I++492rUj62J7WiQOanY0TyeRzfmfGFOG7CE32DS3xFIwWXAtwAodAKuVQbH2Kzd/JQWz4
 JcGzRPXpbkfOBEOML44t4R2KXksw+p44uBQajftERcOcxPaput3XkBKw3vEc4Z1wevQPbmp1M
 wOQYjCREFRt/M+wpqfldJyvY6Wf+CfM77A38HdpKSqPjKYGVjjvZa2IA8fk/AkgQsRF1m+Cl4
 j4+r3KVDHvcSrCqvA+0X+B8RBP4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values of the limit registers affect the fan speed in a
particular way. Document this behaviour so that future users
can exploit it if required.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/sch5627.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/hwmon/sch5627.rst b/Documentation/hwmon/sch5627=
.rst
index ecb4fc84d045..8639dff234fc 100644
=2D-- a/Documentation/hwmon/sch5627.rst
+++ b/Documentation/hwmon/sch5627.rst
@@ -33,3 +33,13 @@ The hardware monitoring part of the SMSC SCH5627 is acc=
essed by talking
 through an embedded microcontroller. An application note describing the
 protocol for communicating with the microcontroller is available upon
 request. Please mail me if you want a copy.
+
+
+Controlling fan speed
+---------------------
+
+The SCH5627 allows for partially controlling the fan speed. If a temperat=
ure
+channel excedes tempX_max, all fans are forced to maximum speed. The same=
 is not
+true for tempX_crit, presumably some other measures to cool down the syst=
em are
+take in this case.
+In which way the value of fanX_min affects the fan speed is currently unk=
nown.
=2D-
2.39.2

