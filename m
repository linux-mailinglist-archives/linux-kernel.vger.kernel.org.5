Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC3A753BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjGNNd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbjGNNdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:33:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E4B30FC;
        Fri, 14 Jul 2023 06:33:52 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EDQZxM031241;
        Fri, 14 Jul 2023 13:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QpjekHMSX2cllauusKKhmktFNvzZYaaBG3vcqnlT79c=;
 b=cROPFXT7fYW2pzkv9JOX7GXKHPCK5XB3ONfI2KQzvs2P1bwWIRwcOp05J42mEZro4oil
 ZeVC3Vx0klpv+sfV4HoMssfEntOsH8ncj2md39jbnF6lukiYcxudrSqwctro5GUCGxns
 Xr4d5R1WOt/FoWnxxf2/l7WUmV9MBa9IzRcpteFY/kQ8zF1uez93eVGnXPiW1Qc8hXIL
 nI9qONu8MJQikJvdSsL6vzuStmGJbv/EH8qm9/yY5LGKO5gKC0Q4nRHH6rLu1BCqa+P0
 DhcRv+daBM2BvV6/U8QVggOcLauMfXagZNq5cCuq4Zf/Gqh0xNWheHH4YfU/YIXL16Pi 9g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtpth1h9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 13:33:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36EC0Xb1028378;
        Fri, 14 Jul 2023 13:33:04 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpvr5esq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 13:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bh2lg2bXrWrOGILHinc1/Ytr6Gok/+/ntzP2xTBFvp7Eq2wfWs8XCFP7FhdO74T8ckirPQUcNSicuD0clZ5qubd/6uROjWrZng26bX2tHqIEslztrfqPhc2Ac3p0ULQ/LCKguwH9pPIBInlDEoQ9uonpf4/4ubdf7mwfEjlfhWQTr5AeGaR5I3lYtyxNIV6IFDt2uV5kGgHx6XHjhtwCuCSAc+UIAoN7g1+Q2aV2SOgcwOEo/fOYErk+NnyIyRXSWZG4uYldzTtGxEIZDEnl3IrOV11MX+s+oI/xP3mBiwisgZgd6eMRTil3ZAlMKlaFhA+IkitJzg1s27oWpIf9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpjekHMSX2cllauusKKhmktFNvzZYaaBG3vcqnlT79c=;
 b=Dve+XT5Fp4mxavv8QCl8rXzfOIdH0snICR1tVgpNtvaioCPYPgEuOt0eEZm6SuczIgWcBcsTvefU+Twnnq1Zqmvwyufbmx5qtUQ2bWo/f2WoIAIWyEo7MwKphGXyr2bvftxWssL2vDe8O0Wu25QFxqzFXdkLrIwfKrqcVZ4RayggV0UsGthKllpISBkElYRwuuBgRRQz3sz3KGsipqoaTkC6KZGhj6pSuNoxMVXSRa+ULF36DpbKvM7LWyevniT6jUx+ND0EFZBJTWFFxcag+bN5zH863gEdvj1D4d3+c347UGVMZnAEslbncc1MhbYB/3LZPgfoPsQxC1OzdWRYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpjekHMSX2cllauusKKhmktFNvzZYaaBG3vcqnlT79c=;
 b=N6zr08432CWJ+znSeO+Y6pE2kCfxjGJ/aXaPxM349Pjn5nf+ClFR8JLgUwHnYsdNJ/E2b8OzDPlcKbb3qfs1xkclvHlPJN7U8cJhjLjs3avT99tB6NmhZDRd99Em3vdH7YxHg6+Uw+2GZglERYbBumz7jgXdlG/HYLfTo2h/EhM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH3PR10MB6883.namprd10.prod.outlook.com (2603:10b6:610:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 13:33:01 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5a68:4817:cdec:ca0d]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5a68:4817:cdec:ca0d%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 13:33:01 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3] integrity: Always reference the blacklist keyring with
 apprasial
Thread-Topic: [PATCH v3] integrity: Always reference the blacklist keyring
 with apprasial
Thread-Index: AQHZtfDNQNLB92MPCkaKMBtIuMBVY6+42/6AgABnigA=
Date:   Fri, 14 Jul 2023 13:33:01 +0000
Message-ID: <03CA1631-3A15-4191-A3DA-2DBFCE41A55C@oracle.com>
References: <20230714011141.2288133-1-eric.snowberg@oracle.com>
 <ecbf405c6806fa4706051e0bf946d742f3442367.camel@huaweicloud.com>
In-Reply-To: <ecbf405c6806fa4706051e0bf946d742f3442367.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|CH3PR10MB6883:EE_
x-ms-office365-filtering-correlation-id: 89af5129-ae2a-4f84-f8df-08db846ed823
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ReqkZMPkiIzRepRk+IG0TBP1y68w7qlH8pUNwKITePUguSi0Z+7k+yHUHQlKtawaAqEuGy2WO9bLIKMSa21KbS0MUHHw4bsfUQAeFu14lnul6xdoVGu3+cVkPiF7xoQodHjtFLYtpyIihs/Wh75AdPJCa+hAcz9dGkqihEieH5cXifZjrCh0xn5YOamIxcYRo2Fsarn0abh/Ld6P4hrF6h5bDNxGBUkRedi6ZKbrnA3SQPgtle2mzSnJ1k7GXsjdILWyd4PINtFkM21DPsdfJDqFy+YZ18VAQx1RAO1deDRpxwKi/4pFvH9fin7uWNqPwTy3GxwJu1AhMdB9Whq0Cllw+gfuKYr5iyflU8p8goqM/G0S2m8hl8ZB7RToHz2ujEijwmGuuR0NfSdRKa44oEjlBWy90R/s+/H2JevSHIVHa/R2duzeV+4kra7V42xfHHLHv/4QknjPNXFSPmUftmJbTfXkHaujLuCYCKa8CXkBcZa1SSjkFUFcaUkbBqI7LSChpc0AVE2BUHlhKX+l1dKo7zSwR8fjgzLpUA7kTc1t6BtwW5TE9eKYXkdtRqEOaFVyTP6Hal0aCAcGxyMessUXlM0WpX4bJ6jzIE9kQh1WIl4fWYU/o6QCcmmR8nV5fVqqUMbZumwJOEPKKjwW3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(2906002)(83380400001)(2616005)(33656002)(36756003)(38070700005)(86362001)(38100700002)(122000001)(6916009)(4326008)(316002)(66476007)(66446008)(64756008)(76116006)(66946007)(71200400001)(91956017)(66556008)(53546011)(186003)(41300700001)(6506007)(26005)(54906003)(478600001)(6486002)(6512007)(44832011)(8676002)(7416002)(8936002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p68YiBPVBZoK+uZa+xA/nrob5HErgMenyYGiHXr5OHQhf2BTB0fmJjumNMEW?=
 =?us-ascii?Q?Ux1TI//CVH+5RJ3EjJ39vgGxUkVHmP66AlhXNwheufvBclCYzuItjfCEF4Lw?=
 =?us-ascii?Q?r7tmZthIUNcu8PBsmyBFRWEhcmDjSwX+f+yKV0ZCuoKRt/vsoJ/doLLYkP8s?=
 =?us-ascii?Q?iKolgT5GmGvEBxVQKbMa4SGXAqc27stRVWrPuvg4DWAxDVnj+2DZahFPa41U?=
 =?us-ascii?Q?VxARBFSgLl7jSLQUwzSDi1nxDx/p/WhOWpc/S0WeEjAae7kdb/IqE5eWDwf8?=
 =?us-ascii?Q?gRrGCaSlCe5D8ZL4QXhLSkP9Fs8C4SzWEE1BRHkMgJGQbljEQzRWBLQrxNGB?=
 =?us-ascii?Q?Peu1GI0uALKisIuG+8WXiBaD2HT3olv3VV3VJOmsjD5K7TzJ8ZezDQJD9mPj?=
 =?us-ascii?Q?ksei8G18bZFrXyYEwjiGHAuHojsFPpDqwbvpl1RvDfZyfod5u0Y49cInfecY?=
 =?us-ascii?Q?0vFENfY7AyZ0CayV8ykCXYSWXwclBA0Ng9WgqQhDNv1f2i3v0x6680CNGop2?=
 =?us-ascii?Q?MVggvJjz9AJgGH1eRFkltoahLSHIqIMxE3AIKEJNe1mKIgG5wLcyDZ+HN8Sg?=
 =?us-ascii?Q?HJ1Y8beIpgnEDa6H4HlpGT4cYjwtLh2UEtZcIHwRzkDYNKF+aMXUh0194JS5?=
 =?us-ascii?Q?Kby2GXJQWbcdy1yM7rfZueox6UoTmxmeY9Q2OXs/Oge2AcaZB+kjMbjrVOj0?=
 =?us-ascii?Q?sx58Hi64Evm+m5twDb2JuOLjoviKJ8WDKKVE8F0LmwVWTVfrD3PKXI0VBrVD?=
 =?us-ascii?Q?1KmUxi5pZ25cqh4ezNWbYn6zRtF5LlAPo3u8/ug45TvqQacsRi2UlQYoQqEf?=
 =?us-ascii?Q?8rzMeoT36X0jLez4oCGaTEO/vfOIspBq4/+XaOuc5Z6FdbHyCvJl59GOLyS/?=
 =?us-ascii?Q?y5cOc2PA0BrCzhdicZ1kvC8kxwaxf1+Qk02bfrR6YCWwNctOhH/hKiAjw4AQ?=
 =?us-ascii?Q?OhrxLHCoQu8hk6AMMte5DtUXK9qyebq//NIKjk8ur/SOlCW6x6KqOutRRxst?=
 =?us-ascii?Q?BjJGYspd9T9T+yNRtaHu/FD0K+r4EDpN4Hxjx3B+CyrmJsrtYbuv5r732E0u?=
 =?us-ascii?Q?uUTSnEZNMvfnzbHXuazxhzABtFwKeRSFejGqwyAEWvCrm9UgseRdY8g+RtOS?=
 =?us-ascii?Q?FsHgHfC6GO2yvbWmc7kEoZRFczjoKuvmjgAtcG/u7t5gOryJTId/na10nEfq?=
 =?us-ascii?Q?K99zMeiXlyRDuTtv6rwzxc1Vb93g3oiVcM53/eEbQaZrHYrK51h3oxFIHG2j?=
 =?us-ascii?Q?syGgnUjERYgap1/YrlqHguOfm2PIY8+evO8+Ymc5oK5+wWv4z0c1ki76OFfD?=
 =?us-ascii?Q?JLYt5F17+QFNA9Ajv7oA35rOuWAXtVRtdye9vaxzZYC9rjWi/td1IxCz0aLa?=
 =?us-ascii?Q?PFjlGOwo3baZLK6S+48E9d2E8di8Qvb9l1wXJX3gu37dRvjLot5cL97QweT6?=
 =?us-ascii?Q?e/DjAP21Fo0haYRlFmF9ewUUDRbPu0C98VyN048FCWNTunXkJ5xVnljKcZ70?=
 =?us-ascii?Q?8FdM68rPyiPGZZ4X642dqLGxygZDvPvenyJ9m3XJqnDOT54NQ8JbUQSI3RYc?=
 =?us-ascii?Q?Do6ogJ7JF6gtZFQZlvJb+ML1FApEQ2XBAZ664haS+VN2wgyr5/4RSAO/u8Cu?=
 =?us-ascii?Q?2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC8D5FE0614F294AA1A4401A89AA2B8F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0JKPe3L+ZOTnUqTjrg2fcmJ5rFKyE+G0TfxfxCY9CxiuELLA/7VnCDgyB2eD?=
 =?us-ascii?Q?z2QF3E+rgJgW/62zzBgHa8m3VhVc4+3WbBR4cwqRbo6RcvU25+CQm1UA4gqe?=
 =?us-ascii?Q?9Mz1JpM1DlMEiamkNnov2+NxBN3lIsQkYVUXjyNNlxt/YH1QyW+8/8Zy8Zfw?=
 =?us-ascii?Q?w7ABz8C5xoBRbsx0ohhZCHhKArTlGXU0+46VxjwX5VIRTuJ09k3ud8Xqooxk?=
 =?us-ascii?Q?H17MiNkM4Y0dHwqE67OGJ/Nkahc7z8Vx4+qdIoI9t1gpnoIPeZEzRN7UaSDT?=
 =?us-ascii?Q?I6JU1yY8PPfzN+YUeWc4ophS+tbOmFn6y7Sdt6R+kfm8NMowaL+12BUU0TMq?=
 =?us-ascii?Q?uml++ImoZuzY2drtM2wWV6+0RFsJjw+lGz1nClcPNEPdA0dVQpUA4sNNG483?=
 =?us-ascii?Q?NLiHfq+VSAxSUvttYnxobw/fZs+2oNgW42/cxSsORKK351PnEgcLpqCwRxUT?=
 =?us-ascii?Q?DkomzMBejZ6bbxeg5+paL/drbay+AGL61Wp1uOddohsbyxPa1zHtuzmaKNJi?=
 =?us-ascii?Q?a0BgqwOCKhBPNFJlptcCQw81C5w4IqfKWa5KlxfVr6zrNwDqePO8xV24dPB2?=
 =?us-ascii?Q?vBcVRm0pxdugEsLrQVnTTclBNie1mn767tOG0q2z8uPfkzcrZfH6Y5ky8vBG?=
 =?us-ascii?Q?u4wmdVLNLU0VAr3Bojb7Zv3TPLr3c8E9JHWc4BJENaXaE+ZGLGy5hDCBgLIr?=
 =?us-ascii?Q?RDvVaESr1W1SrPACK7V3k1CPim/3inQF23As+f8zsuXh1Q8exvRDD7zTltj5?=
 =?us-ascii?Q?rDLeqTDtewAu55pMzqOIxkgRUIpBsLH1dhXpAR1VgCuUhTLCVJPsbY3P2FT8?=
 =?us-ascii?Q?Ums89LvIKPKOV5j8R457nC+NvBrpmApW81YJpMHULxdwAixPBZuJeoC9/KwK?=
 =?us-ascii?Q?H3g1FpN5oDdmERINIFlVYJO9yoCgec7YjIuuCmbFgwDuE0P/wRTyHo8QSS1/?=
 =?us-ascii?Q?TWfVYzQApspfYF7ITvWCHHtkQli5QxEzQ3nETWrrMWH1Fhet4psQKP1sWaCd?=
 =?us-ascii?Q?+3Sc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89af5129-ae2a-4f84-f8df-08db846ed823
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 13:33:01.0331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4MgZ8p34EpsswQOXY4tfBL13Rpwz9pVw6eXWb6pBIZirwZ6hLwDDYKTe0QI2ybpBZv+59Q3eIK3witwpOV6gnLCnNHfdi8PPtpYYAp6KWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140122
X-Proofpoint-GUID: kvwMhMbn3UKDmg-DQAO7fQtlmyP08uhG
X-Proofpoint-ORIG-GUID: kvwMhMbn3UKDmg-DQAO7fQtlmyP08uhG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 14, 2023, at 1:22 AM, Roberto Sassu <roberto.sassu@huaweicloud.com=
> wrote:
>=20
> On Thu, 2023-07-13 at 21:11 -0400, Eric Snowberg wrote:
>> Commit 273df864cf746 ("ima: Check against blacklisted hashes for files w=
ith
>> modsig") introduced an appraise_flag option for referencing the blacklis=
t
>> keyring.  Any matching binary found on this keyring fails signature
>> validation. This flag only works with module appended signatures.
>>=20
>> An important part of a PKI infrastructure is to have the ability to do
>> revocation at a later time should a vulnerability be found.  Expand the
>> revocation flag usage to all appraisal functions. The flag is now
>> enabled by default. Setting the flag with an IMA policy has been
>> deprecated. Without a revocation capability like this in place, only
>> authenticity can be maintained. With this change, integrity can now be
>> achieved with digital signature based IMA appraisal.
>>=20
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>> ---
>> v3 changes:
>>  No longer display appraise_flag=3Dcheck_blacklist in the policy
>> v2 changes:
>>  Update the "case Opt_apprase_flag"
>>  Removed "appraise_flag=3D" in the powerpc arch specific policy rules
>> ---
>> Documentation/ABI/testing/ima_policy  |  6 +++---
>> arch/powerpc/kernel/ima_arch.c        |  8 ++++----
>> security/integrity/ima/ima_appraise.c | 12 +++++++-----
>> security/integrity/ima/ima_policy.c   | 17 +++++------------
>> 4 files changed, 19 insertions(+), 24 deletions(-)
>>=20
>> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/te=
sting/ima_policy
>> index 49db0ff288e5..a712c396f6e9 100644
>> --- a/Documentation/ABI/testing/ima_policy
>> +++ b/Documentation/ABI/testing/ima_policy
>> @@ -57,9 +57,9 @@ Description:
>> 				stored in security.ima xattr. Requires
>> 				specifying "digest_type=3Dverity" first.)
>>=20
>> -			appraise_flag:=3D [check_blacklist]
>> -			Currently, blacklist check is only for files signed with appended
>> -			signature.
>> +			appraise_flag:=3D [check_blacklist] (deprecated)
>> +			Setting the check_blacklist flag is no longer necessary.
>> +			All apprasial functions set it by default.
>=20
> Typo.

I will fix that

>> 			digest_type:=3D verity
>> 			    Require fs-verity's file digest instead of the
>> 			    regular IMA file hash.
>> diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_ar=
ch.c
>> index 957abd592075..b7029beed847 100644
>> --- a/arch/powerpc/kernel/ima_arch.c
>> +++ b/arch/powerpc/kernel/ima_arch.c
>> @@ -23,9 +23,9 @@ bool arch_ima_get_secureboot(void)
>>  * is not enabled.
>>  */
>> static const char *const secure_rules[] =3D {
>> -	"appraise func=3DKEXEC_KERNEL_CHECK appraise_flag=3Dcheck_blacklist ap=
praise_type=3Dimasig|modsig",
>> +	"appraise func=3DKEXEC_KERNEL_CHECK appraise_type=3Dimasig|modsig",
>> #ifndef CONFIG_MODULE_SIG
>> -	"appraise func=3DMODULE_CHECK appraise_flag=3Dcheck_blacklist appraise=
_type=3Dimasig|modsig",
>> +	"appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig",
>> #endif
>> 	NULL
>> };
>> @@ -49,9 +49,9 @@ static const char *const trusted_rules[] =3D {
>> static const char *const secure_and_trusted_rules[] =3D {
>> 	"measure func=3DKEXEC_KERNEL_CHECK template=3Dima-modsig",
>> 	"measure func=3DMODULE_CHECK template=3Dima-modsig",
>> -	"appraise func=3DKEXEC_KERNEL_CHECK appraise_flag=3Dcheck_blacklist ap=
praise_type=3Dimasig|modsig",
>> +	"appraise func=3DKEXEC_KERNEL_CHECK appraise_type=3Dimasig|modsig",
>> #ifndef CONFIG_MODULE_SIG
>> -	"appraise func=3DMODULE_CHECK appraise_flag=3Dcheck_blacklist appraise=
_type=3Dimasig|modsig",
>> +	"appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig",
>> #endif
>> 	NULL
>> };
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/=
ima/ima_appraise.c
>> index 491c1aca0b1c..870dde67707b 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -458,11 +458,13 @@ int ima_check_blacklist(struct integrity_iint_cach=
e *iint,
>> 		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
>>=20
>> 		rc =3D is_binary_blacklisted(digest, digestsize);
>> -		if ((rc =3D=3D -EPERM) && (iint->flags & IMA_MEASURE))
>> -			process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
>> -						   "blacklisted-hash", NONE,
>> -						   pcr, NULL, false, NULL, 0);
>> -	}
>> +	} else if (iint->flags & IMA_DIGSIG_REQUIRED && iint->ima_hash)
>> +		rc =3D is_binary_blacklisted(iint->ima_hash->digest, iint->ima_hash->=
length);
>=20
> Curiosity (I didn't read the previous discussions), if you are checking
> if binaries are blacklisted, why not doing for the BPRM_CHECK hook?

Yes, if the policy contains BPRM_CHECK, binaries are now checked to see
if they have been revoked.

>> +
>> +	if ((rc =3D=3D -EPERM) && (iint->flags & IMA_MEASURE))
>=20
> Uhm, the measurement will be done only if you are also doing appraisal
> with digital signatures. But if you have only measure rules, you won't
> know. Shouldn't you run is_binary_blacklisted() also for measure rules?

This part of the patch is code that was moved down (see above where it used=
 to be=20
located) to allow for code reuse. Previously the measurement would only be =
done
when doing appraisal. With it being moved to this location, nothing changes=
.

>> +		process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
>> +					   "blacklisted-hash", NONE,
>> +					   pcr, NULL, false, NULL, 0);
>>=20
>> 	return rc;
>> }
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/im=
a/ima_policy.c
>> index c9b3bd8f1bb9..69452b79686b 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -1280,7 +1280,7 @@ static bool ima_validate_rule(struct ima_rule_entr=
y *entry)
>> 				     IMA_FSNAME | IMA_GID | IMA_EGID |
>> 				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
>> 				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
>> -				     IMA_VERITY_REQUIRED))
>> +				     IMA_CHECK_BLACKLIST | IMA_VERITY_REQUIRED))
>> 			return false;
>>=20
>> 		break;
>> @@ -1355,7 +1355,7 @@ static bool ima_validate_rule(struct ima_rule_entr=
y *entry)
>>=20
>> 	/* Ensure that combinations of flags are compatible with each other */
>> 	if (entry->flags & IMA_CHECK_BLACKLIST &&
>> -	    !(entry->flags & IMA_MODSIG_ALLOWED))
>> +	    !(entry->flags & IMA_DIGSIG_REQUIRED))
>> 		return false;
>>=20
>> 	/*
>> @@ -1803,11 +1803,11 @@ static int ima_parse_rule(char *rule, struct ima=
_rule_entry *entry)
>> 				if (entry->flags & IMA_VERITY_REQUIRED)
>> 					result =3D -EINVAL;
>> 				else
>> -					entry->flags |=3D IMA_DIGSIG_REQUIRED;
>> +					entry->flags |=3D IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
>> 			} else if (strcmp(args[0].from, "sigv3") =3D=3D 0) {
>> 				/* Only fsverity supports sigv3 for now */
>> 				if (entry->flags & IMA_VERITY_REQUIRED)
>> -					entry->flags |=3D IMA_DIGSIG_REQUIRED;
>> +					entry->flags |=3D IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
>> 				else
>> 					result =3D -EINVAL;
>> 			} else if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
>> @@ -1816,18 +1816,13 @@ static int ima_parse_rule(char *rule, struct ima=
_rule_entry *entry)
>> 					result =3D -EINVAL;
>> 				else
>> 					entry->flags |=3D IMA_DIGSIG_REQUIRED |
>> -						IMA_MODSIG_ALLOWED;
>> +						IMA_MODSIG_ALLOWED | IMA_CHECK_BLACKLIST;
>> 			} else {
>> 				result =3D -EINVAL;
>> 			}
>> 			break;
>> 		case Opt_appraise_flag:
>> 			ima_log_string(ab, "appraise_flag", args[0].from);
>> -			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
>> -			    strstr(args[0].from, "blacklist"))
>> -				entry->flags |=3D IMA_CHECK_BLACKLIST;
>> -			else
>> -				result =3D -EINVAL;
>> 			break;
>> 		case Opt_appraise_algos:
>> 			ima_log_string(ab, "appraise_algos", args[0].from);
>> @@ -2271,8 +2266,6 @@ int ima_policy_show(struct seq_file *m, void *v)
>> 	}
>> 	if (entry->flags & IMA_VERITY_REQUIRED)
>> 		seq_puts(m, "digest_type=3Dverity ");
>> -	if (entry->flags & IMA_CHECK_BLACKLIST)
>> -		seq_puts(m, "appraise_flag=3Dcheck_blacklist ");
>> 	if (entry->flags & IMA_PERMIT_DIRECTIO)
>> 		seq_puts(m, "permit_directio ");
>> 	rcu_read_unlock();

