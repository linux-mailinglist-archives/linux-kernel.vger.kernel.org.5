Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D0777BF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjHNRhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjHNRh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:37:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02926172A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1692034632; x=1692639432; i=j.neuschaefer@gmx.net;
 bh=jGenBMxga4rsDnHEFrI1uwBNqH4WYg0F7v+WcEBMdpQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=jABlkrhtwSCw8IfLNwPdEF+/aY4BsZ21gjWVf88kg+pCCoDQmycZYmx/cwGUTHzCGC9K+BD
 P1RgENN2BOQoAeJdPLD4t4A/hG4yRS8abKjUXgNhrodhhZsIiy2CgR3hFZWY4YC+7ZDxd1wVw
 T06dFlrXPwNdWsw4Ua/Fq3HvtR6eQXSQX9YgAGqTkG84SxIlza2F5Rmzow821JAI9nn/8pS5e
 BAGvNRGNhkaAIktUZYsy185KeVEfBCXvQ5QQZ8l/IqJSzbGpJ3aytjUR0B5miP3768x9UCuM1
 Gd74txD/mEQ6RcRZ5wduR9SzoRoKQVj0NA7hTd0GtPO7XMn6peYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([151.216.154.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1qKVfs08gS-00Sj1T; Mon, 14
 Aug 2023 19:37:12 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] bitmap: Fix a typo ("identify map")
Date:   Mon, 14 Aug 2023 19:37:08 +0200
Message-Id: <20230814173708.1746905-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I5I78qM0YnrUELdYt+c9dlWuHk0TDo0FTgkCXtShnJwBxjsGNgP
 KArdOyMDMfY4hKDcLWntGPloxVbxCmJ/sh0QBIoZNGAzPE5ozlltoQWoIGouqLIbe15064X
 oxzB2BWe7HsjBJbXRbKFRsDpevBU5ZHK9RYrywPBLvMWC3JhebKabD/yVUp/fa1A6n2VPLE
 tl8RM7l//C61wjo78Os1A==
UI-OutboundReport: notjunk:1;M01:P0:2UrpGbG0gjw=;O44wm2LTiwV3PJ3kYl+ReuxNCTK
 1bEfarOd4aIUsAGwykSl6wTk77lUgIYXHipyoUcruXRNDdoGVLPnUT1DE0iQLww3g/4TNgXYv
 /dzRemZ8IW+P8TqiLEq+voo5f7zHwGQPf6iYH1yqgvo2xISAcwQMKJpMpGKf0plHG1/tSCfaw
 W4SVFwu3yJmbt1+pKw3KvNYz9SbLrjsYZOzZfa/AbH3i3ul7opSNHzCxQi5lJHJRFU6fz8w4+
 K8RH41Y/yrW/9oVHwd2yxmLUBQmNF0Abz0en8Lh2yl1mUZKws9JCkLHbH5tu/JETibByWihOB
 VNiQ2IsLGcNiArR8sP1i8VmfwkIcUNLZefNxOxUDpiGq4MBYpSe+zQVbXQxciR5aOwW6PEyXO
 IPR5vyZdQl34Y3VzHAsbKGttaiUC7Qpge4RiICbhVyg+6orGtFCQlzaxDDiUSvcQhQNQQ764/
 KjWVOyqwM0N3POgAI7QVTG4UP2gVDCO84SPwgpIKeVnebQJH8wkLd+MS9wGINwbg+m8NFxbiT
 jffY9iRlw2Td5ODdFBCX+iFdJp+MoPsrr39lW8/qAv6mhb+l/NcYiQ9WmhP+FUpyyTP73uMTY
 36ula9x40o234cpm8rVJcGjQMGTbM4q5/4X0nVaLWLPAA9UIwRIVYom8yTEXBkJca0viu6lv4
 cl1R6z0FEWTUNujf4PgyVBXv5DSYKcf/8hiYDjExYIs3v96Mg1Kp3+gwCIek6FvQLOjEGqt/W
 2zOUH7NDjbmyGindu/qAnukE+24hrQituKTIrcZ2DfEM2/fMP+aZjAIK4L2M/bq2nbfNqnMNx
 mPz0ubzlfQ6cYvY3c3PVQ7bnh7vqE/JYN0xgPyF5gZQLuidXoXv9jnCLxC/5dr6Sdg6hNy3N7
 icYVGpJjO5pm1VdpEJ/N2wpe1c5ePLN7v45S9gVQC+pNfEG74GS/kFJEBgAomsap5ndOIi3ny
 2kRg6fm4J4n1M72mKrIQlUm61OI=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A map in which each element is mapped to itself is called an "identity
map".

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
=2D--

v2:
- Add R-b
=2D--
 lib/bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index ddb31015e38ae..24284caadbcc6 100644
=2D-- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -988,7 +988,7 @@ static int bitmap_pos_to_ord(const unsigned long *buf,=
 unsigned int pos, unsigne
  * to @dst.
  *
  * The positions of unset bits in @old are mapped to themselves
- * (the identify map).
+ * (the identity map).
  *
  * Apply the above specified mapping to @src, placing the result in
  * @dst, clearing any bits previously set in @dst.
@@ -1037,7 +1037,7 @@ EXPORT_SYMBOL(bitmap_remap);
  * the position of the m-th set bit in @new, where m =3D=3D n % w.
  *
  * The positions of unset bits in @old are mapped to themselves
- * (the identify map).
+ * (the identity map).
  *
  * Apply the above specified mapping to bit position @oldbit, returning
  * the new bit position.
=2D-
2.40.1

