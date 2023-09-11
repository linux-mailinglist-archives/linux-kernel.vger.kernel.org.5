Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEFA79A387
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbjIKGcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjIKGcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:32:13 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B93DEA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:32:07 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230911063204epoutp04e156d1b73cfd627e825f6f674ffd0e88~DxHyMcCPa2502625026epoutp04I
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:32:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230911063204epoutp04e156d1b73cfd627e825f6f674ffd0e88~DxHyMcCPa2502625026epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694413924;
        bh=OtK4+Z2JS7n44256jbrIMxFSk9nndW18j2TP+4HDmrM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=AT/ctxgf9Ht5EMj338RixpXkGWWUVj5XqkvGG4EfCmDgyh1kAt1r5LtJlf2BjzZx9
         zyU3POc6+WCFgyG8uPZwFiXq3HSc1RpsszPsdDsR6o1Endj9wiGZTFULfJKoVrequk
         nOwlW19yaEGy7C10BU5nRQ5RXLGBml8UMzk2PXto=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230911063203epcas2p12e11b45784cf1799abbd361f1572ce14~DxHxWvGy60872308723epcas2p1n;
        Mon, 11 Sep 2023 06:32:03 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RkcM644sKz4x9Q7; Mon, 11 Sep
        2023 06:32:02 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.8B.09660.264BEF46; Mon, 11 Sep 2023 15:32:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230911063202epcas2p1bc8a8d2107ffd99c750e8fd1335092e7~DxHwXBziA1789917899epcas2p1Y;
        Mon, 11 Sep 2023 06:32:02 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230911063202epsmtrp26f979b4c0ab7cc9c0ab8a372915ff3f7~DxHwV20wT1073610736epsmtrp2X;
        Mon, 11 Sep 2023 06:32:02 +0000 (GMT)
X-AuditID: b6c32a47-d5dfa700000025bc-60-64feb462784e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.12.18916.164BEF46; Mon, 11 Sep 2023 15:32:01 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.38.105]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230911063201epsmtip2d71a2452b48082dc7e982b58d2d35bc7~DxHwGcK1m3136831368epsmtip2X;
        Mon, 11 Sep 2023 06:32:01 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Adrian Hunter'" <adrian.hunter@intel.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>, <beanhuo@micron.com>,
        <sc.suh@samsung.com>, <hy50.seo@samsung.com>,
        <sh425.lee@samsung.com>, <kwangwon.min@samsung.com>,
        <junwoo80.lee@samsung.com>, <wkon.kim@samsung.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>
In-Reply-To: <7dc56344-ee1c-43d4-9751-ded8f76d5852@intel.com>
Subject: RE: [RESEND PATCH v3 0/2] change UIC command handling
Date:   Mon, 11 Sep 2023 15:32:01 +0900
Message-ID: <001001d9e479$ac74c5d0$055e5170$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIwe0l2XHSCkaXhuPDRLLuGM/RalAHEhVGBAhaVcJgBqZylIwKkta+hryanrKA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmmW7Sln8pBmsfy1mcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxa6/zUwWW2/sZLG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBabL31jceD3uHzF22PxnpdMHhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfR
        fqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0z
        B+h4JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGB
        kSlQYUJ2xvaWn2wFCwQrzr/cx97AuJevi5GTQ0LARGLn5QNMXYxcHEICOxgl5p+YCuV8YpTo
        btzBDufcWLiUBabl6aczUFU7GSW2dO6CqnrJKLHizy8mkCo2AW2JaQ93s4LYIgL6Ehv232EG
        KWIW6GKWWH/vFdgoTgFbiY/b9gDZHBzCAnYS93fIgYRZBFQl/rZsYwSxeQUsJSY2d7NC2IIS
        J2c+AWtlBpq/bOFrZoiLFCR+Pl0GtctPYsbsM1A1IhKzO9vA9koIPOCQuDv1IyNEg4vEhyvf
        oN4Rlnh1fAs7hC0l8fndXjaQeyQEsiX2LBSDCFdILJ72FqrcWGLWs3ZGkBJmAU2J9bv0IaqV
        JY7cgtrKJ9Fx+C87RJhXoqNNCKJRWeLXpMlQ+yUlZt68wz6BUWkWkr9mIflrFpL7ZyHsWsDI
        sopRLLWgODc9tdiowBge18n5uZsYwclay30H44y3H/QOMTJxMB5ilOBgVhLhLTn0N0WINyWx
        siq1KD++qDQntfgQoykwpCcyS4km5wPzRV5JvKGJpYGJmZmhuZGpgbmSOO+91rkpQgLpiSWp
        2ampBalFMH1MHJxSDUyMPitFN8dtPzkjJLYotaDpLeeOeMO/haIWxkt6X3aekvm1X+3YzbTz
        0w//L9j7ebVgGJfPLqPSCcs3PLMrnK3VeX7T7HWRc6WkDO0mTmx8s5ZNk2/xhvgz4TJnz8up
        pD2cX5C38NGn5bU3k1ewnqww7HM5m8xy2sPqlcjSiXe9MtZ8XaV91e1JnhzbzWMHUoO9GqJ+
        eU5+o9XRHn5zy2+p7B9vm2pO8b3myPpkwl+o9KDriPkuJsG2X3NmcHqv+v1P4Pqrhw7MzyYW
        vLetbEw2K1Wubt41gf1FmZ5sbagvq2Rq56ae8yLMXn6ZF64U1D/S1VrI6aQWFPghTuLRi4fP
        65uCb9w79LLiUnChVa0SS3FGoqEWc1FxIgDC+kgBXwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSvG7iln8pBuf/W1mcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxa6/zUwWW2/sZLG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBabL31jceD3uHzF22PxnpdMHhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfR
        fqCbKYAjissmJTUnsyy1SN8ugStj1t+5zAUrBCoWzehmaWA8ydvFyMkhIWAi8fTTGaYuRi4O
        IYHtjBJd6zawQyQkJU7sfM4IYQtL3G85wgpiCwk8Z5Q4dsgdxGYT0JaY9nA3WFxEQF9iw/47
        zCCDmAVmMUssXLuaFWLqBCaJruXvwSZxCthKfNy2h6WLkYNDWMBO4v4OOZAwi4CqxN+WbWAl
        vAKWEhObu1khbEGJkzOfsIDYzEDLeh+2MsLYyxa+ZoY4TkHi59NlUEf4ScyYfQaqXkRidmcb
        8wRG4VlIRs1CMmoWklGzkLQsYGRZxSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iREcs1pBOxiX
        rf+rd4iRiYPxEKMEB7OSCG/Job8pQrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tS
        s1NTC1KLYLJMHJxSDUwhd5Z210SeOu9y17+6LGJK6sI1l50XvqyIyYxmPzP7zd0Nef7S6jFH
        txTkHlYTfH/F48vhT6KuM17X1l06f0AliyHwwpqHPyJfsbau0DBZy9DJNaP44I+nSU01UQve
        fJr81rljy5X9JxxMtIsjLcq97t88fGTC8yXszk6cGsofjZOevY8qini0VCUt17+ta03w5U1H
        iiRtnkc89DZ6Ui3JpDv3iM/l+JRX3Gr5m757qfxOZby6K7znmPGKx7mnTM7d296oaDb1pG69
        bNri1e9Erj3M2qDz4MvZ6WqFqaWb4zo/n7ywS2d1IMN9lb3xObtmz98hvO7kmo7kb3tP63e/
        a07ousNU2FWsvsHW9m6OEktxRqKhFnNRcSIAbXtYOUgDAAA=
X-CMS-MailID: 20230911063202epcas2p1bc8a8d2107ffd99c750e8fd1335092e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904014146epcas2p37d6690a5eb3a5652571bb00e358231a3
References: <CGME20230904014146epcas2p37d6690a5eb3a5652571bb00e358231a3@epcas2p3.samsung.com>
        <cover.1693790060.git.kwmad.kim@samsung.com>
        <yq1jzt5j5go.fsf@ca-mkp.ca.oracle.com>
        <02b701d9e450$3e7d5ca0$bb7815e0$@samsung.com>
        <7dc56344-ee1c-43d4-9751-ded8f76d5852@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> ufs: poll HCS.UCRDY before issuing a UIC command
> >
> > =5B 4671.226480=5D =5B3: kworker/u20:29:17140=5D BUG: scheduling while =
atomic:
> > kworker/u20:29/17140/0x00000002
> > ..
> > =5B 4671.228723=5D =5B3: kworker/u20:29:17140=5D  panic+0x16c/0x388 =5B
> > 4671.228745=5D =5B3: kworker/u20:29:17140=5D  check_panic_on_warn+0x60/=
0x94
> > =5B 4671.228764=5D =5B3: kworker/u20:29:17140=5D  __schedule_bug+0x6c/0=
x94 =5B
> > 4671.228786=5D =5B3: kworker/u20:29:17140=5D  __schedule+0x6f4/0xa64 =
=5B
> > 4671.228806=5D =5B3: kworker/u20:29:17140=5D  schedule+0x7c/0xe8 =5B
> > 4671.228824=5D =5B3: kworker/u20:29:17140=5D
> > schedule_hrtimeout_range_clock+0x98/0x114
> > =5B 4671.228841=5D =5B3: kworker/u20:29:17140=5D
> > schedule_hrtimeout_range+0x14/0x24
> > =5B 4671.228856=5D =5B3: kworker/u20:29:17140=5D  usleep_range_state+0x=
60/0x94
> > =5B 4671.228871=5D =5B3: kworker/u20:29:17140=5D
> > __ufshcd_send_uic_cmd+0xa0/0x1c4 =5B 4671.228893=5D =5B3:
> > kworker/u20:29:17140=5D  ufshcd_uic_pwr_ctrl+0x15c/0x390 =5B 4671.22890=
8=5D
> > =5B3: kworker/u20:29:17140=5D ufshcd_uic_hibern8_enter+0x9c/0x25c
> > =5B 4671.228922=5D =5B3: kworker/u20:29:17140=5D
> > ufshcd_link_state_transition+0x34/0xb0
> > =5B 4671.228939=5D =5B3: kworker/u20:29:17140=5D
> > __ufshcd_wl_suspend+0x3f0/0x4b4
>=20
> Do you know what is in that path that makes it an atomic context?

Hi,
This made that.

static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd=
)
..
        bool reenable_intr =3D false;

        mutex_lock(&hba->uic_cmd_mutex); <<<<


At first, I was willing to post together w/ the following patch but I've go=
t a suggestion to split the patch set because of different topic and I spli=
t the patch set.
- This patch removes the mutex, so it can fix the issue.
https://lore.kernel.org/linux-scsi/1694051306-172962-1-git-send-email-kwmad=
.kim=40samsung.com/


But now I'm thinking again that simply removing the mutex could hurt atomic=
ity of UIC command process
that the original code intended for the first time.
So I think this polling UCRDY should be modified rather than applying remov=
al of the mutex.



