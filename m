Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B46176AD9B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjHAJau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjHAJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:30:30 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B01A116
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:29:10 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230801092001epoutp017f03baeef40fd7656c052ded25f84172~3N9uzQ51p2326823268epoutp01b
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:20:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230801092001epoutp017f03baeef40fd7656c052ded25f84172~3N9uzQ51p2326823268epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690881601;
        bh=vs4C8cJGS67065RVYT27eNMIlYfToH9rfLGTxjMdpXU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=uQ0R/potL5sMLVmZQLe7ZKNyauhmxZmv69ln/ZbBbNwi4rwo7b6psSW6LndQLmJUq
         jUKtpzN4NQ5L9F7EaHtmvZB95J98Eju/ewGLG7ZRsJlI4ujcCAUdFaz2qi+Px5Mkh3
         Jzd2QG8fnOs0L1qaz+ubrvTCiO9b6TMfgDoga2Zk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230801092001epcas2p3c25661e733c443f20800cb24b60d97bc~3N9ufw0Bj2559825598epcas2p3X;
        Tue,  1 Aug 2023 09:20:01 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RFV1r59Tbz4x9Pp; Tue,  1 Aug
        2023 09:20:00 +0000 (GMT)
X-AuditID: b6c32a48-adffa70000007e89-4b-64c8ce404008
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.6D.32393.04EC8C46; Tue,  1 Aug 2023 18:20:00 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] scsi: ufs: ufs-pci: Add support for QEMU
Reply-To: jeuk20.kim@samsung.com
Sender: Jeuk Kim <jeuk20.kim@samsung.com>
From:   Jeuk Kim <jeuk20.kim@samsung.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "dlunev@chromium.org" <dlunev@chromium.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <48f05875-5255-70d2-0737-36fa95470037@intel.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230801092000epcms2p44c99d2c15bc6169e38693cb64cf946db@epcms2p4>
Date:   Tue, 01 Aug 2023 18:20:00 +0900
X-CMS-MailID: 20230801092000epcms2p44c99d2c15bc6169e38693cb64cf946db
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmua7DuRMpBrdb1CxOPlnDZvHy51U2
        i2kffjJbvDykaXH80FcWi0U3tjFZXN41h82i+/oONovlx/8xOXB6XL7i7TG74SKLx+I9L5k8
        Jiw6wOjx8ektFo++LasYPT5vkvNoP9DNFMARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
        YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
        JafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y/OKD8wFs4QqDs4/yN7AOEegi5GTQ0LARGJP
        +0cWEFtIYAejxMWzwl2MHBy8AoISf3cIg4SFBWwl7l7eCFWiIDFnWwc7RFxTYvr6iUwg5WwC
        6hKnF5qDhEUEtCUm/1nF3MXIxcEs8JFJonfNbxaIVbwSM9qfQtnSEtuXb2UEsTmB5u+cvYwd
        Iq4h8WNZLzOELSpxc/Vbdhj7/bH5jBC2iETrvbNQNYISD37uhopLSpz69pgVwp7OKLHgvynI
        ERICCxglfjVPh2rQl7jWAfIMyI++Elee+YCEWQRUJV5/nQe1y0Xi9al3TCA2M9Azyxa+ZgYp
        Zwb6d/0ufRBTQkBZ4sgtFogKPomOw3/ZYT5s2PgbK3vHvCdMELaKxOLmw6wTGJVnIcJ5FpJd
        sxB2LWBkXsUollpQnJueWmxUYAKP2eT83E2M4FSq5bGDcfbbD3qHGJk4GA8xSnAwK4nwSv8+
        niLEm5JYWZValB9fVJqTWnyI0RToy4nMUqLJ+cBknlcSb2hiaWBiZmZobmRqYK4kznuvdW6K
        kEB6YklqdmpqQWoRTB8TB6dUA1P4mvXVR0V7zkZaCUp7269WrmS3vLvvulx7hxV7xZR6b4/T
        opzL/s9Zsy0nKX1ze9S7f9XmjZ1xi6qn7RbdZmj9v2u+b8mmBVH7W7/6Rer/kjGakHDBeuXK
        E9xZB9kDThY/uxPjZcAi2iW/qINpS0DCjSsVT292XNi98/j8U3onVgi6J6qfZLz8yXOT3vyt
        AS6LeAPmz3Z1Ci6eGpe3fvOtOdKrXp0sOhR27qurzEyXb0t2aAbV/g4IZvrdapLKm6OzzOq6
        8Z1Wfu19x227N7y4FitQo/f499yJW583MlaKah7jrUgPt19ff/T5ssRapR7DE7ZrMriVfLwm
        7ve+9V1eSOy9j55CYyTbBa13d5VYijMSDbWYi4oTARpEefguBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b
References: <48f05875-5255-70d2-0737-36fa95470037@intel.com>
        <20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b@epcms2p1>
        <CGME20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b@epcms2p4>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/08/23, Adrian Hunter wrote:
> On 1/08/23 10:37, Jeuk Kim wrote:
> > Add PCI ID to support QEMU ufs.
> >=20
> > The new qemu ufs device can be found at
> > https://lore.kernel.org/qemu-devel/20230727155239.GA979354=40fedora
>=20
> Please say something about why a UFS device is being virtualized
> and what features it is expected to support.

Hi Adrian=21

UFS device emulation feature has been newly added to QEMU recently.
Currently, QEMU UFS supports basic io and query request features,
and plans to add more features in the future.

With the addition of the QEMU ufs device emulation feature,=20
QEMU UFS decided to use the pci device id of 0x0013 in the REDHAT vendor id=
 (0x1b36).

However, this information is not registered in the linux ufs driver,=20
so the current linux kernel does not recognize the QEMU UFS device.=20
Therefore, I want to register the QEMU ufs pci id through this patch.

Do I need to add the above content to the commit message?

Thanks,
Jeuk

> >=20
> > Signed-off-by: Jeuk Kim <jeuk20.kim=40samsung.com>
> > ---
> >=C2=A0=20drivers/ufs/host/ufshcd-pci.c=20=7C=201=20+=0D=0A>=20>=C2=A0=20=
1=20file=20changed,=201=20insertion(+)=0D=0A>=20>=20=0D=0A>=20>=20diff=20--=
git=20a/drivers/ufs/host/ufshcd-pci.c=20b/drivers/ufs/host/ufshcd-pci.c=0D=
=0A>=20>=20index=20cf3987773051..29d322931427=20100644=0D=0A>=20>=20---=20a=
/drivers/ufs/host/ufshcd-pci.c=0D=0A>=20>=20+++=20b/drivers/ufs/host/ufshcd=
-pci.c=0D=0A>=20>=20=40=40=20-590,6=20+590,7=20=40=40=20static=20const=20st=
ruct=20dev_pm_ops=20ufshcd_pci_pm_ops=20=3D=20=7B=0D=0A>=20>=C2=A0=20=7D;=
=0D=0A>=20>=C2=A0=20=0D=0A>=20>=C2=A0=20static=20const=20struct=20pci_devic=
e_id=20ufshcd_pci_tbl=5B=5D=20=3D=20=7B=0D=0A>=20>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=7B=20PCI_VENDOR_ID_REDHAT,=200x0013,=20PCI_ANY_ID,=20PCI_AN=
Y_ID,=200,=200,=200=20=7D,=0D=0A>=20>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=7B=20PCI_VENDOR_ID_SAMSUNG,=200xC00C,=20PCI_ANY_ID,=20PCI_ANY_ID,=
=200,=200,=200=20=7D,=0D=0A>=20>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=7B=20PCI_VDEVICE(INTEL,=200x9DFA),=20(kernel_ulong_t)&ufs_intel_cnl_hba=
_vops=20=7D,=0D=0A>=20>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7B=20P=
CI_VDEVICE(INTEL,=200x4B41),=20(kernel_ulong_t)&ufs_intel_ehl_hba_vops=20=
=7D,
