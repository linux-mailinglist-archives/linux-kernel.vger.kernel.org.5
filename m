Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476BF7B1D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjI1NHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjI1NHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:07:21 -0400
Received: from sonic310-20.consmr.mail.gq1.yahoo.com (sonic310-20.consmr.mail.gq1.yahoo.com [98.137.69.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D84199
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1695906437; bh=7/JHu1At3lsSs82rSJ5Ikeu4GT9bo5ecWa5+ln+eCbg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fwBhG5L8kYztQboJxHpqIP2o3rYSQxKDVC21f/56oGw3kOX0eu1VEaINLxxP8MtXyuj4DpljnHq+XywO/Lz4il4u3KdT/T3H0669luolsDSE903k5p75dOl3juEwngwAsv+15SNbUznw2sUmK4/29/72nSQHPrivXKgD49uknfUqN2mqKzjWQtP052oB5de7hZQPC7UUv9I3dLvoORg+KnHRwYhuUccHgEwKrBTs+0X8Txc6FToqUP4UWvxRK2wkoiHo+qF0BpvZDnG7BMUEjgDSuWDtj0HOc07BaW7ZBMh1BeIVYk3DuPUfYGCtZiB8du0AVQz9HJAlB1IIg+8fSw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695906437; bh=O4OAQ2tiiNrNY2L2bRtnXHAxVtNRY5oMEO//RAYqxhE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BzrHs1RtChTFpFhL0/PtNPUa3jTrj78rQ5J/L4i6JdELH+1DyTCdI8LwUM5+6Tp57p8DlvYAK/GS4xdpE9h5DKwkdrKPuCiFcFaF1NdG658OrQwq5Br5cdUvYPKJ5NGgs0potJFt1zoU6uODocj9fI0xhgMnRP/UulxYR9XlV6MB95pFkxn8li8PiFRu15MmMnTlMQlhVdANMtDyRRvI1iy2EzVldJfu7UMs1f47D3maABIdQr4qnhR0pEuYqdMzV4qR8J8gLYwbI9KZFKleFwpDl84NhGJoWvXjhlYcsqcHv/z5AsjwCTOLVsyl0VOPoQHaNQUKLeBAhNfbym/w3w==
X-YMail-OSG: 4w.AwnYVM1m9kJboZZgX3He.WMl2SEKXOaQZ1g1nn1AdOsMWu4L.2885XpGQ7TI
 Bs.3qIcWWFh1I7f62S5QJC0ZqxUMHcGZk2Ci2CWrNbklY4HZjrCF11cgmT.TfMGNeQu0GG8FYeUZ
 UbLgL0zoE3v2MZ1iTHGlykpVeXZ68YNDtlF_FD2kYEdIQ31lk_6EBmNVQrRKCRkaz1jVvxWc6USU
 ptdUcnmWM_BJYZIU778AfGn.4eIIs8R56MN20_CriXn_zslSsdWTDtTpzSwpAXfjnUcdmkkJ6wHs
 c6b7k3B49_qVQBRVOdZPQIrr8PRiurULSBOIo2CkCdQshttPWY5_EYOlFmjosW1cyQPhg8UkfUGa
 _TJLtwloHFv.Xp3Qpjk9GcWYxnkria3zhnjk5Vqv8ryMWTwbDDzg5ouOiB1fPahYhz8WnFsOxjty
 H32j2B3ZK3ENBxRhraXKSkv3S7xB9q.ZQDjpn4DW44K5x2TAwMY0lNdV99v_uJGv17nzmbI2U3VE
 T0VK4KjvbppaWuEqVp2HS_v7.doS6KQSyfDthvG8Kl.ODSjG5zwuSgQGnXoGDR1VcwY_ISSXJ_Nh
 F6UWTiY2c9kmhQm_V07_9OqeLcU6WPQCXnDnNHJxobHRLuMa92pUhMV9fQRKERdu9EtXVPiHUEiG
 _nT7zhCPSaYLIzhHDkCSFFq83p6TYwB0ger5kVaq5xqtvuUtTI57eHI3QnXeeTHWq4K8Z3zwK.wu
 0F0NJ_eNNZeBWaK5ag8WdCdXj8s6z5opR8Wqsi2LrZNWfNx05XNDtn.8pHJsf.MLCtNHf._UJXBi
 LMvsrcXQR.0qmtlmnqEcAPH.WYnN9KLRjMd6w0_2EqKWfXVBLVOLvuMl4V2askATog0O6c9vREnQ
 dFwirqIXt1eyxm6PTbWfj6SZelbCEmUeDOpAHyw00bLUNIZBbWizucimAoq6rKH720oEj0UsIghF
 eDkCezr4exneyw_FQyzAvb9QInurZbO9RTQ9l6SZVDe4d3Aij4iOGk8HXOr5njnMv9oEoqZse7w0
 T8W.v22eQefHeS5iU42WtNmN_.pQRb8jxFSFDPRBNYEttLt2_I6fgXSJun0X073v.ne5fNq6z35o
 MyUCEDfvv3nguENSK.7y1zW837C4Bnr9KULMPOuBh.pOhFNHZcD21R.DiP1K.hxocj4T2mvLpryd
 on2SwYej8w0ra.kYIobJK0HLFiHoxZtZ_.JO7n3BjLYOKa13EtNOXu0FAI15LGRMtgMqNuZ5Kna1
 f8sUNHgE15vO2.zgLaOWe_VOpMNMusUhQfql.L3JUIEiBy4UO.JVceBXmQ03XGUjbPOkf_QP_vdu
 6B0d.qjSfMHI_uhIUDVIqcj3kLUTzl8XnurUYLyWDI412Ys4P0fr7t9G9Sg3UJWm9pqCYffzbI1u
 cCnJZd.WJtYThW.ZTvtK1r_nYvqJhkXCbyAGH7rmn3D9sLyZY147xF1OZIAf0aOXnZNIfCftZNoh
 vUonNL2hNF1SS_XSm55_rQAM_eir2O9ySrdlgqjIqTKnHmxgDlYI2m4bRpG7QsRzTnVyX3mYeKb1
 aw01Zp1GZZnCYwhDQdsQ8iwxa3VkAtqlsLXFtLewszD.S_7xNXQmcQ.xRMI3EuTpUHbIDYsvT5m6
 luoC0OpbZr93OjjDnh6UnCCNZyXZWGMzi3XxeCHCfGAybWp6pfTR18opH2YzNT4Mtq5dRWTZS53h
 iMAloEDdTPPs5ojnMTykADk1WTI2ovoLTK_OuMF8NdCSWb4B1tscvyk2uVadZtseKxAJB2ziOapN
 rIKudez_.4xAiGCGHJ4OhGINlJfr.LYcDT0qcj3g_vS60iFxHA0acC.Tq6zBYAEf5WG0HRmd0CmR
 zd5R0sCRR5FVaNEKKa.wtc5VbYiQHa2tEs5SZ_0QHGb1edNHE_2TRgwWtRyvL4Yox2OzoE1IZM1T
 6nfUmCqKZLp6yLbNgSgC7aXPJa9ZdIOF4kN9Njkqr.o6dea6dQU0.jWGgt3.Cv.900nyShDPNuQ9
 cG31i4A6TcpAUYlXUNu6QfmpmCF88Y5K8kZMhYSqHr61jp40JsYrJyigE04fKIql_u_RhQ17O6JQ
 rPQ2cnxxBC9gtu2gC1DRu3Lnv0HTk6.y1jDMZMoB5.4yNQKMwyrYm7OipA8eIlpFNb5umfE4_k_T
 dFdGd0R0wdYl3TiB4AJ3evuPirsdpA3gCHUtiDSsu480P8akYr_dBZBvF_4HzoNxrSXUKjuLCT1K
 l4bog59FX1EIuaErz48BWcR1j9IUossAFPRwe7Et77JqARuZnPV0NOQYNmNHB6ZUNu1D19bNt7U.
 f
X-Sonic-MF: <earl.chew@yahoo.ca>
X-Sonic-ID: e8bb10cc-933d-4614-a0a3-c75530f97cde
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Sep 2023 13:07:17 +0000
Received: by hermes--production-ne1-5b56858476-gtxgq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f346c2955d660113915917d4a1c1d41d;
          Thu, 28 Sep 2023 13:07:14 +0000 (UTC)
Received: from localhost.lan ([127.0.0.1]:52224 helo=localhost.localdomain)
        by postbox.timberdragon.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95.0)
        (envelope-from <earl.chew@yahoo.ca>)
        id 1qlqjY-000fEn-1d;
        Thu, 28 Sep 2023 06:07:12 -0700
From:   Earl Chew <earl.chew@yahoo.ca>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     peter@hurleysoftware.com, earl.chew@yahoo.ca
Subject: [PATCH v2 0/3] tty: Fix tiocspgrp() related races
Date:   Thu, 28 Sep 2023 06:06:56 -0700
Message-Id: <20230928130658.4045344-1-earl.chew@yahoo.ca>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230901015030.2469062-1-earl.chew@yahoo.ca>
References: <20230901015030.2469062-1-earl.chew@yahoo.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resubmission to correct errors and warnings
called out by the kernel test robot.

Earl Chew (3):
  tty: Fix __tty_check_change() and tiocspgrp() race
  tty: Serialise racing tiocspgrp() callers
  tty: Move task_pgrp() after tty->ctrl.lock for consistency

 drivers/tty/tty_jobctrl.c | 47 ++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 13 deletions(-)

-- 
2.39.1
