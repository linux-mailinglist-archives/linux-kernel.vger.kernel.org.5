Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC97EBCC3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 06:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjKOF1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 00:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjKOF1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 00:27:11 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB547C3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 21:27:06 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231115052703epoutp013ed35639ae69fc01ad0af984be81d0bb~XtKlYjAuy0913309133epoutp01k
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:27:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231115052703epoutp013ed35639ae69fc01ad0af984be81d0bb~XtKlYjAuy0913309133epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700026023;
        bh=D0EqNZ4QvmTiqp+zm9gUip9+1CE4m/Mr3OtYi4fnK84=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=Ald55MmamXookYk9bNvZJYivhK6D9WzjrqF/Z4MKvUqNi6AE/65g4USPq+VbR7Nnc
         5Y6aXNAV1Vv0ZMrip9tc2vzuFJ/P61d+xpLiocOVcWiOU+Wp2dRhi0ovFlj8CJxMp9
         gFDUpyQwU7fIlzvkpdE9BnL+lS3ggXexOngAppnw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231115052702epcas2p4bf1ed0b3b92810f0966e742e4553af6f~XtKkn6zhR0725207252epcas2p43;
        Wed, 15 Nov 2023 05:27:02 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SVWr61JVLz4x9Q9; Wed, 15 Nov
        2023 05:27:02 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.81.08648.5A654556; Wed, 15 Nov 2023 14:27:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231115052701epcas2p4d1106372cfc6e274fbf51ce14d5c4924~XtKjItrl-1897718977epcas2p4Q;
        Wed, 15 Nov 2023 05:27:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231115052701epsmtrp1474112faf7522eb10d691ca34ae2e501~XtKjH3mQz0354103541epsmtrp1i;
        Wed, 15 Nov 2023 05:27:01 +0000 (GMT)
X-AuditID: b6c32a43-4b3ff700000021c8-05-655456a5efc7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.7E.08817.5A654556; Wed, 15 Nov 2023 14:27:01 +0900 (KST)
Received: from KORCO118546 (unknown [10.229.38.108]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231115052701epsmtip18ad6a5c866000d16411b218042404755~XtKi6RgAz1106911069epsmtip1D;
        Wed, 15 Nov 2023 05:27:01 +0000 (GMT)
From:   "hoyoung seo" <hy50.seo@samsung.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <kwangwon.min@samsung.com>,
        <kwmad.kim@samsung.com>, <sh425.lee@samsung.com>,
        <sc.suh@samsung.com>, <quic_nguyenb@quicinc.com>,
        <cpgs@samsung.com>, <grant.jung@samsung.com>,
        <junwoo80.lee@samsung.com>
In-Reply-To: <dca06fd3-d4ad-4e41-a0a3-61d52c85ef9c@acm.org>
Subject: RE: [PATCH v2] scsi: ufs: core: fix racing issue during
 ufshcd_mcq_abort
Date:   Wed, 15 Nov 2023 14:27:00 +0900
Message-ID: <000001da1784$5c2520f0$146f62d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLYbO3h/Z18bVSq8KBPFnY/ewa5qgDl2w4PAbQq5PquaVzhQA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmqe6ysJBUg8mvmC0ezNvGZvHy51U2
        i4MPO1kspn34yWzx8pCmxa+/69ktFt3YxmSx628zk8XWGztZLG5uOcpicXnXHDaL7us72CyW
        H//HZDH1xXF2i667Nxgtlv57y+Ig4HH5irfHhEUHGD2+r+9g8/j49BaLx8Q9dR59W1Yxenze
        JOfRfqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA
        1y0zB+h+JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomV
        oYGBkSlQYUJ2xruvsxgL7vNUHOx6zNbAeIiri5GDQ0LARGL3FJ8uRi4OIYEdjBK39jSxQzif
        GCV6Fv5lhHC+MUq8u7yPpYuRE6zj0+QTbCC2kMBeRonZlzwgil4ySnTP3MMOkmAT0JLof7uF
        DSQhIrCLWWLjveVg3ZwC1hL3u2aCdQsLBEvc2XKGDeQOFgFViYbz0SBhXgFLiZuXzzBB2IIS
        J2c+AWtlFpCX2P52DjPEEQoSP58uYwWxRQScJBZ3nGKHqBGRmN3ZxgyyV0LgAYfE9Z0P2CAa
        XCTO33zNBGELS7w6voUdwpaSeNnfBmVnSzTuWQtlV0jM3TyZEcI2lpj1rJ0R5E5mAU2J9bv0
        IUGnLHHkFtRpfBIdh/9CdfJKNGz8zQ5RwivR0SYEEVaSODP3NlRYQuLg7JwJjEqzkPw4C8mP
        s5D8Mgth7QJGllWMYqkFxbnpqclGBYbwmE7Oz93ECE7XWs47GK/M/6d3iJGJg/EQowQHs5II
        r7lcSKoQb0piZVVqUX58UWlOavEhRlNgoE9klhJNzgdmjLySeEMTSwMTMzNDcyNTA3Mlcd57
        rXNThATSE0tSs1NTC1KLYPqYODilGpi2dc4yZHZn6e+VWKB/aIay7r3mBctk80MXzgud2X5k
        CffHcp1wzsY/92zdV+UyNM6cuvnZjE8nZk00SJGbz7XoYNBEntiZ4o7FtTs09vtOffdeUKRI
        MSNX+3/UU7F+75Uqi6Z/buX4MFni6M+YiWYBwveWXzdeyL93iae0uEYB97dOh9LNOW3TeV6L
        r5gab93maLMt1qpbPb77xPFjj5XvfKg6ecPS8NFdtzlR2zyPO7P+1ogW3a55cmtHb8baEzuX
        RaQdXfbLdEIee+sHoUTDf5zn5K6eEvVvUU0Wam7jnOU1115Tg+EKT09YWsmuLZbJ2k/fxEeX
        2HVYOU8332mV2swx8ZpI3dGby86vW6PEUpyRaKjFXFScCACS6dTlYAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7bCSnO7SsJBUg/23BCwezNvGZvHy51U2
        i4MPO1kspn34yWzx8pCmxa+/69ktFt3YxmSx628zk8XWGztZLG5uOcpicXnXHDaL7us72CyW
        H//HZDH1xXF2i667Nxgtlv57y+Ig4HH5irfHhEUHGD2+r+9g8/j49BaLx8Q9dR59W1Yxenze
        JOfRfqCbKYAjissmJTUnsyy1SN8ugSvj3ddZjAX3eSoOdj1ma2A8xNXFyMkhIWAi8WnyCTYQ
        W0hgN6NE0wUniLiExP/FTUwQtrDE/ZYjrF2MXEA1zxkl5i7YAdbAJqAl0f92CxtIQkTgHLPE
        yY0vWCCqdjFKfGv7CVbFKWAtcb9rJpgtLBAosebMdMYuRg4OFgFViYbz0SBhXgFLiZuXzzBB
        2IISJ2c+YQGxmQW0JZ7efAply0tsfzuHGeIiBYmfT5exgtgiAk4SiztOsUPUiEjM7mxjnsAo
        NAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCI1VLawfj
        nlUf9A4xMnEwHmKU4GBWEuE1lwtJFeJNSaysSi3Kjy8qzUktPsQozcGiJM777XVvipBAemJJ
        anZqakFqEUyWiYNTqoEprMnw+E3bWqNLy/muKnKWleh6PrukWuMypyxMIoOXaYprxiyeaBW5
        HX63Dl0+O501SOKPptiGE23maVcVT05dteDP/AT1j8K6C/0Xx954kWwX1n3CZ43ZNzWV4oN/
        MmyiT39VuC++h5/dZXduodpT12/TVzxfOPdFqo/o1jdrfx36/7J6vbTBv2n2LhK6HLOvRpZq
        Nv969+7IbtED06f0BkjbrjJ8+fSW70rZJZ3Wr1qdjv+epvdaevNkmZ22j0RNHty8JWlsvXPR
        9s6tsW8juVwvngxM2r1x5hPr4+cThC7wbH4smrdedULZ9llpK9OVls5pCDxYYCLvWvXnjJzE
        D9OLF1Z8+BjMJdf/WN/jhhJLcUaioRZzUXEiAPxfK/xDAwAA
X-CMS-MailID: 20231115052701epcas2p4d1106372cfc6e274fbf51ce14d5c4924
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231114043431epcas2p4a8d452e18fff192c03fb6066e81514ea
References: <CGME20231114043431epcas2p4a8d452e18fff192c03fb6066e81514ea@epcas2p4.samsung.com>
        <20231114043704.52525-1-hy50.seo@samsung.com>
        <dca06fd3-d4ad-4e41-a0a3-61d52c85ef9c@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Bart Van Assche <bvanassche@acm.org>
> Sent: Wednesday, November 15, 2023 2:55 AM
> To: SEO HOYOUNG <hy50.seo@samsung.com>; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org; alim.akhtar@samsung.com; avri.altman@wdc.com;
> jejb@linux.ibm.com; martin.petersen@oracle.com; beanhuo@micron.com;
> kwangwon.min@samsung.com; kwmad.kim@samsung.com; sh425.lee@samsung.com;
> sc.suh@samsung.com; quic_nguyenb@quicinc.com; cpgs@samsung.com;
> grant.jung@samsung.com; junwoo80.lee@samsung.com
> Subject: Re: [PATCH v2] scsi: ufs: core: fix racing issue during
> ufshcd_mcq_abort
> 
> On 11/13/23 20:37, SEO HOYOUNG wrote:
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index 9a730a794b66..55f4c0eeda7b 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > @@ -7574,6 +7574,10 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba,
> int tag)
> >   		goto out;
> >   	}
> >
> > +	if (!ufshcd_cmd_inflight(lrbp->cmd) ||
> > +	    test_bit(SCMD_STATE_COMPLETE, &lrbp->cmd->state))
> > +		goto out;
> > +
> >   	err = ufshcd_clear_cmd(hba, tag);
> >   	if (err)
> >   		dev_err(hba->dev, "%s: Failed clearing cmd at tag %d,
> err %d\n",
> 
> The UFS driver must not set SCMD_STATE_COMPLETE itself. Only the SCSI core
> is allowed to set that bit.
> 
> Thanks,
> 
> Bart.

Hi,

The test_bit() function just check SCMD_STATE_COMPLETE bit state.
Do not set SCMD_STATE_COMPLETE field. 
This function is also used in ufshcd_mcq_compl_pending_transfer() 
to check the status of cmd.

Thanks.
BRs SEO.

