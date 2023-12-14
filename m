Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60600813426
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573741AbjLNPKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573670AbjLNPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238AF129;
        Thu, 14 Dec 2023 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702566602; x=1703171402; i=wahrenst@gmx.net;
        bh=rYispb63UqZXzgy62A/1FZAm7a2jT8FXIlaZMoImlD8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=ZUZX87KY8FoSmaFhn5n+Qn9Qh6mx8MOOXSaBGMhR8LyCS1Iy1kTb/DIspdWnjjWX
         Npzo+3saTa5Eh8blJxOZMEbui9OYSBolpT3hRtwGh3JG4F4a5ev9ooGivTscMbS/j
         fXKA34UD8dK2bwXsmedhAD+DSH6wjOXWt11uMYFB3QVVUlPYeI3fUN19p89WS8LVA
         UNdQ47dQV65kdw/Ljw/0Zlk/jNlg/FWgzmQIEeCkQPQwcBOO91JMpWndKXVMmvFNg
         rPnYXDoMH1e2lJa6YGY8R5yEnDj/7Vf8uG04k2ro7gndVmOHukQ7RJHW2n8ugGZzi
         ZMC9mOfZ8aLHBIGBjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE6F-1qtEK927kR-00Khcx; Thu, 14
 Dec 2023 16:10:02 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 04/12 net-next] qca_7k_common: Drop unnecessary function description
Date:   Thu, 14 Dec 2023 16:09:36 +0100
Message-Id: <20231214150944.55808-5-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VbLJpMCe7heODYKKm/sey597xrpchi5RYL2k/QMfRbmopw7sWhZ
 /McCGcQ2UL4DWjqT60va6Hq+5CBiHZFmwNj8fFctAzoA3cO101RHrVLNkT9TZikTRs688VV
 gYeHT7kaXHxOFx0xezfhtT+yQjz1QE30JxcMefBk4sUO0K+ZzRxjYdf6LeTfiUy4Or/M51A
 zFat5e3YMXz+sUcTRb3ww==
UI-OutboundReport: notjunk:1;M01:P0:daEqLFpVZd4=;jSL4l2pwog3lveXnlWmwPeU+PfI
 H3rDsaIdadwdQrstDaeOR6f+hdCzaFLsY9sUCCHVbHpiN9CnpWpr0UkuIBHb4x9MmUUiJG86l
 luqvR0/gyLmHVRN0fJ4HCdYUKRuY9f66k1ryi5QdIdczt70OquU9VBA1URIQljIlqS73l6TA+
 7ujbZmZEq2lpUTOns0U7UccBpAh94FPKcXlLw8JaABoaX5B2FOlwueXQq3DgDw5VR8e9d6VDy
 kOsEGgH3l9Lq9ccIWRaCN+CFdff8wdfGdi4Pm1haaphfqvJTRXeM16x9j+oaZm5xIHf0Kvl8V
 cJVL2EMdKDU60I+Ei1CoUaXJSIRSqd57XZTofUsQVQoqfZRkHcxBrcyUiJIdiCcEasofo+2Bz
 Vn2BI64155CJvAuXqdkWwMLjDXfleCnpNHcCSctTO4xIMLo4RSi4UqShcISDrRA/N1AWZcNiA
 OrNZAmm3OJvljw1qfid+NRCHmxwv1XNvOxGy63eY5GM/J1c+r5Pfstlm24jw2mmjPidKcVx3J
 eer29OhC7s4xEkyodLaMNTGjCra6l7cwGGxZeiliAw6pYjQc8RAd+nXu31janp1bE5JSc1W//
 x5SUoXvV1XfeqiCDJ0yFD92QKOldpnPrpDHpkO30aWKMbOfkGohk/5/RcYyR1DWMYwTWegmdp
 SCWmjBAJiGwiYBdj6ZNM9iJUxMx4fTkDQv0jR/cAPu+rNXUWDtluVEzcXcN0DWH9M/zVshqrq
 GRrOVjHA07cR/DOq0WzrcgcJjMJq4dsbd0WQT7V0V+VTAn0tkaDu1sRe4ncuEkr/pH9XKc7am
 9BTj3CvJGlpCwy+bH+v3Bjj9OuKt/rySra6fHH56YqCCqujzeGVc7BsNe7vKmJ5gGpy2Le5hH
 4AaShZLoBt8zC33nR62btEFDF+ystkh6oWBo+Fbb23rbcg/lBCZj6hcNltCq7bcrYQx2WoKMa
 AP4aqA==
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

qcafrm_fsm_decode has the almost the same function description in
qca_7k_common.c. So drop the comment here.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.h b/drivers/net/e=
thernet/qualcomm/qca_7k_common.h
index 928554f11e35..71bdf5d9f8d7 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.h
@@ -128,17 +128,6 @@ static inline void qcafrm_fsm_init_uart(struct qcafrm=
_handle *handle)
 	handle->state =3D handle->init;
 }

-/*   Gather received bytes and try to extract a full Ethernet frame
- *   by following a simple state machine.
- *
- * Return:   QCAFRM_GATHER       No Ethernet frame fully received yet.
- *           QCAFRM_NOHEAD       Header expected but not found.
- *           QCAFRM_INVLEN       QCA7K frame length is invalid
- *           QCAFRM_NOTAIL       Footer expected but not found.
- *           > 0                 Number of byte in the fully received
- *                               Ethernet frame
- */
-
 s32 qcafrm_fsm_decode(struct qcafrm_handle *handle, u8 *buf, u16 buf_len,=
 u8 recv_byte);

 #endif /* _QCA_FRAMING_H */
=2D-
2.34.1

