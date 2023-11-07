Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1847E4B40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbjKGV7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjKGV73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219AF10D0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:27 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJLxa004012;
        Tue, 7 Nov 2023 21:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=aqpiam7KVLCZXip4Jboq2QxVkPHTcXzEkkF/s5Hqh6s=;
 b=RzlfS5hSf+58LVf1NI2QIWlXj+bd5f65WQonYFCHn5ow7G1EAeA185JyoYkUNd7cURSl
 +cNArjXThbXr/a4mmhDLaBkqVv9u/S9llI3kZuaHgt+5Z+6KAygI7/S7f/CJRAuIm0Ko
 6AqqXBI18GxsOlF2MC+zSMIZWWTmc8CfYbUWQI6GnZ3L+TWomUGsJd9npXT2sEP+KmOg
 AoXL4V+6fSCz27qG/rQ+2sN/PURuw+V68w+VTZb3xLOuqJHQ/JmG3LTcSo7GSVYQ8Tms
 8V54nTvSo4COTmVM4BMBsS+H2KqsGyS4+8M9S2gQHZ2l1+4yznj0kVlAHbD/TEB/DoHe uw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIrDO003912;
        Tue, 7 Nov 2023 21:58:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vsh7b-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbw8QNTx+bdkwgXG2FudQzP93KpIywLbePzLdwwoUqyzzyiAHPEqYWlOPxn5WUbLs5rkMV/9ZsGf7VWAgYaM61K7sPUKhfjEYlKlnS45t9WIU6TQ1jPprueY1m9dGtZX77LD68grzt5vz0qfCEH/e5l22a7bAKwbldojDbi0++oMYQoxTeDCaR4cqTNUY/cR8u+KI0n9UUuDx3TILXG7V/EbMDO34A5V3fk37g1GKcv7tTkQ/yl6DrUu97LEn8/A1dYLtEa9JbqwQd0xtgDlCB9TTOJIOlx4ADy4yweKQiFrdPklQskPf7+KoZgPfcV21r257svp4hT/IhmUMaQheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqpiam7KVLCZXip4Jboq2QxVkPHTcXzEkkF/s5Hqh6s=;
 b=EW0wBLjdzcjujjZfh34Qk6NRHFVzVwAZCTha4pctzXGAdwTAnbG0uezweOqeOaRcI3X1IoK6/SBFFsaFeYUVJ1GHAfD0lTnVlVEbwjwbf2wz6noIR1gbBHP2joijb7/JBI8cR0asM8v6YHvwALBzKH4vyseL0VmssEQ0oYl50JTnlGpTBXW0bHJ/6+3cx/W0EegfzG6NB1YD3GQpvn0YbdXDJn6ydYoEaHMQ+7mTBots3w4HHPTOksaIFDqf81LCw2ok5LHVg2gUZ1AYljoPEVJzAsOZgfYBZ2YlTyC4x4AvLASx4AF27O9io92X0mhe42SBNibZIq4O4EjCbbrgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqpiam7KVLCZXip4Jboq2QxVkPHTcXzEkkF/s5Hqh6s=;
 b=g4eAHpGKVfQ+aG2Qb0SZo/5TSRSFN6NVsbbhIDVnkO9/OyVtqycSdoYMoNg7OyMEn9LmijOrUuNO2meVxLe/pM6c21BsHpfDVqFxP7eiRft2PQX6YarQDRV9uYg60luijDa4v7087jFPg1QE0bKfEcnwweP9IHRAzpEbW942Puk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 7 Nov
 2023 21:58:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:04 +0000
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
Subject: [RFC PATCH 07/86] Revert "livepatch,sched: Add livepatch task switching to cond_resched()"
Date:   Tue,  7 Nov 2023 13:56:53 -0800
Message-Id: <20231107215742.363031-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:303:2b::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 62cb8e56-03e5-4f73-ca7a-08dbdfdc9e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FC6ZjGRUpRWeE0+BDpZb2TuA8ETsaMzfnq52j2PjZC2eM7JnwApLZnijNrSu6v8VpfISp5X/KfTAbeqh6BZX/+rmkWJoYMbd3HUV7T+4N7G3lPqdRJN+dsyeKyTpzE0vwODFcjItgtMsLCLP1VBa+wOKYwgG4789J00dgn21YF0i1ZQDFeY7E3e/Dbev5nd+7v4oYYVeOgyYh2fILu/7yhcjelUMo5VLz48fr6i4XmLJcVd/xDHaXspt5THLHnUcemFnSgPzNtK868FZFfWP3nni3RgpVo50W1bDGG0OqWeRMWAigI0/3Ya8pfaPs7/uef5WicJMcJd6vLpWQkjaY+NlwRq+EpEiGPrFcBk7LrP5YDExTYYCYdceHrYlI4OArYWrd1UI/KpzBd1evBfTI0Ju0UFCzST7kiTPbMj1JhoORAAkr8/GxOxyNvbOhdv16ZV0N6mbQbFcCgP+TvAexHkK/YSFPqAiSGCyhadyvocju1GAnDSFKvSa1a/pKkOcVlqU6iZWxL5/Xq+I970CiZrsy5RMdUtONNfF1zbLhnGbhMii0j4bAa0yXhNR61AW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(30864003)(6916009)(41300700001)(66556008)(66946007)(83380400001)(7406005)(7416002)(66476007)(316002)(478600001)(8676002)(6486002)(2906002)(6666004)(5660300002)(4326008)(8936002)(6506007)(6512007)(26005)(1076003)(38100700002)(2616005)(107886003)(86362001)(103116003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZLUBV7Y3FPcRbMvAnZHuAOqj2xpuEB9qlDmWNF6UAe50mhEWs+WfCfKEXK/L?=
 =?us-ascii?Q?KqHG8XyPnPjdWB2v27NB3LDko9U6jiy3xCRu/C2Y8JHYkX6qOsUhh0yo2F0f?=
 =?us-ascii?Q?Ork887z/EAPZq2AbjfYF1JhnbeoVOU/92N7Kq376xgc7M+XFSgCwWLVNttDE?=
 =?us-ascii?Q?iTq8gzAqeJili27KBNzAg/TTDNWLwgzRdpzh7qitEc3sD+eI1ToUVRLKtqVf?=
 =?us-ascii?Q?jnbrb86pgNt+85jAhwvMNe6Lm6CGLzXBwQdHlN3KgSx4ZzCrzPB5yLUhs7nl?=
 =?us-ascii?Q?eVdiSALeu51xBgjWe0G28rjybJQQPrlxdf2h8fh5NqCJQcbinbDD4TRuxqjl?=
 =?us-ascii?Q?i/93SigHrhF3mWoQnGoV3lOTW4v4divCYqWehy4L8lbSrfQRWVYAUXVEvcNr?=
 =?us-ascii?Q?Dk9vwaSZllPdUsRcgdYlHufU91fWUZPuRsSRZC3qgvJVjcUjCC/uaSNkBBEF?=
 =?us-ascii?Q?gg/RgBNZYNW/iK2jo9nhWseAY9nhfl+gUZ/hQZa+F5s4VN7qH2UbDnSyKhWj?=
 =?us-ascii?Q?FHVI5QaU3C+fVQaPXPuh0LhHwegqtscj7gz8MiYzLE6GvdYb8rhb9SnJ3Zdm?=
 =?us-ascii?Q?EYbme7YsgKmdg2y+HhTbKeO42M5Xpz1mxm+GHih+/Fd/3BvLqmaK8QgZ0u8d?=
 =?us-ascii?Q?lGxnlQSBEka2j0lubooCX6VSccGHFJCePkqb/h6HWbwQ2L6Nm65dserjgz3B?=
 =?us-ascii?Q?h6jJxlkZr4XgQ1HAmu0dkv4PR9Semz2UmPEn8vQ7eBCZbpC7q1CXu7QDxdWE?=
 =?us-ascii?Q?VjSRtWfDBtdvnvB6QlgZrbkVFG/Qx7Hl/fHuLOuJY+dxm36fvNnNvlxclZ9F?=
 =?us-ascii?Q?YN6lzJdT1Ep8QJLE4SdFP504lzAVj0pJcwtNKXD0EKJdddsgCAmzpdEVocHy?=
 =?us-ascii?Q?KPwRQKBNIbeX6vWBZndzo0VZbM5aYPDKkOfH5Lx5e36qJtFmj49JCMBqxKbq?=
 =?us-ascii?Q?q00ya9zbu1dQ0a4z2zE96C44EJ2tl5jXSq41ygC3eTRYcONRlCmKXcHB7/2G?=
 =?us-ascii?Q?MfvVAVvbJJoYjpdZ7xNK9+PKfxjVrHLKfi4JkGx4m0mte8zgFSAY6Wh2nLp6?=
 =?us-ascii?Q?CgpLNexYrFJoxo4s79bMhdaBhlvZQekK0ROJV6rB6giFo+k99nYXaJUWElau?=
 =?us-ascii?Q?Oe7PijfCFtk0Us26A4DTKdLSDKlpOtE8CxELUqAgmcFxcdEBWovxAuMku/PX?=
 =?us-ascii?Q?M5bc1+fpbOc75gLEQRWgNBgarnO4S52z1UAK3h4IIeMnXJMAe1Q9hvlg6d+a?=
 =?us-ascii?Q?UphdIR5V0ee7vyqqKP0WHALR8jJoI+gzXqbgZq2AN1/ve1n9wcUfYogQU0ZY?=
 =?us-ascii?Q?kZSGctXlI6/eIdwfS3xShG9uH3gToSgB4X9Z3riVnJn8IccJ2STymHm5bmaf?=
 =?us-ascii?Q?C9rvqwEszA9Mzw1KT0LIGSKqNkOa3Q2g6DSJ+xXh8WZD9Tp2RrsHfBFj0E+P?=
 =?us-ascii?Q?ZmAH9aPjD7DcK466HOvSngTazPGP5LlJnGI0yLVGr2ixp/8KwK04uCUUFCfx?=
 =?us-ascii?Q?R0WSNhurcSjLjK6QIb4rBGPVoyz6UZdeqfoDRd0a0WrN07eWTFu8ecibQU3u?=
 =?us-ascii?Q?7atRVQO0OU0oHJUpz0UK7GlYqy4Lu7bOR1/ktMr7zWx0gHaQrDGlLPIo2X+X?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0RvvU9tOW6I5PNc5jaD0RAdmu7RtOvD4Q+R1Gnq08UcXB4cc9BLmkapDepxV?=
 =?us-ascii?Q?ZdfbKjKZu/qlQ5qoT4UX5ifuvSlmQ+kq9davAZQXCvF15PKxXf56PcPivxFA?=
 =?us-ascii?Q?3yM/v4qbIMOQd8EygxFYRu8T71OmjibCv8gPonCzXoqavfqNZWJFPWLFfek8?=
 =?us-ascii?Q?85yhI0Ko+qjXXv3Wof+GwlaAbPqKEm5DlwvFIsxTdxq3Q2rybWnYVEo4o+Y0?=
 =?us-ascii?Q?dqa2nRp9VRf3m1B1rukBf10suLM6mOVwDfp78NKyWJNTSfLePHYFKN4FI14G?=
 =?us-ascii?Q?7dvlqEHd7SPmlLeJSTiR8RSlOLE09zZ3JfUdCYkWohwMDvkrjzLlYjdTwEwQ?=
 =?us-ascii?Q?PZzCNisrOXHhMAjx3DDXyZzhVYbDZakguNC7HV4m7fLsc6D+QlBylLABq7Jt?=
 =?us-ascii?Q?2FSNO5sY5UW9CfvPNdbwKnn4w0WGsn9K2wSJKPOT7IZHO2FkZuvXKFX9GmkP?=
 =?us-ascii?Q?klVCE119VCoqKqq/ngoN5AZfUj5N/F0/oX5FneWQNDVy1pOiXxSfEjFLQewa?=
 =?us-ascii?Q?Hyk5AVWLZVbfAzzeoxR86VTfg6j6DcUbYIe0GpAHMsgi5Wdu2jYJI5dRpmSQ?=
 =?us-ascii?Q?qQZk4E7DzlnDaSbzDdLDnTAKuWxHMrOsCLYNurVaMHcBikGDSGQDDJ11+GUu?=
 =?us-ascii?Q?2Z2tLVqM4BIIzlcj6vzEOkv1ddMcMRMQR7ZNIZe5tFMX+Ud5O7FAQg3E8uZN?=
 =?us-ascii?Q?rrGvPQqMQokwXQ653ka4KpbPddLu71YhE64egfoKVsMdee0o1oXlivHhD1Iy?=
 =?us-ascii?Q?hM0mMjO1O8FoiGwxHrjKOm/KZptfCJjt4fBs4c3s35ccI4oZIDfYyp7z6Zyp?=
 =?us-ascii?Q?ubHIZ1V38teFhuGlivaFwL5/xLUJHKGCdszEksSIKmcUsXY5aIcdbDCphm8P?=
 =?us-ascii?Q?NF+DOienKYSjh89Zu8NphPkc4QabeCiZem00pt843vTUeIHCYVngYWGzShWf?=
 =?us-ascii?Q?7WHU+GM39TzXe36F/3I+14MfEorOJzL0N4kVwqAahbiEpsmgYtB04dyu5Eu0?=
 =?us-ascii?Q?9tndepjOVB25sVUqIVW7X+ygAOPTXhuA+9TeSmM8pn3I0HS6J8AACezS9kYN?=
 =?us-ascii?Q?6cghnHB3s4y6TdyW/SAg6P/MBsvTbCNqaRWsZW+Tn7LPxxlCVEypbJO5KYva?=
 =?us-ascii?Q?OD4GmRV/hLWt96W9hggCIuOLBdbF/P8lj1tMnZ43xXiqf45tnyYwrBdsG1Qe?=
 =?us-ascii?Q?/6l/U/+gVv0POqt44XlCH6y+JIL2hBD8caeRJKDwsWjwz+0wC7wbmr/dDgSq?=
 =?us-ascii?Q?AOfypKXkP4pzfbHdbN50q6bmBOEQROqrajMLCLWhbamRgQ9AkWTMtEeXydjC?=
 =?us-ascii?Q?shk0HlZF1MNIRSTHvSvZooIx7SwfPpRGpKWCAniiq5pAmG1k/p2kqeaDksyk?=
 =?us-ascii?Q?vvXpprf3UcW3MPFu7fpHV2v5imtjY1IEiZArb/cOOXmXqOksdCjpZXd6vNsS?=
 =?us-ascii?Q?8BV9zgUbMYIlk0sDgwibCBWbw/eP5c+IpCyGbHNDMbtuc7kR4OttG40uOdr/?=
 =?us-ascii?Q?QqVcM8YXHCkac35V3GN+EdWySTnvHtrr9V//xSF5EDRRfr3y22HcgKYXFQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cb8e56-03e5-4f73-ca7a-08dbdfdc9e2a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:04.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDdcixOLTXDUqKm8+r5cG7Ukv3JHr7mbj8HYucZco3CWng7lx/wLIeXa1bwnmdOrDafdXZFoU+O8cjY9pd1w9jMmk2EGcqI4gqxgwdkS4ZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: UIWDsT_jDuRDMW7nX4qj_3oFk79q-zts
X-Proofpoint-ORIG-GUID: UIWDsT_jDuRDMW7nX4qj_3oFk79q-zts
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e3ff7c609f39671d1aaff4fb4a8594e14f3e03f8.

Note that removing this commit reintroduces "live patches failing to
complete within a reasonable amount of time due to CPU-bound kthreads."

Unfortunately this fix depends quite critically on PREEMPT_DYNAMIC and
existence of cond_resched() so this will need an alternate fix.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/livepatch.h       |   1 -
 include/linux/livepatch_sched.h |  29 ---------
 include/linux/sched.h           |  20 ++----
 kernel/livepatch/core.c         |   1 -
 kernel/livepatch/transition.c   | 107 +++++---------------------------
 kernel/sched/core.c             |  64 +++----------------
 6 files changed, 28 insertions(+), 194 deletions(-)
 delete mode 100644 include/linux/livepatch_sched.h

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 9b9b38e89563..293e29960c6e 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -13,7 +13,6 @@
 #include <linux/ftrace.h>
 #include <linux/completion.h>
 #include <linux/list.h>
-#include <linux/livepatch_sched.h>
 
 #if IS_ENABLED(CONFIG_LIVEPATCH)
 
diff --git a/include/linux/livepatch_sched.h b/include/linux/livepatch_sched.h
deleted file mode 100644
index 013794fb5da0..000000000000
--- a/include/linux/livepatch_sched.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _LINUX_LIVEPATCH_SCHED_H_
-#define _LINUX_LIVEPATCH_SCHED_H_
-
-#include <linux/jump_label.h>
-#include <linux/static_call_types.h>
-
-#ifdef CONFIG_LIVEPATCH
-
-void __klp_sched_try_switch(void);
-
-#if !defined(CONFIG_PREEMPT_DYNAMIC) || !defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-
-DECLARE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
-
-static __always_inline void klp_sched_try_switch(void)
-{
-	if (static_branch_unlikely(&klp_sched_try_switch_key))
-		__klp_sched_try_switch();
-}
-
-#endif /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
-
-#else /* !CONFIG_LIVEPATCH */
-static inline void klp_sched_try_switch(void) {}
-static inline void __klp_sched_try_switch(void) {}
-#endif /* CONFIG_LIVEPATCH */
-
-#endif /* _LINUX_LIVEPATCH_SCHED_H_ */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5bdf80136e42..c5b0ef1ecfe4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -36,7 +36,6 @@
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
 #include <linux/rv.h>
-#include <linux/livepatch_sched.h>
 #include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -2087,9 +2086,6 @@ extern int __cond_resched(void);
 
 #if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 
-void sched_dynamic_klp_enable(void);
-void sched_dynamic_klp_disable(void);
-
 DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
 static __always_inline int _cond_resched(void)
@@ -2098,7 +2094,6 @@ static __always_inline int _cond_resched(void)
 }
 
 #elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-
 extern int dynamic_cond_resched(void);
 
 static __always_inline int _cond_resched(void)
@@ -2106,25 +2101,20 @@ static __always_inline int _cond_resched(void)
 	return dynamic_cond_resched();
 }
 
-#else /* !CONFIG_PREEMPTION */
+#else
 
 static inline int _cond_resched(void)
 {
-	klp_sched_try_switch();
 	return __cond_resched();
 }
 
-#endif /* PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
+#endif /* CONFIG_PREEMPT_DYNAMIC */
 
-#else /* CONFIG_PREEMPTION && !CONFIG_PREEMPT_DYNAMIC */
+#else
 
-static inline int _cond_resched(void)
-{
-	klp_sched_try_switch();
-	return 0;
-}
+static inline int _cond_resched(void) { return 0; }
 
-#endif /* !CONFIG_PREEMPTION || CONFIG_PREEMPT_DYNAMIC */
+#endif /* !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC) */
 
 #define cond_resched() ({			\
 	__might_resched(__FILE__, __LINE__, 0);	\
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 61328328c474..fc851455740c 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -33,7 +33,6 @@
  *
  * - klp_ftrace_handler()
  * - klp_update_patch_state()
- * - __klp_sched_try_switch()
  */
 DEFINE_MUTEX(klp_mutex);
 
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index e54c3d60a904..70bc38f27af7 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -9,7 +9,6 @@
 
 #include <linux/cpu.h>
 #include <linux/stacktrace.h>
-#include <linux/static_call.h>
 #include "core.h"
 #include "patch.h"
 #include "transition.h"
@@ -27,25 +26,6 @@ static int klp_target_state = KLP_UNDEFINED;
 
 static unsigned int klp_signals_cnt;
 
-/*
- * When a livepatch is in progress, enable klp stack checking in
- * cond_resched().  This helps CPU-bound kthreads get patched.
- */
-#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-
-#define klp_cond_resched_enable() sched_dynamic_klp_enable()
-#define klp_cond_resched_disable() sched_dynamic_klp_disable()
-
-#else /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
-
-DEFINE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
-EXPORT_SYMBOL(klp_sched_try_switch_key);
-
-#define klp_cond_resched_enable() static_branch_enable(&klp_sched_try_switch_key)
-#define klp_cond_resched_disable() static_branch_disable(&klp_sched_try_switch_key)
-
-#endif /* CONFIG_PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
-
 /*
  * This work can be performed periodically to finish patching or unpatching any
  * "straggler" tasks which failed to transition in the first attempt.
@@ -194,8 +174,8 @@ void klp_update_patch_state(struct task_struct *task)
 	 * barrier (smp_rmb) for two cases:
 	 *
 	 * 1) Enforce the order of the TIF_PATCH_PENDING read and the
-	 *    klp_target_state read.  The corresponding write barriers are in
-	 *    klp_init_transition() and klp_reverse_transition().
+	 *    klp_target_state read.  The corresponding write barrier is in
+	 *    klp_init_transition().
 	 *
 	 * 2) Enforce the order of the TIF_PATCH_PENDING read and a future read
 	 *    of func->transition, if klp_ftrace_handler() is called later on
@@ -363,44 +343,6 @@ static bool klp_try_switch_task(struct task_struct *task)
 	return !ret;
 }
 
-void __klp_sched_try_switch(void)
-{
-	if (likely(!klp_patch_pending(current)))
-		return;
-
-	/*
-	 * This function is called from cond_resched() which is called in many
-	 * places throughout the kernel.  Using the klp_mutex here might
-	 * deadlock.
-	 *
-	 * Instead, disable preemption to prevent racing with other callers of
-	 * klp_try_switch_task().  Thanks to task_call_func() they won't be
-	 * able to switch this task while it's running.
-	 */
-	preempt_disable();
-
-	/*
-	 * Make sure current didn't get patched between the above check and
-	 * preempt_disable().
-	 */
-	if (unlikely(!klp_patch_pending(current)))
-		goto out;
-
-	/*
-	 * Enforce the order of the TIF_PATCH_PENDING read above and the
-	 * klp_target_state read in klp_try_switch_task().  The corresponding
-	 * write barriers are in klp_init_transition() and
-	 * klp_reverse_transition().
-	 */
-	smp_rmb();
-
-	klp_try_switch_task(current);
-
-out:
-	preempt_enable();
-}
-EXPORT_SYMBOL(__klp_sched_try_switch);
-
 /*
  * Sends a fake signal to all non-kthread tasks with TIF_PATCH_PENDING set.
  * Kthreads with TIF_PATCH_PENDING set are woken up.
@@ -507,8 +449,7 @@ void klp_try_complete_transition(void)
 		return;
 	}
 
-	/* Done!  Now cleanup the data structures. */
-	klp_cond_resched_disable();
+	/* we're done, now cleanup the data structures */
 	patch = klp_transition_patch;
 	klp_complete_transition();
 
@@ -560,8 +501,6 @@ void klp_start_transition(void)
 			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
 	}
 
-	klp_cond_resched_enable();
-
 	klp_signals_cnt = 0;
 }
 
@@ -617,9 +556,8 @@ void klp_init_transition(struct klp_patch *patch, int state)
 	 * see a func in transition with a task->patch_state of KLP_UNDEFINED.
 	 *
 	 * Also enforce the order of the klp_target_state write and future
-	 * TIF_PATCH_PENDING writes to ensure klp_update_patch_state() and
-	 * __klp_sched_try_switch() don't set a task->patch_state to
-	 * KLP_UNDEFINED.
+	 * TIF_PATCH_PENDING writes to ensure klp_update_patch_state() doesn't
+	 * set a task->patch_state to KLP_UNDEFINED.
 	 */
 	smp_wmb();
 
@@ -655,10 +593,14 @@ void klp_reverse_transition(void)
 		 klp_target_state == KLP_PATCHED ? "patching to unpatching" :
 						   "unpatching to patching");
 
+	klp_transition_patch->enabled = !klp_transition_patch->enabled;
+
+	klp_target_state = !klp_target_state;
+
 	/*
 	 * Clear all TIF_PATCH_PENDING flags to prevent races caused by
-	 * klp_update_patch_state() or __klp_sched_try_switch() running in
-	 * parallel with the reverse transition.
+	 * klp_update_patch_state() running in parallel with
+	 * klp_start_transition().
 	 */
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, task)
@@ -668,28 +610,9 @@ void klp_reverse_transition(void)
 	for_each_possible_cpu(cpu)
 		clear_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
 
-	/*
-	 * Make sure all existing invocations of klp_update_patch_state() and
-	 * __klp_sched_try_switch() see the cleared TIF_PATCH_PENDING before
-	 * starting the reverse transition.
-	 */
+	/* Let any remaining calls to klp_update_patch_state() complete */
 	klp_synchronize_transition();
 
-	/*
-	 * All patching has stopped, now re-initialize the global variables to
-	 * prepare for the reverse transition.
-	 */
-	klp_transition_patch->enabled = !klp_transition_patch->enabled;
-	klp_target_state = !klp_target_state;
-
-	/*
-	 * Enforce the order of the klp_target_state write and the
-	 * TIF_PATCH_PENDING writes in klp_start_transition() to ensure
-	 * klp_update_patch_state() and __klp_sched_try_switch() don't set
-	 * task->patch_state to the wrong value.
-	 */
-	smp_wmb();
-
 	klp_start_transition();
 }
 
@@ -703,9 +626,9 @@ void klp_copy_process(struct task_struct *child)
 	 * the task flag up to date with the parent here.
 	 *
 	 * The operation is serialized against all klp_*_transition()
-	 * operations by the tasklist_lock. The only exceptions are
-	 * klp_update_patch_state(current) and __klp_sched_try_switch(), but we
-	 * cannot race with them because we are current.
+	 * operations by the tasklist_lock. The only exception is
+	 * klp_update_patch_state(current), but we cannot race with
+	 * that because we are current.
 	 */
 	if (test_tsk_thread_flag(current, TIF_PATCH_PENDING))
 		set_tsk_thread_flag(child, TIF_PATCH_PENDING);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0e8764d63041..b43fda3c5733 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8597,7 +8597,6 @@ EXPORT_STATIC_CALL_TRAMP(might_resched);
 static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
 int __sched dynamic_cond_resched(void)
 {
-	klp_sched_try_switch();
 	if (!static_branch_unlikely(&sk_dynamic_cond_resched))
 		return 0;
 	return __cond_resched();
@@ -8746,17 +8745,13 @@ int sched_dynamic_mode(const char *str)
 #error "Unsupported PREEMPT_DYNAMIC mechanism"
 #endif
 
-DEFINE_MUTEX(sched_dynamic_mutex);
-static bool klp_override;
-
-static void __sched_dynamic_update(int mode)
+void sched_dynamic_update(int mode)
 {
 	/*
 	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
 	 * the ZERO state, which is invalid.
 	 */
-	if (!klp_override)
-		preempt_dynamic_enable(cond_resched);
+	preempt_dynamic_enable(cond_resched);
 	preempt_dynamic_enable(might_resched);
 	preempt_dynamic_enable(preempt_schedule);
 	preempt_dynamic_enable(preempt_schedule_notrace);
@@ -8764,79 +8759,36 @@ static void __sched_dynamic_update(int mode)
 
 	switch (mode) {
 	case preempt_dynamic_none:
-		if (!klp_override)
-			preempt_dynamic_enable(cond_resched);
+		preempt_dynamic_enable(cond_resched);
 		preempt_dynamic_disable(might_resched);
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
-		if (mode != preempt_dynamic_mode)
-			pr_info("Dynamic Preempt: none\n");
+		pr_info("Dynamic Preempt: none\n");
 		break;
 
 	case preempt_dynamic_voluntary:
-		if (!klp_override)
-			preempt_dynamic_enable(cond_resched);
+		preempt_dynamic_enable(cond_resched);
 		preempt_dynamic_enable(might_resched);
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
-		if (mode != preempt_dynamic_mode)
-			pr_info("Dynamic Preempt: voluntary\n");
+		pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
 	case preempt_dynamic_full:
-		if (!klp_override)
-			preempt_dynamic_disable(cond_resched);
+		preempt_dynamic_disable(cond_resched);
 		preempt_dynamic_disable(might_resched);
 		preempt_dynamic_enable(preempt_schedule);
 		preempt_dynamic_enable(preempt_schedule_notrace);
 		preempt_dynamic_enable(irqentry_exit_cond_resched);
-		if (mode != preempt_dynamic_mode)
-			pr_info("Dynamic Preempt: full\n");
+		pr_info("Dynamic Preempt: full\n");
 		break;
 	}
 
 	preempt_dynamic_mode = mode;
 }
 
-void sched_dynamic_update(int mode)
-{
-	mutex_lock(&sched_dynamic_mutex);
-	__sched_dynamic_update(mode);
-	mutex_unlock(&sched_dynamic_mutex);
-}
-
-#ifdef CONFIG_HAVE_PREEMPT_DYNAMIC_CALL
-
-static int klp_cond_resched(void)
-{
-	__klp_sched_try_switch();
-	return __cond_resched();
-}
-
-void sched_dynamic_klp_enable(void)
-{
-	mutex_lock(&sched_dynamic_mutex);
-
-	klp_override = true;
-	static_call_update(cond_resched, klp_cond_resched);
-
-	mutex_unlock(&sched_dynamic_mutex);
-}
-
-void sched_dynamic_klp_disable(void)
-{
-	mutex_lock(&sched_dynamic_mutex);
-
-	klp_override = false;
-	__sched_dynamic_update(preempt_dynamic_mode);
-
-	mutex_unlock(&sched_dynamic_mutex);
-}
-
-#endif /* CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
-
 static int __init setup_preempt_mode(char *str)
 {
 	int mode = sched_dynamic_mode(str);
-- 
2.31.1

