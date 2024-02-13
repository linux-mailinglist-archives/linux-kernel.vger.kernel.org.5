Return-Path: <linux-kernel+bounces-62963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2887185286C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4381F24BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EBD179A6;
	Tue, 13 Feb 2024 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jMO9LZ1D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IWWiDFTG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A241754F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803821; cv=fail; b=jTtAjDZRysS+dQ+Z39q2wXGDJC7LziFdbzVzv3kFpR223R+t4gczTHiBL+weLBs7baYrS1gAWzRHhZ0a1uCYGkM52cOQBRjorLRqrHOLXTW0PqSe0K2sqRGWr5KUM+ESIkXAKz344FDpLQWX6Xdkbwhb9ibn4JMbJyVDi7UYWIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803821; c=relaxed/simple;
	bh=l7U/OJUO6CI83OsMzPQK29qpXrrJF2BPUHGz5bQq0VA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K5mnFU5o7WT0vtan6CaBy6FFBtP61taq3sqQiRxQ5Y3cVdNSYpaZ+VvLhmK7CDPnMmgzGMP+IRFmFrclWqtuIq2/JLJLBqQvzScUXRenBJTVh4dMgfgQfxwSQQmM2e6WwqbioRrXJVAfOgpu9yOMJlWMmPsjUYy15K18BwEtvKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jMO9LZ1D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IWWiDFTG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5HWOV011785;
	Tue, 13 Feb 2024 05:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=JPqNy/ih8oh/yE7bYXGBNueEA0lXPAgRXgUwRoFWa/4=;
 b=jMO9LZ1DIRSlMKq26xHXfonLUvVF1gIdCagx4v7s4aZJhLRlI5vOid/a0xEGtnCay0aD
 IScWdejo3lmfWP99faielaaAuNCNTqEkxrJ90Y8KRxufY6FEKtPIfWg0rGL2i7iRy3y7
 OEZ+jaRAn7LVlkHvqjYmfE22gVKz73vVHZEeoIxidYt2bS3h2gjLUFesIdHLNiDMDFiE
 B0Fom0Gj4XJSDNpDw/pMC6hqTjAKvwEjEmsRIBl2p9z1d/BMK+g+XhFTIywXHL5Xep/N
 EzTXynY+bYQ2T0uLQfFpSyOEEk2x1EfX86zVfEOWjjw1qoT/hIIdsRrAQuOzx0IP8Mp9 Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w824v02ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5cWbM015103;
	Tue, 13 Feb 2024 05:55:51 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6ug81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsqZjtISKbZ9DHG8gNDZZKwDhP/O19V1mYh/wL5wh2WxV3fy2NSm7j25+kGXP2aU10FTgV9X/ZbhlAEb6SrZuN0ijcOgthKme6Rfm9kDEjDHjtismJiItsBKQ643QxvSLY0zIKzyKxXPQ6R4hjhlIkWp6Ikdz1U8Aex9DNr4GTWlGDGeadKaqhM1KvZq9IhZT02jI7xw34BwGU4sNcp7qG+GMWjK1RFPCdgNy0S4D78S+0sZez/C0ZcVnRhBV51JNHMa3mZKYoVtItggwk8o0G9YTznVmqefmV+HTtn8McgeLj57lt1KoS3uTex9Ve36WD08oxI7EBNW5x2BMshSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPqNy/ih8oh/yE7bYXGBNueEA0lXPAgRXgUwRoFWa/4=;
 b=ZAm8tndO6pWC2mGdmwyeC9jv0AMDElFM/8GIEggMsS+Dd5ncORqOv+wE8shg1tGSeJU8vibg0AtaMmQ7RhNlTF9m8rkw09LM2KH6keURCzwJRDkM+z/47da0A1/kXHL8NxD3qyYVDlO3w+J/RjMOxsyAWpq5tY6hUhxRC2XcJyXschDMO7FGYj68xWllb+AehJfABtObxVHwz0Mt5tvwfdDLbxYVmzOydtHKgCYQD5iqM1OVRQ3HfegQhft4iVtmV4CB2EE6J8f13rLkqKESAIHsrdEwLrZGklYADRcvxhVyUDOgsYpKJgKJ2+7mrFmfjwyFS25s0GB6qEY8hHNUZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPqNy/ih8oh/yE7bYXGBNueEA0lXPAgRXgUwRoFWa/4=;
 b=IWWiDFTGOtAq1Qpil2xZph3Zkoil/znsV3shCA2JX/TsHiZukWe8tiuiOVTDTvXDfxPKzW7yJd5/xsIn0Tb8YqxdVHmAXEz3qBB12UKmBkI9So1mRIj0RLo4CqHNo//9ZlN2y115O8nP92dV8Rem2T29SdQpAuGeoygT638rigo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:55:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:55:48 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 05/30] sched: *_tsk_need_resched() now takes resched_t as param
Date: Mon, 12 Feb 2024 21:55:29 -0800
Message-Id: <20240213055554.1802415-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:303:8d::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d45fde8-3eed-4efa-6e3a-08dc2c586d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Jwz/h9L80ks88UKz5oM9xifha2ZFLWHjVx2QI8SB1BdbJL8O7RV0UIeoK4vrTj+LmTf1AhEm00ODslHndQG+U8ppzNWeKNKSjX/vJmAbuB/ahsWrY0qiFDNW/6aGoJ5dJMB4tPjnZ9ixWcFcA5q4wVdj40mO5uVQCf5xaZGI2DHqZHioAAvCdZzUomYYUi/pLoui8Ea8fLgnqOl3MR8tvll2lg833KWrWAOchx2CvLhTAp84NPbRAL1VatW9NC8h3ommgoI6Wl1yNrOqfJ0auBD3zcxOB/sVJ/q7bFkjlR6OXspSeNLC8S6YZzhZCzVkkVfP/TpuGtTAAA3q/OPQac6VuVhzsVkUgShLVFykCOGuAPf8HGts7h/oyJuXhspcTBbsm2j8snHRqgXCdtWDJvhyCyL/DiW4Y/ifMlVUWesQEhDvpWik5uExJpIiuav9l1190Bjhh6btQWECnbeyL7c1eR+nmxURaVw9H4pKa8Ac6ULA0Fc673K0jf+qqBqZ3kqmrXNo0FMJh+Iu4/a5ogtK8jZWOZfXbzE/kkrhlOk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6916009)(2616005)(41300700001)(66574015)(83380400001)(26005)(1076003)(107886003)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(6506007)(6512007)(6486002)(316002)(6666004)(103116003)(966005)(36756003)(38100700002)(478600001)(86362001)(2906002)(7416002)(5660300002)(30864003)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HgQOi8n25jPMszKtklGiand2Q7OzzxqoDLTbOPXt/Hy6DEnWedMhlEId6ICx?=
 =?us-ascii?Q?VLFBNBRkU/Wp8KcrBiE4bSdi/nGKUZfvONJu9rWx/IPx3u5br0sRV6nHS6Ii?=
 =?us-ascii?Q?DgOqOFO4gDKhj8Bl1dEuOwNelh/a2KAUmLeR+dRg3rxcDH/e8ElLRfWRGA4x?=
 =?us-ascii?Q?Jd/e1gS50fxqxdZs0bR74lpX0XnjvUkctmYImuUQzFRcPsWuEPLdFqgFipGw?=
 =?us-ascii?Q?oBI6BUeodO2Sd9bb0sii1hVAmdkdbUjqMeDpnQxxX4gQQYs/kkPEwICCrGBZ?=
 =?us-ascii?Q?3YLfgFhxYp9/DxCbiYhlzzW6gB6PWBC8IBFJgkXqRgjwjKT6Pr9dA8siRzD5?=
 =?us-ascii?Q?WXzCUuM47cEnS1LEbxCwGAVU9HoKq0SiCUL/IhVpf7+wQvEmSEjIV+GaMVzl?=
 =?us-ascii?Q?nn2HbCtk7MfMgyAIICUPIw+9yYPFWIOALOYPbPTeIlPnCKU8P8QnNsMwiT++?=
 =?us-ascii?Q?iyJIijFtv5Nqc1Bwr3S54xuHw9DYTf7CZCwhqbktpCdVgA3ao8cPIgJvVwjP?=
 =?us-ascii?Q?aBhw0LTSUM6shtIW0NrBqt/h7dLEQVHCKExX5o08ZYk3M4fSMWXp7VODwSVH?=
 =?us-ascii?Q?FNQ46tB0N1gxb7mW2zy4r03iBqlmv2tNyLNdBsBisuIjyycjj6Wa3adJZxZg?=
 =?us-ascii?Q?WzSifXJAtthzWmk6shaxIjQxfqzLtUA5uOpdFFPAbyEzWslOfTVZ1pjXH5cK?=
 =?us-ascii?Q?6EaZh6MmhnDV1mx0R4vWeXToKEKuY7drF0B8502gwfLQzuSWUGPbAmxY+PTh?=
 =?us-ascii?Q?kGp/Np+PXpqIg2VKFXZGr6J2f675nGLArl27EmWyL0Sw9fYkXWfhIHDvgcbq?=
 =?us-ascii?Q?RkhGzgtxqecnNs/h+YNZiV/SKHMaYh3y+zz/zZCpiKHiOwSY9+zeNeFMT0IY?=
 =?us-ascii?Q?Ub+53X+OeMyOIUOxvoiGnBXt5PmHBmsgCUWqHfL2aze1MFEwL83rvQa+O8qp?=
 =?us-ascii?Q?r8QCLXswa/JiaRe3hCjO+VJ+uht0Q0+U0zhTjkQW6q6Xyn6CfIaY6MUUfLWE?=
 =?us-ascii?Q?w85DhopxPvwtKp3jsGL91V3JFxWzta2jQm3y0yLJ4JuQh8cw4trqA1IQoH5T?=
 =?us-ascii?Q?tbOtB/3aeCUw58AH83jHwaPw+pfnn4yyY6EnTrADNSxpbL9pIl/J1uZdLBU8?=
 =?us-ascii?Q?l9oGImZcGJM7EnZPg4xvG/bIIQd2RUQ0YfiDWDV/0pyMlKe41bHskKDrwplI?=
 =?us-ascii?Q?DvJnY00ZjLJh0u/ZfZ7b53Nf7NpsHL5EJgKbefeN4ZhwAmF+VnYvnbLkXBm5?=
 =?us-ascii?Q?fUffXzxlFzKK834TDjUoH+67j+4jBq1LT5yK1+Bu5Ddx6zsJpXwNKruMCbvE?=
 =?us-ascii?Q?9T0G3nHM2nJsePFx5kL3e1BHt+o4yfeHJaVVLbcglWvcYY1HC40kg/LP2z7Z?=
 =?us-ascii?Q?KccDWEL9t/UPHqW47SgPf7jAke1Vb3nRfGnzn7UUAA9lRhRZXoxC9ukydU1j?=
 =?us-ascii?Q?3Pdclujc/mASSFKtqtM1XT+VeQSaUJsduiYeMKdKNTJp6mTvaHKEXTYJzxeF?=
 =?us-ascii?Q?o4dZx8Xglf1Db9fQkwH+dHFs+RC+Nj9xmMzRR6fOd+n6K1bgj6qacJclVIJw?=
 =?us-ascii?Q?U8Rd9h8a62dP3LIsSZy0Fq2/zdjcLIk/FIDHWNCd+B6756oKnLQB7oh7pqmY?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z7mn0cbk+Q0fUDICIqh9vXIGMuJHPCJD1CcWvM9/YtJx0bj6GgxCitTT+OlQhok2LdRUjmq8ZHaDKYGZNyicoSEpxto1era+aEiPqCAkMcs+NWZnpCVyEOvddmRpfQ7Zeh2RJHyGhR+kgTGxhOrnEnjfvsgKITxkMolvw6+zYGnZRRAeCEMkXhy0rxtTArioLlBgufRECyNLRVZY0ydsHhyhZl5gco4ILaGgieVqTwouHpC2e3CMhACVvAmf7FxsicP8/aW0vo3ISBR1OLc1CMTIyw8MFq49md7Sqv9ilJxvkpZCpI+XP7595O6cqeXm5NAtr5cCmITMcHbuoK0/GnQ0n0lY6bygwnL0lBj06XVUhZuEvmI+keNytHnNUDG2krY/1gvFg7O2rxwr3NHNl6BJLZz7hraR5RZlYZaVhK9Bqz842xxwAb+y/R7fw8P7c0dikhHz9D/oYwkNmZNpsseiOUIQqJLTyx61fuRVECHHCV7oSX1jdE5cCNfJundauaF69BTNSv3ivxzhgLQpuwpn07cgSTWrcyRecOhSEphJWMdE/hdeB3ZkzhixdY5TQTrK/HG1c2T7tKDc/owdsYX2HBy3wXdguilIrwTS7kA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d45fde8-3eed-4efa-6e3a-08dc2c586d87
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:55:48.7880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgB16tS6Ax6jeCP0Gyf5XFQ5oiuIAben/mMOzlP04HR4Ysc8OT79hdkcKtLNml2gz8qw+Rue6ktHrpP/RFoplJYLC7knvQl3GrAVGVL9zQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130043
X-Proofpoint-ORIG-GUID: -q7hDUj8Yc0RVSd6qgIcCWYfOsl8fLEs
X-Proofpoint-GUID: -q7hDUj8Yc0RVSd6qgIcCWYfOsl8fLEs

*_tsk_need_resched() now test for the immediacy of the need-resched.

These interfaces are primarily used in the scheduler and RCU. Outside
of the scheduler, set_tsk_need_resched() is typically used to force
a context switch by setting need-resched and folding it in. Update
those calls with set_tsk_need_resched(..., NR_now).

For scheduler usage, preserve the current semantics by using
set_tsk_need_resched(..., NR_now), test_tsk_need_resched(..., NR_now).

Note that clear_tsk_need_resched() is only used from __schedule()
to do any clearing needing before switching context. Now it clears
all the need-resched flags.

Cc: Peter Ziljstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/s390/mm/pfault.c    |  2 +-
 include/linux/sched.h    | 30 ++++++++++++++++++++++++------
 kernel/rcu/tiny.c        |  2 +-
 kernel/rcu/tree.c        |  4 ++--
 kernel/rcu/tree_exp.h    |  4 ++--
 kernel/rcu/tree_plugin.h |  4 ++--
 kernel/rcu/tree_stall.h  |  2 +-
 kernel/sched/core.c      |  9 +++++----
 kernel/sched/deadline.c  |  4 ++--
 kernel/sched/fair.c      |  2 +-
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        |  4 ++--
 12 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/arch/s390/mm/pfault.c b/arch/s390/mm/pfault.c
index 1aac13bb8f53..4e075059d2e7 100644
--- a/arch/s390/mm/pfault.c
+++ b/arch/s390/mm/pfault.c
@@ -198,7 +198,7 @@ static void pfault_interrupt(struct ext_code ext_code,
 			 * return to userspace schedule() to block.
 			 */
 			__set_current_state(TASK_UNINTERRUPTIBLE);
-			set_tsk_need_resched(tsk);
+			set_tsk_need_resched(tsk, NR_now);
 			set_preempt_need_resched();
 		}
 	}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e790860d89c3..d226c2920cff 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1948,19 +1948,36 @@ static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
 	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline void set_tsk_need_resched(struct task_struct *tsk)
+/*
+ * With !CONFIG_PREEMPT_AUTO, tif_resched(NR_lazy) reduces to
+ * tif_resched(NR_now). Add a check in the helpers below to ensure
+ * we don't touch the tif_reshed(NR_now) bit unnecessarily.
+ */
+static inline void set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
 {
-	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
+		set_tsk_thread_flag(tsk, tif_resched(rs));
+	else
+		/*
+		 * NR_lazy is only touched under CONFIG_PREEMPT_AUTO.
+		 */
+		BUG();
 }
 
 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
-	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+	clear_tsk_thread_flag(tsk, tif_resched(NR_now));
+
+	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
+		clear_tsk_thread_flag(tsk, tif_resched(NR_lazy));
 }
 
-static inline bool test_tsk_need_resched(struct task_struct *tsk)
+static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
 {
-	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
+	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
+		return unlikely(test_tsk_thread_flag(tsk, tif_resched(rs)));
+	else
+		return false;
 }
 
 /*
@@ -2104,7 +2121,8 @@ static __always_inline bool need_resched(void)
 
 static __always_inline bool need_resched_lazy(void)
 {
-	return unlikely(tif_need_resched(NR_lazy));
+	return IS_ENABLED(CONFIG_PREEMPT_AUTO) &&
+		unlikely(tif_need_resched(NR_lazy));
 }
 
 /*
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index fec804b79080..a085d337434e 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -73,7 +73,7 @@ void rcu_sched_clock_irq(int user)
 	if (user) {
 		rcu_qs();
 	} else if (rcu_ctrlblk.donetail != rcu_ctrlblk.curtail) {
-		set_tsk_need_resched(current);
+		set_tsk_need_resched(current, NR_now);
 		set_preempt_need_resched();
 	}
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1ae851777806..d6ac2b703a6d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2250,7 +2250,7 @@ void rcu_sched_clock_irq(int user)
 	if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
 		/* Idle and userspace execution already are quiescent states. */
 		if (!rcu_is_cpu_rrupt_from_idle() && !user) {
-			set_tsk_need_resched(current);
+			set_tsk_need_resched(current, NR_now);
 			set_preempt_need_resched();
 		}
 		__this_cpu_write(rcu_data.rcu_urgent_qs, false);
@@ -2409,7 +2409,7 @@ static __latent_entropy void rcu_core(void)
 	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK))) {
 		rcu_preempt_deferred_qs(current);
 	} else if (rcu_preempt_need_deferred_qs(current)) {
-		set_tsk_need_resched(current);
+		set_tsk_need_resched(current, NR_now);
 		set_preempt_need_resched();
 	}
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6d7cea5d591f..34d0bbd93343 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -759,7 +759,7 @@ static void rcu_exp_handler(void *unused)
 			rcu_report_exp_rdp(rdp);
 		} else {
 			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
-			set_tsk_need_resched(t);
+			set_tsk_need_resched(t, NR_now);
 			set_preempt_need_resched();
 		}
 		return;
@@ -860,7 +860,7 @@ static void rcu_exp_need_qs(void)
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
 	/* Store .exp before .rcu_urgent_qs. */
 	smp_store_release(this_cpu_ptr(&rcu_data.rcu_urgent_qs), true);
-	set_tsk_need_resched(current);
+	set_tsk_need_resched(current, NR_now);
 	set_preempt_need_resched();
 }
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 41021080ad25..26c79246873a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -658,7 +658,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Also if no expediting and no possible deboosting,
 			// slow is OK.  Plus nohz_full CPUs eventually get
 			// tick enabled.
-			set_tsk_need_resched(current);
+			set_tsk_need_resched(current, NR_now);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
 			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
@@ -725,7 +725,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
 		if (rcu_preempt_need_deferred_qs(t)) {
-			set_tsk_need_resched(t);
+			set_tsk_need_resched(t, NR_now);
 			set_preempt_need_resched();
 		}
 	} else if (rcu_preempt_need_deferred_qs(t)) {
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5d666428546b..9d4aa4fde5ae 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -712,7 +712,7 @@ static void print_cpu_stall(unsigned long gps)
 	 * progress and it could be we're stuck in kernel space without context
 	 * switches for an entirely unreasonable amount of time.
 	 */
-	set_tsk_need_resched(current);
+	set_tsk_need_resched(current, NR_now);
 	set_preempt_need_resched();
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..41c3bd49a700 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -933,7 +933,7 @@ static bool set_nr_if_polling(struct task_struct *p)
 #else
 static inline bool set_nr_and_not_polling(struct task_struct *p)
 {
-	set_tsk_need_resched(p);
+	set_tsk_need_resched(p, NR_now);
 	return true;
 }
 
@@ -1045,13 +1045,13 @@ void resched_curr(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(curr, NR_now))
 		return;
 
 	cpu = cpu_of(rq);
 
 	if (cpu == smp_processor_id()) {
-		set_tsk_need_resched(curr);
+		set_tsk_need_resched(curr, NR_now);
 		set_preempt_need_resched();
 		return;
 	}
@@ -2247,7 +2247,8 @@ void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 	 * A queue event has occurred, and we're going to schedule.  In
 	 * this case, we can save a useless back to back clock update.
 	 */
-	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
+	if (task_on_rq_queued(rq->curr) &&
+	    test_tsk_need_resched(rq->curr, NR_now))
 		rq_clock_skip_update(rq);
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a04a436af8cc..b4e68cfc3c3a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2035,7 +2035,7 @@ static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 	 * let us try to decide what's the best thing to do...
 	 */
 	if ((p->dl.deadline == rq->curr->dl.deadline) &&
-	    !test_tsk_need_resched(rq->curr))
+	    !test_tsk_need_resched(rq->curr, NR_now))
 		check_preempt_equal_dl(rq, p);
 #endif /* CONFIG_SMP */
 }
@@ -2564,7 +2564,7 @@ static void pull_dl_task(struct rq *this_rq)
 static void task_woken_dl(struct rq *rq, struct task_struct *p)
 {
 	if (!task_on_cpu(rq, p) &&
-	    !test_tsk_need_resched(rq->curr) &&
+	    !test_tsk_need_resched(rq->curr, NR_now) &&
 	    p->nr_cpus_allowed > 1 &&
 	    dl_task(rq->curr) &&
 	    (rq->curr->nr_cpus_allowed < 2 ||
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..ae9b237fa32b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8298,7 +8298,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(curr, NR_now))
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index be53d164e267..cd25f71f43a7 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -359,7 +359,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	struct idle_timer *it = container_of(timer, struct idle_timer, timer);
 
 	WRITE_ONCE(it->done, 1);
-	set_tsk_need_resched(current);
+	set_tsk_need_resched(current, NR_now);
 
 	return HRTIMER_NORESTART;
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3261b067b67e..c57cc8427a57 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1680,7 +1680,7 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 	 * to move current somewhere else, making room for our non-migratable
 	 * task.
 	 */
-	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
+	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr, NR_now))
 		check_preempt_equal_prio(rq, p);
 #endif
 }
@@ -2415,7 +2415,7 @@ static void pull_rt_task(struct rq *this_rq)
 static void task_woken_rt(struct rq *rq, struct task_struct *p)
 {
 	bool need_to_push = !task_on_cpu(rq, p) &&
-			    !test_tsk_need_resched(rq->curr) &&
+			    !test_tsk_need_resched(rq->curr, NR_now) &&
 			    p->nr_cpus_allowed > 1 &&
 			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
 			    (rq->curr->nr_cpus_allowed < 2 ||
-- 
2.31.1


