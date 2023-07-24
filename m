Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D49A75F9F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGXOdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGXOda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:33:30 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4AA12C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:33:24 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230724143322epoutp01820d34f05597e30242a7a312020fd561~01FCFAptb1174511745epoutp01P
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:33:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230724143322epoutp01820d34f05597e30242a7a312020fd561~01FCFAptb1174511745epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690209202;
        bh=2lbXG54zL1G8BlZYG/zy39SDXTgugu4KVifoDcPDB0s=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=EgsT2B3zHiOUKOmkwRyYN7pBLC2tlPfezi/2jz9Vvm98a4o0kXFVw8qI0w4EIV3kf
         evtLGLNPRUDACtB2lk+R722GCMRwP2uNzMDlkmtoXzZ8BoGKUHacYHbgZGaINvF/A0
         ymLvsE6TLBJVz/O+QrbHGAUYOmSzuDAf3kIqQkx8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230724143321epcas5p2f0468b310ac42bddc2f0425049a18eff~01FBmEqUA2906029060epcas5p2P;
        Mon, 24 Jul 2023 14:33:21 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4R8jM34c2vz4x9Q1; Mon, 24 Jul
        2023 14:33:19 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.A9.57354.FAB8EB46; Mon, 24 Jul 2023 23:33:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230724143319epcas5p45943b6438993193a457c7e3750d5407a~01E__51sB0398903989epcas5p49;
        Mon, 24 Jul 2023 14:33:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230724143319epsmtrp1c8e00b315bc428a088a576ba71a3fd34~01E_95vVN3018030180epsmtrp1M;
        Mon, 24 Jul 2023 14:33:19 +0000 (GMT)
X-AuditID: b6c32a44-269fb7000001e00a-7b-64be8baf6f8f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.D2.30535.EAB8EB46; Mon, 24 Jul 2023 23:33:18 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230724143315epsmtip10ab7ae65819b6fa5ffaabf4fd2de38b7~01E7a3F8l2217022170epsmtip1R;
        Mon, 24 Jul 2023 14:33:15 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <andersson@kernel.org>,
        "'Konrad Dybcio'" <konrad.dybcio@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "'Jonathan Corbet'" <corbet@lwn.net>,
        "'Arnd Bergmann'" <arnd@arndb.de>,
        "'Olof Johansson'" <olof@lixom.net>, <soc@kernel.org>,
        <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <arm@kernel.org>
In-Reply-To: <20230723131924.78190-3-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH v3 3/3] MAINTAINER: samsung: document dtbs_check
 requirement for Samsung
Date:   Mon, 24 Jul 2023 20:03:13 +0530
Message-ID: <18dd01d9be3b$ca143490$5e3c9db0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJVkvW7fnRp8t18XMiZ0n2xtNvXyAL8zzyAAox4cNyupQckgA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbVRjOaW9vC1p3V6ocuujKzYjSBGg3qLcG1CjRjs3YBD+iznV37Q0l
        9Mu2wNQfIggrVIawgEpg3QYZpC7WtYxuY2UIZa6QlYxvCRjKhxtDPgKbzgHGtndT/j3v+z7v
        ed7nPedwmLxJVMDJ1Vsok57U4mg00t6TmJjktHWqxY6VeCIwu4EQ7dZ04vq9NpTYqrnOJs57
        Awxirus4IOy+AIuwnvQgxIk7QSbhXbzIJlyzoyyi+tpNNnGmrBkhhq40oMR3A50Mom9sHSVK
        vT42MTu2iRL3L28xXo2RbzysAXKXoxyVT45eReXu5i/kwzeKWfKmEydZ8nXXcwr2h3npGopU
        UyYhpVcZ1Ln6nAz8QLbydWWaVCxJksiIF3GhntRRGXjmQUXSG7nakBVcWEBq80MpBWk24ykv
        p5sM+RZKqDGYLRk4ZVRrjanGZDOpM+frc5L1lOUliVi8Ny1EPJKnqfHwjX07jv3QdAopAg5u
        BeBwIJYKK7YSKkA0h4d1ALji2AB0sAZgoPk3hA7+BNDnr0IrQFSko8f/kE0XvABu3H3AooMF
        AIuddlaYhWJJ8FJTGRou8LFbLDjtsqFhwSgsE676lWFODHYYlteVssMYwRLgZXtJBHMxGfxj
        7VeExjuh//u5CGZiu6FnqYFJTyGEf8+fY9H5WLjQ64v08rHX4IytP6ILsVUOnJ/peDR2Juyb
        rmPTOAbe/aXtERbAhaoyNr0MOTy7KaDTGrjU4gQ0fgV2DTcgYQoTS4TOKym07FOwcmOOQXdy
        obWMR7MTYMnyCELjXbDaZmM9Pnyqzkhv6haAPdZx9BsgrN9msn6byfptxur/Fz4NEAeIo4xm
        XQ6lSjNK9FThf7etMuhcIPLMRZmXwLj9n+RuwOCAbgA5TJzPlRzqVPO4avLTzyiTQWnK11Lm
        bpAW2nw1U/C0yhD6J3qLUpIqE6dKpdJU2T6pBI/lLpY2qnlYDmmh8ijKSJke9zE4UYIiBmtu
        eb57qngn7/TqYNdZbWFRp/uZSfKOWzD0wW3v/H77PuMn8Rewod+PjwU28efXd/F8iQ8c355b
        K5cWrIw6D2S3Z54PvulNafFNF+g+T74/PjAgri3E354RZfUoLryjOvXk0k9fZ/cGRc2VfHJF
        NdVWM+Gq9Phyexm+ldyfrbulyPtBmeJosnS86Ks9ngTnjht1I+uBtxqDI/5haqKQW5X3kXtw
        9r3l1kYwUnuvPkZjiIstn5zpT6t94XaVszfbt/fo4LWJm3wGlXH4YnyZSz4RXZVSd5Uhiut4
        4qCypfXjEuzQj19W98dmdbVv/lW8p9/tYe8/cmzJzn/32axF45lWHDFrSImIaTKT/wIULqAS
        bwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSnO667n0pBsvWWVmce/ybxWJbh43F
        sS9b2Cz+TjrGbrFm7zkmiycH2hkt5h85x2rRMXk7i0Xfi4fMFntfb2W32PT4GqvFxP1n2S0W
        ti1hsbi8aw6bxYzz+5gsTl3/zGbRuvcIu8Xj63/YLL7u/MvkIOzx+9ckRo9NqzrZPO5c28Pm
        sXlJvceVE02sHov7JrN6fN4kF8AexWWTkpqTWZZapG+XwJUxabtIwSn+itWL57E0MK7i7WLk
        5JAQMJE4fPIXexcjF4eQwG5GiTk7GlghEtIS1zdOYIewhSVW/nsOVfScUeLXz9lMIAk2AV2J
        HYvb2EASIgIPWSU+3prHAlF1llHi2OzNQKM4ODgFXCQ+nIwHaRAWiJE4+HEBG4jNIqAqsXN+
        M9gGXgFLiTefbrJA2IISJ2c+YQFpZRbQk2jbyAgSZhaQl9j+dg4zxEEKEj+fLmOFiItLvDx6
        BGyMiICTxKPu02wTGIVmIZk0C2HSLCSTZiHpXsDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQv
        XS85P3cTIzh2tbR2MO5Z9UHvECMTB+MhRgkOZiURXsOYfSlCvCmJlVWpRfnxRaU5qcWHGKU5
        WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1MBn0lJ4+rlFz67LC0d2P/N9VZQmsMjsyyb64
        c/3UbrEi96tzl+yJY9QpLv/a+Ha1frFR+5nEnUk+3D8+T9AN3O1UW397xZSgf8FNoiq/tCaW
        J98xueTIEfm0S1drmXLf+lknLCQY1EpW3mINUnXnm3ok/bfegsikf1Fz357x1XM/5HdXJ7uO
        Va7BeHbJNPM2CcdlYXnyG2Jbcr8Yh9g7GRRGGJ9YtyP1xLyjTOWettfOZfI833vn7ZzI0LLJ
        ZrkfXxVGTaplmNDwPeQZz+PybbxXt7x1eVN9sOhT1teLXat3WB5QNJ+2bPeyBxVP/W83LtBc
        7RDHeOKZRvCxr1oJLhOyLDJCG3sF5zIkKr94qsRSnJFoqMVcVJwIAMDkWeBMAwAA
X-CMS-MailID: 20230724143319epcas5p45943b6438993193a457c7e3750d5407a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230723131941epcas5p17cc35fcb68cb748ed1dbd00bf609540f
References: <20230723131924.78190-1-krzysztof.kozlowski@linaro.org>
        <CGME20230723131941epcas5p17cc35fcb68cb748ed1dbd00bf609540f@epcas5p1.samsung.com>
        <20230723131924.78190-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Sunday, July 23, 2023 6:49 PM
> To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Alim Akhtar <alim.akhtar@samsung.com>; Andy Gross <agross@kernel.org>;
> Bjorn Andersson <andersson@kernel.org>; Konrad Dybcio
> <konrad.dybcio@linaro.org>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-msm@vger.kernel.org; Jonathan Corbet
> <corbet@lwn.net>; Arnd Bergmann <arnd@arndb.de>; Olof Johansson
> <olof@lixom.net>; soc@kernel.org; workflows@vger.kernel.org; linux-
> doc@vger.kernel.org; arm@kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH v3 3/3] MAINTAINER: samsung: document dtbs_check
> requirement for Samsung
> 
> Samsung ARM/ARM64 SoCs (including legacy S3C64xx and S5PV210) are also
> expected not to bring any new dtbs_check warnings.  In fact this have been
> already enforced and tested since few release.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> ---
> 
> Changes in v3:
> 1. None
> 
> Changes in v2:
> 1. None
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9fe3870300f2..4b299e39111d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2646,6 +2646,7 @@ R:	Alim Akhtar <alim.akhtar@samsung.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-samsung-soc@vger.kernel.org
>  S:	Maintained
> +P:	Documentation/process/maintainer-soc-clean-dts.rst
>  Q:	https://patchwork.kernel.org/project/linux-samsung-soc/list/
>  B:	mailto:linux-samsung-soc@vger.kernel.org
>  C:	irc://irc.libera.chat/linux-exynos
> --
> 2.34.1


