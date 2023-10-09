Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5A7BD26E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 05:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbjJIDpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 23:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344883AbjJIDpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 23:45:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842FBB3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 20:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sonnenkinder.org;
 s=s31663417; t=1696823123; x=1697427923; i=maxahawking@sonnenkinder.org;
 bh=BooXJXIX021ufBUvb5WRfivwZXsb/EQtHjhdIiYTc8g=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=ZS4pDRTO9IPtxvO0LIXX8a7q3tzzKf9wvpC01/b3W4xAZldix/NIL4WV3lwOADlzvOHRraDJLhO
 lfja7zevXY8UIgNdN3Fk/eCwSTHbQzZjDokjuwWy/DR63UA4nGlehWrWZCjKbn+j1EgrTgu6GM//V
 fwVPhDC7zZpM4uNjTBMCgWJGxKp7P8kihSbenNlgo1K3Ac51SICPsvLPOeb0Ry/xa7j0Sz9e5jRCk
 xw5QM4quxuAiRpDNIgRiTNVQlYW3JioNpRjIMOTtNRWXPW1h7SZj6M5ODPWObddsD/UwRAi3qmoWQ
 yw0C8leC6eK46ALuPaickj5PNkSG9KKNe5dA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.209] ([173.228.106.87]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7iCW-1rbYfZ0E30-014lVq; Mon, 09
 Oct 2023 05:45:23 +0200
Message-ID: <2ad3273e-1212-428d-b598-e6a82c2bc570@sonnenkinder.org>
Date:   Sun, 8 Oct 2023 20:45:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Minjie Du <duminjie@vivo.com>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   Max Hawking <maxahawking@sonnenkinder.org>
Subject: [PATCH RESEND] ntb_perf: Fix printk format
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wfeZcE7YQl23xZEtSBdR74ZaI2yyuKTtlyDr3kkQAYRbMVyKOGV
 KtH9mc0H+pp1e5+nQWQJT+Ri452lXu81Z2YpYWXHutQ5yWRB9dzW/52U0mqVQ1sMgXsRNGL
 wLi5u98008ZzFU1gePkQf/JhQ8iU7lRO1PWmC3Md010DAZnatm+3Mmk9/C0nub7NJBMh3ro
 Guu/OLJjsuCU9vWYi2MyQ==
UI-OutboundReport: notjunk:1;M01:P0:72h2Qk2nv/0=;hAEEXr9SRYK7Qp/EIKUlG/LFcpU
 vf0YKE6C0uyZRm7szbq4EWoyhJoAgphCSGennMwOtIXnOQO0TaboazMCmTCGBWQ0p07fiLbF+
 PuQ/pnpAK5YdSyt7SORBw+1i9/OeWIUyevKoS9SBiVvPTSjA0DNBfN7f1qUz3vFjJ07eMwWDb
 J1Kj8h63MF5/9kLxZkpzWS9cM0uussDQJ+IiLW8aTGWsCBethRWD9c5+r+YCpRntR68FJqONH
 WiERE8Xtk8OxU5DLimLdIcivbDk5AVB+UrQsMAMpELzp8pHJTRTbEZbm/eaOiG7PjBQD/3DG/
 GZmWQZECkQ/ByG/d/s4PLSkYqDWMg8EpYfGx3bJ6l0PoMq1y9hUM/r/c5jJf3SQqtpOGIiquY
 kvpEiaw5MxIzSyIXQ5kyI4dz38FIfpi6UOPqoHDVQ48/PGQD+HK7e8VdtiHJfUU0YjUi8R4Xd
 WflBmr4zOK52A9/rL6F32XE5QTbbqj5cmeLaxTtnPtGO7ySyspOtGJQe6TbLs5V6gcOIEvhDA
 XPitTmwBDpC0TAWOjmS9mYptmoRlfSk22Xsi9Dlyf2lxy5Lwfc0BbMdpFCYEABqh95mMLNrXi
 JNMya34TKyiRJisJRe/7BHTUDxWBYw5lbp23OJwJcmj75if524NbzYYATjfxTEvUYHtkmr26P
 YEEP5T9bXinEttMt0bMz/gsaAsjSdyf+g5FS/P1fhUCw2bS/Oc9ujjFTzLCyp7hdVH+jec7+X
 z8kUys0GXMKie+MzAZNXlyVHBTSShPBgxrjetXFliSKAvackMrhEgKys5BYeYKoCNlyonK/b6
 TivonJC9rRBDOBRpj1AW6qRt10QpJnHB/y8lNvqPPZaVcijWp98smvMtj8SrvMEN+0o/BgY5I
 N2v/j1SmjRjcPMpRxKwIlYxrBdYbOmx9eoRJ57HfAFxGNadAOlbCNPW1WnyhCQszdIs4OTKoK
 I5QfZ5r4ULnsSJQuK3+RwXy8VGE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct printk format is %pa or %pap, but not %pa[p].

Fixes: 99a06056124d ("NTB: ntb_perf: Fix address err in perf_copy_chunk")
Signed-off-by: Max Hawking <maxahawking@sonnenkinder.org>
=2D--
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 553f1f46bc66..72bc1d017a46 100644
=2D-- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1227,7 +1227,7 @@ static ssize_t perf_dbgfs_read_info(struct file *fil=
ep, char __user *ubuf,
 			"\tOut buffer addr 0x%pK\n", peer->outbuf);

 		pos +=3D scnprintf(buf + pos, buf_size - pos,
-			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
+			"\tOut buff phys addr %pap\n", &peer->out_phys_addr);

 		pos +=3D scnprintf(buf + pos, buf_size - pos,
 			"\tOut buffer size %pa\n", &peer->outbuf_size);
=2D-
2.41.0

