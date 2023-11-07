Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED237E4C93
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344412AbjKGXM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjKGXMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:12:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A031994
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:51 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJl4Q004882;
        Tue, 7 Nov 2023 23:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=T7AofHyoW9OieGwkjaBnQeFwRFnyjYF+C4gjUWOGxKI=;
 b=WLPw6oTov2cZzVooRPEFkqXV5w5nH7A8SNuaw8GyCdihTZZaI//byVDqaNrdV9Fv5gU1
 0lPmk0BhX8qGNvECaG70jQqMby+WxqvDcC6LNuRLpapmg2gcmxFd1YVVH26AmgdhNc49
 mCI8ptMk7AGNc7Ct6DRXs/0+9no9RYiUP1RJw0XmNUAWXvwOwpwgenZvb6NKbg4CFROm
 UElWMMNKQWRhw8MAQk1kxK1SQEgeMn/kzGItyxOg+EABr9KczCrkl8hqL7METrnfmaeu
 6hbS75Aq+HXy118AfU3sahID6+VNyiYdToilTBmt2LHvWAWqUPgAFfZNL9ajiOwmk8el cA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22g6c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N3k1D000664;
        Tue, 7 Nov 2023 23:09:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wve2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUL1OXJDUOHV0UDXGC2XiHHJho2Yjm5QLOh+VZZFraool2BKYJVUZXYVQ+qWD2dU/UbobLFzPoP3pKcJF+QyCqVEZ3Fu/Q/dzClHX5UdpHBzcJX6PyIRQOPrVPpntLEMtYMo74VxCev+WGs8Os/5Em5VtUPkZQwkuwNQITYx6C3Yd/Ir7TDqEXhWXR7oyvANilbSCNCPC0sLJhz3qt+qZEG/jHvZeh6HZTQsGJ8W70+UKgaBFkUtcUyEKcuLGvRgMx9QpiGChsF2z8YkrI3+5P33NHqKbdObQKOC3wMd8JzQOTpEIQigEqt+9K7LKFqM0TrQ3duWs9+c4qL0gfIM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7AofHyoW9OieGwkjaBnQeFwRFnyjYF+C4gjUWOGxKI=;
 b=O9T0HKuedHr4zS8lRrDg39T3Jm8w++rhqSkXr8IC3qJeaF9jyomk9raiiEF2H+zdk+X4sL/TmtsmxJYv0X1dQbnLweaz4KCb738Dvl2432KW0iM5W4BHIOak76XBGU25jfBQUTz22AFiJpKEv8wWGFNYDABQs4L6ECoEVxTTblsUchNyH71LpZ7/bNuQyS9nhZd8qk2jQHqzKol37/eZa9xGVgL/n5kjgLrsX18+0S3dqf7DtvTVLGEJC5LQH68hwJEmAbmNW70w3r7W2F9hqgpmK2roxtcgJeXixvz+EdMYkoj0Rx026Jp3BsP87cQiYiKZM+wjLHUIpfbazcGGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7AofHyoW9OieGwkjaBnQeFwRFnyjYF+C4gjUWOGxKI=;
 b=rioEJkhr4Xn9Zn6tyhNVL7q0HU/mVxmreytdzIdIDuTXNwHItsndBs6eee6kZaNPOSBj7rNN/q09N4CBfWh28gKiRXKdJSQFgsaQdE1Ha1BwniZad50F3ZDJSwPCiwAWBrDiU6Pb+8WlGtNH5yrNiyTOmYAT/xE3Ab8o7Tueg4U=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:47 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:47 +0000
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
        Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [RFC PATCH 81/86] treewide: md: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:17 -0800
Message-Id: <20231107230822.371443-25-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:303:dc::25) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b566b49-4f0f-46e4-0b76-08dbdfe6a305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sCaoZroLzPRjkR1IwkyKsJzphCb8TsDSx0NCmD8DER1G80QTbamdYBOxgDMOPhZUrmRcnRQpSTpl0PRaOqqHvcO+q1eiJGalxO8R4qG6m+mDJpQBnwLZHwhdkW9rno8gDO/Ayk1xQ5ocqpB3awMIkWIP2eR6UStN/VNbklwGZ1qNM9+O9QLIC0wBQJpiwg3rU+2Ehi1MjRY9GQXrYKWErF/D9SWqzrQqo7gYZJoz+2gdBJIR6HQ3iQFHvqsFIDkUovTgiPmgevvIprHiahJ68om/WEkBJU+8Qh3DVf7XW2JNHN6FsuDIz/TFR7LiB1eaHEVMBn3tWIPAHbAaw1fHnW/w7Xng3ng0sTQBYtKypDHxpfCafPoj9oimQqpHdxV/6E7DKK1Q47cVc/i74My0ZLddsNonGMCiIA9iNsbJqkDj8GuYka8D3ZkHh9GuQVGf6UL8o5HcQGtcQTbWep6Vx3ycvEOwuKtH1uj97Ks91IjMaSiE2Plp0fONOWWtnLcR/LlrQ+uv2G7fMlamzKKTis158jvpeARDh4L0mqt3ojKpXwashHBYY1PzkwEBB1V8Engi3jmepPKOhWlY+uY69vMN+vpsQ1GVT6BezjMhvZ2dUTosmk5TFZIJITv5GAO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(30864003)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rbxvBp/ngSI1LK3DHJGvmW5T2gNsOSjJXWA8CtaYxPm0t10xJ63XwR3X9nxo?=
 =?us-ascii?Q?0H+aanUQuD8r/xHBaVeHG1giFj4qHFXe4mI7x946UtMN4oCH0gDenixQpVk2?=
 =?us-ascii?Q?TTtFh+YS7DN2uEY1Aa1nEVEvd54Z3otwobOULDINldiK0X66XU98OtBXgPKE?=
 =?us-ascii?Q?kTYiBDqXXL34P2y3G/rf2Z/Izmy5sqnlBaM6iM6X1G6IZ0y1oesLLnCeHwFN?=
 =?us-ascii?Q?zW+xta7u/0ruAKm8APtHZvvAMLex3HQCCwgCCTDkTuGzk5jF6zXeouCBmCLr?=
 =?us-ascii?Q?AXPaMdqw4oXDqd2jhgBpq96h1nQGU/gf8WDCAam/dHkMMEyJ2AQGYbPgt3RM?=
 =?us-ascii?Q?OOAg86BF3A9npC9lZ9BaKKrGTBEPJn/Gd3H7UH76h1jGo02FvxxHlm15HIld?=
 =?us-ascii?Q?vRnrkfTwQG0NOq9DnoqcdF5iOBbGJKj56d9kQQpRI5CT3lvCoD+t2xm3JfNa?=
 =?us-ascii?Q?2uDqYXxeeh7F0LoOS1LTLn8ObFtwEPyytzT/yVua0RWbyPQzxGlt18PVQ3U0?=
 =?us-ascii?Q?Y1s6tvuh6hxmueNCCTlMeIHikYccqFfKDfb0g03DwN0EsJryEUf4rpPH35im?=
 =?us-ascii?Q?Wc1ba7cP6UIUQniwFLbxNmG42tVcE7hsd/3teJaj4Zwlv/kvc74ff5msBGAO?=
 =?us-ascii?Q?i7T1NzfqNo+v5isiyXktXg8VZ83aDFzA4RFa2t0slMony6Q8SHTfBaRcz3zr?=
 =?us-ascii?Q?7zgc/OSH/Aa3LjPO/IllZD9AZ3Yg0Ruk3o0TbMNnBhQSR1Amd4J+CH5y13Be?=
 =?us-ascii?Q?l24k+8GbSePH0lv7FId1DbGqIZmMvWzWuUZKAQ/KwLslW8pICWCYwoCOT7Iv?=
 =?us-ascii?Q?11vifQdFIvYLP/leOSNYbmvLjhrKJLIepMOSW/AigcAAy8w2S0uobxlhDiaf?=
 =?us-ascii?Q?W548gjk+0cJGb1U9KVIFdRylP6d49lDwYIdW1N7pnRiNe0z5Wdsgst8+i29d?=
 =?us-ascii?Q?jvgK6Da//bJN7M0Pt5tdJ1ZFq0PWqYKxpGoV3rKELrQ7NWJDwgZp+SqkSzE7?=
 =?us-ascii?Q?LZcaumqvcCsxUbjFUHdNtbnZKf0eU7J+I4nzLR/jzik4XQtl8fkTrCXBDRjt?=
 =?us-ascii?Q?ZtFXCxiw1MyOLACYIpt2AivCgIUTJOUBTRPM3vMkVy9VQv1oNUvRz5UknDGY?=
 =?us-ascii?Q?oXFOUHjKt9DYOLIFJAaNlmYZDl2pXIHwDzUSkhoMBAU7rYEqKTzdlbld3sak?=
 =?us-ascii?Q?ZMYDXDqBBUzLDZ0jnqlq3iB0dG96asj+bZ0ZOuYeYeBeCA2RyOOuN+sZM1bt?=
 =?us-ascii?Q?dGc0GA882gqDV5HHjG5kuhgclB1s89Pg9tYugUml2eW2zLJilHsT5aiwInzI?=
 =?us-ascii?Q?ZEa2FZsSY5oK3e/dya4nzms8oKcCFOkWWLoCvZketndyHro6U7AWqCpDaXaw?=
 =?us-ascii?Q?sM4q0C0dnwSWxb7AWv8cmMWfviKY+/9F145bdq/50TXzyLut8p+EU9Kf+6zJ?=
 =?us-ascii?Q?qkhaqlh06KIZTiPZrjJr1fgSJh1+O5nQQmp3a/d8Y2e0x6Rjm+USahgumyDX?=
 =?us-ascii?Q?sSkdJ2gC6KlCXNAdY3IiZ2PRLAaA+KjnsRongO+ee12isYo7cA0BIWHaS61X?=
 =?us-ascii?Q?cbRy5gUp4H492Z2KCphkTf3c3D1AKtmlWxam9PI4QmZv4QCwxcKSLUg1jYnu?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iuTAoR4hIIKeb2bjZMPtmCU0l/UPWpWeGnYAkxcN5rzXcdF6VrngPmulD57A?=
 =?us-ascii?Q?lS1VtlF2S+L5XAdfTYQOqKZBK2jELdQBM/vTgiJRNgUvX2is9VeNSxrWbjmF?=
 =?us-ascii?Q?odC/4zRYY7/iND3hz8vSgsB/ozssV7i7QZpLrS3BlZDcEZN10rm+fO/WpAvk?=
 =?us-ascii?Q?MqE1H6S3XWspnh4nklXtZfOz4Q3f3IERaLwo2IVxvPdr6zgq5hrNHjqLawSz?=
 =?us-ascii?Q?j8L/oSpjjMt7KYiQPB74kBvj1xkheHAr+Y1duXOT8+8M2UC6M1tdqxxJB+fV?=
 =?us-ascii?Q?KNhb6wnvyqSRyCGpha79S90eOWhPpF21ASoHmCpDnp/qG4qO+wIpUleiISc5?=
 =?us-ascii?Q?eq8rSmnEt9Ve6cr6lfOwa5HwC8Xr1XIGNYOAQwW9dQLTglYMRSedVuxQeuih?=
 =?us-ascii?Q?N5M+xYt0AXDC7R7C93Ya1aHg00cZ15t5e2WAqtrZ9bSX0Q0mL+Wil/BCqhtb?=
 =?us-ascii?Q?oak7X05uiKGMVj4EuDe/0TU7JqSzi+q/nbXBA/6nKVLXQjCMvJJ5GR2IwGB9?=
 =?us-ascii?Q?Pg4jGVNImFlct846nj3TJsM+6pLhVAOu9uqlLQzm18f/iWfBnYm/6nEZ710h?=
 =?us-ascii?Q?GqfizjoZA3GZFuaCknBQ6W0/5rVLtKlXOT1JQoDVoOqe5ZwDodLqt0hJkRh7?=
 =?us-ascii?Q?8eGvNS9CmgBxX4FI0smKJcNKd7QzXbEpdlSk3py7YWKu7lTJbSEdqnimglk/?=
 =?us-ascii?Q?zmZglAakKUGsqykKSteOzLPCRBQi5/d4o3kpROQNxWu1L+K4eSyf5OK64U8w?=
 =?us-ascii?Q?2ODhtAiGY803Slob9zry23A07So9jQeRpbp0G5gr/prbAD3x7Fw8M3KopAR+?=
 =?us-ascii?Q?uyXeZyytIsCTsosU57zi+eKIP7FT+x8tq80QNmKBFAB+UlF7hzXfrG+r8RJH?=
 =?us-ascii?Q?yLcd0IEzFzfwp9QcMYW8kXOYrfsKbimPz8ad2REXzLrRvSkoqcaZZP0xq18k?=
 =?us-ascii?Q?xAntWCgtYqdYUUTOj3F/FNkTqhCUkqAUWouokgwRQceeMzR5rNLe8qdeIugE?=
 =?us-ascii?Q?V5Eft3avcDW+4+bmB8sjWuesPk6SF95f5eZ3Qym1pri8L3SaoTNcvenXIgLd?=
 =?us-ascii?Q?yVOhLnjvufZmNsrNKHzLQaswlBJ/N1yvkuQXt0puAsFqx2MFMUjukt3VJzQJ?=
 =?us-ascii?Q?pkP4s/eAu3E462HX6UQwd7prU6ucEQqgpLs8nsZHgQAF44kqI15NHIVO34rs?=
 =?us-ascii?Q?oIomjLEz6cDVQ+kwG5xdAYaOvB72WQUV/dGl6YOokOsMBCY0Nxd9l7gmVGzI?=
 =?us-ascii?Q?G37lQqYTmiWUb88YyR34qpZ10j5IPfAHo0o7h5vMdDlq9buemfO9gsfB8WWj?=
 =?us-ascii?Q?+YEGFvEfzhtcUQlyfI0PRkw4IoAANVZM0lido/CeiabCQG+wXAcKh8D05hdP?=
 =?us-ascii?Q?jIpenUn+DmO6YXDBcADBIuUQEHctlOkUKjtbyE2SF0n2C6jDyfaD4PzBd/bw?=
 =?us-ascii?Q?CVS3ExbU/uARVIliJQlAmAelivzBVAYih+uCzZbGXo5AbDt8OjngutkjVLmr?=
 =?us-ascii?Q?T5wMJgDJlkEEPXVVz2Td2sKePdOMUtXtAaZEyzAUQUJsqI4oJvHFl5Rj8w?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b566b49-4f0f-46e4-0b76-08dbdfe6a305
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:47.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7f/4LiKkP6+6Xx6N7vWrPSr6lNUPL6omYQG+0KBDAtTHx9WGXNuUnHPPcpCUrylj/ArddG9JgCIubvQiTnzDor5UoPZD8UymIBze/t2au4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: YEtXCCsHJMIbhjkyBfA4u7vrCk7b880N
X-Proofpoint-GUID: YEtXCCsHJMIbhjkyBfA4u7vrCk7b880N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well be --
for most workloads the scheduler does not have an interminable supply
of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

Most of the uses here are in set-1. Remove them.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Coly Li <colyli@suse.de> 
Cc: Kent Overstreet <kent.overstreet@gmail.com> 
Cc: Alasdair Kergon <agk@redhat.com> 
Cc: Mike Snitzer <snitzer@kernel.org> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/md/bcache/btree.c     |  5 -----
 drivers/md/bcache/journal.c   |  2 --
 drivers/md/bcache/sysfs.c     |  1 -
 drivers/md/bcache/writeback.c |  2 --
 drivers/md/dm-bufio.c         | 14 --------------
 drivers/md/dm-cache-target.c  |  4 ----
 drivers/md/dm-crypt.c         |  3 ---
 drivers/md/dm-integrity.c     |  3 ---
 drivers/md/dm-kcopyd.c        |  2 --
 drivers/md/dm-snap.c          |  1 -
 drivers/md/dm-stats.c         |  8 --------
 drivers/md/dm-thin.c          |  2 --
 drivers/md/dm-writecache.c    | 11 -----------
 drivers/md/dm.c               |  4 ----
 drivers/md/md.c               |  1 -
 drivers/md/raid1.c            |  2 --
 drivers/md/raid10.c           |  3 ---
 drivers/md/raid5.c            |  2 --
 18 files changed, 70 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index fd121a61f17c..b9389d3c39d7 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1826,7 +1826,6 @@ static void bch_btree_gc(struct cache_set *c)
 	do {
 		ret = bcache_btree_root(gc_root, c, &op, &writes, &stats);
 		closure_sync(&writes);
-		cond_resched();
 
 		if (ret == -EAGAIN)
 			schedule_timeout_interruptible(msecs_to_jiffies
@@ -1981,7 +1980,6 @@ static int bch_btree_check_thread(void *arg)
 				goto out;
 			}
 			skip_nr--;
-			cond_resched();
 		}
 
 		if (p) {
@@ -2005,7 +2003,6 @@ static int bch_btree_check_thread(void *arg)
 		}
 		p = NULL;
 		prev_idx = cur_idx;
-		cond_resched();
 	}
 
 out:
@@ -2670,8 +2667,6 @@ void bch_refill_keybuf(struct cache_set *c, struct keybuf *buf,
 	struct bkey start = buf->last_scanned;
 	struct refill refill;
 
-	cond_resched();
-
 	bch_btree_op_init(&refill.op, -1);
 	refill.nr_found	= 0;
 	refill.buf	= buf;
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index c182c21de2e8..5e06a665d082 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -384,8 +384,6 @@ int bch_journal_replay(struct cache_set *s, struct list_head *list)
 
 			BUG_ON(!bch_keylist_empty(&keylist));
 			keys++;
-
-			cond_resched();
 		}
 
 		if (i->pin)
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 0e2c1880f60b..d7e248b54abd 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -1030,7 +1030,6 @@ KTYPE(bch_cache_set_internal);
 
 static int __bch_cache_cmp(const void *l, const void *r)
 {
-	cond_resched();
 	return *((uint16_t *)r) - *((uint16_t *)l);
 }
 
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 24c049067f61..7da09bba3067 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -863,8 +863,6 @@ static int sectors_dirty_init_fn(struct btree_op *_op, struct btree *b,
 					     KEY_START(k), KEY_SIZE(k));
 
 	op->count++;
-	if (!(op->count % INIT_KEYS_EACH_TIME))
-		cond_resched();
 
 	return MAP_CONTINUE;
 }
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index bc309e41d074..0b8f3341fa79 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -294,8 +294,6 @@ static struct lru_entry *lru_evict(struct lru *lru, le_predicate pred, void *con
 		}
 
 		h = h->next;
-
-		cond_resched();
 	}
 
 	return NULL;
@@ -762,7 +760,6 @@ static void __cache_iterate(struct dm_buffer_cache *bc, int list_mode,
 		case IT_COMPLETE:
 			return;
 		}
-		cond_resched();
 
 		le = to_le(le->list.next);
 	} while (le != first);
@@ -890,8 +887,6 @@ static void __remove_range(struct dm_buffer_cache *bc,
 	struct dm_buffer *b;
 
 	while (true) {
-		cond_resched();
-
 		b = __find_next(root, begin);
 		if (!b || (b->block >= end))
 			break;
@@ -1435,7 +1430,6 @@ static void __flush_write_list(struct list_head *write_list)
 			list_entry(write_list->next, struct dm_buffer, write_list);
 		list_del(&b->write_list);
 		submit_io(b, REQ_OP_WRITE, write_endio);
-		cond_resched();
 	}
 	blk_finish_plug(&plug);
 }
@@ -1953,8 +1947,6 @@ void dm_bufio_prefetch(struct dm_bufio_client *c,
 				submit_io(b, REQ_OP_READ, read_endio);
 			dm_bufio_release(b);
 
-			cond_resched();
-
 			if (!n_blocks)
 				goto flush_plug;
 			dm_bufio_lock(c);
@@ -2093,8 +2085,6 @@ int dm_bufio_write_dirty_buffers(struct dm_bufio_client *c)
 			cache_mark(&c->cache, b, LIST_CLEAN);
 
 		cache_put_and_wake(c, b);
-
-		cond_resched();
 	}
 	lru_iter_end(&it);
 
@@ -2350,7 +2340,6 @@ static void __scan(struct dm_bufio_client *c)
 
 			atomic_long_dec(&c->need_shrink);
 			freed++;
-			cond_resched();
 		}
 	}
 }
@@ -2659,8 +2648,6 @@ static unsigned long __evict_many(struct dm_bufio_client *c,
 
 		__make_buffer_clean(b);
 		__free_buffer_wake(b);
-
-		cond_resched();
 	}
 
 	return count;
@@ -2802,7 +2789,6 @@ static void evict_old(void)
 	while (dm_bufio_current_allocated > threshold) {
 		if (!__evict_a_few(64))
 			break;
-		cond_resched();
 	}
 	mutex_unlock(&dm_bufio_clients_lock);
 }
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 911f73f7ebba..df136b29471a 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -1829,7 +1829,6 @@ static void process_deferred_bios(struct work_struct *ws)
 
 		else
 			commit_needed = process_bio(cache, bio) || commit_needed;
-		cond_resched();
 	}
 
 	if (commit_needed)
@@ -1853,7 +1852,6 @@ static void requeue_deferred_bios(struct cache *cache)
 	while ((bio = bio_list_pop(&bios))) {
 		bio->bi_status = BLK_STS_DM_REQUEUE;
 		bio_endio(bio);
-		cond_resched();
 	}
 }
 
@@ -1894,8 +1892,6 @@ static void check_migrations(struct work_struct *ws)
 		r = mg_start(cache, op, NULL);
 		if (r)
 			break;
-
-		cond_resched();
 	}
 }
 
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 5315fd261c23..70a24ade34af 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1629,8 +1629,6 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
 			atomic_dec(&ctx->cc_pending);
 			ctx->cc_sector += sector_step;
 			tag_offset++;
-			if (!atomic)
-				cond_resched();
 			continue;
 		/*
 		 * There was a data integrity error.
@@ -1965,7 +1963,6 @@ static int dmcrypt_write(void *data)
 			io = crypt_io_from_node(rb_first(&write_tree));
 			rb_erase(&io->rb_node, &write_tree);
 			kcryptd_io_write(io);
-			cond_resched();
 		} while (!RB_EMPTY_ROOT(&write_tree));
 		blk_finish_plug(&plug);
 	}
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 97a8d5fc9ebb..63c88f23b585 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2717,12 +2717,10 @@ static void integrity_recalc(struct work_struct *w)
 				       ic->sectors_per_block, BITMAP_OP_TEST_ALL_CLEAR)) {
 			logical_sector += ic->sectors_per_block;
 			n_sectors -= ic->sectors_per_block;
-			cond_resched();
 		}
 		while (block_bitmap_op(ic, ic->recalc_bitmap, logical_sector + n_sectors - ic->sectors_per_block,
 				       ic->sectors_per_block, BITMAP_OP_TEST_ALL_CLEAR)) {
 			n_sectors -= ic->sectors_per_block;
-			cond_resched();
 		}
 		get_area_and_offset(ic, logical_sector, &area, &offset);
 	}
@@ -2782,7 +2780,6 @@ static void integrity_recalc(struct work_struct *w)
 	}
 
 advance_and_next:
-	cond_resched();
 
 	spin_lock_irq(&ic->endio_wait.lock);
 	remove_range_unlocked(ic, &range);
diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index d01807c50f20..8a91e83188e7 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -512,8 +512,6 @@ static int run_complete_job(struct kcopyd_job *job)
 	if (atomic_dec_and_test(&kc->nr_jobs))
 		wake_up(&kc->destroyq);
 
-	cond_resched();
-
 	return 0;
 }
 
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index bf7a574499a3..cd8891c12cca 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1762,7 +1762,6 @@ static void copy_callback(int read_err, unsigned long write_err, void *context)
 			s->exception_complete_sequence++;
 			rb_erase(&pe->out_of_order_node, &s->out_of_order_tree);
 			complete_exception(pe);
-			cond_resched();
 		}
 	} else {
 		struct rb_node *parent = NULL;
diff --git a/drivers/md/dm-stats.c b/drivers/md/dm-stats.c
index db2d997a6c18..d6878cb7b0ef 100644
--- a/drivers/md/dm-stats.c
+++ b/drivers/md/dm-stats.c
@@ -230,7 +230,6 @@ void dm_stats_cleanup(struct dm_stats *stats)
 				       atomic_read(&shared->in_flight[READ]),
 				       atomic_read(&shared->in_flight[WRITE]));
 			}
-			cond_resched();
 		}
 		dm_stat_free(&s->rcu_head);
 	}
@@ -336,7 +335,6 @@ static int dm_stats_create(struct dm_stats *stats, sector_t start, sector_t end,
 	for (ni = 0; ni < n_entries; ni++) {
 		atomic_set(&s->stat_shared[ni].in_flight[READ], 0);
 		atomic_set(&s->stat_shared[ni].in_flight[WRITE], 0);
-		cond_resched();
 	}
 
 	if (s->n_histogram_entries) {
@@ -350,7 +348,6 @@ static int dm_stats_create(struct dm_stats *stats, sector_t start, sector_t end,
 		for (ni = 0; ni < n_entries; ni++) {
 			s->stat_shared[ni].tmp.histogram = hi;
 			hi += s->n_histogram_entries + 1;
-			cond_resched();
 		}
 	}
 
@@ -372,7 +369,6 @@ static int dm_stats_create(struct dm_stats *stats, sector_t start, sector_t end,
 			for (ni = 0; ni < n_entries; ni++) {
 				p[ni].histogram = hi;
 				hi += s->n_histogram_entries + 1;
-				cond_resched();
 			}
 		}
 	}
@@ -512,7 +508,6 @@ static int dm_stats_list(struct dm_stats *stats, const char *program,
 			}
 			DMEMIT("\n");
 		}
-		cond_resched();
 	}
 	mutex_unlock(&stats->mutex);
 
@@ -794,7 +789,6 @@ static void __dm_stat_clear(struct dm_stat *s, size_t idx_start, size_t idx_end,
 				local_irq_enable();
 			}
 		}
-		cond_resched();
 	}
 }
 
@@ -910,8 +904,6 @@ static int dm_stats_print(struct dm_stats *stats, int id,
 
 		if (unlikely(sz + 1 >= maxlen))
 			goto buffer_overflow;
-
-		cond_resched();
 	}
 
 	if (clear)
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 07c7f9795b10..52e4a7dc6923 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2234,7 +2234,6 @@ static void process_thin_deferred_bios(struct thin_c *tc)
 			throttle_work_update(&pool->throttle);
 			dm_pool_issue_prefetches(pool->pmd);
 		}
-		cond_resched();
 	}
 	blk_finish_plug(&plug);
 }
@@ -2317,7 +2316,6 @@ static void process_thin_deferred_cells(struct thin_c *tc)
 			else
 				pool->process_cell(tc, cell);
 		}
-		cond_resched();
 	} while (!list_empty(&cells));
 }
 
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 074cb785eafc..75ecc26915a1 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -321,8 +321,6 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 			while (daa-- && i < p) {
 				pages[i++] = pfn_t_to_page(pfn);
 				pfn.val++;
-				if (!(i & 15))
-					cond_resched();
 			}
 		} while (i < p);
 		wc->memory_map = vmap(pages, p, VM_MAP, PAGE_KERNEL);
@@ -819,7 +817,6 @@ static void writecache_flush(struct dm_writecache *wc)
 		if (writecache_entry_is_committed(wc, e2))
 			break;
 		e = e2;
-		cond_resched();
 	}
 	writecache_commit_flushed(wc, true);
 
@@ -848,7 +845,6 @@ static void writecache_flush(struct dm_writecache *wc)
 		if (unlikely(e->lru.prev == &wc->lru))
 			break;
 		e = container_of(e->lru.prev, struct wc_entry, lru);
-		cond_resched();
 	}
 
 	if (need_flush_after_free)
@@ -970,7 +966,6 @@ static int writecache_alloc_entries(struct dm_writecache *wc)
 
 		e->index = b;
 		e->write_in_progress = false;
-		cond_resched();
 	}
 
 	return 0;
@@ -1058,7 +1053,6 @@ static void writecache_resume(struct dm_target *ti)
 			e->original_sector = le64_to_cpu(wme.original_sector);
 			e->seq_count = le64_to_cpu(wme.seq_count);
 		}
-		cond_resched();
 	}
 #endif
 	for (b = 0; b < wc->n_blocks; b++) {
@@ -1093,7 +1087,6 @@ static void writecache_resume(struct dm_target *ti)
 				}
 			}
 		}
-		cond_resched();
 	}
 
 	if (need_flush) {
@@ -1824,7 +1817,6 @@ static void __writeback_throttle(struct dm_writecache *wc, struct writeback_list
 			wc_unlock(wc);
 		}
 	}
-	cond_resched();
 }
 
 static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeback_list *wbl)
@@ -2024,7 +2016,6 @@ static void writecache_writeback(struct work_struct *work)
 				     read_original_sector(wc, e))) {
 				BUG_ON(!f->write_in_progress);
 				list_move(&e->lru, &skipped);
-				cond_resched();
 				continue;
 			}
 		}
@@ -2079,7 +2070,6 @@ static void writecache_writeback(struct work_struct *work)
 				break;
 			}
 		}
-		cond_resched();
 	}
 
 	if (!list_empty(&skipped)) {
@@ -2168,7 +2158,6 @@ static int init_memory(struct dm_writecache *wc)
 
 	for (b = 0; b < wc->n_blocks; b++) {
 		write_original_sector_seq_count(wc, &wc->entries[b], -1, -1);
-		cond_resched();
 	}
 
 	writecache_flush_all_metadata(wc);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 64a1f306c96c..ac0aff4de190 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -996,7 +996,6 @@ static void dm_wq_requeue_work(struct work_struct *work)
 		io->next = NULL;
 		__dm_io_complete(io, false);
 		io = next;
-		cond_resched();
 	}
 }
 
@@ -1379,12 +1378,10 @@ static noinline void __set_swap_bios_limit(struct mapped_device *md, int latch)
 {
 	mutex_lock(&md->swap_bios_lock);
 	while (latch < md->swap_bios) {
-		cond_resched();
 		down(&md->swap_bios_semaphore);
 		md->swap_bios--;
 	}
 	while (latch > md->swap_bios) {
-		cond_resched();
 		up(&md->swap_bios_semaphore);
 		md->swap_bios++;
 	}
@@ -2583,7 +2580,6 @@ static void dm_wq_work(struct work_struct *work)
 			break;
 
 		submit_bio_noacct(bio);
-		cond_resched();
 	}
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index a104a025084d..88e8148be28f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9048,7 +9048,6 @@ void md_do_sync(struct md_thread *thread)
 		 * about not overloading the IO subsystem. (things like an
 		 * e2fsck being done on the RAID array should execute fast)
 		 */
-		cond_resched();
 
 		recovery_done = io_sectors - atomic_read(&mddev->recovery_active);
 		currspeed = ((unsigned long)(recovery_done - mddev->resync_mark_cnt))/2
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 2aabac773fe7..71bd8d8d1d1c 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -807,7 +807,6 @@ static void flush_bio_list(struct r1conf *conf, struct bio *bio)
 
 		raid1_submit_write(bio);
 		bio = next;
-		cond_resched();
 	}
 }
 
@@ -2613,7 +2612,6 @@ static void raid1d(struct md_thread *thread)
 		else
 			WARN_ON_ONCE(1);
 
-		cond_resched();
 		if (mddev->sb_flags & ~(1<<MD_SB_CHANGE_PENDING))
 			md_check_recovery(mddev);
 	}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 023413120851..d41f856ebcf4 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -916,7 +916,6 @@ static void flush_pending_writes(struct r10conf *conf)
 
 			raid1_submit_write(bio);
 			bio = next;
-			cond_resched();
 		}
 		blk_finish_plug(&plug);
 	} else
@@ -1132,7 +1131,6 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
 		raid1_submit_write(bio);
 		bio = next;
-		cond_resched();
 	}
 	kfree(plug);
 }
@@ -3167,7 +3165,6 @@ static void raid10d(struct md_thread *thread)
 		else
 			WARN_ON_ONCE(1);
 
-		cond_resched();
 		if (mddev->sb_flags & ~(1<<MD_SB_CHANGE_PENDING))
 			md_check_recovery(mddev);
 	}
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 284cd71bcc68..47b995c97363 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6727,8 +6727,6 @@ static int handle_active_stripes(struct r5conf *conf, int group,
 		handle_stripe(batch[i]);
 	log_write_stripe_run(conf);
 
-	cond_resched();
-
 	spin_lock_irq(&conf->device_lock);
 	for (i = 0; i < batch_size; i++) {
 		hash = batch[i]->hash_lock_index;
-- 
2.31.1

