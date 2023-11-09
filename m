Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E67E619A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjKIA41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjKIA4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:56:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BF71BE6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 16:56:23 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8NJq9A007780;
        Thu, 9 Nov 2023 00:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=DjwmuJX7+uTGma3xEKvPAXWY6I6F2Zu34tkHlcU/P5M=;
 b=tn+iai/QVttdjdag9tVwB+MfyQWis1SE6tBVBNP8JpGdeaB1GwP5lyc1ib5ZeQJoynf5
 8GPoFjEEU0lufPFc5OqPBTGHyaD41noGkBHImsLqIIeDLbGbpcw4ZYGmdJvHImUzPtUT
 t847fukdNM5PpP0txoihlIS18WutJmEJpjEsDLFPPA4vnm+sGrWVzkq/ivaMWikzqOL1
 LIot4pYdU/81SG99FDsAdDekm+1eOyTLi5ToKGsE1ataPdkTsBGIqYoB6c/bTdPrO7pr
 wlfLjCYg+7jZkHjPHyySmVB41VQSlyLm8voViS0B7Mqx5Gio2LesguXWH7R4HBwwynHI Hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26tuwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 00:55:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A90W8Mv003920;
        Thu, 9 Nov 2023 00:55:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1xme7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Nov 2023 00:55:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN07p+eLDWzwyTfEzffF2sJedLN/hTOW5JdUBi0UBGdDaV3DuRlTrYj/K0CaeNdjxZSa11UJ3pZJJW+W9wRUkdDmO9yxz5tp+XKkd5mPUIvTVD2uYhrhZ2y2SxmwjtNXCHlhKGR4cBUOILNsn8wokQ55iDt0Qb1JtD5VbVrm/M6TqiHFnfYczHrDT+DSOh5CnqxqHXYva/Cp48SggVpl85M+1L9MxxGQvPlRTvwbDAx09q1MEw+Q9Qn2AfqaZE5P8PTzt2s94ty07h/S4hCLnSHgqhq2O4+jCgVIq0FCrAuGHEHDDpsOpFOfXrOve+hfPN+YDPug0yMaKtyoSrFzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjwmuJX7+uTGma3xEKvPAXWY6I6F2Zu34tkHlcU/P5M=;
 b=Cl0fxx21/5NzT8wocq5GEK3670jqW0Vf+wVcwAd6LjspknpucYnFDvTRUojnTN3u7y7C4Q0zGyqmyK0K50T7NWjWF4Y3e/02+VuwiEi0vTLpG272upUqXe5z8hwBaJEpCT6KzQho4WseEN6m8Y3SzrujERxnsVCqcyh6BDfaCw0oHOBJU7SVXBKZH5ameO5nqIc1Xk3LlbrWO8vCs08C2hCapAsKRwIVITFN2jLwwk4ci7QbHBcyPTE2nGvnbwTWOJR3mXB2/E2TanrvBuXsEVzTOi0ts29SR1AkT9lY7+FvsBsreoqxvx1PZ23bPLARYxId7dAygOynv/vZZW9XPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjwmuJX7+uTGma3xEKvPAXWY6I6F2Zu34tkHlcU/P5M=;
 b=Js694lxIE8AOgRT+SvB51KAg786tlixnTyLq7ool5rLhoXQjIexhlzrxXyAwlM5a8dGMZfplhFWzHZh+UlXjgX+katNHH+vU6VpKoXu88kao9XY2Z1PW1NX+0/di2BdacjSBF8Lph/dBEmxoPc1796w1i8T65b+R16IGfKqFf/M=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6920.namprd10.prod.outlook.com (2603:10b6:8:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 00:55:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 00:55:02 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-29-ankur.a.arora@oracle.com>
 <739dd8ac-cbc9-434d-9726-584ccdf83afb@alliedtelesis.co.nz>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "jon.grimm@amd.com" <jon.grimm@amd.com>,
        "bharata@amd.com" <bharata@amd.com>,
        "raghavendra.kt@amd.com" <raghavendra.kt@amd.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bristot@kernel.org" <bristot@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "krypton@ulrich-teichert.org" <krypton@ulrich-teichert.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "richard@nod.at" <richard@nod.at>,
        "mjguzik@gmail.com" <mjguzik@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Amit Shah <amit@kernel.org>, Gonglei <arei.gonglei@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Sumit Semwal" <sumit.semwal@linaro.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Jens Wiklander" <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Helge Deller <deller@gmx.de>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH 85/86] treewide: drivers: remove cond_resched()
In-reply-to: <739dd8ac-cbc9-434d-9726-584ccdf83afb@alliedtelesis.co.nz>
Date:   Wed, 08 Nov 2023 16:55:00 -0800
Message-ID: <87edgzeoez.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:303:2b::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 60833533-22e6-484e-3609-08dbe0be8133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2q5jtblSP5LZ0JGZpdpwP9jsRZc4Dcip8wCrzk3shQEABil5XwKz9PXtl4QCjC90lFCK8mS3QfiYABBHvJPoQnb+RYM+VekbKudIbzZ7TOaFATSZuJVWdcWZvNhKm9Uvq117LHjt1o2Wa8rSWfher2/Q8dg4EE/k/1s494Dy6ie4GdeUbw0FV4xfa1Uq6M0qhV0LIALpbouiptYEb4aPurC7yWzbaiLEd1/RqlusYg2We2Swx0/xOopOETEi46I/DHP1o/F6rRYep27fv1uHG2B5cZxA8bsXu673br/PiAUEB3gXYcE5VmFxPo5odbCPYAo4uD9MySZ2JBU404GNGthyNzuQ1fBzXreG3jOUMnvkTW2db0bmrFwtaJBCn0OL/HOxr0IrJ36N++VUGwJfd8mcmeTNPTQ43HLk1hBWMx8y1E6KwQHPs8mTNjvA+bWA5rYwchzFUG2ngYG6o8FNtwIwe2Bmm0cEycL8KS4B8eAfTSUAxZutOBWROEVnnwi6rjiwR4p9MbUSaG1kAiJIlYXqrIn4TNnEiJgzOmCFVpVMdowZxI0pbPx+zDp1jbU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(53546011)(6486002)(478600001)(38100700002)(6506007)(6512007)(36756003)(54906003)(316002)(6916009)(2616005)(66946007)(66556008)(26005)(66476007)(83380400001)(7366002)(8676002)(4326008)(8936002)(7416002)(7406005)(7336002)(2906002)(66899024)(41300700001)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GxioZEHBaMSKwGOTuD87ae8g7yflghqot2MjYMbI98wbL+Sd40Q9mrie7LBU?=
 =?us-ascii?Q?EdKfQvAn68AMrjEocL+qZxXXnFMntjnGMpO5kTwXsQl4GHVZ2gYmhLW85yaJ?=
 =?us-ascii?Q?elXNZGoLYlju5Y/Mw5fzMp7jyCo6BQKmEYtr/Jey2DcJPJjHiFLjjcK8FT87?=
 =?us-ascii?Q?JD1OUgw7U7RtHg3UBy2yHWCffb8pyCQ827O8p8AtFUlQpAi398xwJCUq/bCV?=
 =?us-ascii?Q?Ss3lMZc12vzHF9uIjHF914Q3W3EjmJJ7v5YA+gNeZPO04UyntZg58VJu1qVa?=
 =?us-ascii?Q?nI1kMZay88QgtmD/6TVWC/ebvUzAVRFMHCLzXLuoQgQIKv919iB2LZhe5nHQ?=
 =?us-ascii?Q?G6faK1O6KwjR9510oUFpGgO2cd+DU9jZsjnQOlvtBPnQDS2nsEvq5Go6c6dL?=
 =?us-ascii?Q?Lz52tVxS8VzJ12qA1ACiMNk8/zrrS77FnuUfHDv8KTcIgJm2ZixI1ke1h9kn?=
 =?us-ascii?Q?gQczVy9aCvf2FqGbXwl/9GzFbmIRkzUllA9S6DgLoOkQoshPGJAtSSjX1dl4?=
 =?us-ascii?Q?4XhAfHLgEMjq7fP4lMCfnjdXKE9RROvTaQUe9AeYF3Dmlv0mSY+nLPqmZIIz?=
 =?us-ascii?Q?BX1M42NcLB/gRHM1D2lIUOOEVYvOTYFnlLEXnlUWD6qkOslLtueqM31BaE1V?=
 =?us-ascii?Q?e37QYUvPsTsOyXd5782qzmljxUqa+SZUTh2Chd8h0GfV9os9XKpzufdOVcO+?=
 =?us-ascii?Q?X8kEL44v38jW3IX2/WvPSOPKWGTLRMoOH050YZHe/Qy67IycwSQABZw3sFxP?=
 =?us-ascii?Q?Mdo2AcQnBZ9LjjBRkC3F0uyDwBzNL09ITogdhYF1S4uzzB7OdFeVhN3jnl8D?=
 =?us-ascii?Q?RGe3s9DB55MhQLLGDQmFsEQngOQSL3G3EKoW1bKVt5b8E3JTzZidL5l6o0JE?=
 =?us-ascii?Q?mCwmO1Fc1g54iibkFxdv/35vsslXqDFSaYfFSFNtbRKGxlnW+JP8yJj8Zf8o?=
 =?us-ascii?Q?xyBkmiHETp0yMz06g20+kgYxEoU9ur4JElxmaP/t3WBkMD+2CGtwZU/yI9jw?=
 =?us-ascii?Q?c6UEo3sRhV59nlg3beeIWcRnn+WQnCsmf2W/HFYenR+FKsRSLRbLSuS1M6Z2?=
 =?us-ascii?Q?z6sPIl237kC5O82oRvUrif6krsX0XER8WApW+H41gWv7XPzszGg3sfoVxqbM?=
 =?us-ascii?Q?tylrRuEXQn0INLVUC1euB0w/FsiBMyD3yDdUTwAHugAxdbw4D0Deu6hwK1bd?=
 =?us-ascii?Q?GXM6RpIg2+fEnvfYc//m9b+rxxTvqBiCZFzKXsM5n61imRF5b182vvyDioeJ?=
 =?us-ascii?Q?M+BHt9Huqzro8vQLHNvet/PXavjR1y1HPDt0NzdSDRpC4Lh1gN/nWCBh0zd1?=
 =?us-ascii?Q?1Jbu7/OM6iyvrzxC21JFcvw3zmUVz4k1coAoJuW6Q5DJECgj2VTAaEJSSFFa?=
 =?us-ascii?Q?kzJ1zVbQUviSviguHZMnRWGJPyH1yHua6Tz8xJFfae0wKYuFhAl4Ru72N/G9?=
 =?us-ascii?Q?NuVpNNsW1X9oQ2Me0YEW8hRLeopHFRjJEffROXk2Y+Bkc7Eavli7tSkpNE2F?=
 =?us-ascii?Q?7WHhko63LuvS40nNe9zac2cDo8ABRdx06pzv8c/2WVUaM/sDvdOtS7pb5I9l?=
 =?us-ascii?Q?j/f4DOPohC5wKdYYQ+mpTMMhCXsiVHtdYjl4J9T0mYktBS6yYaDgWeyAyz9N?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?y2j32Y0JNg/gI2KD2kXA/acB4VXhlwEYQ01HoKzlBeXDvzzoscQDLISEjiJX?=
 =?us-ascii?Q?BSc+0ACJApoff/+MOptXtcTYc45lwfVzPZwA/6STBB1BPcko22OdE7fyrYl2?=
 =?us-ascii?Q?wkUH8rtaa6znUYWg7sMDmCUzcRtyq8K8H9MbP8WA2RJGjyX0Go7a9ZKTbEUS?=
 =?us-ascii?Q?KtQAfBn8g2sEz5q975DYrY2tQH+jdQdDqcEzUp7tve++sTSYSXTLJDlAl7Eg?=
 =?us-ascii?Q?Z2h5FDIGOGDcRbOx4ECJLNbO9jnHe7mSrxvRKLTQ/ZVmyviMNIQPewnwyrwX?=
 =?us-ascii?Q?Q0UWlRxi7Col/yHTEOdSIieE6NwvVyciwyxmEQh4CvEQYrsu4aI7V03EMUc0?=
 =?us-ascii?Q?pM2MunqjFQoLwu+/1S/kACVDD/pDePXYKgYv6AFmfYvqI9k4YPLyBPhGXEtC?=
 =?us-ascii?Q?Vazy64KrtNgsY299EmCw651iHTBMoFQHbPHXdhll6MetVK3nuFfODLAe2K/W?=
 =?us-ascii?Q?rKL3E5oeqffSaaw+cmUF2vu3d2cmAii45yHRiHZHK9Dc1u8qzLlNP5rF/540?=
 =?us-ascii?Q?zeBW+RPUNdnm6/q4REuq0QprryzxONeqrg2PntWheBRTXEfOMpPoGwqKjh+0?=
 =?us-ascii?Q?4BWHJ+ZsR4ZftiCKHkWQk+59cOcy4l/3ZTMdmTQGasbRnBZ5tSgajeUAAKTx?=
 =?us-ascii?Q?VDNhqX+PtimRTq8P+7flV8VSajxfKKmytWbPV92br1hpF3irsq6ODpxElZJo?=
 =?us-ascii?Q?KcTRcNIShzJPnBePFUg+UkA0kKQqiFkkdm35n3yoIZMeYRMsAYDcYQABQ77S?=
 =?us-ascii?Q?rLVNgSrYPUAbwXKnElrhfTI1A3MyKEGCxIAN952iuEU70Bwk3XdB7MDCnb7a?=
 =?us-ascii?Q?4Y+pGjIEXPakvbYVidJXD/8UsgtMOl1Rht+bLVR4ygTewyzR9tp7zkDs3Og+?=
 =?us-ascii?Q?IVHPSmj8wAB5G3KjymLK20szEZD4nQdtlxNxbF7P9CJtHqZqHNfa/Pdv+J/K?=
 =?us-ascii?Q?aSCGSAb3VqGHfSnpkkyUCj4jLam/CrxTd4EvdzGs/kO9sNhDXiWpWKUSiEmD?=
 =?us-ascii?Q?driq4SwSFkjp/akvdkCXadwddzM2m7RnEsm+/7Ke43zHQLN0PgsG3j4xXxcQ?=
 =?us-ascii?Q?d/5qOowyi04nm+MmqTw+wJgRSRjMHwnPxSdUEV9YYUYVcu2bYiz5e5EIJZOz?=
 =?us-ascii?Q?4w76OQzvLvBibgSxaxu5RGf03YP9Lh8BQukcM+clf0ELaGk1geNFk4ZzBKvm?=
 =?us-ascii?Q?ADuh9ckSbJ7XFDj3EF21w1Kdp35FaKeojNa9QOp3qlFnkKmkpgHJd3moKSDN?=
 =?us-ascii?Q?fPc4csf0ycFNbWV+ob6HJXUX6Mk8ejRnAePSgFCXOFc6CHVCMrU0CqB/5v83?=
 =?us-ascii?Q?GpLDuElp0ay179WgmkR23tVQ6PTWa4nnUK3e+CGpjzdFYAyFb3ghJufDkPw/?=
 =?us-ascii?Q?0u7aA0pEhwxg0f57AeuwXut6hC8HuOKXvr99XTyTRlR1efVSTtfBtP39dxF5?=
 =?us-ascii?Q?u9Qi8ns+Wj/hQt6WY0r93iXxu7tq8lhGKEml0V/ShDKsjlM/41gLxjTbEbAN?=
 =?us-ascii?Q?/mYNy8VCvMqknk0/Q0lgKVorh7pY0eSMXa+SzaMFkwlTg+yZN9I7KEwAMREg?=
 =?us-ascii?Q?Q6i73NtiTEkkXPkstYfM1MUrmUVSDqqxaKLLxV66W81GWAUe+1ZmbTS5ruUa?=
 =?us-ascii?Q?w3M0FuTBhJeEqLmBbXULSUKqTzk1ob4/rWr8ta+473VFB6gM9PvNZqWvMFOM?=
 =?us-ascii?Q?ManzIW95HBbziW4kvUukIGMSMUM4PsQuFlZNVdpF8QvQD4jj2V2GC2tjOGS8?=
 =?us-ascii?Q?feVc0d8MIfwi9nNnLP8j8LpicC/Ot/1hUAvEH+nrXS/qS6qsEvPn89dwXGV8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: S1tbmcJC0Y1jXYhXGFOIs42hiU9hfLWeAJghd3ZWrWpgvkg3AlOENYPzEKMlQEpMWB7CfjGSR3Gql7gNIpEImPWhQD3ijlMon+m4SNdesz9XXrtbfzoy+0ESgRx0EUsLWCHvwnbH7/KK8HjaGc691YRzO/yHchaQfBussd6rl9/CWE/vLqA9wh9F0fE4r8lgB3cFI8IsUTxutqLpBtHFGCyh+hdR75ABXyNeUO4KzXvN/+nPkIE3N9i1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60833533-22e6-484e-3609-08dbe0be8133
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 00:55:02.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQtoFIqSpJhdxSOI3n/HjpsQYMGIolomsQPyAaGyYMyORKKQRNvX/FhHPKI7ddCA3udFPjsPWfKrCaBAePmlKuuydkp3MmY83EbnbPnSOAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_12,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311090005
X-Proofpoint-GUID: H3ojD9Dhr4IloFWcMPqo_DPVmDqsvR3n
X-Proofpoint-ORIG-GUID: H3ojD9Dhr4IloFWcMPqo_DPVmDqsvR3n
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:

> On 8/11/23 12:08, Ankur Arora wrote:
>> There are broadly three sets of uses of cond_resched():
>>
>> 1.  Calls to cond_resched() out of the goodness of our heart,
>>      otherwise known as avoiding lockup splats.
>>
>> 2.  Open coded variants of cond_resched_lock() which call
>>      cond_resched().
>>
>> 3.  Retry or error handling loops, where cond_resched() is used as a
>>      quick alternative to spinning in a tight-loop.
>>
>> When running under a full preemption model, the cond_resched() reduces
>> to a NOP (not even a barrier) so removing it obviously cannot matter.
>>
>> But considering only voluntary preemption models (for say code that
>> has been mostly tested under those), for set-1 and set-2 the
>> scheduler can now preempt kernel tasks running beyond their time
>> quanta anywhere they are preemptible() [1]. Which removes any need
>> for these explicitly placed scheduling points.
>>
>> The cond_resched() calls in set-3 are a little more difficult.
>> To start with, given it's NOP character under full preemption, it
>> never actually saved us from a tight loop.
>> With voluntary preemption, it's not a NOP, but it might as well be --
>> for most workloads the scheduler does not have an interminable supply
>> of runnable tasks on the runqueue.
>>
>> So, cond_resched() is useful to not get softlockup splats, but not
>> terribly good for error handling. Ideally, these should be replaced
>> with some kind of timed or event wait.
>> For now we use cond_resched_stall(), which tries to schedule if
>> possible, and executes a cpu_relax() if not.
>>
>> The cond_resched() calls here are all kinds. Those from set-1
>> or set-2 are quite straight-forward to handle.
>>
>> There are quite a few from set-3, where as noted above, we
>> use cond_resched() as if it were a amulent. Which I supppose
>> it is, in that it wards off softlockup or RCU splats.
>>
>> Those are now cond_resched_stall(), but in most cases, given
>> that the timeouts are in milliseconds, they could be easily
>> timed waits.
>
> For i2c-mpc.c:
>
> It looks as the code in question could probably be converted to
> readb_poll_timeout(). If I find sufficient round-tuits I might look at
> that. Regardless in the context of the tree-wide change ...
>
> Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Thanks Chris. This'll take a while before this lands.
I'll see if I can send a patch with cond_resched_stall() or similar
separately.

Meanwhile please feel free to make the readb_poll_timeout() change.

--
ankur
