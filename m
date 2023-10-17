Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96C47CCA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbjJQSXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjJQSXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:23:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B90C90;
        Tue, 17 Oct 2023 11:23:36 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HHsOCI007778;
        Tue, 17 Oct 2023 18:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=pyebzPOVdOwujunO3rgJ8Z2e7qz67eMtfeJycDR8T/M=;
 b=KETbQk1MrvEkyJ4okL70gkKqRq3zJMGOFAUc6mlt7ZWid/Q3ZFhppyJ2k8rTfmyp4sCo
 HUcPD3qBAf2opRmSx19QkHYUFJjBBZB+MX5a4Kduzjbsw3z3/HiGRjrDf4KWLLDidIAU
 JO2cMFklF5X9+nRpXQ0zPanfYD5nkceSpvSj4p73g0RHzB+sYeG1thkg/geGOLSWYTa2
 MnpqPA0ZSOahwefZSWbvI2PfPXdTsvmnH88B+nEN7Lk6bcWJOhmMZYnE/pnqGPOTLYr6
 xhjg1rt3BlJ/UNMl8RoziMpO0hbPbtru4RO0RDfK+uydlknkFHbGclrx8zw8P0TT6MKK kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28nxy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 18:23:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39HGb10f015255;
        Tue, 17 Oct 2023 18:23:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1fe6qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 18:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khUobZGloAazgeGg5Ueb/Il5oy0H3h718w0ePSGll0EzV7KKXp03Hse1TwD91hAN4lxhi+2FgUli/f5tdinIFOYkKPaxTJC1UyVOoqCqOdle9WWTvRFB8wDpfFn3ugl9Cp39Q+5YWFkvwTwzhdZeR26xPb6UiBFANrb5giWLX6o9KDROY19NsFvsF4N5QhDV+038bY32YeZeqMnDe8uGrtCAh/mdKnHnurb92EV/dJDmZJGUolL8zvITbgVtDk0eaRnGEmPQhHu5rj981yHbdneXkoN+jTb7gk72cBrTKVDCf/fB97bV6RMUlyx+zjE8SW6/aNFcJ5+7j9+VZpkNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyebzPOVdOwujunO3rgJ8Z2e7qz67eMtfeJycDR8T/M=;
 b=RYNchfwNVIDRvBvO2oRutO/QL2V8VqaPYKXdtgftynu32lamyS/w7bMJ2eJi2zZLoPeskydYjMdbs3PLi2hvaBz1chmwakNjw0h1gQtWjYDRNqJnqT+eHoWU7qqDamtPEG3tKqOKM9PlxFL0tP3pMA63wRBtDZ4RLxXKIAQ6/TUtLMFtqTPPh8q6sOTausi53vhuxrdS43Vz0XaTZZfOmO6nT14buohV4lWHrockqPiBlSz8ayndkX+IjOKQfdbBZbgyz88ouLjB7DN7M4kGXBKvSV6u2Y1XhTBfsoHst9k+bI4umsjYTe9KxXHi1MAAU2z7sK77gZgQ7fh3FFAOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyebzPOVdOwujunO3rgJ8Z2e7qz67eMtfeJycDR8T/M=;
 b=AmhblP56EeBX/zugtksk0akXVBATujsoqBC9qBgdcPBR4yaiDKR8ntXdxFLMinAXHCMHSfnCy7LIGW29m56G0Avd1ZNbmtmRf8USFnvwaa3r/SNtctqk36CN4+MwB4Zv6Y5RFS1ea/VjA/OluwJlvYz7I9wMbw+F3SFurTwAdr8=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by CO6PR10MB5585.namprd10.prod.outlook.com (2603:10b6:303:144::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 18:23:15 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91%6]) with mapi id 15.20.6863.032; Tue, 17 Oct 2023
 18:23:14 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Simon Horman <horms@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        Netdev <netdev@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v1] Fix NULL pointer dereference in cn_filter()
Thread-Topic: [PATCH v1] Fix NULL pointer dereference in cn_filter()
Thread-Index: AQHZ/ih9jUSSRZynuUmcpd9TV4mzXbBNpCQAgACteYA=
Date:   Tue, 17 Oct 2023 18:23:14 +0000
Message-ID: <8387061C-CCD2-4F6E-B5F1-8F18F19E686D@oracle.com>
References: <20231013225619.987912-1-anjali.k.kulkarni@oracle.com>
 <20231017080210.GG1751252@kernel.org>
In-Reply-To: <20231017080210.GG1751252@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|CO6PR10MB5585:EE_
x-ms-office365-filtering-correlation-id: 160978af-a057-45c1-0711-08dbcf3e20de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TpyrvBdg04Am5zV4VfLf0wUPxEz21F/zKH0cuAFl1M5bY+Wq85l8NfpxzJ1p5jDOKWR3KjmAjx/D4oDCg90jlWQT6T6XHwKEa6ZUIbOkKzNIwhucdqXyexUUtrrSZ6BpWpuHx8dMf2VuiLSoPTITbTOrTU8njXAcecqtx39baCz4g4l3AA6++hNG6JqO+Dyu2MXxEz2yY0HnysWFDNjyZ6BNKWC/NYdTqUfGBpVS3yFszLFHhsWIjLhmd/8NJkzoJXq6IKfY7FYaWB1W7xpb+rzrV40stAcihW69x8KgQYeQ7guMPzG4JyhoIX8eIyHGl54HajyJUS7uK9wOqJBrXGmDDblK9QlVFVxYtO9QYKgO72hY774uhc/OILu66HSCkwBgCdon+/ElSOkxOErl+neFjURlL2BwfcmAP+R+0R41la8QHQYyovHkitfC6HbpKeX14r/MzyuC3fUtN4jSs5Sh0oA8SNVC4/me7ZNz8Q1rcd37ksbVBeLjW/dPfLy2j+9AhizEhYspJMeGdFg3EQh9WSDm7A3Cg4G7X9is+edD9BfGP6pUW6ki8c3pQRcm/4Gydidskdx/0QnYBAY873Cbz6E3rkbLUrSb8su3anIjDf688F90Umsugff0AUj4c/JdFjqpeGSHRfX4AtSb+FQZE8aU35G+5rZWgqIXODqP4XnJA+JVVAsv2ARRh9nj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8676002)(38070700005)(2906002)(4326008)(26005)(8936002)(33656002)(86362001)(38100700002)(122000001)(41300700001)(36756003)(5660300002)(83380400001)(478600001)(6512007)(6506007)(6486002)(71200400001)(966005)(53546011)(6916009)(2616005)(64756008)(54906003)(66946007)(66446008)(316002)(66476007)(66556008)(76116006)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sw/RdiF4n9bMbA5+4tLGxT0999/E+ThqP0sdOxJvl0nG3SPv3hHtNw4+BPin?=
 =?us-ascii?Q?kiVgPWqG+PDI/4RN/MZjGS826TbhCIh8xf1j6fd2/DBV606SrJqWuVnJEEC3?=
 =?us-ascii?Q?LVBKl++RFYjevBGY/MzJAmeQnX5/TSSLbFHmu2Zo0f3DsOO0I5XYezFgM8Ki?=
 =?us-ascii?Q?B4efCgzMffpNvZbvkqS6I5rhzhlsNk9gAgSj8BgHKyS4MzPR7CGBXT7ejtsJ?=
 =?us-ascii?Q?egYg4gAC6KDwGaA8+w6mTD9jOu/Mz7esTLF7/qBy3nyH9I5C0pFmD4l1L+jo?=
 =?us-ascii?Q?/Hg8EgPiI9vvgbjPi8fKHXSdKXCov2fD9KWLayTNM9KiobkKVdeSgwpoEc6+?=
 =?us-ascii?Q?QuH9OMqVH8KkBh4R5PEu5VoURogTnxPw9lho7jOdO4TntRD43hpyx/2y+43n?=
 =?us-ascii?Q?n6Y+ou4g7L4+nY/iitP/W37d0dbBDtjGSdLDaeiyl1u0Wn7/8DGbwqKUocF8?=
 =?us-ascii?Q?YvCO+SF4miDgixhvkI2EsOz3BUQTusznda/VtvAYVd7eaC3/qZH8rXfu5ew1?=
 =?us-ascii?Q?m0AOG9h9Sb1gOnBHRTJCxYCWq71c+PaekbPa+zjobOgv6CCtiswmQj0aL+xw?=
 =?us-ascii?Q?oVKvGMm72ytwWyquRkQgcSy+buzoCVW6421NGTktFlpJYhR4/EiBOridm4rf?=
 =?us-ascii?Q?cm5t1u3uN9HbIw6Z2OPaX5MFtR+Xziz3nzOrtNsMYc9YchRpN2OevEWfSyiA?=
 =?us-ascii?Q?uWevXBHknVAGVRnO4URve6OnAKbwvpHVEUayUcoIcFK96yK+Re1HLW3gFdd7?=
 =?us-ascii?Q?195nZl1NgHXGL2CJ2LKVqpaApOgQGYQQ52zCwNgIuGKtUxO6f8b9VDyJ84Bt?=
 =?us-ascii?Q?IQkIuXvTlhkuj3kXBS0HM5UgPu22fC0LgRqkO4xV/Uny+SQssVUWFvK+fMrQ?=
 =?us-ascii?Q?1crsooSqDPhNsQJb+KcqqqqrLIZNrr81uqltK4LDMiyzqsIIsDyvCDuRKORh?=
 =?us-ascii?Q?0x1UHon0UNgnHjfrtGLCBEpWhdB1V2v7ZpldoijmktLq/W0Df1wwnaQng+Up?=
 =?us-ascii?Q?ud8aIPUjRRZRLVyucKBzwULnziBXQ5ILu6/TDoVzFTPj8X+95Wkq/ElWKzKy?=
 =?us-ascii?Q?Smrt6b+/sf4dqTx4LBOzbhY9Lgk1OEzg0tm/VSHwhRpEElddDHtBkXQvrp4K?=
 =?us-ascii?Q?16IOD44fyZjAumL2uh3f3G4dZDQRcRsiPdJxc9x8Yi/RDISnC3CErJ6ttLwN?=
 =?us-ascii?Q?2wHBSr2Q5eY0Q6UAoybyFi0Bi8TsddVjQ9doRyGgeKf3MduEla8XQZoTkrTV?=
 =?us-ascii?Q?+NdnMTaon7qgoDAum3+WNpEeNwJHAJqPub0QhES3PaWPoiw3U9enRbMvX/TT?=
 =?us-ascii?Q?sB8enhypjeqRmubTmaMGY+5wdw0K7paQtWsI7Kmq8LmlbgsQSbhlf1gx1C1B?=
 =?us-ascii?Q?lQGX1JcG23Jm9ffJccIMzL7OoIqa8q6MeDej66jffKjodSSdnTuZuMmyRYd6?=
 =?us-ascii?Q?syU01aS8P755TmNtkGbGHpGhr6iYL6TeltneDzJIEDZ4LskeoRSG80J2thFg?=
 =?us-ascii?Q?SeSbpfdbQY2PL0jIlFjrv4NqnYV8O5xhB8vFZd5ef59y9/3AKqY+KopcS4YD?=
 =?us-ascii?Q?HFV42uq9FdDwrO7RHxoSa5Pwe15meYKGSlwMCd95SmLTu1C1gW1j0NxtFSmy?=
 =?us-ascii?Q?TA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3DB98F03D43FE43B54791B49A772DD0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9+olW40qYeD99ssISpMV1jWgkA9PPcdB9JUVkZKOdfg8+bZ/ZyxcQVQ0yZzmmsO8AN9ojV7kmq6E46MNA24xxlrMQ7J4hfkRojxpaEpDHAIYTtdXTVzWm/xv0mnt4xjvMZaXwlWAkbWMpMcwbOacN8hfifYRW/e5lS6CBJmw63F2t9DbUuFSafGyGVUfU2wI+gT3G6CLvsb3zfWJuBgLKLnYlDjaeE2V31q8p/JBBfm2BGbSRFaJIhsDuAYiJS3r7Zaewg7gh2FMR44hlZk/eJPkdSbfaxV5hwyUIb4lAHp6rgNsm3RVIykeY/hoQb6I2d69elY63rQUIEreqUFrQ3nwYWRtESOzhv3WmQhF3+JyAE9/G1cLVwm+yL+j7D9C4HVbJOQO7iqpnFeFgc++dUR3/J8p2bgALVpUADsx07ohEhe/Hg7V6r1gYJASLs/NDwU1F5IDRbksyogGaM4d/y68NFOaWYmzU4iR0ifjjhIT6laYXmcTSFUPchAAUJgTtM0u6VXlAnKQ1kjXZtyFe0beFWmp3EUbsVa4iyXUJ48HEizr4CdXevqyH4bIjM87oZVKqOn/7FPb2MDqE35d3ycQCahV1BmSbk6GZOfqMDg7iZ97vbYwjFq58fMzSlxI9am8uWJXYDIsJV/2pu7C8qU3tyYOUU2PfZ0rAPLS/+rXvU+tNUKFr+4WGP994oj3XgbX09a7THZ4oq5uf6XjQZ6iy0N8MFTvIRCwR+iGISVPcfl5EkMfrN+A3IXY8b64xLNeGtZhWtEDxgXbdfQek7QvNrY0NdthZzPIRxtvXFehi1aU0tO/FIuC3BrhQYtd0YTlCukC/YszEFO34iGwTLFv9JogAvDVLVCtlxtVKa4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160978af-a057-45c1-0711-08dbcf3e20de
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 18:23:14.9360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EovpJwkDi6F1LGGCAeWU3JoOh1gWnN/52xDVyax0kjqfNyfrzoZ6wufkfdsIjzD0QFGJeuRSbhjBKzDNDP+6txSHu1/37qYDhWj2dT/oYkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170156
X-Proofpoint-ORIG-GUID: 02M3IgNl7fpcIleWVp33onKSXbM43tsc
X-Proofpoint-GUID: 02M3IgNl7fpcIleWVp33onKSXbM43tsc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 17, 2023, at 1:02 AM, Simon Horman <horms@kernel.org> wrote:
>=20
> On Fri, Oct 13, 2023 at 03:56:19PM -0700, Anjali Kulkarni wrote:
>> Check that sk_user_data is not NULL, else return from cn_filter().
>=20
> Thanks,
>=20
> I agree that this change seems likely to address the problem at the link
> below. And I also think cn_filter() is a good place to fix this [1].
> But I am wondering if you could add some commentary to the patch
> description, describing under what circumstances this problem can occur.

Thanks for reviewing! Yes, it seems this patch has fixed the issue (as test=
ed by Oliver Sang). I will add some description for when this problem can o=
ccur in the next patch revision.

>=20
> [1] https://urldefense.com/v3/__https://lore.kernel.org/all/2023101312010=
5.GH29570@kernel.org/__;!!ACWV5N9M2RV99hQ!NNsMHaho3lyW2NyoT8Sju1BL78S5pNu5A=
htZC76cc1Xb1_psXwfP0lmVtVmTxGRrsQkzClWNS8HriosTMols$=20
>=20
>> Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs"=
)
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/20230=
9201456.84c19e27-oliver.sang@intel.com/__;!!ACWV5N9M2RV99hQ!NNsMHaho3lyW2Ny=
oT8Sju1BL78S5pNu5AhtZC76cc1Xb1_psXwfP0lmVtVmTxGRrsQkzClWNS8HrirVfNms7$=20
>> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
>> ---
>> drivers/connector/cn_proc.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
>> index 05d562e9c8b1..a8e55569e4f5 100644
>> --- a/drivers/connector/cn_proc.c
>> +++ b/drivers/connector/cn_proc.c
>> @@ -54,7 +54,7 @@ static int cn_filter(struct sock *dsk, struct sk_buff =
*skb, void *data)
>> enum proc_cn_mcast_op mc_op;
>> uintptr_t val;
>>=20
>> - if (!dsk || !data)
>> + if (!dsk || !data || !dsk->sk_user_data)
>> return 0;
>>=20
>> ptr =3D (__u32 *)data;
>> --=20
>> 2.42.0
>>=20

