Return-Path: <linux-kernel+bounces-74303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DD985D28C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40EEB23DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9030D3C461;
	Wed, 21 Feb 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MyDT8XxU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gYqGEfB3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1F3BB5E;
	Wed, 21 Feb 2024 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504081; cv=fail; b=hfRzPlUcN2ot+BLi4somncbAOqiLS0n12PEkSdzKuwZYrL/aikPJeDa4yWt6chQa/Thyj19JMHXcUcdKuMkBZnzX0FYLBi317mf4kRbOsE+h1nsVqq8XzwgthHC//hf5xJu1BQZtntJ7CKtoAMeQoAHT4WDEhc0knfm/cxBnIog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504081; c=relaxed/simple;
	bh=2O7ubcRYL/Qfia+7GcMwHPkQHSGYIxNFJwJtFCJc/0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ikcr1bx49incRfdh7zWnYGPnZ/c6k7SXLU3TkGQOKuZExzUGyHYfPLi2Ngl7E4gDadk0w//Gyy49l5wyeYTpbBmdr+96eMoucCnlO/m1FgEmNklFU9LE4w67bCumMSAa6hmVPQmApvLCeTRZSdcrRApJ3U9MERrDuZYl0uafuOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MyDT8XxU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gYqGEfB3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41L6dCQc026198;
	Wed, 21 Feb 2024 08:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zWtUn3MidlEsk729xmIHhjEkmICm9V4rKIZR5psxvAM=;
 b=MyDT8XxUaAM1GjYP9GJrsY523qwYp2Y+82pwa1QlQYv+hjBz0YFeMJXQJmsDaYBIsAof
 OzaeB7gaS/D9Es5m2g8cEcCGoWyyXBKPD4RIbMypnfmWjYEHeR0A6JiJBCQWqdu8THRW
 MUE97WO4r+KgfVPQK5z73+TprxdcBo8M6TXKWtOBN2kAWepQkPiv5weEFX4tyHeUVbdI
 sfk7nqekPsFzT/dacVinsa9+lu8YKh5WqPZYsmfiKWhZpZ8e1oucUuW/Pe8neDLx2OqC
 8Aua5JF1T5+15fBsgEd5ajYVr8htwI4G1GFGUrbm4/xTv68joXsHCiIydBQ82nFBnbGf kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc93tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 08:27:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41L7KiV2021335;
	Wed, 21 Feb 2024 08:27:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88wsh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 08:27:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZQywxUwXBFikgVBXWlWrdN/WEkKinMWVwnEONAXzdQo/cdWHOrmp7NPJupCAFe4hjviggsoUG2vYTK1Wbj1oQoZCVaPS7kh5QGOCPz3iWYtu1W0bpAORH2jcV/Oh8b4cc3CfkpbGwIbbctEZK6p/Xbr++xSco0+vkr/A0khDUsvG3an61sD4/iDmuHvar1zHLtTawchInW5C16xStwm3IyI3edWuAubtbGU7iV7B/fhIFw6xEo4ksEQtzd9BSaqw9NfR1947kggnOYbGNQOdhiBUDf6dD7hMoByzsOv/1jXpnWJ/jmW9SirXQgOtsCjZYtiU61+gy8xTTm/y2oJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWtUn3MidlEsk729xmIHhjEkmICm9V4rKIZR5psxvAM=;
 b=nOGI+nctP3p5y8fM47sQ2R5VBp2A3KSYmuzmR+YQFoJfFse9hKPM9rqG6o3jO6FeG1gbiXBj1esdWd+aH7WPELoVEd6iTnfYe6Mfk9gK/MbiCHtGrQm8YfiCxerzP+SU+6Bay9QZzTGR+DiRd78TixfDvljB5/YzrXnxuKvfeplfxAl8J59ZnwjPtrsB4TKvETIzRpmvIMO/9kWxjuB1PXmybDuA0fplo0/sfqT5lwNHzdllCku8aJ1m6E2K2lipvUf9Hkx0fqujEaF2yPqWWT9Gyd/MNZyorHvdDdkImBZrnmwA5OT+3st5UGGwZWpvy68s509C4h0tEpgFF2M+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWtUn3MidlEsk729xmIHhjEkmICm9V4rKIZR5psxvAM=;
 b=gYqGEfB31NuNssaWjPzCbRGLwJJAQP1fXD9Phe0ktbC0ucw8cw9SD5+S4gEgEEDrY2ywtK3aFKnyRQ6JnwqMuF87ohfqv9wM/d83+kJTxDdSkv98HThdMOoEl4Yy+bOKuRo79z+iuFs6xi18AinY8IDxbirHFnNjasfjX+jsxUE=
Received: from SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6)
 by CYXPR10MB7924.namprd10.prod.outlook.com (2603:10b6:930:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 08:27:47 +0000
Received: from SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219]) by SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219%4]) with mapi id 15.20.7292.028; Wed, 21 Feb 2024
 08:27:46 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: "j.vosburgh@gmail.com" <j.vosburgh@gmail.com>,
        "andy@greyhouse.net"
	<andy@greyhouse.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajesh
 Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Rama
 Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>
Subject: RE: [PATCH net-next v5] bonding: rate-limit bonding driver inspect
 messages
Thread-Topic: [PATCH net-next v5] bonding: rate-limit bonding driver inspect
 messages
Thread-Index: AQHaZIQBPXoFQXpUBEa77pYvezjdNbEUbF2AgAAJ5QA=
Date: Wed, 21 Feb 2024 08:27:46 +0000
Message-ID: 
 <SA1PR10MB64451708B325FDE134EE11978C572@SA1PR10MB6445.namprd10.prod.outlook.com>
References: <20240221050809.4372-1-praveen.kannoju@oracle.com>
 <ZdWrXyQTfF_bMPCA@Laptop-X1>
In-Reply-To: <ZdWrXyQTfF_bMPCA@Laptop-X1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB6445:EE_|CYXPR10MB7924:EE_
x-ms-office365-filtering-correlation-id: a05dec8f-1477-45de-ed9f-08dc32b6fb94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8mndbslYzqGfaixpWAyMyHSO56Q8JN8i+VaOtarzPIot3K8NBOC+k4ivH8Brbu8xRdRSuE71Uagypqrfkjge8Maf2HjqQMQFiw/Iv4MH7k3RY6Px01uBSzFqepgqje97hEHzfBJwezTGzH9AuaFRLERLMYFCYnJHQMSKywmgDguNQ9ycVH7m5/XrypP4bnsRojNdK8zD3xGgG+60Yr4gqu7LRLRHSWwp34faUIde+6WKNec82ac6owQmH7hpdKrqbIGZaiVzwNck1oLSmHceNS2ymuMR/FBatBgx+dOoQSWvu5Y/gydbJpepRz0Ntej7oibKj0VZhDX2ObQAqTEpt2AFCBAFTpPSuQpIBwRKGAQxhb0tQ3+aaAjzfCpOAtneR/y0sqy+ZLmqFSlEPNiX4rJEv8+Gbhuordhvtqa3uT/0k6bVoUw5tcLD9+RixiFWgXQ6qufjzwjMVm14O553X+PGD1IeVemwoiV3Q7vdeWBBCR09fXsWnQ9q5rYbIw2zC7XvD8O59sRvMUpzTn2VOiAQDiFqLYNz1A0MwcxTI3vxTpgg1t5wpPK2K31lFZ8kBX86WsogKiUXAtdhVAVHmPPlHoNdk08QyiZGZKTM39A=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6445.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Av6SvQOdvGp2Tf/N1T7rPp5VvhNSRQIAE2z80vO4n/ulZlPYuFriz2PpsO07?=
 =?us-ascii?Q?mTF+FkGVAF8Rivd7/lZJ3yWAky7wp17xwI0nehrFqrvDMeY7edc8J8vv8oS1?=
 =?us-ascii?Q?rbGRHqtVJOXxIwUXz60ik7m4m3Mz6s/VKD+IZjZhyVL33R4gqHX/pJFLLJCp?=
 =?us-ascii?Q?CUT04KFq9sDlSVrDFzlX9ewiVNJEJR1d4vEp0xvTAFLHBMTJrRoCuWEx6pBL?=
 =?us-ascii?Q?JoomxH1qLha+prVdHiKIimcbB+Md+BQyM5RoS00AglyteXhmOouU4vaP+VxK?=
 =?us-ascii?Q?OKR/7eBpc3zThVvTor6oDs/SSoC/EgJukVtppsg/yPORfytIoM7PHjMjB9DL?=
 =?us-ascii?Q?X9s/OSytD9YegS9zTNK1eJj7OEzL9ECDCoSpiSflNUc46RhFidVgT3Dg+kqn?=
 =?us-ascii?Q?A0IcVX2zGb8QclxPY8FgnPDO5iw3OWTT0GPHL3Jb0xxj+N5ysjaxETVwMNIS?=
 =?us-ascii?Q?LOGcAvyGF11nNVhvOJheoI5jJG7FYiDwwUMHvnKP32+akVronvJLTiF8nZKy?=
 =?us-ascii?Q?siLwj/lSJ+FLcOtbcrSLthWtniuAtAmdAdHntzmcyVF+XpJZuwmjmZQTfB5p?=
 =?us-ascii?Q?EX2mp6XDSnxlPekQRnadCJRdSzgQRdzgC9yTzy5xXMlx77qkC46+IsY2edP8?=
 =?us-ascii?Q?2U7GyjO6L2J0LwMZAiD5cUKEGa16UfsN88ws7tWaT5Ocm/n59kBbNvKWXtnV?=
 =?us-ascii?Q?9JAXp2VAPFbN5EQ0QfXQhOj+adGu5J6jP3JkpVgTV8EHKNkGmJspbXLSA8S+?=
 =?us-ascii?Q?eksOAJtwz2X0grJ04FraM0SJKvVykgd4mugaRVd6WnbtdoNImBQDwh2pgdrQ?=
 =?us-ascii?Q?NuCH8O5hRlDWzBU4Ut+VS1QLqGPm6JAaBxWJBxcKAwtlUVFd2KK6eTioRg93?=
 =?us-ascii?Q?vn8nFKet4e1dx0bi/vg6BRexQ76+7TxGLp9bodSf/a/9X583cgq+RlL1/IQ2?=
 =?us-ascii?Q?oK6FjXG/tIPXh+paHU0ogla8kRnh37z5Wf2fq03ZQNrgp5Opgz9HJGx133oM?=
 =?us-ascii?Q?IlGQvQqLh+sWl8P4f8/rXWu0Nv8kPlugt7XHStfWC9OUFtsayeRJQ+2yoj1B?=
 =?us-ascii?Q?oTECgBndgWBAN/L7u6vo4AXnWPz9uCbWus/RCkD1jTlyCKOMa8J2G9ghXj6h?=
 =?us-ascii?Q?oeiudmqVPFzcl4Jy6W2BwpFqwc7gHH1+9u4zt6uu/96DErD8ZJhYF4QGrQod?=
 =?us-ascii?Q?sgi8X6SZq8GI5dvgxxtENyQmShTDAL1kK9LcuXtdrXj3cxmK33alePIqzyia?=
 =?us-ascii?Q?K2cjRvOfaiNlVu7Cb8rsyTWkv5BGlSYplmmI7sSd5Mx++P3qPGJevQaaugdB?=
 =?us-ascii?Q?i/YKv7OoYk31OppSc1w0RhTf3EATxbdGhXyKa8u6w6RPEa1sLjKOOI+Gytz2?=
 =?us-ascii?Q?P2vjCOuBe3za0zyLad+hbNtPvB/pIJwSh6sZS3Kc8Do8gHqoQv4t6g4K+Va8?=
 =?us-ascii?Q?ItUo7FIUkAO33uUhwcwGiETYbDKUqrRyeeK0oM1urZvbK2LpiX2eRFGtO60e?=
 =?us-ascii?Q?mR5IkcA3bmsSF0X2jDeCqaDDkbYDbotIXNwwXHNCHq9iUAd7uYIzb5+It2VX?=
 =?us-ascii?Q?ki9wVy+g38SgGEqg5SNoMS+sfCwQ/ZTxuMdY33MKixG6uOKSwxqemQMWHynG?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RREzJxVwrZ0VTiMeL+mphXoFcXageU9PHIolDfmIidIYG3l7JLlU7/1gl83oMw4CZYP+lmrao+nZQlnONsYz8CzMrcjivttXzi+/5yLbtJMf49hv6Cx70HSYt4KFTw1aE5rPJtZesIGfzIoatAmeMLmZT64bmLnMCYHABWZ7qWPaaEB5Sy6Phs3n1ZTDujmLHe9aIZQ+0Z4JUv7yjdPvogrPYv7ba9qb2JV5YkujPmb4D1k6bHeRuQ5d5KhOCJ9Gc3vySDMB6onnMfpcqRPdTPzjeTuIJ3D1JT0z1WZLWt3AGA31ZjCOTrp2j2E/Sfe4LdTmyGWfX/KupHH9N+GrVLy7UCf0MbhbSJGnT3o0ChQby76D+Xsr94OBYlKo8wxMDjiZcxKKh83G8SCAjj+fBt/WfLsXcf+CP2hWqKK55vYqAEClfxbOXEofcPLuxZnVfhEQN9zAD+zs1uhllwuy0lDsIahPVi9kgRVyo3ePVRXZU/8Sfj/YvOpjUPq4MOgpNQMj+p5/dLljkMqyiKDYu2wkFFgpb12rUcH6n9I800Gn/okgC861jitthMkZCmrpWMzO8n1AW32efC4a89FoeYurm73OLnBfESWDR6lUCh4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6445.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05dec8f-1477-45de-ed9f-08dc32b6fb94
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 08:27:46.5475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rSkUDA+Z+ZZXJsAQXw52FhDM3Ysp8wWu1X2H61YqF+cjBMKbVd8dJx4DlrIefvd7NTCh/o+LVG0Vmwk6t4sq16tybazmpxsVl0nkoww1PgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210064
X-Proofpoint-GUID: WUipwa8RhtLTaqBKiiGf2Rv9DmwHE8tq
X-Proofpoint-ORIG-GUID: WUipwa8RhtLTaqBKiiGf2Rv9DmwHE8tq

> -----Original Message-----
> From: Hangbin Liu <liuhangbin@gmail.com>
> Sent: 21 February 2024 01:21 PM
> To: Praveen Kannoju <praveen.kannoju@oracle.com>
> Cc: j.vosburgh@gmail.com; andy@greyhouse.net; davem@davemloft.net; edumaz=
et@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
Rajesh Sivaramasubramaniom
> <rajesh.sivaramasubramaniom@oracle.com>; Rama Nichanamatlu <rama.nichanam=
atlu@oracle.com>; Manjunath Patil
> <manjunath.b.patil@oracle.com>
> Subject: Re: [PATCH net-next v5] bonding: rate-limit bonding driver inspe=
ct messages
>=20
> On Wed, Feb 21, 2024 at 10:38:09AM +0530, Praveen Kumar Kannoju wrote:
> > Through the routine bond_mii_monitor(), bonding driver inspects and
> > commits the slave state changes. During the times when slave state
> > change and failure in aqcuiring rtnl lock happen at the same time, the
> > routine
> > bond_mii_monitor() reschedules itself to come around after 1 msec to
> > commit the new state.
> >
> > During this, it executes the routine bond_miimon_inspect() to
> > re-inspect the state chane and prints the corresponding slave state on =
to the console.
> > Hence we do see a message at every 1 msec till the rtnl lock is
> > acquired and state chage is committed.
> >
> > This patch doesn't change how bond functions. It only simply limits
> > this kind of log flood.
> >
> > Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> > ---
> > v5:
> >   - Redundant indentation addressed.
> > v4: https://lore.kernel.org/all/20240220050437.5623-1-praveen.kannoju@o=
racle.com/
> >   - Rectification in the patch subject and versioning details.
> > v3: https://lore.kernel.org/lkml/20240219133721.4567-1-praveen.kannoju@=
oracle.com/
> >   - Commit message is modified to provide summary of the issue, because=
 of
> >     which rate-limiting the bonding driver messages is needed.
> > v2: https://lore.kernel.org/lkml/20240215172554.4211-1-praveen.kannoju@=
oracle.com/
> >   - Use exising net_ratelimit() instead of introducing new rate-limit
> >     parameter.
> > v1:
> > https://lore.kernel.org/lkml/20240214044245.33170-1-praveen.kannoju@or
> > acle.com/
> > ---
> >  drivers/net/bonding/bond_main.c | 24 +++++++++++++-----------
> >  1 file changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_main.c
> > b/drivers/net/bonding/bond_main.c index 4e0600c..c8482cd 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -2609,12 +2609,12 @@ static int bond_miimon_inspect(struct bonding *=
bond)
> >  			bond_propose_link_state(slave, BOND_LINK_FAIL);
> >  			commit++;
> >  			slave->delay =3D bond->params.downdelay;
> > -			if (slave->delay) {
> > +			if (slave->delay && net_ratelimit()) {
> >  				slave_info(bond->dev, slave->dev, "link status down for %sinterfac=
e, disabling it in %d ms\n",
> >  					   (BOND_MODE(bond) =3D=3D
> > -					    BOND_MODE_ACTIVEBACKUP) ?
> > -					    (bond_is_active_slave(slave) ?
> > -					     "active " : "backup ") : "",
> > +					   BOND_MODE_ACTIVEBACKUP) ?
> > +					   (bond_is_active_slave(slave) ?
> > +					   "active " : "backup ") : "",
>=20
> Why these lines changed?
>=20
> Hangbin

Must be a editing mistake from my-end, Hangbin.=20
Addressed it.=20

-
Praveen.

