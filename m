Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9017E7E4B54
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbjKGWBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbjKGWAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:00:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6992172C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:38 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJP6L004600;
        Tue, 7 Nov 2023 21:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0QNl8/K34dXXO4olXEeV1fgO+qg6/8wB4pTXb+jU1wc=;
 b=urnGM1dib95X4t0O3Mz5/zAcljmDQIlBFYGf795UhXdDQWqEhqPQwr6Z0YrW1G6MyfEq
 8cz4raEyO2RYOUIuxU8D3djOw62jJgE+dzBb7j99JY9fsmpsxMPo8x46XQgcO2ev+PRp
 vESGv/qBW291crq7vQHqUbaTMIrwXtAKKO85CY989R8ptoNmTgP34C8+p2BboL8Ee1lC
 fv4UeNbx2CUhnFRTWX21eyk+ly2aIYTkNVOuSp/1tD+k1Bn3+cR8BZMHS7NLaMiXYiDm
 EcCB5mSWyivRjSuK6liDZhXxAGfXwI8Q71H/2IhIxAuIMvGbBCGgg6vsGQSBCo+c35mr MQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LItTM000430;
        Tue, 7 Nov 2023 21:58:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wskcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3wzFXgWyKvmeZipE6NooHTwT9JZUo/LijTyTRzT6xumoVjBxxLHFEM+iURMbu19jhO0mA0Sk2SNWh1bmd0yws4Hwm7wpYTke9I+TaBdYgwNoJ2Hg/pgFdXl3W4hFGwpi2c4dtdqpn6vIRLyei8VhemTizNcQjPQN3I4br2WT/SEmf5dyE21r1mCMoYFyHa1u8UHv943Q+jOMrad2gBLLzxZrip4hkMck7+ZEc2lo0GMAW3JgjdqN3fnXTNbg3WOoI3HogS2aiULc1nE75pkVfDPXBD2V0yvIcAtOj2xgfMepFHQyfXzZedi2Wmx9ViTXB6fAqxOe3tRyb8UKmcEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QNl8/K34dXXO4olXEeV1fgO+qg6/8wB4pTXb+jU1wc=;
 b=AXtB6rda9rLn9bsAOcCtaDvvXZA6Ai79L8NTNw2FO2ypmS+5nQEgdoOotBrZEYw3UKMSeAU3rVaCuFo3qy/Rqs7RqU09neTthvutJieEzzsSebkcx0g6ly0peU/o5Ed9RooTnzGwaBXcWhhInscqaLETGVWUO23F/VmxlfgfnhCADACKMSZcidoHnE11VQVyVy1BS+FnSHEp5GFDy/G2brZXjwaL1l23XLf4Jd7QDbOXj7k0rF6Hdjnr9A67ayrGkp+10B8+s626Cxg813SSYj5ONADE7PP9DzyrzPJnAcIqXt2bgROfOypHdl0ifOzWtMWwwB9gdteuZRe01Tmb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QNl8/K34dXXO4olXEeV1fgO+qg6/8wB4pTXb+jU1wc=;
 b=qumvcoUrFCKj/jBzFIkGnMoUPU5uFa3W3+LaTniwD26l1QGADtjCjliOEMjuC4Wnp8BtDbvHXv+htb2LQf3Z3vL15Ld4k849BiSpYovfSvJgTd4+Zy2b4A4+k3byzPgIwL8CzRfLlS+MqWO4yXd6ns6gQ2iqLCaI56G1oliKTfs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:50 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:50 +0000
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
Subject: [RFC PATCH 22/86] Revert "sched/core: Stop using magic values in sched_dynamic_mode()"
Date:   Tue,  7 Nov 2023 13:57:08 -0800
Message-Id: <20231107215742.363031-23-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd85dc8-e0b9-4c56-91bf-08dbdfdcb991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sB5YaQIy9UjhCF0FIBj8pdBQbaahg8IVrtuG0WIlEITh8gUa7eSORZ8wdQcL3T+ePBQhSYTADbF6+1y3jprXLg7iUeGVSKXYNHt/khxgzzp7OF9dSNnV7+zRFzV5XG7ZIitxkvBxdAWD9VJIIQHaRitWpAATV1MNCUSG1khfSjjxmQ03jSzmisR323KBFcSNCCtlbDh4uOF/yOS9px1Kf7chGq6Bz4ZrnVkOcJJ7yRNVdx6f58wm1vx0Cfi7gNvQkXpME0g5fOQotRqC/Fzz6zGQ+ACqtmbifFaWsPCIvxx7KVkqIvSLRj9U4v26mgQqQbOm4UiGMwgA9fkGvkGKIwTNfcdodrugAFvndAoR18yn18YuhhbYQ9wdOyfizFV6SwNxxkLaBdtfMvVqXypt/78H1U1wr4vFSZANWHk9NePVT3ziFk36+Fh/+o7a/aVKQCogw0tAjB/QkvSvEynawGYMEXNRYaEJ0PyyO7Rbb0wDtbvJ1nTuY+urrVMR3ctHwhLuPsUF+/O25ZZhFu+Lx+lsZjqhPeAPotSs+55nGzbGtvDGC1V7zgNdGz0vD22y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(4744005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+A9pe8CbYQgdIKVAkQwXSX02Yg2OjuKcW65GOuNh15dOt5lyVXtYm1wiJn+N?=
 =?us-ascii?Q?QFAUStGclKWt6LPWgweT3khMNmDimwLmsIDxBKrnydIn/0Bvik1NdfI76a9b?=
 =?us-ascii?Q?fiyXvpswmpoWv8fSCp05izttXqDigX14ixWZdgRQ+yEvjq/Gwi+yqVlr1BtY?=
 =?us-ascii?Q?o3VHt1fnAgLJHSGup75gY1MP8cG7Hvo8HwCL9diNc60jeAx6srFX6NCPcJr8?=
 =?us-ascii?Q?glZ2VjDJWuNr/LlXEuMmrkT1YZJ++6QmWfwrwxQOuKa4aaJg+NVdyrEgylyC?=
 =?us-ascii?Q?oiPybr5c1PJiobsizOSWF+orpCSqExvwWTYtunyyssQmiMXsRBuKQ0J3IBa6?=
 =?us-ascii?Q?IFAethgNPU+5QykB/y0IoXKVaIR8gPz9rplI785jbxW76kq3xqXvshVpRO/9?=
 =?us-ascii?Q?s6uVs37vY36q8vz2RtCtfeMoglAkAWkH9PfwXNQfgYpdbBZVKVuuVIUYqTat?=
 =?us-ascii?Q?EdmJpSjdpJhPwhRVFgdU3CDa+yDO40RTCGOP+2jbpvegh01XkGaOufMzOcWZ?=
 =?us-ascii?Q?xMoXq9JpX2wVuLDwRbRH4aAotzhM3IACWd3kftLHvWhANaDUUO5QbgEF5xeW?=
 =?us-ascii?Q?VUu16Xisui/2rWDS5DcPHECUcBJeNzMLnog7aN+ioWrAuKOFoY2DmpEtraGX?=
 =?us-ascii?Q?Ft5MeYSzVZMZ3I8HNGDbbHgZK4MI0XUR4z6azldv8xQTprn1T5z0KM5IYgeE?=
 =?us-ascii?Q?AB4D4NZ7BJ8QZoesFk5VPweIqvj8m1RnZn4gWcHrXPhhz66smSOkXWeexW4l?=
 =?us-ascii?Q?M7zA+i8OUzckE1Dj3T9YePYisfcwJYCB0xOCkBeYcHESEabjMJE5LpuCH65+?=
 =?us-ascii?Q?gpac7mZtaHj0hdJ+mPbIF2cmUH750xSkHzasQdpTeZIc9sXSoFc+CE3fI9Nq?=
 =?us-ascii?Q?456DgUfBEnh1srQG/DonPgESd2H2J2+kCc8mfa7GuBreb48qWXnEWhFtFHHu?=
 =?us-ascii?Q?WjjpaW4P3TJ2JabRCkDsj5Nj0apnI8vBxjzmUtX/e4W6Oym1faKLoZp5ehvs?=
 =?us-ascii?Q?FpW/sfiRFnwo8YRgJkF7u2eTJb7AhfpnA2Kd1Pd2AOAPY0mli+8dxur9X1ND?=
 =?us-ascii?Q?6IBO7SF5F5V2xDVcN6eYRTJ9OGEJw9bLQszIzQYBrTavGfGxEMOhjInRG7Bh?=
 =?us-ascii?Q?yhmaEyja5HzEnYIZMj3W2Xu+34moqrQUBDovfU6BM1+lUbrvFqNlsBCacfbx?=
 =?us-ascii?Q?3EIOM8M/0YvkhfW/fk0vdhZaVUk4BsPPdHYj3upU8K7jxaYH1EmUhXHqZpTG?=
 =?us-ascii?Q?eNLjW1HP0FCkwB/1tAHXDx8jK0o/sk4AtvZb79koHUQSTkElMnNw19/ElrXd?=
 =?us-ascii?Q?s9Yi8gQYGkHBS4rEvwnyH5IPVtbwXQg/yBrYMQ4LoZ6oBj7p/aq3F3zzJHp6?=
 =?us-ascii?Q?aN9tcY7m2cWUJk06cUgX8Y5Ny9I9qVkijUpq9TQIFuuJNlVwNEN1jI4NXOfH?=
 =?us-ascii?Q?Fjur+2EVlnHIogrH5rwqjRKBlMNJCEe+4ss1eP5mAWUhYfvf8S3PL8vnDszT?=
 =?us-ascii?Q?/BaauRAMi6CXgre7TWznpuNk0YrP3CCoI0KAqMtFoDoLWSs45jEbNf+ZxTrm?=
 =?us-ascii?Q?Ueo+YVZXY/+RESzXxpdTUEJ1/SlJ4hVTDQucalATJCwFCick+3oBkIdVEDXZ?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qYcx9XdB6TEWZs78ZS5U48KfDKaxSt9wpmWLComn4zoGpudYWYdzFL9nwJss?=
 =?us-ascii?Q?Dsxw092ExvP+hBIIZmwLUHCZQOM+8xVvXyUCL0kpiy4ov9NsfjXdKFiMcVyO?=
 =?us-ascii?Q?c1RJpA634Ij8vIHr1Nx7tz0QLVgJ/lvqjzCbkRY9iEPudSjf1t+XCnS4UHei?=
 =?us-ascii?Q?3TV8v37b+KmZ89RHbq9vjAyIJgSkb0dF35Q25XyyS2ZVUpXYYp4C6LhXO59E?=
 =?us-ascii?Q?8oTjjwDLU0UFbowXfoNMFM+pLRtZyhc09SlldGSn8kT8Hc5H3Q4BEvMPyyKB?=
 =?us-ascii?Q?e8Jb4H7bTsqTP36LkXQB3ncNiIbHD7KFf2q2rmFrqcnhv0wUhAt2wKaBsFD+?=
 =?us-ascii?Q?cYzm5VW8WiNPI+WGS4Onq3J8XQddFQkgysMPA62WU/b18ZRjMqpaWfuBwZbe?=
 =?us-ascii?Q?WGIyFunQZgRqOsTuiqu0+CCxCKB/IphTPhY7Qqk5dtCjoQ1i7hSB6swKlIzh?=
 =?us-ascii?Q?oPYh0N0+YzWmOj9jTUTbh9jFie6Vr46CTZcM391RnZB1xt3/IY1UB8yexhMl?=
 =?us-ascii?Q?+Ket9AWL0klksrdGcRZpv5BYCX5gvkNYVfdyIzLn8RVD1OSROh5mmq6l1RQU?=
 =?us-ascii?Q?zHyijU5xmX/scUpv9NqqH2vWaPOgxVw09rS7FwozKmk6+pKhlMSS5+XG4/qH?=
 =?us-ascii?Q?704O8Ay5eUg92fD4Zu9KuQAqLCDki0t4YKIDjcgoozeYCpG2JQNQRqzVUikW?=
 =?us-ascii?Q?z7Lit/FNI/eC5UNWxfO+3KJWLEixzcNoMvot55DT/ijn2WNLP85hFFA2XZOO?=
 =?us-ascii?Q?IA29PF/scifcug5i0sLQdIYINWaJazY2IZNncI/CKMD2MvH4Y9ZnjqOz/WLt?=
 =?us-ascii?Q?OB83qq/0frYvTTmheLfUzXBwOLhO6gXcLwsliyv2JfywylAx1ed1VdduAIKO?=
 =?us-ascii?Q?j5Cx7kYSTbJHkAUZxo6qDy4zTO8o2KH5LNdtjO5/2NrH/8mUeVs7yZzxESMp?=
 =?us-ascii?Q?MqYKFN0vDsQUBvMqfSqwXPEW7zoF1/aEV23WUDC4xGDOuKkuwGTFQZtV3lBh?=
 =?us-ascii?Q?+suBRoDqjZ3Etu/2e7FsxFeMiGAXsvK6PkGEzxpNf8ppUn+hA3mu10Ofn2QU?=
 =?us-ascii?Q?8nl9NJVeR98eCGuQ+r3b/WLHhEHuUTOIwRhqmIpYZY/bI9rM65WVrY+y2hnP?=
 =?us-ascii?Q?SfYy0o20ce68GSGMIiHwCXUk8nUCwWbZFgiBIuvEvr/QD/dk8pyD+TL0bmOE?=
 =?us-ascii?Q?Up6gun73n3w8J/7yWQ33DuppEvULboMMbjo32w9LxLsERsXYZU3t16FRUT94?=
 =?us-ascii?Q?s99cGn1wSoFB9BbZvKCiLa7q/oYvrlBdqzpUz7luJFRRnm81pfz2JP5l0Qfk?=
 =?us-ascii?Q?UxUiJh9S7uU+dHwP0AxpY2PRm1HIkxvtIzlG5eeS9xey2nRujnw6x6YZtmE7?=
 =?us-ascii?Q?BBei2kQS95g/Dso/oE4FbBnFOm7cDBG4Q8/kZrS9uMJIPobSA58PE57+/ClN?=
 =?us-ascii?Q?okebfyixjh0eYIxu4UNNc1fR4war5L0aUvTsAjd8+siVDMu43D3LJM2xINhr?=
 =?us-ascii?Q?PhVX3IxB6jULiSkidrAPLpvJm5FE+jFGq0Me3eys3oyzkLSgWDnWS/VW6A?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd85dc8-e0b9-4c56-91bf-08dbdfdcb991
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:50.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTyBNCgaeaqMtL1WSXdVlO5033PPD1ydJf91JuIkAQyPgaXSQDl9iVm0Y+wjxSsCBPqv5+31r8Nu0JEhawA4MVFzPvABKRIdsb0ZByyah2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-GUID: mRwN_D95aA5dNA2fOc2Hg6NsnuU4We8i
X-Proofpoint-ORIG-GUID: mRwN_D95aA5dNA2fOc2Hg6NsnuU4We8i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7e1b2eb74928b2478fd0630ce6c664334b480d00.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 673de11272fa..bbd19b8ff3e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7001,13 +7001,13 @@ static int preempt_dynamic_mode = preempt_dynamic_full;
 static int sched_dynamic_mode(const char *str)
 {
 	if (!strcmp(str, "none"))
-		return preempt_dynamic_none;
+		return 0;
 
 	if (!strcmp(str, "voluntary"))
-		return preempt_dynamic_voluntary;
+		return 1;
 
 	if (!strcmp(str, "full"))
-		return preempt_dynamic_full;
+		return 2;
 
 	return -1;
 }
-- 
2.31.1

