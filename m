Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49787C4917
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjJKFNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKFNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:13:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C8D8E;
        Tue, 10 Oct 2023 22:13:10 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJiLm6026475;
        Wed, 11 Oct 2023 05:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=59y2MEHfvUEAFioqxd1yeyq8hqvfSADIrmchf0+1DAk=;
 b=0EnRNHZedo6sxGw1/6oMP7KCGIwAJdl6p6e8BMd+AYFERcfQ5zuIfvkxAmH5QSOb54mq
 wwBxufWOK/LPjTkk/kJYlr2sEPWkeqVer79JWxtlqv0DktofVZzv6YXaXIHNlSEIOpo/
 NmB3GMnkhzEZ4ogEm/D7nzBljbWRrEXKfCJ/N1SbOqKbeftMSgTZk7cFSQwdwbMnHEjA
 4m3oYDnerGPUTrITdNbGKPquMRqqH0MJ4KNUvlRS0Fz3WxqYskMY3IlZWTqyAjP2OCBC
 apW2OyX9KMRIFTh8wmTT2hXE667x9GVrg1XT9SQgkGu2QmsTGypbizBBq87D7feDn8FT fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdpy29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 05:13:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39B4t4kP020760;
        Wed, 11 Oct 2023 05:13:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsdn2xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 05:13:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hy76YD+gVpdC5/R1S4Jjqt1cN6qparUmdZ9z7NSswiwnbQU1aYvSvXpEopmjrbkLTlJkSztcziAIne1aP5P1EW86A8ibfSo3gDXoY2jZ+78A6D8MRz9V2dWIJ+jAg3fUu/Xkl04qpWzcNfx4B9JTMZ+vBadLM38MJqlh1eOIub0XsIfrNhYutjkOr09/dFWugN1xiNRorUsqmrvaxi3dasyqLNiK95gXEzCFbuCu9ETmdWOyRZiz4+Y4BCSuT7gIGuAHKyh8S2v+INfQHXV7oTM0fFtHK6ELp5HBMxqPApb96mca/iRJBE1/e3mAZxdi+pJf5bNGLD4dvskqCdqWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59y2MEHfvUEAFioqxd1yeyq8hqvfSADIrmchf0+1DAk=;
 b=UKOXBbtHEq3qhS/GmIElztcsg04K8a1hqAwIacwdVq3Z+HIRfg2NWONRO/4uZRedZXhAHZqFKFVtpKRAWVbmIQJ5+W3FVv25GUw3I0WcuGDItVsPldZcAmLLuLMFJh8Ygx1bBzm4SlEE3pkDbLY0AEhyidkKaoY6cmsyG0TWwHmYSPjEAIBsAOQR33yt2Wrfqy40eqZsdI1QXiMYq8OfeWDV5rLHs7GUnvDkmeDQLy2n+pXN2mbKiPK4gk7Jnj0xnHZNQ/+zHY1DzVmRKqJzYkV4NhuX86kq0/g/rAR6D12nKyDiK5nd9gWYxiPn3InHKlrZgqojC+4FmZgtFCHsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59y2MEHfvUEAFioqxd1yeyq8hqvfSADIrmchf0+1DAk=;
 b=r7Egb70kgk8/06qw8liYrNtDXGRkUZY7wG0RglUhERm+JwhdHZXTzp1/3d0XarlYhcu1GQOeCwkTk2aCRdjRRuENN6XpWOyUDNHonnqGfXLMpelo1EvZ55VDRdgACXw2A+dtbjuO2NZZYqPw/yhaLRslowSDYa5MdvE4eiPCacM=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SA1PR10MB6542.namprd10.prod.outlook.com (2603:10b6:806:2bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 05:13:02 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::f5d4:dcca:5e7d:ad91%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 05:13:02 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oliver.sang@intel.com" <oliver.sang@intel.com>
Subject: Re: [PATCH v1] Bug fix for issue found by kernel test robot
Thread-Topic: [PATCH v1] Bug fix for issue found by kernel test robot
Thread-Index: AQHZ+8G+NJU6mcg+iU+LJua0IHiEnrBDwyYAgABIgIA=
Date:   Wed, 11 Oct 2023 05:13:01 +0000
Message-ID: <618140A7-2286-4CA4-9EA1-D8F4C921606A@oracle.com>
References: <20231010213549.3662003-1-anjali.k.kulkarni@oracle.com>
 <20231010175322.0efb8a87@kernel.org>
In-Reply-To: <20231010175322.0efb8a87@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SA1PR10MB6542:EE_
x-ms-office365-filtering-correlation-id: c82b7870-b781-4927-c10b-08dbca18bdf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/3Plg1nx2U3ie94Wq0fR7MQJlqvELs40UCwJ8Yqb3sjlEb9KTz9adPfn3oqZi7kFupDp+ABbeaRez94bC8VCObuTFd36Ilk/ad69r+oRa4uEjgYjRt93TfWsQvYiRyQqJF4owUBoCtokXkgEPy7CWBqyx13ryNZGla9lC0/d76gb4x2CSRgCnEuZCXTJOtl5NBfqn1AHTdN23MUgxeS6kY6NMc9P3XEgenyi4XNDuf4QnjHL8p02drMch8KQclFiW0N2JgV03Uh8aqxBVJXjG477uI/co3JD8EVbETABpexdQH4zdSFmtP0SD6px+pKgauamnFSyfynTQ9h9ilG03Wq2/gKCZ+nKDNrWVo7NWrqq5LvL0HtI7ByeTja1L71M0q4RmCKCmTWxIC441peuLMKt5ViryOzVeAbkg8j94FfXmbVKI+G8ITJsN6tdw522oOc7Oihl29tt+s8s6JpNA6fZsYFkl6zcM7Ip7YBpEuEE3YHeDiYw+n6pBm+TDAac4LkqLz7eViZebC5qxlBJGuJ+BINbrzrPPpTbaijkjSD430XoRwrd8JvCOZ0BKAoY8IVNx0uGKRlqpcnqSyGwB38oZdakQmbEnJNdPHqjJ6HXq38R+GlV2mKQq1rKe8LkHboMfpPIcNUo2VmTD7Wnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(76116006)(2616005)(26005)(54906003)(66556008)(66446008)(66476007)(6916009)(316002)(64756008)(4326008)(5660300002)(6506007)(41300700001)(6512007)(478600001)(4744005)(71200400001)(8936002)(8676002)(66946007)(6486002)(53546011)(36756003)(33656002)(122000001)(38070700005)(86362001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Q8NawJGikF+Hu5jNgWVH2PFZrtCwhbtjPX1YAaZDbIJwi3i+wYINQPuProM?=
 =?us-ascii?Q?WN/yLJwQaHmDGESs4GZ0/+KqZ3svZhjhLlcaMMhUgOeLpWW652WU453idSTe?=
 =?us-ascii?Q?rbtvWBOYuF0j60ZPW1l2sJHPEq9rVe4oqjJa8o0O7artaho8eqYviAXkFKFe?=
 =?us-ascii?Q?bFGCq9tTZPp/gyDCrpwjK0eQr1vErQf5BY4jhGMAUAJxcSRo8paZATXSaXWI?=
 =?us-ascii?Q?52wJQHvCuXzEsDvq+NlByhVX/UNbLME7mTOZgJNfIbp/EEtO9GRpgafY01vT?=
 =?us-ascii?Q?yZTY0Df/IiM4SsVjo1C/Sqmp4oJSF20z2MszKP2tGWpDJSNsdhNfmcNHNj7w?=
 =?us-ascii?Q?bR4Xoe3RI6ba6F3ZldD5S/0RtTFN/0hGasRCgwsOELwwE6IFnPfHlg4GLHuQ?=
 =?us-ascii?Q?elveT3R29iyOv3Q7gVkNVa8zBwYSD4lap6B4ZiWwZvDkc6yKP6/wJInIFB4L?=
 =?us-ascii?Q?s6eqysBWr/XxZAGUBJ4pnthpTxtvhR9mYrItVR4i9v4F7oZ2wmcTFhvduTAd?=
 =?us-ascii?Q?zzj3QWj6HmyUl60SLG5TnguMX+5r8rKionKUjpMj8UUiSRRBKteLMl59NS2+?=
 =?us-ascii?Q?FczsIDSZBdQWeflTYYtAOj/6bKk/xhawaGWpeIH3mycLhmMw4qsl+HtJosdu?=
 =?us-ascii?Q?OgBo8pjUqoH0FgqyXG1Woh4nur0+gDWICc6a7bm5MpoJ1FA78txkCSlPPHdU?=
 =?us-ascii?Q?vsTqrlEkne3VjNpXNYX2ue9iS4o0UyvALMqCVUX/RDJlCUfbV1plDd/OqNzO?=
 =?us-ascii?Q?jMI+eQpG8M8kZlU9jzJhuyJx5NTNHL7CPDcfJkTWEyn2sic/0nxLhnxE5m9P?=
 =?us-ascii?Q?lNMuutVin1wGo9OxW7tXk5pAfFqeSS4iJAF+xVCKnqmYxoRaOUmL/i0kWJd8?=
 =?us-ascii?Q?/8CqDUdxwLAz/C1nTxCtZjZ2lZA4aBnbBfZUiZcg6o+ER0hm8KBrwKQfiA5E?=
 =?us-ascii?Q?FAmcXEoc0r420jNHOL07yyOlO36x3+RbUxvAMY2JOROkwoyJhKIPIcLbXtI9?=
 =?us-ascii?Q?afLDtYHdmh7O7sjp/i1Kl/IJ0q25G/U9IqsnHCqWopViZkEj45w7pRglCrOr?=
 =?us-ascii?Q?5sAAkXlHB3jFnEh+krp8Ci5SGedDbWnFBSHEwvqcnHFbz9NCN+igASErNSfF?=
 =?us-ascii?Q?wgraokHUzxjbMtOg1Md7skP7JPGc0E1+OMSk9+aPDKkGNiMXXya970KBxVu6?=
 =?us-ascii?Q?Soi2PIWiSdb7H8LywyD35xjflKCHJgToHHhnP29GOOkTW3ALGIaQ4gGPEPF7?=
 =?us-ascii?Q?PB2S/KB1cWxtMOgfThWkZ4sbV+0zmHYJqHwAqQ1OHQK4C16xAp43HOS1PLMX?=
 =?us-ascii?Q?tgo1Mh/hactvajf7pkL4KCDdrwlM+eEBsL2v12x1j73lDjTJqvFiFKnrB6Y7?=
 =?us-ascii?Q?DKMka0sWN5iXDrUQN1YSNoAHTAe/XHE9x8FVWBrKOoIoi1Uqesl9MdcMiCNO?=
 =?us-ascii?Q?IhnMFd9uA1jbvZ9fX3WRbvJ1QUPhSfWsgopi+wnah8z9/MQVPLqDwekRU6Dm?=
 =?us-ascii?Q?12iNACXbE6TIVUa1QX7AWj2BBka+CZxc34gLBRvdck2S44Ulaux+8yxARke0?=
 =?us-ascii?Q?ZXyHJwygiyyCrvj1WhcqXqvKFdPptKDoF6TNcJtWoCHnUk8iY4mpnmRF562G?=
 =?us-ascii?Q?3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3620984986FA834EBE01796DCA27B952@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mc1eWQLn3ZiYcUWNPWl2wYPU+PYLVs8LK2SHDXK6A3KdzkvgqwZSZlJhjPEHlerzaiNsVlnrJ/TJDNlPDI3TutOzttg8Kq1GaNdZagQ7ab0GGuvegOzjHcSFBv3oEWobHY18aUtcsqS75+Y6FlijSNLGFP/BnMIkyXxaj3Y7hTo+kCnahNh2EZb64rKIik4/2MQciCLCSejMDiHCW80rLC/mXiay8OlEs0olFp2bzYnsTSDKh3w1diHG6xF9LMKpd+VYCgqhMgmmbA6jr6IDvNv5mI5DYfbFeDRThzclGThhhnEyde+sfL+F/cC3WOEJvG99dLSdM+4Trsz0SxSQog8Hbd2eikl0Ui0vcsSXT33Xux0BjhjAoBw6kaUiIbOXjxk0cu/nbH53yFwzhyJpG1y8JA2ZJFY1t0MsHvk5AfF2VYjxfmaYQh3Bh1/885wbMzS5m8DV4296t20m+jTDAUEaQGg7omuDeRzyipyOTToMLdFczuDK8nVo7ozdbMaXQusYUTxFFCjQxez2vrUvLJ0pnQXY42AQjW61q5O4URQ1AvMbx+KlEBYKwRS0ERWJDn/rnjku+9KAyWTNORL4iEORq6PvxigoA8zxu65gIGqin16riltaqTh9/o41QA+MGPq/pigtcAhDQtQKIiPZSsPPqvhM2hqSIeac8dN9fP5z8yJI3rvfpbWfu+8XnzYcGLtpPOR0JA3Fa75g5YVrUmIcuGFCEFYtHYAD9nyHIPE4BJy6KCM3u/lLi3NEwWgZKcvgCEClOTB/EMw+5eAHHXbKSTCxlzWJk6mbi+9OnL4XtsN2bnekIAP7sCMwrw6BZid9zOZ1/TFQfNN7WoF65AvMnqtxLjT6GPVZRbHjSZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82b7870-b781-4927-c10b-08dbca18bdf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 05:13:01.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kK5/sCWkVwc7kdesr5CNbFr9bKhYlEwWF6Yi3kPhTpmkDz/XiAx2PdiaUtmOwPVHqiKN66MwJ3U8QxxTcx8oc7AawJctKvaQiE76OaHUEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_02,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110046
X-Proofpoint-ORIG-GUID: Ygew0V3zwDV3dSVl2My4jzahVi24alwt
X-Proofpoint-GUID: Ygew0V3zwDV3dSVl2My4jzahVi24alwt
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 10, 2023, at 5:53 PM, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> Thanks for the fix! Let's start with some basic process feedback :)
>=20
> On Tue, 10 Oct 2023 14:35:49 -0700 Anjali Kulkarni wrote:
>> Subject: [PATCH v1] Bug fix for issue found by kernel test robot
>=20
> Subject needs to describe the issue (e.g. fix null-deref due to $xyz)
Done.
>=20
>> cn_netlink_send_mult() should be called with filter & filter_data only
>> for EXIT case. For all other events, filter & filter_data should be
>> NULL.
>=20
> We need (1) a Fixes tag pointing to the commit which added the bug
> (2) appropriate Reported-by tag (see the syzbot report)
Done and sent out v2.

>=20
>> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> --=20
> pw-bot: cr

