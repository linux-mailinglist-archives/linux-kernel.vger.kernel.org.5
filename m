Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C1796EA7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 03:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbjIGBqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 21:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjIGBq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:46:29 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EF4CE7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 18:46:24 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230907014620epoutp03d8b5b76ccde4d40674d979193ae11409~CepLHqyss0283202832epoutp03I
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 01:46:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230907014620epoutp03d8b5b76ccde4d40674d979193ae11409~CepLHqyss0283202832epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694051180;
        bh=OkuoPtTpHJVB2fCg6+nOQpQ3udhh1o1CmNxCcKdiJLg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=D827dadAG2MhEI1XXXvNOEaeFdYQjom/x6ehUVVTR4TvL5rJsdxWjDRo6AbeVS7PW
         lNYfC56oDICyIjtm+5t+kjM95i0pyHr8AjdonGTAri4n2dl+HlCjW35jPbPiSqubVv
         TYz/HVHkmNEXc2NtFhthcZuY9iOb6NUuRaysRi/c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230907014620epcas1p4c9f7f4f01a227409b1dfaf6d9322542f~CepKqLWIW1550515505epcas1p4X;
        Thu,  7 Sep 2023 01:46:20 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.237]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Rh2CH1WS7z4x9QH; Thu,  7 Sep
        2023 01:46:19 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.FF.09647.B6B29F46; Thu,  7 Sep 2023 10:46:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230907014618epcas1p17b3301ecfe2bd09f105e905dfb9123b0~CepJRjORj1677416774epcas1p17;
        Thu,  7 Sep 2023 01:46:18 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230907014618epsmtrp17856d09f45545919c829ce4e598640b1~CepJQyoXm1887018870epsmtrp1Z;
        Thu,  7 Sep 2023 01:46:18 +0000 (GMT)
X-AuditID: b6c32a36-0d9ff700000025af-25-64f92b6b02c4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.D4.08649.A6B29F46; Thu,  7 Sep 2023 10:46:18 +0900 (KST)
Received: from kson001 (unknown [10.102.7.58]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230907014618epsmtip10aef9b5c4390bfa27ac9cfea01612cf6~CepI7sSey0225602256epsmtip1p;
        Thu,  7 Sep 2023 01:46:18 +0000 (GMT)
From:   "Kwanghoon Son" <k.son@samsung.com>
To:     "'Philipp Zabel'" <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jszhang@kernel.org>, <guoren@kernel.org>, <wefu@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <inki.dae@samsung.com>
Cc:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
In-Reply-To: <a0894d3dece496f6d2d8bf4e5379794369d48a9e.camel@pengutronix.de>
Subject: RE: [RFC PATCH 0/3] Introduce reset driver for T-HEAD th1520 SoC
Date:   Thu, 7 Sep 2023 10:46:18 +0900
Message-ID: <000701d9e12d$18774d70$4965e850$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGu9iCUenuWNo4+XXoKLIyFFtBzUQIKln6jAmvpzC+wQLeEMA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmgW629s8UgwOH2C22/p7FbrFm7zkm
        i/lHzrFavNjbyGIx6f4EFovmY+vZLPpePGS2uLxrDpvFts8tbBZ3751gsXh5uYfZom0Wv0Xr
        3iPsFi37p7A48Hm8efmSxeNwxxd2j02rOtk87lzbw+axeUm9R/9fA4/3+66yefRtWcXocan5
        OrvH501yAVxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6
        bpk5QPcrKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wM
        DQyMTIEKE7IzLu/ayVhwkaXi1+8/jA2MV5m7GDk5JARMJKbtfMPSxcjFISSwg1Hi5fa5zBDO
        J0aJ2T+WglUJCXxjlPi3UBWmY9LsKWwQRXsZJVau+ABV9JhR4vjcVBCbTUBTYuG534wgtojA
        SiaJHW8zQGxmgVSJo5fnsYHYnAI+Eh0/GsF6hQU8JTaunAsWZxFQkXi/7ixYL6+ApcSX201M
        ELagxMmZT1gg5shLbH87B+oFBYmfT5exQuxyktjw7zUzRI2IxOzONrBvJAQ+cEicuP2cBaLB
        ReLbw61sELawxKvjW9ghbCmJl/1tUHa2xNGPe6FqSiSuz1rECmEbS+xfOhnoIA6gBZoS63fp
        Q4QVJXb+nssIsZdP4t3XHlaQEgkBXomONiEIU17iVmc5RLWoxJmnH9kmMCrNQvLYLCSPzULy
        wCyEXQsYWVYxiqUWFOempxYbFhjBozo5P3cTIzhha5ntYJz09oPeIUYmDsZDjBIczEoivO/k
        v6UI8aYkVlalFuXHF5XmpBYfYjQFBvVEZinR5HxgzsgriTc0sTQwMTMyNrEwNDNUEued87g3
        RUggPbEkNTs1tSC1CKaPiYNTqoHJdzZ/30abHQ9LdYvYOZdEvouf6OW5zLFZ/0kWl/m003IR
        14rfCmjEvnoxWyurfPK9TZe7qvfovbEyM1uv/GRhvGrtL8FnLzK/p/94+WRbhlWVZ5Xv/2PZ
        szPtWFuCJFlZ3A85TVXSuPwoeVbo5xt7Cr408jKutQ0+Ht4QstuxvL022k0mTPSq1n3WybHX
        Tcxq2ZZcnnTW3/qGU9rKpV+1E7cXzWE5lr5tVk5K3f+eyR02zP2iWdHywv9XNU7V3Jy4fEPI
        2+zaFWvZDtwKvP9j7fPAIm1LlwnXpt2dtbRkm1csh8Ldblt93uVt89/4iK9ycizlYfO4YCT+
        8vuKSpWsm5bMOy49Fl/9OuTl0Y1KLMUZiYZazEXFiQBsT+oeYQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7bCSnG6W9s8Ug9uPFS22/p7FbrFm7zkm
        i/lHzrFavNjbyGIx6f4EFovmY+vZLPpePGS2uLxrDpvFts8tbBZ3751gsXh5uYfZom0Wv0Xr
        3iPsFi37p7A48Hm8efmSxeNwxxd2j02rOtk87lzbw+axeUm9R/9fA4/3+66yefRtWcXocan5
        OrvH501yAVxRXDYpqTmZZalF+nYJXBmXd+1kLLjIUvHr9x/GBsarzF2MnBwSAiYSk2ZPYeti
        5OIQEtjNKPG08Q4TREJUouNyI2MXIweQLSxx+HAxSFhI4CGjxL/TIiA2m4CmxMJzvxlBekUE
        tjJJvJ6xFmwos0C6xK3XZ1ghhp5ilHi24RIjSIJTwEei40cjWJGwgKfExpVz2UBsFgEViffr
        zoLV8ApYSny53cQEYQtKnJz5hAViqLZE78NWRghbXmL72zlQHyhI/Hy6jBXEFhFwktjw7zXU
        ESISszvbmCcwCs9CMmoWklGzkIyahaRlASPLKkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT8
        3E2M4AjW0tjBeG/+P71DjEwcjIcYJTiYlUR438l/SxHiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        azhjdoqQQHpiSWp2ampBahFMlomDU6qByXH+qRWtrXqFouV9fZUXNyxMajCZMn2G7Ty1zFKu
        Q9czrixal7Vv7bk7URICmydeOMg2w0S9drK2WdjqHx+K5efdEBDS/f5w6oqJrflTi/y+fWjb
        sHvmjtXN/PsevPSzjcw7tMZky4trH+f5uTDYPG5Pu6IucP7N3Be/TG5qVB8XbXy9dVV3cMC1
        K5+eBFkxu67h3v6983OFw/HtdU8f+b2YvtwwaWrW/l/8C2/EN968FuBw7GKSTzXDQl+TyVt/
        eU8VF/V1mpNTdE3LUfINY8vFz0Lp+97sFo97Pe3vNtEpeRPVaz6Y1iV9sCoqOLhBj53h9AbJ
        b7zTnObpz86s+/C54XV78AwnG7mWRb9jppsosRRnJBpqMRcVJwIAws2zQk8DAAA=
X-CMS-MailID: 20230907014618epcas1p17b3301ecfe2bd09f105e905dfb9123b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904042603epcas1p40f732a0ac7871371126d229945cc0849
References: <CGME20230904042603epcas1p40f732a0ac7871371126d229945cc0849@epcas1p4.samsung.com>
        <20230904042559.2322997-1-k.son@samsung.com>
        <a0894d3dece496f6d2d8bf4e5379794369d48a9e.camel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> what is meant by "initial support"? Are there just more resets than the
> two watchdog resets, or is there other functionality that might require
> describing in the device tree? Is the dt-binding document complete?
> Is this the only reset controller on TH1520? In the thead-kernel.git it
> looks like there are at least two different ones.

True, in vendor kernel has more registers npu, vpsys reset.
But since I can't test other reset so I only added few register (CPU reset)
Also other reset can be added with same driver.

Best regards,
Kwang.

> 
> regards
> Philipp

