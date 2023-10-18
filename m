Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012AF7CDB55
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjJRMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjJRMLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:11:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85016112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:11:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IBJLfS000684;
        Wed, 18 Oct 2023 12:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Xg6EanTftiyMqUZbMlbHuBtOjT3ZhTAPp4rpTviCHdY=;
 b=U6vyL163d7QKEJKU7/nJZ14NVT2iQ1aHYLXYoSg3nomcuBV8/WCF0tOeyuPTTqjwiZKd
 8g0A1tA7mx7imcA7s/kMcBrme0w5RIptluEpqWThaquLFzhfBD1jm0XVSxx5ghTrFw/u
 b9dJNwdbtiMRk0N6P5D/QJxMhy5SAMNrrjGpqzR1/t6bIqVDUn3tN6KPc5rOPv9ixB5G
 UH8nnEvJ6Iys52UlxQhlDfhjZyNrbUp4G4nwvoEQhBVnHD9TkSDhM3hIyXuwrtKGjarw
 WZ69E7aFIgT9g+74QwGIUicOYPXDmeHP2mnr5ApR18L57/78VlTXtqBaQpuHJUnNft2h XA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jqcjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 12:09:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IBfM9K026871;
        Wed, 18 Oct 2023 12:09:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg5573tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 12:09:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFXVZnZGUxkLZW88x+zLq3KrWkfkMnZKaHYjYTwaO8T+clR3mY6kRoK1E1BKdCShWJcTi9efcPy62tsDmTC9Qc/S1LyObMQIrZwNzGWP2kY99CUc2WX56fdX+HrGyTeIv+0qScGKyoQqvJfU7kKj3S9OpWJSxFhHIM7eQtWE4MHl2Q4SGYiEON9zT4WpQ4w60g/Hy8ZHGgt4HXsLYBA19qmTTCXD7xehPBVxuLdQ+6bgG2zh9VpLW1S4Uj4RTgCffFZ7nwdWxy6qmPHwUG/gGbyfRkTMUkJuNc01FZ16+iAbbexNcbJeB+uHLh9EWwkOK9+Of0bPMHxZObiCgErEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg6EanTftiyMqUZbMlbHuBtOjT3ZhTAPp4rpTviCHdY=;
 b=S9ZbDsueZJ6Ft+ms0LVopRcDwtap5cPv8/YFUW1+BLFuyA9qz+NFE+h6J5V6BnTXh4BqszNfwwOaa6P8ZvSAbq2CROYM6sRlf0eQ565wNN6EGPJlLZ0zjkoZufudks/Jth8hea1LF/M9BN1dvhuchMUDhxlwmHlSTcjDpl/lhYz1Xn4GWVyGfoBKDvFiRmpGZGb3Jo+5AhGKHzpFYiPs/FsY7h9iVttWBeTtBrD2LhSyd+PcvFsTkQ0Ec1g4Jo+E+qn3HzIhs5wT1XKy++IOi1YNXl7MYtdxuCe0flmRb3o/H/rAWH11uGoS5SWtp2iACRrKbOhPbxnBWNeAFBtUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg6EanTftiyMqUZbMlbHuBtOjT3ZhTAPp4rpTviCHdY=;
 b=ndYR0l8p7EHWMe0VZsyyCkyxL/xFPZY4UxRyAnRrgYoFMXx38ZHjNbEPgZ2r5oNs765ng1e9JCyPNKY9XkVW32PyUxYJ9cKWKQxn2bzU0XjQpXZ70KwGiaM+ie9KKF/h1nnSpWtundT2pPFa7rKBjnhegGKYcLQtyPVSlR3NEFU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 12:09:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 12:09:48 +0000
References: <87ttrngmq0.ffs@tglx> <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
Date:   Wed, 18 Oct 2023 05:09:46 -0700
Message-ID: <87il74qghh.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: e96171b8-6a07-4035-9eb3-08dbcfd31f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mi8RAvqzC32mtGR0KoPhyrc3lumi5Di6RcRaRNpeDmpGWiR5mBBguYNuUphTMhxNLB/0Vcz24i2Y00gC0zyRg+KOXjaBmKbR9siO8DCCQOVkRTJ3hWx35esg7gMgqWR6z4Znn4Lx2h773b80bexSeM0hxX8PFDsHx0ZtgukxyUo2JnPDuagrwSkLXHetB8ar817J05OcHW8sIiHjzy3NKtL/AhPISc3ccugqSgvS7qXArJ81N5NqgilvizLoppzosWAst3I4kSznnehR1GtaAshKbLw65Wr+22gNlkPG3VKqJ624q0tdBqDVaP9HNx2TnlV+a/TLBTL+pcbpOcR4b2raMhekzgqIqe0MQBZtop1BuuXX10KL948ylNRX0xhrLHF0CDbJU9EmoZhUA6p6kniOdlqPqRM3fl4fB474aHwNssQ6MvEFISv0PR4ayibil84eiQzXynJIBXcGHmtU7nYqMMuSAYqSlqndo0Nk4k0dRnkA33hIUNB44BHPeNEy+9gkvWztiRHhmjY7xZZIEFadoQtU9n5JmY8RmVnmEC14xSsLlNfTUe1oCh2bTU/bEDzOK0jHUzNPhjO80Tx7d9pZon3yNcxckiKiam4iCaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(8936002)(26005)(2616005)(6506007)(6512007)(83380400001)(5660300002)(41300700001)(8676002)(4326008)(7416002)(30864003)(2906002)(478600001)(6486002)(966005)(316002)(66476007)(54906003)(38100700002)(66946007)(6916009)(66556008)(86362001)(36756003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VIe7s+3owQP4M2aoJmj/8lQKoja3zwk7autO4jCvIUkvf6wiwjO4QUaUcdh6?=
 =?us-ascii?Q?qPqFaBB7ENtIrhcdkQqwNxpIbfyHqrYj0RS1G0t5IxPRTBfV6o46/rKMYCsg?=
 =?us-ascii?Q?keuzMDnfIXJvGyvQIHT6RbOMBDoEH1sydAdNQiBPI9zZuEcRmDQ8f7zHaC2V?=
 =?us-ascii?Q?REyiiIrrwAuAZyGD8OydwPMI9MVZaJDDrp6Ta+7D89gA9aUX27Ke5qyYlWre?=
 =?us-ascii?Q?QifkbSxT5QcuQGkMMs6SZU66Zh43HIbyo8pfI7JxeP1B4kON3qgM57gfHWRN?=
 =?us-ascii?Q?xiHoCjwY983UWkWXJC7zw13Qj4rnz0vBM2djZFLjOSrHzY/gqm65cJl/JmRw?=
 =?us-ascii?Q?NzPLtUN0MN7PdWcuZ/E3R76F5zHgLf7QBeN700HiKnjLU9o7v7QJdEwwfHI3?=
 =?us-ascii?Q?fb0mdlFXsY9J2LjVMnoOg+2aXXEMnv0xw9zCoV+Bd4YClNqEDfBQkGmDzWCH?=
 =?us-ascii?Q?QqYMqgQEX1EhlpSwutdMGL8ANIIL6LWHY6/W1Ro/PmAeRPUsptT0JG2xUIpN?=
 =?us-ascii?Q?7LTe6ItkE0t9hnzgnBffxPFhGMxt/JD/HKQZC64qh8SqZn8JfQ0c+9B2lPlx?=
 =?us-ascii?Q?kvEsvrXWH7LZg+6kNrA/Gz8d4SAvPwoCUyY4muI8g4y+7N2atDDoJ7Lh792U?=
 =?us-ascii?Q?lPfqaOkOWs8NkkEEotycJgoeB4bPkf0T0h83LpM80dTTvD3rgYmZ71vWgrNj?=
 =?us-ascii?Q?Xpiz4errFqSNSx7Wh2r+ulzkZJUquaV7avVNJqwy/jOPn10vWVxnyOBHGnbx?=
 =?us-ascii?Q?BKT3SdnUJmM1NqWD32Lf7UUKvbYYqVciM3sme3nRtuPvyUKRtR0xcTCR/bWr?=
 =?us-ascii?Q?tXRSjM8PA8L8cPcZxBqp6wGlUuMhRC64lghNcTcNXNKv7PYQzxdzEgGwBa7e?=
 =?us-ascii?Q?/yq7ePiuJBl4Y9a1DOswErshuZVq1l/GTBmYebyVMAwQRhHiIsUeNfqyxWA4?=
 =?us-ascii?Q?KJGqnDcQKZaWKcqLfGK0CuOVpnx1AQbLWVHsOVSN5NsY7Jkfez8jMqCrueea?=
 =?us-ascii?Q?rMFTUl2jPqkb97+/l/nNSntKIaq6i3fFfCiIwG/e1HucJvhvbENbA/Pjc0Re?=
 =?us-ascii?Q?blJ5Op4Cn39h9fLxLkaVtZJS5dGKqaWtqt8bj4jcuuNJXEpGItYjoOLVWIpB?=
 =?us-ascii?Q?q/WamyaE5eJrbifXZcxxoMsfXPdzzZLV5cNP0Ec40ZvJaxy0ryQO8wQcuUdE?=
 =?us-ascii?Q?fQr6XttnnPkwejZLRkgprR7Z72MRX24CF6dp9GJ43DqFGMJE7xA9aVoVHnr2?=
 =?us-ascii?Q?qYHNHCkevUjPtrQa3iZ6djVmroZgPnlgwIS/X9ZGvlzFzKciwjix20m/H1+W?=
 =?us-ascii?Q?qNYfTOr/9eQm3BK5GuuXOcXozz2DuoGatKWMXEK3nZBLSS90EwNB7A4WAxYe?=
 =?us-ascii?Q?+3oO35RxE7bYKwUSo5x53bpEgAtnlug9LWKWoJ9s925CAqNkkKEYXBTcteob?=
 =?us-ascii?Q?dS0hy4PCbyGU/5l6tor2lXNuY3NjAwhC6aO2LW9oX9Otzwni0nNA+K77E8ZH?=
 =?us-ascii?Q?Y0XGdY3eGvQ9lB8SGPFG5DY+LGiyUfD15jfhfSeHCoHSxsMDi9Gg/nsLy7WG?=
 =?us-ascii?Q?w47b1B0y+gYxQ9cARJnhUNcBgN55dgrjr5UCkMW7vjNce2QzirJnfjA0CpR+?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+N7/ymVLVX8iucXrxe0gPS6JkfJ2FqvtxKWX4267dmW4Gjrw+W/I6u7saIAm?=
 =?us-ascii?Q?WrqLVRO94gT5Xin9bdhPQQtZO9FQ8+ev2JgRusTYLK78lD0ZCFIdMh05I1Fs?=
 =?us-ascii?Q?TYfUMCBMjZaSNCDR+E0keE3SvtfnHygILROIQ0BBzRp4NtiFX81Jto1F6oPB?=
 =?us-ascii?Q?6urHDOjfttsde2XJi/UK7ozMwAgaBnM0cQMrskwLq+ifUA7fjJH/864hzSl5?=
 =?us-ascii?Q?wf+z13udTyLOm04pPT6zoYIJ4WALCkiqIi2TDGjrJZmWzJ/+quvDHm2Xz8SB?=
 =?us-ascii?Q?Y7USiFBX0RfconQc1+QRaDsYPQhadAPLwpH1Sv8Yi9NP+N4myucFluXrswpb?=
 =?us-ascii?Q?u2/S6ehuVV9jEneH/iVR1uU0WNoAzcsDXUzUg/aVvXxOIuNBG01IqPv8yt4V?=
 =?us-ascii?Q?OYWwKqKccFPuEnd9X3p+6aPfk/9VVcL1QCGti2D9E3pMnQdj7vIiGkHkTnGk?=
 =?us-ascii?Q?Yx9PIh3UfoqcDaUG1FMl+JuyTCP+776gHWF8hmSXXfzItcRPol7VABImPp4h?=
 =?us-ascii?Q?rqVJeEuMDCBW0IMfK+fryNQnUPRW+vEarrowf3V80rodUYGBZyU+G4CEWZ9H?=
 =?us-ascii?Q?kMQRySDbSFT6vi2lcpawdBS3lUB6yUEZsMlBy3YldVlvxlRSJWMeR8X8IXtW?=
 =?us-ascii?Q?9pGL/aflTVuaXBO4pL+IihkyV5O0aQPZ2sG6RdkCkrmUeLU5sDKQwG6FqUhA?=
 =?us-ascii?Q?soz5XwI2wrxpTfaoviKyuTLGADygRnkNxDbrBr08ubJCjnB7R8JzupKXiS/U?=
 =?us-ascii?Q?7sU8W6jZzAQQc+Y906Et1z29yxId+uPNw6xl/NwGx7nL6lfq4MV2mfdmIDso?=
 =?us-ascii?Q?35Zxo+ZDsInfA8acxEn1mo/+ZT12H+KyGAySkuO53LXN+xceFaSCdoaBOosv?=
 =?us-ascii?Q?1z17isZ5neARVtMtWBepTXvQehQVA/WIm4XZuEETroCxwu9w+BxSkGKFoD8w?=
 =?us-ascii?Q?vZ1TIVnJM2dkej6iKc4dL/mdtHXASPME/frVpSBiFqUvsmTpA94TTjDyKRiJ?=
 =?us-ascii?Q?KTC9uq4B3abCOLUBXXhFW57TvObIha7pp156y3F2AC0+oZa/lilukqfmnnPd?=
 =?us-ascii?Q?Tq1O05cm0RQbjPdnuGgVc21KG1uosCYtmHVTDL18dlpo4hVOAqwtRcQHPXyK?=
 =?us-ascii?Q?REbT+c7fzVgkB2W1ru8fxLDscEkaKHBwkQjztUtGlxseXpzDDRka3Hm3Xrsn?=
 =?us-ascii?Q?l4NUEJb9BWmwsuDsyVHgcsqRkHQaUHHDVnwC/DW0u+/BpXaEEvapgKei0Uyn?=
 =?us-ascii?Q?TspAzroIHp7OeFA8ZbVo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96171b8-6a07-4035-9eb3-08dbcfd31f99
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:09:48.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQpckTadvoBO4bD2eUJXCXU7rVhMNJbuN9ycluZT7oOWG2w6XQ3pPSR22dA3gJJ9BsYWgv1Cp1nGOqoZmjNnBY5yCdId7CRhRgGHbiynekQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_09,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180100
X-Proofpoint-GUID: 4QvpCFbKEN8Erca2yY__JFYhh8Viekpt
X-Proofpoint-ORIG-GUID: 4QvpCFbKEN8Erca2yY__JFYhh8Viekpt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney <paulmck@kernel.org> writes:

> On Sat, Sep 23, 2023 at 03:11:05AM +0200, Thomas Gleixner wrote:
>> On Fri, Sep 22 2023 at 00:55, Thomas Gleixner wrote:
>> > On Thu, Sep 21 2023 at 09:00, Linus Torvalds wrote:
>> >> That said - I think as a proof of concept and "look, with this we get
>> >> the expected scheduling event counts", that patch is perfect. I think
>> >> you more than proved the concept.
>> >
>> > There is certainly quite some analyis work to do to make this a one to
>> > one replacement.
>> >
>> > With a handful of benchmarks the PoC (tweaked with some obvious fixes)
>> > is pretty much on par with the current mainline variants (NONE/FULL),
>> > but the memtier benchmark makes a massive dent.
>> >
>> > It sports a whopping 10% regression with the LAZY mode versus the mainline
>> > NONE model. Non-LAZY and FULL behave unsurprisingly in the same way.
>> >
>> > That benchmark is really sensitive to the preemption model. With current
>> > mainline (DYNAMIC_PREEMPT enabled) the preempt=FULL model has ~20%
>> > performance drop versus preempt=NONE.
>>
>> That 20% was a tired pilot error. The real number is in the 5% ballpark.
>>
>> > I have no clue what's going on there yet, but that shows that there is
>> > obviously quite some work ahead to get this sorted.
>>
>> It took some head scratching to figure that out. The initial fix broke
>> the handling of the hog issue, i.e. the problem that Ankur tried to
>> solve, but I hacked up a "solution" for that too.
>>
>> With that the memtier benchmark is roughly back to the mainline numbers,
>> but my throughput benchmark know how is pretty close to zero, so that
>> should be looked at by people who actually understand these things.
>>
>> Likewise the hog prevention is just at the PoC level and clearly beyond
>> my knowledge of scheduler details: It unconditionally forces a
>> reschedule when the looping task is not responding to a lazy reschedule
>> request before the next tick. IOW it forces a reschedule on the second
>> tick, which is obviously different from the cond_resched()/might_sleep()
>> behaviour.
>>
>> The changes vs. the original PoC aside of the bug and thinko fixes:
>>
>>     1) A hack to utilize the TRACE_FLAG_IRQS_NOSUPPORT flag to trace the
>>        lazy preempt bit as the trace_entry::flags field is full already.
>>
>>        That obviously breaks the tracer ABI, but if we go there then
>>        this needs to be fixed. Steven?
>>
>>     2) debugfs file to validate that loops can be force preempted w/o
>>        cond_resched()
>>
>>        The usage is:
>>
>>        # taskset -c 1 bash
>>        # echo 1 > /sys/kernel/debug/sched/hog &
>>        # echo 1 > /sys/kernel/debug/sched/hog &
>>        # echo 1 > /sys/kernel/debug/sched/hog &
>>
>>        top shows ~33% CPU for each of the hogs and tracing confirms that
>>        the crude hack in the scheduler tick works:
>>
>>             bash-4559    [001] dlh2.  2253.331202: resched_curr <-__update_curr
>>             bash-4560    [001] dlh2.  2253.340199: resched_curr <-__update_curr
>>             bash-4561    [001] dlh2.  2253.346199: resched_curr <-__update_curr
>>             bash-4559    [001] dlh2.  2253.353199: resched_curr <-__update_curr
>>             bash-4561    [001] dlh2.  2253.358199: resched_curr <-__update_curr
>>             bash-4560    [001] dlh2.  2253.370202: resched_curr <-__update_curr
>>             bash-4559    [001] dlh2.  2253.378198: resched_curr <-__update_curr
>>             bash-4561    [001] dlh2.  2253.389199: resched_curr <-__update_curr
>>
>>        The 'l' instead of the usual 'N' reflects that the lazy resched
>>        bit is set. That makes __update_curr() invoke resched_curr()
>>        instead of the lazy variant. resched_curr() sets TIF_NEED_RESCHED
>>        and folds it into preempt_count so that preemption happens at the
>>        next possible point, i.e. either in return from interrupt or at
>>        the next preempt_enable().
>
> Belatedly calling out some RCU issues.  Nothing fatal, just a
> (surprisingly) few adjustments that will need to be made.  The key thing
> to note is that from RCU's viewpoint, with this change, all kernels
> are preemptible, though rcu_read_lock() readers remain non-preemptible.

Yeah, in Thomas' patch CONFIG_PREEMPTION=y and preemption models
none/voluntary/full are just scheduler tweaks on top of that. And, so
this would always have PREEMPT_RCU=y. So, shouldn't rcu_read_lock()
readers be preemptible?

(An alternate configuration might be:
   config PREEMPT_NONE
      select PREEMPT_COUNT

    config PREEMPT_FULL
      select PREEMPTION

 This probably allows for more configuration flexibility across archs?
 Would allow for TREE_RCU=y, for instance. That said, so far I've only
 been working with PREEMPT_RCU=y.)

> With that:
>
> 1.	As an optimization, given that preempt_count() would always give
> 	good information, the scheduling-clock interrupt could sense RCU
> 	readers for new-age CONFIG_PREEMPT_NONE=y kernels.  As might the
> 	IPI handlers for expedited grace periods.  A nice optimization.
> 	Except that...
>
> 2.	The quiescent-state-forcing code currently relies on the presence
> 	of cond_resched() in CONFIG_PREEMPT_RCU=n kernels.  One fix
> 	would be to do resched_cpu() more quickly, but some workloads
> 	might not love the additional IPIs.  Another approach to do #1
> 	above to replace the quiescent states from cond_resched() with
> 	scheduler-tick-interrupt-sensed quiescent states.

Right, the call to rcu_all_qs(). Just to see if I have it straight,
something like this for PREEMPT_RCU=n kernels?

   if ((preempt_count() & ~PREEMPT_NEED_RESCHED) == 0)
           rcu_all_qs();

(Masked because PREEMPT_NONE might not do any folding for
NEED_RESCHED_LAZY in the tick.)

Though the comment around rcu_all_qs() mentions that rcu_all_qs()
reports a quiescent state only if urgently needed. Given that the tick
executes less frequently than calls to cond_resched(), could we just
always report instead? Or I'm completely on the wrong track?

   if ((preempt_count() & ~PREEMPT_NEED_RESCHED) == 0) {
             preempt_disable();
             rcu_qs();
             preempt_enable();
   }

On your point about the preempt_count() being dependable, there's a
wrinkle. As Linus mentions in
https://lore.kernel.org/lkml/CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com/,
that might not be true for architectures that define ARCH_NO_PREEMPT.

My plan was to limit those archs to do preemption only at user space boundary
but there are almost certainly RCU implications that I missed.

> 	Plus...
>
> 3.	For nohz_full CPUs that run for a long time in the kernel,
> 	there are no scheduling-clock interrupts.  RCU reaches for
> 	the resched_cpu() hammer a few jiffies into the grace period.
> 	And it sets the ->rcu_urgent_qs flag so that the holdout CPU's
> 	interrupt-entry code will re-enable its scheduling-clock interrupt
> 	upon receiving the resched_cpu() IPI.
>
> 	So nohz_full CPUs should be OK as far as RCU is concerned.
> 	Other subsystems might have other opinions.

Ah, that's what I thought from my reading of the RCU comments. Good to
have that confirmed. Thanks.

> 4.	As another optimization, kvfree_rcu() could unconditionally
> 	check preempt_count() to sense a clean environment suitable for
> 	memory allocation.

Had missed this completely. Could you elaborate?

> 5.	Kconfig files with "select TASKS_RCU if PREEMPTION" must
> 	instead say "select TASKS_RCU".  This means that the #else
> 	in include/linux/rcupdate.h that defines TASKS_RCU in terms of
> 	vanilla RCU must go.  There might be be some fallout if something
> 	fails to select TASKS_RCU, builds only with CONFIG_PREEMPT_NONE=y,
> 	and expects call_rcu_tasks(), synchronize_rcu_tasks(), or
> 	rcu_tasks_classic_qs() do do something useful.

Ack.

> 6.	You might think that RCU Tasks (as opposed to RCU Tasks Trace
> 	or RCU Tasks Rude) would need those pesky cond_resched() calls
> 	to stick around.  The reason is that RCU Tasks readers are ended
> 	only by voluntary context switches.  This means that although a
> 	preemptible infinite loop in the kernel won't inconvenience a
> 	real-time task (nor an non-real-time task for all that long),
> 	and won't delay grace periods for the other flavors of RCU,
> 	it would indefinitely delay an RCU Tasks grace period.
>
> 	However, RCU Tasks grace periods seem to be finite in preemptible
> 	kernels today, so they should remain finite in limited-preemptible
> 	kernels tomorrow.  Famous last words...
>
> 7.	RCU Tasks Trace, RCU Tasks Rude, and SRCU shouldn't notice
> 	any algorithmic difference from this change.

So, essentially, as long as RCU tasks eventually, in the fullness of
time, call schedule(), removing cond_resched() shouldn't have any
effect :).

> 8.	As has been noted elsewhere, in this new limited-preemption
> 	mode of operation, rcu_read_lock() readers remain preemptible.
> 	This means that most of the CONFIG_PREEMPT_RCU #ifdefs remain.

Ack.

> 9.	The rcu_preempt_depth() macro could do something useful in
> 	limited-preemption kernels.  Its current lack of ability in
> 	CONFIG_PREEMPT_NONE=y kernels has caused trouble in the past.
>
> 10.	The cond_resched_rcu() function must remain because we still
> 	have non-preemptible rcu_read_lock() readers.

For configurations with PREEMPT_RCU=n? Yes, agreed. Though it need
only be this, right?:

   static inline void cond_resched_rcu(void)
   {
   #if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
           rcu_read_unlock();

           rcu_read_lock();
   #endif
   }

> 11.	My guess is that the IPVS_EST_TICK_CHAINS heuristic remains
> 	unchanged, but I must defer to the include/net/ip_vs.h people.
>
> 12.	I need to check with the BPF folks on the BPF verifier's
> 	definition of BTF_ID(func, rcu_read_unlock_strict).
>
> 13.	The kernel/locking/rtmutex.c file's rtmutex_spin_on_owner()
> 	function might have some redundancy across the board instead
> 	of just on CONFIG_PREEMPT_RCU=y.  Or might not.

I don't think I understand any of these well enough to comment. Will
Cc the relevant folks when I send out the RFC.

> 14.	The kernel/trace/trace_osnoise.c file's run_osnoise() function
> 	might need to do something for non-preemptible RCU to make
> 	up for the lack of cond_resched() calls.  Maybe just drop the
> 	"IS_ENABLED()" and execute the body of the current "if" statement
> 	unconditionally.

Aah, yes this is a good idea. Thanks.

> 15.	I must defer to others on the mm/pgtable-generic.c file's
> 	#ifdef that depends on CONFIG_PREEMPT_RCU.
>
> While in the area, I noted that KLP seems to depend on cond_resched(),
> but on this I must defer to the KLP people.

Yeah, as part of this work, I ended up unhooking most of the KLP
hooks in cond_resched() and of course, cond_resched() itself.
Will poke the livepatching people.

> I am sure that I am missing something, but I have not yet seen any
> show-stoppers.  Just some needed adjustments.

Appreciate this detailed list. Makes me think that everything might
not go up in smoke after all!

Thanks
Ankur

> Thoughts?
>
> 							Thanx, Paul
>
>> That's as much as I wanted to demonstrate and I'm not going to spend
>> more cycles on it as I have already too many other things on flight and
>> the resulting scheduler woes are clearly outside of my expertice.
>>
>> Though definitely I'm putting a permanent NAK in place for any attempts
>> to duct tape the preempt=NONE model any further by sprinkling more
>> cond*() and whatever warts around.
>>
>> Thanks,
>>
>>         tglx
>> ---
>>  arch/x86/Kconfig                   |    1
>>  arch/x86/include/asm/thread_info.h |    6 ++--
>>  drivers/acpi/processor_idle.c      |    2 -
>>  include/linux/entry-common.h       |    2 -
>>  include/linux/entry-kvm.h          |    2 -
>>  include/linux/sched.h              |   12 +++++---
>>  include/linux/sched/idle.h         |    8 ++---
>>  include/linux/thread_info.h        |   24 +++++++++++++++++
>>  include/linux/trace_events.h       |    8 ++---
>>  kernel/Kconfig.preempt             |   17 +++++++++++-
>>  kernel/entry/common.c              |    4 +-
>>  kernel/entry/kvm.c                 |    2 -
>>  kernel/sched/core.c                |   51 +++++++++++++++++++++++++------------
>>  kernel/sched/debug.c               |   19 +++++++++++++
>>  kernel/sched/fair.c                |   46 ++++++++++++++++++++++-----------
>>  kernel/sched/features.h            |    2 +
>>  kernel/sched/idle.c                |    3 --
>>  kernel/sched/sched.h               |    1
>>  kernel/trace/trace.c               |    2 +
>>  kernel/trace/trace_output.c        |   16 ++++++++++-
>>  20 files changed, 171 insertions(+), 57 deletions(-)
>>
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -898,14 +898,15 @@ static inline void hrtick_rq_init(struct
>>
>>  #if defined(CONFIG_SMP) && defined(TIF_POLLING_NRFLAG)
>>  /*
>> - * Atomically set TIF_NEED_RESCHED and test for TIF_POLLING_NRFLAG,
>> + * Atomically set TIF_NEED_RESCHED[_LAZY] and test for TIF_POLLING_NRFLAG,
>>   * this avoids any races wrt polling state changes and thereby avoids
>>   * spurious IPIs.
>>   */
>> -static inline bool set_nr_and_not_polling(struct task_struct *p)
>> +static inline bool set_nr_and_not_polling(struct task_struct *p, int tif_bit)
>>  {
>>  	struct thread_info *ti = task_thread_info(p);
>> -	return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
>> +
>> +	return !(fetch_or(&ti->flags, 1 << tif_bit) & _TIF_POLLING_NRFLAG);
>>  }
>>
>>  /*
>> @@ -922,7 +923,7 @@ static bool set_nr_if_polling(struct tas
>>  	for (;;) {
>>  		if (!(val & _TIF_POLLING_NRFLAG))
>>  			return false;
>> -		if (val & _TIF_NEED_RESCHED)
>> +		if (val & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
>>  			return true;
>>  		if (try_cmpxchg(&ti->flags, &val, val | _TIF_NEED_RESCHED))
>>  			break;
>> @@ -931,9 +932,9 @@ static bool set_nr_if_polling(struct tas
>>  }
>>
>>  #else
>> -static inline bool set_nr_and_not_polling(struct task_struct *p)
>> +static inline bool set_nr_and_not_polling(struct task_struct *p, int tif_bit)
>>  {
>> -	set_tsk_need_resched(p);
>> +	set_tsk_thread_flag(p, tif_bit);
>>  	return true;
>>  }
>>
>> @@ -1038,28 +1039,47 @@ void wake_up_q(struct wake_q_head *head)
>>   * might also involve a cross-CPU call to trigger the scheduler on
>>   * the target CPU.
>>   */
>> -void resched_curr(struct rq *rq)
>> +static void __resched_curr(struct rq *rq, int lazy)
>>  {
>> +	int cpu, tif_bit = TIF_NEED_RESCHED + lazy;
>>  	struct task_struct *curr = rq->curr;
>> -	int cpu;
>>
>>  	lockdep_assert_rq_held(rq);
>>
>> -	if (test_tsk_need_resched(curr))
>> +	if (unlikely(test_tsk_thread_flag(curr, tif_bit)))
>>  		return;
>>
>>  	cpu = cpu_of(rq);
>>
>>  	if (cpu == smp_processor_id()) {
>> -		set_tsk_need_resched(curr);
>> -		set_preempt_need_resched();
>> +		set_tsk_thread_flag(curr, tif_bit);
>> +		if (!lazy)
>> +			set_preempt_need_resched();
>>  		return;
>>  	}
>>
>> -	if (set_nr_and_not_polling(curr))
>> -		smp_send_reschedule(cpu);
>> -	else
>> +	if (set_nr_and_not_polling(curr, tif_bit)) {
>> +		if (!lazy)
>> +			smp_send_reschedule(cpu);
>> +	} else {
>>  		trace_sched_wake_idle_without_ipi(cpu);
>> +	}
>> +}
>> +
>> +void resched_curr(struct rq *rq)
>> +{
>> +	__resched_curr(rq, 0);
>> +}
>> +
>> +void resched_curr_lazy(struct rq *rq)
>> +{
>> +	int lazy = IS_ENABLED(CONFIG_PREEMPT_AUTO) && !sched_feat(FORCE_NEED_RESCHED) ?
>> +		TIF_NEED_RESCHED_LAZY_OFFSET : 0;
>> +
>> +	if (lazy && unlikely(test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED)))
>> +		return;
>> +
>> +	__resched_curr(rq, lazy);
>>  }
>>
>>  void resched_cpu(int cpu)
>> @@ -1132,7 +1152,7 @@ static void wake_up_idle_cpu(int cpu)
>>  	if (cpu == smp_processor_id())
>>  		return;
>>
>> -	if (set_nr_and_not_polling(rq->idle))
>> +	if (set_nr_and_not_polling(rq->idle, TIF_NEED_RESCHED))
>>  		smp_send_reschedule(cpu);
>>  	else
>>  		trace_sched_wake_idle_without_ipi(cpu);
>> @@ -8872,7 +8892,6 @@ static void __init preempt_dynamic_init(
>>  		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
>>  		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
>>  	}									 \
>> -	EXPORT_SYMBOL_GPL(preempt_model_##mode)
>>
>>  PREEMPT_MODEL_ACCESSOR(none);
>>  PREEMPT_MODEL_ACCESSOR(voluntary);
>> --- a/include/linux/thread_info.h
>> +++ b/include/linux/thread_info.h
>> @@ -59,6 +59,16 @@ enum syscall_work_bit {
>>
>>  #include <asm/thread_info.h>
>>
>> +#ifdef CONFIG_PREEMPT_AUTO
>> +# define TIF_NEED_RESCHED_LAZY		TIF_ARCH_RESCHED_LAZY
>> +# define _TIF_NEED_RESCHED_LAZY		_TIF_ARCH_RESCHED_LAZY
>> +# define TIF_NEED_RESCHED_LAZY_OFFSET	(TIF_NEED_RESCHED_LAZY - TIF_NEED_RESCHED)
>> +#else
>> +# define TIF_NEED_RESCHED_LAZY		TIF_NEED_RESCHED
>> +# define _TIF_NEED_RESCHED_LAZY		_TIF_NEED_RESCHED
>> +# define TIF_NEED_RESCHED_LAZY_OFFSET	0
>> +#endif
>> +
>>  #ifdef __KERNEL__
>>
>>  #ifndef arch_set_restart_data
>> @@ -185,6 +195,13 @@ static __always_inline bool tif_need_res
>>  			     (unsigned long *)(&current_thread_info()->flags));
>>  }
>>
>> +static __always_inline bool tif_need_resched_lazy(void)
>> +{
>> +	return IS_ENABLED(CONFIG_PREEMPT_AUTO) &&
>> +		arch_test_bit(TIF_NEED_RESCHED_LAZY,
>> +			      (unsigned long *)(&current_thread_info()->flags));
>> +}
>> +
>>  #else
>>
>>  static __always_inline bool tif_need_resched(void)
>> @@ -193,6 +210,13 @@ static __always_inline bool tif_need_res
>>  			(unsigned long *)(&current_thread_info()->flags));
>>  }
>>
>> +static __always_inline bool tif_need_resched_lazy(void)
>> +{
>> +	return IS_ENABLED(CONFIG_PREEMPT_AUTO) &&
>> +		test_bit(TIF_NEED_RESCHED_LAZY,
>> +			 (unsigned long *)(&current_thread_info()->flags));
>> +}
>> +
>>  #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
>>
>>  #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
>> --- a/kernel/Kconfig.preempt
>> +++ b/kernel/Kconfig.preempt
>> @@ -11,6 +11,13 @@ config PREEMPT_BUILD
>>  	select PREEMPTION
>>  	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
>>
>> +config PREEMPT_BUILD_AUTO
>> +	bool
>> +	select PREEMPT_BUILD
>> +
>> +config HAVE_PREEMPT_AUTO
>> +	bool
>> +
>>  choice
>>  	prompt "Preemption Model"
>>  	default PREEMPT_NONE
>> @@ -67,9 +74,17 @@ config PREEMPT
>>  	  embedded system with latency requirements in the milliseconds
>>  	  range.
>>
>> +config PREEMPT_AUTO
>> +	bool "Automagic preemption mode with runtime tweaking support"
>> +	depends on HAVE_PREEMPT_AUTO
>> +	select PREEMPT_BUILD_AUTO
>> +	help
>> +	  Add some sensible blurb here
>> +
>>  config PREEMPT_RT
>>  	bool "Fully Preemptible Kernel (Real-Time)"
>>  	depends on EXPERT && ARCH_SUPPORTS_RT
>> +	select PREEMPT_BUILD_AUTO if HAVE_PREEMPT_AUTO
>>  	select PREEMPTION
>>  	help
>>  	  This option turns the kernel into a real-time kernel by replacing
>> @@ -95,7 +110,7 @@ config PREEMPTION
>>
>>  config PREEMPT_DYNAMIC
>>  	bool "Preemption behaviour defined on boot"
>> -	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
>> +	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT && !PREEMPT_AUTO
>>  	select JUMP_LABEL if HAVE_PREEMPT_DYNAMIC_KEY
>>  	select PREEMPT_BUILD
>>  	default y if HAVE_PREEMPT_DYNAMIC_CALL
>> --- a/include/linux/entry-common.h
>> +++ b/include/linux/entry-common.h
>> @@ -60,7 +60,7 @@
>>  #define EXIT_TO_USER_MODE_WORK						\
>>  	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
>>  	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
>> -	 ARCH_EXIT_TO_USER_MODE_WORK)
>> +	 _TIF_NEED_RESCHED_LAZY | ARCH_EXIT_TO_USER_MODE_WORK)
>>
>>  /**
>>   * arch_enter_from_user_mode - Architecture specific sanity check for user mode regs
>> --- a/include/linux/entry-kvm.h
>> +++ b/include/linux/entry-kvm.h
>> @@ -18,7 +18,7 @@
>>
>>  #define XFER_TO_GUEST_MODE_WORK						\
>>  	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
>> -	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
>> +	 _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED_LAZY | ARCH_XFER_TO_GUEST_MODE_WORK)
>>
>>  struct kvm_vcpu;
>>
>> --- a/kernel/entry/common.c
>> +++ b/kernel/entry/common.c
>> @@ -155,7 +155,7 @@ static unsigned long exit_to_user_mode_l
>>
>>  		local_irq_enable_exit_to_user(ti_work);
>>
>> -		if (ti_work & _TIF_NEED_RESCHED)
>> +		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
>>  			schedule();
>>
>>  		if (ti_work & _TIF_UPROBE)
>> @@ -385,7 +385,7 @@ void raw_irqentry_exit_cond_resched(void
>>  		rcu_irq_exit_check_preempt();
>>  		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>>  			WARN_ON_ONCE(!on_thread_stack());
>> -		if (need_resched())
>> +		if (test_tsk_need_resched(current))
>>  			preempt_schedule_irq();
>>  	}
>>  }
>> --- a/kernel/sched/features.h
>> +++ b/kernel/sched/features.h
>> @@ -89,3 +89,5 @@ SCHED_FEAT(UTIL_EST_FASTUP, true)
>>  SCHED_FEAT(LATENCY_WARN, false)
>>
>>  SCHED_FEAT(HZ_BW, true)
>> +
>> +SCHED_FEAT(FORCE_NEED_RESCHED, false)
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -2435,6 +2435,7 @@ extern void init_sched_fair_class(void);
>>  extern void reweight_task(struct task_struct *p, int prio);
>>
>>  extern void resched_curr(struct rq *rq);
>> +extern void resched_curr_lazy(struct rq *rq);
>>  extern void resched_cpu(int cpu);
>>
>>  extern struct rt_bandwidth def_rt_bandwidth;
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -2046,17 +2046,17 @@ static inline void update_tsk_thread_fla
>>  	update_ti_thread_flag(task_thread_info(tsk), flag, value);
>>  }
>>
>> -static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
>> +static inline bool test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
>>  {
>>  	return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
>>  }
>>
>> -static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
>> +static inline bool test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
>>  {
>>  	return test_and_clear_ti_thread_flag(task_thread_info(tsk), flag);
>>  }
>>
>> -static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
>> +static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
>>  {
>>  	return test_ti_thread_flag(task_thread_info(tsk), flag);
>>  }
>> @@ -2069,9 +2069,11 @@ static inline void set_tsk_need_resched(
>>  static inline void clear_tsk_need_resched(struct task_struct *tsk)
>>  {
>>  	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
>> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
>> +		clear_tsk_thread_flag(tsk, TIF_NEED_RESCHED_LAZY);
>>  }
>>
>> -static inline int test_tsk_need_resched(struct task_struct *tsk)
>> +static inline bool test_tsk_need_resched(struct task_struct *tsk)
>>  {
>>  	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
>>  }
>> @@ -2252,7 +2254,7 @@ static inline int rwlock_needbreak(rwloc
>>
>>  static __always_inline bool need_resched(void)
>>  {
>> -	return unlikely(tif_need_resched());
>> +	return unlikely(tif_need_resched_lazy() || tif_need_resched());
>>  }
>>
>>  /*
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -964,8 +964,10 @@ static void clear_buddies(struct cfs_rq
>>   * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
>>   * this is probably good enough.
>>   */
>> -static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>> +static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se, bool tick)
>>  {
>> +	struct rq *rq = rq_of(cfs_rq);
>> +
>>  	if ((s64)(se->vruntime - se->deadline) < 0)
>>  		return;
>>
>> @@ -984,10 +986,19 @@ static void update_deadline(struct cfs_r
>>  	/*
>>  	 * The task has consumed its request, reschedule.
>>  	 */
>> -	if (cfs_rq->nr_running > 1) {
>> -		resched_curr(rq_of(cfs_rq));
>> -		clear_buddies(cfs_rq, se);
>> +	if (cfs_rq->nr_running < 2)
>> +		return;
>> +
>> +	if (!IS_ENABLED(CONFIG_PREEMPT_AUTO) || sched_feat(FORCE_NEED_RESCHED)) {
>> +		resched_curr(rq);
>> +	} else {
>> +		/* Did the task ignore the lazy reschedule request? */
>> +		if (tick && test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED_LAZY))
>> +			resched_curr(rq);
>> +		else
>> +			resched_curr_lazy(rq);
>>  	}
>> +	clear_buddies(cfs_rq, se);
>>  }
>>
>>  #include "pelt.h"
>> @@ -1095,7 +1106,7 @@ static void update_tg_load_avg(struct cf
>>  /*
>>   * Update the current task's runtime statistics.
>>   */
>> -static void update_curr(struct cfs_rq *cfs_rq)
>> +static void __update_curr(struct cfs_rq *cfs_rq, bool tick)
>>  {
>>  	struct sched_entity *curr = cfs_rq->curr;
>>  	u64 now = rq_clock_task(rq_of(cfs_rq));
>> @@ -1122,7 +1133,7 @@ static void update_curr(struct cfs_rq *c
>>  	schedstat_add(cfs_rq->exec_clock, delta_exec);
>>
>>  	curr->vruntime += calc_delta_fair(delta_exec, curr);
>> -	update_deadline(cfs_rq, curr);
>> +	update_deadline(cfs_rq, curr, tick);
>>  	update_min_vruntime(cfs_rq);
>>
>>  	if (entity_is_task(curr)) {
>> @@ -1136,6 +1147,11 @@ static void update_curr(struct cfs_rq *c
>>  	account_cfs_rq_runtime(cfs_rq, delta_exec);
>>  }
>>
>> +static inline void update_curr(struct cfs_rq *cfs_rq)
>> +{
>> +	__update_curr(cfs_rq, false);
>> +}
>> +
>>  static void update_curr_fair(struct rq *rq)
>>  {
>>  	update_curr(cfs_rq_of(&rq->curr->se));
>> @@ -5253,7 +5269,7 @@ entity_tick(struct cfs_rq *cfs_rq, struc
>>  	/*
>>  	 * Update run-time statistics of the 'current'.
>>  	 */
>> -	update_curr(cfs_rq);
>> +	__update_curr(cfs_rq, true);
>>
>>  	/*
>>  	 * Ensure that runnable average is periodically updated.
>> @@ -5267,7 +5283,7 @@ entity_tick(struct cfs_rq *cfs_rq, struc
>>  	 * validating it and just reschedule.
>>  	 */
>>  	if (queued) {
>> -		resched_curr(rq_of(cfs_rq));
>> +		resched_curr_lazy(rq_of(cfs_rq));
>>  		return;
>>  	}
>>  	/*
>> @@ -5413,7 +5429,7 @@ static void __account_cfs_rq_runtime(str
>>  	 * hierarchy can be throttled
>>  	 */
>>  	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->curr))
>> -		resched_curr(rq_of(cfs_rq));
>> +		resched_curr_lazy(rq_of(cfs_rq));
>>  }
>>
>>  static __always_inline
>> @@ -5673,7 +5689,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
>>
>>  	/* Determine whether we need to wake up potentially idle CPU: */
>>  	if (rq->curr == rq->idle && rq->cfs.nr_running)
>> -		resched_curr(rq);
>> +		resched_curr_lazy(rq);
>>  }
>>
>>  #ifdef CONFIG_SMP
>> @@ -6378,7 +6394,7 @@ static void hrtick_start_fair(struct rq
>>
>>  		if (delta < 0) {
>>  			if (task_current(rq, p))
>> -				resched_curr(rq);
>> +				resched_curr_lazy(rq);
>>  			return;
>>  		}
>>  		hrtick_start(rq, delta);
>> @@ -8031,7 +8047,7 @@ static void check_preempt_wakeup(struct
>>  	 * prevents us from potentially nominating it as a false LAST_BUDDY
>>  	 * below.
>>  	 */
>> -	if (test_tsk_need_resched(curr))
>> +	if (need_resched())
>>  		return;
>>
>>  	/* Idle tasks are by definition preempted by non-idle tasks. */
>> @@ -8073,7 +8089,7 @@ static void check_preempt_wakeup(struct
>>  	return;
>>
>>  preempt:
>> -	resched_curr(rq);
>> +	resched_curr_lazy(rq);
>>  }
>>
>>  #ifdef CONFIG_SMP
>> @@ -12224,7 +12240,7 @@ static inline void task_tick_core(struct
>>  	 */
>>  	if (rq->core->core_forceidle_count && rq->cfs.nr_running == 1 &&
>>  	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
>> -		resched_curr(rq);
>> +		resched_curr_lazy(rq);
>>  }
>>
>>  /*
>> @@ -12389,7 +12405,7 @@ prio_changed_fair(struct rq *rq, struct
>>  	 */
>>  	if (task_current(rq, p)) {
>>  		if (p->prio > oldprio)
>> -			resched_curr(rq);
>> +			resched_curr_lazy(rq);
>>  	} else
>>  		check_preempt_curr(rq, p, 0);
>>  }
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -108,7 +108,7 @@ static const struct dmi_system_id proces
>>   */
>>  static void __cpuidle acpi_safe_halt(void)
>>  {
>> -	if (!tif_need_resched()) {
>> +	if (!need_resched()) {
>>  		raw_safe_halt();
>>  		raw_local_irq_disable();
>>  	}
>> --- a/include/linux/sched/idle.h
>> +++ b/include/linux/sched/idle.h
>> @@ -63,7 +63,7 @@ static __always_inline bool __must_check
>>  	 */
>>  	smp_mb__after_atomic();
>>
>> -	return unlikely(tif_need_resched());
>> +	return unlikely(need_resched());
>>  }
>>
>>  static __always_inline bool __must_check current_clr_polling_and_test(void)
>> @@ -76,7 +76,7 @@ static __always_inline bool __must_check
>>  	 */
>>  	smp_mb__after_atomic();
>>
>> -	return unlikely(tif_need_resched());
>> +	return unlikely(need_resched());
>>  }
>>
>>  #else
>> @@ -85,11 +85,11 @@ static inline void __current_clr_polling
>>
>>  static inline bool __must_check current_set_polling_and_test(void)
>>  {
>> -	return unlikely(tif_need_resched());
>> +	return unlikely(need_resched());
>>  }
>>  static inline bool __must_check current_clr_polling_and_test(void)
>>  {
>> -	return unlikely(tif_need_resched());
>> +	return unlikely(need_resched());
>>  }
>>  #endif
>>
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -57,8 +57,7 @@ static noinline int __cpuidle cpu_idle_p
>>  	ct_cpuidle_enter();
>>
>>  	raw_local_irq_enable();
>> -	while (!tif_need_resched() &&
>> -	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
>> +	while (!need_resched() && (cpu_idle_force_poll || tick_check_broadcast_expired()))
>>  		cpu_relax();
>>  	raw_local_irq_disable();
>>
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -2722,6 +2722,8 @@ unsigned int tracing_gen_ctx_irq_test(un
>>
>>  	if (tif_need_resched())
>>  		trace_flags |= TRACE_FLAG_NEED_RESCHED;
>> +	if (tif_need_resched_lazy())
>> +		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
>>  	if (test_preempt_need_resched())
>>  		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
>>  	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -271,6 +271,7 @@ config X86
>>  	select HAVE_STATIC_CALL
>>  	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
>>  	select HAVE_PREEMPT_DYNAMIC_CALL
>> +	select HAVE_PREEMPT_AUTO
>>  	select HAVE_RSEQ
>>  	select HAVE_RUST			if X86_64
>>  	select HAVE_SYSCALL_TRACEPOINTS
>> --- a/arch/x86/include/asm/thread_info.h
>> +++ b/arch/x86/include/asm/thread_info.h
>> @@ -81,8 +81,9 @@ struct thread_info {
>>  #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
>>  #define TIF_SIGPENDING		2	/* signal pending */
>>  #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
>> -#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
>> -#define TIF_SSBD		5	/* Speculative store bypass disable */
>> +#define TIF_ARCH_RESCHED_LAZY	4	/* Lazy rescheduling */
>> +#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
>> +#define TIF_SSBD		6	/* Speculative store bypass disable */
>>  #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
>>  #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
>>  #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
>> @@ -104,6 +105,7 @@ struct thread_info {
>>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>> +#define _TIF_ARCH_RESCHED_LAZY	(1 << TIF_ARCH_RESCHED_LAZY)
>>  #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>>  #define _TIF_SSBD		(1 << TIF_SSBD)
>>  #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
>> --- a/kernel/entry/kvm.c
>> +++ b/kernel/entry/kvm.c
>> @@ -13,7 +13,7 @@ static int xfer_to_guest_mode_work(struc
>>  			return -EINTR;
>>  		}
>>
>> -		if (ti_work & _TIF_NEED_RESCHED)
>> +		if (ti_work & (_TIF_NEED_RESCHED | TIF_NEED_RESCHED_LAZY))
>>  			schedule();
>>
>>  		if (ti_work & _TIF_NOTIFY_RESUME)
>> --- a/include/linux/trace_events.h
>> +++ b/include/linux/trace_events.h
>> @@ -178,8 +178,8 @@ unsigned int tracing_gen_ctx_irq_test(un
>>
>>  enum trace_flag_type {
>>  	TRACE_FLAG_IRQS_OFF		= 0x01,
>> -	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
>> -	TRACE_FLAG_NEED_RESCHED		= 0x04,
>> +	TRACE_FLAG_NEED_RESCHED		= 0x02,
>> +	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x04,
>>  	TRACE_FLAG_HARDIRQ		= 0x08,
>>  	TRACE_FLAG_SOFTIRQ		= 0x10,
>>  	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
>> @@ -205,11 +205,11 @@ static inline unsigned int tracing_gen_c
>>
>>  static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
>>  {
>> -	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
>> +	return tracing_gen_ctx_irq_test(0);
>>  }
>>  static inline unsigned int tracing_gen_ctx(void)
>>  {
>> -	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
>> +	return tracing_gen_ctx_irq_test(0);
>>  }
>>  #endif
>>
>> --- a/kernel/trace/trace_output.c
>> +++ b/kernel/trace/trace_output.c
>> @@ -460,17 +460,29 @@ int trace_print_lat_fmt(struct trace_seq
>>  		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
>>  		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
>>  		bh_off ? 'b' :
>> -		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
>> +		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
>>  		'.';
>>
>> -	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
>> +	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
>>  				TRACE_FLAG_PREEMPT_RESCHED)) {
>> +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
>> +		need_resched = 'B';
>> +		break;
>>  	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
>>  		need_resched = 'N';
>>  		break;
>> +	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
>> +		need_resched = 'L';
>> +		break;
>> +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
>> +		need_resched = 'b';
>> +		break;
>>  	case TRACE_FLAG_NEED_RESCHED:
>>  		need_resched = 'n';
>>  		break;
>> +	case TRACE_FLAG_NEED_RESCHED_LAZY:
>> +		need_resched = 'l';
>> +		break;
>>  	case TRACE_FLAG_PREEMPT_RESCHED:
>>  		need_resched = 'p';
>>  		break;
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -333,6 +333,23 @@ static const struct file_operations sche
>>  	.release	= seq_release,
>>  };
>>
>> +static ssize_t sched_hog_write(struct file *filp, const char __user *ubuf,
>> +			       size_t cnt, loff_t *ppos)
>> +{
>> +	unsigned long end = jiffies + 60 * HZ;
>> +
>> +	for (; time_before(jiffies, end) && !signal_pending(current);)
>> +		cpu_relax();
>> +
>> +	return cnt;
>> +}
>> +
>> +static const struct file_operations sched_hog_fops = {
>> +	.write		= sched_hog_write,
>> +	.open		= simple_open,
>> +	.llseek		= default_llseek,
>> +};
>> +
>>  static struct dentry *debugfs_sched;
>>
>>  static __init int sched_init_debug(void)
>> @@ -374,6 +391,8 @@ static __init int sched_init_debug(void)
>>
>>  	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
>>
>> +	debugfs_create_file("hog", 0200, debugfs_sched, NULL, &sched_hog_fops);
>> +
>>  	return 0;
>>  }
>>  late_initcall(sched_init_debug);
>>


--
ankur
