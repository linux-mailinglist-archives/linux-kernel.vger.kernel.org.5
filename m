Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94F77D6458
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjJYIAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjJYIAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:00:43 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB65BD44
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:00:39 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231025080036epoutp0109c4a8766cbce106ed02cc8d9cd608cd~RStpUsERT2150121501epoutp01h
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:00:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231025080036epoutp0109c4a8766cbce106ed02cc8d9cd608cd~RStpUsERT2150121501epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698220836;
        bh=qten6g44rcD4Z466ZtreMwvzGHfddBYtd05ynQxp4mo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=osPthvIkfP+xgs0ZpigmTvJWC5wfzIFGKGpK7aNit5r4Yku6Lq8Z69PvplTzlfIo9
         mGgYlIIK/qCy0UnGWkAfbqwwyqvGknGDgp/vyCBHm5rgYXE5px/mQUzGYnVl9eLeiZ
         qZEDQjmrhieBbSyWPJH4m4C7vIe9rbt4HsBYvxdk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231025080035epcas5p17f006a2281ec855c358c806f57b0e7b0~RStowMcCM1243312433epcas5p1r;
        Wed, 25 Oct 2023 08:00:35 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SFhDx44w0z4x9Pq; Wed, 25 Oct
        2023 08:00:33 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.84.09634.12BC8356; Wed, 25 Oct 2023 17:00:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231025080032epcas5p4c29c7c138e81982a2515c11d3db1f698~RStmWATeN2031420314epcas5p4I;
        Wed, 25 Oct 2023 08:00:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231025080032epsmtrp11e7fa50801e55579c4bd431f14b7b71a~RStmT56xQ0672806728epsmtrp1E;
        Wed, 25 Oct 2023 08:00:32 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-b5-6538cb210524
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.57.08817.02BC8356; Wed, 25 Oct 2023 17:00:32 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231025080030epsmtip25175dbe6a227b6c66b4a4ad5797f8170~RStkZ8eDM1654716547epsmtip2B;
        Wed, 25 Oct 2023 08:00:30 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Neil Armstrong'" <neil.armstrong@linaro.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <andersson@kernel.org>,
        "'Konrad Dybcio'" <konrad.dybcio@linaro.org>,
        "'Manivannan Sadhasivam'" <mani@kernel.org>,
        "'Avri Altman'" <avri.altman@wdc.com>,
        "'Bart Van Assche'" <bvanassche@acm.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>
Cc:     <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-ufs-v1-1-a355e3556531@linaro.org>
Subject: RE: [PATCH] dt-bindings: ufs: qcom-ufs: document the SM8560 UFS
 Controller
Date:   Wed, 25 Oct 2023 13:30:29 +0530
Message-ID: <10c701da0719$53fda6c0$fbf8f440$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHnaXdSkn7Ry/Unx4XPRnM1kWnxVwJuJ/amsCvuSOA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmhq7iaYtUg4atshbnHv9msdjWYWPx
        8udVNotpH34yW6zZe47JYv6Rc6wWHZO3s1j0vXjIbDFx/1l2i8u75rBZdF/fwWZx4MMqRov3
        O28xWrTuPcLuwOdx+Yq3x6ZVnWwed67tYfP4vEnOo/1AN1MAa1S2TUZqYkpqkUJqXnJ+SmZe
        uq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QnUoKZYk5pUChgMTiYiV9O5ui/NKS
        VIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Iytv2+wFTQLVbzf/J+1gXEP
        fxcjJ4eEgInEl9tbGbsYuTiEBHYzSnz/NZcdwvnEKLFw4jtmCOcbo8SPkxtZYVq+ndoIldjL
        KDGrdRNUywtGibmfdoBVsQnoSuxY3MYGkhAROMoscfDtEnaQBLNAI6PE6nfmIDanQLjEj/3X
        WUBsYYFQiQ07foHZLAKqEosX72AGsXkFLCWmP4dYzSsgKHFy5hMWiDnaEssWvmaGOElB4ufT
        ZUA1HEDLrCSWLoqAKBGXeHn0CNhxEgJnOCQ2H58JViMh4CJx5hQ0AIQlXh3fwg5hS0m87G9j
        hyjxkFj0RwoinCHxdvl6RgjbXuLAlTksICXMApoS63fpQ2zik+j9/YQJopNXoqNNCKJaVaL5
        3VUWCFtaYmJ3NzQIPSSutm5nn8CoOAvJW7OQvDULyf2zEJYtYGRZxSiZWlCcm55abFpgmJda
        Do/u5PzcTYzgRKzluYPx7oMPeocYmTgYDzFKcDArifBG+likCvGmJFZWpRblxxeV5qQWH2I0
        BYb1RGYp0eR8YC7IK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qB
        qYE9sCtoc4mJyi5VwbN9kxVWrFGd3Ck1VfMld8y8JxUr34YWtq29ytyxQmfVnDUfEnncdNOu
        3nv3yrX21TrWj3MkjF8u0IxbHnZKY/Oq02IffcqubT38e+fOlw9fr7NbJnNQJmL6A6Wrmg9v
        eHzwDt65veXL/HkJiubl6Qu2Xfe07zw3aUH6bLctfy7f3tGw44adxMx6Q/kShjUpHxZx8+95
        2ybQM9/ccsPfYAOvx5lftNzq0/+pi7E+rAvMmnptYbfNYe9XP1KCVM33Xdzn3VBg3afKfG/5
        ohfvdPee0j2nsc/OQrPO7df5zbfO7GxWmx79LGt93v+NZ59xz6zvfqu0tKnng6DAydBpK1Ya
        STQqsRRnJBpqMRcVJwIAYn6QA00EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSvK7CaYtUg+er9SzOPf7NYrGtw8bi
        5c+rbBbTPvxktliz9xyTxfwj51gtOiZvZ7Hoe/GQ2WLi/rPsFpd3zWGz6L6+g83iwIdVjBbv
        d95itGjde4Tdgc/j8hVvj02rOtk87lzbw+bxeZOcR/uBbqYA1igum5TUnMyy1CJ9uwSujPb5
        f1kKLglWfLrwjq2BsZO/i5GTQ0LAROLbqY3MILaQwG5GiZfflSDi0hLXN05gh7CFJVb+ew5k
        cwHVPGOU6LjRyAiSYBPQldixuI0NJCEicJpZ4nvrVkYQh1mglVFixa1eqJYVjBL3p71kAmnh
        FAiX+LH/OksXIweHsECwxIFLmSBhFgFVicWLd4CdwStgKTH9+UZWCFtQ4uTMJywgNrOAtsTT
        m0/h7GULXzNDnKcg8fPpMlaQkSICVhJLF0VAlIhLvDx6hH0Co/AsJJNmIZk0C8mkWUhaFjCy
        rGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI5ILa0djHtWfdA7xMjEwXiIUYKDWUmE
        N9LHIlWINyWxsiq1KD++qDQntfgQozQHi5I477fXvSlCAumJJanZqakFqUUwWSYOTqkGJrbM
        R44/RR5feHUr8bH2ihszFnYemeLF9/b3yeZvdxcFH9e7v0DMaE/LObNP/WcmTOnc9meaxewP
        bStZ/zbeD+yRTowwnx3KESzn2GldMe22lcIVoblSpZPif9yWTJJdUcazzjB9nXz25dtmW3Yy
        GFtEZj04eKw8/cSyFWocryeXrzxYt0n8+IkrC2X+v9/zyy4o3zRg5a7mBW/UJO8V3Nm3aefr
        W5MV58k01CxUWvDIUb1PRtjwvNJPVb8rLpZrg7U2e9pqHWFYJKn78+TVAs97dQd3B010EeWZ
        tSf7ZZK2xz135fOHjd0sXpQ9PXv5m9LR+XHLGBaeS9A/dpfvzfMsZl/jM9mz5u+KfDM5nNlX
        iaU4I9FQi7moOBEAobByujcDAAA=
X-CMS-MailID: 20231025080032epcas5p4c29c7c138e81982a2515c11d3db1f698
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025073056epcas5p3851ec51ba29dd2d8a311ba73c35d24a8
References: <CGME20231025073056epcas5p3851ec51ba29dd2d8a311ba73c35d24a8@epcas5p3.samsung.com>
        <20231025-topic-sm8650-upstream-bindings-ufs-v1-1-a355e3556531@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Neil Armstrong <neil.armstrong=40linaro.org>
> Sent: Wednesday, October 25, 2023 1:01 PM
> To: Andy Gross <agross=40kernel.org>; Bjorn Andersson
> <andersson=40kernel.org>; Konrad Dybcio <konrad.dybcio=40linaro.org>;
> Manivannan Sadhasivam <mani=40kernel.org>; Alim Akhtar
> <alim.akhtar=40samsung.com>; Avri Altman <avri.altman=40wdc.com>; Bart
> Van Assche <bvanassche=40acm.org>; Rob Herring <robh+dt=40kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt=40linaro.org>; Conor Dooley
> <conor+dt=40kernel.org>
> Cc: linux-arm-msm=40vger.kernel.org; linux-scsi=40vger.kernel.org;
> devicetree=40vger.kernel.org; linux-kernel=40vger.kernel.org; Neil Armstr=
ong
> <neil.armstrong=40linaro.org>
> Subject: =5BPATCH=5D dt-bindings: ufs: qcom-ufs: document the SM8560 UFS
> Controller
>=20
> Document the UFS Controller on the SM8650 Platform.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong=40linaro.org>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>

> For convenience, a regularly refreshed linux-next based git tree containi=
ng all
> the SM8650 related work is available at:
> https://protect2.fireeye.com/v1/url?k=3Dd60dc63c-b786d30c-d60c4d73-
> 000babffaa23-1167d5ba7fe13959&q=3D1&e=3Db9d38028-d43f-4463-959d-
> 554468a2f421&u=3Dhttps%3A%2F%2Fgit.codelinaro.org%2Fneil.armstrong%2Fli
> nux%2F-%2Ftree%2Ftopic%2Fsm85650%2Fupstream%2Finteg
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml =7C 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index 462ead5a1cec..0d136c047b8b 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> =40=40 -36,6 +36,7 =40=40 properties:
>            - qcom,sm8350-ufshc
>            - qcom,sm8450-ufshc
>            - qcom,sm8550-ufshc
> +          - qcom,sm8650-ufshc
>        - const: qcom,ufshc
>        - const: jedec,ufs-2.0
>=20
>=20
> ---
> base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
> change-id: 20231016-topic-sm8650-upstream-bindings-ufs-d03cf52d57d5
>=20
> Best regards,
> --
> Neil Armstrong <neil.armstrong=40linaro.org>


