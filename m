Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4337F7735
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbjKXPFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345617AbjKXPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:05:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB29519BD;
        Fri, 24 Nov 2023 07:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1700838301; x=1701443101; i=frank-w@public-files.de;
        bh=Ix7kpbSVl/E0T/0d1Pht1rYCZKqw3dVgDyb07vLVcGc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=PvbSTSIB4lffJljSG4x3vZo9axQe2k91WFc0HvK06Uksi2okqG7+tSkyoV+MGlHi
         qB+NxwOL5rjz/C1NKlxPEBU4JtSY+l6QEUeNAiFun+qWx+A/C6a8HpCi9Yve0BCkW
         FRd62tCPZrx93DokOlSHqhy5/ghscbSYDPq/uvmJC0jc5BRS15u4KvDi/Q2drr1kk
         qvgomya4GLFbA+omT80QTN7MyzCXaa5gH4g7zjoGEDnBn8qgzpwXV6+j5/wjRHqDN
         PHZDE/aS5AcUn7qvi7qsL/5CNZ1vlzAGWFMCx9aDGUmRaQTKTU7GgDTztTGjpnvG/
         BR/ekAfiQ+xol7YibA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.79.113] ([80.245.79.113]) by web-mail.gmx.net
 (3c-app-gmx-bs48.server.lan [172.19.170.101]) (via HTTP); Fri, 24 Nov 2023
 16:05:01 +0100
MIME-Version: 1.0
Message-ID: <trinity-a9a71294-1396-43e4-9ed5-9ee2914ef093-1700838301802@3c-app-gmx-bs48>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Corentin LABBE <clabbe@baylibre.com>
Cc:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Aw: Re:  [PATCH 6/6] crypto: rockchip: add rk3588 driver
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 24 Nov 2023 16:05:01 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <ZVtVkACNHTcCjqGp@Red>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-7-clabbe@baylibre.com>
 <trinity-a0ee3146-f23d-4f6c-b29c-5fe446c4d4ad-1699797868421@3c-app-gmx-bs50>
 <ZVtVkACNHTcCjqGp@Red>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:KZY66OmMPVZRMlmi74pw8ADByftw6rLqB4krhDPt1n6lm6PqszSx4cKvc4cZjMaxiCH9q
 9l76vJDnRyCKy+eXbolThC+wwdw4dv1bdU4iTgErQSSMfaGhXdFf9Hw8m2d54Obzs6CpDsrq/18q
 TEe0LEFYkOe/u47SsG/Cz/fazr5GJSKcscqOCYKIKUI5ZS4Qz2H5T/mWYX/BAwcWhjtWXQ3IyITK
 gWvtkulcLy4Ksr8Efpa7xkFttn5SYux8Z7cGFDgcF33skBoacgmIdOyvNt6ysMKaEToS9LDLnTZO
 zw=
UI-OutboundReport: notjunk:1;M01:P0:nU8MkRQpVF4=;cW5EMDZ6CBFw9FyqPe6KBZB/V18
 K6E987HH1iAQnNOcy5ZBHGefyE25N6rxX+3pirLkOnU/zCkzodgk9FOxD9Cr1RQOJ9kCBB5OU
 jUboXEL0DRyXxqDsfqi+UATzF3N2/tp/G4gWip+pFqinf6NKT2XWejdO50yHxVXgc0Af3J+F1
 Yyz8h5CY0RZKPd0b5Gd23VSlmq+/Widrj5RK8DDKMX3Ak3oAFl2MGRuaFGFbPG+eE8UB3exU/
 J5W38CPcFE84FhhfxqzfTTr0LrEezSrHh5LDp93NU1UK4ECk6y0qJ+f0iaBMTkv3kIHI+Ohhf
 XoOWmrQcoaXHHv8IDCUz5B2NhyK1EiUtuK4DEHcksp3BynkMeM2/ymRpEIKNY0ulRuyzJRPm3
 +orjVtzoZWjdd2CkjhJfF2ah+uPoDp2pd1Z16SvQwmR5SfJMcvgt53OVp+jtSBC8rD314ggIe
 902t/NJ/xbV+W/bATfBPqX7Cx6WRmBvHwOng3dgR5Rv0TwPBwhGVzR57K9ZiGspS0M4liI+Q6
 QSIIBMjJBkamkRUnn3O+G06PooaSgO+99XkvoWNuE6Jv8W/tggIVAanoHtTD8Xy7G9M4ha71F
 sLwihv1Y8dsoJNQNwXtvU5jsUM4GpCu5fJCT6sGXsVdiVlD/bpKhgyViHDS0jQQmgqklkrrp0
 5lRwUv//M/OuJEbtmb5K01CzVlpVt/ik0vohNwuLlOfjMtRiU+Yd5AP5tLXBnrHcWy35cO6yb
 ItPBMt4lQN8fZGopD7NmXSoIQbY0GHqO8OzCdo6IPY5G1Q0n9QR7v9LEVt6g3JsDKOL/yg8qQ
 cQQlCI0IDm0t3wNCSzVHhNIA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Montag, 20. November 2023 um 13:48 Uhr
> Von: "Corentin LABBE" <clabbe@baylibre.com>

> You are using kcapi-rng but the driver do not support RNG yet. (and probably never if I continue to fail having good results with it).
> So it is normal values does not change.

which functions does the driver support atm? or how can i test correctly
(and which kernel options i need for this)?

regards Frank
