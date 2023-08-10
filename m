Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AFD776DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjHJCG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 22:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjHJCGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:06:25 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443DCF3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 19:06:22 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230810020616epoutp0371f3ebe59291d4a7330802ac744e85ed~542lPbPA71669216692epoutp03h
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:06:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230810020616epoutp0371f3ebe59291d4a7330802ac744e85ed~542lPbPA71669216692epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691633176;
        bh=PBnRm2oRhfvLhESry5Ivra7pQp4y7Epj+56bT+8qL7Q=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=NYsBy6GXyBox7KPg9K8DZnpXnG4xitN3lJ6NwGxsTi8Z729sogxuKwCCJtDvesBPZ
         uL7Ep6F/kbepEbX5/AZfER2boYm/XGnJUF4FvL/kEJuHykJ01Kb7z+yUPCNFC6lymI
         77sbX3jFY4nev1T4dcXsSEegrs70XL/DUCLuwi6A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230810020616epcas2p1b060878c961888b7dd0465c21440c24e~542kycGs81707817078epcas2p1J;
        Thu, 10 Aug 2023 02:06:16 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RLqzC3CfHz4x9Pr; Thu, 10 Aug
        2023 02:06:15 +0000 (GMT)
X-AuditID: b6c32a43-e6fdca800000c342-31-64d44617cca6
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.63.49986.71644D46; Thu, 10 Aug 2023 11:06:15 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v3 0/4] multi-page bvec configuration for integrity
 payload
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <yq1y1ijho3e.fsf@ca-mkp.ca.oracle.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230810020615epcms2p8ae414270a3b4cf171fdcd7537fdfbe64@epcms2p8>
Date:   Thu, 10 Aug 2023 11:06:15 +0900
X-CMS-MailID: 20230810020615epcms2p8ae414270a3b4cf171fdcd7537fdfbe64
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmma6425UUg45XIhar7/azWcy6/ZrF
        4uUhTYvTExYxWUw6dI3RYu8tbYvLu+awWSw//o/JYt3r9ywOnB7n721k8di8Qsvj8tlSj02r
        Otk8Pj69xeLRt2UVo8fnTXIe7Qe6mQI4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4BuU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
        mBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZzyavo+5oI+t4uiMKSwNjAdZuxg5OSQETCReXf7O
        3MXIxSEksINR4sS+c+xdjBwcvAKCEn93CIPUCAuESCzY9YEJxBYSUJI4t2YWI0TcQKLldhsL
        iM0moCex4/ludhBbRMBUYvKnrWwgNrPAfSaJdVvNIHbxSsxof8oCYUtLbF++FWwOp4CxxNRd
        q6Du0ZD4sayXGcIWlbi5+i07jP3+2HxGCFtEovXeWagaQYkHP3dDxSUlDh36ygZyvoRAvsSG
        A4EQ4RqJtl/vocr1Ja51bAQ7gVfAV+Jkxyswm0VAVaJ1czsTRI2LxNqdnewQ52tLLFv4mhlk
        JLOApsT6XfoQ05Uljtxigajgk+g4/Jcd5sGGjb+xsnfMe8IE0aomsajJaAKj8ixEKM9CsmoW
        wqoFjMyrGMVSC4pz01OTjQoM4RGbnJ+7iRGcRLWcdzBemf9P7xAjEwfjIUYJDmYlEV7b4Esp
        QrwpiZVVqUX58UWlOanFhxhNgZ6cyCwlmpwPTON5JfGGJpYGJmZmhuZGpgbmSuK891rnpggJ
        pCeWpGanphakFsH0MXFwSjUwWQTMsLt2vKDb6dbs49qOD5iT8uIvCEcpvj2gaHuO+2THt2+n
        b6XvepxVYHLbnvOzdF6x3Pl76QZVp6KfH3byfKzQu/e0j1mQJZtEj9CMevk1UxjjGd8uqlac
        kqy3zHlZ48Mp1QcEbiq6JaSLtNa+a7R35Klfyy8y2X96ANPexDbVpluW4o5X1T6duNHCLp6T
        rbwzJsw24NtRcyv+0luSsx8u53dk/vn2b5xdXFq3gJ7UC6kDkY+fRgakmV8s9Erus9gYaBdj
        77ajJm/TvH2fGd8UXlzgH8L/puUCx45NMb/SKg5cZDmjfmCq+b9JNf9+TLPXTv/ionxq1dnt
        F0IOOXDdf/4/cOdNbY/mqEVKLMUZiYZazEXFiQCdkxh8KwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524
References: <yq1y1ijho3e.fsf@ca-mkp.ca.oracle.com>
        <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
        <yq1zg31hubf.fsf@ca-mkp.ca.oracle.com>
        <CGME20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p8>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Martin.

> Jinyoung,
>=20
> > This looks OK to me. I'll test on physical SCSI hardware tomorrow to
> > make sure there are no regressions.
>=20
> Lab test complete, no regressions seen.
>=20
> Tested-by: Martin K. Petersen <martin.petersen=40oracle.com>
>=20
> --=20
> Martin K. Petersen =C2=A0=20=C2=A0=20=C2=A0=20=C2=A0Oracle=20Linux=20Engi=
neering=0D=0A=0D=0AI=20uploaded=20only=20the=20parts=20that=20would=20not=
=20be=20a=20problem=20in=20the=20patch-set=0D=0AI=20prepared=20for=20the=20=
first=20time.=0D=0A=0D=0AI=20will=20prepare=20to=20make=20good=20use=20of=
=20the=20nr_integrity_segments=20in=20the=0D=0Arequest=20structure.=0D=0A=
=0D=0AThank=20you=20for=20your=20time.=0D=0AHave=20a=20nice=20day=21=0D=0A=
=0D=0AKind=20Regards,=0D=0AJinyoung.
