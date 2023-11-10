Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596587E75A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345538AbjKJAHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjKJAHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:07:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E17D44BC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:03:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MZxog026574;
        Fri, 10 Nov 2023 00:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=BrrQsJT6WKP/sKQzsTUJKusNm7kqjMMVvPXjiFnML3c=;
 b=Mi8JeI/UBz3YyscBBEZ303FMmceAkxs1YC75zKapwNi2vcREy46ZxJO4kNPHr8L7nrNE
 9SEx+9qYRKc+Eu1Q0LtPGykp5WcFzjcHpx9aCHKMN3R/SPJ8ZxIixjBG2lZZ1s4V/C1t
 pellX200s8FsHaJVCcrPg7xCwMQzDZE5T05Go6oaEiqPrbaswW/x9YMwl1XATp6vmC4u
 sFW7R4zA402N7cdWcnhNG7X0L4/LKR1kugIuz+0BTen6ZLBBvW0a5JzTdB2bEDUe/1Ul
 vn3WBI3e1h/Yy2Y2Fe5YmiltZ6+8O37BVPjuxVGIca+YG1IFco12iQa+6xC0LMs7sPKH VQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23n8uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 00:02:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MrV7G000446;
        Fri, 10 Nov 2023 00:02:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1ypwsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 00:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHPmzPVm//+tMPG/vx4x1adm+s65aX2anWTxy3H+lE53wBSTccQI16kVF7xvfawhr/PULGEoDsXFmFfOuMaABOTAm2O8x25BYC5yujIzmMfU2R7vI9pixMMP9CkWFUXOPco48re6bx67OtarPYzBv8/4W5n2Lob2Hi9N8jQzCM+B6Fx8INh1YyZcIE8Aod44n47B/Q0548fKs1DU26R8kSBPcuNYjM+Dj0NOc35c3UrpqeTIcmb4ZjGJI2SM6ed5o0Rtt8A1oj5EjJUQHlehyw66V9cHo5nehrwEt9GiKHV7VbpFuHlNoG+FSIQDg1oIvp3LUTxkhPutcELvKGyDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrrQsJT6WKP/sKQzsTUJKusNm7kqjMMVvPXjiFnML3c=;
 b=Cf/aFgo2iBS/GYsWHruI1X4vUZO83whtEPER2eG04tpWkbqRWN7vrcdMMlyAjogL/17IYObP+IRJDGsU9fJT2SzlJe0r4jfgu6tTm3PlT4u1yDD6QIILQizcrHqSUWZxGJMC8qsZ2VyBdIfRAzwbEROor0x6woHCaC/mvgD/sLKqQrR04L52Wg/QgjUZIs2F6a+QabH+4iYsMlwkE7t8TYjfEh8nXrrt+TZJS02FvfLoZX3fjPlDM0hI8Ny+Wu++kT2g+/mTAL/F3pHr8d75cvBY4PFnuKv77manWTUjYLcNfn1nzStz4xVWKE0/N+q4c5WY8TSrXJZsX1r4WnJI4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrrQsJT6WKP/sKQzsTUJKusNm7kqjMMVvPXjiFnML3c=;
 b=Hr77zTBTbGOhGQ0BSg8lkKeUPkJMxhFAG0pNry1H89mFEtOhQt/F+ekNef0bERGoAjkiTykOBEFND9Epa/Jv7C4EmRnYDN+UbP3qwazJty+VXxI1uZLu4P1N3yYcW4ekx+kzhiadb/mSave5kS8sr9p0N9OTGOFAjs/RLJMAnTE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA2PR10MB4714.namprd10.prod.outlook.com (2603:10b6:806:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 00:01:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 00:01:56 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-29-ankur.a.arora@oracle.com>
 <ZU1qgv1QNiSJFEOZ@google.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        Oded Gabbay <ogabbay@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Amit Shah <amit@kernel.org>, Gonglei <arei.gonglei@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Helge Deller <deller@gmx.de>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH 85/86] treewide: drivers: remove cond_resched()
In-reply-to: <ZU1qgv1QNiSJFEOZ@google.com>
Date:   Thu, 09 Nov 2023 16:01:54 -0800
Message-ID: <871qcybhn1.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:303:8f::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA2PR10MB4714:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b326655-b0b0-4572-f247-08dbe18040f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdfnpXRheD4IVDN3YuvPLe30IzOm8xGfJ0rUrX0l5MLGXbi2BHDcyR24OQsnbqKSPWguyhG7DuGeJOznf2puIO+LnwyDn5Icj5M24ub1vTPiSRjq4m3VZG5KYF3vfK4SQPx3laKIOx5R5YpysxM0fnfRh6pMzVKY8XT0x/iPqtg5Ol619CyReuSQgC9RcdS+wVFtM1Wkkw8ltPQLk4IX43xM+x28b1aQPdJMKOGKyRcn5k1yRfssS5PmiGEMuzZiCWr1NWfy+owI69fXnMxh4q7BMeO6FTkMgSyxD9zY097LCa4ZIx7m2wNuKqPvib++Ee8jVGbzrkzwOb73813qi7nYJeiOb4aWiCA7CGPXUI4GeFc2+K7terIYcwrdqL1GvgfAbV0kmWAftqS+mibPNMYWVa/dgfSF6cQKVL+4AgCeq3GWg1QMt/vi2UHhTamLkGxE6sIWvlUhXlfG/FJBnW2RQq6vrd20UJS8q5jjq0pUkgqnt+H+xsQ77+2EncvprTYZaBs/fxhb2U88IgN6JRCmUpFZh+O1orVoxqccWoVBodwChoK+9lmTsVo4e+b+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(7406005)(7366002)(41300700001)(2616005)(86362001)(7336002)(26005)(6506007)(478600001)(2906002)(6486002)(36756003)(7416002)(8676002)(316002)(4326008)(5660300002)(8936002)(83380400001)(6512007)(54906003)(6916009)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lqEGPuyZ33puUsqwqt5401j36Q3e2OYjGEvNXvxv2SUZyPFcSfiU7gk6wXw/?=
 =?us-ascii?Q?sv7JZXxRNwvjUrtIR2lblKXCnxQ/W47MDLkCIo17GsdAtD6O+iZrlohmLsjB?=
 =?us-ascii?Q?Gc3AaV+PpRcbClMFBMY7GP6uSDhHAs9+BO9S6wnk2mJU7BdoW94ld7PPh3hH?=
 =?us-ascii?Q?ZFAjZ+QI6hpXeCdaFBeSWEvHAFTptnnIR+gyCuvfIs6MtbwmY1YaPPxcuaay?=
 =?us-ascii?Q?1CUjC2rgUwZxYvVAXIB2PcVY0e56oi+fB1FIqoS7E4pJ9ie50kuWiyOUGr3N?=
 =?us-ascii?Q?YkNwIw8Ohwmy0mlRHgK9VJYa31buob6wsY7FkE4tRCTUAP7/VIHD0sp70KHm?=
 =?us-ascii?Q?KtELLbgwqzX1vKLj15rA8OXNqUIB2e5U5Qe5oFUQ3slDPA7Cvnu70QfU2/pN?=
 =?us-ascii?Q?47C4f8B9TLHfiMYlRNRWmue+A16mc8HUBBona3jyVecaE/cm1R4y0kZNrTEB?=
 =?us-ascii?Q?4bkgXbiwCPSwX8UXhyZ3xLkHWehCNPdXRmqfrd4k2nbtBzF0M0ZkK3z3Laoh?=
 =?us-ascii?Q?vXtW/+7qrIzANebFXUvqtDbFaZrLcp7YB5h8vcGzw2hkGd8AL7x780PgDdqB?=
 =?us-ascii?Q?KbfpUdBjBfhF8W3dXz050L3iOFGglB+BY9ZH/9xeoxW9fCBK6JUig1qSXI1z?=
 =?us-ascii?Q?9SaKp4wF9ZGKY/L+m5yI0LpyNJhgu1eK9IwMokc8xhmmAFAge9wgZ4DAMsOB?=
 =?us-ascii?Q?Uyjv6r8FX4ITSDjgHSXelYzuh7qX/iF/+lI20Zq01s1/Zib+4IMe+Ehr97kq?=
 =?us-ascii?Q?c1JpbIAuAbydaauC2Sxjqmc6QZpL4NxPPaqDewRjOsZG2lP+/jDA0tWDcpPM?=
 =?us-ascii?Q?lzVD+gjZJS7DoG3xTULthYyWJm7qP98DDVJwNQzxNrJHk55cTUVZosiq3ILV?=
 =?us-ascii?Q?/EHjh9GDF30IPlJN8lpq12e7KGGHXcAhSiYjbjcH1HUHjCaKCogvHvY4+Vep?=
 =?us-ascii?Q?dQmRVSUkzcWoN1n7KKqrdB/eD9YmlLysJq1Jm+ZNdjm2q+RDbDq/Dn5YreN4?=
 =?us-ascii?Q?N5BW0RR5KS/RF6dH4ewcQDl92v+D6F9n5korbxPp0bzM2CbkKPXv2YnRBVz6?=
 =?us-ascii?Q?qipiGucP4odzPWUFSioFXas0xN0hi7omNe68pAOrx9xZzirxBREzdRTjs4IC?=
 =?us-ascii?Q?mMeJDIL+EzQEBdsxOI9lAVZFb08IreNpnyIhDCe9KPb2qsXltJjPiDOhATXX?=
 =?us-ascii?Q?wvnVWTdPRHdCsOIbYzSWYgETU9M8N6VwXeQIshdoKM1Mr3qM75hkiRVfhoPU?=
 =?us-ascii?Q?yQx/nwTgNZqtONF26XzaOsm555s6JRZUMQMJ6LR8S1F9FPEEvPoOF21aPJBV?=
 =?us-ascii?Q?X4NCt2KQGbayS1NEszboujUP5QfOycXA21du6L9vUPADWmUHZU1l40+GwkEy?=
 =?us-ascii?Q?nzzgsMNsZg5ZTz2MCFpOttlyMcWQCK5+2qe4nRf/lj0pX0nJxvdolwzoitb2?=
 =?us-ascii?Q?hsx7THVGvEzACL0xNl7FxvEan9Y6m+nN9FYXZB8oiNuHQ7Zda6UJLuzdmKMm?=
 =?us-ascii?Q?OtfidSAmdCFLDQQitGeJRwPHGoYqo8d3fbunP0GkC1I23vHiMyIWRDTf+mQQ?=
 =?us-ascii?Q?OGsvWd30Q3lMJ16dXE7qPu7FT8ayAV5Z+dL24tOu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?um4UBDBplnGAjWQGNcp/Kh2EQIT9hQ42uUqpiLXBnhbLjg8O+LSfMrchrjqf?=
 =?us-ascii?Q?Yc/lYGp9rffkhhCXfQvMceJVefMtDNAdjgNZv5HB/iWxqnPYUtnYEdgMMSYh?=
 =?us-ascii?Q?/nHERACswrm07hycXoOwvJp3DaBMq4fGm6u2Gzmc1nV3bPrTmy0h/y7e1+OV?=
 =?us-ascii?Q?+nl5h3lnEoSYd/oQ9tOvWU2nusgW6LCA1MBcCLpUUXwvZPj8pu88FHFb81Xq?=
 =?us-ascii?Q?iQGvMHFV6MXhD/DzTilD2cl2LasXaGEVkdEdmV2qR6hdtMZcDwhZZBQcG8M1?=
 =?us-ascii?Q?oKz42gImK9TwMZdWbgp8NQ1l9/Jyu7qDHfSz4MVkIKPkNYzGJhHsIdxRvjoZ?=
 =?us-ascii?Q?qxltGjjlJPX5LnG6intH2kacIGFLRFCskcfEwAz2gBfz4yhu9UluueqcuO8t?=
 =?us-ascii?Q?BgmlMq/T3hSjWONBsq6ng76V5Clhp5VcOQjU5s3RtdS9OQcDanPhDe7YbH4q?=
 =?us-ascii?Q?3CiTBWSOS9EIwvY/XDF58aIk6tZfL8Q+c58HrvtmLibWcnKOcjc5/OSF41zF?=
 =?us-ascii?Q?TpFTU/CcoZBlf6pVpxcyWmNOxLryed3WbYYuav9r64l5XZPBo8puqGpUOP9Y?=
 =?us-ascii?Q?UhONT82U56CFuIPBW+U8S4gdBvvrT9nIfVyHv4pkpsFIZZb2obuEjL5g3/9m?=
 =?us-ascii?Q?se/Ue7Xn/ZlYhvaPA4aKoirzAZG9QcRCRUz9kM5kMYWGgCOt1cjAzStBoy4s?=
 =?us-ascii?Q?Ckf+3LrZSl9hMI63bevM0kefEpPBrPzW0MxQRusqpEpdrnlDgq4jKlzamVPp?=
 =?us-ascii?Q?Q4zX36gM7PF7LRZneTxr/CYgVhQznXdVanZHP0Gt8KEET1oxTRfwYUIL07O7?=
 =?us-ascii?Q?0DLOfxmQ9kMyod+evfH7hTw+gdcCB/3sO1zxln9QlJ0fwoGnG9J154Jea3fv?=
 =?us-ascii?Q?w6N/5aG/aGes1J3i0gp3bd7GwKnNT4Q0SoOQUZh7IQw3YCCdptXPthcIdBeI?=
 =?us-ascii?Q?APu50t1StfVprgK3BOVQ5eoKSo82p5UFS6YS0JeYNXB+DB7Ay/C47Euq2C0Z?=
 =?us-ascii?Q?o+XVLHvmtYMHViojy2pYmUoC8CaUIsVBZaaTktCE8lnpfCp1oIQ79Z2U6SMW?=
 =?us-ascii?Q?GyFDrdViuyDkraGGazthX7JIxThIJb9h/Mu/tGXGpzsqmEV9voaHQYmRI9gx?=
 =?us-ascii?Q?2hhagcP0OdaGlE4voOTomHid3iGA7IJIG8jkOAwbPbGlu7U2QiarlwT0ejgg?=
 =?us-ascii?Q?lwidqn4Y/EIUji/ine8y3mMgEm3H9JbGTjpcSAdDfMjWTk0brS2moi10B0y+?=
 =?us-ascii?Q?Ec3fXKTY2MpD38+lt/FPWRlEYA653ucj3IYq0gKQH/XXl2nO0sg63Vojygcy?=
 =?us-ascii?Q?/g1geBMDfYR0wWkBnL2TqSu/u1obhJEE3SIj6EBwVpJF1iHwwUp8zhoiF9Ce?=
 =?us-ascii?Q?I+m+fo/GakpWbG+qD3DXwj3XcvbPFyAWfybtZU8AKQ0HOt/4M+dZuISMP6db?=
 =?us-ascii?Q?T+fhaEMCy2Nt2+4OxlcgsxAhflm7OyTAM2yKr89s/pYK1msRD8qeurwTz+X5?=
 =?us-ascii?Q?Ig1RweZu2eFHD2oA3iBU9eNWEVvfSnZIxftqDvGZzftCooSO6SBeQe/mGMNz?=
 =?us-ascii?Q?HdTdINyUUp+Pd0/E0sbY/PbWFY6riST9w5qZdKvplljphUb1gRi1aB4JnjGo?=
 =?us-ascii?Q?+OsPwv79/JAu2Pz2McWj9OVA9/7WqVm7ldAfZ/pMC7wbPSgYItxTNO3zOfCu?=
 =?us-ascii?Q?40uhM+E0uxSVlqtkXh16RmWkPjLLKpViZiRrruUXy6+HVChlGAoeITJFGbop?=
 =?us-ascii?Q?Is9C5KyujSGhRrUfjaB/kJJsWZrk1kpPLuGbaMfpKIiK/38LH4VuPujN4gQk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: CbTE5vNuP3hK34qsQBpRq1EnJj6v0y5HZSbyNfvV7d9mqOQIxflqH8+/QOk+qfuYw2o1Imq/Axl5tF8Ck40/09JIYyQlZ6YMPEJUHNs5ifhsHrTVXbIiwOV/QGDhMuCZhrHQGmhihfGhI0uCJWljYvx0aVGCEJjHoybfDr48LH5EfuigQEYFjMtRdc9Ix8oB2e7tN48H6rjC/aaEBbya8fa0fYa68sUuON7KJVuGTn/PWa3NJMajWmnL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b326655-b0b0-4572-f247-08dbe18040f2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 00:01:56.6318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0JpaQ0a7c/HFh0KEfSw+947EPsRRYoGogL18WyuhN8DqZV9es6UFt/nEnrN1Jlw5ITq6GeJtVmf4r012mVFL1SIL/qxrgPGZ4nkoEGjgVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=778 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090177
X-Proofpoint-ORIG-GUID: IfaEsNjxlfv4QvmhFHKMNxINEZNzgazp
X-Proofpoint-GUID: IfaEsNjxlfv4QvmhFHKMNxINEZNzgazp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> Hi Anhur,
>
> On Tue, Nov 07, 2023 at 03:08:21PM -0800, Ankur Arora wrote:
>> There are broadly three sets of uses of cond_resched():
>>
>> 1.  Calls to cond_resched() out of the goodness of our heart,
>>     otherwise known as avoiding lockup splats.
>
> ...
>
> What about RCU stalls? The calls to cond_resched() in evdev.c and
> mousedev.c were added specifically to allow RCU to run in cases when
> userspace passes a large buffer and the kernel is not fully preemptable.

Hi Dmitry

The short answer is that even if the kernel isn't fully preemptible, it
will always have preempt-count which means that RCU will always know
when a read-side critical section gets over.

Long version: cond_resched_rcu() is defined as:

 static inline void cond_resched_rcu(void)
 {
 #if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
        rcu_read_unlock();
        cond_resched();
        rcu_read_lock();
 #endif
 }

So the relevant case is PREEMPT_RCU=n.

Now, currently PREEMPT_RCU=n, also implies PREEMPT_COUNT=n. And so
the rcu_read_lock()/_unlock() reduce to a barrier. And, that's
why we need the explicit cond_resched() there.


The reason we can remove the cond_resched() after patch 43, and 47 is
because rcu_read_lock()/_unlock() will modify the preempt count and so
RCU will have visibility into when RCU read-side critical sections
finish.

That said, this series in this form isn't really going anywhere in the
short-term so none of this is imminent.

On the calls to cond_resched(), if the kernel is fully preemptible
they are a NOP. And then the code would be polling in a tight loop.

Would it make sense to do something like this instead?

     if (!cond_resched())
        msleep()/usleep()/cpu_relax();


--
ankur
