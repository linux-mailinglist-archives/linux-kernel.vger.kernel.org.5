Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3A27C8D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjJMSnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMSnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:43:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB00C2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:43:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DIEXZ0030365;
        Fri, 13 Oct 2023 18:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+E0MzBtSntBC93dNWWKrJJ9omAIyOqik0e2QKbvdg1k=;
 b=bKaHSlf4MWUEZuCotJhKx3enlVKie0+9BP+47L5Vx7eVkRbYI9S+3FXzQ0noxWDZAS8P
 Mrr917v2tVwRInYjopknOehO18zC+OcjNV2RjcwRwHTbWPu2tUErR/fi+LJm62TEMPTJ
 5EJWuMR0UzQhNQ0JgrP2GnjiqeVXs5f3vR4rcDD72a8YKZ8T94McX727XCXP1cYg0J5/
 9vvXx3rC+G+4QFhDSW1Px+Q2yvz0uTpSqmp7a87dG9FSEoNzqXqX6scJDhC1pBmfVbpt
 vhBYqQtKNMvIlj2Q2P5ISdjUf2weG6GcPXAfbp/NH+wUrJSjS9XV7D+kXd5P0nbye8Fg xw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh912ypr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 18:42:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DH7CmI006128;
        Fri, 13 Oct 2023 18:42:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tptcss40a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 18:42:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjPuRE2q/5qG32keH1E9JQTKvunzwuZY2Tz3TfJj83AXLvcx/D3K/0c1KvaAZDRNfoJGH46PWTgsismlg9fkHV+UGcWSDefEQtH30VoLGKoFjW8dht9KnrG5SNEQfPuLP7I+bthT02Mthow/OyLqwVaw42iou7H2VDFBVqCnlY9ATEK6gGZrr5Jp7HaeyLJa3BMIT23ORxZG9pJ8EkOLhp0TFSkO0RJNwhsFFQPpJfTTPwuM/vDsSpyt2lAi1P3VnDd3BfytMjTDpw2Dh6aLCXLfBsRQg7BuODkPRRXeTXk+MXdJjYiZxXiR1AF6lP7J7umnFDPcC+R8ZUyGm+as3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E0MzBtSntBC93dNWWKrJJ9omAIyOqik0e2QKbvdg1k=;
 b=iJIly2HR/Qcyl+HimXWJxajDRxwZqwE86t2lm/PMhvuHDxNTCD3yL9p0VrnSk6LfNZQ1MrRXeuIWVDDNsDwoJ5X7EnivwrXw7q5l2HAy3rFqQHyH+xNvWM005mBUn/o4Xf75Ul/Ptcno96OqASWahpxj1wWh7c9bOljkKQa+Ql7t+706FxUXVyqu14bC+qzV1rIAyzAQ0Vn7bY23XJxKHYCI4YZT3LZSEqr/ADHeplab7En7nTjUNWaInVvYaxejreSl0ClLcveiy1hPyBdA1dl639gpSfAJRvvIlpn+wPkPfDS1DnOrC/5QC4TXHY/gm31sKbJJl7azPlp/o5oSNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E0MzBtSntBC93dNWWKrJJ9omAIyOqik0e2QKbvdg1k=;
 b=LiGDA0trq0RHrKIQtEbd8EWmLpsyajScHPKWoIQln98sWFsw/2pbCwpSuXXSSAxLcZFncpRaQnWXClCX6fDxepTOQNxsqmA0avROxFJbOVi9yIQKlhVNIt6BtD9lq4xljFPnskDDPnHO9H3zycmT6fSlGjuM9CeGgGwaAIwcoLU=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS0PR10MB7342.namprd10.prod.outlook.com (2603:10b6:8:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 18:42:43 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 18:42:43 +0000
From:   Miguel Luis <miguel.luis@oracle.com>
To:     Eric Auger <eric.auger@redhat.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jing Zhang <jingzhangos@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>
Subject: Re: [PATCH v3 2/3] arm64: Add missing _EL2 encodings
Thread-Topic: [PATCH v3 2/3] arm64: Add missing _EL2 encodings
Thread-Index: AQHZ/G0Pr4UHFXyzik2/jKxJUqxW5rBGLCMAgAHlCgA=
Date:   Fri, 13 Oct 2023 18:42:43 +0000
Message-ID: <F88A4039-A2D0-463C-925C-549EA31CBE0A@oracle.com>
References: <20231011180103.91774-1-miguel.luis@oracle.com>
 <20231011180103.91774-3-miguel.luis@oracle.com>
 <4c73e58f-13d3-7cb9-a706-b20ab7d2df18@redhat.com>
In-Reply-To: <4c73e58f-13d3-7cb9-a706-b20ab7d2df18@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|DS0PR10MB7342:EE_
x-ms-office365-filtering-correlation-id: 434054be-d9f6-410c-c610-08dbcc1c2fde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S2OCy6YWNazskt+eNC261aORHz3Ipr4ld54ios2r6ghYZRGNyoQgJ5I7CaGyALIsMGfJI/1xkmlLfGtHw7tLQ2XyRwbr9tWQq97g6lOWc+t1q9zHEsJSuzN6SXcQDcScnR9o95+smn8ZOz1Hu3nmHEAf4zkp10wMcj034aECxbPe2uTISTQ5DB9esxseWLDLZ8VaUN2X0y4x3GwrPwao7UOuWlAcF7avesaBcyJ7nDT3fp1WjygK4sfmyehkdXU5Obl4tK7DIKkjZFSpO78J71QkVFgsNBGgc6lOC9xxS1WFrmaE38dJQzyq961mYluiTAKNEpSEvX2IXpOb99jQ9rWkJlaLSIzuFTbeu/hQ35mhrmbhYZ3VMbtF/6mfX2131OVBIk68rfojyvuJXmZdZD+uM52e2hpWITPpqG7ebdCWaMzVgStlGRwh8uTlEimA9GF3YAxPgfYx3bF5UyKiByRr8tvQFt/XqT6RAivftbCobQPid0OrrhPXOpr6aZKCp7dCMlv7BSXxuxLAEYau3oU5+aAfeqyUkeUdicm4trjRn1FUBJ4TSTDG2/8enUk+XagaXZ2MrwTVsni+SY8Z/0Y+ifD8zPHoOhuDC/8ymvxMh5LgSyd4Ylu1y7fbjoOVtPVm4nR4MD6cmeFJl2/BdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(53546011)(6486002)(6512007)(54906003)(66556008)(76116006)(66946007)(66476007)(6916009)(2616005)(91956017)(64756008)(66446008)(71200400001)(478600001)(316002)(8936002)(8676002)(2906002)(4326008)(36756003)(38070700005)(122000001)(86362001)(5660300002)(41300700001)(44832011)(33656002)(7416002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pA45GekODeU+HPL22gh5fw5xh+VWuMIMyBcB5ghJXNeODnGh6caYpJFwckeU?=
 =?us-ascii?Q?CGDHmfQ2yQkAmLpqfOEKxY6t74ubdjIqH3dHmXGnDPt0lUXLHKFXbQGHi5ob?=
 =?us-ascii?Q?txBKGyNsoW1HsHl5eN7yQNt9RGSzcDCi/Y34oj4r/T3acDYU+VLayJc7fUYN?=
 =?us-ascii?Q?npv66g4HcqtNZ7URkcgdFmwSEwwaV8m9pTD2GlsadGqdg5ZJGYszeaJedq0R?=
 =?us-ascii?Q?gncuuLOPMNB248DESh62dfQgD5oW3w/OiBFTHtxp49UWyJW0Sq+M9G4Unfa7?=
 =?us-ascii?Q?gp9OxsNfy8JYjN8mV08fWLb3jaXbw82QjXKIaDsFsDrb5jWl+acMvI+nXHDt?=
 =?us-ascii?Q?+dEKzvKNtwoB6tvkpDcNaNUAJwyUg2ZPLl++DFKlCdWWY8tbGkIVlVwwJqSC?=
 =?us-ascii?Q?Scbzssny/gOh2vrrUggwxcb3vTFQonnK8YtQSIMn/JM3M8IDiWV98ZeJ6khT?=
 =?us-ascii?Q?6x3v+/CM9OGL0MrZtslizsuDQhWyw6tBKjEDvtCjpe87rUzEig8IqCaV7FEc?=
 =?us-ascii?Q?rvIJ0/oMJiY4iXxbKvcZC/UV0Ec61Te92uCn/zy3txbpnTopK34z61ApFj0n?=
 =?us-ascii?Q?QSRwy2GS9L032f43FXAXERZOql+2vbEBbWyuDcz0MzCBcjIvGxFWh2rsRAQj?=
 =?us-ascii?Q?reCWBtAWBjwLT6GT50ZKxrsxBGc/VWcgFLILSiIjvLtZyT/RMYyZGhaajarS?=
 =?us-ascii?Q?gYSuwkmpYjDtj/VWi6/5j/afZ9tT9MqFM/lWB8RcRcvQFO27md1F55hgdqFd?=
 =?us-ascii?Q?RPAdwcbgOFiHfqCxgWOnjE9ZpytfIpouos8/huicxFxxFLXSepYMu4JSl59P?=
 =?us-ascii?Q?b04lG6OFSh20nWQMb/v9CWUb/kyr0LXWCAxxtksAzL6tOX6Lyt+C/4YzTW5h?=
 =?us-ascii?Q?4gQh84aOkle/GIh5fzk5oRQUEbX+9s/CRDtJK2eQXQP6ud9ThAn33wObG8B8?=
 =?us-ascii?Q?Kc0YAwM20cvirZulo8Kim6RihNYaPUoN7PYP/0Mlpd0PjqTyshTkNr8YlzqJ?=
 =?us-ascii?Q?YCtbl+beYo46Cq3HdscHMrSAepdowD/OQi+yAxQ8Bk5WRH0BGwSRWSqi0wOt?=
 =?us-ascii?Q?TG1paEqvJIY86dfqFiThy9VTuywrbXP9UuHnuEf8xKe3tANG182j0m72K4TQ?=
 =?us-ascii?Q?P5ecW7wfEuxt8VeQOPbxNEJ1CoAYJ6C8XPgip97bdaVkgFHAUUW0v3rU4yMs?=
 =?us-ascii?Q?bDHu8xHnPFeDoNo2XAW9cCte3v4DgdJVatrt3tXcUEMTcguvzk4mxDdiwbvc?=
 =?us-ascii?Q?FGWKmBKfVuDo/xBCbog06ye191Rs5i2Tzhv8fXj3aFIqJbA8G0fW5ty/goWX?=
 =?us-ascii?Q?dp9ReeD5dJYKdBV6c+cjs4/HKVIAZWNX33WcE/kSr1Rtl2mgk1s8nPVgvNP+?=
 =?us-ascii?Q?r4htCPUS83ITxsPsjCOBpPKVfWEWL1Be33XZzzx4marbWk3cJtVnX0QrWAeC?=
 =?us-ascii?Q?WdSLk+rB2oGSE44V69whq16Mmr6BxrhcQfZyzA/0kUoTTWSH11+1kDRTt4aW?=
 =?us-ascii?Q?6MS87Uc4iqp9fXzBeN7gFmwTZOPqKTGNIPmL1xNo8mxbamlZXVBdGX95kmM/?=
 =?us-ascii?Q?fi80qQaf9cJH8ortyAVNuWzmBucHW928sejj3QZU+nEL+rxstkPsOPDzfG+y?=
 =?us-ascii?Q?34f+bClSl3yhTLr+87ueXFA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7AE3488363BA9A4B94BA8A64196244F3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BS9thO1Waubk5k0qFD0vP8tBwlW8Opwm+axUdIWwL9mRN5ja1QP8Ywfv543Q?=
 =?us-ascii?Q?bIWswoz5JJhWhpB4/ituGm7yJGGZs9xD8T5f48XOwJ1bhJNiCRBQiF+a0zxW?=
 =?us-ascii?Q?9Vp3vbzX8T1rhaqU8qylp1+lro/LsTkvyz01Az3hwL4cH6ojQmrAPQaR9q34?=
 =?us-ascii?Q?JNaX0avLaY6QwgbYIM/kVAM2WzatIsaWx78xvotph6WHQi36W/c890wXH5Qy?=
 =?us-ascii?Q?gjv3ud0HuPFfhOVFm5K94faN2Nx6t26/HPiVy6y6EJPNGEAWX1gfyDIRNkbI?=
 =?us-ascii?Q?Wkmq9Tf+ooGfUaIJ0WBnuNnX1uM032f90jHmq6+r7/pLmHw21FjTIQYg6RIU?=
 =?us-ascii?Q?IDiS4j8oHp2PBT0vegsw5MobM1oC8z9ACF+kbTm1G0RwRfSxZLLUFazZcxcB?=
 =?us-ascii?Q?opYMaB234AWAvUStkQxChTPlmO8+pnioKgnMCs7yI+bzYl29A2+yHWEl9Jyq?=
 =?us-ascii?Q?6P+HSavV8gVeF2sTHaX9hDM30dYG3UiaDeFFAB0Xc0v83SY90AasQtDEuObw?=
 =?us-ascii?Q?kBYmG72ojbm+QJCQBVGr0YUcTR5tgVe9xtFGiekkaJdeZzWGmIcASbDWWfIH?=
 =?us-ascii?Q?qEij7JG44/r64dv36C9rSHELYe4WVPD0pNjQsq/1hamWSVs5SSHiKemlMOeN?=
 =?us-ascii?Q?xkEX5ipwMjfb/VLRWuUTfjaJjsqxEfKczdSpMwPxjAezh31luJmFubl1vOnR?=
 =?us-ascii?Q?SNAQIIwPSPw5Fh1x1lfMqYPSFJHe2VRoTgOAHEXbwzjhI0zre+HhMHewTePr?=
 =?us-ascii?Q?p/4pE4sibHLWQ9GjLdEWzI+yqCVmi3dUT/Q/h8ECk6rtodckbiRUHoLHex/A?=
 =?us-ascii?Q?vhWbLMFuj7oPJx8jWu8D+S+RukOsaeixFcf8jZrgeNv7IWQLguhX0UPvLliT?=
 =?us-ascii?Q?XrroC05rrzqIceXYisFHqeDJz6CYMFJrOHV36Tak6oJksX8aqP198freEeeg?=
 =?us-ascii?Q?e/o69b2SQ6CfJhqzXfDpdo1TTRjVXZVV8nqkE4ELbLU36HCGjbh7IFzuHpp4?=
 =?us-ascii?Q?BN6xg41+AemXxN8qtHPaPBGhWg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434054be-d9f6-410c-c610-08dbcc1c2fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 18:42:43.7082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPsuMYFgpF/aPYywWxA70pteAdgYYPCvoN/UCeMf8x1CBVsXMyPsHdtXDzzLAuWptqLZV6URvlVgluxDF1vlHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130160
X-Proofpoint-GUID: IfWlm1FRXB7_lIjo1YVyzCvAUE7vK5i_
X-Proofpoint-ORIG-GUID: IfWlm1FRXB7_lIjo1YVyzCvAUE7vK5i_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> On 12 Oct 2023, at 13:46, Eric Auger <eric.auger@redhat.com> wrote:
>=20
> Hi Miguel,
>=20
> On 10/11/23 20:01, Miguel Luis wrote:
>> Some _EL2 encodings are missing. Add them.
>>=20
>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>=20

Thank you.

Miguel

> Eric
>> ---
>> arch/arm64/include/asm/sysreg.h | 37 +++++++++++++++++++++++++++++++++
>> 1 file changed, 37 insertions(+)
>>=20
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sy=
sreg.h
>> index ba5db50effec..d8e8607c9de8 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -484,6 +484,7 @@
>>=20
>> #define SYS_SCTLR_EL2 sys_reg(3, 4, 1, 0, 0)
>> #define SYS_ACTLR_EL2 sys_reg(3, 4, 1, 0, 1)
>> +#define SYS_SCTLR2_EL2 sys_reg(3, 4, 1, 0, 3)
>> #define SYS_HCR_EL2 sys_reg(3, 4, 1, 1, 0)
>> #define SYS_MDCR_EL2 sys_reg(3, 4, 1, 1, 1)
>> #define SYS_CPTR_EL2 sys_reg(3, 4, 1, 1, 2)
>> @@ -497,6 +498,10 @@
>> #define SYS_VTCR_EL2 sys_reg(3, 4, 2, 1, 2)
>>=20
>> #define SYS_TRFCR_EL2 sys_reg(3, 4, 1, 2, 1)
>> +#define SYS_SDER32_EL2 sys_reg(3, 4, 1, 3, 1)
>> +#define SYS_VNCR_EL2 sys_reg(3, 4, 2, 2, 0)
>> +#define SYS_VSTTBR_EL2 sys_reg(3, 4, 2, 6, 0)
>> +#define SYS_VSTCR_EL2 sys_reg(3, 4, 2, 6, 2)
>> #define SYS_HAFGRTR_EL2 sys_reg(3, 4, 3, 1, 6)
>> #define SYS_SPSR_EL2 sys_reg(3, 4, 4, 0, 0)
>> #define SYS_ELR_EL2 sys_reg(3, 4, 4, 0, 1)
>> @@ -514,6 +519,18 @@
>>=20
>> #define SYS_MAIR_EL2 sys_reg(3, 4, 10, 2, 0)
>> #define SYS_AMAIR_EL2 sys_reg(3, 4, 10, 3, 0)
>> +#define SYS_MPAMHCR_EL2 sys_reg(3, 4, 10, 4, 0)
>> +#define SYS_MPAMVPMV_EL2 sys_reg(3, 4, 10, 4, 1)
>> +#define SYS_MPAM2_EL2 sys_reg(3, 4, 10, 5, 0)
>> +#define __SYS__MPAMVPMx_EL2(x) sys_reg(3, 4, 10, 6, x)
>> +#define SYS_MPAMVPM0_EL2 __SYS__MPAMVPMx_EL2(0)
>> +#define SYS_MPAMVPM1_EL2 __SYS__MPAMVPMx_EL2(1)
>> +#define SYS_MPAMVPM2_EL2 __SYS__MPAMVPMx_EL2(2)
>> +#define SYS_MPAMVPM3_EL2 __SYS__MPAMVPMx_EL2(3)
>> +#define SYS_MPAMVPM4_EL2 __SYS__MPAMVPMx_EL2(4)
>> +#define SYS_MPAMVPM5_EL2 __SYS__MPAMVPMx_EL2(5)
>> +#define SYS_MPAMVPM6_EL2 __SYS__MPAMVPMx_EL2(6)
>> +#define SYS_MPAMVPM7_EL2 __SYS__MPAMVPMx_EL2(7)
>>=20
>> #define SYS_VBAR_EL2 sys_reg(3, 4, 12, 0, 0)
>> #define SYS_RVBAR_EL2 sys_reg(3, 4, 12, 0, 1)
>> @@ -562,9 +579,29 @@
>>=20
>> #define SYS_CONTEXTIDR_EL2 sys_reg(3, 4, 13, 0, 1)
>> #define SYS_TPIDR_EL2 sys_reg(3, 4, 13, 0, 2)
>> +#define SYS_SCXTNUM_EL2 sys_reg(3, 4, 13, 0, 7)
>> +
>> +#define __AMEV_op2(m) (m & 0x7)
>> +#define __AMEV_CRm(n, m) (n | ((m & 0x8) >> 3))
>> +#define __SYS__AMEVCNTVOFF0n_EL2(m) sys_reg(3, 4, 13, __AMEV_CRm(0x8, m=
), __AMEV_op2(m))
>> +#define SYS_AMEVCNTVOFF0n_EL2(m) __SYS__AMEVCNTVOFF0n_EL2(m)
>> +#define __SYS__AMEVCNTVOFF1n_EL2(m) sys_reg(3, 4, 13, __AMEV_CRm(0xA, m=
), __AMEV_op2(m))
>> +#define SYS_AMEVCNTVOFF1n_EL2(m) __SYS__AMEVCNTVOFF1n_EL2(m)
>>=20
>> #define SYS_CNTVOFF_EL2 sys_reg(3, 4, 14, 0, 3)
>> #define SYS_CNTHCTL_EL2 sys_reg(3, 4, 14, 1, 0)
>> +#define SYS_CNTHP_TVAL_EL2 sys_reg(3, 4, 14, 2, 0)
>> +#define SYS_CNTHP_CTL_EL2 sys_reg(3, 4, 14, 2, 1)
>> +#define SYS_CNTHP_CVAL_EL2 sys_reg(3, 4, 14, 2, 2)
>> +#define SYS_CNTHV_TVAL_EL2 sys_reg(3, 4, 14, 3, 0)
>> +#define SYS_CNTHV_CTL_EL2 sys_reg(3, 4, 14, 3, 1)
>> +#define SYS_CNTHV_CVAL_EL2 sys_reg(3, 4, 14, 3, 2)
>> +#define SYS_CNTHVS_TVAL_EL2 sys_reg(3, 4, 14, 4, 0)
>> +#define SYS_CNTHVS_CTL_EL2 sys_reg(3, 4, 14, 4, 1)
>> +#define SYS_CNTHVS_CVAL_EL2 sys_reg(3, 4, 14, 4, 2)
>> +#define SYS_CNTHPS_TVAL_EL2 sys_reg(3, 4, 14, 5, 0)
>> +#define SYS_CNTHPS_CTL_EL2 sys_reg(3, 4, 14, 5, 1)
>> +#define SYS_CNTHPS_CVAL_EL2 sys_reg(3, 4, 14, 5, 2)
>>=20
>> /* VHE encodings for architectural EL0/1 system registers */
>> #define SYS_BRBCR_EL12 sys_reg(2, 5, 9, 0, 0)
>=20

