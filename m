Return-Path: <linux-kernel+bounces-67671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41050856EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F511F260C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096DF139564;
	Thu, 15 Feb 2024 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DCxaYBut";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lz7k1Tfz"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DD135A66
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030465; cv=fail; b=lIfPRr7ab5tsm/OFuVtiL3CuxW+ecMq9196uMwIw74G5NxKS5VkQfgiXWGIdorj56Zsyb+4lp5JGnrWOAZL5W3aE2OQouWSJjNT2rcrDrkduhDoUgovPtW1uH/MljzDpwPz/ea91pxP/taOvKeWJvR2zQipHpO7iJFxae4jgfNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030465; c=relaxed/simple;
	bh=yxeVyP+yhyJg9YM5+4my55rmqsNDaeNcZ7++56Jl8TU=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=BVivvujnGfL+FTONzAcX7347cKehu6Yr8jb6C6wUwQRmyNWMf0mOAxyK5PHBq774GqLZfzIYcvPQ7d4+WzdfQB0Jgz1UyQEfewupNc8mya9jRz0uUD8i91qOp2Dce7DjEeQpvREDnsNx7NCzmWY5h7lE8lU6v+2JX8wcjrAhHZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DCxaYBut; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lz7k1Tfz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFSwAe006155;
	Thu, 15 Feb 2024 20:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=JGhXnt41k6Us5ZE5FxBZ/1GLMTXIbphNhf+1FrZcivQ=;
 b=DCxaYButrBsXq79I7Ib+W7adqKx1eSH7F8lVVMQNC+auniEMo4UGtg2CxCMsbLHooAIl
 0Ke6/1f8GjCRdhImlS0MvHQymASvTrvEMrucHSTbjJ61aP0+zHICf/sgNUg0aK1WbZdz
 FNxzxpanITmri62X5e+rPj3TTN52A3PdocY7ci8f3vzRhDXkIxaRSde7QU7PFbYsWjlA
 UkM4+1TY3pRSPDdB7F28MwCxMTZ0/B69kIQl7Ye7c+UkSpnRXfBqp91PQpX0wizHraWV
 mqa1cPYfYqp4MwqQ++xGFyCQa9JBmsD/edoSfvSxeusKPPdYuFPGRXtKl823WjSAzX4e /Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w930137tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:52:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FKfOsk014975;
	Thu, 15 Feb 2024 20:52:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykau7xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:52:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vf+gnOkUhASS8YePrsTWT+aaK1r0XGEdwcB8Hrhax++IScQYfDNXZtm+ioawszJLYQIqp2/Hy7hSjKY5yopgiOas79ldLCvl7YhvAg2GVJg/2tX6XoNa2+eytbEMLbhbvLmWrG6xc2fGo39AT/H+GvNxLuH/+SZTBY3JslGW6iage0Y+kvRmljQysyYwRzXU/8XdJlJQw9acFM7rv8lOnW2cO6f8UubVr0ROkWF3xi6ltnu9XZ4ul5t9ryjtHwK73FkTDyCS9x7kAkLr/vDTml/VBM9KmMRmFuR/Kezz57Z4lbgeCk7INAn6X6HJAclkB+UBbGq+AKFuTH8fjT2NGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGhXnt41k6Us5ZE5FxBZ/1GLMTXIbphNhf+1FrZcivQ=;
 b=LMprQ15kkId1fDahT/mzokpGELqXFw2TwiS9ZiTypa8YrYQgXIOVw6IyVl0hfFFklLrZ0NbuCtWKz+kcND5jQGhw02oxmGOfgZmF0XGvW3TDUeKoWbQ68cWO4SQlM1pxgt2BrVoDshiflri6oXa50ZY+4AnGzaPNB16mZ465KyOa/lk7AD7rrL1E1WSxO84HNTvzlE6M4zpbIkZ/bQJsg8N0ypo751T+s9EF3l/NqqLN1+kjsaYZ1XJXSiodNuYe9BdzKIlYRJ/DeOku5N7IHF8HdgemrwLqLD4bRsL9B0felmIfTSifhyuSH2tZ2gSR2BQXOwC+k21WsbysqbMWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGhXnt41k6Us5ZE5FxBZ/1GLMTXIbphNhf+1FrZcivQ=;
 b=lz7k1Tfzx0G0O9Qt7UoJJzstDnXLDMgN/JPoC+I3Ay1lY4BEz7kZXIIlaqDRlgpqiyRcNKmTDmOww2hykevK6zvq9izdjrNVATQjDglhdL5j8mE4dd0NiFZkJQT+RT6vYxFM/ZZbBKF8s7I3mdXg8YmEdBT32ZXWnKKlvY0wC2Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7330.namprd10.prod.outlook.com (2603:10b6:610:12f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 20:52:55 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 20:52:55 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
Date: Thu, 15 Feb 2024 12:53:13 -0800
Message-ID: <878r3lmoue.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:208:2be::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 9550f981-dae7-45c7-5436-08dc2e6815a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	m1gpEWgWCpQ+/m6YkVKqf3xrT7KX7zoCHL2qmNK0jAN2LMGxCD3nIO4dAT2K0ASQv4dOa/ROBOojxG04A/GuXOiuAVFSh8nRnK/EBVWRhAjzorEPyyZh8qnQKYntw1gbPqDWTNZjnVBDApY1XfxnPFJvKcTgsSNTHY12HQ9I0Yx/uVLNGHm65ZIcQd28dHdT/WboHdmYYgVeSewFkzz0ZISvJtyhN4ebN+7cHyCInNtC35fu626inbCjKcki2jPkV7pXluhZ5G72KDui55U/aAfEem/wCNSppiKPuOf8zSr+rrdPBD+FKaUbxz7APAvajfmUPdetDZ+dKdQLTplBIhnl5ZBflFJ9f+QLrdJdCKS0iw0a6SfMsRGp6U5UH+EWz7BPB7FQrlj1PSwofokpDJ89aJxYoPVc8AICmbiMVkNOdKL+smMDwnGdaC4FiU59ICeYx7Iw8AavlgAA9KYkTj/WSr6rUQJ+xeXKdRQ8S8baUjhJ9y4qpacx2Cq4/ofCVjAIOCcdrfPdF6XdwSqrUf/tbUQ72kRfUPPxLLlUv0hZGtto4hT7d1L/UM6bsonX
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(6666004)(6512007)(6486002)(41300700001)(478600001)(2906002)(7406005)(4326008)(8936002)(8676002)(5660300002)(7416002)(6506007)(6916009)(66946007)(66556008)(316002)(66476007)(107886003)(2616005)(83380400001)(26005)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?w/2HO0xGooI8MCDGVmKrQPfPDCUFup3pRDM7ViFUeD1aEgOI50ucSu2yLNdr?=
 =?us-ascii?Q?KN4gEZdtauwPhkawUGEpZRIiRNTTXjqSII7Kd4Kl8qiF7jZBN4UMG8PIFshz?=
 =?us-ascii?Q?E5OgHTT1pbK4IL33NUOMiEk5vPPaUzODy0+zGDSypPqZVRP9WbL7AEukMftC?=
 =?us-ascii?Q?wT0jIYsiFrMasCLcWNF0QR8MemTIzmiqElRgBVAkl0wjaflCYSu0R5OY4NR+?=
 =?us-ascii?Q?md9U7LtBSCbMngjabngPHr/JyzERH/Edt8MjY3/TnLblvokiPaL/7LPCEZ1D?=
 =?us-ascii?Q?qTqBCYwLl6mxx072ItMmlWLT+T4PsTKDwnWlLRJnisuE1pPNehdpEifhF8HL?=
 =?us-ascii?Q?h5GEozbPGNCZrA+v8kEDPnEAZ/Bvhf9BVpKdi31VbThjcKkRr2y/JZSwmIRP?=
 =?us-ascii?Q?rsDXkv4oNW7oXr39pFhBjwet+nsRbSykX0QaEv/lcBqk0C0xMaKuo5Ijg6sH?=
 =?us-ascii?Q?QcLYEi3DGhx3z8VWDDT+eviHds4VSY7BbH9COXD3CR2VtpE8M+ayTGlXtzMO?=
 =?us-ascii?Q?fmHb7Cjaay6vfVTwn4gaz3bNNchBndFkvEs7vqzGfOFGKnU0kYjtozezpzC2?=
 =?us-ascii?Q?v+ac6v4WiTJMF7b9FE1WVx86fb0ynsCBD5h6rt8eQUMpj0tRWotvwFtYHdo0?=
 =?us-ascii?Q?Qg+EUymStCEc8CVisGVF36JvpcQZ1oiZExqFpq0gU/z41tyV5Vg3gUslzM20?=
 =?us-ascii?Q?OGUCnzkbA1z4IN8BnD/rthVPavJxG3ygi9TrjAhfoLAqXI3B3qWWgdNfd4H7?=
 =?us-ascii?Q?8BmwnyifceWDP16j4TTQ3UZVXgcsMxX3aRt4nJYzf9MiMhTKXSPvpEdcv6tE?=
 =?us-ascii?Q?3ln/sqod38hNbR37FwArbH3vtxuIlIyrzupMDO6vVNizh4eb1D1sOc0zOlTo?=
 =?us-ascii?Q?heAI4K0fWqJVV5PeeDcXlJifrBqeG18+4iArBts7nrrMZB3CSPuPoU6cilCF?=
 =?us-ascii?Q?gGTkLO5t9UPtkZUH0qO8rKDuCTZBWj4Ahzc9jloyhO8pIElIHtmXovTF0qov?=
 =?us-ascii?Q?NivxvaqFXklLu8ncUfVxjv+NFaLbXYtJQFOtWkLOl1VHcNCi9e0MyCyje4oe?=
 =?us-ascii?Q?IkPEFMdmxQs0lSmv/TgMG7nozGU3dkvEohSfHrymCnOZJL2LgHheNVLj7B0i?=
 =?us-ascii?Q?wIo61PuKwjg6J7DSgtTKEasOHLtLxS2FHyrAFIVuEsmv6TxCI7ieG+K+IrNw?=
 =?us-ascii?Q?rttmB6JqTOCUk2usO0W+bsVaqZ4YleqkXDA+cSaU6RcQK5spPVmgH3sI3/7J?=
 =?us-ascii?Q?+nf+KNPhYLhWDmxXd/FtKjdTRzo314H1xWfFLGCaXmaLqWtLnUMjNUp+L81d?=
 =?us-ascii?Q?Iqfyb4z+FXVPHd2rZJuHQN2UvKt9c2fB/wtOfTE2YA7lruMJLELbxqSBQj3C?=
 =?us-ascii?Q?0V5w72ugY1MQwXtJS2fn/p0Rj/1a4c5VU24mW0dp5aWeb6dFqsZOvwhi+vkb?=
 =?us-ascii?Q?5o6Qw/H04CyayGHU8F7eWaG7Tjzr68MVjO3Fd6ZWHW06tACiW6XZvq7p7cm7?=
 =?us-ascii?Q?i0kWQAbAERmAQCWPrSeU7aoYZ7aHesc7jy+B//TAkL7QV/aY5Qw75GtwgAj3?=
 =?us-ascii?Q?UwTbDei9cE91P0krXvDLgRWyMDtmR2R+cRSNrVUCR4/gUGcoJ/mI8FcAcnNx?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sMPhDGAbpxK9oD42wrKnFTijKa7duKMN4L6Twu4QDTXORI1lC1kp3+fZY5mVlMoBgygAfYYhgoIJev8QWrTzl6EsKKPoLvn9siQ8hoQ/J5Z8RP0jFF8mSI8oSc3RV+WbVyfZbOirRw8Mi552nXwvx0FDf6cDMB6EnxaIX21ZQCWPsFC+4BQY22FzIw1Cv83J+6SjI0CYUJEynKgBjQ43Ip8v6qBTlEmV09dASI0ey8wRH37lmgQR+dvBS1P/OYkZM6qf1JrH1C188xmOXYM1IBDkmHgMyuXQxLpHVzlqyR22hm9+gnor7mGbyOuXUVNnSPRm8bNrALt/lGS2GvYV6rMy3O9Uk1Ue8mji40BJGCIy52jkGxH6dKacywqy0VTZUPIxe3sre878u+pa+u16m1VoO0Va9azVEu57fymkodPJe+EMv39ATlvYwwhw/nZFG0DAc6L6aXfnHI7LC79FHelOeVqHPj+boBpq4DQv//3Nj7mX/9MqZFYxxs1x+BLqTcvjD6wBnHy19047XOO0F9q1OnBfC7nlSA4K54wh0/ngzwNeOqUBGCEskIPAZSpsZYQ0daIgTvpA31i1oNIzLmF8NLgEK52pVbD9YGi/RBE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9550f981-dae7-45c7-5436-08dc2e6815a0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:52:55.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+u/U+LEh+ihxgMmOPNnlnSIuGKOYbDiRZSyyUK/Jb2U0sFoc9XQdPpLYO2bOQGRj/oRvLME0kzxgTzUVWqo0CxHp2ER4fxiU0jI9+LB/JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_19,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=786 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150167
X-Proofpoint-GUID: fPDpOkHbTfyGxoQ05rQOhnC2Ox6T2n4x
X-Proofpoint-ORIG-GUID: fPDpOkHbTfyGxoQ05rQOhnC2Ox6T2n4x


Paul E. McKenney <paulmck@kernel.org> writes:

> On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
>> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
>> >
>> > Paul E. McKenney <paulmck@kernel.org> writes:
>> >
>> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
>> > >> Hi,
>> > >>
>> > >> This series adds a new scheduling model PREEMPT_AUTO, which like
>> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
>> > >> on explicit preemption points for the voluntary models.
>> > >>
>> > >> The series is based on Thomas' original proposal which he outlined
>> > >> in [1], [2] and in his PoC [3].
>> > >>
>> > >> An earlier RFC version is at [4].
>> > >
>> > > This uncovered a couple of latent bugs in RCU due to its having been
>> > > a good long time since anyone built a !SMP preemptible kernel with
>> > > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
>> > > likely for the merge window after next, but let me know if you need
>> > > them sooner.
>> >
>> > Thanks. As you can probably tell, I skipped out on !SMP in my testing.
>> > But, the attached diff should tide me over until the fixes are in.
>>
>> That was indeed my guess.  ;-)
>>
>> > > I am also seeing OOM conditions during rcutorture testing of callback
>> > > flooding, but I am still looking into this.
>> >
>> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?
>>
>> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
>> two of them thus far.  I am running a longer test to see if this might
>> be just luck.  If not, I look to see what rcutorture scenarios TREE10
>> and TRACE01 have in common.
>
> And still TRACE01 and TREE10 are hitting OOMs, still not seeing what
> sets them apart.  I also hit a grace-period hang in TREE04, which does
> CONFIG_PREEMPT_VOLUNTARY=y along with CONFIG_PREEMPT_AUTO=y.  Something
> to dig into more.
>
> I am also getting these from builds that enable KASAN:
>
> vmlinux.o: warning: objtool: mwait_idle+0x13: call to tif_resched.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x36: call to tif_resched.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x18: call to tif_resched.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: acpi_safe_halt+0x0: call to tif_resched.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: poll_idle+0x33: call to tif_resched.constprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: default_enter_idle+0x18: call to tif_resched.constprop.0() leaves .noinstr.text section

Thanks Paul. Yeah, with KASAN, tif_resched() transforms into this out of
line function:

ffffffff810fec20 <tif_resched.constprop.0>:
ffffffff810fec20:       e8 5b c6 20 00          call   ffffffff8130b280 <__sanitizer_cov_trace_pc>
ffffffff810fec25:       b8 03 00 00 00          mov    $0x3,%eax
ffffffff810fec2a:       e9 71 56 61 01          jmp    ffffffff827142a0 <__x86_return_thunk>
ffffffff810fec2f:       90                      nop

> Does tif_resched() need to be marked noinstr or some such?

Builds fine with Thomas' suggested fix.

--------
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 8752dbc2dac7..0810ddeb365d 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -81,12 +81,12 @@ typedef enum {
  * reduce to the same value (TIF_NEED_RESCHED) leaving any scheduling behaviour
  * unchanged.
  */
-static inline int tif_resched(resched_t rs)
+static __always_inline inline int tif_resched(resched_t rs)
 {
        return TIF_NEED_RESCHED + rs * TIF_NEED_RESCHED_LAZY_OFFSET;
 }

-static inline int _tif_resched(resched_t rs)
+static __always_inline inline int _tif_resched(resched_t rs)
 {
        return 1 << tif_resched(rs);
 }

