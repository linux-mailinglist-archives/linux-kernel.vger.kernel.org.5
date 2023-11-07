Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8867E4B6D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbjKGWE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjKGWDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:03:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745851992
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:56 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJm5P004891;
        Tue, 7 Nov 2023 21:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=/+dZ8EuRBjh9qZi0qxIr/G1BamPMT8CzHU5Xn7Q5MtY=;
 b=xxy9bm3bPae98uIiuEgOPFdmick2K9epEUSy2IfO+oIeapJoNOOlYea1OaYybtJzlf/L
 cntkjige84LBMl50WrzgSnHf4V7CaLyEj86o6RuHAP6huhYnOHN1gsQY16jmKiVm/Dqb
 aBx6wFglyljLHfWD5w1pYEpOYZEfQuQnBK/Oq9oL4x+8Ux2eGXkK8Cwx32oFP9U6Akk2
 94mxb8zi0Sj1ZDHAaUKaaFpiYV2/07RcH7b2uY6tNw6rqek1O+64SO9VJsse/Djlndx7
 ED2na0k5840Dx8voArzx2YHlARnNbQZv5K/FPPq+JjHgfnENLHi88dwHzXITYfO1Ar+x 2g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22g2ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIrZv000400;
        Tue, 7 Nov 2023 21:59:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wsmhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnFGpd49WR3VO8GuyYvuaoOgZKbP4TN3NCdyCtV3+HiBnraS51dzc4QDqAxllOFHVIOkP/+tJURUCqrteVBhkPPrh7+C1UaIbz9BB6Nu5va+MYB8WLPOTSylb3NmbToWr0N7wAo0FBa2UUYJp0pNZHbkpWatrlu+7vNwACT2OtQ3FsXB9bQ1JP+t2EvUa5RfqXrsyDnkXOd8EpGjnZKkW3v1O8wiXR/i9tnCTie/7XZVkMvyJX97jNsLusHoBWIGQLVWGjj1gPav8MqsJQpllaD/IakuzOOrue0mtEHfh7+D7F0fdV0UvRaQw5gJGKk3bQZ5W7yNl+VKXehygRhlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+dZ8EuRBjh9qZi0qxIr/G1BamPMT8CzHU5Xn7Q5MtY=;
 b=KDJIAiJjW/CtF1J1pogj5ie50FN68W2Md10Jj9Lndt2gfLmZHScxWp8sJbwNCXj/O6xS/3YafeY8aXpVw/BYec8Zxlm60YehffvZjYcVON/lwQARhuyp5L4viYIKJBOiaUxZqG2yaFnwEYHIWL8mpOxl7Fuczk2pQdhBBQLaq7H8J7ihc9VI4K5FYg+fMpkdD4CAwYSJdi42FeikyewKfR5DsNPqosDOSpkI6Rfq+xWExEl9EBK/whkdnk9nvTg9Kja5wnfQ2QB70fcJFy6fqcdoLbncloeDnp5C4qV7uLJXqjMAvUMRXpSMVH61lLjrVW0jRu3gTYP5DXJ3t+DL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+dZ8EuRBjh9qZi0qxIr/G1BamPMT8CzHU5Xn7Q5MtY=;
 b=x2D1OQLKKcp/yErkFWrKUQDTefHoVy7JkcE+fWCk31KkF3NuDaioAjAJNd6ugEkM/QspfYlu2wlQUSbZYMTeZyFIUZSXPYBMzfCkO539MpKtqmVpYUOAkSLNKAMUJYN8Rzl2CKRz/1zJy4p+rk+EMrqgPs2LhWljjijv24BtNAw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:52 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 42/86] sched: force preemption on tick expiration
Date:   Tue,  7 Nov 2023 13:57:28 -0800
Message-Id: <20231107215742.363031-43-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0319.namprd04.prod.outlook.com
 (2603:10b6:303:82::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcaccd5-26c3-45c4-c68b-08dbdfdcde7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LiMEbrdjeRHw3hhaWr4bKN3mX6YK/ectIhKNtCfRc7c8BPu4QvjRhlQsbQ0HDzh28V8MLRcVCcMbBAVGmHtCl3N3pDEaUQVb9APF3omBYidfTIGWswlzBtNRTzlML+LxeU9n8WemwWsOMvU22ZjWszo5GWwCAKKTAYnNax/ZhmA7y/OWe3TVAPaGYB6mi87VQWLWZ9LEJtKodKAfxL3TbqlZolelmp+QO1+o0SL0JbFF/vh24UXqS68kxpQx+mCWiGD116Wc4UccquFjGQmXeSL8X9+9KrWOrMn7duSFzJapg82sylwJUf5Wqd1S1ExAmhyOFY/YzAhZGzIF/MRx5sdoIZPXNuAZhwxmoBCx4efSiIVpQkVfz4stMUU/1lnY5yWpaMs1wbK0yBPuJ0NnEb03dk7AU0CpNczsthgyqqNP1ohLcEUluSukarM8gt8zK/qTRJqFQ6aNsD4U/M6Ah8rGnVnhLW1QCu2DimlcG+YKi1Xl/S7rjKgMup2LGy6CtepYt4gOHuVburDLlFra9R3ZfrlsbG8ed4QUfBjQqXYkZkjqMhF968i8LohJAT4uTSTDhBCTSlBX1xjK15Yc558BhO7KtL3fuhH6x/ILTSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N7Zl9kzSy828eFXLNeTc4eYYSpi2VaGMj7V8D97WdmjqL2IruFNV0oTv5giI?=
 =?us-ascii?Q?Udg1rb5RZnLVWe5C3NAthhI3wFVOvbcXdxhKaEun/pIU0DcqUybPK9G30BbE?=
 =?us-ascii?Q?2sclPWtklurTDyBVWlpPx1a567C0S2saUZNEjkCiisLlxDLzMgfmg+2z7eYX?=
 =?us-ascii?Q?nqYm+Uu9K82VNwM7e9q+9Ttx5zZO/z2ugNKtvD009b+OxpJpdqAf8KsCgoLC?=
 =?us-ascii?Q?78UualXoG2oM9Foz9ojxK6UcZ8pbf7JVo2YioZ79m8VUQPSIqU9gqqcpQr86?=
 =?us-ascii?Q?K0sHS0OfdQ92bZ6sP2h1j86JPvfS6cNVP7YiOnEHe64nNNfQvPTfSjtgK5A9?=
 =?us-ascii?Q?a8jfXxP8+JBSh/tVrC83YuRIYfBJT/B0QGCz5qac/oL3Bw9MMVau/DXWtBjv?=
 =?us-ascii?Q?7/jOTF5VPlalShphA+EImwozxYsiD4jvwiQWe5b9TuqpanUAwra7M2zTV5fR?=
 =?us-ascii?Q?ot3e2z5bsHX8Cu18w8V+jPD3sIgB3HttQJKgcZQVwowuSoQGoBnkz28TD6MN?=
 =?us-ascii?Q?viJL8MEl/9GClmhnfcBKQO8tFTtk5P6uJ6/AcVGfuZ478TuX9/zxMhJqEwEA?=
 =?us-ascii?Q?2dgeTL81SE1PwgQyeZI1DLdF6lwCO1bKZxNRBXjxb7jPKtlNaaC4DQPlZ88h?=
 =?us-ascii?Q?B4ZSRfPt0IRqO35d8zBu/rpqFg+Vundxw6Jjgm3VFROZFm+DxeJbv/piIw25?=
 =?us-ascii?Q?fCM7sJ6rZEF5ZhX+Kw6PRwahGTumoFAe4bRXxOEPSpgjQoCSSKK38VBpLqJ8?=
 =?us-ascii?Q?TdfLwGGRrA7CH1OERzu/CikIs+hpKA3zHV9WDNla0XWaAIT0eEAsNJ5WZgrS?=
 =?us-ascii?Q?xmttWRsc4iWs1YZcz66NVHnWBDtFANwL5WYeBGJDi9fRGbaFpaZDKcZE3nr7?=
 =?us-ascii?Q?5bWLE0i60A/G9WQKnvj0D48Dr6Dkk5ITYYeiHMw1XhWvH9saF5yU2/2g2F27?=
 =?us-ascii?Q?Hw9u9IuwsZ4YJqzNvPnN3NKPCvcqKZfdf7jnJKMlHowzulx1neE7zdYQkuj8?=
 =?us-ascii?Q?ZNVzubaP/xvpH7p6PbQYQTwWRQoSqTjnQvPHH3j7NY2YQMYSmUe3fBYQyc5r?=
 =?us-ascii?Q?uFwewBxC6xek/3urvo90Q3i8HdyixZjfPexTTeaDVoDQyDE17Xg3m8mZ7Pe4?=
 =?us-ascii?Q?rg/0jN+KneKjLmVzEF/Tw5sSYDEOI/DHA+v7eIrcqONyI67u/yvPYQO6a5Ep?=
 =?us-ascii?Q?G90rSKd9pWNmDYjTqE97HY3/h+HjYWSavBhAS7pUdVBmElD5RmwtogaChBk/?=
 =?us-ascii?Q?mrnBuTXXod6qJ1h0bpMDsQqepWHfy/Rm+/cQIh81dGQkv/P4fo3vdO9W1Sg3?=
 =?us-ascii?Q?X/HYmZ3659/B0Wdj3El1IyHA65oYmhfcHPw53OJsBL5klrUWr1ugN1i6L13Y?=
 =?us-ascii?Q?dGVcgPmXxXsM91essdLVEZ1zCCLOrBAsfFf6zUPzzaWLAzu1+Q9aACK+6n+n?=
 =?us-ascii?Q?t+/5JdIxDUoYIhgSDJEf9gUWUXLulvYTs2V5TA7P+imxAdKnfmtcsKNwENbe?=
 =?us-ascii?Q?HpbbpoDjybCIWlc1yIrEmvp1NRZFLG07Xc8btu1xStXVZ51wJ7tr2wW2N3Cg?=
 =?us-ascii?Q?hks2iy52BFdwSRspPawxhgFOSC7t0deeUM/7SvCey3wLmIegVWr5pU2iGrxk?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?oDi5oPgUJrCQTbIod0xAHz/+hBnNWRV7lu9ik5vImvm6Ry9mQyFKeiDR6csA?=
 =?us-ascii?Q?f+yKXA+jGyjbIS3m9z45ithMDGvCVFlFCai/p6dK9PBo3TLHnwEnavAj9Shr?=
 =?us-ascii?Q?0Gr1xsEf6goVjJG1UNxNSS8EbzoXFp+T/9EDxiQZ5NoXHeT05rBXTfWMcGDi?=
 =?us-ascii?Q?WEBOuFaIKgqzqmSbo6xHwj7/rGVYHKVB5waOlLAWGmPD53XP8uozFbY+yT93?=
 =?us-ascii?Q?MDCh+py1vgzw9kdUJauZG90IEJKJipZUlFkqBT7Zx7VyK++U+Hib5qWUQ9Cu?=
 =?us-ascii?Q?QMeUfEwm4w6efrujPDg0uCxAN2ojNuTmOhG56A9VxuM+snT8RhflVFht+JMj?=
 =?us-ascii?Q?zXYLCoK2abKfJcVuGwMQCWP198GTUIgIHw6/b1ZbfCU25dokvzS9PErFl1Sl?=
 =?us-ascii?Q?SUFGa+bzijrkc4YNvuJ5VEqEuEtb/JYfsweCAxrpp1H1ryc3eluNXJCRkiGX?=
 =?us-ascii?Q?QKW/DOidIh/Uzx3xQMGc0Lk+/L0S7Oos1Ad66Qp1XUQQyrAt8QMG2LPY02WV?=
 =?us-ascii?Q?2gpTtdAhU+CtKU71NoSPXImkdtKHEzQLiERVB8XsaUmF1L+nG3n3hvhRQRHG?=
 =?us-ascii?Q?lMW5axMa8ni/XSKMyMVfSauMUFXv2IASKJeHVGBGtI2MOEV4o/uBa69xyOBA?=
 =?us-ascii?Q?QcEbx9eo+TLkT/VU8ikRQexsuFnfBs0vzobcxmHxz9rQSsHHwQwqikujlGlx?=
 =?us-ascii?Q?J3UsNd1DxW0XuGS9CAdbngUVwEn6t7ul1x7jvvr7YmunQXgggIZATc/iVzOb?=
 =?us-ascii?Q?jeXFPCq/Ch+HoXG1GpGmEvN0xIptTMTa2IzposlI7rKaYjos3FbvI1+yF96z?=
 =?us-ascii?Q?ljSNUePdIeHghubYII+FQSP8RmBZvpzJz5GfMhsbLpUqEZLweHmxH+m57xA0?=
 =?us-ascii?Q?g6qy9/mhLe9Itb5VjLz5VLNfFHDsnE55nEVsvb8ZyBZBElWzgRyCya1VBTne?=
 =?us-ascii?Q?lJA3kL/CvyImdndUCRxXFaN3ObcG2YnyKyQkLM3sMstqeux18xQrYn0e7r2T?=
 =?us-ascii?Q?RjHlV3qn69H2n/ZtIHzGTm3ZX7sl6vdCRXN8uASdunL01+VzPeAfkDdI6zqF?=
 =?us-ascii?Q?KRvx2Q/I53JwHgALvDkiYYooGtk2S7jvr7v++nF/4L7NYwtiZKajwCFRMGWg?=
 =?us-ascii?Q?S03NoaPhZiOAl8KbZmgSYAqMKbkodhk7X+tK770i6b3ZWUAdeUgfTjl6gfV0?=
 =?us-ascii?Q?lVzj2p9vlUPtBVw01paKrSKFwVLyGliRFeixYZtsSXKjEQx33u+RboZcfLW7?=
 =?us-ascii?Q?spazaAPP9GXzlANfMb3nJb15LqbYC/nOmrp+M4ivB/YIgR7Xs2/d3BQD+HCE?=
 =?us-ascii?Q?pyJFF16GOVyp9KyIMQTPW2mv6BrcNjxxZfqehkC4nYww0F9pScGDDXE7eOiU?=
 =?us-ascii?Q?wYmYXJMHyAAZDeLQJYKxs/wis2crwrl2lcEoXZo8vduRrcX9H+RlSEtZ9Bm4?=
 =?us-ascii?Q?9zBAil5f2DM/12AFJSOx3pm8fajWsXxcgC9apmdz0PVvgeHzyvA26aguFV0m?=
 =?us-ascii?Q?ehSZxiFz0MEoQEH0fCNnTjBrXffUl++09oeQB5nhY3f1B9f8PlviqVsy0g?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcaccd5-26c3-45c4-c68b-08dbdfdcde7a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:52.2891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/ZrSR6uUGKoFyolI5aXePsPzF0G93etPoO49IN//k3lpb34xxLrfyuzuHVHWNjIU9qaS/34aBeg1h1lwTfHVongnh4wEY2mnxdli6YW8T4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: v0Hwn4KELhgeHSddVmK2RFUVBvarqlJO
X-Proofpoint-GUID: v0Hwn4KELhgeHSddVmK2RFUVBvarqlJO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel can have long running tasks which don't pass through
preemption points for prolonged periods and so will never see
a scheduler's polite TIF_NEED_RESCHED_LAZY.

Force a reschedule at the next tick by upgrading to TIF_NEED_RESCHED,
which will get folded into the preempt_count and a reschedule at the
next safe preemption point.

TODO: deadline scheduler.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/fair.c  | 32 +++++++++++++++++++++++---------
 kernel/sched/rt.c    |  7 ++++++-
 kernel/sched/sched.h |  1 +
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4d86c618ffa2..fe7e5e9b2207 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1016,8 +1016,11 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
  * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
  * this is probably good enough.
  */
-static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static void update_deadline(struct cfs_rq *cfs_rq,
+			    struct sched_entity *se, bool tick)
 {
+	struct rq *rq = rq_of(cfs_rq);
+
 	if ((s64)(se->vruntime - se->deadline) < 0)
 		return;
 
@@ -1033,13 +1036,19 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
 
+	if (cfs_rq->nr_running < 2)
+		return;
+
 	/*
-	 * The task has consumed its request, reschedule.
+	 * The task has consumed its request, reschedule; eagerly
+	 * if it ignored our last lazy reschedule.
 	 */
-	if (cfs_rq->nr_running > 1) {
-		resched_curr(rq_of(cfs_rq));
-		clear_buddies(cfs_rq, se);
-	}
+	if (tick && test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED_LAZY))
+		__resched_curr(rq, RESCHED_eager);
+	else
+		resched_curr(rq);
+
+	clear_buddies(cfs_rq, se);
 }
 
 #include "pelt.h"
@@ -1147,7 +1156,7 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 /*
  * Update the current task's runtime statistics.
  */
-static void update_curr(struct cfs_rq *cfs_rq)
+static void __update_curr(struct cfs_rq *cfs_rq, bool tick)
 {
 	struct sched_entity *curr = cfs_rq->curr;
 	u64 now = rq_clock_task(rq_of(cfs_rq));
@@ -1174,7 +1183,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
-	update_deadline(cfs_rq, curr);
+	update_deadline(cfs_rq, curr, tick);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
@@ -1188,6 +1197,11 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
 
+static void update_curr(struct cfs_rq *cfs_rq)
+{
+	__update_curr(cfs_rq, false);
+}
+
 static void update_curr_fair(struct rq *rq)
 {
 	update_curr(cfs_rq_of(&rq->curr->se));
@@ -5309,7 +5323,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	/*
 	 * Update run-time statistics of the 'current'.
 	 */
-	update_curr(cfs_rq);
+	__update_curr(cfs_rq, true);
 
 	/*
 	 * Ensure that runnable average is periodically updated.
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a79ce6746dd0..5fdb93f1b87e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2664,7 +2664,12 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 	for_each_sched_rt_entity(rt_se) {
 		if (rt_se->run_list.prev != rt_se->run_list.next) {
 			requeue_task_rt(rq, p, 0);
-			resched_curr(rq);
+
+			if (test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED_LAZY))
+				__resched_curr(rq, RESCHED_eager);
+			else
+				resched_curr(rq);
+
 			return;
 		}
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9e1329a4e890..e29a8897f573 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2434,6 +2434,7 @@ extern void init_sched_fair_class(void);
 
 extern void reweight_task(struct task_struct *p, int prio);
 
+extern void __resched_curr(struct rq *rq, resched_t rs);
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-- 
2.31.1

