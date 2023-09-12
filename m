Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB00F79D188
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjILNCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjILNCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:02:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6924AE50
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:01:58 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9nAEa015250;
        Tue, 12 Sep 2023 13:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nbzTzYGVYy2ICzMV1ZgjyPf9wgtT/mhvFoJ5wL1yUNo=;
 b=1ZUqr+UTMavi9f5XSuXBYvMVleivz/qQktptduE7q/W26shZkMmZ7qNu688C7lMrVCDe
 P6L4cgSK0SNyyEc8EJRUfqDyFu3TY2scPSX3JhC/KM8p2TocWOSNaXvihXoGrGJdt+6q
 hn4dPl0dXwzhqiyPBhzeobRMojDwV9Nmj/Mz46M3zrEuetL0euydcWtlj7sh3u8na+J6
 PXigWl4mpRvPSZt92nJbzHFrFzJNJMDe6JLvuU4X3oeaLOwlNubUOQKE27vThNDRtIU4
 QkIj+5FyAiJFIEx6GJHO2gGfxInTFFPrkrD+NZs1T0mzx3crcKtmrXGNOfZFvFA3rafD BA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1k4cuwjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 13:01:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CC26eZ023095;
        Tue, 12 Sep 2023 13:01:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f55y0a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 13:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM2pTIJnlFzRVR4DpooSMUuBQpoDnnpHWqWj/wGprK0axdUIsPU7UHvY0fXTkxdTjtTGy40nq/TPhP+m5amTzMV1ia7RTz69LFViGMzqgU0EikkVjOl4nqzPp4/18KUdYLBoi2EzEHikyBkmzPd+SEc6jk70Ad1ac7hzhyH5dEzC1q9X3KIU2ey3rnq2FRmGA/ncnmKBmL7Wu3hnJRwHtMlfNwCoWn7QULEmMDll+B6BGNWvk6/6XNhAbNKYzU+4YUBxl+aE5ypgYSi0mWWR4GU0pPAk2vJn/JZb+kwdcRZawERhcNtIgLrTBTeZ7IQAIkaLVB7o7j419XBTx6EIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbzTzYGVYy2ICzMV1ZgjyPf9wgtT/mhvFoJ5wL1yUNo=;
 b=C3VgMKtbzOZfyHYuSebd1VY0gzV5TdhQlmPPq+U/VYbHIgv85bYtqxja+FublBo9nBanuelYQotdZrwOnRBsytCPwQHQHbOzw7Z6JPZ/2Vahn5F1FjMMFYnJCgPyLglZA4DAl83zs5/4aVuRCqrUjJwNHj9Yq3L0XFB6UwLPgAdFZWDzghBYSn4v4FjWckQcoYlb4Jvok+skuGuijm7MkmGEG47X5rgvCQYGrl84vA2ClvWCKKqFjPynIp5ZKD7I8hUXKZ3rKhawpbs11L9S/d8gmI+W+ti+hu90DP5vBu98I9pGIErzmSBoMn1SyVJLRuXFG69KFuihV2g5Wq8O2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbzTzYGVYy2ICzMV1ZgjyPf9wgtT/mhvFoJ5wL1yUNo=;
 b=S/QDZwxgDi8tHFfu1VrqtAAgNMf5Sj2L8TCxUfWjbEdpCbBlm/OHtRmIf1uvw1PozhKATFXpn/pj1FdIYxv6B4WLGg5Esk+psJF2wyL2x0sk9tEnPHwMEKfSGdUrM2prUQdh8Pt3J0ib02oNPdh9pbqOgpcjZJp9iWtQLU2iUo8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5890.namprd10.prod.outlook.com (2603:10b6:a03:3ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 13:01:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 13:01:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Oliver Sang <oliver.sang@intel.com>
CC:     "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        kernel test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
Subject: Re: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Thread-Topic: [linus:master] [shmem]  a2e459555c:  aim9.disk_src.ops_per_sec
 -19.0% regression
Thread-Index: AQHZ4hUlovnTGopJRkWINRJx8jG2QrARAWsAgAVqhYCAAMJWAA==
Date:   Tue, 12 Sep 2023 13:01:29 +0000
Message-ID: <84984801-F885-4739-B4B3-DE8DE4ABE378@oracle.com>
References: <202309081306.3ecb3734-oliver.sang@intel.com>
 <C85F44FD-BC7D-421B-9585-C5FDFAEA9400@oracle.com>
 <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
In-Reply-To: <ZP++GV9WURg1GhoY@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5890:EE_
x-ms-office365-filtering-correlation-id: 5bf98335-2c1c-49eb-ce4e-08dbb390616f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lIaKfOHJhj0tc4AtW0tnIeULL4Crs15tyQgawBuzAmvu9GNt998iDyEXGUdE/fvX9QIK7UC+1Hzdh5mn42j9v5+eAbMHmzzGTjgt9nZZrunszTSc19Vs81l+9bGdzN961ntS51c/WHYBAZ60FbImFZvmIYx8+qeYxJUMRM+MGK2Vg9OGaKtXMjKA+Z0ovPNHntmpsO2rxFz0gG6riQHH5dEsl0CyECxh+H+kybp0IXnE38uJKa8R9g7jjWMS4oa+S4hhXaa28D5Z9K6Tx8KzKYbQSdr0g4weFEAUUEZRxcSFvYvmhXaDGX82D3C9AOn3fIe2+aAVYDqP/qkNPm5x2DlHtriFquaw27LAjmPRrwzyycbxg0mK3w6WYtnWxv0NSpcJu+yRDAhSXUXyJj5hbxKpc/ger87JwG7fvhJbUYEKjy1q0z8DUMyt1OccTO7+N5pmvH6ERbL2w79OyGpH0JNgA+dwxor/vh7cTRvMrzQnYPN1PcUU0Df0UXDxAXJA5kVQMraRAyEZDHlIGrypgjIRPwrUnM8yKt0hFDv2ghQdeqOL47KgDWd6ya2pvinuMYF1jsnex/xgi/o7kjkdbu1zwaaae0Rt0XrkjnPa2CtG+GepDhIQ6oUPm1Ll7VoZvwGi+lqBEwrVtU6K7N0N7lG2KjhuWWN+00qQWidaip5l9uK9MqOhtEijl5QgfNs5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199024)(1800799009)(186009)(54906003)(64756008)(66446008)(66476007)(6916009)(2906002)(66556008)(66946007)(316002)(5660300002)(122000001)(76116006)(91956017)(38100700002)(41300700001)(36756003)(33656002)(38070700005)(8676002)(86362001)(6512007)(4326008)(8936002)(53546011)(6506007)(71200400001)(26005)(2616005)(6486002)(83380400001)(478600001)(966005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YpGIIwJLJ2m7qlq3ZfE3QAnMcL5Njy5q/06VHp7AqM19BT/REZhSS0+Uar8e?=
 =?us-ascii?Q?kiiDHZpOu67qr+zYQqIQOdx9PcFSgEpBn0svTre/lYYiNm707b+SKCxI39mw?=
 =?us-ascii?Q?L8MuXX2dSN40y6aISyPXQaej6YUzGe+/OusV/U2xKRLppo85KL77MSk/EbPI?=
 =?us-ascii?Q?3kYXtb5gU9CtvIkQa0ZA1Sfc+gpflDoboJlCpOVvsNUzjMsSkcxv5LLf6Zzo?=
 =?us-ascii?Q?lYnkBoe9EV3Gkh41aWPIoKHn5qOpyyd49fTVjqDYAEKfzP97c92pKvgFalEs?=
 =?us-ascii?Q?3yaWgQ7E8kur4NvP0SpzLU+fxFtI4TuD5O+wjQpUoGydfEiEJkdPoq7x6YnF?=
 =?us-ascii?Q?fwqy/qBoN5O5hEVs+DxUnR1Vo/LBFTSseHWX7Sz05TgAxzEQ/zYzSA2jDM6D?=
 =?us-ascii?Q?AssiQhMXLgEh5HcJFL1AjyT8Zi9pTrMqfMgp/Paxa3JtGyfFZoJrvIpeqVjZ?=
 =?us-ascii?Q?XJlexg8nid0GXHMpm+AlqWmf+335AZeVSiDNwHsOVseYf5GXQ0O9rRa6dy2A?=
 =?us-ascii?Q?oN4UVKcsJxmUhVax9GN/zU1bOpobjjbARnaeRjLXPxTVjaBiidlFwGKChWrb?=
 =?us-ascii?Q?n5zhv/Xo7KQGXhjIKDC29RtxXuVXKXvYQApG1ws0KAjkqpxUSZI6H4ttGp76?=
 =?us-ascii?Q?ihivuQLkE23nudYldeZiMxPkiCz1WaGBr10UB4pP3mB8Oe7Amj8YS7z54jla?=
 =?us-ascii?Q?BaCoBOJScfA6W5YyzIUOIdVmKFyC4cTdgaIZIL70J2z7x+F17YaF/5vbIFJm?=
 =?us-ascii?Q?Scugznp/ezWZqpcogO3MSUnlFrHht+GO5YQPZdlY31obg1CL869SMfOKwl6S?=
 =?us-ascii?Q?0E1StlFp0cqGFJ/1X8p5EA7IUVLpfpQm8oYEG57QGg7XqAPv4ESm+tkmlwQg?=
 =?us-ascii?Q?wsK95I/aB6RqS3+LH8+FMJo7agneXmJrBb4A2GHyxOe1VCBwRXbvgy1tpM0p?=
 =?us-ascii?Q?S/2yUV2mkDja7GeUMrT4ba9KzbvhooTIACM/c0WtnBf0Q7UkdideLO400mEn?=
 =?us-ascii?Q?OwJBqMBPpg6s9uyetv+ihWgwo+thYuPen1jPDyYVTTEzctGlFern2TnRhD/U?=
 =?us-ascii?Q?TAbV26EltdmWnOny4xkhBJAjdwX9pGmy5Ud/VNNv4O4PgyaenouTwOPZIIA9?=
 =?us-ascii?Q?Ds2Heyn0CWmj4KhBsgzCdZrZ+9jh6IpLrtkQ8sE1r47wAqBrUB1+ztUPXTCZ?=
 =?us-ascii?Q?WhWyE4dn7akpeMxzM6Ggu3DvB4ULox74qnwEDRxbU9U0UDcLZ0No8kRDnd10?=
 =?us-ascii?Q?xg3NSKN1Pv72U/C+8vGZ7ShUusHle9avhIxNcXkKOnsYDzlgEjVnRjR4INrc?=
 =?us-ascii?Q?7XbnesFfxWFlsdnqTlyBqVNyub+D1I0ObTOt/RwZ15n+gQ6vcRH0FiSo/M8h?=
 =?us-ascii?Q?b2VoNBJDkPfSSbYEpWsMVm6JmCGyG0JpgMAI0R9/vYFhYj++Otb5zHvHTpnr?=
 =?us-ascii?Q?r4q0ZBFH2ITlSYAY+icihcv+Facql+BmMmB5XW/0exKHSt3MciE56KuhTlUI?=
 =?us-ascii?Q?9L+IbMG5XzUUNTnXx8f34ScgadQIH3l1SNpnFhaDZZjMv5nY0bmdiVmXh66C?=
 =?us-ascii?Q?dogNGNupImG92BxC2TPiRz0MWK+zjG6ULD5TfwFtvSc6Dxn4+Y5cnj49EMRf?=
 =?us-ascii?Q?tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87A60FE27CA00643B1D77E323CEE66D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hmvMY3prel5FvLzCx7PqeR80E1yY/wwesCp/iqH5YG8+h5zusDIeDJp+UCGYZ5d8QLGQLAADTm6Z0xvSm6c4iKrlqUA1I8X/DvCoVNUsT5d/f42udMAGN3uJAUKHQGz6b1o2z+UWOb+vi0nUiz1YXzpAiu+zud0y0wtkw0jVcAOVO87jP4kQ3b0CGNKX8OBlGp+dDTb77uI2B5w375iDFqRCXdZjX++N+WT+DS40P8p4ge5ZZqUVW26NncIFF4FGGdFVuEFbyRWgvDaGX4qbb0TCsEIYST0FuIe8S80lPp466ldl5fWLBO3jd0Z5Bw04bHZLoHE7E/YlOo9MStNbO/RYS7HvdXe4Dak4lOSuw9yNAVJoplyxEAu/ajY/F65YTJU0ZKJG1iZBRfLopHSwNWfWCWkK9bwB+yiD55hqmbfuIHbueYtQLTVH95a0VfDgDHJgPavd7dKlf992hGoiQ7LaU0s24FfMcy+3Ndx+hsHkF/VrfYgm5Ew8JjVnxiVxjLOBGQuE0sk7ioBj3UItPLQBD9LKJ4UfFA9QBcdxRPpzExFzOwHlYzr/hfW8mNQgyTX2XgGlYtCBzbMoFTjxh8SaEbcsx1OLwB1dY5JQ1Y3OR/IMfUXIG9vqx8ga7aec23EYmQT/3DZ1iQHt8jVG1xpn/cXS7q7T6yUq73yTV21x/V9Bq7aQ/1WhluXFBxb6iIPYXRopiIDX0FEbwyyFtV7NhihwdMw3BoiWL46WDmLJY/LiL97Mdqi2XRwWrHx+iUCr1BU5a+p12PGR63vgFQetWUTxMrqG9aftQarQw71w3Nm/Xm5TWPeUGH3gkvb+MSbj5GcdQH5K6KlOGlv+QX5MdsNBcj4Y2R4EbVm3cx3NEihWy36ABdSsJGg71BSb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf98335-2c1c-49eb-ce4e-08dbb390616f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 13:01:29.4184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bIgSY6Oa59gxoZzkVbKIqEQuBxs44OPQoZhe9ul2FDpwoCQFuuEqQfCHcex3MI4zXZqV5bfuyhNeN5J+XiqEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120107
X-Proofpoint-GUID: MyyeJh935eDPp0z0pNAWp_f4lbzY4KZz
X-Proofpoint-ORIG-GUID: MyyeJh935eDPp0z0pNAWp_f4lbzY4KZz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 11, 2023, at 9:25 PM, Oliver Sang <oliver.sang@intel.com> wrote:
>=20
> hi, Chuck Lever,
>=20
> On Fri, Sep 08, 2023 at 02:43:22PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Sep 8, 2023, at 1:26 AM, kernel test robot <oliver.sang@intel.com> w=
rote:
>>>=20
>>>=20
>>>=20
>>> Hello,
>>>=20
>>> kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_=
sec on:
>>>=20
>>>=20
>>> commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable direct=
ory offsets")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>=20
>>> testcase: aim9
>>> test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.=
70GHz (Ivy Bridge-EP) with 112G memory
>>> parameters:
>>>=20
>>> testtime: 300s
>>> test: disk_src
>>> cpufreq_governor: performance
>>>=20
>>>=20
>>> In addition to that, the commit also has significant impact on the foll=
owing tests:
>>>=20
>>> +------------------+---------------------------------------------------=
----------------------------------------------+
>>> | testcase: change | aim9: aim9.disk_src.ops_per_sec -14.6% regression =
                                              |
>>> | test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 =
v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory |
>>> | test parameters  | cpufreq_governor=3Dperformance                    =
                                                |
>>> |                  | test=3Dall                                        =
                                                |
>>> |                  | testtime=3D5s                                     =
                                                |
>>> +------------------+---------------------------------------------------=
----------------------------------------------+
>>>=20
>>>=20
>>> If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>> | Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.s=
ang@intel.com
>>=20
>> Hi, several weeks ago we requested that these tests be run
>> again by the robot because they can't be run in environments
>> I have available to me (the tests do not run on Fedora, and
>> I don't have any big iron).
>>=20
>> We wanted the tests rerun before the patch was committed.
>> There was a deafening silence. So I assumed the work I did
>> then to address the regression was successful, and the
>> patches are now in upstream Linux.
>>=20
>> This new report is disappointing.
>=20
> I'm so sorry that I missed the test request for
> https://lore.kernel.org/all/169030957098.157536.9938425508695693348.stgit=
@manet.1015granger.net/
>=20
> just FYI, when this auto-bisect done,
> head commit of linus/master: [65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4] w=
as
> tested, it already includes
> 2be4f05af71bb libfs: Remove parent dentry locking in offset_iterate_dir()
>=20
> in our tests, the regression still exists.

Thanks for clarifying. I wondered about that, of course only just
after clicking "Send".


>> But, I'm still in a position where I can't run this test,
>> and the results don't really indicate where the problem
>> is. So I can't possibly address this issue.
>>=20
>> Any suggestions, advice, or help would be appreciated.
>=20
> if you have further fix patch, could you let us know? I will test it.

Well that's the problem. Since I can't run the reproducer, there's
nothing I can do to troubleshoot the problem myself.

Is there any hope in getting this reproducer to run on Fedora?


--
Chuck Lever


