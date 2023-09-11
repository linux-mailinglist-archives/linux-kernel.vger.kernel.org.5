Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0327779A0FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 03:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjIKBfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 21:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjIKBfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 21:35:38 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A2E121
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 18:35:32 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230911013530epoutp01f23a78109e8321752a2965d5c173f8bb~DtE2TB3Dz2299122991epoutp01X
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:35:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230911013530epoutp01f23a78109e8321752a2965d5c173f8bb~DtE2TB3Dz2299122991epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694396130;
        bh=8eJgZeaFbEsj0QhssoQfhVmof4A93dXSX4xLkpJuYSc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WMJvSpz9IazInBaj4LWe2DNIogwNql99+t2yu2wQu2i7zQJ4D/Q+BQ3d8Z5td41Ex
         CsDdLNLYE24xC6EFbtgHsa5uZ2kT/qQ6C0iGeTh9kXXm4vbQqyrfZJb4yw7sP48LJT
         qybBx+H3BxvP3nazMTWiZJ8OGFLDqNgNFbCZs4BQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230911013529epcas2p1009fec4ec3e20bfbf1d37f12ef633a0e~DtE1fa41Z1935419354epcas2p1_;
        Mon, 11 Sep 2023 01:35:29 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RkTmw4x6jz4x9Pw; Mon, 11 Sep
        2023 01:35:28 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.69.09660.0EE6EF46; Mon, 11 Sep 2023 10:35:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230911013528epcas2p13cf413d9d41ab93ee1f6a924c4e3f935~DtE0k3Ypl2910929109epcas2p1U;
        Mon, 11 Sep 2023 01:35:28 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230911013528epsmtrp205038945a3ba1db08fbc323537fec7d0~DtE0kF6cS0370003700epsmtrp2S;
        Mon, 11 Sep 2023 01:35:28 +0000 (GMT)
X-AuditID: b6c32a47-afdff700000025bc-e2-64fe6ee06bef
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.EA.08649.0EE6EF46; Mon, 11 Sep 2023 10:35:28 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.38.105]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230911013527epsmtip22961711704d618a2950bba6d3cb1c194~DtE0R_VgX2379423794epsmtip2r;
        Mon, 11 Sep 2023 01:35:27 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Martin K. Petersen'" <martin.petersen@oracle.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>, <beanhuo@micron.com>,
        <adrian.hunter@intel.com>, <sc.suh@samsung.com>,
        <hy50.seo@samsung.com>, <sh425.lee@samsung.com>,
        <kwangwon.min@samsung.com>, <junwoo80.lee@samsung.com>,
        <wkon.kim@samsung.com>
In-Reply-To: <yq1jzt5j5go.fsf@ca-mkp.ca.oracle.com>
Subject: RE: [RESEND PATCH v3 0/2] change UIC command handling
Date:   Mon, 11 Sep 2023 10:35:27 +0900
Message-ID: <02b701d9e450$3e7d5ca0$bb7815e0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIwe0l2XHSCkaXhuPDRLLuGM/RalAHEhVGBAhaVcJivSNAtgA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmue6DvH8pBjf+q1icfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxa6/zUwWW2/sZLG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBabL31jceD3uHzF22PxnpdMHhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfR
        fqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0z
        B+h4JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGB
        kSlQYUJ2xvw1M5kK7vBWXNh2i7GB8RZ3FyMnh4SAicT/u7PZuxi5OIQEdjBKrL98ixnC+cQo
        8ef+EyjnG6PE9hfPmGFaPn84CtWyl1Fi2rF5TBDOS0aJ5sZPbCBVbALaEtMe7mYFsUUEzCUm
        TjjKAlLELPCBSWL97RlgRZwCxhLPl50Dsjk4hAXsJO7vkAMxWQRUJR4+rwap4BWwlOh/fIoF
        whaUODnzCZjNLGAg8f7cfGYIW15i+9s5UMcpSPx8ugxqrZPEgSPfmSBqRCRmd7aBfSMh8IRD
        4vq2/awQDS4S/WsghkoICEu8Or6FHcKWkvj8bi/YaRIC2RJ7FopBhCskFk97C1VuLDHrWTsj
        RImyxJFbUKfxSXQc/ssOEeaV6GgTgqhWlvg1aTIjhC0pMfPmHfYJjEqzkDw2C8ljs5A8NgvJ
        AwsYWVYxiqUWFOempxYbFRjDIzs5P3cTIzhda7nvYJzx9oPeIUYmDsZDjBIczEoivCWH/qYI
        8aYkVlalFuXHF5XmpBYfYjQFBvVEZinR5HxgxsgriTc0sTQwMTMzNDcyNTBXEue91zo3RUgg
        PbEkNTs1tSC1CKaPiYNTqoFp+V21OyIbIx7EHK6onbB5Pl+wgW1aiI8Si2burntCxqEae3c7
        qfDrWgk6CngYcb3fH7GZhy2JZd7NOya72y8d5lR/2C/m4pi/Vc9IjZmlcp7xDJeWd64vNVIZ
        vf4Uuld/Wl4589DSsKRJFfPcn+RpuH8P+vCY80ngCc7Nl59wHLWfcfpXY0jiWn6DD0kca4TD
        +WIeaExnfqRUX1bxIf67f4DmI4YN97MvvrL2FRSblsowh7N80tvfzlGfneVamZI6707pKNkS
        +njRAq/uJv5NpwyffXK0DNatUVn9p0KOv/mhqWni57m8WvyFiSGdCdvfNnyZdnth2G5Th5w5
        bwKloq2v8pmWyQct8ToyRYmlOCPRUIu5qDgRAGcTHutgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSvO6DvH8pBqcb2SxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZovVix+wWCy6sY3JYtffZiaLrTd2slhc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFovNl76xOPB7XL7i7bF4z0smjwmLDjB6fF/fwebx8ektFo++LasYPT5vkvNo
        P9DNFMARxWWTkpqTWZZapG+XwJUxf81MpoI7vBUXtt1ibGC8xd3FyMkhIWAi8fnDUXYQW0hg
        N6PErPXqEHFJiRM7nzNC2MIS91uOsHYxcgHVPGeU+D7tEBNIgk1AW2Law92sILaIgLnExAlH
        WUCKmAUamCUa1h9kg+jYyChxfOIWsCpOAWOJ58vOASU4OIQF7CTu75ADMVkEVCUePq8GqeAV
        sJTof3yKBcIWlDg58wmYzSxgJHHu0H42CFteYvvbOcwQxylI/Hy6DOoGJ4kDR74zQdSISMzu
        bGOewCg8C8moWUhGzUIyahaSlgWMLKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYIj
        V0tjB+O9+f/0DjEycTAeYpTgYFYS4S059DdFiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkp
        QgLpiSWp2ampBalFMFkmDk6pBiaF7z3P2j/KCyvelDs9QTO0mfmTv74Ek+Vnjndf2hdE/trN
        GfaoKkRxTsAVvVcNcbeuhfusEFI+u8k2wyzk3K6F9cuD2x75fgi7EzlZ6lwvv1JhnNPcie1N
        Rre3/ljq9ubWmvm6vbFT6/b5H1PRVPAV+378ddHFjvdmYsV9z65t1321tvZoZX19l29Aiq/C
        OQWR8mPmDGx7nmvyxF1fbJG5+12+kmKuWMQflTDVPWs+XVh7qyC39NBZls9/z5lObH1+67vr
        ZDsD/rO3VXsuP1xw6mK25M11Jf+U9S233OBxjWE0k3gYUrX1LsfM/DQWey6GY74lvWF3HvCf
        WFbV6ZvzfFVOrFF3TcyMDenz1ZVYijMSDbWYi4oTATt4iOtLAwAA
X-CMS-MailID: 20230911013528epcas2p13cf413d9d41ab93ee1f6a924c4e3f935
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904014146epcas2p37d6690a5eb3a5652571bb00e358231a3
References: <CGME20230904014146epcas2p37d6690a5eb3a5652571bb00e358231a3@epcas2p3.samsung.com>
        <cover.1693790060.git.kwmad.kim@samsung.com>
        <yq1jzt5j5go.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > v2 -> v3: rule out the change of polling w/ pmc from this thread.
> > (I'll post the change later)
> > v1 -> v2: remove an unused variable in __ufshcd_send_uic_cmd
> >
> > Kiwoong Kim (2):
> >   ufs: make __ufshcd_send_uic_cmd not wrapped by host_lock
> >   ufs: poll HCS.UCRDY before issuing a UIC command
> 
> Applied to 6.6/scsi-staging, thanks!
> 
> --
> Martin K. Petersen	Oracle Linux Engineering

Hi, Martin

The following patch seems to make trouble because of using
read_poll_timeout.
Its initial version used udelay and after discussion it's been changed.
Could you revert this patch set?

> ufs: poll HCS.UCRDY before issuing a UIC command

[ 4671.226480] [3: kworker/u20:29:17140] BUG: scheduling while atomic:
kworker/u20:29/17140/0x00000002
..
[ 4671.228723] [3: kworker/u20:29:17140]  panic+0x16c/0x388
[ 4671.228745] [3: kworker/u20:29:17140]  check_panic_on_warn+0x60/0x94
[ 4671.228764] [3: kworker/u20:29:17140]  __schedule_bug+0x6c/0x94
[ 4671.228786] [3: kworker/u20:29:17140]  __schedule+0x6f4/0xa64
[ 4671.228806] [3: kworker/u20:29:17140]  schedule+0x7c/0xe8
[ 4671.228824] [3: kworker/u20:29:17140]
schedule_hrtimeout_range_clock+0x98/0x114
[ 4671.228841] [3: kworker/u20:29:17140]  schedule_hrtimeout_range+0x14/0x24
[ 4671.228856] [3: kworker/u20:29:17140]  usleep_range_state+0x60/0x94
[ 4671.228871] [3: kworker/u20:29:17140]  __ufshcd_send_uic_cmd+0xa0/0x1c4
[ 4671.228893] [3: kworker/u20:29:17140]  ufshcd_uic_pwr_ctrl+0x15c/0x390
[ 4671.228908] [3: kworker/u20:29:17140]
ufshcd_uic_hibern8_enter+0x9c/0x25c
[ 4671.228922] [3: kworker/u20:29:17140]
ufshcd_link_state_transition+0x34/0xb0
[ 4671.228939] [3: kworker/u20:29:17140]  __ufshcd_wl_suspend+0x3f0/0x4b4

Thanks you.

