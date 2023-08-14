Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E2B77C2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjHNVq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjHNVqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:46:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2557E4;
        Mon, 14 Aug 2023 14:46:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOsWO023639;
        Mon, 14 Aug 2023 21:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=m7hGWDTy94MZzBYvVRqREB/TkKtycYv3LIJ2Jo5D9PE=;
 b=hITFBTcPZVK7JpM1DzN5QVPe8HnSRHT7Pr0dsBQqNuEWBtHGqiP8I7Fss3U1yy6hsBbF
 2rZXtFtSl7xMfB56zb64HFvjXAc1OEVi+d80F2zfwgm2MNNr2tefMbYY/HIn9sCDep5f
 b1s0I4uUKtIjuVYoKQ5p/b0xO0eL5GwZiDaZYfKfqEzLbl2TnBHhx+2IuJD1cdxwQIrh
 BA+GYoLRcvI1Ey+PTpoI1muIBwpULJqiyY61i9kSfnkFXyUd3KAcScB0mbq6JlowGW8K
 rAZRav3S6y4x6N8YkXOymcijMbcbHX+efJpzk90vyG00UIev1sR9+ueF0dfemDfv66je mA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5umk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EKAhFU027528;
        Mon, 14 Aug 2023 21:44:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rdwxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy3D8akHOmZSitXoCu9ME66p8zYKeBwELm+/k1uPYFu52VJRG3ACNNzM7GGcjxod2NoBNHVc7Ee5QReKmmNhPdhfYoyF94l4mrqXCS8aEQ+G/sgQ1GWr7on2HzUUIDvQmnwlmsn3ZQZp3PrHAMUafJiUJ85rKiOCBY6lUSTuktwXwtGuF+5aPZcJ8ZBaEzPRNxSWeAqqhp28Zk9irvoqZyI9k0/8alHLj0WykqkP838/A8j77qo/17ZlJkBEg4zjj9zbt1ZXxPF9+tzI1enanO+lzdbXJBlcREbuFvI4fXq4INQkNTxkZ9RJduAQsxxcUJR/FXNTtPvFzqUv4NFIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7hGWDTy94MZzBYvVRqREB/TkKtycYv3LIJ2Jo5D9PE=;
 b=Gm4Ul0cXpPglVY7/vYSzBOUmXwRt4qr1TJWy8r6T8JvdRaZfVueyqOFVRNtzD152L0Ji5JxZVJub2d9VHNrFDQ/VroVGOFConD0M60tx90IQfunVRbvf6kHXQ6abcSq5tuICfybEbX5arC5TXQCpEhlw1fFbj6MNnr4PJLMauGpmaDFfP9RRoVng0bBlnx11TPrVR2gsXu/vNa0LIpojG9NUHuQIxSZqSU12ZWXdJG9L88UZrHinP5AshYeI6H/X02hA7TzNb7WHw7VMhGzVRyqHR6rn5qfzyldVtT2YtDvFlaIWrfQDhRmrCXJ3Q4LTOQFYeQxHm5caqy74W1ZIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7hGWDTy94MZzBYvVRqREB/TkKtycYv3LIJ2Jo5D9PE=;
 b=yuk1w5YTEPLAcoE9YSZ+OsuxkawehAcXAlX5WmguZQDt1v8BLrnrEDln8AIqWZLLg9c31KxdB/dM2Qp24BiVaZoXUnVpnl9nYHRWKXzI1FfRN9kI3yyFSBdgYj3s/A4Yyhs6vH4DI+ad7O+qr/D/9hDGLWRqMa5gLXSaKiWMXxU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6222.namprd10.prod.outlook.com (2603:10b6:8:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 21:44:55 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 21:44:55 +0000
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
Subject: [PATCH v28 1/8] crash: move a few code bits to setup support of crash hotplug
Date:   Mon, 14 Aug 2023 17:44:39 -0400
Message-Id: <20230814214446.6659-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814214446.6659-1-eric.devolder@oracle.com>
References: <20230814214446.6659-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 7998bff5-8f04-487e-9b7f-08db9d0fb2e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYyLjUBANwZd3HlqM9y/GGvXSA+vvqZsWSS4ikAOy4pT1jvSkYP9zUyi+mwwLDAYTs1vohFwtQy88pVZCqxtPjKZOIpSZ8q+/ma2zNHurynvGYVfmFMUpISmCdMrgEbCfWCz6uhVrDgFn3HKF+nrm/3LJoRNCq67ucLVA/LL1o65/o+NHp5cOOyC1i8O4xHZG/xDjqIat9A3CqLbPyLIRSuevfdMEwS31+VcvbM+MQg+Z+bKHNNAXNbjAtRV5iGvrA93nNO7L6nfb9aTf9J9oGqJPcVlcorLC/xKXymztPN6f8yX+DSPQv4As3lMzYOkGb68GjtICjGBVXYR4+FRp7UxMJjIeidrIZZeRf5XQEVxwjFv27QukNfCgiSKSNO9FGEEB/ZvwDqUV20gkCpVGDUIOnxbyEewkVb1uUDsg5KJEt5EdZkNO/BBCWp64yLJtYFyXbzjjoX2sHXWvLO6S+RlANtX1yUUgtujmMJAn18WBoa8UD10MpFzUEyQN521xFJjZ3ZM8fz+OaYNNnXWsPnKLigjXdHdlMmyDv+W126/WaiavTI0TEqDwA2IWmHwH64zVkC15A06qRlDVUNB++AcTyQ0SaJI799h6LGdcGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(83380400001)(36756003)(86362001)(41300700001)(478600001)(921005)(66946007)(66476007)(6512007)(66556008)(316002)(8676002)(5660300002)(4326008)(8936002)(38100700002)(2616005)(30864003)(1076003)(107886003)(26005)(6486002)(2906002)(6666004)(7416002)(6506007)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rcHwblVRLtQNa6SPGxih8Tl22uS2EEgLNo++nU1j9ZpEjiAhgg5mkRxevcc7?=
 =?us-ascii?Q?FJviSR4goLt65+2jji2SQeJaSmRf8U1Im0TzUArpqM449gn5sE7Jb7n/j4ta?=
 =?us-ascii?Q?RdYyCzWR4WuNbrRln1oFkH6qCIgoxo+gA91gILYfJilylUrRE6aSM3bJAgsg?=
 =?us-ascii?Q?djHzTaYbQPZRz17QrVzDxrZuSKUKkC1TdFft27c5IBHl6hXEGHyV4aoNRWdB?=
 =?us-ascii?Q?JwsMv5zfCSIeBVPTLmhFHWdGZOanAfKzbavRXohxOyTkQOqpXWTRihLpsLDz?=
 =?us-ascii?Q?3/OCawzFurPDbZM7GiOGyPKfMelLv6R160jOW67LrPiPZ+OsfymT7j6CUou7?=
 =?us-ascii?Q?8cMevGGfr22dvSI02vbl+1ND3Feqk4yWDaHiG+yj6Yo6aYHBsWG6hR1gt1FQ?=
 =?us-ascii?Q?jDdQybwwul8IYqsCQFKEcu3F9UjUGWSbI10MEbpwjvl3rWCEUc6/qRUf4VBu?=
 =?us-ascii?Q?ul2DDtzZHKXzV/SSL/8oE1hnwpfY3RM/d+XgNVt7tUoEuAuLq+xtOnzPxFcG?=
 =?us-ascii?Q?eaOw7Fw2xdfLZnm6mqMM9vHTcaqn/kMDLsdXOzD0HRJdB+J0cfBvO/F9SA5N?=
 =?us-ascii?Q?vtk0lLGVCZ6pQOv417RwLA7ENGvYGW12XkgTV/tVK2j3Oi74DMFmZsK2obO6?=
 =?us-ascii?Q?yFlfY2ZjO9biRze5kU43dhrFmQojAr2bdJfvrcKrILqT5+fgSvaAszS0ovYH?=
 =?us-ascii?Q?lsw8pE1kFusbeI68i+m7T0YPys/iH0f9FNZ6OjB70Kj8OjYw6C84PtyPIWKF?=
 =?us-ascii?Q?Ol8lvXlm6NW2a6Bc6hI8hf84esMR/blH4v3Qlv7W9Pii7iu5cBOJpRXHYurG?=
 =?us-ascii?Q?lcoyagNe+4mJLGxBDWeV5zjZae7PFfORCT0hcIOGflqMGyNWjbtSED6vL2FD?=
 =?us-ascii?Q?V95mK2x9/0XzYzEQ4AFpcTqzv8ahu4iD8LZ3mvCQ3uP8/msw+C3tBGND5ySN?=
 =?us-ascii?Q?Xn+hUj1jvtkeA1cfIbKQ7qfZECPDpCjv/iFKgNV65B1/FaryyV8uQR2ETwQd?=
 =?us-ascii?Q?ULtBjmHunwS4Kv4UqDFo2atWCvD8yoIqC6xDm3GLfp/mn+PQMDOdBjDwSyZP?=
 =?us-ascii?Q?dhZKEHk/hiEYRfKWilC8DNLpGM+XRrWZVzEizOCsbzrIL423WdRt/cmetd5i?=
 =?us-ascii?Q?CeR38YyTdIJDtfppmBpF1elsUaEN2XrQUcQb5cni1izb3i08RLHjlg+rq015?=
 =?us-ascii?Q?CIVH9CXAYDiwPncsDDoVWE/E10MZ0FSlhsK6R5a/jEZyXZjDWESJQ5gGmEKw?=
 =?us-ascii?Q?onUE+7CRSL6pJ2TXIoINqsvNHMMb3XWa1DJy7r2JX9IEiOFYg3p9NoQCqJfC?=
 =?us-ascii?Q?ob/M6bflHKWmFS/585ODuduTJoMbCktgaXwQB35CwgboXspAb2F2dR+/8sXt?=
 =?us-ascii?Q?G4r34sPjIQmhzoPSd1arBDEwKgPAbMwORVATIbr9ImY1VlBQjicW8ZWZE9u3?=
 =?us-ascii?Q?Np8zS0SAoflZ8IBflclowte1boZTKqpANne0Ccw579WXP8GhSvzlCnWD3Sso?=
 =?us-ascii?Q?TWESlc1qcsIJAFi0lQqTtrQTR6hqPF4GMcxE3jyJLIu/qwxpCv/EAwS5hHzp?=
 =?us-ascii?Q?1wVnpRiSuh3i4IJIrnL54UfRrXOjqI1PAKKS8GsuB7PCx0nmU/vvIzMAPSM6?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lDXyx0DADrBn8dgwTiwinTZg9FxoMrnxsZZpLmrg3epzeQ//CUQNVTxA7PF6?=
 =?us-ascii?Q?2PgZDwBaK9gQdsLrz3iIWg0KQ53aeL00XRx0Y02hxP5j6hwiC0YmzT9Jem4A?=
 =?us-ascii?Q?BAkU+Qd+7J3YuHS/pbuQPRU1bO1FjuURzZMlQ7hTClozxBC3w/4SLE689LAa?=
 =?us-ascii?Q?/7gp+r4S9Lk1/w0cFbEfbcvTAbnfSTQhUhrRJg6SH99smM6/6fmB8t8m/ZfA?=
 =?us-ascii?Q?H+CN8mDwrYGBw/7AnO3nyJT95E6zRzIZfR54kaUMtEFIw3YA7k0TB1QbJil6?=
 =?us-ascii?Q?WqPQSZYtMcYMLesj4lhYbrNSOb+aipsQUMFY+AWkd4q3b50zJ+mQ+DPfc25l?=
 =?us-ascii?Q?uNlDoqpzuT8aV+h2FGgUpSe/lfbFSFfWjD7xvS3HmLlUEO9mMhgoh7MGFyNP?=
 =?us-ascii?Q?KUzsbFjRTlWMgu2ApNJlUXy8eLR/xlDM2DmbcnOH0jjBMfeBcemTfnsuCXfh?=
 =?us-ascii?Q?BZT1GdJ5+f2dVwcasBUjhTno3nXfm7Kb2113jdj+IurCA41pXrf5cMwPhlq2?=
 =?us-ascii?Q?Hp1Gb6MnFz1zi9Ijd6IJUP8mmAdgYonlvF/PpuXyCXK3NaBGKXKPd6bxJosR?=
 =?us-ascii?Q?s4nE+2LGaihXq04/3C00SCcrjqeb73JQ2YnXH0hnZrzoDq0gm2hVNiYt34ue?=
 =?us-ascii?Q?fGNxz1HeSxuRCm6X0BGbMwzUliGhoSBwApiMyPbMnnyvZue7mC+a3K9lVvO6?=
 =?us-ascii?Q?2gZpklIJaponoMMpxyPBYSzG34KGACxM5rdQC980gnuwHm1gtd0OcLwl/uM6?=
 =?us-ascii?Q?VPb1qwRh84H+zBSl18J3uVME4k28LhBxbaV8FO5Dhe3o1C8+HLd2phqY5oUm?=
 =?us-ascii?Q?Da1RbgBBa/BJA8jvUXJVBaggPgzSXlptmFa48kx2bZEu4MXmWYl2OkdhDen/?=
 =?us-ascii?Q?yPgJ6PH5cdaFyPkBnaJGxI3QK+xZYhitKagrSIGPzYVl6DxsBQkr0GXlkAOS?=
 =?us-ascii?Q?KAZn+Ut+OWysxYAuuQKxTOuQKE/jK+PP0OEsgUpZOfQZIw/+Zq0u00JfzZxS?=
 =?us-ascii?Q?fZxGdintv7jz8dnFHjzXR9Upiw5HN0zpa5Qk3cuaUuAyaQhbybupYV8sHDZU?=
 =?us-ascii?Q?rdhr4wI3NbtBq0LMiVpaYl0zuVp2WGix0nrUiY93ii20MfYgVt7FchIbcUda?=
 =?us-ascii?Q?9QZ87Jjson3Tm1Ui4rLLJcX5SqimVB+8jO3aI8QzfmMZYB5SLQ6ylbMCPw1T?=
 =?us-ascii?Q?0ZKEzFIDIldO4h0d5PHofCXcTzu1iOmvRRFthXWaxxI/xmoYaZ9NqFvse5N9?=
 =?us-ascii?Q?tkgviWxmKatf4JXdMV2BWn7XC2EEPwB5W6wwhuP0uKW73MJHgFqZJNoOibFO?=
 =?us-ascii?Q?pFbySxsY7orQkVuS+vsNfob0qI1xdPRJ+NuM46mNWV+aZL3a0cG68GAX9pXS?=
 =?us-ascii?Q?10ExEOf/SkvgzpJS/YUT34GF8wFqjjvOkcjfh7EaJ2pYbshJgZHHrb/vUej3?=
 =?us-ascii?Q?7al39lasxhE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7998bff5-8f04-487e-9b7f-08db9d0fb2e0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:44:55.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVDpNsla2oP+wdK/BZXfx03rq/4OszQNSdrJo8khqzSFlezSfCfOu7DcbPjdUHZG40z2MJIJb6NJOMCPbmRF6oPpv9bSTTu1yO64nunKwG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140200
X-Proofpoint-ORIG-GUID: OfWkeN9pF4ZfVuA98yzYduWjDbpFFr0n
X-Proofpoint-GUID: OfWkeN9pF4ZfVuA98yzYduWjDbpFFr0n
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash hotplug support leans on the work for the kexec_file_load()
syscall. To also support the kexec_load() syscall, a few bits of code
need to be move outside of CONFIG_KEXEC_FILE. As such, these bits are
moved out of kexec_file.c and into a common location crash_core.c.

In addition, struct crash_mem and crash_notes were moved to new
locales so that PROC_KCORE, which sets CRASH_CORE alone, builds
correctly.

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |  20 ++++
 include/linux/kexec.h      |  15 ---
 kernel/crash_core.c        | 218 +++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c        |  37 -------
 kernel/kexec_file.c        | 181 ------------------------------
 5 files changed, 238 insertions(+), 233 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..1e48b1d96404 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -28,6 +28,8 @@
 				     VMCOREINFO_BYTES)
 
 typedef u32 note_buf_t[CRASH_CORE_NOTE_BYTES/4];
+/* Per cpu memory for storing cpu states in case of system crash. */
+extern note_buf_t __percpu *crash_notes;
 
 void crash_update_vmcoreinfo_safecopy(void *ptr);
 void crash_save_vmcoreinfo(void);
@@ -84,4 +86,22 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[];
+};
+
+extern int crash_exclude_mem_range(struct crash_mem *mem,
+				   unsigned long long mstart,
+				   unsigned long long mend);
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+				       void **addr, unsigned long *sz);
+
+struct kimage;
+struct kexec_segment;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 22b5cd24f581..fb4350db33ff 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -230,21 +230,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[];
-};
-
-extern int crash_exclude_mem_range(struct crash_mem *mem,
-				   unsigned long long mstart,
-				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
-
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 90ce1dfd591c..336083fba623 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +19,9 @@
 
 #include "kallsyms_internal.h"
 
+/* Per cpu memory for storing cpu states in case of system crash. */
+note_buf_t __percpu *crash_notes;
+
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
@@ -314,6 +318,187 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
+int crash_exclude_mem_range(struct crash_mem *mem,
+			    unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end, p_start, p_end;
+	struct range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			p_start = start;
+		if (mend > end)
+			p_end = end;
+
+		/* Found completely overlapping range */
+		if (p_start == start && p_end == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (p_start > start && p_end < end) {
+			/* Split original range */
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
+			temp_range.end = end;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
+		else
+			mem->ranges[i].start = p_end + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == mem->max_nr_ranges - 1)
+		return -ENOMEM;
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
@@ -515,3 +700,36 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+static int __init crash_notes_memory_init(void)
+{
+	/* Allocate memory for saving cpu registers. */
+	size_t size, align;
+
+	/*
+	 * crash_notes could be allocated across 2 vmalloc pages when percpu
+	 * is vmalloc based . vmalloc doesn't guarantee 2 continuous vmalloc
+	 * pages are also on 2 continuous physical pages. In this case the
+	 * 2nd part of crash_notes in 2nd page could be lost since only the
+	 * starting address and size of crash_notes are exported through sysfs.
+	 * Here round up the size of crash_notes to the nearest power of two
+	 * and pass it to __alloc_percpu as align value. This can make sure
+	 * crash_notes is allocated inside one physical page.
+	 */
+	size = sizeof(note_buf_t);
+	align = min(roundup_pow_of_two(sizeof(note_buf_t)), PAGE_SIZE);
+
+	/*
+	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
+	 * definitely will be in 2 pages with that.
+	 */
+	BUILD_BUG_ON(size > PAGE_SIZE);
+
+	crash_notes = __alloc_percpu(size, align);
+	if (!crash_notes) {
+		pr_warn("Memory allocation for saving cpu register states failed\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+subsys_initcall(crash_notes_memory_init);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index e2f2574d8b74..4ff564bbd8d8 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -49,9 +49,6 @@
 
 atomic_t __kexec_lock = ATOMIC_INIT(0);
 
-/* Per cpu memory for storing cpu states in case of system crash. */
-note_buf_t __percpu *crash_notes;
-
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
@@ -1218,40 +1215,6 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
 	final_note(buf);
 }
 
-static int __init crash_notes_memory_init(void)
-{
-	/* Allocate memory for saving cpu registers. */
-	size_t size, align;
-
-	/*
-	 * crash_notes could be allocated across 2 vmalloc pages when percpu
-	 * is vmalloc based . vmalloc doesn't guarantee 2 continuous vmalloc
-	 * pages are also on 2 continuous physical pages. In this case the
-	 * 2nd part of crash_notes in 2nd page could be lost since only the
-	 * starting address and size of crash_notes are exported through sysfs.
-	 * Here round up the size of crash_notes to the nearest power of two
-	 * and pass it to __alloc_percpu as align value. This can make sure
-	 * crash_notes is allocated inside one physical page.
-	 */
-	size = sizeof(note_buf_t);
-	align = min(roundup_pow_of_two(sizeof(note_buf_t)), PAGE_SIZE);
-
-	/*
-	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
-	 * definitely will be in 2 pages with that.
-	 */
-	BUILD_BUG_ON(size > PAGE_SIZE);
-
-	crash_notes = __alloc_percpu(size, align);
-	if (!crash_notes) {
-		pr_warn("Memory allocation for saving cpu register states failed\n");
-		return -ENOMEM;
-	}
-	return 0;
-}
-subsys_initcall(crash_notes_memory_init);
-
-
 /*
  * Move into place and start executing a preloaded standalone
  * executable.  If nothing was preloaded return an error.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index dd115571f8fc..453b7a513540 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1151,184 +1151,3 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	return 0;
 }
 #endif /* CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY */
-
-int crash_exclude_mem_range(struct crash_mem *mem,
-			    unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-		p_start = mstart;
-		p_end = mend;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			p_start = start;
-		if (mend > end)
-			p_end = end;
-
-		/* Found completely overlapping range */
-		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
-			/* Split original range */
-			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
-		} else if (p_start != start)
-			mem->ranges[i].end = p_start - 1;
-		else
-			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1

