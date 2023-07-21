Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0205D75D115
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjGUSIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUSIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:08:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7D92D46;
        Fri, 21 Jul 2023 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1689962895; x=1690567695; i=ps.report@gmx.net;
 bh=d7+NOCj0zr2QbS/Qs3ayEuVHnM+vEVtZH5MttU94reQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Np1OBUPMC3WTOwoM91eZK5rrNtjNqd1PrbUEpnsCsJlpATQcpRDzX6tzjxfV7q+7EKRXoI5
 AsBJqOjkdbfqks1+ooZce/l4lMviQRdkoPezslBErBBHmBm0Hfb8OIwfHvGPWrfhh1GjJVZQB
 Rh5/35hGCIUnuB8Cys/FAEvvurUi1Sod9hJUwPkCQXJ85R3I6gmsmYfaBJekHxrGxRtU+X2Yp
 AlcFanicrnPqZI20Fd8nDfDcubRMjNYFuv4/MfGnZ3R5Zf0yez4RWOea77gwkymQ5YY/qyeo7
 T627Y0psaR4tdi3lfMmD28FFkWTjzvEAlM5TzXvwjoEMgDvMm8ew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([62.216.209.39]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhhX-1qEybI0mUZ-00Aiwa; Fri, 21
 Jul 2023 20:08:15 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lukas Magel <lukas.magel@posteo.net>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH v1] can: peak_usb: remove unused/legacy peak_usb_netif_rx() function
Date:   Fri, 21 Jul 2023 20:07:58 +0200
Message-ID: <20230721180758.26199-1-ps.report@gmx.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:HKm+8cK0Tw1sAFXS0uN6nAmdO3n8J4GLE+78t6hDn1BCjTrLeZJ
 93t5ncU96ScQpKqDboh6pVP0dM2pAS3NJ7jN5drsVZis8R6x1PX28VLmpP7rK1jVYGVgzBy
 XjOtI20Y3Q+Z2QRasf295HRNx/3bTuTA1mkCtBPHr2xVDZsYSeJiLYlAIMMvcA7Q4dUAxI2
 JeWFVL3QjLv8KaWrrvsAg==
UI-OutboundReport: notjunk:1;M01:P0:i8wtBtZ+2lw=;XOKH+cMPUGrMTJSMwkuncju9v/4
 j7aMj/uOUIGMHO0C1k4cO48wZOcQk5OTM5MPeJ5ft5VDt/mMYs/fq7SYoYNgBpfZqgdJa7CvE
 w7km0RoDkBUR+FznHCyyQZZGvgIrCHsYQKNsxxoEBTP8HRAc6W/a+UXdV+Gt31o29HddaWdtv
 CTTw8jmkutxYhWSz/mXrbMUX0xOxmFGc1sCcMVGaSZqSHzhe3q6O1zJO/cpwM1UxHQgySDCK8
 1O37hblSTFduLD5+/MXLa7xib4bG9bmrVfWXBkaNenFswlhzbWgV1uviWX3a76zVn/21B4hHu
 5y3U9q95mpFWkkhVigyyuMBlMER5q+EDLAMfkVyt1pf6F+b7yPmh1rlinoWAbtKeofXvnB22U
 cl0YCvki3CnzxmyEY7xa+rZk2mDxwmqjHg0p/RSjqMubhli1izeTVsCqV0S/pn+7arz8iEizq
 yPcPwstQqcVQbUVjHB2m8DpXMh66DmgPD4/gYjOY0VqxkwPvZPxHshaGKOiJCWNPik3p7K3r/
 8kZphDh2QippOecRzVDbfayZoKRxUg8Q12Cub0JgHVuC59qovvt0VCmLSdqfc/zkSi/KhZt2A
 uDN8cCIFV4ZWDHDPyD/dc9LAtQytCsk4g7DPZpCMju7cLHUR3bcxWimZDYEgcpXGLkFNzFVaD
 OH0hhV/3uTcUvG3gaxpJUbfyM0G6Ajgh/+FTf6n6aCdEJSUXYxTCvAsSdPseIKJEl2V+dKAOh
 crHxyG3NBdN06hJUEERsAN+PZjBCBVpLW0JfThDuJncQ7pQkgygEUAB04C9cezoGcAnbCkw1w
 MHJxkg9BX7mmKHI9WV0unb/2PMg9mAewbwgOnntv2c3yItVXG4sCbjmgWMBvLUNJqqfZ34zaM
 z6suJo0TDcMmlQGaY1lccWaLHv4y3t6oHjOjC2YZPeOzAve4tXKpQCsx8HhWE1JVVPMIzWdYh
 v732dflfqBbo9BrTm9CQQgI00sc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVtb3ZlIHVudXNlZC9sZWdhY3kgcGVha191c2JfbmV0aWZfcngoKSBmdW5jdGlvbiAobm90IGxv
bmdlciB1c2VkCnNpbmNlIGNvbW1pdCAyOGUwYTcwY2VkZTMgKCJjYW46IHBlYWtfdXNiOiBDQU5G
RDogc3RvcmUgNjQtYml0cyBodwp0aW1lc3RhbXBzIikuCgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBT
ZWlkZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+Ci0tLQogZHJpdmVycy9uZXQvY2FuL3VzYi9wZWFr
X3VzYi9wY2FuX3VzYl9jb3JlLmMgfCAxMyAtLS0tLS0tLS0tLS0tCiBkcml2ZXJzL25ldC9jYW4v
dXNiL3BlYWtfdXNiL3BjYW5fdXNiX2NvcmUuaCB8ICAyIC0tCiAyIGZpbGVzIGNoYW5nZWQsIDE1
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi91c2IvcGVha191c2Iv
cGNhbl91c2JfY29yZS5jIGIvZHJpdmVycy9uZXQvY2FuL3VzYi9wZWFrX3VzYi9wY2FuX3VzYl9j
b3JlLmMKaW5kZXggZDg4MWUxZDMwMTgzLi4yNGFkOWY1OTNhNzcgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2JfY29yZS5jCisrKyBiL2RyaXZlcnMvbmV0
L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2JfY29yZS5jCkBAIC0yMTQsMTkgKzIxNCw2IEBAIHZv
aWQgcGVha191c2JfZ2V0X3RzX3RpbWUoc3RydWN0IHBlYWtfdGltZV9yZWYgKnRpbWVfcmVmLCB1
MzIgdHMsIGt0aW1lX3QgKnRpbWUpCiAJfQogfQogCi0vKgotICogcG9zdCByZWNlaXZlZCBza2Ig
YWZ0ZXIgaGF2aW5nIHNldCBhbnkgaHcgdGltZXN0YW1wCi0gKi8KLWludCBwZWFrX3VzYl9uZXRp
Zl9yeChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAotCQkgICAgICBzdHJ1Y3QgcGVha190aW1lX3JlZiAq
dGltZV9yZWYsIHUzMiB0c19sb3cpCi17Ci0Jc3RydWN0IHNrYl9zaGFyZWRfaHd0c3RhbXBzICpo
d3RzID0gc2tiX2h3dHN0YW1wcyhza2IpOwotCi0JcGVha191c2JfZ2V0X3RzX3RpbWUodGltZV9y
ZWYsIHRzX2xvdywgJmh3dHMtPmh3dHN0YW1wKTsKLQotCXJldHVybiBuZXRpZl9yeChza2IpOwot
fQotCiAvKiBwb3N0IHJlY2VpdmVkIHNrYiB3aXRoIG5hdGl2ZSA2NC1iaXQgaHcgdGltZXN0YW1w
ICovCiBpbnQgcGVha191c2JfbmV0aWZfcnhfNjQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgdTMyIHRz
X2xvdywgdTMyIHRzX2hpZ2gpCiB7CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vdXNiL3Bl
YWtfdXNiL3BjYW5fdXNiX2NvcmUuaCBiL2RyaXZlcnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNh
bl91c2JfY29yZS5oCmluZGV4IDk4MGUzMTUxODZjZi4uZjZjZjg0YmI3MThmIDEwMDY0NAotLS0g
YS9kcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiX2NvcmUuaAorKysgYi9kcml2
ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiX2NvcmUuaApAQCAtMTQyLDggKzE0Miw2
IEBAIHZvaWQgcGVha191c2JfaW5pdF90aW1lX3JlZihzdHJ1Y3QgcGVha190aW1lX3JlZiAqdGlt
ZV9yZWYsCiB2b2lkIHBlYWtfdXNiX3VwZGF0ZV90c19ub3coc3RydWN0IHBlYWtfdGltZV9yZWYg
KnRpbWVfcmVmLCB1MzIgdHNfbm93KTsKIHZvaWQgcGVha191c2Jfc2V0X3RzX25vdyhzdHJ1Y3Qg
cGVha190aW1lX3JlZiAqdGltZV9yZWYsIHUzMiB0c19ub3cpOwogdm9pZCBwZWFrX3VzYl9nZXRf
dHNfdGltZShzdHJ1Y3QgcGVha190aW1lX3JlZiAqdGltZV9yZWYsIHUzMiB0cywga3RpbWVfdCAq
dHYpOwotaW50IHBlYWtfdXNiX25ldGlmX3J4KHN0cnVjdCBza19idWZmICpza2IsCi0JCSAgICAg
IHN0cnVjdCBwZWFrX3RpbWVfcmVmICp0aW1lX3JlZiwgdTMyIHRzX2xvdyk7CiBpbnQgcGVha191
c2JfbmV0aWZfcnhfNjQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgdTMyIHRzX2xvdywgdTMyIHRzX2hp
Z2gpOwogdm9pZCBwZWFrX3VzYl9hc3luY19jb21wbGV0ZShzdHJ1Y3QgdXJiICp1cmIpOwogdm9p
ZCBwZWFrX3VzYl9yZXN0YXJ0X2NvbXBsZXRlKHN0cnVjdCBwZWFrX3VzYl9kZXZpY2UgKmRldik7
Ci0tIAoyLjQxLjAKCg==
