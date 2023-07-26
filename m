Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E5E763660
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjGZMcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjGZMc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:32:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B71E61;
        Wed, 26 Jul 2023 05:32:19 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QC63rH025552;
        Wed, 26 Jul 2023 12:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=V482rUNBz4tTIra7kuTC3bWBRLk0bTH53l6xwHFMRjc=;
 b=QTPA6wbWn7DDJ8uzueWNWs5CgG3GtdO1v+6FKnsBU0jp5rW2RSsZ/PRQr2qFaX9bX5a2
 5vA9MaN3ivETmNLi8gqP8Mu2ijHrn5dZlvfE4+nQlDScyrDPCbtn5AcmiH6iJwJofrCN
 KeQYRbXebZAd3PSRektg4weeBMbEFSSicb/OEk0x9lb6oyPBivHSJ5JXXg6H/Rr/75B9
 7x1dIZzTputaAxmkyWJqpB0rCFQLbYk98CLiZMjU+50D+qKupSD8wIpRBm1AERl5oUoR
 jAp30C006LcUwPRKdXPbCSARg22dQGL7cql//xwYqRPq0QcyHXSijnajMAawPrpJo9/P og== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s336t018g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 12:32:13 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QCWDRb002272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 12:32:13 GMT
Received: from nasanex01a.na.qualcomm.com (10.52.223.231) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 05:32:12 -0700
Received: from nasanex01a.na.qualcomm.com ([fe80::482d:250d:70b6:e1c5]) by
 nasanex01a.na.qualcomm.com ([fe80::482d:250d:70b6:e1c5%12]) with mapi id
 15.02.1118.030; Wed, 26 Jul 2023 05:32:12 -0700
From:   "Naveen Kumar Goud Arepalli (QUIC)" <quic_narepall@quicinc.com>
To:     Andrew Halaney <ahalaney@redhat.com>
CC:     "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1] arm64: dts: qcom: sa8775p-ride: Remove min and max
 voltages for L8A
Thread-Topic: [PATCH V1] arm64: dts: qcom: sa8775p-ride: Remove min and max
 voltages for L8A
Thread-Index: AQHZvt7QYX0nSDdHt02LA98zFub0Fa/Le8CAgACAp6A=
Date:   Wed, 26 Jul 2023 12:32:12 +0000
Message-ID: <516a54da44724001895f7e50634ad884@quicinc.com>
References: <20230725100007.14775-1-quic_narepall@quicinc.com>
 <a3l7356miuuapf5dakgfchdjmxjp62ynvle4ta3hejd3tjvzd4@e2t2zm6jh7hb>
In-Reply-To: <a3l7356miuuapf5dakgfchdjmxjp62ynvle4ta3hejd3tjvzd4@e2t2zm6jh7hb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.44.194]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SFfrn_nuT72KcPszkf7lbYsfAdFtc54t
X-Proofpoint-GUID: SFfrn_nuT72KcPszkf7lbYsfAdFtc54t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 03:30:07PM +0530, Naveen Kumar Goud Arepalli wrote:
> L8A is the supply for UFS VCC, UFS specification allows different VCC=20
> configurations for UFS devices.
> -UFS 2.x devices: 2.70V - 3.60V
> -UFS 3.x devices: 2.40V - 2.70V
>=20
> As sa8775p-ride supports both ufs 2.x and ufs 3.x devices, remove=20
> min/max voltages for L8A regulator. Initial voltage of L8A will be set=20
> to 2.504v or 2.952v during PON depending on the UFS device type. On=20
> sa8775, UFS is the only client in Linux for L8A and this regulator=20
> will be voted only for enabling/disabling.
>=20
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts=20
> b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index ed76680410b4..6f3891a09e59 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -98,8 +98,6 @@
> =20
>  		vreg_l8a: ldo8 {
>  			regulator-name =3D "vreg_l8a";
> -			regulator-min-microvolt =3D <2504000>;
> -			regulator-max-microvolt =3D <3300000>;
>  			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>  			regulator-allow-set-load;
>  			regulator-allowed-modes =3D <RPMH_REGULATOR_MODE_LPM
> --
> 2.17.1
>=20

Reviewing with very little expertise in the area....
A few questions below that would help me understand this a bit better.

Does it make sense to *not* set the range of the regulator at all?:
>>> Yes, we are removing the range of the regulator.

    1. A board dts knows its UFS device
    2. Is UFS backwards compatible with respect to UFS2/UFS3?
       I don't know how the version is determined, but if it's a
       "start at UFS2, go to UFS3" should it be scaled as that goes?
       >>>> For a UFS device 3.x, we cannot start as UFS 2.0. vcc has to be=
 as per UFS 3.x recommendations.

Relying on the bootloader to set up the device before the kernel starts
seems like a direction that should be actively avoided instead of
depended on in my opinion.
>>>> As per upstream UFS driver,  voltage voting is not there and we vote o=
nly for enable/disable .=20
Since UFS is the only client in Linux for this rail (L8A ), we don't need m=
in and max range to support
UFS 2.x and 3.x cards.

Thanks,
Naveen
