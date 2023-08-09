Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B3F7764DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjHIQRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHIQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:17:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE16CE;
        Wed,  9 Aug 2023 09:17:15 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379F7UwL015277;
        Wed, 9 Aug 2023 16:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=Wo/6kfzeHoYrpEe9xmaECGG7d6fPFTIHAia96Y2Abfg=;
 b=FF3keMIL5IJQGCPRogrkYtjLE9b5WVjFAteWsktynAjcC6oFEt/rDdaVz4RnN5eExlsP
 BR44GJlbmZB6ACekhCPl0oQZWqQ2otUX8YDheAK8rlOhr9jA4tzTmkwmohC46rzg3M25
 b0XmtgQrrllBJE4s1w8s2fYAfcgOSdhtCax65A6i0nirLTDnKEqWCoXhWBFPQU0vgiUO
 nSEaC5XBQUZmExw0gMcZgw+pSaDRpP477tlm4ry3j+MG72ziLxmaewFm8SIRtIblt1Qz
 Gm8xk3c42Ugh9UD2wFBwynZqOOzpxtE0hIbIymM6aq/JA2v1ktLATjZk8V1JGVvEjmwG HA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc1ny1rfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:17:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN1C2/biMcCcMIvY1ZH32J1KP88l6EGv1iGaD0GHrJVKTYvcQ47WZ3Yy3zFnS+cqfr051K+owysyjd2syWToNNUdDm4egs4fJwOqx6y/TadorfFkv/9JG4Rmva1MwEFEhjmzTke4QuFI+SgWYgRH10qYXlznwiZxQs30ZmmR2Zeiuhrx0RBFIWr0gCGJbdCcZ6CchCRA7XnVaF0MtUoZbTPoioOhNHLjqsWkbrJwenCQsshzaSu9aTB5EIIaftmS4AuTgJ8VoN/tsYA4mRlo8k68UQ69bEQVeiJKmwvLGjQrPNsWywphXfJ46W7vU7+5+MnD3BCbqLAvSaxTU6bd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo/6kfzeHoYrpEe9xmaECGG7d6fPFTIHAia96Y2Abfg=;
 b=cQejsY/qF6j44Q6yLNc+3QOflUvyvHk9ycd6uEXf7mOqFJh8wW1g5/B3HHSTVpzHl46PE75JVN6CE8dtSTMuhTY47c9RZ/Hmpw9hkxXi+sC30620i/SRWUc56o4T7oF/stv90OcC2OzxHKLOkK8UtvT9/P6An97fZ/z7Xb/IoAXenwoRyQmiDOPDt2UjvD0k3Jv20CvGbf7cTWjGziNbKgg0ZDePsBzwnHmCk/MugYAaesmur9ch8SGGdxqcd4GO6p3CNYmjoKjU/YC12v5ulqtSm3xCXe+lT4lOrAqlrhZVP3BCYfE6Cj5Ip5A+4Bzaa9L+o0DpFy1FxhLZexoiOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by SN7PR02MB9352.namprd02.prod.outlook.com (2603:10b6:806:328::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.18; Wed, 9 Aug
 2023 16:17:08 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::1329:89ed:4c1e:a28d]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::1329:89ed:4c1e:a28d%5]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 16:17:08 +0000
From:   Brian Cain <bcain@quicinc.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Hexagon: Make pfn accessors statics inlines
Thread-Topic: [PATCH] Hexagon: Make pfn accessors statics inlines
Thread-Index: AQHZydJ6eksC8mofJ0Cpmob5aQDN36/iJg3Q
Date:   Wed, 9 Aug 2023 16:17:07 +0000
Message-ID: <SN6PR02MB4205A0DCD5355ECBAB39A0A3B812A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20230808-hexagon-virt-to-pfn-v1-1-68d07c221f17@linaro.org>
In-Reply-To: <20230808-hexagon-virt-to-pfn-v1-1-68d07c221f17@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|SN7PR02MB9352:EE_
x-ms-office365-filtering-correlation-id: 77f17ab5-9048-4598-89d8-08db98f41412
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jLXypEVnwzt8WU1ufg+aiUzpAOQwEHopxfxOQAIPKino6d+KKx3fkhlkYLfcSVt3gyQAFGxp9UQbhpYRRZMntDKxS7XSONcjIHkOBay06xJB3gcNdPN8KzhCn+9I1cJd/+j5HLh74zwDeqA8Pf/GRzIRf1Jbrp/5AykfuYUmg5G6HZvvvMouNznW6j5Lqx5RFi7KayRNbROkdiHjA8Nna9FoRXLQTVjwCH++Kda0o/84SIbg4kdixor7SP1/idwnC35Mg07nldL9A8tRbMszv/EXvhS3dDQwiwkyAvw2I3FAr7xhza5VDyfjUeuei7r/PekhyTgeB/2hKYEFSQcrPaAIXk6Q+hxT9LupuVYeciS8i73JLhQJAREkyBs9/dqU2eiS7RpgxixbMf0yCkN+/94fqhHf5vImC8sRx/1oqwdSMdUTTKQQC832KVm7DLTRPF6DfgjGJ4vol1KAE1+GDt4V0K+88vksGZiv2QDLpN5oA55VtA3UWalpMZuj7pGiLE9tAYTohphUgma4alFSrbLU1EqfDoeoZUowAHBGXdYUteHd9oCiw63iqyQo7OhCZAKargYzYGERxIGbdu1UHn4ajENxPm0dmIpKonBR5EVNQnGqqQzdiiENuyeHOA3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4205.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(1800799006)(186006)(451199021)(7696005)(478600001)(9686003)(54906003)(6506007)(53546011)(26005)(71200400001)(2906002)(4326008)(64756008)(316002)(66446008)(6916009)(76116006)(66556008)(66946007)(52536014)(8936002)(41300700001)(66476007)(8676002)(5660300002)(122000001)(38100700002)(33656002)(86362001)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGlFSng2VG44SFpFaEd3TnBaRlQ1OXNlcTYyZytCQ2FHejNtVi9hcWxRRmho?=
 =?utf-8?B?UkxPOHMrekdyVDQvaXVMNHBya2xCb1VEbzhTNkNuTFBJamR2T0Jtbi9ESDRN?=
 =?utf-8?B?QjVoM3RwNzV6TGlVejV3dmxZNlhjZTVlQlNyUWtnOE4xZis1U1hMZGpUMnZx?=
 =?utf-8?B?aSsxcEVHTXkwSE9OMTdkaXBOeUc4SDdYYkx0U0NVVlU3ODUzSVpBY1lUUyt3?=
 =?utf-8?B?OHlpRXAyVGZmNnZQTmcwdHdjZWZ3cmwvRzJhT2Y2VjJna3lJenBnRGozN2Qx?=
 =?utf-8?B?SlJFc3N6VkRiS2FLaDNsK25KclN4TDcrVnJVdFZsTEROUEVmQ1pldTZqM2cy?=
 =?utf-8?B?SGFmZVhmd04yampPU0ZyNXF5cS8za0g2bmV1RDZvUEt4WVJMVURyREVacGZy?=
 =?utf-8?B?SVZobHM1UTRyL3ZUaDZ3S2xjNmI5VC9LSzZhR1o2UXNLQnM5VXJEWS90Wjlh?=
 =?utf-8?B?bXVhZlkzelp6YWlmQmtDSzFBTC9jRFl2NmhxTGlkYWIzRnRnbGZ6Tkp0Z0dT?=
 =?utf-8?B?bHYvZnptQ3hZTXl5bTZmd0RTSW1Vcnd3eHJnTjVCUWNDNkVGcytJUFYzNmNU?=
 =?utf-8?B?bElkR0o5QkJwTDh3c3ZOSXB3NzRWUVVBVzcwNHVCNWZFaFQwaTYrcHBqK0Zu?=
 =?utf-8?B?SG5IQlNDYVkzSEdON0FNQzRpanJJVXVUS3N1clc5RkJ3Vkl6dlllOWdzZVdI?=
 =?utf-8?B?TU9yVXFFbldiNWNQU2xKRE56REpTcUcvRFp3TGgwUnNobW1COWxXZUUzMC9J?=
 =?utf-8?B?M01pZXRnOHRTdTdELzRkQ3ZYZCthdThKaGw2WE1PRXl4bFdTVkpMV0syOHBn?=
 =?utf-8?B?M2NTUW1VY09xNnVCbHhid081UUtLcnFyQTRhMUl0ZVU4R0VMYjVRcWNBaks4?=
 =?utf-8?B?ajJ1ZmttbEhWZlZlaU9KNWxWSmpjdXJoaTl1MzREeUJKa2F2RVJMSE9wSkRN?=
 =?utf-8?B?YXFTRm5PS3dRL1ZMTXBEMnVTVkszOWpVUjh3N1FVcVNxRkFiSzlnRzREdHUr?=
 =?utf-8?B?a0dwZDRJTmJyT2g1TDNrbERVOE0wRzk4czNHcDNLdlNkaElWTEhzd1lrejdT?=
 =?utf-8?B?bFpLUlBqSVRwYk9TNXhjZjN1T29QRVp6NFhhRldFL1psMGd5K3V2bEJTMkVQ?=
 =?utf-8?B?VDN1SDYzM2V2Z1VHVDV6bEZBbDlXQTNYL3VRbUV1UERYYVlIRmZuaW5lMVJJ?=
 =?utf-8?B?K25SRWRtMEVzaWNHeUJBaWRrMnFuN0s3LzcxbGJyWVcxaU1Vczh1b09lS2o3?=
 =?utf-8?B?dU4ranp3V0dUTnI4N1lZNDZ3UjROM0IxNHQ2cUh3eE94blFsOU9Jck5qS3JW?=
 =?utf-8?B?alB3N0hiN05RQkhSVGx4WlFmZUdPdFhTODUzN1BDYU5UTHJwVXVRNU1GY2t6?=
 =?utf-8?B?YlI5N3FLL3RIbUxWVndSOGpteDFpWE5aWUpmeWo1SFV3YUJEdlFaRWFCMGI0?=
 =?utf-8?B?aGYrUFRiN0VXck1mRVpGV0NBUU5QeHljVEFVb0d6OEdmVWdseGpqUmtMbUE3?=
 =?utf-8?B?ZzNmclRDNDR0eEk2SWIwbVV5K2hwRTF3YS8ydHI3MmZKUm5OWGVKTXdkaVhE?=
 =?utf-8?B?Z1QvVjY5VUpCOWxWV1kxaGxyVXVRSmZ2eStHVFVIYW9MQnZVdWpMU1FhUU9Z?=
 =?utf-8?B?OWNYQUpMVVZkNkZHMlJ6UmI4VmxJSWhscThFSVpibWhYNW5BVDYxUElhbktj?=
 =?utf-8?B?ekhGdnVOTDg0Mmd3NCtPczNlNmN2MnZEZkdzWm42NzkyK3ViVzVabTd3OHAv?=
 =?utf-8?B?NzMvYmM5OVB4Wk9FSlhsTCt2VE1iazlRYjdlRTNHZmdFUjNHeWVHOUlza2ZU?=
 =?utf-8?B?MDZSaWVtUnk1b096MUpZVjhad2psZk1yWEVtZ01rTC9Fa1JvUDRBeHhYcUVW?=
 =?utf-8?B?Yi91dkxjemlLRE5NL1Z6TDBCTjBYdFRWSVFDS09VdVI4VDZCb205dFl0SDEx?=
 =?utf-8?B?WWYzbEVoMnY5RzJjV0tzZHJwWURGSTNSaVQ4OE9lakR0OEg0SzU4Q0pFYW5w?=
 =?utf-8?B?YTFxS0RIYS8zL2UvbEVrTXgrbVBCZ3JMcU1nbk1lQ05EWkNoaG44YW52UHRx?=
 =?utf-8?B?WUFyMTVwV0hiTk1zVVFBUmllMzdvNHNGb1lMU1ZGT1dFdTN6REFFWEZHSmsr?=
 =?utf-8?Q?ftVQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hb3dLybN0C5smWxV6tjvmBkfyXRa8R+fxp3igOgyvzkXbMjNORfaP+s3VzBVEkNfRF+6HcZJGDgYSz8uBIxk+dEVROPvZ6dVxzg7hKBiKe9Lg6m4YgUTy6xoI/XB2fiX3WSmwGcX0IxDyX3Q7PqXINsRvoMsNKmq/T+3AK6tghBk/4qQMOCvDIONvda13gedWGnKXo5Fl+2gUY2Bkn+lx4dZSh7YyWzfozf8FfEIztp5/vXYxjY1ZuMA1Pnk2DUQFd9HYgdtk0PRz0D3nEfio7idA3TB6IwmLtZgf8+di/Bzyp9YloqsIeaeiJ9IDkaytZS8bF51+6WW5/basS+/sCd0c3hlx5yZfdYR7h9ou1yoEPooob6jH4VjATLZ08JhbR8wMdKEvGNcTSURcvIC84qU/JmBELdfDdFpbIuY8SPfb+AD9hrv5AXTUVXuDYScXgJmL1AhHcp0ScVokUF4Bm//8fGBmzz0BmPkz4gws/JDXzdAmFhZ+mYpNZbeVMt2VLxGjrEUyAf8j3/lsjvBhBlGv/PLBiCtA0KKaXC3nzvj1pX4uF6pYejxgRxBMbXs8tE/fQbx0IYJFr7nyKkBk8bBP43Qh+XykK2p4zTY00EprkpfFhaympYm20u44UfNt04t7mYV2OoIOP5gVdE/lDHYkJc/pcSbHTB4wX79loeyGqpuTceb4gf1uOlP47XoUjxpvL9VKXPfPln9qCvb6UvHkWrjULwOYueNwI76gauRjDiQlis+TI1mAFKVNQ9mpyHUXMXGfeuxILDOx/KxSX6AvUUzSSVODT7sqMEO0a+Wtf7ip9GHRJW/xtbuBJrs
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f17ab5-9048-4598-89d8-08db98f41412
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 16:17:07.8811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrJyewm+14SXLcQfZviFpe0+BT892EEsL2ZMx+VkjY5QqU5i9b6ncjUEOc+aW9TiE7Rm++qtgsLhktactOGPQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9352
X-Proofpoint-GUID: ZySdubMiCZLUaIoFWobmxs670fHsFWtG
X-Proofpoint-ORIG-GUID: ZySdubMiCZLUaIoFWobmxs670fHsFWtG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_13,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=356 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMgV2FsbGVpaiA8
bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgOCwgMjAy
MyAzOjMwIEFNDQo+IFRvOiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCj4gQ2M6IGxp
bnV4LWhleGFnb25Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBMaW51cyBXYWxsZWlqDQo+IDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFN1YmplY3Q6
IFtQQVRDSF0gSGV4YWdvbjogTWFrZSBwZm4gYWNjZXNzb3JzIHN0YXRpY3MgaW5saW5lcw0KPiAN
Cj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29t
bS4gUGxlYXNlIGJlIHdhcnkgb2YNCj4gYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8g
bm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBNYWtpbmcgdmlydF90b19wZm4oKSBhIHN0YXRpYyBp
bmxpbmUgdGFraW5nIGEgc3Ryb25nbHkgdHlwZWQNCj4gKGNvbnN0IHZvaWQgKikgbWFrZXMgdGhl
IGNvbnRyYWN0IG9mIGEgcGFzc2luZyBhIHBvaW50ZXIgb2YgdGhhdA0KPiB0eXBlIHRvIHRoZSBm
dW5jdGlvbiBleHBsaWNpdCBhbmQgZXhwb3NlcyBhbnkgbWlzdXNlIG9mIHRoZQ0KPiBtYWNybyB2
aXJ0X3RvX3BmbigpIGFjdGluZyBwb2x5bW9ycGhpYyBhbmQgYWNjZXB0aW5nIG1hbnkgdHlwZXMN
Cj4gc3VjaCBhcyAodm9pZCAqKSwgKHVuaXRwdHJfdCkgb3IgKHVuc2lnbmVkIGxvbmcpIGFzIGFy
Z3VtZW50cw0KPiB3aXRob3V0IHdhcm5pbmdzLg0KPiANCj4gRm9yIHN5bW1ldHJ5IGRvIHRoZSBz
YW1lIHdpdGggcGZuX3RvX3ZpcnQoKS4NCj4gDQo+IEZvciBjb21waWxldGltZSByZXNvbHV0aW9u
IG9mIF9fcGEoKSB3ZSBuZWVkIFBBR0VfT0ZGU0VUIHdoaWNoDQo+IHdhcyBub3QgYXZhaWxhYmxl
IHRvIF9fcGEoKSBhbmQgcmVzb2x2ZWQgYnkgdGhlIHByZXByb2Nlc3Nvcg0KPiB3aGVyZXZlciBf
X3BhKCkgd2FzIHVzZWQuIEZpeCB0aGlzIGJ5IGV4cGxpY2l0bHkgaW5jbHVkaW5nDQo+IDxhc20v
bWVtLWxheW91dC5oPiB3aGVyZSByZXF1aXJlZCwgZm9sbG93aW5nIHRoZSBwYXR0ZXJuIG9mIHRo
ZQ0KPiBhcmNoaXRlY3R1cmVzIHBhZ2UuaCBmaWxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGlu
dXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gIGFyY2gvaGV4
YWdvbi9pbmNsdWRlL2FzbS9wYWdlLmggfCAxNSArKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2FyY2gvaGV4YWdvbi9pbmNsdWRlL2FzbS9wYWdlLmgNCj4gYi9hcmNoL2hleGFnb24vaW5j
bHVkZS9hc20vcGFnZS5oDQo+IGluZGV4IDljMDNiOTk2NWYwNy4uYjNkNGEyYzA2NWJlIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2hleGFnb24vaW5jbHVkZS9hc20vcGFnZS5oDQo+ICsrKyBiL2FyY2gv
aGV4YWdvbi9pbmNsdWRlL2FzbS9wYWdlLmgNCj4gQEAgLTc4LDYgKzc4LDkgQEAgdHlwZWRlZiBz
dHJ1Y3QgcGFnZSAqcGd0YWJsZV90Ow0KPiAgI2RlZmluZSBfX3BnZCh4KSAgICAgICAoKHBnZF90
KSB7ICh4KSB9KQ0KPiAgI2RlZmluZSBfX3BncHJvdCh4KSAgICAoKHBncHJvdF90KSB7ICh4KSB9
KQ0KPiANCj4gKy8qIE5lZWRlZCBmb3IgUEFHRV9PRkZTRVQgdXNlZCBpbiB0aGUgbWFjcm8gcmln
aHQgYmVsb3cgKi8NCj4gKyNpbmNsdWRlIDxhc20vbWVtLWxheW91dC5oPg0KPiArDQo+ICAvKg0K
PiAgICogV2UgbmVlZCBhIF9fcGEgYW5kIGEgX192YSByb3V0aW5lIGZvciBrZXJuZWwgc3BhY2Uu
DQo+ICAgKiBNSVBTIHNheXMgdGhleSdyZSBvbmx5IHVzZWQgZHVyaW5nIG1lbV9pbml0Lg0KPiBA
QCAtMTI1LDggKzEyOCwxNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY2xlYXJfcGFnZSh2b2lkICpw
YWdlKQ0KPiAgICovDQo+ICAjZGVmaW5lIHBhZ2VfdG9fcGh5cyhwYWdlKSAgICAgIChwYWdlX3Rv
X3BmbihwYWdlKSA8PCBQQUdFX1NISUZUKQ0KPiANCj4gLSNkZWZpbmUgdmlydF90b19wZm4oa2Fk
ZHIpICAgICAgKF9fcGEoa2FkZHIpID4+IFBBR0VfU0hJRlQpDQo+IC0jZGVmaW5lIHBmbl90b192
aXJ0KHBmbikgICAgICAgIF9fdmEoKHBmbikgPDwgUEFHRV9TSElGVCkNCj4gK3N0YXRpYyBpbmxp
bmUgdW5zaWduZWQgbG9uZyB2aXJ0X3RvX3Bmbihjb25zdCB2b2lkICprYWRkcikNCj4gK3sNCj4g
KyAgICAgICByZXR1cm4gX19wYShrYWRkcikgPj4gUEFHRV9TSElGVDsNCj4gK30NCj4gKw0KPiAr
c3RhdGljIGlubGluZSB2b2lkICogcGZuX3RvX3ZpcnQodW5zaWduZWQgbG9uZyBwZm4pDQo+ICt7
DQo+ICsgICAgICAgcmV0dXJuIF9fdmEocGZuKSA8PCBQQUdFX1NISUZUOw0KPiArfQ0KPiArDQo+
IA0KPiAgI2RlZmluZSBwYWdlX3RvX3ZpcnQocGFnZSkgICAgIF9fdmEocGFnZV90b19waHlzKHBh
Z2UpKQ0KPiANCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogMDZjMmFmYjg2MmY5ZGE4ZGM1ZWZh
NGI2MDc2YTBlNDhjM2ZiYWFhNQ0KPiBjaGFuZ2UtaWQ6IDIwMjMwODA4LWhleGFnb24tdmlydC10
by1wZm4tNDU3YmQ1MWE1NzQ0DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IExpbnVzIFdh
bGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCg0KQWNrZWQtYnk6IEJyaWFuIENhaW4g
PGJjYWluQHF1aWNpbmMuY29tPg0K
