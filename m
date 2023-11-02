Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9697DEBA2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348399AbjKBEHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348387AbjKBEHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:07:46 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5E8127
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 21:07:39 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231102040733epoutp01b632c2358c48f6c62c06a060665f5869~Tssdlsg4T0548905489epoutp016
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:07:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231102040733epoutp01b632c2358c48f6c62c06a060665f5869~Tssdlsg4T0548905489epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698898053;
        bh=b0X8nfNxem9JetzRHwX5y/FRL/0G/2uEZ8HwSBZ8HDo=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=VfJXaeWB2Pr+HBBtBt8/U9O4FvERaOnDtPweAqJaasl/jMGEK0KAhODCzH3Z+K8uo
         lI4qaEKpQfxuq4Ay3q9GSsA3drz390qnaybIihJTVYgkNvjfqNOVHYEfDtYV4INqVA
         YFif0xG0GJ39M9OAR0Ki7hcGwguP2rlbd9/8MDwg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231102040733epcas2p1d7a3e7e448683a9406d00fcc74af85b2~TssdGdeAg0295302953epcas2p1s;
        Thu,  2 Nov 2023 04:07:33 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SLVhN4WjZz4x9Pr; Thu,  2 Nov
        2023 04:07:32 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.26.08648.48023456; Thu,  2 Nov 2023 13:07:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231102040732epcas2p4b725fde7d65e0569f7ff5b9809140c43~Tssb81lGL2090720907epcas2p4U;
        Thu,  2 Nov 2023 04:07:32 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231102040732epsmtrp2d797d4a1fd97c31b8e9bb020b652dad3~Tssb7V_kU1194411944epsmtrp2W;
        Thu,  2 Nov 2023 04:07:32 +0000 (GMT)
X-AuditID: b6c32a43-4b3ff700000021c8-4f-6543208483d9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.93.07368.38023456; Thu,  2 Nov 2023 13:07:32 +0900 (KST)
Received: from KORCO118546 (unknown [10.229.38.108]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231102040731epsmtip11ed5b0085c6a9a98da6de5f58451571e~TssbtBr0r0643906439epsmtip1e;
        Thu,  2 Nov 2023 04:07:31 +0000 (GMT)
From:   "hoyoung seo" <hy50.seo@samsung.com>
To:     "'Bart Van Assche'" <bvanassche@acm.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <beanhuo@micron.com>, <kwangwon.min@samsung.com>,
        <kwmad.kim@samsung.com>, <sh425.lee@samsung.com>,
        <sc.suh@samsung.com>, <quic_nguyenb@quicinc.com>,
        <cpgs@samsung.com>
In-Reply-To: <e1ed8776-d8ad-49f2-bf8f-2759256e33e9@acm.org>
Subject: RE: [PATCH v1] scsi: ufs: core: Process abort completed command in
 MCQ mode
Date:   Thu, 2 Nov 2023 13:07:31 +0900
Message-ID: <000001da0d42$1a1c8410$4e558c30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI/NadRec19V/jm3RVDFrtg0RqXhwIoHnBGAuFKLQmvc6/hoA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmuW6LgnOqweEeBYsH87axWbz8eZXN
        4uDDThaLaR9+Mlu8PKRpsejGNiaLrTd2sljc3HKUxeLyrjlsFt3Xd7BZLD/+j8li6ovj7BZd
        d28wWiz995bFgc/j8hVvjwmLDjB6fF/fwebx8ektFo+Je+o8+rasYvT4vEnOo/1AN1MAR1S2
        TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7Q1UoKZYk5
        pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IwX
        068wFuxVrDiyrZutgXGTbBcjJ4eEgInE6mVT2EFsIYEdjBKHN8R0MXIB2Z8YJU4fameFcL4x
        SrydcpYZpmPetC0sEIm9jBKXdy5lhWh/ySgx+YcGiM0moCXR/3YLG0iRiEALs8SrB1vAdnAK
        WEsc3DQXbJKwQJjEvZ/HmEBsFgEViVUX1wMN4uDgFbCUWHQQbA6vgKDEyZlPWEBsZgFtiWUL
        X0MdoSDx8+kysL0iAk4S7T9XsUHUiEjM7mxjBtkrIXCFQ2LdzWdMEA0uEneevGWFsIUlXh2H
        uEdCQEri87u9bBB2tkTjnrVQ8QqJuZsnM0LYxhKznrUzgtzGLKApsX6XPogpIaAsceQW1Gl8
        Eh2H/0J18ko0bPzNDlHCK9HRJgQRVpI4M/c2VFhC4uDsnAmMSrOQ/DgLyY+zkPwyC2HtAkaW
        VYxiqQXFuempyUYFhvCYTs7P3cQITs1azjsYr8z/p3eIkYmD8RCjBAezkgjvYVOHVCHelMTK
        qtSi/Pii0pzU4kOMpsBAn8gsJZqcD8wOeSXxhiaWBiZmZobmRqYG5krivPda56YICaQnlqRm
        p6YWpBbB9DFxcEo1MIkH6nQ8r3jx8X3Xvfli5/xDxG5xsLPUb0yutPEqyL4tmKn59LqOc93a
        08rdbALqHNbXCjdPvr1y4enkk35cIssP5V85We98ZsGSow+MfgRECSq57Ji0Nn39B+cvRUte
        qzLtZnXfGmp62D90XdN7Rs5v795KijRPNnzo7+m8zZb/YI+79VWWfamXlQQF7A4zzPLcOJfN
        41Do7b67x6IDX0a3MPVv1Np2Ib/bSmjVInE3H3a1xi+OWffUnCvbm96lrSvlz9v/85CmhHaq
        +nStVUf4lsgfK/x/7WJYqfDvVyvmJYn+3G7+zOti7eTdrx/bbV2u8vwk1yS9nbz6sw4l/Gf8
        cW8RS1TQybQtSatyliqxFGckGmoxFxUnAgCznbD6VgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSnG6LgnOqwetPTBYP5m1js3j58yqb
        xcGHnSwW0z78ZLZ4eUjTYtGNbUwWW2/sZLG4ueUoi8XlXXPYLLqv72CzWH78H5PF1BfH2S26
        7t5gtFj67y2LA5/H5SveHhMWHWD0+L6+g83j49NbLB4T99R59G1ZxejxeZOcR/uBbqYAjigu
        m5TUnMyy1CJ9uwSujL8dE5gKLstUbN3ynb2B8Z1YFyMnh4SAicS8aVtYuhi5OIQEdjNKnGye
        wgaRkJD4v7iJCcIWlrjfcoQVoug5o8TMQ0vBEmwCWhL9b7ewgSREBKYwS3xYuJ4ZomoXo8SB
        aR3sIFWcAtYSBzfNZQaxhQVCJLY2rgLrZhFQkVh1cT3QWA4OXgFLiUUHNUDCvAKCEidnPmEB
        sZkFtCWe3nwKZy9b+JoZ4iIFiZ9Pl7GC2CICThLtP1exQdSISMzubGOewCg0C8moWUhGzUIy
        ahaSlgWMLKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYLjUktjB+O9+f/0DjEycTAe
        YpTgYFYS4T1s6pAqxJuSWFmVWpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0xJLU7NTUgtQimCwT
        B6dUA5P16ktpsQZL082sn9zwWL14rbgAv3dVl8jaMM1X9q/faQXPXeh+cfcEM4aYBLH6WS9+
        2Lb//uoZLHbCoIMhzdF9p6X0/23NWtfsJvOecnN9Kj77452AO4pb+E/sujS36q1lnYXA3Qu5
        e4JCJZkbxJRfKlz0DGS6dURVXXCV/LVVF/OeWM9LuB1lG9ozseS+odqtLpbfB5Kc5Hn+Twn+
        tev+Ae9kpjmyGtf3W++2FJ8hp+7K37E/0K41uf1AfcaEjSkbFv3p8U+eEzHds3jHn5TNpyYv
        ju5oXZzV87l4xtTPSQ1/T2kJ3+K4+0zaffJ1Ad+l21KW3//SW9q7ID/o7LuY/iePHpwts+48
        98UxMVKJpTgj0VCLuag4EQDEzal3OgMAAA==
X-CMS-MailID: 20231102040732epcas2p4b725fde7d65e0569f7ff5b9809140c43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101084246epcas2p32ae15219878d1c31e7d8a14c22489519
References: <CGME20231101084246epcas2p32ae15219878d1c31e7d8a14c22489519@epcas2p3.samsung.com>
        <20231101084504.79087-1-hy50.seo@samsung.com>
        <e1ed8776-d8ad-49f2-bf8f-2759256e33e9@acm.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Bart Van Assche <bvanassche=40acm.org>
> Sent: Thursday, November 2, 2023 1:39 AM
> To: SEO HOYOUNG <hy50.seo=40samsung.com>; linux-scsi=40vger.kernel.org; l=
inux-
> kernel=40vger.kernel.org; alim.akhtar=40samsung.com; avri.altman=40wdc.co=
m;
> jejb=40linux.ibm.com; martin.petersen=40oracle.com; beanhuo=40micron.com;
> kwangwon.min=40samsung.com; kwmad.kim=40samsung.com; sh425.lee=40samsung.=
com;
> sc.suh=40samsung.com; quic_nguyenb=40quicinc.com; cpgs=40samsung.com
> Subject: Re: =5BPATCH v1=5D scsi: ufs: core: Process abort completed comm=
and
> in MCQ mode
>=20
> On 11/1/23 01:45, SEO HOYOUNG wrote:
> > In MCQ mode, the case where OCS is updated to aborted is as follows
> >   1. when abort processing is completed
> >   2. When a duplicate command occurs
>=20
> What is a =22duplicate command=22? The UFSHCI driver guarantees that each=
 SCSI
> command has a unique tag.
>=20
> > In case of 1 situation, cmd should be re-request.
>=20
> It should be resubmitted by the SCSI error handler. The UFSHCI driver doe=
s
> not have to request this explicitly. See also the code at the end of
> scmd_eh_abort_handler().
>=20
> >   	case OCS_ABORTED:
> > -		result =7C=3D DID_ABORT << 16;
> > +		if (cqe)
> > +			eec =3D le32_to_cpu(cqe->status) & MASK_EEC;
> > +
> > +		if (is_mcq_enabled(hba) && =21eec)
> > +			result =7C=3D DID_REQUEUE << 16;
> > +		else
> > +			result =7C=3D DID_ABORT << 16;
> >   		break;
>=20
> I don't think this change is necessary. Additionally, introducing
> different behavior for MCQ compared to legacy mode in this code path is
> suspicious. Why should how commands are queued affect how aborts are
> processed?
>=20
> Thanks,
>=20
> Bart.

when the ufs host receives any error, the ufs driver executes the error-han=
der.
If the error-hendler attempts re-init, it must abort and organize unprocess=
ed
 requests.
The above operation is the same for both MCQ/legacy mode.
However, in the MCQ mode, if b or c is included in the following specs,=20
the OCS is updated to aborted, which is different from the legacy mode.

B. If the command is in the Submission Queue and not issued to the device y=
et,=20
the host controller will mark the command to be skipped in the Submission Q=
ueue.
The host controller will post to the Completion Queue to update the OCS fie=
ld=20
with =E2=80=98ABORTED=E2=80=99.=0D=0AC.=20If=20the=20command=20is=20issued=
=20to=20the=20device=20already=20but=20there=20is=20no=20response=20yet=20=
=0D=0Afrom=20the=20device,=20the=20host=20software=20driver=20issue=20the=
=20Abort=20task=20management=20function=0D=0A=20to=20the=20device=20for=20t=
hat=20command.=0D=0AThen=20the=20host=20driver=20set=20SQRTCy.ICU=20as=20=
=E2=80=981=E2=80=99=20to=20initiate=20the=20clean=20up=20the=20hardware=20=
=0D=0Aresources.=20The=20host=20controller=20will=20post=20to=20the=20Compl=
etion=20Queue=20to=20update=20the=20OCS=0D=0A=20field=20with=20=E2=80=98ABO=
RTED=E2=80=99.=0D=0A=0D=0AUnlike=20legacy=20mode,=20this=20phenomenon=20cau=
ses=20unintended=20behavior.=20(As=20shown=20in=20the=20log=20below)=0D=0A=
=0D=0A=5B1:=20=20kworker/u20:2:23157=5D=20ufshcd_try_to_abort_task:=20cmd=
=20pending=20in=20the=20device.=20tag=20=3D=209=0D=0A=5B3:=20=20kworker/u20=
:2:23157=5D=20Aborting=20tag=209=20/=20CDB=200x2a=20succeeded=0D=0A=5B4:=20=
=20=20=20=20=20swapper/4:=20=20=20=200=5D=20sd=200:0:0:0:=20=5Bsda=5D=20tag=
=239=20UNKNOWN(0x2003)=20Result:=20hostbyte=3D0x05=20driverbyte=3DDRIVER_OK=
=20cmd_age=3D0s=20//=20DID_ABORT=0D=0A=5B4:=20=20=20=20=20=20swapper/4:=20=
=20=20=200=5D=20sd=200:0:0:0:=20=5Bsda=5D=20tag=239=20CDB:=20opcode=3D0x2a=
=202a=2000=2000=20d3=2002=2000=2000=2001=2000=2000=0D=0A=5B4:=20=20=20=20=
=20=20swapper/4:=20=20=20=200=5D=20I/O=20error,=20dev=20sda,=20sector=20110=
628864=20op=200x1:(WRITE)=20flags=200x800=20phys_seg=20256=20prio=20class=
=202=0D=0A=0D=0A=0D=0AFor=20commands=20that=20have=20completed=20the=20abor=
t=20operation=20in=20MCQ=20mode,=0D=0Asince=20OCS=20has=20been=20updated=20=
to=20aborted,=20it=20seems=20that=20it=20will=20be=20retransmitted=20only=
=0D=0A=20when=20it=20is=20made=20to=20REQUEUE.=0D=0A=0D=0AThanks.=0D=0A=0D=
=0ASEO.=0D=0A=0D=0A
