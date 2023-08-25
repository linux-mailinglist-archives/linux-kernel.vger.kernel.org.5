Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FFA789074
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjHYVgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjHYVfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:35:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F2026A2;
        Fri, 25 Aug 2023 14:35:36 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PL1aMp027486;
        Fri, 25 Aug 2023 21:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=Zgv4FGwsmVpsJUk7WNjtvN23NcvOlXGdYIOvC7OLUU8=;
 b=nJiRTyTO2Ghr5f7ahImz1DTPm7Prxpju0+3ibngbpKH4BsEA2rdl12pbv6PrYiv9Vk3W
 kxxtdK5A55I5c8Utwq1YYMlLTjSk1gre39/FDzaNNqsOkMBDpbDCp1Zl0/BW1i8ZeiCj
 Z963E83SeRX3208zDz4AACXQIFsFk6oEM0kHcw+nrv84AbV/cM9l75S6yrXXFoUBvNvX
 vsmuImba1lE+Nz0yujHOFOyBu8juRoPHst2PKj7V9KwwfsDgK3KjTuTIvOVUmsisCvL0
 4iKDNXCM+M1Gnf3HhHA6BPDbDhShUeCac59vHH0NL+y7aY3xzld7zrORI/bHGkwYL/f3 LQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmn620qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 21:35:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mhf8NwwXTTPHtXMI0lRD906OjW3JIG1YADM3t965zL7IE1Cdh8pLItYna8rCo6s7g3TKK7VUx4blWBN1pdI2o7swgKqIB9frTy0WQBXE9Orl5TDnAeyUBlcigGkLTaQ2YI74oQKYZIz/kC6sFxR/MCPXBdgYp/GFGqW3avYdkoUMO+mMlElgUry8Uy5zEnFAoGWWEOoJHLXmRojokh7N4TeIlSefKfFpI6mVXhh9SX9CDr0PCXRL1hYIyNQZWAEHgG4Sy7D0H72tI5rGchAIXu9gOwDoROZjhoemzEUTf8f742IQDHsyukC1V3JSKYAdM1SDgCQ4sUndNtcG53wuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zgv4FGwsmVpsJUk7WNjtvN23NcvOlXGdYIOvC7OLUU8=;
 b=GoGDSsi3306Xu5RtGYZHT3v0UyI0sxbcEGcsJADJ2X6lGRqidqx7oednsMR89kvcK1SAH/8xIYYnVlC3RQrcqWg0Yc4oql4l5kb+OTKI1TEAaZFoFqS/Mji3uCUc98VAz348P/MdriOoOGqFQxFOPkCFqDdQf+mGqtS4NjTm3wT4q2Rtci9/FowzojaVKiidIYf/asRGsOhxsc3McB9lZrtk8LLUJnEezcLESuaOQLi4Q3RhGREXt5bIBynWDyLAYlJ+VHCT3j9GXzjTgoZ92kqVC1/s1+MQCKHu/x1t1g4k8p6EVkJJrsIE3J6iDmmfvZ3dYMo9xR2EgW2kvq7Bfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH0PR02MB8073.namprd02.prod.outlook.com (2603:10b6:610:106::20)
 by DM6PR02MB7065.namprd02.prod.outlook.com (2603:10b6:5:25a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 21:35:00 +0000
Received: from CH0PR02MB8073.namprd02.prod.outlook.com
 ([fe80::3d62:6828:e5de:a985]) by CH0PR02MB8073.namprd02.prod.outlook.com
 ([fe80::3d62:6828:e5de:a985%7]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 21:34:59 +0000
From:   "Pawandeep Oza (QUIC)" <quic_poza@quicinc.com>
To:     'Sudeep Holla' <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: ACPI binding with SCMI
Thread-Topic: ACPI binding with SCMI
Thread-Index: AQHZ15v/XxjdIx2eokuNoiWET0Kgsw==
Date:   Fri, 25 Aug 2023 21:34:59 +0000
Message-ID: <CH0PR02MB80732F4C4134B3EF2D80B4EDF6E3A@CH0PR02MB8073.namprd02.prod.outlook.com>
References: <20230807154834.888328-1-quic_poza@quicinc.com>
 <20230818091931.iqh6bxiifk4wyc32@bogus>
In-Reply-To: <20230818091931.iqh6bxiifk4wyc32@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8073:EE_|DM6PR02MB7065:EE_
x-ms-office365-filtering-correlation-id: e48bda2d-c2e8-4899-99b4-08dba5b32244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X+5FgD3LJWSNhoQ2AK+MYvKUgb1K4w1rmxM5Q08lkadXU2X38E/+SI5Q+X0R3wQj6755Ia0OhwFiMuc1k/tHdgmBP9QbIcDbgW+mbqx74nOHJDzWtUg0SdL4Awyg7i9Qdd5Nouxu4MrxFAVJvuNwg7K+DeIvioVW36+Jy0/tmUNyN3FxrlJDJFvZWjClhMplNUxSQ+q6GWxe4wve7Yu0UL11Bi79/ayZBOqScdvX7CQxtCHDk1Kl5dNB6XIqE7okTNuG1Zk2oWnfLv8gWbh00SK65sefjCEUWSeYO8EumhZRo4JNeqU4cFpwQGVS3QOfvweMT9b4d5p4H3CtfLCm97ZPB/Vs/DLBVqTRuxbJJAFKYfznajuURjYOT1K81In0KZxxmxts332RMUVxB1/Phxbh5pzv4DjX0yUaIpcXGI6nWqnNICZq1EuvlCzeXgKocmbP2YnKtUhEtPNAhIVGcLk1Bbm6qYIQHh3J9it3i7k4k0T2noa/bx9Z7fTbEubs9NqHOK8N8tIbZfsSnohy7iKm6xTFNya/Z31i5KHbX7MosSpgEP6ArOUR0hoiHCRrz5i7uiyRtlUdcfmkMlrTROeUvJgcE0e3qOcw6iyGmUo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8073.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(1800799009)(451199024)(186009)(45080400002)(110136005)(54906003)(966005)(9686003)(7696005)(55016003)(478600001)(76116006)(8676002)(8936002)(66476007)(66446008)(66946007)(64756008)(66556008)(83380400001)(52536014)(5660300002)(41300700001)(3480700007)(2906002)(86362001)(4326008)(26005)(71200400001)(33656002)(38070700005)(316002)(38100700002)(122000001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3GjNym12VBMNfGGI3RXdJlitc7b1BZ7Uez2otOy7lH6Ml35oG3Cc+CgFboek?=
 =?us-ascii?Q?WrUKjH7fPPxXEVYMsanyLB6VEdPFLVVZQTI++/sTE3La6zDpOO2QI8LxmVw5?=
 =?us-ascii?Q?6itp6VkMvg9IsPUqCofQQlH7hfpeaZbmQ2Ot8OeMqNDgGzt3QFs0yBJk8Uln?=
 =?us-ascii?Q?9ad1ysb0Xko6kgPiuFv3pd4YxLIFCdGjP1Sd5dp6QiGm6dujd/+48AaYqwIH?=
 =?us-ascii?Q?mRz4n1sRe8eB9zRhfQHGIyhjDOgX7gEAdaKcJN7UiTlmglDphIH8lNsotdT0?=
 =?us-ascii?Q?dMyPuUN3x/hDytkag87bvJc0mz1FgcZLwaSShEuVkIOxoE89qagpRyDPwU2d?=
 =?us-ascii?Q?W2qPsERSHC/OJoYBHy6q8cYjDG8vMVy7cBdVd0MlHjMYmm3c/pqhYXHgtbTN?=
 =?us-ascii?Q?jXppe8cpbgsZBrqwuxECjbsk2mlNUOAcq7npFcbX3Ezfl8MlNs4U3mqABrxQ?=
 =?us-ascii?Q?VYZkAa8fAdbCExRFuxf35vqaVwd/ptw3WHKsg/Sze+ymkajptqq9Lvix0JUY?=
 =?us-ascii?Q?UYIr049MPULF791JmBzn0f06VAfBcAlU7BriL4uv1sK7e24RqfyxO3oLKPBw?=
 =?us-ascii?Q?mN7T7RE98XvWAGTKcf6UvWElyP3O4ki0NeMM7uoYvQi9+IGewtkQ5JJ5Mqsz?=
 =?us-ascii?Q?kJBxnjZeWT+uJODVTV2MlJdoxvGABxPEaoNa4+/UAa9oE+04wkXPU2mDePM5?=
 =?us-ascii?Q?BR1esLoCCSGn84d0zxA1a2z169sDe/2Qth9lj+7dxXswQ1nuiqL5M1jkQSZ0?=
 =?us-ascii?Q?nYynapKnnxGhvcojYYmfbXSV8UbPe2qXfwKLudxhDYr43tK/bIbycbd7IYeA?=
 =?us-ascii?Q?Ym+CoLk+hHdWXFL4eagJ7oKLyXVfYLe6X11ZJYj9nlG7rJHM829AZ3+y1Wa6?=
 =?us-ascii?Q?yHR7lTendzr7Xbva01KA3ls04lMBvS/kmvmvXEAGlXqZmAYtkz9oi7GWhaJ4?=
 =?us-ascii?Q?5NmTLttoV18H+KdHbFa4WWUmDCorMLA18PwZD+iU4C0iMpmNRHhGeHpFhGj1?=
 =?us-ascii?Q?2tswtcTa4HwJuQRVxN08CXuF3D5sBQWa+8tu3cZ75bITBHvSZP4+00LeYRmi?=
 =?us-ascii?Q?o7AZ6qMFY6rC9rJgUj1NU/deffj5Ms0GpOoyTcvwI8/3zpQJL+cd0lDzawvp?=
 =?us-ascii?Q?WF+xrIWeFeb8j382IT1clUefqT0s7ruTLlvugBflvYzIkW3p4tterSDlbKa0?=
 =?us-ascii?Q?Uyar0aGBDKwBrWyFZ4cacUqhkgXluygCXECoPMqakNpqtfHW/il4ajPVe3Co?=
 =?us-ascii?Q?ZOO0I0IFhqHVj6BQUXtUgZwKjfsriARFnOLJ4VmTF2+t9Nm9LlrPC69EULaT?=
 =?us-ascii?Q?8CMTsmKh2eKF38h591bCtCrUhNpUcRDMBpcWq3GY+F12GzqbSg4STp1xaf8Z?=
 =?us-ascii?Q?QNvocy+dhajumENkdadzxmNG2pnP5/2XYsqZ01kAmHVz2SXbs3weLX9Jhcz4?=
 =?us-ascii?Q?1xCdQ791GbTvEaMbNYO8WbXrWcxRPEMgs6hLSegcj44N8+B6oeakKpEZl+zx?=
 =?us-ascii?Q?Eg5AK+9mEml0PdswySzJcLJrVcyUE+vdHuPMEVrDw4pG4PwgzX9iAkHpgyii?=
 =?us-ascii?Q?oIccjSlvVX8b7jpODKsUHFiXRuxmGEsNpoxKw1mv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0lfMA9kTknBz4lKzSmYDrpS1uaf+LwTRUHcRspkdk385vb2+Nu/jeAwlriY3mns5XMXydWNEZEw6aKVnjVpTXnI4FKECF643zp76DeoYbAUfVghPWH3XuDnU3F5c7KrXknrNM9AAiikQEK12tv2aiRTKHxvzJxr3pIuw4MlkmwwcB92CHuOOhn2Q/aWuRykOu8hDSx6tuHMjf8Dy+OZLMOzseSSOE9WmazA97tAg/xt7bjvEb31ft45hfGiiQZJ0RraRlPtfKFWjdXXSVZ0Xa/gqg4K22+bsB6CyMJgyFEXrYMy6rMNKxEDiFnZt5um/IZ0uA3qOuj9FisoeaA4AjZmUoJCY8H/aOiUEVA+0HBTdH/cPO4CY7mXrtEjq1KibVdVcKW7PVGtT53qYEvGFj7MT2tr14RszQAGy2OnlkIbJnnaC59Ft0J2KZijMB3QjGO6Va0WSKT+LwpxsUKtJRmsB4lRGGbHqxH/ebAqxSx7KKygabv6BzTQ+MO9kuILzOS0nRk1Ee/IFbfQVrmIcbaWRhih1a7KHkjYrVkx0N9iVinTMf9VQINBURGdMM2hSJ+ipcvprbKvT5HiLAIbtcnzHFWqhIa3QpxUTIs5gvqo3SLVdw4NuDA39yxwHPeaOHnFbIpXrm3DwAtIiXYh3uczn2gZm2wTmmx2duRoqkf3bhol/eQkyg8L4UsFBn+vpDP3RRKyDr9UQyG18GY84YIyhWB6z7o+5sDlZ9nlGBcaeM56GezMKJ6hpvuvUmnIC98MiTFXKkOT2144RiNaCsabP3mpkB8gKzELlqEjoYlZChgy8gUdkBMESXyh+91Bj9dhLVlSc6kBvY1UV8hr7AaxBXglcqRNqmFVBE6QrQVrveHTa5SmZ+J02+IIEHcx0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8073.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48bda2d-c2e8-4899-99b4-08dba5b32244
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 21:34:59.5654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JO/ToX9ygiq0OpHSm9XyLvJAiE0JHDtp1ulhoyL8Jl7nfapKLdLpHuT7GOR3Cq1UF7LKtutknrsUgdqokgpPlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7065
X-Proofpoint-GUID: vfx7MqREWATVr6EWdJNiYlFTn10JVCSL
X-Proofpoint-ORIG-GUID: vfx7MqREWATVr6EWdJNiYlFTn10JVCSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=913
 priorityscore=1501 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

I have PCC based regions defied in ACPI, and CPPC binding already exists th=
rough _CPC and all the way in kernel to facilitate per control.

I am looking at SCMI on ACPI based systems - and I am going through kernel =
source, SCMI specification.
spec mentions
"The SCMI transport is represented as a standard ACPI Platform Communicatio=
ns Channel (PCC) of Type 3. SCMI transports that follow the format outlined=
 in section 5.1 are compatible with PCC type 3 channel definition. Also, AC=
PI version 6.3 introduces the concept and use of PCC operation regions. Thi=
s enables ACPI methods that rely on underlying SCMI services to access the =
SCMI transport through PCC operation regions."

But when I look at kernel source: drivers/firmware/arm_scmi  -> mailbox_cha=
n_setup is just reading the information from device tree.

https://lore.kernel.org/lkml/MN2PR18MB3358B61B4B5777FB35B42733BA3A9@MN2PR18=
MB3358.namprd18.prod.outlook.com/T/
you have outlined the way to have SCMI bind to PCC space in above thread

"
However, being aware of this difference, and also for other valid requireme=
nts
we introduced the concept of Fastchannels in SCMI for performance protocol
mainly to bypass the PCC/mailbox overhead. It also aligns well with CPPC.
You just need to implement fastchannels in SCMI and specify those as
system memory GAS instead of PCC GAS in CPPC tables. Hope that helps, happy
to provide more details once you get familiarised with SCMI Fastchannels.
"

But I still fail to see how fastchannel doorbell and shared memory space co=
uld get bind to PCC space (type 3) ? I am on 6.3 kernel.

Regards,
Oza.
