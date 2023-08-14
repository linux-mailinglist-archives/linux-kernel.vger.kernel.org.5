Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDBC77C2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjHNVqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjHNVqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:46:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC66310E5;
        Mon, 14 Aug 2023 14:46:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOisO031610;
        Mon, 14 Aug 2023 21:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=O0mUkPCxgnOmWguM/rJSUhgIj/fgohRM80IPLuQiE0M=;
 b=jBkEQ1S62MTQSE/gdEn7pIEx4XstT6IkgLG3Bdv0oshz/ocg643pjeUZ6R1VgERj93eB
 CDQLUv5FbecYAKj2UFOgilg7NVeZHJ9huE/c6dbi0rgVvmAl5IIJmTfteCtEtxc/1fxH
 o7SqAbQMIFIWHxNJmYKG3qId71whCUUSDfb1ToJgxSZT/1i8GtFn/0xEUB/ha5uhUvOK
 3Db0kLmbZ0Al69ROqKaQ9MVHhKRMZJZCwB0dOu4DWIkIGHJw+NIa/8x3mGBc3eMulzxf
 IKBQFIZVYkeawWjoocjQTea7d9VA0nR/NotrvBhPZOOPuQfc8NHyblJ/89yPeoUz6B5F Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3143ngv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EKjD7R005544;
        Mon, 14 Aug 2023 21:45:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2ce13x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKEQ6br06pBz/jB3DxZ9fSiORoxJQgAjTH5dXLLH/YT1LPDpKZkn+haqGzb5YSm9cSB38LrCJ5jszFvh/Fk1BayOABTLTdWL9HZKWvJQ7JcOCeW14BpKIplCWEeiEtOAx7hyFSDB3WhYPgZXENVfbIrAFEfxr/nHimo4Ii5zglrZazYvG8dQTAH+EV1E+t+QzkEZJ+fxoLCZfURlokMRdYYwlD9t1VvD2VAzTpfg5kiB/sJuZmQUhMDT03dn4QuJIAbqWI5m8JdapUS/XMh15y192e8ZX4fJZudDM3G7hJpGfU8tW3RYXGxQRve5zo8SGONjEmqmoqLfC3HSN610mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0mUkPCxgnOmWguM/rJSUhgIj/fgohRM80IPLuQiE0M=;
 b=BIus8lqFSUeNn8gvtP7r8eeAjwMUVzV81IEUuiG0GUaBCJIJowXXncH3/AlwjSN2/pzsVGnfhtG1fkgu7BHN91fOiNWqx8tf2cGHU2EEa9hKnDAyFZyepmfAEgUeDMMRxr7cbqhbCtPKv2kO24pYCDRF+2v0zEU+kR0BiJYM8GYIrfmHEr8Bv/V964K8ucCAGrwx8KhZHpbQ1ddDoK8jTl7Efxk6pam2QPwIKJ4sPE3x3cf86UhrJ0f/IGn8qZkIdR+K9HjtzxhZsXWIu62sIqxEaOH/jtKZbkGK5JAUyroQ5+ETyorSBdMzOS11eHuxZv97XtvHnwtl7SEDb0XCgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0mUkPCxgnOmWguM/rJSUhgIj/fgohRM80IPLuQiE0M=;
 b=cAqLFVddYcM2tQ9Ha8XAYtc9q9iqBQppF0foQArD9wTOQNmtwEVBgCtrNC4i7iZYDL7aEkQyjj+2PU11Tlb35PXVZS0I8KRbxMORg+RkRUdYIZGp5mRgmTwEEZ0aL8UIOWnAYX2KoQ+HFpmy+QGUO37FIEkW556ByAdV1/bFsJg=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6222.namprd10.prod.outlook.com (2603:10b6:8:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 21:45:06 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 21:45:06 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v28 5/8] x86/crash: add x86 crash hotplug support
Date:   Mon, 14 Aug 2023 17:44:43 -0400
Message-Id: <20230814214446.6659-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814214446.6659-1-eric.devolder@oracle.com>
References: <20230814214446.6659-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:805:66::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b6f035-d433-4264-2b49-08db9d0fb914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qY9Xa0Ed15Zk+3MV73sFfCCFJwzdA5NUunxBQmunmMrqRumlF+nWbE+mR0YsfotgzpiGvQ6lwv9gUMJnwH59rmdhWI5Dsny0R6fOLcHGRDwOxb7S2exXmHr/a4G9wcH8Rr3MEfo/8+VVMJuSPudIRpfmq/zW7lrbhsX6yabH0gF72YJLDOXqbBqnERu9FSAGA4uzbCZjo2b1VO+xmHyrp6XutbpH0CjwYQhAJpQYcldRAsS0mdVLZS5CtsGDlrXFT7XQvYZ136OBkxJnQrRQD8V5gCE71Sb0ovSrnKMDb1Kl0z8SFfuIvQwoJar4Lt0Jd+U4YbgkiG2xKK0oFxGbQWwh1FUJsZEGPcyKsI8iOOC8e0232zwJgGCw19ms2aFwIuivMhm9UVffFNLIMscgoWAoWqgb4+7YuDA1kl1j2gd5vMbBEL3hFyfdzitS0JHWURD7hWMPFYnomqjv1m3bONymCxMti0BJgtJ7hDW9E3XK28nE2LCUfluqQQmLfbhzFlEEqkBwlfFaLtsAR/AR2xZgVeZ1BpuDW0v6R5wvdfTNY7PAJerPFcGl9R9Lh5AKOjQRsRuOtwvZFbH6gkHeSmI8GBSjlBA0YJ1FhU7AfI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(83380400001)(36756003)(86362001)(41300700001)(478600001)(921005)(66946007)(66476007)(6512007)(66556008)(316002)(8676002)(5660300002)(4326008)(8936002)(38100700002)(2616005)(1076003)(107886003)(26005)(6486002)(2906002)(6666004)(7416002)(6506007)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8yDGUE59JxiaqqltMk4NYcHP4QNQPSE3woNnqepOlaU+NT3DMv52EI33NsP?=
 =?us-ascii?Q?x1/ilmjzaxSDx/J1Kvo9LUeCwbW7cD5a3wjCPTRFd53sC/+ANVM2m2PHHJu4?=
 =?us-ascii?Q?SnAynuqaPlgetbR5fMWWw6z2Dz+NbxLOY+lK8QkMmfe9d7J9ssrcjJjPbqb6?=
 =?us-ascii?Q?QtTu64PZt1frIo2eyWl2OHKUfDVDEKHneAL1gHOXeNTlMOsXHtvcg0gzIawK?=
 =?us-ascii?Q?6iexwPD6T3XocKSdT1sUSJhGFZDdcaBxpVOrpRhlLci2etcLk3Un15SRQsYd?=
 =?us-ascii?Q?Xn3+UXuzxAzZRY11MGerA6aVFR2prSrZRUqN7+57eEaUoLxoAyN1yGAwHFab?=
 =?us-ascii?Q?r6FkV1gegVHBHy4o3dPlqbUu/YwpE80U6cfSGaJ2+XibdDSLgT3+fUmU1o/S?=
 =?us-ascii?Q?OAvuBFBpfc7e0/64DUhe4UUIN02yfzzmZbpEhs505FFyBMH3wRhQUMUSlMAj?=
 =?us-ascii?Q?Mo4gM0+rdU9wLcNPefltbCTBACOzqcwegoBJt8yZ8DCJ9RT1Poh7tzJRMzhS?=
 =?us-ascii?Q?PmRrnqtIgJmfY+Y6OvLMDyDrHstiQ4gMKi2coKL/1nP2rsYtCH2HcGTzN9nn?=
 =?us-ascii?Q?joH4NkKOB587+pdgOHLmM9TLNeA4E8BpEXJGo6m4txQuaaldHWmotBcIhRuV?=
 =?us-ascii?Q?QO1D+15afKlIz1F+LjNZ3HjzFiB1TMVcEFy9i14BnHBg7Jn6mv6D2yKFRQBH?=
 =?us-ascii?Q?d8VK78F/Uko6bU4W4SSpZ+YDiCoxbHvHKGjEC5ozDKVhFvCOhkicCFwT9+5Q?=
 =?us-ascii?Q?aUkbUg9fHfYWVDWXoib5h7mbhwshMEOk+C5qleh8GPgoN+Q3va6h+tohQBcb?=
 =?us-ascii?Q?f2/fotMxJYIn1OxgguDsU7QFfmNjVLZ4V+1PbkN203Cxamxe49vbgXpgTUlj?=
 =?us-ascii?Q?35AgwJMFlFA4tX62VQk95aAlSU5n7BnG7uce0YFt9+O2fmJJ6jdUEoCU+SKI?=
 =?us-ascii?Q?IhNnTgy/kB3Nm531P4e+lgiecWX7CzsGfIzqyVS8BbR/Bfyvfz/yqkAA6f44?=
 =?us-ascii?Q?Ka+Dx0ukfau4i1rjtdMjEJzy/wJdGN8G3/Jy6MPBTL8oq7n2Pz16wYe+W6sO?=
 =?us-ascii?Q?6dOV00yswv+0sna19fah8Q6cdP1FGU3vZXb+e14KWRUL8iLTJY+KL7HKpqxo?=
 =?us-ascii?Q?uDNchQtUj5C1DJfo/D4WLJI6kYldFNDZc/VeVf2nVIovmHYmZXxX4tyV4eFT?=
 =?us-ascii?Q?4H9iglmjxmxh31iI3cTs4Q5KjHLnXbGq+GBmrUuy9YN4thOXZr7f15qwHnKW?=
 =?us-ascii?Q?3EQn9pr4kViVS6GyuxeSJGLSC/EYx/tnZpvj96WVcPaDRKT75B08xsxMs0+C?=
 =?us-ascii?Q?kgkppGgQFviQZElNd+jYWBuy6oEfX4Kh0vAdMEaD12v22DaDVNIPSAWz8s+4?=
 =?us-ascii?Q?EWf6lR4OszuGm866kYGxEas85qtdqfCkiPxW7Lnhd6bhl0CeDYoaRKeov7jW?=
 =?us-ascii?Q?walw3hlDqGf72Y7/uDC7rEDi6Dl26W3e4PrrdqtI8QBvBt0pDeTGKL4fm5bO?=
 =?us-ascii?Q?GNLtDr3rxHqFo28GzuutxaSA4ETauD1eAnbIBSyPdrKc+5vns1PrNcYh8Uso?=
 =?us-ascii?Q?9u/gHn3f0RpGe7Q1fJiF0kL9+QCrOTzDtwlY1G1hsANxIZoWrHdmu97pyntb?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?aveJD6jau9exhmrO4SwIWtPfhb/q/Kd+ZIf4TI4lyasiqfpx8q/IGmXhldgN?=
 =?us-ascii?Q?eaAfbUrGPKNl26LIRK18dni0KkkDpoCfepa8DuhZ9ER1xNw94rPE1qbdotQZ?=
 =?us-ascii?Q?Ibrow9Kf6QgnhjiH7J3omi0Rc0LNtt1S3id3i2OEY62UCmFsZxhQ6UaV24CF?=
 =?us-ascii?Q?NPQZ+qyUr4lE6ZgO5Jvs1i3oPZiOoOfMgYnGKEY1ueKXp6/vB1ZWCoLu3Ev0?=
 =?us-ascii?Q?74tnmkGYjSm5lc23ZfW3vBhbn39LE2zZH4M/ALVPlHn6VHJP+cBj5KVr07aj?=
 =?us-ascii?Q?bujgnnmydGtN0Nhe033qOhfXLtFb5lbTkYpJsJlHiGQ69/A78y5GgcMMfxNy?=
 =?us-ascii?Q?73/hxFWGbBQVtYIQDy4yXdaj8Xt71MGmGE/jQqSxtSdJ0Gro9lxlarGP/eHT?=
 =?us-ascii?Q?Sa6knyxKVOoZXvgS3H45lzhJwjYOLcoE/bfwfd4odaRQ/IaK0SW/XcGVNz4U?=
 =?us-ascii?Q?upEhZmaP4M1EkcCZOo+civpq6AksvxAIpbD9rSKBVvlNQwVDW9SxXWpomC9F?=
 =?us-ascii?Q?Thkic/kVcGltLRAcRRHKt+MCzqhrKJtK1gNl4s8XlLnEUwhqSfJiCWAoybWQ?=
 =?us-ascii?Q?FEJwiGrm2ychLfpY48qpipgZNdSIyOVN7eh11xLILLDhxUjPCwftej/aPv7I?=
 =?us-ascii?Q?fbND38/4Sio0714SRPuucaiilrJpweuEXPZadwxHvV45Qraf0AMT1hoIupSA?=
 =?us-ascii?Q?A5xMZuy4qpS98O0N2LoTAjYRGEe5VJod8fobWuuqnb1Y6mlEPVS8VvYsxFs1?=
 =?us-ascii?Q?bOqYkY6LaY9eL5WgKyHH0I8EOM3N5rwW+NMzKPJXsUcg0gmkLDhEVaHA5I57?=
 =?us-ascii?Q?ZyVtoeD+2UIPV4oycs7qK3aBnKZofj0U8sUsjDBXJMfAUtQ+pRYjByR/k9wr?=
 =?us-ascii?Q?xqZiHJ8sgao33+Dyw1y2S6rVPKmrgfR2wc38HgIrRD+Crlr0kWTxtpbcZsxP?=
 =?us-ascii?Q?s6FXukliuNoSfOl65KhX8UneHJIVdLT8MXo791pZACYiLJ+2bybZtT6RvLTt?=
 =?us-ascii?Q?TKNiixJcmZW2oLFqKrvZ1IJyeScjrxtZufoXReI6KVRZtPOqrRBQJfRYYOq4?=
 =?us-ascii?Q?EFFNYWThKoST9TaP/3lc+qKJP6R7b1SmwQZwSbUtgjzzrrLEqz9lTy7atnv/?=
 =?us-ascii?Q?sN38lI8sEHIR28aErCxa2r1Zr5Nb3OqYTujvpEMA/f/4P65r6Svy9PcCz90W?=
 =?us-ascii?Q?vxHXOkTAlJ79l3XGQjVzL6ui9W+tlUMEi4FVOlySnzAzs2HuIewOSZiCn/7t?=
 =?us-ascii?Q?+0FbqPjB+G7s7svIi0rngPstMUGNczxvycZrNRBK1K7wbN4m9S7F0rR67ZMk?=
 =?us-ascii?Q?ljBexxwkFFkPgE3MVJ2+uNHY9fLMlSQAp2YtpCcGehFzUFcFjHQo9Xno2d80?=
 =?us-ascii?Q?NrQicZD5WerjKK74wsIrqpXStiMUhSPBrcLOrE9qGEqCLibQhabaKYOI6l8U?=
 =?us-ascii?Q?aVAtTLYJ1F0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b6f035-d433-4264-2b49-08db9d0fb914
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:45:06.0381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24DVlpf7eygh3G/UXNEUVL/D/lhbeEM0/jYmdgVVrSPLo/t7XcouxJofvEwJp01Yzej2nj+T40oe032cyA83epokUQcYL8Y+6Qj3XLZzsG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140200
X-Proofpoint-GUID: HffFPV2tcL9v2MzmdViVkwBNcnW-r4Uy
X-Proofpoint-ORIG-GUID: HffFPV2tcL9v2MzmdViVkwBNcnW-r4Uy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, or off/onlined, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

A new elfcorehdr is generated from the available CPUs and memory
and replaces the existing elfcorehdr. The segment containing the
elfcorehdr is identified at run-time in
crash_core:crash_handle_hotplug_event().

No modifications to purgatory (see 'kexec: exclude elfcorehdr
from the segment digest') or boot_params (as the elfcorehdr=
capture kernel command line parameter pointer remains unchanged
and correct) are needed, just elfcorehdr.

For kexec_file_load(), the elfcorehdr segment size is based on
NR_CPUS and CRASH_MAX_MEMORY_RANGES in order to accommodate a
growing number of CPU and memory resources.

For kexec_load(), the userspace kexec utility needs to size the
elfcorehdr segment in the same/similar manner.

To accommodate kexec_load() syscall in the absence of
kexec_file_load() syscall support, prepare_elf_headers() and
dependents are moved outside of CONFIG_KEXEC_FILE.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/Kconfig             |   3 +
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 105 ++++++++++++++++++++++++++++++++---
 3 files changed, 116 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7082fc10b346..ffc95c3d6abd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2069,6 +2069,9 @@ config ARCH_SUPPORTS_KEXEC_JUMP
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool X86_64 || (X86_32 && HIGHMEM)
 
+config ARCH_SUPPORTS_CRASH_HOTPLUG
+	def_bool y
+
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
 	default "0x1000000"
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5b77bbc28f96..9143100ea3ea 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -209,6 +209,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cdd92ab43cda..4b6cebceec68 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -158,8 +158,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_FILE
-
+#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -231,7 +230,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 
 /* Prepare elf headers. Return addr and size */
 static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
+					unsigned long *sz, unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -249,6 +248,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
+	/* Return the computed number of memory ranges, for hotplug usage */
+	*nr_mem_ranges = cmem->nr_ranges;
+
 	/* By default prepare 64bit headers */
 	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
@@ -256,7 +258,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	vfree(cmem);
 	return ret;
 }
+#endif
 
+#ifdef CONFIG_KEXEC_FILE
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
@@ -371,18 +375,42 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
+	unsigned long pnum = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
+	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	/*
+	 * The elfcorehdr segment size accounts for VMCOREINFO, kernel_map,
+	 * maximum CPUs and maximum memory ranges.
+	 */
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
+	else
+		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
+
+	if (pnum < (unsigned long)PN_XNUM) {
+		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+		kbuf.memsz += sizeof(Elf64_Ehdr);
+
+		image->elfcorehdr_index = image->nr_segments;
+
+		/* Mark as usable to crash kernel, else crash kernel fails on boot */
+		image->elf_headers_sz = kbuf.memsz;
+	} else {
+		pr_err("number of Phdrs %lu exceeds max\n", pnum);
+	}
+#endif
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -395,3 +423,66 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: a pointer to kexec_crash_image
+ *
+ * Prepare the new elfcorehdr and replace the existing elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long nr_mem_ranges;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+		pr_err("unable to create new elfcorehdr");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (!old_elfcorehdr) {
+		pr_err("mapping elfcorehdr segment failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1

