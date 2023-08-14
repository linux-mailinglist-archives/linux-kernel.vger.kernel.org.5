Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7647F77C2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjHNVqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjHNVqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:46:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC67B110;
        Mon, 14 Aug 2023 14:46:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOsFl023652;
        Mon, 14 Aug 2023 21:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0lGmsCcImpocu8kDuqsgQVuyg5voL+nxXv3eY+/tViw=;
 b=broQAzxZFTINWlcNCz5b8NeCHxSJCOz8MxVTtFV1SDD2lfQsNHo7D66L1Zks1+ZYfdAc
 iSNAo3R+/jHLbmzqlpMFWpkVRR6s7jTGRuPzuKnYhExBGB5bSaEPpk4AJ0r1Osaww0fy
 TZaswN8F0fIiU1ys5jER5JbR7ch6zCpZHQfP+fajFnV90kYPFHnME4BUUZz0L8Kl//Vh
 uAogxrO1VJDEKd1CZRVygAq1Tia+4+r2WUN4Fr783L1HRm2QFrJld432PR2S9z/5Ag0W
 MdC0SmvaUlA9Ugsl4u6aO/NEyXzDLs97DWtMVcXdWqgcLcmswMW/RoUNInawvI076k0r Pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5umkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EL4KPx027399;
        Mon, 14 Aug 2023 21:45:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rdx7c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCHzaeGklAlpAexFnwM4tJegxlcA2QyWCWmdseF5SmuYhgtIDVpIJHuf91myj/+tlKiThkHpxZy08DJZmQ5XyU//PD4+FkXKZD5jhCaUACzIYinzKq7c9ZapLFuLTmlZxL7CuzGOGprxhi0u+vtwcf8ykJ6tok3nUPrFGWgCDZg7IaAzpX8Q+6o+a1mTLGykniVPloT4dx/SfKQeGmyfTgRsIHPP4JokPBhPu/7ZxOxmd4UBaHY/hQ5bvsKDOV9QqnTMc2tbIhhuuYvTKgL5FSTfpRh2JuhEqYgpU89Mc31JXKY9quzj3oH2Z4bdbkGdWLKtryR/BxHrLCEB2odDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lGmsCcImpocu8kDuqsgQVuyg5voL+nxXv3eY+/tViw=;
 b=DJGugjrWxbBwsyjbmswivnsZTudXYvbfSEFZtOMNx4kM7u6VuBOtnhTGXOrnIUGvZ86ZXg3/peJrEyVQZXhaYPwMP5xJV1bqXaaFxwu9/zaTXHsIDuKJdsfOa0jyr+mDCSJ9R0ZQDNsZ+c+h7AdAqLOqoUHYrjLaW6WB3gdDnfQQr5yij/Jr+dLhN+PVJ4hIM8zD3cmwlqlkI/+iSaHQilre7Mxdq22MIvAX9GUBL4J8AH2wp3vJyCceiYpj3ZYx0BZdjRiqC0OiJCuB6b7ZbIERuqjE9vS0/NOg8JHqzIlUXpqJd6MvFS/zRO0RQO4N8RBdQWDV/ulHL8d6D/6HHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lGmsCcImpocu8kDuqsgQVuyg5voL+nxXv3eY+/tViw=;
 b=TD1EGsHb8XHJ9ISFf2WB46dIfdZgkU8HC+ECSKItI9emnOb4IReamT78rTT5CsNLVjnaK7VU/TbXL8ZcVSvKdFvpgiDZ7xny/BhIIttpmibujwLOOm7DKEYSpzRbIcXCecEMmqROk/OZuM6tq7HyiPnG2pgxOH8CJHvtfXusVPg=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB6957.namprd10.prod.outlook.com (2603:10b6:510:285::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 21:45:11 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 21:45:11 +0000
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
Subject: [PATCH v28 7/8] crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
Date:   Mon, 14 Aug 2023 17:44:45 -0400
Message-Id: <20230814214446.6659-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814214446.6659-1-eric.devolder@oracle.com>
References: <20230814214446.6659-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:806:125::27) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ba5c7a-15fe-4fef-032e-08db9d0fbc60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/Ys2iuZyIn4NrSEI3D2S1KqLAZWuQaJ2sK7SJEHF/UOYbHhwFRDUZgOfsMklFkVui4PAl6CIaCwhBweA3O/TH4tits9RN0dj2p31X8WbNDnifJ0+x6NCThoNMzxFNvjJ+pa7C5/7bylJCSW1vYNrih741ndn4+VklZ9uZMJq3zH2lPvOsOqBjelb2v6XUeapeIJxuhyK6M9+q7gHtnvaXlj58M7kYvhoI9ursiyY8WW8kxH3OxghU03/Z6zjiib2IuuxqGzjZwXUackOdbyMaI1jXy56AOZtyg5r5CNL6RK4xahjfkgkZF6xlTLyHcEjCy2Ml/99HKYkRIC4+hAbYMoLG9URCuyGHBv2HWWm4p66ikKT+hWSHodgcpS8+5rxXo5eIN3UEUlerzQHJ9Or0sDRPLF6UyLGOgCXktYKRAfoQ2fONAnftYXpCrwI/oDCzWTodKbpbgdNZ9KPHmiLBBqjQvboUOruP6/JcBHxVa9plF2nfDZruGLglFcKHUd53ibFnao1Cfan7iAWnb5TPZY+cgrd9v3Y9xtxJE6qDQ/KvUWjjdqMn3OuV7YT6s6jq+YX0Fs8miRAt4ZC3i8r+PQIzIF8z6x9Gk4Y09uY2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(1800799006)(186006)(451199021)(6486002)(6666004)(6512007)(6506007)(478600001)(107886003)(2616005)(1076003)(2906002)(26005)(83380400001)(7416002)(7406005)(66556008)(41300700001)(316002)(66476007)(66946007)(5660300002)(8936002)(8676002)(4326008)(86362001)(921005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fPh36RdgK3TAbdi3ZWwN6+mjVmaOaGbLDkVOAtnyzCjjIJN58BaQ5Ek9IrjV?=
 =?us-ascii?Q?GLfp32n9HxqkMkYwdRyajn0fF9U5D09jThazYyb9m80chh6rDw9YlXx464km?=
 =?us-ascii?Q?qEbpllTzcBeec4dpX5HoOe0VI0pSJpBbBBxK6KfOwPNhArVBf5n+XuufZLlD?=
 =?us-ascii?Q?dDPwq9C0ZiknhzVnrF5t8/78UnRJTeKQCM7nhMeXD/H1ORpX3Wg+AibyLHBT?=
 =?us-ascii?Q?sYFtBXZe2zi781u01JTjYBlPvu0y05Ejgo9hw7SZk5i5x8btcxgSBuG9b9/k?=
 =?us-ascii?Q?nhCtHhzj+3teQnUlJcoow1GNPbqz3DcqwSidiwnI1Cvxq0vHBsb3g6NppOZC?=
 =?us-ascii?Q?aqRsyp+0+Jmovk7DGHw8wCPXLkUHHTyuuGUPvZexbX3XdbWcXn6DpR1VCr4l?=
 =?us-ascii?Q?GxlSZZqWp4AC5GmXzmV9aPYnWd1gPA2M/CYPP9rgxjja0M7YqF+fDlnwIU+v?=
 =?us-ascii?Q?iPXcoUUFiunILzXdHGQUu1ZW4Tqbl+68gj+1311mKpbzoLShXLgD2oZJbGa6?=
 =?us-ascii?Q?I9fKDIAy2dcYnzEIP1AU2vKjK4oyVTUd8hD+UZJTOARBb69Y0b6iJtVJ0fQD?=
 =?us-ascii?Q?5Hff9OChr4Ndm9WtL40rFzN980H7J1z8TQm/Cxf/EofcrdkvCFIlGkm2pBie?=
 =?us-ascii?Q?Fv9iF+GUamkLvyWtHHOhd+oB6xtT0g5rBXiP3r1oABp3EN9qZU5HTMx39zLb?=
 =?us-ascii?Q?UqJtwSyicF9BpCO44VXA0x37pa1Zt+icq4E20mNgUWCLHJ/iegFtxPuw/m4c?=
 =?us-ascii?Q?HHXCWyVJ7Gi7tb2V2xPsq0TDlU5PpSg6jb2BnDMCV5D/Y6om6nbTO6xoxhXm?=
 =?us-ascii?Q?LwquwCJ4M2FzbY8xQIjW1wOaMyYWHisezIlS1C4naYVBgemWv2YPpByyVBkP?=
 =?us-ascii?Q?76UDBWjBtazPlkkGayKKX1BdG3y6EdHuz00YVbu2obLBaoYAbYwUDuhJYfR6?=
 =?us-ascii?Q?O/hXDE3EDQZGx02hV+vaOcSDSqttfC/3tC4GrKkpLHjQ5UO9QXRwrYtK4eNf?=
 =?us-ascii?Q?qSn8GznpYH44DAjTVjM9iYS8Nn1eHGldjcFkOE8/dOmpt+P4zUQ9ftNgIFf5?=
 =?us-ascii?Q?fwCMlg3vU8S9LP3y9jft0nLHozjHnE7vQs0z6NOBqbrpcRgD+fsmD9gx+UlK?=
 =?us-ascii?Q?rDTunJQoxcNatcly9fBJdJ8p7skOS5ZadaX91awHENc9shNFJKAYkWTOE0AB?=
 =?us-ascii?Q?kN78m9ffWd3On1mshpjf4ifL+pZuuSHmVXod6tZAXJ/84TqRTVkryGsmmsF9?=
 =?us-ascii?Q?QKJU+5bSQuC2NMBGVTRNZ8J/O5H/ISspJYL/Xrk7z/+KaIyqc0qRcntq7hww?=
 =?us-ascii?Q?M5Xv4Q9Vzk5+x7sXHSUbX8sSRNYLNQj9xY4BD1jMxnih4QNfqHrSQJ3pW+LP?=
 =?us-ascii?Q?heV3e7q/dG16CElUv+iqJ58cZDS5Z44Xz5LzLwS4M2oc0RInFtv0h5SDNJsk?=
 =?us-ascii?Q?eBPkW6mV0w4Hn0kkZJFqRya9lVagm2hZDHZ9lOK/VFs/GQXOX8KwH2VvbLC+?=
 =?us-ascii?Q?LPTEWtEaQmKEw/I7JJ9wqh0oQ7oXUCtaLyY/fGKIgPdjswWuUksuLo4VO5J3?=
 =?us-ascii?Q?GTLKRGjHC0n19nYDTr/LYTXyNl3y7Ew7WKstKSgT6PJPFBCzcBH7e6YUM1lA?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mocSUBPQRfLfMWK57M6YYGwMck2QiP+Rr8LrdL4vB4yoenizXtcHPU8CA3Lp?=
 =?us-ascii?Q?UGi+GXGyZBkYa80qJIvD6GfHfo98Am/eU8HjFZcgBhzRiEDKqsMbSbkhqqbs?=
 =?us-ascii?Q?JavoU1lU8MHbUb54chRy/spOaW9JuN9KKmxs9OOOZUwjboiLalqITfUsNB2+?=
 =?us-ascii?Q?u+dlPIldr+zHkxOvGVa9Yqyqp5fFcsfm/XqLTB+jezlAjC7/3JtCyA0qUgqP?=
 =?us-ascii?Q?7dIcqcUKmMCQco1fm74uKMBg7Eo2NIfzISlKwELErATpfHdRgYA0RnDtklS9?=
 =?us-ascii?Q?bqXGU/9S7o0MdMARAQCdIClCCEmEU9uv0GUQ/byaq8/C+dIDL8QzvIju4n6X?=
 =?us-ascii?Q?zwQMXP25vnf+9UjiJTtwb9Z7NxDtqZpWK1FqrEuoNnFYQKa+fkPv4qmum6J0?=
 =?us-ascii?Q?wW/AJuDOFPHJYwhgTVXFGmQxx7OgMyjmar/+9dEeRsTjTK4dXZcN8tHF4BCr?=
 =?us-ascii?Q?xyQgqgZGYQslX3hcYnvA+h9FJjuSWZX+c+AXU1DEJuE9wI70V5AQqL9xR4VL?=
 =?us-ascii?Q?jsXGWrtcWqmVrsjXi6wqOtez19MRajoEaIeZaNXpAMXtt5eNjA4YtOE9v2Eb?=
 =?us-ascii?Q?7NH5TtFmXfmdXoCJ8IhMzUcWmtdqCWRoHFWygwvHNv9OKD8oR0T3ecJVrzql?=
 =?us-ascii?Q?h/4oTMJ+e2L9rI6IqgZUSRufddJ/T3gTa99ri80HntF1SIqW2kaQ9j72bFUp?=
 =?us-ascii?Q?I6PtjkVL05diKREigM0OpvwK4OPu+2qGEAquotkGEKvlyZgfffO8FgfLGnNL?=
 =?us-ascii?Q?6JZi0EB0BxLrOvtgV24RHvORygsbaQSiqF0hpIgJxIjchslfHlPB6tQltRkr?=
 =?us-ascii?Q?qMrBKtYyku7ykAQnt0D19zsKlRJknAAwO9RpkU5P2lDJWgt4GMYxv8nv4nJj?=
 =?us-ascii?Q?rir6OTzOZknmEIOrbOr2pMVWoRniy6UVEv46icuep/mmoTHVI9yIAT7hLd37?=
 =?us-ascii?Q?eHfjhSY3KUECVimjgSpHn+U27WwOO9weOqIgSSFREZ/GDx+eKuWzId9iZsh7?=
 =?us-ascii?Q?D1d39BxFXEgz/BzUskTWy9BVz1EapQ1kSOQ3pShM675VFaQSMXq8R47H/crj?=
 =?us-ascii?Q?ZWtvRoqR06n5/egL8bCblG54JB9K8XIHyiAt59sruRyievMpJBIGv/yxHDMR?=
 =?us-ascii?Q?ZtTGvWzt8xwW02QfqezMLWOj+QnHqI3Tfm9v3+sGd/moLqSPQvWPNuJh95mF?=
 =?us-ascii?Q?puNDkxv6akyEvkY14BHu0cNOxk2Dll7ggqlpPQO0/0NA7FdEXNagEwZeU3WK?=
 =?us-ascii?Q?O7i97tb9lmQfN0xr4fftWCfAsB0yxqmq0Twxi1wfDRnmcBuLB781WCzy62yG?=
 =?us-ascii?Q?m7zN03m0f3g+bxgHYIXtVNj5t8z0Tetxeq4vn0uASo/hE0ZQGE3bIeYoyHjw?=
 =?us-ascii?Q?6Osm4H/IubIVZ6Zn+MwizvvrPVVtq+L7vaJaC147IPYswbt07WWpvqulicZx?=
 =?us-ascii?Q?j00Lopg60kk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ba5c7a-15fe-4fef-032e-08db9d0fbc60
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:45:11.5802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9LY/Yd8c0FV1IqaLIjKiQKUhlWqLhiQsnfe5/ZklLzHFw4xf/U83cuw72LYMDOTRIm405hnzEjw2N2ZmX3bqan1PdK2fiH9VsI/MWBwesw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140200
X-Proofpoint-ORIG-GUID: uZEHzuLMb4HlPwklQFNPLglMydB5qZBO
X-Proofpoint-GUID: uZEHzuLMb4HlPwklQFNPLglMydB5qZBO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function crash_prepare_elf64_headers() generates the elfcorehdr
which describes the CPUs and memory in the system for the crash kernel.
In particular, it writes out ELF PT_NOTEs for memory regions and the
CPUs in the system.

With respect to the CPUs, the current implementation utilizes
for_each_present_cpu() which means that as CPUs are added and removed,
the elfcorehdr must again be updated to reflect the new set of CPUs.

The reasoning behind the move to use for_each_possible_cpu(), is:

- At kernel boot time, all percpu crash_notes are allocated for all
  possible CPUs; that is, crash_notes are not allocated dynamically
  when CPUs are plugged/unplugged. Thus the crash_notes for each
  possible CPU are always available.

- The crash_prepare_elf64_headers() creates an ELF PT_NOTE per CPU.
  Changing to for_each_possible_cpu() is valid as the crash_notes
  pointed to by each CPU PT_NOTE are present and always valid.

Furthermore, examining a common crash processing path of:

 kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
           elfcorehdr      /proc/vmcore     vmcore

reveals how the ELF CPU PT_NOTEs are utilized:

- Upon panic, each CPU is sent an IPI and shuts itself down, recording
 its state in its crash_notes. When all CPUs are shutdown, the
 crash kernel is launched with a pointer to the elfcorehdr.

- The crash kernel via linux/fs/proc/vmcore.c does not examine or
 use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.

- The makedumpfile utility uses /proc/vmcore and reads the CPU
 PT_NOTEs to craft a nr_cpus variable, which is reported in a
 header but otherwise generally unused. Makedumpfile creates the
 vmcore.

- The 'crash' dump analyzer does not appear to reference the CPU
 PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
 symbols and directly examines those structure contents from vmcore
 memory. From that information it is able to determine which CPUs
 are present and online, and locate the corresponding crash_notes.
 Said differently, it appears that 'crash' analyzer does not rely
 on the ELF PT_NOTEs for CPUs; rather it obtains the information
 directly via kernel symbols and the memory within the vmcore.

(There maybe other vmcore generating and analysis tools that do use
these PT_NOTEs, but 'makedumpfile' and 'crash' seems to be the most
common solution.)

This results in the benefit of having all CPUs described in the
elfcorehdr, and therefore reducing the need to re-generate the
elfcorehdr on CPU changes, at the small expense of an additional
56 bytes per PT_NOTE for not-present-but-possible CPUs.

On systems where kexec_file_load() syscall is utilized, all the above
is valid. On systems where kexec_load() syscall is utilized, there
may be the need for the elfcorehdr to be regenerated once. The reason
being that some archs only populate the 'present' CPUs from the
/sys/devices/system/cpus entries, which the userspace 'kexec' utility
uses to generate the userspace-supplied elfcorehdr. In this situation,
one memory or CPU change will rewrite the elfcorehdr via the
crash_prepare_elf64_headers() function and now all possible CPUs will
be described, just as with kexec_file_load() syscall.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 34dc7bddfd77..7b87db9973a5 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -367,8 +367,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	/* Prepare one phdr of type PT_NOTE for each possible CPU */
+	for_each_possible_cpu(cpu) {
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.31.1

