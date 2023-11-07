Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3BA7E4C8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjKGXMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbjKGXLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:11:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2532A172C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:34 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJpW2004902;
        Tue, 7 Nov 2023 23:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o2NOM45GWqtp+KSG2RbtbBF0RAvHHkD/f6WqLYnlgOw=;
 b=br4i54K5zbB2nA9mmARbNwWCKVRnBfWCCO+g8BnH/hcDz7ku4sf+UrLIlwL1EXOS2aek
 EBcEXvBOmeF8aPWO+1UAezfMbwsbRAo7dnt5rzN/v0K5TBrTMv6MC3QBa9xFYOCoPIZb
 HxI/NYf5ajj+70u+wmB/1ZR6pfa4PoYomRhvxUQ9CfBZYH3u2XPtk/VNZY1/t3eZRHGW
 JpMomTrUOBujDvKMT0vJlp0KAygMDVy5WGCUB1zyonvRpcaUx9Ri221pEG8FqJ/kpnd6
 AP2LSRQtHpCHYqTkF6lMXvEmHR8gEy3EEjDmnmAbWz3w23+859wCtVx5jskIFkhW24uY ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22g6bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N7e3k032011;
        Tue, 7 Nov 2023 23:09:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w2248h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go27H4Og6ceJd6SUrSOKLnMdw5L/+4IMR3WpRCb2wx7TzGXGVTR3zc2QQ+SQ7qFHSVwbWsvwLB8jMvVcbPSQvFPUzqVjE7dKfSad0gg4z6H/rCmZc3yFTtMI5blVp8FptNE0dY+nyNjLhLRS+Mlf2G3ObSHxW2Jc/V5OwMSEVX3523uy9t8DcpikUmZHOdJUeSW/fsFe9dyLPR2Ebm4O2lSPR2/a1GyUHZhoL0JbG2tJgbehiHJFcDZcwXBD+Q+8+3TNBw3wz1utSU5ygvrROKx0/gYN9O0/iMMXYh+SBv2qa2Ip3/IoOI+vz2yqGYNRmWErkzXLwG5Szy0aoIC86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2NOM45GWqtp+KSG2RbtbBF0RAvHHkD/f6WqLYnlgOw=;
 b=PDlhxJkQibpqgrG+bvKxEeEphlomovrWrMr2w3Z3ZWVOh5rVbsgB695QPSpUAkukXkkSqgXFqDmOBbENF+epXwiPip2SkkOR8nmPa5Uw04l2xwlsRFR2dbJfmjegrRrMR3uuZOk8kyosJDTuMCcom0XK5gkji5dT1uBNDaYyes8cZgmhEr9stc7gNTo4yUbu2UNh+CSqiInmRsstSDHu+cCs8hDYh9EUSCalkf/PN/w4yJGxP0sxaHd7hgxBYG46DZXeGpwcpSJ6z7vWwtoHeoDQdpzRzUfs8xOZAP1E2+3SuIUp1MvKWOnJEFLmZz0bVpUG/obmzc9jBvT1Q3U/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2NOM45GWqtp+KSG2RbtbBF0RAvHHkD/f6WqLYnlgOw=;
 b=iplCdexr2LuuxKX8SLuhLo7FVFtdQe/SMXUHPmecEenq9GLc9UW+O0gwCu5tmYIrUhZ1I2eRpfnso2zHrN+XZHWBF4MFdJBXuRyUM8NJ6ALZP5uNgB2fJhG3TXHn3TzWSrosE1+pGWV7APzPqSE3ji/roEy/aHAZ3kpCpAG7m1g=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:32 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:32 +0000
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
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        "David S. Miller" <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: [RFC PATCH 77/86] treewide: netfilter: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:13 -0800
Message-Id: <20231107230822.371443-21-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0267.namprd04.prod.outlook.com
 (2603:10b6:303:88::32) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ba34ae-f811-4b94-cc87-08dbdfe699d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 435r//mJq3ALZanutMMD2ONgV26+0ItPGYoZnyhylrJAVugpBaDSkhK7K4vIsb/6Ne3JHeAwsHaee9dqKWQq1Bmfk8CNShkPQkHMVTND2ziuLpsDr1I6dp5vbx1UqsPcJYT1UKkvQTTriYsapDtJJ+rDDKA4rcmvqklVwNBNyYlvYBtM8iH6mhtBfyjjux/tjpILhbIYSmObn5Js64eCum7ORaUUvEBFH0biLFCMDWHgOWuM5iAqUXIevbS8/WbcUD8KTta0uAO9Milp1eQwnXNQjTw0F6+0go34WzmR8wRI1wfBQd2jeE31ot3WG6UD5hIy4YNBEb0/mDjQsbyFzdb2wQx6aU43kacbWN6X5y+9/paoo7OJk/yWyfmktg/d4tzh29skwpOZNuTQaonbB/W3XbmMoIxhcr6CWfXO1RTDUPK90Ea1ta6DAxU9HhJIZhOJcR371/m+ARdC4yfh00lXh0dTCDcaV9zaArupnr4IYVpoWvyCBtcUzbLfB2jJB9ZSE7RhSyI9NVvyVxnwgYLLVyrZfN1yw3XEfIuml/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EvQ6/28vSTn3UNbur++COrNRJDpS3tXyYryZsuyDR4IDKghy4gl/McK3OtBA?=
 =?us-ascii?Q?u2Za9orDFe6JsbBuhYrg7SGJIbgtaDpQL70nl30M1Cpi9Nf8csHxhYmYqPyQ?=
 =?us-ascii?Q?EiQOZFUBjMGmo/L8BZ+/d946ZtSIGAwJgM9pDUhnfKN59N2/whmLPWmUArws?=
 =?us-ascii?Q?IWMA6STKlWb+j5yIRTJ4bH+5q4XQsl9nAm2Ugc10eOnCkJCaikDEnUUG60Sf?=
 =?us-ascii?Q?nsspN4dJUmblCnV4ntg7WXjf07mpPlmSEkCHr26zcxk8KZbV8iLoz0DNDYzX?=
 =?us-ascii?Q?PgpU1qghLwuIoDVY0YSd83J9Z/H38XQQfR8b0XYupKDDJtLgZ6/1qm0gl7A/?=
 =?us-ascii?Q?PO1xeUqatPuBsceyh15dMFFAU7icvNzXv2BM22JXi3kGPrVOQdNyl9i8qfD8?=
 =?us-ascii?Q?RDc78bzjJh8+MPhmCT7De3o9F3+HKEd5rzNvXKXqFMN/JDaUiFt5TeCLQ00k?=
 =?us-ascii?Q?jZeLnrilRKsJJlAJDOHhgwJkXH/eRXtQ/S7GSzUmNt+5OnQlesAlqSlei2/C?=
 =?us-ascii?Q?af+OosBIhc5aba8u4ZIaQpRvXqJULmObkjg7dbOpgwqRyD+wE66dwSnNj+NI?=
 =?us-ascii?Q?jZr9frF+Irur40JU4HubUpkZsaHzPCk3RqBhSXL9cJvjiNuuNXN3Al/KMV0h?=
 =?us-ascii?Q?2c7lgDJKcvKGnqPZlES9QFVbu3cCgTKJ2CZxW0pXy4mU1Yfwz++NWh+Je6gu?=
 =?us-ascii?Q?TKhXOHnRUTl5aNlk3dQzTXaTYtK9OfdTzt/hGqBWUtd8TD9prsHw7yzw57Kq?=
 =?us-ascii?Q?40Cq7L2chlbYNA1noV6D/Wx0frOEdj9DtzP0egdhLrLVDCn5d/GF0bWmppwp?=
 =?us-ascii?Q?sZJxnCFQ/M0cmCUynQwza6qkkkapiSvDGW5mhm36hZDq03hDk1EMGoUGA1Uq?=
 =?us-ascii?Q?F1Up+o+2Be/mvlNxmUBtpvy5PoeZqhOq6hBVuiTNjoErIo6PNvfO1PiQvqg1?=
 =?us-ascii?Q?X2D2iRtYX/+nWIMKA2gd9SQXYoN7tVk14Q8ytC0vh2PzM+4xBE7ViITcg5An?=
 =?us-ascii?Q?qKmf0HIeJADtUK+tOlWxdJe8muFhOlKL6mJZhKZ8RzOTlixR/YUfxzbiXXQ7?=
 =?us-ascii?Q?1GQnbKxI0qksid9NfRi6seWuhGBhNt6TxHNraVScG86gB6GliwxJoJ3qn8mV?=
 =?us-ascii?Q?AIUKPTX2c30qjD1AK8vvzeuPRNgjvQn0RlngTg3E8NWiqsyZV74UBYomPB8O?=
 =?us-ascii?Q?1ygUfffmtu66t2t19MoePrfJsiDq01l7jeYqScZdbGQkpIXiSWWqBj35EVe9?=
 =?us-ascii?Q?AbonNdE54AvCw6GuTI0tZ7LNYfklo1/CAfObItXi/8yaudrZdXiXCpjUB9AY?=
 =?us-ascii?Q?6O2jpyBZ/K9P1xVdieEW0fq7XlG6tQgdlGr4J+p5s4E3Kyl2vaW1NTC+qho5?=
 =?us-ascii?Q?czp97cEZbxMZy5DHAeHlqkf30fEgdXO7ZexK1u8yVYVpIjZWB/44Xe8xu1LW?=
 =?us-ascii?Q?YIvYLDNhbEqvMntQ6dZKTYTt6Tlkxjrlrb0OaAI8W5eMKKiW/zBudXyaWgI0?=
 =?us-ascii?Q?IX6OTsTCErRrjgA4VuyfPBy66OTxp6tXOe2HbQE1IzfdPHX+7NwXwHYvZmpz?=
 =?us-ascii?Q?7amiCwhgEjYWdATxPYg7wW8VvaF0FR7QG1ZNSXLwnw/hsggVmq8bvCTtKuHc?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sMzrO2/y5JQHMDk9Y84xUWrCxX0mqeNSkczqJHNgKVVTL0zZLv8oJSiq8QEp?=
 =?us-ascii?Q?vy0c1qyaMBVL9ghKSg2aBVjzPneKwUaP+g19lEK17XqyvXF6dcqOEpcMQ4VL?=
 =?us-ascii?Q?mJKLy7t2guUwFtzY0yZ24tcCT7XPx4kGGj8BUKJbDujwxZuwSH259nRLeHGk?=
 =?us-ascii?Q?vVdL9g1Vg1cecz3a+bNPM40dmfrFMIDwI+9N0P5xKRhxUw06zjlkc1L7PkII?=
 =?us-ascii?Q?9hiUzf4ervPxQuEOx6pjdcc9N5GqB2zsjx4A4HvEUPp1psheXYFw/sPg02Bk?=
 =?us-ascii?Q?OcNF4eH1jQ+CqUPoVShFOKnWl17HaAr7W1McBIyUTUQO07u2t42Ps8yIbmdi?=
 =?us-ascii?Q?b2d6EWqFvxqfQJJYfs+hngbT1MlSX1ccBHwi+KQ8GvayuqC5IGeyegBH4SbN?=
 =?us-ascii?Q?e9ePt+DIqj9bZu7R5gL6RIYpQDwc4h6nAu3eyVDv92jRPdr63+kDezm4Ump9?=
 =?us-ascii?Q?CWJnU8EWE/mVq2QllDJbBKh6U4fhoShPCtlYOWXWyxTr/ANl8TW55vjnjLcE?=
 =?us-ascii?Q?3iW/g/+tP7Zfb9ydnFz6Nc2hjdZkh0qTGFZOOB4DdvGhePPCssQGZ28eykHv?=
 =?us-ascii?Q?sHCVJN23gnMk4mLpdj0+CU0drasxOX6VNaWV7Iv7+b6YTnRuoOzLcjEwFPfe?=
 =?us-ascii?Q?TYi+fUnmTOVqXnC5G/zS3SoWzbfl6qBBlLIM1iMTJFO982uNrfyBnMENBzyO?=
 =?us-ascii?Q?5lJ9D0S1Sy6hyBD6xZyknqa2edeZq/e97WvQ5LwiYRJb++H+PR+Dc6a+Y7MV?=
 =?us-ascii?Q?jI6vRBXtV3CJ+lIKnrS14X23S23Kn7ZHQlstJ8sb+NUqdCtXTKVo9UZs7hdX?=
 =?us-ascii?Q?nGPMyCwBvuUYlDzTrRW22oBoomRb8GTmVUOyyy42MP8fk80BVkpdwefMETJl?=
 =?us-ascii?Q?5HWsYD5T7EXK9e3Z++IqNFl9MgbMzpDOqwpGfQjHNYWyytbPykNXtLlKX12z?=
 =?us-ascii?Q?b/rJYsAv9NFDGy+a6ZJfPUo7gcoc1UIho+KX8twPkESRjxR2+4TD+rDrNP1R?=
 =?us-ascii?Q?UL8ENIwoNjIGvvysl64BOqca/uS0lPv7etWEWC39xCqvaeLIhfE8FnaaSOIK?=
 =?us-ascii?Q?uznlxwJW/s/d/PtOHkAlicRY9htgRBhBVIJ4Wl3+Q5+04U06dooI05CshZBe?=
 =?us-ascii?Q?emU9WDb+5GqaDYwFCztjmPzSj+a02INgzvrmImIvztXl10VOI1eLbzlhWvsp?=
 =?us-ascii?Q?NaaWJOcy2768pjEqcj3Ptz7OPEYjMWFnTzW/P2+UFGeRkFTHdtQCTqPS516C?=
 =?us-ascii?Q?BTOfSOpuosbzyUfKI6jdHDJOqA/rb0Pw4eOVN8C3Dx3rzNWBIfYqlRGRI/OO?=
 =?us-ascii?Q?xgTD9rrJ+6LJ4U2qOr+HWwN4LKFWQqVNtTytmWrGvamHhsMqW3/nH5iJQxqx?=
 =?us-ascii?Q?tT5/qlT6OsVpr9q+r/P4IfFy4mt4sr9PHsCdAHjEoZmTqIICGs8ln1aPs9Tw?=
 =?us-ascii?Q?oYcF5rbjsnOEGHhkgZslUtOdN6iuYtayqxJHpCyLdd3Fqwg2Aiy0fBHJ8X5M?=
 =?us-ascii?Q?J6BISS6FImL03XL3ZO/ewxqQLirmXtIJC7Kd3pPmINfE1qaO5dc93+zG4LtX?=
 =?us-ascii?Q?QlhA1A6ys46Vgziu9ZM6+SgWWJEOT9XiFaNzUZjDccwIvKOwmVpcxc4eGslC?=
 =?us-ascii?Q?+ZmDnEK7tAR02LqNMAmariNcJDDiVi1u1DvIaidyf0tCMS3M+/ULd3hDSL2f?=
 =?us-ascii?Q?mN/KRrvBYTv8L/SDuGEgmFvoUy0kbBXg4RxZGpnKtg7/SWn9EezKmEg/gyta?=
 =?us-ascii?Q?ie0Ly8ADsA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ba34ae-f811-4b94-cc87-08dbdfe699d3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:32.0893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35EDMQmdCNxXLjpiX4Ti2U6a7vMFTrspFbfoA/0yLyaxX96gfKSh/iYz2PsiqBn1XP6vQFnX0NCpgttZkEGMYXjZf3udpYAuPCpRH39dVH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: IpR0uO48cSymKOpsh7pitboZTEQ_wAYY
X-Proofpoint-GUID: IpR0uO48cSymKOpsh7pitboZTEQ_wAYY
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

Most of the uses here are in set-1 (some right after we give up a lock
or enable bottom-halves, causing an explicit preemption check.)
We can remove all of them.

There's one case where we do "cond_resched(); cpu_relax()" while
spinning on a seqcount. Replace with cond_resched_stall().

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Florian Westphal <fw@strlen.de>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Julian Anastasov <ja@ssi.bg>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 net/netfilter/ipset/ip_set_core.c   | 1 -
 net/netfilter/ipvs/ip_vs_est.c      | 3 ---
 net/netfilter/nf_conncount.c        | 2 --
 net/netfilter/nf_conntrack_core.c   | 3 ---
 net/netfilter/nf_conntrack_ecache.c | 3 ---
 net/netfilter/nf_tables_api.c       | 2 --
 net/netfilter/nft_set_rbtree.c      | 2 --
 net/netfilter/x_tables.c            | 3 +--
 net/netfilter/xt_hashlimit.c        | 1 -
 9 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 35d2f9c9ada0..f584c5e756ae 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1703,7 +1703,6 @@ call_ad(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 		if (retried) {
 			__ip_set_get_netlink(set);
 			nfnl_unlock(NFNL_SUBSYS_IPSET);
-			cond_resched();
 			nfnl_lock(NFNL_SUBSYS_IPSET);
 			__ip_set_put_netlink(set);
 		}
diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
index c5970ba416ae..5543efeeb3f7 100644
--- a/net/netfilter/ipvs/ip_vs_est.c
+++ b/net/netfilter/ipvs/ip_vs_est.c
@@ -622,7 +622,6 @@ static void ip_vs_est_drain_temp_list(struct netns_ipvs *ipvs)
 			goto unlock;
 		}
 		mutex_unlock(&__ip_vs_mutex);
-		cond_resched();
 	}
 
 unlock:
@@ -681,7 +680,6 @@ static int ip_vs_est_calc_limits(struct netns_ipvs *ipvs, int *chain_max)
 
 		if (!ipvs->enable || kthread_should_stop())
 			goto stop;
-		cond_resched();
 
 		diff = ktime_to_ns(ktime_sub(t2, t1));
 		if (diff <= 1 * NSEC_PER_USEC) {
@@ -815,7 +813,6 @@ static void ip_vs_est_calc_phase(struct netns_ipvs *ipvs)
 		 * and deleted (releasing kthread contexts)
 		 */
 		mutex_unlock(&__ip_vs_mutex);
-		cond_resched();
 		mutex_lock(&__ip_vs_mutex);
 
 		/* Current kt released ? */
diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 5d8ed6c90b7e..e7bc39ca204d 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -473,8 +473,6 @@ static void tree_gc_worker(struct work_struct *work)
 	rcu_read_unlock();
 	local_bh_enable();
 
-	cond_resched();
-
 	spin_lock_bh(&nf_conncount_locks[tree]);
 	if (gc_count < ARRAY_SIZE(gc_nodes))
 		goto next; /* do not bother */
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 9f6f2e643575..d2f38870bbab 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1563,7 +1563,6 @@ static void gc_worker(struct work_struct *work)
 		 * we will just continue with next hash slot.
 		 */
 		rcu_read_unlock();
-		cond_resched();
 		i++;
 
 		delta_time = nfct_time_stamp - end_time;
@@ -2393,7 +2392,6 @@ get_next_corpse(int (*iter)(struct nf_conn *i, void *data),
 		}
 		spin_unlock(lockp);
 		local_bh_enable();
-		cond_resched();
 	}
 
 	return NULL;
@@ -2418,7 +2416,6 @@ static void nf_ct_iterate_cleanup(int (*iter)(struct nf_conn *i, void *data),
 
 		nf_ct_delete(ct, iter_data->portid, iter_data->report);
 		nf_ct_put(ct);
-		cond_resched();
 	}
 	mutex_unlock(&nf_conntrack_mutex);
 }
diff --git a/net/netfilter/nf_conntrack_ecache.c b/net/netfilter/nf_conntrack_ecache.c
index 69948e1d6974..b568e329bf22 100644
--- a/net/netfilter/nf_conntrack_ecache.c
+++ b/net/netfilter/nf_conntrack_ecache.c
@@ -84,7 +84,6 @@ static enum retry_state ecache_work_evict_list(struct nf_conntrack_net *cnet)
 
 		if (sent++ > 16) {
 			spin_unlock_bh(&cnet->ecache.dying_lock);
-			cond_resched();
 			goto next;
 		}
 	}
@@ -96,8 +95,6 @@ static enum retry_state ecache_work_evict_list(struct nf_conntrack_net *cnet)
 
 		hlist_nulls_del_rcu(&ct->tuplehash[IP_CT_DIR_REPLY].hnnode);
 		nf_ct_put(ct);
-
-		cond_resched();
 	}
 
 	return ret;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 29c651804cb2..6ff5515d9b17 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3742,8 +3742,6 @@ static int nft_table_validate(struct net *net, const struct nft_table *table)
 		err = nft_chain_validate(&ctx, chain);
 		if (err < 0)
 			return err;
-
-		cond_resched();
 	}
 
 	return 0;
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index e34662f4a71e..9bdf7c0e0831 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -495,8 +495,6 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		if (fatal_signal_pending(current))
 			return -EINTR;
 
-		cond_resched();
-
 		write_lock_bh(&priv->lock);
 		write_seqcount_begin(&priv->count);
 		err = __nft_rbtree_insert(net, set, rbe, ext);
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 21624d68314f..ab53adf6393d 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1433,8 +1433,7 @@ xt_replace_table(struct xt_table *table,
 
 		if (seq & 1) {
 			do {
-				cond_resched();
-				cpu_relax();
+				cond_resched_stall();
 			} while (seq == raw_read_seqcount(s));
 		}
 	}
diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 0859b8f76764..47a11d49231a 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -372,7 +372,6 @@ static void htable_selective_cleanup(struct xt_hashlimit_htable *ht, bool select
 				dsthash_free(ht, dh);
 		}
 		spin_unlock_bh(&ht->lock);
-		cond_resched();
 	}
 }
 
-- 
2.31.1

