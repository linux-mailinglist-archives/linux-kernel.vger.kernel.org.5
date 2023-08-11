Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EE97795D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbjHKRIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbjHKRIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:08:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E666730CA;
        Fri, 11 Aug 2023 10:08:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDLQYa006209;
        Fri, 11 Aug 2023 17:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=lgaJD46QDEz0RB7w0/dNRKzErz6jXRofjGW9vyWRddJDD9FaaX+zeleeJW6fLOVfEVUU
 0NgNaycxd7MDwOe8g6d1xXaGB3ks0fk0N2NHQIpK+juT9I1MiQfxc4RHULkWiqjseiu7
 dTbJ1rqTaoAjs6Cc47whaAmCufpCMBv/yq9JJdARLERHZ+rgx5t2AB539sJgsxcnRyCe
 Z1BcjnF+cXhfdghnrNg0uXFW4OrZ1KSsu6CyrMSNGaN7rXpY3oy+SeQTC0nhi2eCbOoK
 dEjV9Lrckx996wDUfadjIpkLFifApDKcqGqRd6BeqTdgOdW9+uXxSEx58DzzYtQ1JHo6 4A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y49gvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGPJGk000435;
        Fri, 11 Aug 2023 17:07:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvgj0bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY5+AYyFPbYTtNecgDP6xJTM4gf2PIYBTe2n3GHPNupaeIY6Thu10bVoKgjVpXyhqNsevexc3kKN/Vi8gtGhLX3F2Q+knrksFSRQhwd+79Qm5/vffLNdrbawDHiQGAo/PgAxHBMgxSaNaDn2NGDDUpfAlJYIbKlEKM2oZgh5pEQiKnkAA+iha6UIw65Mpq2NhEvbgBpdqcdb3wT6f9fYa+qkasWic66rX26ReZ5CX+dTsEcwrJeJDKKkn884bRq2TcOykBAKTRjXzm1KTDJ28w5V0J7O0DbvjdUXoBDH8CeZFtKI/CTbxOC0Eaodke3hgKt3XDCLxzK9SP7KVCGO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=TcqVRGozPK5rhWd1N8K/QbnUyjJNLA1elXO5gMPgTN7rt//H4pkHXOL0OHo97fe/HpCvTvW3+dEUrE1vdMzgM5NJnq0olycox87RrVcLycXT+wrpx8HieEoEQMpFBqiswwKA2XMUgm1h9lrztXMCfzpnk/E2UShEnVAfAZGWTTG9yjb1z0BXo3bgQ6x+WhDaLIp0zIk/G9hzri/O2NTQf5HAy0+3cq99CbFrdHNHNW9Is7XP9KUKEB0Cc8j6iI4ykKger5W5NI9xnQI5zpMZBJpM0gFT3lsGuz/8TTYiza6hRIlGAkLWj2eN/TB21oI0cKL8v1cjBknSl98MJgC1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=t8um1F/Kzv8Z2nUFjy7LAw6DG7+V0l/V8QjymYBgVC4TLp8JN7g6HWdg2LnoiFIwNxuxb2EK1iNThpdnuh9uhZoUZp648DfQjPnbYl37DEqBPJF57N9mb50xrTT3gv+t3N2OdccAOcbfY5BUjYvYdhKrHe7acVr49ucmuH4w87Q=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:07:16 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 17:07:16 +0000
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
Subject: [PATCH v27 8/8] x86/crash: optimize CPU changes
Date:   Fri, 11 Aug 2023 13:06:42 -0400
Message-Id: <20230811170642.6696-9-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230811170642.6696-1-eric.devolder@oracle.com>
References: <20230811170642.6696-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: be543831-d258-4bed-cdea-08db9a8d69e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NbRgzrbLGIerVN6TYYHzfBQMU5KwxuUdhVTdm6MleaFOrO/+Tpn7fk3yoTTeb3ggCDTa+dgHlT7ULRu6kNzU221haocJO5K7jIJsx5W+QpV/dj/WFoF9FMdJwlXiv7YyVV9Ba1+75cPmFz6YO864sLmmn7uCbnQy0Pm1ERrOl3eu5MzV1rORPHlHIHS1stQyB6LL7ATan+5ng+SR+N1QIlZiK5kb9fbfny5Ry15q79+tcSG1xVybkeIV/KDE4/5RIbAtaXIXbJeDHBiJaxhMRnAVeGrpP4YE3KVPag//RktqjA/rMh4L8orhZFR+dMMIIJ+a7mDt69EFdzF76Q0WJvNfbePL+fXFNsGA0gF3/0IH8RbqALnYZlVTcX4p4Goeej/ndm8mxAuUoh820mbM33P3VqvQt7QUlyFD2WMRf0oefXmnsZJwuMC0nGCfKqmxxFfANayv8asN2gjkAh2PbjkZqHOtk2zVITl987mk3m3IOPAXuxrpmoLRUEYF5wRg+Cws1LrymFnAgWnMBVzGJHsfz+gcfaqc8ZaYPdqPlsbRCvCWZjOwjOy++om0h7PZ+G7MDCggkm1F4GrCGwtdQ2HZnh5USedBqFPuc36L7YA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(1800799006)(186006)(6666004)(6486002)(6512007)(478600001)(2616005)(6506007)(26005)(7416002)(107886003)(2906002)(1076003)(7406005)(66476007)(4326008)(66946007)(66556008)(316002)(8936002)(8676002)(5660300002)(41300700001)(38100700002)(86362001)(36756003)(83380400001)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rXmUMaZyptWiNWWt6YqcTHzWlQvQPeY5OqIDG4BtYojjk7uS6PeDSb+0WO2l?=
 =?us-ascii?Q?jlele7kieZpLm0LtduwmXVaI6eVrukHdjcq31FrICmgrxcKNMFQocmbuBMvM?=
 =?us-ascii?Q?yeMJsqsyDYaRFzs/ZO4TCmali2gPVYsbwFnJdl9Bb3YCX02Svv2G9Yqk8bdG?=
 =?us-ascii?Q?n9Jet461kz+J/A2J2qTMKrIGj5aMWeAEi0mD/NYDm4uQubQDrlSORY3V9BY1?=
 =?us-ascii?Q?zmnsOz8Oe1bApvjjbozkLzfgDGVjLxs90kXkcn0Sm2RzJoaRHxvzSpqJaMLs?=
 =?us-ascii?Q?kl35J6lpaJSN3mDNOfgTXyd2KedTiNojlonZ4+Wz5MTIMegUruxJCsrEWO+w?=
 =?us-ascii?Q?YmHUew8pvBQ6P4PPf1ifwKzMKjugVXw/45CZInIE33yuvNQAuuwLu7kd1eZv?=
 =?us-ascii?Q?YS6i0Vex3M6VYhUB8YWGWKCJPnBhumutFDmLfb0lEzoyYWlEGc/k5gHdljda?=
 =?us-ascii?Q?8Bo5bDfzPE8cdSMpwFWxYCyekaBJc9lTlc+ztD77HBI2rbdlmJ6yBNGo9NGq?=
 =?us-ascii?Q?R3ad5XYFRip+UvByeHLzKxOLAs6gYK4wYa2gP2/9Md9CrofDNWwinGdyyGYD?=
 =?us-ascii?Q?4R+sIPMe5qUP6/nlHrO9KfZwsa0dEhMi2Cq6OVixjcl8mNXTYPesiolUZII5?=
 =?us-ascii?Q?UWmIy8kOj7bme7Kop3iR0fm2UqGbcsAX7r0GTumEyV5fO7Irx0EX4Tb/gPr6?=
 =?us-ascii?Q?sBHlRiauD/T8Aj3zpJ+Q2/QLCoDPnkzQ1oRXLynK0dRPmTGYKl9Ps8PrkkVo?=
 =?us-ascii?Q?M9zDEzDRFjb3AJa0+nVcOQIn6CpxOLhJ+7rc1juHkOL5oj+58lq353mLwUKQ?=
 =?us-ascii?Q?zKyAFt/tAMiR7URLpycCmROI5X4b8UvrMP4xQMIUnQ9h/f7av5tgfTtMONP+?=
 =?us-ascii?Q?G6Dmj25PIWfyOp1P0iCxykTRbwzGSNhfnUs8fy63j+ujqmNxtWvTEKufeJdJ?=
 =?us-ascii?Q?19RaNvwWVSeN4fKm3g4n07A4hN45MrBWZ74jfGUh7mBixeiEebAc51WquOxl?=
 =?us-ascii?Q?RkjMU5U9LchW3mhVNR8nJ56uaupw/E6Q2Ow/FspYph1KkScbL6sDXrsHG+eg?=
 =?us-ascii?Q?oKZkKw4K4drCxcMcdJ4yCMpz1f6MZ5kizQ9fNEqVtIC8vw25gh0aWmiEmmdo?=
 =?us-ascii?Q?kpfJZmGWAP13P2zq+vSn4+J/kN8sSp7v4LR2HSr4iMG50IlCANh5xJXas0aa?=
 =?us-ascii?Q?i0mGWpL752GdiJq65XFAR+8tNLh/tk7kSagvIM/7c7CaeWIiNQKC7PwtNOn+?=
 =?us-ascii?Q?aajJ8euregJQTNnYgejmD9Re5X2bs0r62EHVItGwHOY3wkYF/hdcC1C9giEn?=
 =?us-ascii?Q?hPt8pbSXgJBv009VrHuZxBcRDAfEveRgNwEELKtOEdfmeU6EYFf6xH3JuYz+?=
 =?us-ascii?Q?TjhsHxuEGvwEjn0ysl6/SpUJdR82Tf7smBlMDcgG5U/DbrHU9/Vp+kRltSIA?=
 =?us-ascii?Q?CaDz5yMdasDocXo1WVl3KhO5OW+smHUBvoObNiccLtLYPpe6scI2e6Cwkpgm?=
 =?us-ascii?Q?/wsU0XB1HMy07Axb14WqhjooAEtzsXJ44yHgWq7W4KH1790LMDO0mltLElzE?=
 =?us-ascii?Q?0CYfKv3BYkEVo4E7FwJeU9L+byqKbK2QCLnbyRJqolIJUWQOTGdFNTY+R7vq?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eLo7UagzOAD/PCxcQ/ReIJkX3TN5ybBAwgzMroMCZCdKtomPNYt2ApNY7vL+?=
 =?us-ascii?Q?w/lYvGon+U+CO19wmAuwSAXd0pouJYpuoYJFmztlKq8+t2n/dS9jx+JfoLBS?=
 =?us-ascii?Q?Ixl63d2p/Z6O0LeZSxXf++4PzihzzGe0Z0k/Vbb62Nndg1J0lx5KAWVmTKFs?=
 =?us-ascii?Q?sEXUudahWWY7mdV1ka4LHhRGX7fUTVM0lbyJbDV2/+F1jQKgUS6q7pkrXMBR?=
 =?us-ascii?Q?htiliqtD3sQcdN3Ybmhq6k6m79z8RIK3/VuEePRXh1F50EOWWzF6c9eZfRTE?=
 =?us-ascii?Q?aRMcsqxxaN7Hz9M5mzUQTR3FP2gYHaUuk/RHoyqoAyqHhXGlyUdKr/51M6GM?=
 =?us-ascii?Q?GUXDYyVuE9G+4AHktNeoY7HNJRj4sDPLmhCJEKNIjueNtYNKgeHUrZPUFKLU?=
 =?us-ascii?Q?F5W934dEgJIirpA2w7XIv7HUyQKzoYFLwg+Z4Q2lo0eIaNUH6gVkLUTHcOQ0?=
 =?us-ascii?Q?z1dj2fBBrwJG6fXf25/5EuCtEgW3iR8XOV2zDfrZXm46s7Kd2hTL/tP7vfBv?=
 =?us-ascii?Q?Vo5uL/H09x7VQ2fvEuEQU+DdmCNnTPiDMZI4rLbJWUFEx8f1hZ1v1cb1dEpm?=
 =?us-ascii?Q?Tx3+9yxJdZhr/C1c/662d8mD/FwAXcOHcmlxhuQ15IPt0begd9lShWgD0b2t?=
 =?us-ascii?Q?EGzyQnMSAkVS1b3KHWXbOZBO3N5f6iB7Ui8BJIpcpdltpYRX+kbK4Le/r8EY?=
 =?us-ascii?Q?/MCuUXTBHJUIBAA5dZo5PdpJ1/oLHVCqsKDhQBkrSmZyJlb08vhfiQaIhk+5?=
 =?us-ascii?Q?gu7v5BhcUnqNcEWt0iSM9Hp5+wR/zs7Cxf+BkGMYTTxlb0DhI2V0Ev7KKe4n?=
 =?us-ascii?Q?jyTLJ8by/6cC6pXz+8XZbMzoU7uned6hZ7YQI+zcxumjZV1rXnf9ykmUeq8q?=
 =?us-ascii?Q?TVpE1g05hZz7IrswsaNQitXG90CHUyjyedNpyuoUyamdHfBTxH700az4r5tB?=
 =?us-ascii?Q?DGr6VC8bM732shz0cw3dRHFEk/5DOq9h/HxwJxuIE75VJXrazuOQ/GTkRuUk?=
 =?us-ascii?Q?38JRpITvVss13wmoeq5LkSeB7vGQDyGwfYRQNFq52YblXhTNW3ya5twz/cAr?=
 =?us-ascii?Q?yU22E6V9PCF+vY5S5GL1tn34l6HMbzlGDvVAmXcqOHAJ00sS6Ce3hjGAzmL5?=
 =?us-ascii?Q?MoaGt1ATRBoEuY8VsdYEik0oOYxMeyzkrH3lsA3TweFIt1/3j9rCnbesFxKq?=
 =?us-ascii?Q?lxJ2/9R8C/6vTu0hvl+AM91Tu9ZIa7DakUz9Wrl0OKhIRwn5aLfsTKh+2Dub?=
 =?us-ascii?Q?UfxnAayaTDqo1psg8MDe6+gewB4O1CcY3aezi+ahMOFCB5VIUAu19S30YTSY?=
 =?us-ascii?Q?+MT+gLE7Y1Srpcai4hLgi344kbLHdVMJ1hfArZmjM8SX5gvtWcaPKDlhO8ZY?=
 =?us-ascii?Q?LXEEbcoRjb4AyAyBlwRnZAU91sQqBBy/OMmXpD5qcKlmj9rpoiNG57/9wy5F?=
 =?us-ascii?Q?TNdTNwpJe2U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be543831-d258-4bed-cdea-08db9a8d69e1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:07:16.2956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMvqRlL+7lr8IMQhNSnolQEElqjhZVEFv2OplbAv9e5X8IKdeVSPJ9ZoGFWpzTg+l3fmi4kW8dfZ5TSoQOUrkUk8KzI+1sxPbWUg3RSVfCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110156
X-Proofpoint-GUID: bu5R73LzN88UCxlltWa3cN5NiCrm7_MK
X-Proofpoint-ORIG-GUID: bu5R73LzN88UCxlltWa3cN5NiCrm7_MK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crash_prepare_elf64_headers() writes into the elfcorehdr an ELF
PT_NOTE for all possible CPUs. As such, subsequent changes to CPUs
(ie. hot un/plug, online/offline) do not need to rewrite the elfcorehdr.

The kimage->file_mode term covers kdump images loaded via the
kexec_file_load() syscall. Since crash_prepare_elf64_headers()
wrote the initial elfcorehdr, no update to the elfcorehdr is
needed for CPU changes.

The kimage->elfcorehdr_updated term covers kdump images loaded via
the kexec_load() syscall. At least one memory or CPU change must occur
to cause crash_prepare_elf64_headers() to rewrite the elfcorehdr.
Afterwards, no update to the elfcorehdr is needed for CPU changes.

This code is intentionally *NOT* hoisted into
crash_handle_hotplug_event() as it would prevent the arch-specific
handler from running for CPU changes. This would break PPC, for
example, which needs to update other information besides the
elfcorehdr, on CPU changes.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index caf22bcb61af..18d2a18d1073 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -467,6 +467,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
 
+	/*
+	 * As crash_prepare_elf64_headers() has already described all
+	 * possible CPUs, there is no need to update the elfcorehdr
+	 * for additional CPU changes.
+	 */
+	if ((image->file_mode || image->elfcorehdr_updated) &&
+		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
+		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
+		return;
+
 	/*
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
-- 
2.31.1

