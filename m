Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2881379C450
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbjILDmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbjILDlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:41:46 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7221C619F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 20:16:26 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230912031624epoutp03f151056b12c6f73eee69c3911e1a9f20~ECGO32fma0418904189epoutp03j
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:16:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230912031624epoutp03f151056b12c6f73eee69c3911e1a9f20~ECGO32fma0418904189epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694488584;
        bh=9b0yhQrPPQVw5SprxIcEQjOCPQMMOk7ZjyyovN9CkDg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ua2iik7FHfnrti/BJaA/4MLf707HNCgXbZrN+W3Ea+5U5lofUiH1Nu+BDZ3bH+HRQ
         aAgSIZwEf5rLYaW+8+GQwynmrJOKP2ma/pqSGh1/I2WcfM5isXXo2wHd9e47qA4smj
         8yNxXpQcaTdn5xT3M0JZ0wPzZVemRw/mog/FgWjg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230912031623epcas1p11d9a8bd5d6d295ace398b240033b9838~ECGOUplos1017710177epcas1p16;
        Tue, 12 Sep 2023 03:16:23 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.233]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Rl7yt4N3bz4x9Px; Tue, 12 Sep
        2023 03:16:22 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.1D.09646.608DFF46; Tue, 12 Sep 2023 12:16:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230912031622epcas1p2a63f76c73d1aa7ead6aaab9c0b639ba5~ECGM6bpeb1704717047epcas1p26;
        Tue, 12 Sep 2023 03:16:22 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230912031622epsmtrp27a64abc0bda6542474a785b540d6a4ba~ECGM5mbEA0271202712epsmtrp2L;
        Tue, 12 Sep 2023 03:16:22 +0000 (GMT)
X-AuditID: b6c32a37-d85fa700000025ae-39-64ffd806b869
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.3E.18916.508DFF46; Tue, 12 Sep 2023 12:16:21 +0900 (KST)
Received: from kson001 (unknown [10.102.7.58]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230912031621epsmtip26d172f24e74ac9813cc894d291c21724~ECGMoQQM_0868108681epsmtip2E;
        Tue, 12 Sep 2023 03:16:21 +0000 (GMT)
From:   "Kwanghoon Son" <k.son@samsung.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jszhang@kernel.org>, <guoren@kernel.org>, <wefu@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <inki.dae@samsung.com>
Cc:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
In-Reply-To: <20230912024914.3769440-1-k.son@samsung.com>
Subject: RE: [PATCH 0/3] Introduce reset driver for T-HEAD th1520 SoC
Date:   Tue, 12 Sep 2023 12:16:21 +0900
Message-ID: <00b201d9e527$813b9070$83b2b150$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJRGlJLVam+TPMVK9gUOhne1mZ+8QFARGg6rx4WsDA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmvi7bjf8pBnffyFls/T2L3WLN3nNM
        FvOPnGO1eLG3kcVi0v0JLBbNx9azWfS9eMhscXnXHDaLbZ9b2Czu3jvBYvHycg+zRdssfovW
        vUfYLVr2T2Fx4PN48/Ili8fhji/sHptWdbJ53Lm2h81j85J6j/6/Bh7v911l8+jbsorR41Lz
        dXaPz5vkAriism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ0
        3TJzgO5XUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFugVJ+YWl+al6+WlllgZ
        GhgYmQIVJmRnrHq4krVgJmPFlD2P2BoYy7sYOTkkBEwk1nSvZO9i5OIQEtjBKPHscAuU84lR
        Yv7Gl2wgVWDOy7O5MB3fj3awQhTtZJRYMO84I4TzmFHi/eLvjCBVbAKaEgvP/QZLiAhMZ5KY
        PPc52ChmgVSJo5fngdmcApYSc6d0gzUIC7hKTPg5mxnEZhFQlbg65RsriM0LVDP97212CFtQ
        4uTMJywQc+Qltr+dwwxxkoLEz6fLWCHiIhKzO9vA4iICVhK3Dl9hhKh5wCHRM9MGwnaRmHXi
        BguELSzx6vgWdghbSuLzu71sEHa2xNGPMHaJxPVZi1ghbGOJ/UsnM3UxcgDt0pRYv0sfIqwo
        sfP3XEaIE/gk3n3tYQUpkRDglehoE4Iw5SVudUJDXVTizNOPbBMYlWYh+WsWkr9mIfllFsKu
        BYwsqxjFUguKc9NTiw0LjOFRnZyfu4kRnLC1zHcwTnv7Qe8QIxMH4yFGCQ5mJRHekkN/U4R4
        UxIrq1KL8uOLSnNSiw8xmgJDeiKzlGhyPjBn5JXEG5pYGpiYGRmbWBiaGSqJ89561psiJJCe
        WJKanZpakFoE08fEwSnVwMSfX2v8u8iGUZLdiuW4qdXt8KN+y4K/dhZyJ6xoerPBa2Lur7n+
        6gfbF5fMCzRYKl0R37lG49ILt9bG0wLBa1tXH1TPceQUuvrk9OMbcqpnGe9nHT+uJZwqX/Jt
        79rfp59nHtJqfvzD/tMsqye/edPmqHEK+XZcX9b9xsxujomD6FNOITZ1mYWG1353Wd95E9nR
        Y7m3P3rf1J8+U8tepsnKPOw4Vq/KNXPSMekrwUWXrzIe5u7b53MiTGh9j/ILr7R7qsWygSeu
        xJ39fK9j8+a1md/UdwsfS4ua2qO2Zy+HfPIjD9PZDT5TJtptNpg7a0PTlx3zVl/b/HCOq+kU
        eQ+1njvvXi7RfVjztivZwEuJpTgj0VCLuag4EQD1aQ1jYQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvC7bjf8pBlvkLbb+nsVusWbvOSaL
        +UfOsVq82NvIYjHp/gQWi+Zj69ks+l48ZLa4vGsOm8W2zy1sFnfvnWCxeHm5h9mibRa/Reve
        I+wWLfunsDjwebx5+ZLF43DHF3aPTas62TzuXNvD5rF5Sb1H/18Dj/f7rrJ59G1Zxehxqfk6
        u8fnTXIBXFFcNimpOZllqUX6dglcGasermQtmMlYMWXPI7YGxvIuRk4OCQETie9HO1i7GLk4
        hAS2M0rMXPyBDSIhKtFxuZGxi5EDyBaWOHy4GKLmIaPE2jVfwGrYBDQlFp77zQiSEBFYzCRx
        pncDK0iCWSBd4tbrM1BTuxglrh6bwgiS4BSwlJg7pRvMFhZwlZjwczYziM0ioCpxdco3sGZe
        oJrpf2+zQ9iCEidnPmEBuYJZQE+ibSMjxHx5ie1v5zBDHKog8fPpMqi9IhKzO9vA4iICVhK3
        Dl9hnMAoPAvJpFkIk2YhmTQLSfcCRpZVjKKpBcW56bnJBYZ6xYm5xaV56XrJ+bmbGMExqxW0
        g3HZ+r96hxiZOBgPMUpwMCuJ8JYc+psixJuSWFmVWpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9
        sSQ1OzW1ILUIJsvEwSnVwOSglrNdprvSZEfhkZymNqa4xD7/wPlWqgZlnL/mBO7UUJnX8OLj
        kUtu+tVWf602ZP7KDhB+pXVqnRhPiI1ieDj/xKf/hWJ+L10k9Cr0lu37XUuuZSduCDcJK7Jz
        NuSQ6G3P2naMc+PJ4zGqglrJPLlb5S/NDDywUe+y6+PDEx47S97uWrrUZknHY5OFwi1GicoT
        bi932mX5WbiRab9g7xKlw5ah0RcT2g/yHLksIhAQEurwdP22HokTLoJawrWR0T9MpCMVD3Ol
        33ilp95aEO9xsGChkfy0LZ8VqvI1dldvZPN5VB72PVn4RTNze8hm5Rrjfr0Arsttn+d51/+R
        yJl14HzazSVrvDUvXmlXYinOSDTUYi4qTgQAlIa1I0gDAAA=
X-CMS-MailID: 20230912031622epcas1p2a63f76c73d1aa7ead6aaab9c0b639ba5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230912024917epcas1p29a513dcf6019fb7c63275aa0e39b1c71
References: <CGME20230912024917epcas1p29a513dcf6019fb7c63275aa0e39b1c71@epcas1p2.samsung.com>
        <20230912024914.3769440-1-k.son@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kwanghoon Son <k.son@samsung.com>
> 
Oops, my mail config has from option.
Sorry, I will fix in next version after get feedback.

Kwang.

