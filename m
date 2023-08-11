Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73077795D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjHKRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbjHKRIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:08:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A188C19F;
        Fri, 11 Aug 2023 10:08:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDVqjG003568;
        Fri, 11 Aug 2023 17:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=WFw7v7cjxpNNgU/vF/xiNsFjyDrsUC6p0fWgxylqC5Y=;
 b=TrBNtMguIeErKsCeheBg2kb7kchir7gKfI/QR7NFG+rv7bOdT2ZdXlYlRjW9iBboj9tj
 kPErylJZJaFISA68Ba4S9jA9YthFoFUZf/v8dPOnLnhOtK94t8jynYA/6UEwJFgyfEX0
 I9sZitvmz/mVcq+cM+V6mO74uSSm2DekN5mP7XE8bpwg2Q+cmzt97anhKHV/Yq+Cxrrm
 lbaVRjAubEEgWVPE8c8ZEa5XOu0AuW2vRFDvl/RnpKNI92WopEVtVU+o7Na7yqB/KfeJ
 m00jyqqGLCkuu8W5f0gCphxmKbahm6XkXfT9afq1fqMVhKtocvG06SDq6lQWB13VzfyM 0g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y6hf9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGO9vL000381;
        Fri, 11 Aug 2023 17:07:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvgj05m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu3vIlWncefEwtHGhnthPpPkg8Rqs1gOp5aF8z56UGvWV79+zb2HU8Iy1bugfLHKS3CTaMTfIhm47ZVuBjxzueOiiEJ4M/K/9ZtS08yFbtk0i69OQXXA7OWBIvwkAHxC5bs83txOVu61WvVmcXUJDK5L3MLKYOfuDgwAzNx9u29pcVo2licgWxYpYZAswx4MMOPCQ/dd++Hw9gnJFti7cYuo2IcvvoWnFqzRU0TacoH/FB7KuTgOotS2XHvhXljnyPisUyyin2geWFOSdjGF/4LxIKmaj94D+oAHigbnUhEPtX+Ol4Y0PVVyCyqA7W+r3jZJvQRwV2ZrwUkSdw4mIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFw7v7cjxpNNgU/vF/xiNsFjyDrsUC6p0fWgxylqC5Y=;
 b=PcVKXtTLGbXTkZ3PgV0+Ujye82lvF1qa4cQJ06B1nfc1R6XY/YSCfIAHfZMNWsqMB1cvvp+veaQSvPJvvWVjEc/LZLMrIlQQqWTsPXN49a4NX9lGG5KWBvEIe5gHPEnuK/QlcltADNRACBQDxDRI8rdMptQMRDfoptrwcA/dfOEJ8Ns/1MDRkQolu2lUO/8YnGVQe897T7C58HSnxq/tgAoW2k+z978VlkU999/+OP5YiAkP7RFKZddOdKThVxxJuMAE3UbHxQEIFKr2zIbu0X948MqgEfGJXF/73fMzeEh04D1uCDYWhr7kfHAIYDIaLPypf9MGp5H0KI9FGw4HNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFw7v7cjxpNNgU/vF/xiNsFjyDrsUC6p0fWgxylqC5Y=;
 b=qYYOMBYJ4sMspvcGFiI6D9YECgNgUbK4XIHzwg9+HZc7Dp3jC3yoHuQibFVlnG+YBi0dyYItSRyu65Cp9ojVVQoiWg+aj9Nx6rxRJavhRcjIzZ2tSrnp335pGvrWlaHPNMa+7S3FXqTRHCkrRMMgicr2Uv9keWi8EQcHGQF+XG4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:07:07 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 17:07:07 +0000
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
Subject: [PATCH v27 5/8] x86/crash: add x86 crash hotplug support
Date:   Fri, 11 Aug 2023 13:06:39 -0400
Message-Id: <20230811170642.6696-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230811170642.6696-1-eric.devolder@oracle.com>
References: <20230811170642.6696-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:a03:333::24) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: ac66a6df-9d44-4741-dd30-08db9a8d6478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bYUxZv0AT5ZNNq+8IrTOM6Q0qjfJcZ4SAWKkdAjHeSA6fWOUNc4+4XUZk842jZn9RasFdqCP23mMDwpzmvdgGx1DsU4UqncrDqACFpiipG6wd4oMNMjddP0qrKhaORFp9bPfEZkPrmXjwBrnW3u8yPsSPmuWPOM/rBGmT2/bitRBYca7Gm/aWqQVRnUlBD8Ao7LFSWBZw0foOeKv3a8xOvUcDTmAPPvAvbYBqqS8YgKwM+AHVyPKfYAeKXNajHNMFXsKA/N7AIoIUaechQ/wjw2cMObk6DP1ycPTAD4EMaC17yq+bIJajmRDRqqN3NkTJ7wThQVlle1h8LOoAbcLtk6bcpujRt57Q4e5OWgv/n3RXMh+3SPWkqEXk/h34v5kRxjPBcIzug0AC4sAsQDY8LcdgUyKA/9VR3czCOrIs8ZZgLimwLaMJNSOJDvdawWT92v0v/kXht7kEhx+JHrLfoO5JSVuNL6doVwpBOkHLOGXlG4q9u8ldKtVfwUt7ihEe3IhtNplMSlRpckTe5LcVjbIOQo2fTrwo2HmIE2Ei+J55yxw2rgRoE7+xboneQM0dtY3lTqayqoZyChrVhW3xwC9r2IZGDOkwd0TmBspMl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(1800799006)(186006)(6666004)(6486002)(6512007)(478600001)(2616005)(6506007)(26005)(7416002)(107886003)(2906002)(1076003)(7406005)(66476007)(4326008)(66946007)(66556008)(316002)(8936002)(8676002)(5660300002)(41300700001)(38100700002)(86362001)(36756003)(83380400001)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rwTo4uvCobBpSt63e4HT+TkAlVZ1TClEcN54qb/Y8QpABJlfDhzKdZuph4ad?=
 =?us-ascii?Q?21E6nP/nQZpZD7Q0wdM1b9nozYu95PMUNfGtY+lVh/qhw2C0SBapkkqWlV6s?=
 =?us-ascii?Q?1jzGRnoryYtmO2DAUlupx86NfWmIbEVBTblxqeXaxR4vNsUT7DVboBLesMmY?=
 =?us-ascii?Q?4Q9V/xwFxZpo+8sSPnb44kdKAH0YNFo9MA0ZEBfHxa5vmlthj6lXi58CDZLv?=
 =?us-ascii?Q?jygJKpYAzXoiEt/813V1szqTsFwVrdfeQwpAQUAoj3v1WkkQDnNiB+5FTuRY?=
 =?us-ascii?Q?ALTU4myicW+ZYmBFLEvZzWjNjDC6gnIePQWP+7l5vf3zD4hYealfNx2FM5Ef?=
 =?us-ascii?Q?hxlw/8Srv9L4qLTSY7fTJMA8M+ZpuUj4zhmGOyJhGGJ6xWExXsncu9Eaq8cp?=
 =?us-ascii?Q?iH5K1RstwMRu5/i1SZm1niVKb3cpPXiVz8BmxMgFQZ6gcM6Xle9rNL8e0dT/?=
 =?us-ascii?Q?odIxiO1j3H4glX510OmEdaI9UVn90C4k1C0CbOm1AGyMUH4xAxn6Xzpl/ZL1?=
 =?us-ascii?Q?0PxUjYyc3q1BcxRC/APHaFOF2F5u2f8DIwCLxeShrl7k3EkMT1ZW4IJqlr4S?=
 =?us-ascii?Q?LeuCgpNxSADCVexqJF4KmXSKUjhkB0c7RNZr/z07J3fs8qFGjz1kYklxM8gg?=
 =?us-ascii?Q?TtkQCl58Krg1ntFV6aCoDUTRRFfKWvgwJ2BG2qtVdCMflNXFaroXYidVZ19m?=
 =?us-ascii?Q?qDXHdXg5+rQ9QlcxFHkvlHfNtGwbeEgHlwPRhiSDxjSV+JTlrbd3G6U9NVgR?=
 =?us-ascii?Q?nWoHsy/2BksZl/hpoPlYf0AwO0MdoCjiQHG/X5EBU8dmPwGocCZQYFZGSyXZ?=
 =?us-ascii?Q?2+6bKf78+wz84lFJ2uLCBJPPMpBst7vSyUL5H9qGrgWn+kpc/gLnQge+zBvy?=
 =?us-ascii?Q?KUiaVDWNCmEqxgGN7OmUyMs7SnLnsAloB5YQYsP/QS6pHMpXIdA7CwoUmu9X?=
 =?us-ascii?Q?fOKz5vAv9pvcPHKPTJzPzvFeULSOA7vXh+RbyUqTZ+lVYyxT7XZq0EsqD3hO?=
 =?us-ascii?Q?aV8yU6D0EgB5a5xBjseio+u/MO6qQlHxgPz+y7eRF7s6zOP8IVUbn63U6Cx7?=
 =?us-ascii?Q?NzeMJ1p3hVorY+RFt1djOoXjpdMryA2AN6x/S03i7h3rQPVUGux2QNh5+XGa?=
 =?us-ascii?Q?Sw9vXBHSpn3tmMd8U/s+UvA7ac+skxf/sc4YWKxfFANAOoIUmnBofVE/yHAB?=
 =?us-ascii?Q?qqIYG9UVmNeqW+5t48ripAYmb+uoDUxQQHQQcTKjtq+X+0FgotgKjMKO7Xf0?=
 =?us-ascii?Q?X21Dv4/erht1ysV6eydRBYFvQCVr9FEA9d9hFzpB9OsbeT4rKXA844HOzxt9?=
 =?us-ascii?Q?KoAFumIWNHk9ET2Yoqd0TPMZH8OTPU46w54A2T9t1NZRtn9Tvs7VZl9nJhC/?=
 =?us-ascii?Q?OvmpyRkqvcYwNT3R4gE/oP1R6uZyyyq+b+750eiA9g0ekxUWNWFXdSrXlWT2?=
 =?us-ascii?Q?tacxFLweNH4bRAu62PIeWz2tO2VDy3UhNqwi7gf0vM89My/r2mLheK8t543z?=
 =?us-ascii?Q?tKIDu6XjE2eUz203iq8gr9FcwG0RXLDkrhnsgVt6JR818vEBUWuca2KucinI?=
 =?us-ascii?Q?Vop+iB3r8s+ex1qw02Wkb+pCB/h5bYxi4cKcQdwiop+m7qN0V2FhiUvVNkcv?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3glHA5BJg02sj58qSLQ8T8j89oUCnszyaMAup94WHP5Xcr0UOcCO6GC04r24?=
 =?us-ascii?Q?KS0wZDlVcB7snj8F0GqFvawGhXPiLLX82yMWZqGfly7GP+iK2F9yfIq2GUru?=
 =?us-ascii?Q?BNgMHIDsraZpMp0CSNqRrXIjl6s2Y1rLcU76Pwvd5ccXy7Blx69MDvYds0it?=
 =?us-ascii?Q?wswtrjADZIR4xNPdqq+8BFptOFR0+vuhRcvTTe+f5ryW88JDkwjYwGhYm3k/?=
 =?us-ascii?Q?RLx6mxJPdbeavoa0Es1ujC8vW8OgTV7+yqtRXriZzCh5kAolrlDCsRN51lSl?=
 =?us-ascii?Q?fFzQjb1t9Mga3KUIcQiFkrwGEFvN9fDqZnZpEZyY9w4f9A+4dcFhlaJgN7VC?=
 =?us-ascii?Q?nJ1i7deialBnmnz7KfpHK+AnIjP9PVbl6gmCxDug4fm8+2p0+LgJeVaXLtZY?=
 =?us-ascii?Q?7pa5WoKbmZs7rj2PkuqZ35l9wYzZkuiBz8gQi7PRL74pwktDL9mMYlaTcRN8?=
 =?us-ascii?Q?6OS6nwUnpg5/3FhzYh/LuB71oM9IqNlBbZl8Ssx84U7cpvPhhmipyJAAOs+/?=
 =?us-ascii?Q?I1rxuc+rAb9c7bpWrmCbHMHZ+H4xXBZdvlj7HRf46+GZIxg8HLzDveYg/9fq?=
 =?us-ascii?Q?AFaRR0jmon41ma5Dvn8XAjq6H1Y3jYevbkj14pHc2R7j1nqk2uxRp7WjdN7g?=
 =?us-ascii?Q?andvWZJFkL7fPGxY7Cd5P0KqIDAXO+pkHQmUfe3hoPlmknNvnS8beUUrHXzj?=
 =?us-ascii?Q?Di46REBJZbReMHWV+vqCovnImXVWxQmBNRFzKtyMHEeNG8iqRxTSdFi4x8X9?=
 =?us-ascii?Q?6qp6tD+vDY6dKOvsQx4soot4zNGCAHfsaVSq2nhXGN6fa0fMrhJQzVOMrJkf?=
 =?us-ascii?Q?gkKbB/+ibRTGtBOYD2jJuvTKPYeou6op/TgG91LPV7KIi8kMyWsUfCv7PkF3?=
 =?us-ascii?Q?w0W9OGxyEnJSnKQPSgZX+R4AMAPdyLpM33PCTLlEJgz+bOMJRvAPxVzOUNXM?=
 =?us-ascii?Q?bjc4Hk4xThBbU1hl8ZY/ZX4Ca7snOnb6YQRr5SaONlWaBYah7cWCEUMP/INy?=
 =?us-ascii?Q?Me3bwMPiNDjt7hc3OPSWU3yNxa9guNdu5alcWwlcU4l5+JMF353vYArRlyAq?=
 =?us-ascii?Q?QEkMJQVemRiDmfk+NN94g9LX4g7R2p4EzwfAQkJdUyCaaLrsU9nfUnleXeH+?=
 =?us-ascii?Q?+f7M/u9VqZnGzbYikBCKqCBn0dbNSzbH4HCAbSC2z6pge/jOO4m0NLav6yDG?=
 =?us-ascii?Q?7sOiWh6S2ZZCQNQnZFJZaeJ7OjoIlkL1a3z/Q+XgTubuHRGBm8vMw0JyFtTX?=
 =?us-ascii?Q?BY2VtxfIYyfwMV+IONN/wWO+Z45CJ/YSZjXUqwKG8uCtUbUUVpo2GFNgT6hj?=
 =?us-ascii?Q?rNrTn5CpjtoOezd8M/00iBuFwUGZXQn77/pyCNYn0TEiAVgBt+2AlFfIYT2j?=
 =?us-ascii?Q?tZzr/P7yWm8y3nDtxxO+Mf+AH9oYTNaLMRA/GaAE7cJ2PMcwGehCufzjSH7M?=
 =?us-ascii?Q?xwP4NmCVa88=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac66a6df-9d44-4741-dd30-08db9a8d6478
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:07:07.2687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1GVLwGTLgYB+6vGKnDalxyoPgG1glWFavfwT9mKaL6CheAUiiKd4iGD8rdfaFW8pA6xME3GJwSMVU1Cljmdpi5ZptkzIEu81uasbqEueIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110156
X-Proofpoint-ORIG-GUID: ZnQ-vwuO36tRcFB4bwYwLnINuuKUf3BA
X-Proofpoint-GUID: ZnQ-vwuO36tRcFB4bwYwLnINuuKUf3BA
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
 arch/x86/kernel/crash.c      | 103 ++++++++++++++++++++++++++++++++---
 3 files changed, 114 insertions(+), 7 deletions(-)

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
index cdd92ab43cda..c70a111c44fa 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -158,8 +158,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_FILE
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -231,7 +229,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 
 /* Prepare elf headers. Return addr and size */
 static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
+					unsigned long *sz, unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -249,6 +247,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
+	/* Return the computed number of memory ranges, for hotplug usage */
+	*nr_mem_ranges = cmem->nr_ranges;
+
 	/* By default prepare 64bit headers */
 	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
@@ -257,6 +258,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_FILE
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
@@ -371,18 +373,42 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
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
@@ -395,3 +421,66 @@ int crash_load_segments(struct kimage *image)
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

