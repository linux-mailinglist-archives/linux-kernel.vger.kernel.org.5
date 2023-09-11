Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC69D79A489
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjIKHbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjIKHbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:31:36 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D95CD8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:31:27 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230911073125epoutp020ce1a32f711f8d9f9e9d37172a4b43d0~Dx7nXopar1094610946epoutp02g
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:31:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230911073125epoutp020ce1a32f711f8d9f9e9d37172a4b43d0~Dx7nXopar1094610946epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694417485;
        bh=PVJbNLjMdAWO6UMAxqBfuhcqvRpqIpVr6bKrPrEQ9zo=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=Pqo1GFmFWvsL5Q2rxQjzn6uqs7AaFcV2nc7oxm1kMGaMtYc9bc5duwXdu7JSqwVs8
         /7JcPPA1QcDPKJsWSZVv2Cl7M4/v+TcgceLPl5EdVLmZ5ZGUoJpLFIpiw79AicnlGS
         nX3yE+33R+nLl9y4BdE8//MO+BYya9xAMC6A/Hks=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230911073125epcas2p28da8f7c1012a81fde5363fdfd8a4357d~Dx7monWRN2271822718epcas2p2Q;
        Mon, 11 Sep 2023 07:31:25 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Rkdgb6RGtz4x9QR; Mon, 11 Sep
        2023 07:31:23 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.79.08583.B42CEF46; Mon, 11 Sep 2023 16:31:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230911073123epcas2p10bdbfa9c2ea8ed1c8a1f9352e7ec0276~Dx7k5OqWW1137311373epcas2p1W;
        Mon, 11 Sep 2023 07:31:23 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230911073123epsmtrp11a908f0db5f2b0f8d256d5a577f042a6~Dx7k4bKS_2413124131epsmtrp1b;
        Mon, 11 Sep 2023 07:31:23 +0000 (GMT)
X-AuditID: b6c32a43-6f7ff70000002187-cd-64fec24bc928
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.56.18916.B42CEF46; Mon, 11 Sep 2023 16:31:23 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.38.105]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230911073122epsmtip2cf4e0f1a411779ec89d7d052967145b6~Dx7kpIzQu0189901899epsmtip2i;
        Mon, 11 Sep 2023 07:31:22 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <adrian.hunter@intel.com>, <sc.suh@samsung.com>,
        <hy50.seo@samsung.com>, <sh425.lee@samsung.com>,
        <kwangwon.min@samsung.com>, <junwoo80.lee@samsung.com>,
        <wkon.kim@samsung.com>
In-Reply-To: <1694051306-172962-1-git-send-email-kwmad.kim@samsung.com>
Subject: RE: [PATCH v4] ufs: poll pmc until another pa request is completed
Date:   Mon, 11 Sep 2023 16:31:22 +0900
Message-ID: <000701d9e481$f70738a0$e515a9e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHCOs06MSlmgDNb/VB40Dx452KEGwMC5LjvsCx3KrA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmua73oX8pBp/WGlmcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxa6/zUwWW2/sZLG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBabL31jceD3uHzF22PxnpdMHhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfR
        fqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0z
        B+h4JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGB
        kSlQYUJ2xuGnT5kKHkdWHHv2l7WBcXt4FyMnh4SAicTmC+9Yuxi5OIQEdjBK/Nm2igXC+cQo
        8ezRVVY4p3vtRUaYloV7V0IldjJKXHk5nx3CeckosW/BfyaQKjYBbYlpD3eDVYkI9DFLXFy2
        gAUkwSngLvFo32e2LkYODmEBb4kTPZYgJouAqsSr92A38QpYStyd3MsIYQtKnJz5BKyTGWjk
        soWvmSGOUJD4+XQZK0RcRGJ2ZxtYXETASmLVmglgL0gIXOGQ2PXwPRtEg4vEsumzoT4Qlnh1
        fAs7hC0l8bK/jR3kBgmBbIk9C8UgwhUSi6e9ZYGwjSVmPWtnBClhFtCUWL9LH6JaWeLILajL
        +CQ6Dv+FGsIr0dEmBNGoLPFr0mSonZISM2/egdrpIdFz6yzLBEbFWUh+nIXkx1lI/pqFsHcB
        I8sqRrHUguLc9NRkowJDeFQn5+duYgSnai3nHYxX5v/TO8TIxMF4iFGCg1lJhLfk0N8UId6U
        xMqq1KL8+KLSnNTiQ4ymwECfyCwlmpwPzBZ5JfGGJpYGJmZmhuZGpgbmSuK891rnpggJpCeW
        pGanphakFsH0MXFwSjUwZUUZym5tqbhws6hc3EL56eKHmx/8kDfLlO+tblS587/wdcI9869M
        zJJxsgEbwidk/0t5tanu+qsZld3br204U52Ycum3zaXDF5NWCL4pDF+kv3pTrsAihVidGSer
        5h9qOnw+9HXch2d8E3ZNDXx00eHLateolkyld+J9EnVft4Wn1exz6bTeuoq5bO2pu5siL6/6
        s95jy+XcA2m1t7+rPBcIeeSS5XNFS7a5dxJPdItjy8LChXZcWsWzT+/y3LbxQ/iUrbujUy5s
        tox+4coX/yK7oMhYgKc9Y7f3AcnpTfrOp2w4ch+lvT1lqMY54Wjl3/sZHc92G+VX237bnTln
        SmGyRZBW97OvK1+fmf/vmxJLcUaioRZzUXEiAFcvStReBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvK73oX8pBmufM1ucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBarFz9gsVh0YxuTxa6/zUwWW2/sZLG4vGsOm0X39R1sFsuP/2Oy
        6Lp7g9Fi6b+3LBabL31jceD3uHzF22PxnpdMHhMWHWD0+L6+g83j49NbLB59W1YxenzeJOfR
        fqCbKYAjissmJTUnsyy1SN8ugSvj3P5FbAVddhWNny+zNjBOMupi5OSQEDCRWLh3JWsXIxeH
        kMB2RolTzddYIRKSEid2PmeEsIUl7rccgSp6zijx8c01dpAEm4C2xLSHu8ESIgILmCWurV7K
        AlE1g1Hie28HE0gVp4C7xKN9n9m6GDk4hAW8JU70WIKYLAKqEq/eh4NU8ApYStyd3MsIYQtK
        nJz5hAXEZgaa3/uwlRHGXrbwNTPEQQoSP58uY4WIi0jM7mwDi4sIWEmsWjOBZQKj0Cwko2Yh
        GTULyahZSNoXMLKsYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/dxAiOTa2gHYzL1v/VO8TIxMF4
        iFGCg1lJhLfk0N8UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzKOZ0pQgLpiSWp2ampBalFMFkm
        Dk6pBibd4/zqjEffLS18PW9blq3cQobwaKtJrNkmcx49jTwcL3y0Ufj/QrkffrK21VN0Nrnd
        vlGnGri03vH1tT1SX8W+n31owH80W+RgZfWxC1u+fyxvXM/jyyw5jbku8HXejNdflyQs4Nu2
        enfP+i9pVQv6jG7cX6h40NArRbLkp2qm/JaO+pPHHju/sK/6GjKRTaWyQ7Lrc57pvSidoKn/
        zBY5WV9rcLBL+GPUHxV74PSlI1ujFi+1F6zpSunxKY95oHv0WvKOG4sz/i01uddyT/VvvFXT
        Yb3cDO0Io69PDJpi+6NdH6sfWLt2zqk5/CmHhbkz2T0uHOxh2sN0/YioueQ8s3xJ0TDjJ3u+
        VxbHzFdiKc5INNRiLipOBACqkBK8PAMAAA==
X-CMS-MailID: 20230911073123epcas2p10bdbfa9c2ea8ed1c8a1f9352e7ec0276
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230907015925epcas2p3b9850bb03126e9caa43530e164884ae8
References: <CGME20230907015925epcas2p3b9850bb03126e9caa43530e164884ae8@epcas2p3.samsung.com>
        <1694051306-172962-1-git-send-email-kwmad.kim@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=40 , =EC=95=88=EB=85=95=ED=95=98=EC=84=B8=EC=9A=94.=0D=0A=0D=0A=0D=0AThank=
s.=0D=0AKiwoong=20Kim=0D=0A=0D=0A=0D=0A>=20-----Original=20Message-----=0D=
=0A>=20From:=20Kiwoong=20Kim=20<kwmad.kim=40samsung.com>=0D=0A>=20Sent:=20T=
hursday,=20September=207,=202023=2010:48=20AM=0D=0A>=20To:=20linux-scsi=40v=
ger.kernel.org;=20linux-kernel=40vger.kernel.org;=0D=0A>=20alim.akhtar=40sa=
msung.com;=20avri.altman=40wdc.com;=20bvanassche=40acm.org;=0D=0A>=20jejb=
=40linux.ibm.com;=20martin.petersen=40oracle.com;=20beanhuo=40micron.com;=
=0D=0A>=20adrian.hunter=40intel.com;=20sc.suh=40samsung.com;=20hy50.seo=40s=
amsung.com;=0D=0A>=20sh425.lee=40samsung.com;=20kwangwon.min=40samsung.com;=
=20junwoo80.lee=40samsung.com;=0D=0A>=20wkon.kim=40samsung.com=0D=0A>=20Cc:=
=20Kiwoong=20Kim=20<kwmad.kim=40samsung.com>=0D=0A>=20Subject:=20=5BPATCH=
=20v4=5D=20ufs:=20poll=20pmc=20until=20another=20pa=20request=20is=20comple=
ted=0D=0A>=20=0D=0A>=20Regarding=205.7.12.1.1=20in=20Unipro=20v1.8,=20PA=20=
rejects=20sebsequent=20requests=0D=0A>=20following=20the=20first=20request=
=20from=20upper=20layer=20or=20remote.=0D=0A>=20In=20this=20situation,=20PA=
=20responds=20w/=20BUSY=20in=20cases=20when=20they=20come=20from=20upper=0D=
=0A>=20layer=20and=20does=20nothing=20for=20the=20requests.=20So=20HCI=20do=
esn't=20receive=20ind,=20a.k.a.=0D=0A>=20indicator=20for=20its=20requests=
=20and=20an=20interrupt,=20IS.UPMS=20isn't=20generated.=0D=0A>=20=0D=0A>=20=
When=20LINERESET=20occurs,=20the=20error=20handler=20issues=20PMC=20which=
=20is=20recognized=20as=0D=0A>=20a=20request=20for=20PA.=20If=20a=20host's=
=20PA=20gets=20or=20raises=20LINERESET,=20and=20a=20request=0D=0A>=20for=20=
PMC,=20this=20could=20be=20a=20concurrent=20situation=20mentioned=20above.=
=20And=20I=20found=0D=0A>=20that=20situation=20w/=20my=20environment.=0D=0A=
>=20=0D=0A>=20=5B=20=20222.929539=5DI=5B0:DefaultDispatch:20410=5D=20exynos=
-ufs=2013500000.ufs:=0D=0A>=20ufshcd_update_uic_error:=20uecdl=20:=200x8000=
0002=20=5B=20=20222.999009=5DI=5B0:=0D=0A>=20arch_disk_io_1:20413=5D=20exyn=
os-ufs=2013500000.ufs:=20ufshcd_update_uic_error:=0D=0A>=20uecpa=20:=200x80=
000010=20=5B=20=20222.999200=5D=20=5B6:=20=20kworker/u16:2:=20=20132=5D=20e=
xynos-ufs=0D=0A>=2013500000.ufs:=20ufs_pwr_mode_restore_needed=20:=20mode=
=20=3D=200x15,=20pwr_rx=20=3D=201,=0D=0A>=20pwr_tx=20=3D=201=20=5B=20=20223=
.002876=5DI=5B0:=20arch_disk_io_3:20422=5D=20exynos-ufs=0D=0A>=2013500000.u=
fs:=20ufshcd_update_uic_error:=20uecpa=20:=200x80000010=20=5B=20=20223.5010=
50=5D=0D=0A>=20=5B4:=20=20kworker/u16:2:=20=20132=5D=20exynos-ufs=201350000=
0.ufs:=20pwr=20ctrl=20cmd=200x2=20with=0D=0A>=20mode=200x11=20completion=20=
timeout=20=5B=20=20223.502305=5D=20=5B4:=20=20kworker/u16:2:=20=20132=5D=0D=
=0A>=20exynos-ufs=2013500000.ufs:=20ufshcd_change_power_mode:=20power=20mod=
e=20change=0D=0A>=20failed=20-110=20=5B=20=20223.502312=5D=20=5B4:=20=20kwo=
rker/u16:2:=20=20132=5D=20exynos-ufs=0D=0A>=2013500000.ufs:=20ufshcd_err_ha=
ndler:=20Failed=20to=20restore=20power=20mode,=20err=20=3D=20-110=0D=0A>=20=
=5B=20=20223.502392=5D=20=5B4:=20=20kworker/u16:2:=20=20132=5D=20exynos-ufs=
=2013500000.ufs:=0D=0A>=20ufshcd_is_pwr_mode_restore_needed=20:=20mode=20=
=3D=200x11,=20pwr_rx=20=3D=201,=20pwr_tx=20=3D=201=0D=0A>=20=0D=0A>=20This=
=20patch=20is=20to=20poll=20PMC's=20result=20w/o=20checking=20its=20ind=20u=
ntil=20the=20result=0D=0A>=20is=20not=20busy,=20i.e.=2009h,=20to=20avoid=20=
the=20rejection.=0D=0A>=20=0D=0A>=20And=20this=20patch=20requires=20the=20f=
ollowing=20patch=20because=20it=20assumes=0D=0A>=20__ufshcd_send_uic_cmd=20=
doesn't=20require=20host_lock.=0D=0A>=20https://lore.kernel.org/linux-=0D=
=0A>=20scsi/bec84ee1ce8f5c5971b98d8e501aeabb9b5b26d1.1686716811.git.kwmad.k=
im=40sam=0D=0A>=20sung.com/=0D=0A>=20=0D=0A>=20Signed-off-by:=20Kiwoong=20K=
im=20<kwmad.kim=40samsung.com>=0D=0A>=20=0D=0A>=20---=0D=0A>=20v3=20->=20v4=
=0D=0A>=201)=20change=20description=0D=0A>=20=0D=0A>=20v2=20->=20v3=0D=0A>=
=201)=20check=20time=20in=20the=20loop=20with=20jiffies,=20instead=20of=20m=
iliseconds.=0D=0A>=202)=20change=20a=20variable's=20name=20and=20fix=20a=20=
typo=20and=20wrong=20alignment.=0D=0A>=20=0D=0A>=20v1=20->=20v2=0D=0A>=201)=
=20remove=20clearing=20hba->active_uic_cmd=20at=20the=20end=20of=20__ufshcd=
_poll_uic_pwr=0D=0A>=202)=20change=20commit=20message=20on=20the=20cited=20=
clause:=205.7.12.11=20->=205.7.12.1.1=0D=0A>=203)=20add=20mdelay=20to=20avo=
id=20too=20many=20issueing=0D=0A>=204)=20change=20the=20timeout=20for=20the=
=20polling=20to=20100ms=20because=20I=20found=20it=0D=0A>=20sometimes=20tak=
es=20much=20longer=20than=20expected.=0D=0A>=20=0D=0A>=20Signed-off-by:=20K=
iwoong=20Kim=20<kwmad.kim=40samsung.com>=0D=0A>=20---=0D=0A>=20=20drivers/u=
fs/core/ufshcd.c=20=7C=2093=20+++++++++++++++++++++++++++++++++---------=0D=
=0A>=20-----=0D=0A>=20=201=20file=20changed,=2065=20insertions(+),=2028=20d=
eletions(-)=0D=0A>=20=0D=0A>=20diff=20--git=20a/drivers/ufs/core/ufshcd.c=
=20b/drivers/ufs/core/ufshcd.c=20index=0D=0A>=207bc3fc4..f6b8659=20100644=
=0D=0A>=20---=20a/drivers/ufs/core/ufshcd.c=0D=0A>=20+++=20b/drivers/ufs/co=
re/ufshcd.c=0D=0A>=20=40=40=20-98,6=20+98,9=20=40=40=0D=0A>=20=20/*=20Polli=
ng=20time=20to=20wait=20for=20fDeviceInit=20*/=20=20=23define=0D=0A>=20FDEV=
ICEINIT_COMPL_TIMEOUT=201500=20/*=20millisecs=20*/=0D=0A>=20=0D=0A>=20+/*=
=20Polling=20time=20to=20wait=20until=20PA=20is=20ready=20*/=0D=0A>=20+=23d=
efine=20UIC_PA_RDY_TIMEOUT=09100=09/*=20millisecs=20*/=0D=0A>=20+=0D=0A>=20=
=20/*=20UFSHC=204.0=20compliant=20HC=20support=20this=20mode.=20*/=20=20sta=
tic=20bool=20use_mcq_mode=0D=0A>=20=3D=20true;=0D=0A>=20=0D=0A>=20=40=40=20=
-4120,6=20+4123,62=20=40=40=20int=20ufshcd_dme_get_attr(struct=20ufs_hba=20=
*hba,=20u32=0D=0A>=20attr_sel,=20=20=7D=20=20EXPORT_SYMBOL_GPL(ufshcd_dme_g=
et_attr);=0D=0A>=20=0D=0A>=20+static=20int=20__ufshcd_poll_uic_pwr(struct=
=20ufs_hba=20*hba,=20struct=20uic_command=0D=0A>=20*cmd,=0D=0A>=20+=09=09st=
ruct=20completion=20*cnf)=0D=0A>=20+=7B=0D=0A>=20+=09unsigned=20long=20flag=
s;=0D=0A>=20+=09int=20ret;=0D=0A>=20+=09u32=20mode=20=3D=20cmd->argument3;=
=0D=0A>=20+=09unsigned=20long=20deadline=20=3D=20jiffies=20+=0D=0A>=20+=09=
=09msecs_to_jiffies(UIC_PA_RDY_TIMEOUT);=0D=0A>=20+=0D=0A>=20+=09do=20=7B=
=0D=0A>=20+=09=09spin_lock_irqsave(hba->host->host_lock,=20flags);=0D=0A>=
=20+=09=09hba->active_uic_cmd=20=3D=20NULL;=0D=0A>=20+=09=09if=20(ufshcd_is=
_link_broken(hba))=20=7B=0D=0A>=20+=09=09=09spin_unlock_irqrestore(hba->hos=
t->host_lock,=20flags);=0D=0A>=20+=09=09=09ret=20=3D=20-ENOLINK;=0D=0A>=20+=
=09=09=09goto=20out;=0D=0A>=20+=09=09=7D=0D=0A>=20+=09=09hba->uic_async_don=
e=20=3D=20cnf;=0D=0A>=20+=09=09spin_unlock_irqrestore(hba->host->host_lock,=
=20flags);=0D=0A>=20+=0D=0A>=20+=09=09cmd->argument2=20=3D=200;=0D=0A>=20+=
=09=09cmd->argument3=20=3D=20mode;=0D=0A>=20+=09=09ret=20=3D=20__ufshcd_sen=
d_uic_cmd(hba,=20cmd,=20true);=0D=0A>=20+=09=09if=20(ret)=20=7B=0D=0A>=20+=
=09=09=09dev_err(hba->dev,=0D=0A>=20+=09=09=09=09=22pwr=20ctrl=20cmd=200x%x=
=20with=20mode=200x%x=20uic=0D=0A>=20error=20%d=5Cn=22,=0D=0A>=20+=09=09=09=
=09cmd->command,=20cmd->argument3,=20ret);=0D=0A>=20+=09=09=09goto=20out;=
=0D=0A>=20+=09=09=7D=0D=0A>=20+=0D=0A>=20+=09=09/*=20This=20value=20is=20he=
uristic=20*/=0D=0A>=20+=09=09if=20(=21wait_for_completion_timeout(&cmd->don=
e,=0D=0A>=20+=09=09=09=09=09=09=20msecs_to_jiffies(5)))=20=7B=0D=0A>=20+=09=
=09=09ret=20=3D=20-ETIMEDOUT;=0D=0A>=20+=09=09=09dev_err(hba->dev,=0D=0A>=
=20+=09=09=09=09=22pwr=20ctrl=20cmd=200x%x=20with=20mode=200x%x=20timeout=
=5Cn=22,=0D=0A>=20+=09=09=09=09cmd->command,=20cmd->argument3);=0D=0A>=20+=
=09=09=09if=20(cmd->cmd_active)=0D=0A>=20+=09=09=09=09goto=20out;=0D=0A>=20=
+=0D=0A>=20+=09=09=09dev_info(hba->dev,=20=22%s:=20pwr=20ctrl=20cmd=20has=
=20already=20been=0D=0A>=20completed=5Cn=22,=20__func__);=0D=0A>=20+=09=09=
=7D=0D=0A>=20+=0D=0A>=20+=09=09/*=20retry=20only=20for=20busy=20cases=20*/=
=0D=0A>=20+=09=09ret=20=3D=20cmd->argument2=20&=20MASK_UIC_COMMAND_RESULT;=
=0D=0A>=20+=09=09if=20(ret=20=21=3D=20UIC_CMD_RESULT_BUSY)=0D=0A>=20+=09=09=
=09break;=0D=0A>=20+=0D=0A>=20+=09=09dev_info(hba->dev,=20=22%s:=20PA=20is=
=20busy=20and=20can't=20handle=20a=0D=0A>=20requeest,=20%d=5Cn=22,=20__func=
__,=20ret);=0D=0A>=20+=09=09mdelay(1);=0D=0A>=20+=0D=0A>=20+=09=7D=20while=
=20(time_before(jiffies,=20deadline));=0D=0A>=20+out:=0D=0A>=20+=09return=
=20ret;=0D=0A>=20+=7D=0D=0A>=20+=0D=0A>=20=20/**=0D=0A>=20=20=20*=20ufshcd_=
uic_pwr_ctrl=20-=20executes=20UIC=20commands=20(which=20affects=20the=20lin=
k=0D=0A>=20power=0D=0A>=20=20=20*=20state)=20and=20waits=20for=20it=20to=20=
take=20effect.=0D=0A>=20=40=40=20-4142,33=20+4201,13=20=40=40=20static=20in=
t=20ufshcd_uic_pwr_ctrl(struct=20ufs_hba=20*hba,=0D=0A>=20struct=20uic_comm=
and=20*cmd)=0D=0A>=20=20=09unsigned=20long=20flags;=0D=0A>=20=20=09u8=20sta=
tus;=0D=0A>=20=20=09int=20ret;=0D=0A>=20-=09bool=20reenable_intr=20=3D=20fa=
lse;=0D=0A>=20=0D=0A>=20-=09mutex_lock(&hba->uic_cmd_mutex);=0D=0A>=20-=09u=
fshcd_add_delay_before_dme_cmd(hba);=0D=0A>=20-=0D=0A>=20-=09spin_lock_irqs=
ave(hba->host->host_lock,=20flags);=0D=0A>=20-=09if=20(ufshcd_is_link_broke=
n(hba))=20=7B=0D=0A>=20-=09=09ret=20=3D=20-ENOLINK;=0D=0A>=20-=09=09goto=20=
out_unlock;=0D=0A>=20-=09=7D=0D=0A>=20-=09hba->uic_async_done=20=3D=20&uic_=
async_done;=0D=0A>=20-=09if=20(ufshcd_readl(hba,=20REG_INTERRUPT_ENABLE)=20=
&=20UIC_COMMAND_COMPL)=20=7B=0D=0A>=20-=09=09ufshcd_disable_intr(hba,=20UIC=
_COMMAND_COMPL);=0D=0A>=20-=09=09/*=0D=0A>=20-=09=09=20*=20Make=20sure=20UI=
C=20command=20completion=20interrupt=20is=20disabled=0D=0A>=20before=0D=0A>=
=20-=09=09=20*=20issuing=20UIC=20command.=0D=0A>=20-=09=09=20*/=0D=0A>=20-=
=09=09wmb();=0D=0A>=20-=09=09reenable_intr=20=3D=20true;=0D=0A>=20-=09=7D=
=0D=0A>=20-=09spin_unlock_irqrestore(hba->host->host_lock,=20flags);=0D=0A>=
=20-=09ret=20=3D=20__ufshcd_send_uic_cmd(hba,=20cmd,=20false);=0D=0A>=20+=
=09ret=20=3D=20__ufshcd_poll_uic_pwr(hba,=20cmd,=20&uic_async_done);=0D=0A>=
=20=20=09if=20(ret)=20=7B=0D=0A>=20-=09=09dev_err(hba->dev,=0D=0A>=20-=09=
=09=09=22pwr=20ctrl=20cmd=200x%x=20with=20mode=200x%x=20uic=20error=20%d=5C=
n=22,=0D=0A>=20-=09=09=09cmd->command,=20cmd->argument3,=20ret);=0D=0A>=20-=
=09=09goto=20out;=0D=0A>=20+=09=09if=20(ret=20=3D=3D=20-ENOLINK)=0D=0A>=20+=
=09=09=09goto=20out_unlock;=0D=0A>=20+=09=09else=0D=0A>=20+=09=09=09goto=20=
out;=0D=0A>=20=20=09=7D=0D=0A>=20=0D=0A>=20=20=09if=20(=21wait_for_completi=
on_timeout(hba->uic_async_done,=0D=0A>=20=40=40=20-4205,14=20+4244,12=20=40=
=40=20static=20int=20ufshcd_uic_pwr_ctrl(struct=20ufs_hba=20*hba,=0D=0A>=20=
struct=20uic_command=20*cmd)=0D=0A>=20=20=09spin_lock_irqsave(hba->host->ho=
st_lock,=20flags);=0D=0A>=20=20=09hba->active_uic_cmd=20=3D=20NULL;=0D=0A>=
=20=20=09hba->uic_async_done=20=3D=20NULL;=0D=0A>=20-=09if=20(reenable_intr=
)=0D=0A>=20-=09=09ufshcd_enable_intr(hba,=20UIC_COMMAND_COMPL);=0D=0A>=20=
=20=09if=20(ret)=20=7B=0D=0A>=20=20=09=09ufshcd_set_link_broken(hba);=0D=0A=
>=20=20=09=09ufshcd_schedule_eh_work(hba);=0D=0A>=20=20=09=7D=0D=0A>=20-out=
_unlock:=0D=0A>=20=20=09spin_unlock_irqrestore(hba->host->host_lock,=20flag=
s);=0D=0A>=20+out_unlock:=0D=0A>=20=20=09mutex_unlock(&hba->uic_cmd_mutex);=
=0D=0A>=20=0D=0A>=20=20=09return=20ret;=0D=0A>=20--=0D=0A>=202.7.4=0D=0A=0D=
=0A=0D=0A
