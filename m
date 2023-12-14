Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7742381341C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573690AbjLNPKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573666AbjLNPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1D310F;
        Thu, 14 Dec 2023 07:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702566603; x=1703171403; i=wahrenst@gmx.net;
        bh=pMOm0QZ3NBUI5Myevq+RLLh5bsvVZgcSKMIaZJHXflY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=XZlwJWZVAaSYvnQeJz0BF4JWnNHIx+8rlnwXB+87lBGw6jZMPsTGss8tp78jxO50
         qFYu2NM7aYMVh0ndZ3jjFV0D00th03jRjUo0srjUZLC+TUSrjTu9JViSnLbunOBqd
         3+U2nIQAAdlY8l3ijpAiU/EaspHiV1zjic5aOpnnsDrtRk2x8eJWxD2eWSpfmOoQI
         l+ynqZv4LasqD7BrLqsMEQ/FBTkD9j/uw83dgo0VEU6FKcsya9u0ETJ+QKWZkNbAf
         fPde197/XhqVMyL8FB0rmYkREgVokF5/AKQ6Oo0wkBvCpbFVJWTpvzC7T3hI1qcoS
         3qurELDDxl0avptAig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1rmZrs3Ufq-00Zt7y; Thu, 14
 Dec 2023 16:10:02 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 05/12 net-next] qca_7k_common: Drop unused len from qcafrm_handle
Date:   Thu, 14 Dec 2023 16:09:37 +0100
Message-Id: <20231214150944.55808-6-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aj3sdZ088cqe6EU8y39swPh4At+btcIf51Ev49HT8NQVoVcf6uK
 Yyvq2I7BodPzA/Qflt+ByvpN5bAIrjETShoTKoL4N0zFQI7wykLZD+0UGlgKfULx/49daki
 SEWLRMIzBRzix4P3AUP4EYJjlqSn5WBnbC2tE6hitRN+Mr+puHHXr9uqQltOeHjzyNYmEXN
 QPOIkL+3vzNGN5FVKpCbg==
UI-OutboundReport: notjunk:1;M01:P0:5mwPav9rwT4=;MNH26R9Y+oV658BHOMGaVJE4/7d
 EYn+CemAv4PLo6KcuYwWIZi5c+/J0VIaw6z0Bf5kh1WyqTPmAqWuam2KeAE7XSvfV4IVbQ0b+
 mbDc8cixpF51llvQmL3BavbnHCraOmGYS6xZqMzVH/mer8YMzrIt1rIGo94RA2jUFBHoY7cCh
 G1/LHUhLE4SY9pwpZZnubDaIGpk0z352gLWCaLI/dyT9yt/exFW4Utht9nlR2qrQBrDKEref+
 KuvtjoKHar4rJsV4XW/wMYdo7VU6f49VJbHkMKXS+CRGs8lZybh7pYrdNvanBDX5MDVXXiGzD
 qL8FlUO/YZxKGiR6ib72kVIMaoFwx3pqS6x49iDxU27NoUCf83YV1eXay6MHxrZ1t847EKcEm
 KDJ+zBht9uRDqou4ZlRhaByDibAg/atlZM4evGxQuxTTBrNrDwqJ2j9ixpklsiIVHi1aArUXs
 eGPv1xPOv3+U5uYk3PjDZi+s8XczIEgOLP2Pj+tuYkJlxhwRwDUzDxTCYEXycJXf7J+cOeyul
 WKVivkut6fz/z50YEdf+n+Mcps4XTElx6emuSt946Tc6qxyx6YlKrrG94ovOnEohhRTk/lz9T
 RHqupNJvkQ8F5GZ4p8nmtp67nyGM+PP2KWUm5uLvbdtgj4s18voQV7b/G14363f+2kg6Bz4Xa
 5+AFhmazfhNeuoOV2YDwN74rQe9yxrVazoQnu0LWYm+1X9bdh7Q7Fc4vO7Nc7f7MwGgO4itJE
 B6DysormbWOvMd25v5zKwtvNIUpHvStKND9K7mOpbzsbThC6zwji4+pECv6ElvmPTTgMUxmhN
 ABm8VmSKalMDu61OR4JHXlcUKGnsuGLcfDmPFvIGFhfM51vWCjfpXD+kw2o5bb1RNRbKrJKQD
 48FJhGbXoWf3YGKBlQtdZCcQxozbS6/YcuWzqsHdUbjrtaGcroA1fdd1Ogg4yGcsFcmiBi6iq
 Aob7cA==
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

This member is never used. So drop it.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.h b/drivers/net/e=
thernet/qualcomm/qca_7k_common.h
index 71bdf5d9f8d7..088cca7f61db 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.h
@@ -107,9 +107,6 @@ struct qcafrm_handle {

 	/* Offset in buffer (borrowed for length too) */
 	u16 offset;
-
-	/* Frame length as kept by this module */
-	u16 len;
 };

 u16 qcafrm_create_header(u8 *buf, u16 len);
=2D-
2.34.1

