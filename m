Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A587B7AE4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241864AbjJDI6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbjJDI6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:58:09 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EC498
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:58:05 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231004085802epoutp0420292af51fd6fa8e36e9b9ddc133fcc3~K28zbTsyy1402514025epoutp046
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:58:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231004085802epoutp0420292af51fd6fa8e36e9b9ddc133fcc3~K28zbTsyy1402514025epoutp046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696409882;
        bh=PnexwO17P7mZdYz62S6iNLFHUko7AzJywD1aqF6b4xg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uy4hOlDaCby6FaUoIihezki+mOQvr9fkJ20hSKrqClW3CQ/0QCeIHhpCoHvtRcOIg
         SHs3ATi4/a1TJIE9ZDN/UO9tp/6vk7iaqxByB+yN8p5NSAP6Onh89xdYSnVgVVHK7z
         op4QEAgM6fU0KXNPsYiAcxzj0PkZHhS4lRbFKl6E=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231004085801epcas2p21b957a43f957aee47e0f99b36607aa2d~K28yzFz9A0082800828epcas2p2e;
        Wed,  4 Oct 2023 08:58:01 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4S0pVx2Vdtz4x9Q0; Wed,  4 Oct
        2023 08:58:01 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.1E.09649.9192D156; Wed,  4 Oct 2023 17:58:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231004085800epcas2p48c4109cb15c80c3075744946d8619b5d~K28xwrhav2638826388epcas2p45;
        Wed,  4 Oct 2023 08:58:00 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231004085800epsmtrp10b05eaf25f32b9a7bf61a0923ed0533b~K28xvqpaT3168631686epsmtrp1_;
        Wed,  4 Oct 2023 08:58:00 +0000 (GMT)
X-AuditID: b6c32a46-b9ffa700000025b1-bc-651d2919736c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.19.18916.8192D156; Wed,  4 Oct 2023 17:58:00 +0900 (KST)
Received: from jtpark-7920 (unknown [10.229.83.56]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231004085800epsmtip17d28a07b4b7a3a789a99b315ee5eca2f~K28xisCQy2725527255epsmtip1d;
        Wed,  4 Oct 2023 08:58:00 +0000 (GMT)
Date:   Wed, 4 Oct 2023 18:00:55 +0900
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>
Subject: Re: [PATCH v2 7/7] cxl/memdev: Fix a whitespace warning
Message-ID: <ZR0px9AZD2IZ7Mgl@jtpark-7920>
MIME-Version: 1.0
In-Reply-To: <zj4pigcxmpycmqqrfym7hhvc7s3gk5juhkziehvyjduydlt226@bke4pkczaxyt>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc/t+9EHS8UTZrgwNebAsZQPbjsITwZDISDMWBjEh0bGwSh8t
        ob/W1/pzG91gBJRNyEC02gaGoBTECNiUH8uwBSsDFVAYP8Y2mFKQYZxzmoGQtbQa//vcc7/f
        c869514CCR7EQ4l8tZ7RqaVKCg9EbU6+OHorfxsjsN0Komf+HMbpou/rAV1TPQzoG5Nf4XTz
        ZAugv26eweii+ss4/eivdZTuXTJy6aGbixhtrRvH6fr+0wjd30PQt00/o/SdrnM4PVVxnUNf
        +f0hnrxJ0mma4UqK+5YxSX3PIkfSZi3DJT+ZW7iS7zqsQFJ9tlDyT9v2DGJ/QaKCkcoYXTij
        ztXI8tXyJCptb86eHHGcQBgt3EnHU+FqqYpJolI+zIhOzVd6TkGFH5QqDZ5QhpRlqR27E3Ua
        g54JV2hYfRLFaGVKbbw2hpWqWINaHqNm9AlCgUAk9gg/LVBUN17jaqsDD98fFxmBkzgOAghI
        xsKy1Ur0OAgkgkk7gCU3uzHf4jGAQ0P/Ii8XK5PF4IXliaud69voBNA83+S3LAD4w2o56lWh
        ZCT8b3me42WcjII1Z4yYl7eQb0PLpWngNSDkUxTaqqY9NQhiM5kMXaN6L/I8+t6VSK+cR26C
        A2fubaQMINNh75Jto1dI3iDgxRODmK+jFPiHbYLr483wgavDz6Fw8WQJ12coAnDJfdfvLgaw
        ddruV70HH066NzIhpAKeO1XD9XYByQjYN4X6wq/BUueaP8yDpSXBPicFLQ0WxMcQjpo7/CyB
        Ix1u/w3dAfBaaRm3Amw3vXIg0yvVfPwurO1+jJs8JRDyTXhhnfAhH17u2lELMCt4ndGyKjnD
        irSilxPO1ajawMarjkq1g6rlRzEOwCGAA0ACobbw5MYwJpgnkx45yug0OTqDkmEdQOwZTiUS
        GpKr8XwLtT5HGLtTEBsXJ4wXiQXx1Bu8374xy4JJuVTPFDCMltG98HGIgFAj54vDs9FNJfaD
        uwe2zbMx+/kHnljfkn373PUsK3Ji1weurLLnsri4+LQmfcj1TPPC+WO/hgzHfnaiMdxytnD2
        UpvcmvLlgaB9ptCE1b1Y1pxQ1iKoTLCtH3IOHnWTfaeE6WNX7L8Y2tfGpg61rt7btYJxkpHT
        F8IWEt9pkM+WW3orgtDMRkNvtqL5alonbw8bze+ve5AdcUTgan8/vUefCaYdt9onuiO6up7l
        TTcN1H287xhZ7jCOFPUPuefH/6axcRZVrKDnO69mNi19ft8RxjQUVBa3ivg/2ufGPtqKfpJl
        vz1ysWo0QhVSOKXqyF47+bS8Nm95DmsR3w0acy6k5lEoq5AKoxAdK/0fMS12FF4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTldCUzbVoPmBhsXdxxfYLJonL2a0
        mD71AqPFiZuNbBarb65htGhafZfVonnxejaLD2/+sVgceN3AbnHm7EtWi1ULr7FZLD46g9ni
        6B4Oi/OzTrFYXN41h83i1oRjTBYb779jcxD02DnrLrtHy5G3rB6L97xk8ti0qpPNY//cNewe
        fVtWMXpMnV3v8XmTXABHFJdNSmpOZllqkb5dAlfG3YeHGAuuslfMvnuHuYFxDlsXIyeHhICJ
        xJfjm9lBbCGB7YwSK89rQMQlJJZveMEEYQtL3G85wgpR84xR4vu8EBCbRUBF4ufbZ2A1bAJa
        EtNnNoDViAioS8xbe5uxi5GLg1ngD4tEV0cj0DIODmEBB4njl0pATF6g+gO/VEBKhAQuM0o0
        zTrBDNLLKyAocXLmExYQmxmo5sa/l0wg9cwC0hLL/3GAhDkF/CQOvN7GMoFRYBaSjllIOmYh
        dCxgZF7FKJpaUJybnptcYKhXnJhbXJqXrpecn7uJERxdWkE7GJet/6t3iJGJg/EQowQHs5II
        b3qDTKoQb0piZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QD00aF
        D5Hvf4vn3tgqxT81oNkzaPWUKLFWZpbZVUfUljcH/DTSeDNxdcaxr/5/d29pecPBveuKjeqP
        g8l3/Jo2yivkLmv4KbQo/s9Ly5tz30dkPlXYVM55696vriUXJdqCObIuRKZo3m6vn1ed3/th
        T8uBf2nTLl+ZI/OuxcwxQSdSfk9ceP+/acvPFOgdqAx44Re3Rv52/81ZrH1Lld47CUg/nDkx
        pdnkwCzuQtar56UbJq+t62VV+Sgg0c1nG7bccfMh9WVzlm6R/R/K+WBd3raCloh1l64G6V/l
        DerMZbwX4PQ9adrF35/0pu/c0WKU6jX7f/OysHP+K8V/H7+0qTpA9r9M9qPGeW5dwadyk5VY
        ijMSDbWYi4oTASjX8PkdAwAA
X-CMS-MailID: 20231004085800epcas2p48c4109cb15c80c3075744946d8619b5d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----fhEHFYu7RNsFUiSWfAq-IjQ-VzC.j9Pzsqf7lJgctIRm.Jgh=_8ee0f_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922113404epcas2p3995ec7890319931c33b0a549214c95ca
References: <CGME20230922113404epcas2p3995ec7890319931c33b0a549214c95ca@epcas2p3.samsung.com>
        <20230922113650.3301992-1-jtp.park@samsung.com>
        <zj4pigcxmpycmqqrfym7hhvc7s3gk5juhkziehvyjduydlt226@bke4pkczaxyt>
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

------fhEHFYu7RNsFUiSWfAq-IjQ-VzC.j9Pzsqf7lJgctIRm.Jgh=_8ee0f_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Sep 27, 2023 at 06:31:37PM -0700, Davidlohr Bueso wrote:
> On Fri, 22 Sep 2023, Jeongtae Park wrote:
> 
> > WARNING: please, no spaces at the start of a line
> > 
> > Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
> > ---
> > drivers/cxl/core/memdev.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 7e8fca4707c0..ce67df163452 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -1010,7 +1010,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> > 	}
> > 
> > 	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> > - }
> > +}
> 
> While nothing wrong, I do prefer this being corrected via
> 
> https://lore.kernel.org/linux-cxl/20230811025755.15103-1-dave@stgolabs.net/

That's better, I didn't know there was a related fix. Thanks for letting me know.

> 
> Thanks,
> Davidlohr

------fhEHFYu7RNsFUiSWfAq-IjQ-VzC.j9Pzsqf7lJgctIRm.Jgh=_8ee0f_
Content-Type: text/plain; charset="utf-8"


------fhEHFYu7RNsFUiSWfAq-IjQ-VzC.j9Pzsqf7lJgctIRm.Jgh=_8ee0f_--
