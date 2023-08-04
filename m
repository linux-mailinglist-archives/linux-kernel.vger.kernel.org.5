Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E09E770A9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjHDVLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjHDVLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:11:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759574ECB;
        Fri,  4 Aug 2023 14:11:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374JCasl019548;
        Fri, 4 Aug 2023 21:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=P5eVvfz0YAQZr/uS/mBoivaf/re60E7w0zQY20vBcFBP+ADx09tGj5zFBPht8POniY91
 kAW7hkx9RaW/iKAAgKi6PwhKgxpWp+Kf6Ft+7Kff5cMmeo3MO5fgJ3YYw66XquxYySNA
 YErweSEons8yi8ZAClKJSMU3KIqZ/zZkUZM748aY94IDTC5bz8us67rBt91OGFPzEvdf
 LDakCbLazFO+DyFl9zvTvUzQchWJ7jtoCZiaLDA5LE0b4CIzB5MgDS7YuF26x6NvpgVM
 OE9ql7d1dD55mmHCG4Mq2qfnP/TKDdIbir3MRu6JtgF5M7EGYgnkJRHk3XdRqPmQeCFN Vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s79vbxr1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374JVRXZ011643;
        Fri, 4 Aug 2023 21:04:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m2sdn69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiX5AaIXSqu+1Q+bGLt2Y4EKjdK1s42K/O6DaaUvdRT2qutpU/nwZ0CnlVmy7EP+JW0Atm2CBHn7SXATGnYlNHmi9lqfh/PSbElKW5tAHoDYiz83VepUL1F1NW2xhUa+wQ7XBq9QzJE/seFVEvo2aYRk7TsyCYpWqj3nwAcc4gxzchmYkmtCNxWBzI0fe7ULcTAnI+oxab2KniFbuksrRKytsAAAMnu61zsfCbh37Ioi68kK6DsHVDBxs3z/OBDWD33FfuaW3EVNaO48c4dp1T83jBu3dbX8PfkQHcJXD8TLrXK/PMl4FQkMt0x6uhdYcdJ7VzZ+6Pvh3uGk4jG4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=L6JuN5buvxkmlFxSh9Pszs2Lk7iSbncdSUdqFEESpUAnh7KBQzSJcoXObw//r7NkZ3Gjs8gfmgD1BrIMzi/dIUsehrYentyXpYP3n4+x3g3ENpczeCDj4D/ulbiaPkXvGZmekbtEHwvIs+3w+qvQJ9qwS0/EPe4qEQADj5P/9Jh4bX9hY8fJ9Eo0itHaJKBoYW9Mo84qOrwXoN+OEbQc+yzSWgxUepQo9p8nqGrzZ6WP3JSYXjc8Q1vb/dF/fINOjAO4gXB4cQ8ckQf6Zegc0NJT3KPGSoh67hWOCgrIZCWohWnnzm34xbmTXcKL87XGDAKwTR+ZUjyGTvicrcd0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=Wz0B1hdWEeGa9Uq8YowtnHeoqsKiaq1Ko/7FGR03ZlJMXPdwM1B68uJvW7Y1ru37AQv4AKZ/cF2xjHeie3Rde96Gf74hJu01BlJzGjFEUAbKRcsqBotSL37pb+Dh1KqW9llNLQKSUUskfLXtATK2I5RBWSFb7j93LtbwSq9NRiw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 21:04:30 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 21:04:29 +0000
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
Subject: [PATCH v26 8/8] x86/crash: optimize CPU changes
Date:   Fri,  4 Aug 2023 17:03:59 -0400
Message-Id: <20230804210359.8321-9-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230804210359.8321-1-eric.devolder@oracle.com>
References: <20230804210359.8321-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::36) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f8d5f7-ba36-4b55-98da-08db952e64d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MljUi1mRDbmvQ+RiHBShHWagf91Qo6nKwv9gPaR8byJqRcsvJI/psuKXZfiLKUuti+RtJivCk5DGz1GGphENorzehhUaYRaerBhdgmCzhk1vUL8oWFijz+xwW+45xH8/IDdVBwE2vQTm06edkf+2mIYacQFhB3N2EL0CT0bLDLswT32goOGZtt++giTJ5pf8JzQVFIcrQaTIuHyBWfwtOPw6w5TAqEG+2WjZ/v3NYyDOk5XF813njaljgoz+Sdg4Qsg5YiM0d+We1r0OCtV/oDOfZOYSJ9IvDFq80crEj4qUPy3V0QcGG75mdonppoyxzWDgsifyYlTIg2zb01efxZbahgOLgadZ4iesgqdCQEfXIFyj9WzgExbqZcpOznDNyqVYn5WDtLdvQVDASmSrVAS9JwctE2ZhVA+LE/0euUUrjraQgTguKIgfyIRI8d4xrIEwq4zzvRKMedQLTP86m0932CDk2ubsdNUMGT/Sjk4rkPmNSnJ37rXv7yHvsc2Fi8N1Ci1tsLoohuiMUis1ysyH3IAFriTKEWDHD4oQmgBh9vEUcPlhnuNDht3ZFBmmz/9YCZK2WYJReb5PnvIIGsM9t7DUZ5bkSwMT3WDa7eM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(1800799003)(186006)(1076003)(2616005)(107886003)(26005)(83380400001)(6506007)(8936002)(41300700001)(2906002)(5660300002)(66946007)(66556008)(66476007)(4326008)(316002)(8676002)(6486002)(6666004)(6512007)(7416002)(7406005)(478600001)(921005)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yUDPCdEpdF4o9ELq4SQU4RRXNnYWZ/FHX1Qngcvq+anUBm7psW5eLxPwCQo6?=
 =?us-ascii?Q?7d1FvpkyHVlsY9izJ/TFE85UbWm3l0aybpV74afBriagjAhtwJ70FFoRLdeI?=
 =?us-ascii?Q?Lttc+XBVnmLDb75y5KY/yPDRMhizvFKRUqFrVXPyDDSEJeg1R27HHbDXSuvD?=
 =?us-ascii?Q?FxEyZ+laWPtNTjYLz+tfQY7Iz4G+d5UQOdQzqpxhWhlXQEEpwOXV87trqoBA?=
 =?us-ascii?Q?p+lLIwvFTJXBU9hNxodnMZkuA5EGycovKjOqnSBLmQ3Vt8ZosM9C5qiuIIWL?=
 =?us-ascii?Q?nzquZZhg+4R5h4MytAOXvDAsD5bDuEJDV/ySmIqiyx9Acd3/SknztkJtT1g2?=
 =?us-ascii?Q?023vri8dNhai9HudsxH05bXHufbXkVUa5qYatYF+d8pZdZK+k6J52JqWF/3D?=
 =?us-ascii?Q?yXLumAWw3UtZswwyoxGM2EqxmoZkRMe2ukQCVG7R8tUZ0XN3kUb9lvmXmAue?=
 =?us-ascii?Q?FOuaVQPH2V37pdDv85MaSL4GjsADnyBNI6fVjtv+uBTL5uFbtZCnxFb97gLa?=
 =?us-ascii?Q?L/o/+J6+LCSphIWOP5u8wojdQpA8jjMDzUnwQwYh9K8/YgL+wFqTakTkuxxX?=
 =?us-ascii?Q?fmwyulSiS+6XA1YSjr+kulg1+jIzCwu4YHod5cvUM7GPfiJx91wRoYl5juda?=
 =?us-ascii?Q?uqdX74vmxEVC6rKX7scrbC59OZfT4zFj28Sr/sPR/hE3HD/Fo1wO+XxDBSui?=
 =?us-ascii?Q?XWeEwGBegtrReHONXuICYYyM7JNb/YKPhOowlRnmGekFyKtFq716ft6pCzzG?=
 =?us-ascii?Q?AnbuC5s66o786YelnpHv6vxVu5MTXPhjstPUZry0ba9N1nuSdPO28ICTAIka?=
 =?us-ascii?Q?Szd4MWf4u+5tx55OU22gWUEwdQDZ48ffdyQzWTGtFbr19DRSqks6786OhEH5?=
 =?us-ascii?Q?S2XPf/Ex/zsB3gHdTJ0CxAdGUbgoAN3GehID9VFcaMTGpAmqZE7bMYqdelJL?=
 =?us-ascii?Q?GLmB8W/Yp1aWBkuA4/I8dSL9r3O6LzMCHFsuINZuPPLyBqSzeHWcaRgpA2td?=
 =?us-ascii?Q?WBV48vTiGJqHHrWpv5HOt6+CbQxinnLiY9mUvXoyuecuGFqXp61WE3z7NKt5?=
 =?us-ascii?Q?NTwbDm4UeJKOLX2Ad9IzLDlgUqH2Gn2q56NxyROf3mZvATV9Rp9yH48dY74K?=
 =?us-ascii?Q?c70TvukgXAlNTpZQCWwl+blqa33saAJabOkx8dqvx/2R22bp0MdyrGO6EDme?=
 =?us-ascii?Q?I06O03oLSZ476U/TczcjJlvxV/VVN8Yrn4uU7GDUFZq3/0DmyWGd0FLAGap7?=
 =?us-ascii?Q?Jq6lHodRnmkvTWmJRfEPd1EcfqgSmZ6qatAAC8k3qFWiAB3g9/+7+QPDADGk?=
 =?us-ascii?Q?1Gbum+jq1NBn13WjJaRdrFu1x4/Cxg5Km8doFLYVkrj4Td+GHs0DjhasNTt7?=
 =?us-ascii?Q?ZIVmnDH/9tCAjUBiaAs+jJyK1FJmxtMn/Pm5rvIr35uhRQOIlksYPs0hBDWs?=
 =?us-ascii?Q?nVAPooA6HOPmWZOfjr02NTERxgKVU+eNCUrlFRYhBEoTMrloIjIy7Akvq/eb?=
 =?us-ascii?Q?z4PlZKwaFsFbBsUKc6GEp34L1qsCA9ppCJ5G+Tivf7OZbZavq/d5i7EYqCFL?=
 =?us-ascii?Q?Ko4rHWJXvIbG1HT+C2AqArsjJZBK0rNofHnLLPQ61+YlF66HuKAbrToU9N89?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Vuet0SO6muxn7Vp6Gp+QxvVFxivuyGuoEfjvAZ0zZXBaL4gIwv6rbqLqTufc?=
 =?us-ascii?Q?kp0RvlYdwYJMi7es/9JSPodEh9rrpmB0LUp91/vPGaGRzSiMncTHWeXyPYCN?=
 =?us-ascii?Q?5WFRBAaxBqGFqU5qys3yVu7fVcd1TufO+3B4PQ2ymgTjKz9GJ1BnQGUCeF6f?=
 =?us-ascii?Q?V493i4LjGogVcme5mUWp6U2w3ie44v4/8Y2JscO6aLlASdOdZs5iaRVSWBdY?=
 =?us-ascii?Q?cbVvw8F9GKi2AfG75ds+JVUm99NtsDyQxYB5NrzJ6TZwoWmNbwEsRGGyUUjL?=
 =?us-ascii?Q?9Y3lSV7cZjlmijNC6uGujTtrDwrTx8CBZYxVuU+FgPEf/PVRnrq+IEgfwmWd?=
 =?us-ascii?Q?oaJFeV5CygJnTH8BC8O0Jwp0YNFj8XYwku6Oy1iDmpBY+4eNzAeUYKgGhiUw?=
 =?us-ascii?Q?71Y5RydNnPHvFWDe0MBx/DMv1jf+ovFbDMD9H1oPoT/DUX1xxoDRDvgn0vRc?=
 =?us-ascii?Q?hG/zR0mP7ySRs78bxCz5aVcb8axknflpNdjKsEgeGEn1h6gxauCaRk/0VfZO?=
 =?us-ascii?Q?1LOhN4yfGy3gaup5dBV5HzaDjhX/k3RwDVtepL1aonud9dy9H4l71yU+V/Bl?=
 =?us-ascii?Q?+VR/V4TyBVrfTvmvYtr3h08p4x6CN0lsLWdWFXCw7Mr5L01vZQnpVDcGo5p7?=
 =?us-ascii?Q?zcTuHRCB+LhBeT6o1Zb82OGSPNzccguaCG1RI49PsKekjxUr/r84Pejp5zdp?=
 =?us-ascii?Q?vQynCYcZjnwG1qegZ2g/hVuAGr7t0hm3nI5tdTO1dwmJAb12wqef7OrYm8sH?=
 =?us-ascii?Q?FcFJG5DxfOXZoSW5uGu/shKiBh562NVLrjVDsYvZB7n02+HmJRgqYU3ALgIW?=
 =?us-ascii?Q?JOJyuxE/A2GGIfk1LIK3Daxi4W4BQiwLbnE4cOd7X4MLzfp2MvqV+NGoqDcT?=
 =?us-ascii?Q?HdzlU9tPJ/Ni5Q/Z07tDw2x1OFSb02k1Pp5Q1C5qovBM3VZ/+oIh+SopPhG9?=
 =?us-ascii?Q?XnBTkskGhb+WAy+byLNXcbxSlansx49LXY02ib0GwEbRof7EE6UWGj+bpt01?=
 =?us-ascii?Q?yJisl0+H9almspT4DOcYRYOhlX/BIyAcuhaRwbqe2fyGSSDg0+700AzjNe8D?=
 =?us-ascii?Q?GbsmuMN3cBVC698EPdqu4mWTPGfPQmf6+Veuz18H/57IRSVHPCbC4SV4nSYb?=
 =?us-ascii?Q?sjKHjZiKSTL7ycJjA00QMvEOCxvDEK66cD/ot1Tms73z/NrvUmpIS/nzJuWb?=
 =?us-ascii?Q?ealvefXUERMUhIZxYvlqfMRFoHVEiHSwUhq3snbZNavFHfGD22TLA00lD+Tn?=
 =?us-ascii?Q?p48AUJF45Ax+LpOLZdjGXsvqZXfUNUJ1c7U4zqBMyGF7WoSZI/TWu8NsQ5LU?=
 =?us-ascii?Q?4mld2pzBZLSI7ArwXziX0wmZq5szR8jd/VvAZYQfE0Cs0mfaF5NBgrMkJ+nk?=
 =?us-ascii?Q?Vo1JKkouzulP2Ymw0WgDWVdD41cDhHmDs0pck3+i937eEGmn06mgqX0LSXRM?=
 =?us-ascii?Q?BVqtyxK2+7w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f8d5f7-ba36-4b55-98da-08db952e64d9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:04:29.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24AquRrZsQjVlURjZtoDvDIndIUSXAMgcvEJ9+xT4CDZI6PN6mHKaHlMgsn2Xs+l7mw8Yc3dlNORG6iz1WKF2yjqp8p4K1zMvob0VtbQ6QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040190
X-Proofpoint-GUID: QZLa1BwoDjBh7ZVHjzwwG0GUtXwyuYum
X-Proofpoint-ORIG-GUID: QZLa1BwoDjBh7ZVHjzwwG0GUtXwyuYum
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

