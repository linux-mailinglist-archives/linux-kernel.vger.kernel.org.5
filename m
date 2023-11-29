Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3637FE7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjK3Dfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3Dfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:35:50 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160071B4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 19:35:55 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231130033548epoutp03ac2a06eb413b440b48429ab6beb5f02e~cSUu9lLMU3074830748epoutp03t
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:35:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231130033548epoutp03ac2a06eb413b440b48429ab6beb5f02e~cSUu9lLMU3074830748epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701315348;
        bh=/WaH6IK/Rfh6jZJ/G83i6v0SV3kGzQkyWCRANtlqumo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WK3PKD1BItYWEZ9tb3goSwLB/aAEd68CWvqMkPiUe6/jOGqx6JxLkNxZsbTcdvjYM
         iNxq/yznUP3ipWavOp1prGTbSbkskMrveRDwWOzg/n6PzQNvM6zQguWFiPtubh34/d
         wbkUcHBxRgjRDZ13F06Cng9pJ60Oh7hDX1ggE0wA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231130033548epcas5p18300b72735a92bf19048b3756f643cf0~cSUuMUTBk0076600766epcas5p1z;
        Thu, 30 Nov 2023 03:35:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Sghfp5Z1Jz4x9Q0; Thu, 30 Nov
        2023 03:35:46 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.B5.09634.21308656; Thu, 30 Nov 2023 12:35:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231129160110epcas5p4913da50d344becbe1fde0c076d1e1c3d~cI2O8sIA51449514495epcas5p4y;
        Wed, 29 Nov 2023 16:01:10 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231129160110epsmtrp22fa9234405d24364f4660074cf38c6bc~cI2O72s1D2435724357epsmtrp2K;
        Wed, 29 Nov 2023 16:01:10 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-33-65680312b377
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.7A.18939.64067656; Thu, 30 Nov 2023 01:01:10 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231129160108epsmtip15276ccd6c632ab09a58b12fdc7bba6fe~cI2NPSQPe2199321993epsmtip1c;
        Wed, 29 Nov 2023 16:01:08 +0000 (GMT)
Date:   Wed, 29 Nov 2023 21:24:51 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
        gost.dev@samsung.com, nitheshshetty@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: prevent potential spectre v1 gadget
Message-ID: <20231129155451.ropb4udx6w4xmytb@green245>
MIME-Version: 1.0
In-Reply-To: <b94b300b-8c09-4246-bd98-95f7b4291c49@suswa.mountain>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJsWRmVeSWpSXmKPExsWy7bCmlq4Qc0aqwZ0DQhar7/azWXyY18pu
        8WiZn8XNAzuZLFauPspksXvhRyaLSYeuMVo8vTqLyeLyrjlsFvOXPWW32PGkkdFi3ev3LA48
        HrPun2Xz2DnrLrvH+XsbWTwuny312LSqk83jzrU9bB6bl9R77L7ZwObR2/yOzaNvyypGj8+b
        5AK4o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BO
        V1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkC
        FSZkZ/Tski44y1HxaP4t5gbGnexdjJwcEgImEnN2/WDqYuTiEBLYzSix6/hCNgjnE6PE558n
        mOGctgnr4FpWr2hgh0jsZJRY8/8VlPOMUaJpfzMbSBWLgKrExhP3gBIcHGwC2hKn/3OAhEUE
        dCT+/Z3MAlLPLHCDSWL/mR+sIAlhASeJe09fMIHYvAJmEku3HGKFsAUlTs58wgIyhxOo5sHk
        dJCwqICMxIylX8GukxA4wCGxb+ZONojrXCQarh+HsoUlXh3fAnW1lMTnd3uh4uUSK6esYINo
        bmGUmHV9FiNEwl6i9VQ/M4jNLJAhsXLyIai4rMTUU+uYIOJ8Er2/nzBBxHkldsyDsZUl1qxf
        ALVAUuLa90Yo20Oi6/8laKB+ZZS4vq6dfQKj/Cwkz81Csg/CtpLo/NDEOgvoaWYBaYnl/zgg
        TE2J9bv0FzCyrmKUTC0ozk1PLTYtMMxLLYfHeHJ+7iZGcNLW8tzBePfBB71DjEwcjIcYJTiY
        lUR4rz9NTxXiTUmsrEotyo8vKs1JLT7EaAqMrInMUqLJ+cC8kVcSb2hiaWBiZmZmYmlsZqgk
        zvu6dW6KkEB6YklqdmpqQWoRTB8TB6dUA1O16oOzL5d5dMgwlMb05m1e6KYcn/+Cc9tOa67f
        O4p6rJa88Hd/arFcdMbZ3TKnXvLo8z7jFOlJ3zC3nmE2l2Nq1pbETzNudFkUTFd0bQ2vjru+
        4rL2QhtRvqDmRzdDJad9/pShxTzT6zVbx4ddFzc+C9585MV3FRufT+WPN1w4t1Bv9gOzF1sP
        2fXsORiVG+ZeaO5ePufA5WtCLBx/p2bbeNqa/Hq3SfnUhJwI/p3uYV3N3MLGWpIGi4NPt7UG
        RAgKTf6S+OjRgms/Wf19br88+saq5Sr/o5DIoxcSbXWk88123FnCpbcqppH/gahN0C3Howa/
        6xzun+t9I7+6elbz1WsHy6TLGYTeL9zI2aLEUpyRaKjFXFScCABT7UiDYwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTtctIT3VoKlNzGL13X42iw/zWtkt
        Hi3zs7h5YCeTxcrVR5ksdi/8yGQx6dA1RounV2cxWVzeNYfNYv6yp+wWO540Mlqse/2exYHH
        Y9b9s2weO2fdZfc4f28ji8fls6Uem1Z1snncubaHzWPzknqP3Tcb2Dx6m9+xefRtWcXo8XmT
        XAB3FJdNSmpOZllqkb5dAlfG76N/2Qr+s1Zs/LuBuYGxlbWLkZNDQsBEYvWKBvYuRi4OIYHt
        jBJT1y2BSkhKLPt7hBnCFpZY+e85VNETRolfG68zgSRYBFQlNp64B5Tg4GAT0JY4/Z8DJCwi
        oCPx7+9kFhCbWeAWk8TcJ2ogtrCAk8S9py/AWnkFzCSWbjnECjHzK6PE+od7GCESghInZz6B
        ajaTmLf5ITPIfGYBaYnl/zhATE6gOQ8mp4NUiArISMxY+pV5AqPgLCTNs5A0z0JoXsDIvIpR
        NLWgODc9N7nAUK84Mbe4NC9dLzk/dxMjOMK0gnYwLlv/V+8QIxMH4yFGCQ5mJRFevY/JqUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5lXM6U4QE0hNLUrNTUwtSi2CyTBycUg1MoZeeNmnWpvdH
        vl7I25C+wdD3Ro/6XcdZJzrCguNYsoNcvu/+z8yq3nNRrE/ZhPmKhJd2WtonF+fXi7tCoz5e
        5HI/7Vkt78tvqNxo3O6stTjDOrHsVUJGj78QT0XS8qev7klG/K8qtHZTOnHRXsY8KKnmaJeC
        zOsbu3x3M7EvX+JbzvjuWnlNSbfpo7RXcxL1Imw1ml+5lCzT2N98+qnQ27ve22d+0twxIUr/
        yPPDTjM3ftW1Sjtz9o5h3QMGH79FPEK6/Dv9u//NXygvbTLr5+x/SZnezLUTlWOXuXzRMj5+
        6VfNqY9Rtd+f++/bsJBV6IOJk+wJt54Lz9fYPti6IPPJV4mKfwaV5kdmGimxFGckGmoxFxUn
        AgCMvymGHwMAAA==
X-CMS-MailID: 20231129160110epcas5p4913da50d344becbe1fde0c076d1e1c3d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----E2FLEX3VNKXZtTxXMF9-IQsaSIEoxQsaU5Vw1-qQHlNadj4Z=_1b44d_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6
References: <20231128122958.2235-1-nj.shetty@samsung.com>
        <CGME20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6@epcas5p2.samsung.com>
        <20231128122958.2235-2-nj.shetty@samsung.com>
        <b94b300b-8c09-4246-bd98-95f7b4291c49@suswa.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------E2FLEX3VNKXZtTxXMF9-IQsaSIEoxQsaU5Vw1-qQHlNadj4Z=_1b44d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 29/11/23 12:27PM, Dan Carpenter wrote:
>On Tue, Nov 28, 2023 at 05:59:57PM +0530, Nitesh Shetty wrote:
>> This patch fixes the smatch warning, "nvmet_ns_ana_grpid_store() warn:
>> potential spectre issue 'nvmet_ana_group_enabled' [w] (local cap)"
>> Prevent the contents of kernel memory from being leaked to  user space
>> via speculative execution by using array_index_nospec.
>>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>
>When it comes to adding array_index_nospec(), then I don't know enough
>about it to comment.
>
Upon smatch's warning, I referred to kernel documentation[1].
Using array_index_nospec should avoid memory leak.

Thank you,
Nitesh Shetty

[1] https://www.kernel.org/doc/Documentation/speculation.txt

------E2FLEX3VNKXZtTxXMF9-IQsaSIEoxQsaU5Vw1-qQHlNadj4Z=_1b44d_
Content-Type: text/plain; charset="utf-8"


------E2FLEX3VNKXZtTxXMF9-IQsaSIEoxQsaU5Vw1-qQHlNadj4Z=_1b44d_--
