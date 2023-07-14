Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C76C7535E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjGNI7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjGNI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:58:55 -0400
X-Greylist: delayed 5959 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 01:58:53 PDT
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B767E26B2;
        Fri, 14 Jul 2023 01:58:53 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DNKFuq006459;
        Fri, 14 Jul 2023 00:19:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=W+64vxahE9VVgqUrPXaYSSnf/z3FI7BI6CIYdOQF1MA=;
 b=lyhrn4ImGmf1d7N49s7rzwqYgp6LFPzeLTO3N25lL4vPImfnpZ44NmlZkXZNE0yeYtk/
 Xak5n0VaBzlHGIpTPeZ9+oWRY7wEwqHJtIXMqMlVlMZuGJaL6XKm1tC0+2dau3X1aiFb
 vMSywiRZ6CxYnhRVUKgcUGQYvd+FhtxROa8pc+r5ug4IcuOAVkAvzOLPWqX0OlbYinQQ
 mQZAcAIuR0KdrwAipI3++DrxxURhskFXuhFkZI2k0wBUMyyhxRUjs/2kwdoVhL2Zki6y
 n3QS9sSJGBr5SonnRd+cUrDmt2kImO3X3cNsh3NQE2Ex6tl2qr4+NajeN4DnHWFR5JJk Cg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3rtputa368-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 00:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4XD8NOIBlgUcuq8g0saym9M7km8kypDNOOhRHQReqGia9DDj9zrSMliKFJwyP3EY2QtIlBci5QLUxnJlMp33AN65uauO6SUiHTdEnsygvtNjzz1wfvwiI0PvpBxcmMDvQvNFMhRHKTIxVUmN7QnYsxYNpI+XWjknQPj3OArEr3OFvBaOQHiHrIMBH4bE2a2tyFmAehDryePqeT7MfVlwCT54I4nTxoEpEeUOi22VwBPguuO7mzhgsxIb9CIKVONq92gmhN0tKQn9oyWJP64bCer2LZgLapkS3aW9xcAZk1gbr0OLnlPXCTf+o7wicEJHwK6DwYlmqDJupwzdWLE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+64vxahE9VVgqUrPXaYSSnf/z3FI7BI6CIYdOQF1MA=;
 b=eDFSx3QvIqrEYWqm0a+7Jv/XMs0mDzblhQSwuS4ciw7dHvcT//3nGwz2Af0ttf7Jjv0oUiaNUR3ak8ehj1Ymi3UU8PWfYjpEUAHYjPpkPbXumIM3G1NhQ3waGw0oC/cbSEi2v7PJesN7vcqfpD8nmAGaBYL074mBcpDkuEBbu9TLj12SQ7FIr2QKJKofmsSV5dLeRqXQW5Bvl4fkjSrs58Uinv83YbtkgE3VsaI9pbHqSgwANqCE0wMZApUqqinSDsRQ8mYgrCuivju6MyqmLdTeU3qqChTiNhkF3MyNAC2tGu5neH6RyjG39ASt3rd8J0w6RAKx170YBpO/T9zPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+64vxahE9VVgqUrPXaYSSnf/z3FI7BI6CIYdOQF1MA=;
 b=hovY4OdStS4HJUVFfX8Pa4LXNDw4h0FD3i5+AAmUikqMcxdZZmdMMc2PJSCvbA9OGDgchh0XaDPLdZwmxu9BlRXN1do0MH+1Cwev4IKL6rm2JSAPzT89yKEEYwfZjoT+fdlPxZV444S2N2nRAiHhxL9C216mPKfbjq8UH+++qMk=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by PH0PR07MB9236.namprd07.prod.outlook.com (2603:10b6:510:117::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Fri, 14 Jul
 2023 07:19:22 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::2c3a:d722:8479:28e9]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::2c3a:d722:8479:28e9%6]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 07:19:21 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Fixes issue with dequeuing not queued
 requests
Thread-Topic: [PATCH] usb: cdnsp: Fixes issue with dequeuing not queued
 requests
Thread-Index: AQHZtWIUOnzlmDC91EyICLRPIn7cGq+4hxoAgABUPOA=
Date:   Fri, 14 Jul 2023 07:19:21 +0000
Message-ID: <BYAPR07MB5381BA3F7A34D18BC16B86DFDD34A@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20230713081429.326660-1-pawell@cadence.com>
 <20230714021436.GA2520702@nchen-desktop>
In-Reply-To: <20230714021436.GA2520702@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYmVhNjc5YmMtMjIxNi0xMWVlLWE4NmQtMDBiZTQzMTQxNTFlXGFtZS10ZXN0XGJlYTY3OWJlLTIyMTYtMTFlZS1hODZkLTAwYmU0MzE0MTUxZWJvZHkudHh0IiBzej0iMTQwMyIgdD0iMTMzMzM3OTI3NTg4NDMwMjI3IiBoPSJIRVVEazdIU0dFcjhKYmozbVVjVU1IVVV2V2c9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|PH0PR07MB9236:EE_
x-ms-office365-filtering-correlation-id: 9e908f0a-b8cc-4a82-5d73-08db843aa52c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1hf0VAN7xvqTBqX26ujJT38mmHuSX8yd7M0D2x5vyO/eVKv2W5dy6Fn148CE2gfwLEXXi8hWlc/FINNeLQ2wqX1SDERxn9KQrLBs/uWZy3YraMhW/rddiCfh8wN8b4+Mnptifh6Gz5bwQfyXYSxW4K3X58iAhHnyyscFziH2vHs9JFdpNXF1s+escPAkMJ7/IwKB9X23fp4Nu+oTM6yW3kLdLNPrlBnpnXnKTA6Tr2NOM6gEzy67bjbd2WLWxvqe3yGPCFF+qXEM2T6Y3VgXwjqUWpj3ycG0ZxQXTbY/fZ/hHmB3hY1BLOQnwPDKr3gNnPXqvX0RrQl8llcG8fla6uu73FmT+WzhSV/Mh9jcemi3ubpMDJDNr5h7r3plNHFiqLkiuKRQepjxsgKdoMRVz+9vH/i4QMfIRWfexRkfNMZ6H+QHmypRI5RRohEFQx8JEKIDr9ZW4RsSMhyke71pePGAM/VqgMjicfg+uQfu6EEcsjN183Efy8OPMUhhbsNlhHX7Fa06Wwm2b+dPydKn2HDsyU09Ue7yIj5RW8VSz2kcdcE4//y+PxCl3yzJjU78NQhgG8azyCxwjkDqV/Y4PSYIKoXrPfHiV/YfzrtYMU5YAY25jRBf/dpsB3DbFXlR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(36092001)(451199021)(52536014)(83380400001)(8676002)(8936002)(38100700002)(5660300002)(2906002)(186003)(478600001)(26005)(122000001)(41300700001)(6506007)(54906003)(38070700005)(9686003)(55016003)(71200400001)(86362001)(66446008)(6916009)(7696005)(316002)(66476007)(66556008)(76116006)(33656002)(4326008)(64756008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Njh/prtfWY6H7KR7rqWyiKdPGR0KICi+cgxM0uR6OXyDq5EI08b0KF0u7fc?=
 =?us-ascii?Q?XaOP9qppFCBPwvrrzGg5qRlb4iO0+1djA3S5TvMOP/ay+VFsVjVSphoGjYT2?=
 =?us-ascii?Q?P0lx3PT5n9AEELkwV56+unCK0Hy0c9ju9m9fSrMFWNummLBhUXWszuuSijMA?=
 =?us-ascii?Q?kv+ACDJygguQchgGqlMp+Zi8clhQMw84r2dqfBEDAkP6npMswLkRW69vGqLM?=
 =?us-ascii?Q?F3gofk2AfRkrZPhdQrbBmr8CrHElaDUGRpmbLjYff+9xADTumR1bY7RHahVe?=
 =?us-ascii?Q?diK3Gc2CpnN7qGfATtwX3JcM9cMdGuB9w+IjOxacQ09fiKK2z0IXo5odHCZl?=
 =?us-ascii?Q?+zXVWVGGP3Td60v/9f2F98mdKXKnORndSLVxSg86zikhjxJCATL0/Ms452ha?=
 =?us-ascii?Q?X7m/PxhBjNFdmmnA2X6l2TiN0tTEl3Rlgc5rWOWTWsjGsw35+cgOWAewWM0n?=
 =?us-ascii?Q?BL8p0obTTasQnJCtshNci0eyLY9ryxByD0Td2nIxdGGLg9jFFP5uZr02V/lb?=
 =?us-ascii?Q?bK6rMJ2GKsPt2qhCUNOPlSY8gBarYk8JfYkAh8zOvxBelA2hzZJgdv8G08l9?=
 =?us-ascii?Q?9Yn+L8Nib0vG1eN1tFp7J86cK3FGO/9Rw0uIiqpoBNYVYQtTvQl1yK5/rZx+?=
 =?us-ascii?Q?cPnwY/pN3UhprJRkRySHJKWNAWpI9Oqf2TgcROR/DKAa+A52UxayY1vOXgTL?=
 =?us-ascii?Q?Q5bqt3T1BUo+IpDY8Xtwkmz5ePZ1DguvoXne3T0doEQEe+fguUtYgJrzbzFc?=
 =?us-ascii?Q?Zc1Vll+v52mYpeoNrABVko8PnDhy+K4cjp2rJJCIlUEoKHnCLa5HNb9ye8aC?=
 =?us-ascii?Q?xZ837RSslvpnl+6ORxvs93l45yHL/k6wEtQDqbI8w9+FmWVAPjsvVsBXNffI?=
 =?us-ascii?Q?px24fDQYug0F5IbYh1K19E4dge6mFrmRxhCkS5HufMEWssjaSKDNLzhOg4I1?=
 =?us-ascii?Q?Vnr7Dm3B04fC/nIMvXIRd/Bol16OGFiccz4AudceQBxSY+XVuLJMSwYOT8wL?=
 =?us-ascii?Q?Juu0dPOH/YQXPEov0yckjx+RIqAF0zexWflDL0ly7ysTEs2Cgodh1l/xIXJR?=
 =?us-ascii?Q?0boKkzfiXiFATSXUvN8Rjrw1My+4Xhw/6zRDB2No67BN0fxAO3koSK8QoqQa?=
 =?us-ascii?Q?MMPDayR/lrYEpou6jWYJQidx2LVFKmtnR/jZYFzf5OKQRM7bavWBjGAZc1ah?=
 =?us-ascii?Q?Ee3mhHNQ9DPoQiN6D85JyqL6KrPcb1u3DuBPO7d9z4BAAruU6UDqX69DhNgN?=
 =?us-ascii?Q?IlNg5jScWcSoAFyUxbyIa0lVHPjeIgTNUPETeL/u6BzEsKNy3kJOEw77Dqsk?=
 =?us-ascii?Q?dTpqAgLYIgVY90xELE0OzzCbQ69LmbiHefp0FMixCdLW2/lrQHincGNGIPcz?=
 =?us-ascii?Q?qSUotVQwBMbGqJI3XB+OT+8lh0w4MKXa7TMAkHih/gisbpuZxbQE0JO3FJaj?=
 =?us-ascii?Q?KfkZx7Ibbaex4ervwILEfAC1HWDVe6v4VocGrgNkCwV7ahHwfY95l37aGDGQ?=
 =?us-ascii?Q?fcrb6MQwuQt4JPdwHjL2vI7fVjYGie73+Fg93LCYbsYlRcMaZydEBXvRaJ6V?=
 =?us-ascii?Q?SYcaErqxOROEm6YNktrivMUhdlnqCnmPyG4pxBkR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e908f0a-b8cc-4a82-5d73-08db843aa52c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 07:19:21.6647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTfVc3dheZNqLb6w5LmANv73mwkj+rXRlMsBfETEgl/xYsPZtQOgKebxXipmQESQ8DWvvp4nqsmC6XVOzqjeR7kqlBdxVLJrbiHwjJVHThs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB9236
X-Proofpoint-GUID: F3vnk_sZ-Nrg3WHSfCrEhALP9npCNnI_
X-Proofpoint-ORIG-GUID: F3vnk_sZ-Nrg3WHSfCrEhALP9npCNnI_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 mlxlogscore=551 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307140067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On 23-07-13 04:14:29, Pawel Laszczak wrote:
>> Gadget ACM while unloading module try to dequeue not queued usb
>> request which causes the kernel to crash.
>> Patch adds extra condition to check whether usb request is processed
>> by CDNSP driver.
>>
>
>Why ACM does that?
>
>> cc: <stable@vger.kernel.org>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/cdnsp-gadget.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c
>> b/drivers/usb/cdns3/cdnsp-gadget.c
>> index fff9ec9c391f..3a30c2af0c00 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.c
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
>> @@ -1125,6 +1125,9 @@ static int cdnsp_gadget_ep_dequeue(struct
>usb_ep *ep,
>>  	unsigned long flags;
>>  	int ret;
>>
>> +	if (request->status !=3D -EINPROGRESS)
>> +		return 0;
>> +
>
>Why not you use pending list which used at cdnsp_ep_enqueue to do this?

It's just simpler and faster way - no other reasons.=20

Thank,
Pawel

>
>
>>  	if (!pep->endpoint.desc) {
>>  		dev_err(pdev->dev,
>>  			"%s: can't dequeue to disabled endpoint\n",
>> --
>> 2.37.2
>>
>
>--
>
>Thanks,
>Peter Chen
