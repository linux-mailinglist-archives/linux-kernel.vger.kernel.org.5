Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A767E4C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbjKGXKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbjKGXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:09:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD86A1715
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:09:48 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJPE5004600;
        Tue, 7 Nov 2023 23:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=zFNbI+mEoF4OPOprgv3SvDkE7nHhMkWabgKBcZWWtH8=;
 b=HQNIEHyZMjp16WYt97omfLHOkrdTyx4FpHlcukBR6TP4/NFUKKZcJDGTkGs/z93RrtP1
 dvLIV8CFji2RwZCQcHwWLEZJFhjNzI+NFl3tnglnL3ADfu8uT80ivL1yLo4FoPZcIt6+
 qsg4BDDI5YhLloATP+VUgd4fkVJX3v259ZsGCSTbgYo3BgwaXrD9+o4OU6reWByUfCcK
 KXzl0I3QrGFuKTdXQPc2Hh2gUYVfPir8eKKEvtVVW6d+p+ELVxC4rD1icmp0Lft06vxx
 ZTRZdqohi9kzZGz/ESt+eoUceG8Atj+enhbjaJKIAT2xxMYs9/Cm5lbxb6XVDMVSjOHO xQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g636-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2mJL000336;
        Tue, 7 Nov 2023 23:08:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vcb5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LilRy611vnOnbvIBWasTXNaKL8QM5l8DWKhFF4D1n72ZWM7bKQmuJUgX8qVsjMqAdEIZZNWGraUTQ6IQC5t0bXmUaVqA5VYUIGqYJVVRCykr1LrrfEDnWdEmdAvOXX06sdc/g2lH9QVWhF06EPSG+01GB1nKeUBZcZSN4WlYxEfnDwyTqsk9rnog8brkKcUDvRqoZTOvKjkfiaemkwrsBmfkrnxfTU9Eg2d7mq2UShvE3L26HW0KqIjGR8LknOLYxG7WcyNApUjgK6JqVe7m+zLPNcI6tlLZzepC+qeSTfvPME3p8lTAKa2yyxKRolLpxlxXcy/i1VukaRJpITQwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFNbI+mEoF4OPOprgv3SvDkE7nHhMkWabgKBcZWWtH8=;
 b=dtyzp18EtUPnXESgBfhByG9m9QVT9XSx2DTYhIhFn6UK0rjSomcoCFmZHmpKCWK7Knw+YtCN45Vsm/erZZvvvwm0FMwr+s6QJHgTNjBdRXnzvvZgOcOebVO2hJVA2QO2ZP/UJUr91MurMyDM7pCgBkRstRa9pg+52YhZZjZVppBG35U6GxJ14O4zhm154RHakxp6pCiiJeOhpGNVxxEvEjLFC/x9ON3qquGtFp+W8nD/xD+Ii07oa+70d8CjaqIyc19VI1RISbkOu/E+Ugc1EDFy9ZuIjOuLsossRGZxtmxyGYdb52nQ7uk/UeH5UaMmi2S1621tfCp54M95IOYoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFNbI+mEoF4OPOprgv3SvDkE7nHhMkWabgKBcZWWtH8=;
 b=W2RfwwtviNr/AwLCJUk38Pu2L5+dATVD9rSAvL6LGwk404EZqswmrISQ2y97TpL5GoF/51Uy+lVdNfGL41tWi3FofV8sAK/Ca0mSagyXSTEwRll/46Ip5SpaSkQhg8aPMpdbUGcuEWgtcEV63tIUUdExEIO+Rti4NMHaVYsMZmw=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Tue, 7 Nov 2023 23:08:35 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:08:35 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [RFC PATCH 60/86] treewide: torture: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:07:56 -0800
Message-Id: <20231107230822.371443-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|MW4PR10MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8e8402-f83d-4fd0-8e16-08dbdfe677ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHwRE1iIZ5umhXSpn8ZltlxCs5AfHUESgbaC0azNrGGo42A8CVkRQkUaVcpFgdgL14/QpJx95VmAugl2uqnrcSOvTsffDGe1H/fOdaRQtypnmBgxn2zispLcgPy/Fgxu4MDCCA/t8ylId6hQhZbUVAvWA00KdVpLIwvDDAT979x9niV429AgxiN+iWps/0MNUf9kZqqafNHAJGwj+2UrY6gve4nCeqCBjrJlIJDsH3bWU/tVu7z6ccrva8U3PsAIT4tis2RIs+9INbwnywcJvcwe0dhmTCHFVoPW051cVQKRH77ve5001UP4yt1KEP8iN0SFy+yocr02R+rs/WUmMYLizsp03WnjaPQjOrXeBBy10IUq8ux6F3I7PMItUVmW+fZIvssdUylky/+TZFIqye+bCAlHfcJyiarvozdB7XTr8DF7YxsGxlTFgC7kck8qcNUzzdgGj+AAnPzIspLny1Ekk+oyEFGgXnv5Xv8gWH369177730IGPuVUDx8KvINJMUaGsZfkNTNqlHGaSqPx3nZiYASuE4g6s0fNNZLlJwyvqI5DM276LX30447FGXj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(41300700001)(6506007)(2616005)(6486002)(6512007)(7416002)(6666004)(7406005)(8676002)(316002)(4326008)(8936002)(5660300002)(83380400001)(1076003)(26005)(66476007)(54906003)(66946007)(66556008)(6916009)(38100700002)(2906002)(86362001)(103116003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CT1CYeBkVY3cJhc09eId/R9Tbdmie71TWl2RYCQZtK452bqktWI/GeAM8TcS?=
 =?us-ascii?Q?cq1yYHDH+noO4rHeOZh0WaVEnK4QkHnivLOmnLlzZMhAo10ZcnzYFbkDA9zr?=
 =?us-ascii?Q?QQ89xZw70vUy9J3qnAbykd9QraUPSbULql7XO0R1wHVp3bmTnKudkDBSy9tt?=
 =?us-ascii?Q?Xj7vby5lNIvhQet1mJM4GfinjRcyMmUcP5jmgnTrOwuhVRNZBiKDXpqWJI4R?=
 =?us-ascii?Q?ac4k/ZephZbWdsBevVdFdRlsWHviM7sQfBqjwkJHCPVxQb/YgLji2cPEdeY1?=
 =?us-ascii?Q?9b+oc0cjzslVSt9u2zkPHM7Dry3bcoLMxveF/V8fYrlnjpZKtQeTNH+0zpl/?=
 =?us-ascii?Q?/mt+3fl2cZJncAoHvNG+J2Bv0785jKLD5e35Tg/Piqh4bcS021k/E4mnZOCQ?=
 =?us-ascii?Q?qD/6Ea4nOh3QVl0ZaXCOt9CkfK+zunsdcSX2vnXtaNgDBZolrjr8Ziqo2eZp?=
 =?us-ascii?Q?D5+CswpOfnP5RS8lK7v9rcswusyNZevy1gBxHwOmUnWjZdMh/NTEnEVIj31f?=
 =?us-ascii?Q?EiaRGgjldZsDhqXHEBQL9FF9eammUwqKiQ4y7wymRztbUlVSSiY1JBRRMJVO?=
 =?us-ascii?Q?RWOaXv6L3VwjqhxWOdyNd3VNd0lDTf9Iz1y+93wWqlpmJGNoDek5C5EBNh+Y?=
 =?us-ascii?Q?g5REqvUin/IFtE63YwVEfFbKf+a2Ui2ZGsd9+tzvEU1PLYsIDdJ77PXX0TKj?=
 =?us-ascii?Q?WJ3fNtjGif8ujlSgPLsfrcJnCerjNkQscAlVX4644qWWR4QcQ5YPNCPe5o7c?=
 =?us-ascii?Q?iJq6K/MJhbf9P1m0pEPka3vOEKCZ5BQe82vRoYaEaPY1TWC3F8j3icnQNdic?=
 =?us-ascii?Q?pPVOK+yyFeKQSr906DrgUqig4tAZB+IEr8kMOXhN01+sZ+0zjQAPcXMwbhLA?=
 =?us-ascii?Q?sUzb7l7nAi6fbc1SBh5s9saMkvHDRiAcjrCDxYcwmY/wQpB2Y/A2YheSBw5o?=
 =?us-ascii?Q?DIy3Tb5UhzgTxSyMj3qbUJm8xfNyTp7nV6gYxRdkFbeh3y1OzJRmxa8toFwx?=
 =?us-ascii?Q?ryYtrWZ373vDneEPU0773RatdJKPaZdvPfuDgu4e0DNddJnTnSa/6x1j6mYH?=
 =?us-ascii?Q?Ebr/ZG6A5Td/xytEQBP7LZh6vm2DhUMW9vHIkPzYpsanzbgRet2AU9fljKuT?=
 =?us-ascii?Q?Jj3NM7Qicsu814SPBmLNnH8i0JPMWZ5yXZllEHiriZwRYOUXLOEhp2Td4LNk?=
 =?us-ascii?Q?Wo5ZR/8rXOiHGcO59GAR90o6udFOPzocxHnYeaCndal/jNc0QvwKubw1JWqe?=
 =?us-ascii?Q?aWvGA5JhFgWPqDjIaExj1tbQWxlglr3PLnmnjhu8jLmhvREA33f7XGk2BAzb?=
 =?us-ascii?Q?BbmcqL8do9KGBlcNL/88qAQzoYCBqiV/SoMx2jESUzBTnqMx2BNCLvSzCaKH?=
 =?us-ascii?Q?vsAzGLtaEsDp1dpGOcmqF+PjUbyPz5qVeJmFAncYoOgKUI8a7ZAjTvsve8m9?=
 =?us-ascii?Q?ScTDhqOKFsuohsUbd+GKR0fqg/SierqAt9fRvSldkIlWIwR016CzaDHH5o3b?=
 =?us-ascii?Q?ldyM9m0IY29hitfe8kLYQyf9++ky8xkiGWDVcNnJEC2vTHqhF1su8JC5fX6d?=
 =?us-ascii?Q?4vnT+r99zqcDQAOlbIwGksyySFYSG7MksJt308ZaTF2agzU7Xyd3LY3yi4MU?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QzrW9P4tR67br7Dks0wO7MiqLyE2T2SXCYYp5g3nKPuVOB8tjxhtB8DOPYpP?=
 =?us-ascii?Q?TshvYSrUD4W6/YGdrjaBajkB2SsfsAoc8C9xSKV11oqs0AYOLJBtEXwS/OUe?=
 =?us-ascii?Q?xANbTYjaGZ7dA1YB+lUKoZ2kaebDdCPD0TTWhgTT9KmjkTkqOtJy0Q5EIelc?=
 =?us-ascii?Q?bacDVVs0mJVoDCP8SdPVFywn2mXhvSgrxprgiH+8Fy435p2jS5OQK2/Gxb9x?=
 =?us-ascii?Q?Nsti/MUxRSAttY4E48bi6RXEOjgrs2801z9JxgRjPToxPhWKHnBR2a/TzhMQ?=
 =?us-ascii?Q?MOk7EfqLv+1lDwq37fpIo3iwlYA9Sd6qirxC1LIhZAHrEunDG/DvLJczKttl?=
 =?us-ascii?Q?6bCtxRjmir60oqlkMS8NxzGEopx/A75/SICpmlg5dJns341q7g/dNyT36itJ?=
 =?us-ascii?Q?tervBWfwlY4U7sSTRi0Kf1o7C75xIpOIln3r84ekQpdz9/4NNnby2VYIbHNy?=
 =?us-ascii?Q?sjFjzalzyJW4lFXg7x/gG2+GojmBhk7ntQcCJyoFvp7IXv1JWFqXRmd1CAfV?=
 =?us-ascii?Q?DPgPrmYi+3Vsa+mqT83ZD6X+6mLIZV3O4DEfTQYwcawjE9Albbgv2h7IDgWy?=
 =?us-ascii?Q?dWGgvDdPaIQMPLUxFcCh8/tdIGna3ADxeQQm3O6nq3rEJ8wDPkajdxaNJhpy?=
 =?us-ascii?Q?BqrFg84f7VAIXgY6FfiTocfPzjH8UkkOImbZwFGD0G2fDtngfPncVlBP30fp?=
 =?us-ascii?Q?wKLr74gbIM+Z/ArbpveXid9c6QPvzoskaEy0IQmf/3qW81BJ0CwIbc40g1co?=
 =?us-ascii?Q?WVyZ/0JwFlC30wt7EE5VRjkV7h4duIA20aHZHcnuSO3Q4Fzkfvi9TbW+deHk?=
 =?us-ascii?Q?Cf8xjfxXqJczylD0gtn5E4cfRzsgLeL73pDWQakgfFZXooghewnploI9rh0W?=
 =?us-ascii?Q?2sbqaAcmaEp9LAsf5homQOwsoZYqXvmXlSIRb1xgV9pGE3AKVFI72e1Pum/R?=
 =?us-ascii?Q?5c5xRYlHxNlIQg+tph82UhV6rrWuBqjqSj+XJ67wSlZVSM86YJCEHioKXz03?=
 =?us-ascii?Q?iPkWJt9hVDAzy02MygtCH2K60KyLchnkydin5tSb4HkhP2OzAEVOurB9n1eL?=
 =?us-ascii?Q?dsPc8MvpeMz0hZi5EqZlTv3+2ji16WGEZR7gKoET6ub8efohQ60zxy48t1rJ?=
 =?us-ascii?Q?LhAHs0gMLxxITgJmZ3jFtyZRrAbgTARgFEKNg7ezRQjpcOyKnW8SU99EnQau?=
 =?us-ascii?Q?WmKll/StG0gIwijmmXpyC6NQsT0MEp5cOfXYtsYiSO3ZN54MhzmFfKNkQnWa?=
 =?us-ascii?Q?ju6QysyhApkNARSmZHJXQ4T+KO3JEhDNHmm4hbmzmxbLV0VyquGWqtNpsoqf?=
 =?us-ascii?Q?exKA2/lKf1J8XINyIF9I08LMKLaa87GS2b8N9hX56YDX1ppsc3VoCzjKqoUQ?=
 =?us-ascii?Q?vwSUgbKj92HtUOG9CiyrtkXxbWcD920mRZX2FGKG+cAhLlEwbRxjqhwBRVsB?=
 =?us-ascii?Q?RBw8FsiaG1dV6O7HWIHCp5Y9b+E9HPbKmoNU4/koR4bGL1AMc5Yf4FSTKgGM?=
 =?us-ascii?Q?X7FLFePufoS04NhAflBnAHqT2pr098IazA8QmJSbOdknakm55Moo/QYH22pk?=
 =?us-ascii?Q?vLJoD0lQWIGBxKYKpaJWr8r/iXnnj9VzFMRCnG3SCb/cKvinYL+9FUhs84pz?=
 =?us-ascii?Q?8oDdL9JSWmR1lcocv3G6RBc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8e8402-f83d-4fd0-8e16-08dbdfe677ef
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:08:35.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lq5Jzmgk0XYZ2wCIBLfI+D50QeAfYnsr4ZopUlQ0scRFiMgWGNgb6ClgLvk3H8ZQY3P68IYPEVthpRh+vcQ5lMZqKLAqH3H45Wup5QiUoio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=858 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-GUID: 4P5D2YlnRh5Iy2JPqwKPi0ErUiHVOeB1
X-Proofpoint-ORIG-GUID: 4P5D2YlnRh5Iy2JPqwKPi0ErUiHVOeB1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cases changed to cond_resched_stall() to avoid changing
the behaviour of the test too drastically.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/rcuscale.c   | 2 --
 kernel/rcu/rcutorture.c | 8 ++++----
 kernel/scftorture.c     | 1 -
 kernel/torture.c        | 1 -
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index ffdb30495e3c..737620bbec83 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -672,8 +672,6 @@ kfree_scale_thread(void *arg)
 			else
 				kfree_rcu(alloc_ptr, rh);
 		}
-
-		cond_resched();
 	} while (!torture_must_stop() && ++loop < kfree_loops);
 
 	if (atomic_inc_return(&n_kfree_scale_thread_ended) >= kfree_nrealthreads) {
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ade42d6a9d9b..158d58710b51 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -81,7 +81,7 @@ torture_param(int, fqs_stutter, 3, "Wait time between fqs bursts (s)");
 torture_param(int, fwd_progress, 1, "Number of grace-period forward progress tasks (0 to disable)");
 torture_param(int, fwd_progress_div, 4, "Fraction of CPU stall to wait");
 torture_param(int, fwd_progress_holdoff, 60, "Time between forward-progress tests (s)");
-torture_param(bool, fwd_progress_need_resched, 1, "Hide cond_resched() behind need_resched()");
+torture_param(bool, fwd_progress_need_resched, 1, "Hide cond_resched_stall() behind need_resched()");
 torture_param(bool, gp_cond, false, "Use conditional/async GP wait primitives");
 torture_param(bool, gp_cond_exp, false, "Use conditional/async expedited GP wait primitives");
 torture_param(bool, gp_cond_full, false, "Use conditional/async full-state GP wait primitives");
@@ -2611,7 +2611,7 @@ static void rcu_torture_fwd_prog_cond_resched(unsigned long iter)
 		return;
 	}
 	// No userspace emulation: CB invocation throttles call_rcu()
-	cond_resched();
+	cond_resched_stall();
 }
 
 /*
@@ -2691,7 +2691,7 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
 		udelay(10);
 		cur_ops->readunlock(idx);
 		if (!fwd_progress_need_resched || need_resched())
-			cond_resched();
+			cond_resched_stall();
 	}
 	(*tested_tries)++;
 	if (!time_before(jiffies, stopat) &&
@@ -3232,7 +3232,7 @@ static int rcu_torture_read_exit(void *unused)
 				errexit = true;
 				break;
 			}
-			cond_resched();
+			cond_resched_stall();
 			kthread_stop(tsp);
 			n_read_exits++;
 		}
diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 59032aaccd18..24192fe01125 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -487,7 +487,6 @@ static int scftorture_invoker(void *arg)
 			set_cpus_allowed_ptr(current, cpumask_of(cpu));
 			was_offline = false;
 		}
-		cond_resched();
 		stutter_wait("scftorture_invoker");
 	} while (!torture_must_stop());
 
diff --git a/kernel/torture.c b/kernel/torture.c
index b28b05bbef02..0c0224c76275 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -747,7 +747,6 @@ bool stutter_wait(const char *title)
 			while (READ_ONCE(stutter_pause_test)) {
 				if (!(i++ & 0xffff))
 					torture_hrtimeout_us(10, 0, NULL);
-				cond_resched();
 			}
 		} else {
 			torture_hrtimeout_jiffies(round_jiffies_relative(HZ), NULL);
-- 
2.31.1

