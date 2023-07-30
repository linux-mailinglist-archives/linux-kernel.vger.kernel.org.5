Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3D7686BE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjG3R23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjG3R2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:28:25 -0400
Received: from sonic310-11.consmr.mail.ir2.yahoo.com (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FC11BF2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1690738068; bh=hWfMoHRlHCYqzwj6mCje4QmZV1hDjbVs6uGSWYCu1JI=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=VpppghCCAZJBtRqePPFm9dIaNhqJ/+lar8i2SJ93EzhJm1JyP1ARSitrjd/Ad272vkPmwKrEt38QYaYjL30DKA2qbej7zMJUFHXGE1wVN6aocBcDqtKgmN3sdz8G9RJNV3AEJ0+2Dku/Iz+yu4FJLgawtJxwzoCTbc2Wi4ECHovzFUnkt3vhjgxfVqnoJx0S1jo2Gc5ThpVIFG2t/8cGHGJ6iO7ZovfSLYv99MWAkwT2k5kg35jqET4I9CrRj564Ah6MhMdaGulNJVMdNy8JqmbasbcE8bivXXqLith6OnoLkeU2EHHIz3xE948WaTqUXgfDVF4d2hLNy0wmfIOQBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690738068; bh=vTI1C89cbZHBYomYvy9u8bKqarvrA/R4pIe4R5+qyth=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=ON3NGV7qvYES/L856SYMwhNzK/vB4Xnq+KuWGzMnuLAg0KeovamSL3JzD2GLs1/HsdHIq6Ug+imivDas7spTt99ViJa0Kw5HG6XIUy5obuJzVfIgB0Fxh3ZS/lCN3PHACd4WaAJmNaQj95dlncjDAJZZM0wUakZCiBzLeAXy33nJDTpy7BeAw98FD7rKRlxabiV7HInG5FJyGbxFe1JXTDF+2HzsK2Bw6MKsE+X2gwTWN4JWvM3xw1FSaiwfPnZbcvAuWkdcUlsy2RrsoIvhZDwUZsrt8aEuqg+aqltrSjxT9u2xP3a3SDDj411SwdeRoaLSobNOZkcNsYZifPrcMw==
X-YMail-OSG: uRjkjrEVM1nvnEEfyr5_XZclxlQWp46OC92Ue.GDyEduMkvFE3_cp9R3I8k3IkX
 CLX92CTbRCq9FOb6XnvPCxquIfJzOVW0alAx2RlJbvZLKlowP1x9SJXhKUwxmJEoU.omHisPmNA1
 Xxn0xr3qX0qU_e4lDsNV4JsxMG96MC_fRxHnhn5VKDYoZjglWOKj__H58ElgA82Wb4uhR4NQA4hi
 smQI1Un85h9MAQUbg1kfdR5AVx5hn1SoQ26oAdBrvJ_asFicvGHZQPCTSUUS0sptA.EqjkCa3i_u
 utM3vX9CXRkyZCD3ATbz7CWEqS4C6UN1Wb6wyFBH8VGzyMmwEpyVzLw_v9HWGc1SWG4pdGTVVrUG
 mI8yRassAHYh6k4dbqkmZxcCuQ8q0kAzDG2wGnTmTihoamkD3jtnG6x36gb7Kc20BDT4._uDLTiq
 7_5i.BqeVl27zAMN6PuGQYVEulk8odgVSfcz6.c2JLxSAujaT8_fk7.J5.9JIBMs3lrkkV7t.zGd
 g64cOXLNfmKwaNhRioIlvTGDGa8fM_PXq5PTyWJsJEZC1DYuI0gaL.yrqUIvaNu7pGxny4uUfGif
 Qovw8pE.gz7eOuuPqW52Ab6yiRFjtvPCFs9g98DBJLRrBgZBtDb0e3u3DyXgnQQWoA0EBVhAt.ld
 qtctTZCxXC5ENBPNXgqHCwXOSTlmUPXWKwwZeF9py_kWoQsSyZt2_BVKz34M3Is5isI.wpOKjetK
 567q9Ti7UK.hZKygkL3EY2pNCtEg5JhqoP3OJ5KdBMngbubVYCcKxn81JTW1.3Y2MaAIWgrq9L.c
 ed9BfhvyfmNviBUs_8f2mWgiS.e4mON.3UHdENpoMK9zG.vs4zv_w2FrOJA2Az9Zl443nlv0KZ9_
 aC2ZDgUtSGwzWubPX6QfxdWiO1Wvo91rakdJPbyOoSawCKVsmGr9K5HfUBzy9o28mJpmVq9GB6FH
 pLQXIcuRYOo_LZV6va3NLB00igX1onuKHE9vMDiwm3WVDp0zcKtSVnf8BZ5QknB2l1Pfye4Vwfop
 ttPa0OCI9QG_ykl9U.rSRMRdetCuc0tXIz6yzEeaUE.9OXhDIESpPsJnKCt5ttIRuoi8VgTqQZAA
 b4MavHj34hvu_7udPli9eC4tVx_aTaPud8E78VTxgu6wpw6jqpK6EpZNhxxmUHfwn6G_gdocqj1y
 Ke_PzM4ZLAGXDcLyC2lUSfrHhT.ze.8fCGj8vcc_EthcbqkhQtfK8rlF.spDe1le88Cv0qJ8JGH4
 s1qf3H57mfIjGTdoHoExjcOLf_xQd2U9a7Odb_VASmGZVxE0.3acSIOBweJsu6pya8G6KjPkCPt5
 SzHA36IKKZVLB8dZtIJ94Qn4JkkbpgdC36DdC2zzXlvW9iLGjyexThUlXHmLZR1zaLWJPfpyqmvN
 FjZJ4a1bKGKf7Xn81mWIGMFtIgOlqoz2sMT3yUSj7kXNwsmQSsEnXuJ7vdsyuBog5Tl4uP7l19HJ
 ZFtQqftSHv32dfBLxtH87IvD3Zm4YGSD10L4lHhFTK3eu2QzFYmEsxa.BEj.J9rzHOdeaPHCXWuD
 jsAHfV5w7OrC5Qy0MAyECHNzLzI1ebC1CCW20ZdB2D_X1qgwnTZTmamDXG6rWltxDOfVO9y2QbfO
 3tgSz6lkhjRksFXibN4sJJwjEP23.qcsFP.7cbQy4RQ9NqJk8hX0LzNXKPYsoi1CBasnKX20xpfE
 CPr7NP9Rcf3J0MA78ZcFX73bI8qGGCGBaSF.ggPduAJUgUrkpdcmtssk1VovcYzeIftwlxtw0BE0
 nEuVGcM4eff4jESoqG7.9wCKmiCiIJsPTW5aGmg0TiZPGJ0FvXgnqS1ftJCmqOmAvPjBgQ22DvEO
 5WrJ695darV98U0.Amn2gxO9YneI0rYOLY3nEyWKnWVciNILmzgkEZbhc1Fdy003Bys9ZSIkD7tv
 aOolqUndx84MvKpzba4rVKQ9pqzdFyoMAtYnTi1yEsA.yzuBLAaFaq7PynFQlWwT0IaIwcAYUW36
 Bp9tCZo59YSYbj7MmHPrQgT4qDpnlfw5_HqqhOrQSukAjeoeQ_.ns7VvBD_x1pCeTgzTELdOx6mR
 NPw_4AEbwzSLtb7NptDGOAlGArKCMPTBOZfSBIB4QmewaqhKFJUclSryfJtUR61PTfAaOAjAhNmO
 sRVD8_m4Gu3LYcdHnIFgmzql0S3EdwQ7WrIhMRusS1j5lLRcneOm2fNT7Cv9VphJwZFqkZJvcvoe
 TU_cglHYpNupk9deKr2mcFtk.Cy.fCjXF6tQuwDZI0PAAB7Scf7eK.q9YnlSAOPqAvYhbrQKhp_g
 y36i5EuF_egshD0KXszTb0oOjpw--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 781161b7-5478-413a-8f8e-7dea003a7a72
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Sun, 30 Jul 2023 17:27:48 +0000
Received: by hermes--production-ir2-7b7ddb79d8-pz5sj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ec871f8548a1982f3d0a52553952b962;
          Sun, 30 Jul 2023 17:27:43 +0000 (UTC)
Message-ID: <0cc0b1de-5f9b-5f0c-77fa-42fc5fa2f887@rocketmail.com>
Date:   Sun, 30 Jul 2023 19:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8916-samsung-serranove: Add
 RT5033 PMIC with charger
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230619203743.8136-1-jahau.ref@rocketmail.com>
 <20230619203743.8136-1-jahau@rocketmail.com>
 <02fe7c1e-cb6a-14bc-73fc-04956a2b8396@kernel.org>
 <3376e14a-4fc7-160e-509e-8dcbe627ef62@rocketmail.com>
 <b8e21ba1-900d-6731-579d-e18c37a97a71@kernel.org>
 <b067e3c0-c2fe-21ce-b398-3f889adbfd06@rocketmail.com>
Content-Language: en-US
In-Reply-To: <b067e3c0-c2fe-21ce-b398-3f889adbfd06@rocketmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21647 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

To close this thread:

On 14.07.23 00:26, Jakob Hauser wrote:
...
> I can prepare a patchset to dissolve this USB/extcon mix-up (basically 
> square one, as you called it).
> 
> Alternatively, if all my tries to clarify a possible misunderstanding 
> are in vain and no one else intervenes, I guess I have no other option 
> than preparing a patch to change the dt-bindungs of 
> siliconmitus,sm5502-muic.yaml.
...

Krzysztof added a connector node to the dt-bindungs of 
siliconmitus,sm5502-muic.yaml.

lore link:
https://lore.kernel.org/linux-devicetree/20230720080141.56329-2-krzysztof.kozlowski@linaro.org/T/#u

Kind regards,
Jakob
