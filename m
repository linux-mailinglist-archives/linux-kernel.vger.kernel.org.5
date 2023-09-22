Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351A37AADB6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjIVJVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIVJVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:21:08 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DF8CE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:21:01 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230922092058epoutp038a2c1059d84c92c544fb1d60fd9582a8~HLhZsWO2V1805118051epoutp03d
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:20:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230922092058epoutp038a2c1059d84c92c544fb1d60fd9582a8~HLhZsWO2V1805118051epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695374458;
        bh=N/E4GBX7zzKYIkwuYXxBrL6bJRdbM6IOCXZ3cSRf6b8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bODdv0rcS+i9gni4GKBPV7tYsgcuRl+MpIF5z6zsN8HKEgYeVpN+bK9Gk19QnJ60C
         VIKonP++rrn1lnQLQqflAneiNNyPQHAKnrq8ZVMfkKoPPleLgTv9CgjGLEZ8wUHMkD
         i62KLNrDS4rWuU07qwtw2+J4JNXDKh+RfXmvyQY0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230922092057epcas2p14cda4f44a306b9d779191c5a5f685319~HLhZI9u6t2197421974epcas2p1m;
        Fri, 22 Sep 2023 09:20:57 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RsRZx4pLLz4x9Q0; Fri, 22 Sep
        2023 09:20:57 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.A4.09765.97C5D056; Fri, 22 Sep 2023 18:20:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230922092057epcas2p15dbc602adc71a42f6faa99677a0168dd~HLhYUP0Up2197421974epcas2p1k;
        Fri, 22 Sep 2023 09:20:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230922092057epsmtrp12631636f96405bbb4bb2857a0cea8f02~HLhYQaQlx0296102961epsmtrp1I;
        Fri, 22 Sep 2023 09:20:57 +0000 (GMT)
X-AuditID: b6c32a48-66ffa70000002625-61-650d5c798dbf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.C0.08742.87C5D056; Fri, 22 Sep 2023 18:20:56 +0900 (KST)
Received: from jtpark-7920 (unknown [10.229.83.56]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230922092056epsmtip12633e7e24efd4a73e2795f0b0f0b65c0~HLhYE8hec3171831718epsmtip1s;
        Fri, 22 Sep 2023 09:20:56 +0000 (GMT)
Date:   Fri, 22 Sep 2023 18:23:46 +0900
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>
Subject: Re: [PATCH 6/7] cxl/memdev: Fix whitespace error/warnings
Message-ID: <ZQ1dIr//9aYNktzI@jtpark-7920>
MIME-Version: 1.0
In-Reply-To: <e14ac1d0-ef8e-74ab-0616-f3203580b371@intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxbVRz19pXXB7PkUb5uWMbIm9NARmkZpZePLmYSbTY1JHNhcSg+2xeK
        lLbpazdYFBlUmCUoji1A+ciWbqCMwahgug4U2VC7gJCxsIAi4UOgsgHBBYkIWPrQ7L9zz++c
        e+7v/u4lMJEbjyBydCbGqKO1FB7A/+ZuNIotyBQyEufGfjQxM4yjkio7QNWXhwH6aew8jm6M
        tQJUfGPCD5XY23G08niLj3oXiwRoYNDjh1qujuLI3l+Dof5uAg3Z7vPRiKseR+OVP/BQx+QS
        /nKQ8rZtQqC03Hvip7R3e3hKR8unuPK7hlaB8rPOFqC8XPex8k9HZDrxdm6qhqHVjDGK0an0
        6hxdtoI6fiLrlSxZokQaK01CcipKR+cxCirt9fTYV3O03i6oqDO01uyl0mmWpeKOpBr1ZhMT
        pdGzJgXFGNRag9wgZuk81qzLFusYU7JUIomXeYXv5WqWp6t4ht8D80fLmCLweI8V+BOQTID/
        eIoEVhBAiEgngPV/b+M7BRG5CmB/81musAbgpcl5nhUQnGM8hON7ACxu/nXXsADgl+6XdjCf
        PAiHyh/5eJyMgdW1RX47OMTLT7bP4DtmjFznw+rRdf5OIZg8Ctvav/aJhF5Dcfkgj8NB0F07
        69P4kwq42bzsM0NymID3i0cE3InS4HaXmmsnGP7xY6eAwxHQ83mpgNOXALg4/5DPLSwAtv3i
        3FUdhktj875kjNTAnvIqjNv0ALw3zufoQHjh7uZulhBeKBVxTgo2Xm/EOAzhg4bOXayE/X8t
        Y9wNPQXw6qU5XiWItD3Tj+2ZNA4fglfurOI2bwRG7oXNWwQHo2G7K+4K8GsBYYyBzctm2HhD
        wv/zVenzHMD3pmOUTlD3ZEXcB3gE6AOQwKgQoWo1gBEJ1XTBOcaozzKatQzbB2Te6XyBRYSq
        9N5PoTNlSROSJAmJiVJ5vEwip8KFv33SoBaR2bSJyWUYA2P8z8cj/COKeMnPG19YCFa8O1E7
        uBzTX2G5eVJWdi5wxNpkv7YHFOa6wmYvfqC9XuuSB3WkpjheFB+pCk95VHi6PjJ29WlLaMmb
        000oX+BxrS05ajfN646UwqX3bR2ixjtl+Q+3bh3r+uqjM5Xkyj42+uxUjdN666YjVCac7pPe
        Dktq6untGhvaaBtwFzyYa+jLPKkqWM0UWQz8wNj4U+K4jKM/q1Iz3tmbpWsgOwHxBtIdqKfP
        V/SG7Auvs86Wbr2lOFxwujv0UHyrZSOxe1y2PSbdb6k/TqyFnHiuzd/OSN1kxdzKxcy11+Tf
        T0U60oILJxc+HKjJXxQPn3J86wFTvZrkmQw7SfFZDS2NwYws/S8VFMFjXAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnG5FDG+qwdP7VhZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmsfjoDGaL
        o3s4LM7POsVicXnXHDaLWxOOMVlsvP+OzUHQY+esu+weLUfesnos3vOSyWPTqk42j/1z17B7
        9G1ZxegxdXa9x+dNcgEcUVw2Kak5mWWpRfp2CVwZb46sYylYylPxdN0D5gbGo5xdjBwcEgIm
        En9uiXQxcnEICexmlNiyZQlzFyMnUFxCYvmGF0wQtrDE/ZYjrBBFzxgllr9byAKSYBFQlTjf
        fZ0NxGYT0JKYPrOBFcQWAYrfX/+YDaSBWeAfi8TEiyvAJgkLOEmsW78ZrIgXqKGp+ywTxNQv
        jBJnW76xQSQEJU7OfAK2gRmo6Ma/l0wgpzILSEss/8cBEuYUsJX4u/w92wRGgVlIOmYh6ZiF
        0LGAkXkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwrGlp7mDcvuqD3iFGJg7GQ4wS
        HMxKIrzJn7hShXhTEiurUovy44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBK
        NTAdKhYuYVfkep3GfnzDs++fXz8xiFv4lzd5W6js9hKD5js2l7Tn3pXSPLTUo3xh3bW6qPsP
        4mZr/Oh9uzJD1+XJJT1Ljhvza68+K2gQKd7runb6yYwzGbHH+O1OTJJI0FS0LFkRUvpwfcea
        tPlPQ9dc1ni3I6rI2+HBqTUWF61bpn3j8EufVPPZ9UZtItuJFAWRia6b7nPvWDB5ar/NvfUB
        1+epJjV/31BtdlY/kj03YcdEW4n29dPcFlzbaXhJfP9dT8uyow/Xbt0X7zVJwMM7f1bjnEM3
        evsMmda7uZ65/a6ny+3Pg0zJFfVCYd90Ra4tEHvzqdnx5+57wktEd3yZMSv4zQS3GvbfZg+N
        Il6FKbEUZyQaajEXFScCAMAkbp8kAwAA
X-CMS-MailID: 20230922092057epcas2p15dbc602adc71a42f6faa99677a0168dd
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----UO.gBI9h3KzXx7fAUzAwhoREi3kPxaIpZHHzoQQrAoo4vDHp=_2351a_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230921024832epcas2p24325cdfdb6fbbcf489ea3d442258e86b
References: <20230921025110.3717583-1-jtp.park@samsung.com>
        <CGME20230921024832epcas2p24325cdfdb6fbbcf489ea3d442258e86b@epcas2p2.samsung.com>
        <20230921025110.3717583-7-jtp.park@samsung.com>
        <e14ac1d0-ef8e-74ab-0616-f3203580b371@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------UO.gBI9h3KzXx7fAUzAwhoREi3kPxaIpZHHzoQQrAoo4vDHp=_2351a_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Sep 21, 2023 at 03:57:25PM -0700, Dave Jiang wrote:
> 
> 
> On 9/20/23 19:51, Jeongtae Park wrote:
> > ERROR: code indent should use tabs where possible
> > WARNING: please, no spaces at the start of a line
> > 
> > Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
> 
> two different issues?
> 

Yes, they are. I will seperate and resend them.

> > ---
> >  drivers/cxl/core/memdev.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index f99e7ec3cc40..ce67df163452 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -935,11 +935,11 @@ static void cxl_fw_cancel(struct fw_upload *fwl)
> >  }
> >  
> >  static const struct fw_upload_ops cxl_memdev_fw_ops = {
> > -        .prepare = cxl_fw_prepare,
> > -        .write = cxl_fw_write,
> > -        .poll_complete = cxl_fw_poll_complete,
> > -        .cancel = cxl_fw_cancel,
> > -        .cleanup = cxl_fw_cleanup,
> > +	.prepare = cxl_fw_prepare,
> > +	.write = cxl_fw_write,
> > +	.poll_complete = cxl_fw_poll_complete,
> > +	.cancel = cxl_fw_cancel,
> > +	.cleanup = cxl_fw_cleanup,
> >  };
> >  
> >  static void devm_cxl_remove_fw_upload(void *fwl)
> > @@ -1010,7 +1010,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> >  	}
> >  
> >  	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> > - }
> > +}
> >  
> >  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> >  {

------UO.gBI9h3KzXx7fAUzAwhoREi3kPxaIpZHHzoQQrAoo4vDHp=_2351a_
Content-Type: text/plain; charset="utf-8"


------UO.gBI9h3KzXx7fAUzAwhoREi3kPxaIpZHHzoQQrAoo4vDHp=_2351a_--
