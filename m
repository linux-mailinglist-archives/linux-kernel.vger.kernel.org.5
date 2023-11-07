Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B767E4C9E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbjKGXRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjKGXQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:16:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A50110F3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:16:53 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJqb1022727;
        Tue, 7 Nov 2023 23:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bnOsTQbfjeCIBrAeCLl3w+O5mhu2+1S+mL/poDVtqmI=;
 b=X5CvKLhHa6azy/mrK3p8tfydOoyBHYChc/UtaET1mG9AbOGzmslrGKMkKIb7++0oEU58
 IZNHZID3o8oVAmXRUw38EBWGBxiKntxxtp61p6EmaUtXps5qtUIUnYUWsjQ1aLc9rohH
 6vH7n7gECuEfc+NnCFn0Ji6RO5DuM9P4+ptskwOeqVXa1rAW8K52gkYHT+2IMU96vy1D
 hyGvsCJqUEf1oXiQN7XKbdAvPI24obKZ5bRkLJurcjfIhpTBvp/9NwUuzZeY8TwbwV34
 E7cIl0vCpG8S+ieq5a6AKmb3CFwUmFczHNGIYqeky/K+FZ7iEh/ftbxlqVc3cjLrI2u3 AA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2006h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:10:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2hO8003851;
        Tue, 7 Nov 2023 23:10:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vvcpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:10:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C20WCijwzwdmdHY5kBE1tTvqFnW6GUl59HNQHaeNb6NVwtfbdaV2CjUapcT6o0Bp4mOXmdl1mf07VNF5ZTfiX3tEHHVthuvduWJQ0eoEaEnbMVv/N4NSgTNXHeSY6D1YwuJWOSQcgsbCFyMleWEN2xc42mD0xxxV5IDBMkNQHuECTNDHKC1Q2s5q+8LnGiPwVu+vyRr9w1aXa10OQurh3xXG9hmHx9tVL2+nz3xeABrwbHwV8w00JWRa58CaGylLf9HVKUbYrxBAP4FzpG3zJkozsVOEu2fPqP7iJQmasJ9b4ZllYa5IBoPmenpTyEURg17A04mAyuGR2S/IfiazBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnOsTQbfjeCIBrAeCLl3w+O5mhu2+1S+mL/poDVtqmI=;
 b=FhIhvQRQ3u/4P/pZq7RyQs0Gck9IpYRxh3OKNpg0ER1OwEX/q7yF6RlUOnQOWAJM3f6FBqyGqJv4MJIx+pkRtQp5gq5UmksCWFYxIy9ZDdhYkd2uQI7IGtXOBW1e9kUgx8CxG/08oFQrUYFyO3cfenZ523kdKJFFGchHT+VifJJFZ2afGjllybT+lSIY8/W4li25g2E5GtnN6RQA/pyibyCqKH3So9hyj4F280cBJLVZi6CmGdWDhOXU1UDf5FUM2MgTKoyk9y39xXVt29ri73/ylHelLUhRgd8+MWzA8raw23K5xzwbuVqtEH+XLgPhuo/y2o9RrvNsJjWp0up9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnOsTQbfjeCIBrAeCLl3w+O5mhu2+1S+mL/poDVtqmI=;
 b=KeLPJvRUDA573NJwgN30v4qzGpQB7X4arhLZ5pXQmO6GewLsb1pXcRKfJl3VAqoQVsgfkEG2dxUC5Qfvc8dJuZZPJK4UeCaV70k0gUtL7hAaEqOvIil0FkIXVQnQt4wGKrDRgHj2/Z/wDRC3nfKFbQfnezzI0oq8SeM99HU94TE=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 23:10:03 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:10:02 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
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
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
Subject: [RFC PATCH 85/86] treewide: drivers: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:21 -0800
Message-Id: <20231107230822.371443-29-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:303:dd::20) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|BY5PR10MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: f71382c8-a5f5-4dea-8729-08dbdfe6abd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGlZM9iC5FoeqiYdFDc+LzAp70ALbEAy6J2WBOKLXCPckRGSblNaf/KIXUFzdMi2VwRyuc+IyZYrGXW4asz0YKzrOzdMJxi6f1HEos9jH/bikZBhVKbWDGueJbmEc0NN/shZ4ZJwV5F7go3vORq5cAaBCzbcGIaMgu+yCjC5mIK+UTxh3w987dqj5ZiJw/nujxebSsf6GbEG5+OuAQpYz8aJ0DW6sQ0nXuohNRANe1+jpXMa2VrAK5lu2ThPTZktF4GFMwW0prpAttVKCJWV15/sreWnvM+nphr83d77ACUnM9ugkAQXJQXDMJCbZzvEFGD7zIVETWby5Y5Q//y6JHRh5N8bMI93mwPGQONKdlm6X1+81oDG2MLQUcWFXR7GG5Z1UTNgc3VTtE44blSUAvFnh4YEMm+5nQ7RJWnREYEGTNYOG6cBGC8mMWSQiBoWqFptNnk6lf9YBmxMMEYcSPoVy589u3+cXSetHejBbLngJnnLFrAmaT013TwTil/zUD5F3ah237wHdimLlusGuvsn4+kQKBJjV/qWdogRZTU2/ucHGtgW1p1KsJUV0qsoDI7ZDuTNiwbIn6fnkI53Rtq7yzt8vbRlAZOd8kHlRx16vM99RLElXgz55rl6Ugzi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799009)(64100799003)(66899024)(66476007)(66946007)(66556008)(54906003)(38100700002)(36756003)(86362001)(103116003)(83380400001)(26005)(66574015)(2616005)(6666004)(1076003)(6512007)(6506007)(6916009)(45080400002)(7336002)(7416002)(7406005)(7366002)(2906002)(316002)(6486002)(966005)(478600001)(8936002)(5660300002)(30864003)(4326008)(8676002)(41300700001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkQ0dXBXcE9tOWcrbFB2R0ZnbkhWZmRNMENlSmxSVFhhNjQzcFZOc0lneVZC?=
 =?utf-8?B?Ry81cWdkb2lsM3ZiczNRaW04cklzZHFkWG0xekY2RHJHbHhUbXRDRkFScnJD?=
 =?utf-8?B?U0N4MFNkK2t5S25zaWVLamtRdkM1aFIzNHFMajZ5L21mZWFEbk1tOHJIUVZ4?=
 =?utf-8?B?cmkwMnZ1WUVuNEIvcjhBMWIrRmtMaXpRQmNBaFpDZVVKam51Y0VtMDA5Sm8z?=
 =?utf-8?B?SVBoK3g0RGtoVGxRRkpHVnBnQWoxU2VyVlpLQjVQQU10eHpvdktqMXU5YWVi?=
 =?utf-8?B?aE8rQjRUU3pUWTQ0SjZKUS8vYzVpM1BLbnFEQ2pvTlhGTGtJSTNZa2p6NHVz?=
 =?utf-8?B?NDZwM2dtankwbWxyTkJvWEhmYWxWbWpOem5VTFoxWTZGbmZOQnhtUGx0WkM4?=
 =?utf-8?B?eEJYMFQveCs5cUZHUjQ5dFBuL3J4bk9qWGJJRjZydkxCY0wwYWdTbVRvRDh3?=
 =?utf-8?B?TFJRSlo4eVFVQzUxOGc1T1BxY2FaUUIxTUt5QnVFYzdSVHRqZEF0azByWHJ2?=
 =?utf-8?B?VVlhcDBwTDdDTjdKWGhiYU1FQkNlQTVCTWhZeUl1bi9maHV1dEdRVHBXZENB?=
 =?utf-8?B?MjNBbGpWVkpLQ0UzY1FXR0QzdThkQmR5YTl1OVhDdmlSbUxna2tGY25EczlU?=
 =?utf-8?B?eW92RmVqNGZ5MUJqU3JiS1JGMmRTZkJqRmxiM2pEcndTbXk5WG8wSXpxNHB3?=
 =?utf-8?B?M3ZTRVQwUTNBd3hVUm5LR3BtQnUvS2VlaGlZMlFJdUp2NnZwKzBxMmdONnc2?=
 =?utf-8?B?V28xL09zbnJtRkdCNy92Ykhsa2Vka2d1UnNZNWxDNk5aRXdESlpNaHFaSEdG?=
 =?utf-8?B?d3dsdFZFUkVoTDB6aUZ6bXp2Z2c1ODlHMHdzeUY5K1NmRUV0WGppZGVXOVVB?=
 =?utf-8?B?cDVUNjduckxiQ3Fjc3dqeW1HMFJ0NzJGQk94cE4zWEl2NStrcW1qb29CT1JR?=
 =?utf-8?B?bWR3RE04dVVaUVdOV2tCQktrZWNqRW5pY3c2QmczY2pXa0Z4VHdvS2wvTUtX?=
 =?utf-8?B?UFYzaC91Z3VvaGRwSTljaXk4ajNpSnB0WDQ1ZEhDV2xselg3SCtJOGs5YXpV?=
 =?utf-8?B?S2g5OHRKTmNOd3ExbnEwdFdHKzY3WThaRFFWRVZQRWxJSEdYUGFNVFM3VXA2?=
 =?utf-8?B?UVV1YjhQczU3bkxhUHdLTFRoUnZFU2tPRmpmM1dLQ09iVUFuOGJrZkpCQkx2?=
 =?utf-8?B?WUZMbmZacjB2VE9aQzRRL1V5OWhuOURtTFBaRnNtdmNvbnlSS2lkRHU4VnQ1?=
 =?utf-8?B?NjlUd1hGdjl6VUhLWUw5a1lIQ3ViRk1hTlV5UXlVS0Q1YWlPMVh5Ti8rMFVS?=
 =?utf-8?B?SWpOcEZ1cXE2KzA1cTR1WkpoUkIyK3dhdGdnQTJ6aWJVMENMVnlXWmVVaVFG?=
 =?utf-8?B?RHdoMmhQS0VHdWJlTVpQcmF5cnNPR1dEU0srUjRLMlRMSXZUYVkxZHNlUy9a?=
 =?utf-8?B?M0t0ejZiZmZTVXRWRHQwZ2s2ZHp1VjQ3ZTJ0Q05Pa2FwWnV4Rzh4VUR0VWwy?=
 =?utf-8?B?dlZSNEsrL2dTV3BpMnBUdkU0a0lrMEdhZWUvU1djWFJJN3ZHOERzYThhTFJB?=
 =?utf-8?B?RS9CV3M4dDhsMVJaY0ttTU1JUUVKaDY4OWo3aUlMWmkxNzRnUXJQa3d4MmpS?=
 =?utf-8?B?WnByQ2pwQzhBQzNvU3c5SG4xUElmVE1tTVYxbDAvczVqTHB2cGlXTkp0dkZI?=
 =?utf-8?B?ZUl0bkFTcW5YYnBjenZjdFJsejUvbkpJaE4vWWlTZVJOWURWQ25iMGZEZnBw?=
 =?utf-8?B?eUgzSWs5VSs1N1V5ZmRkOG0zamE5Y1RFNkliQXpZNTdYbURPVjZaMENuNVpx?=
 =?utf-8?B?V1c2SmNJY1NmM1hTY0xobjY5OUN2Rm5ReG9TUmVSUno4VEhQWlBIQ3UxR2RM?=
 =?utf-8?B?SnVEN1J3VGx2SnBTNjhjRm1tTzY1RW5RZERxeXVkZEQzODRZMFJiRjkzUzBj?=
 =?utf-8?B?REsyamQyUGM4ekdnTXlJbmFCVFozaktLTzZNdngzaGs0RlFvMGZqRTY0LzEr?=
 =?utf-8?B?eFRXamtjVm9QejNuYWZpTlo5RnhWNjBrSno5Tk5nQWdDamIrdUxLeE1PVDEx?=
 =?utf-8?B?RGRoMjdZSFIxb2dtMmFYbVJoZTN3eDBTQkM2bHQvS3kxYUdtRERvd1A5c0tX?=
 =?utf-8?B?aHQxTzZpM1NUbFZ3U1RLdzExOW5tbjNiVHFNdkpIdWVZQUcwTUFsMHkvdzN0?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?LzFoRzZ1eDQ2RHRLdldIY1E3ajZkY1N3RS9LeVB2V0o2ekFzNmEvWEdQWllT?=
 =?utf-8?B?YmRsK0lJT2VoYmYwNUtEWDk0RHpPMWhlTmZzVG5SaStrZmNuQVpLd1ZRanND?=
 =?utf-8?B?UHc4MzFqM1phdWx1TEdVMDZLVS9UbzJzc0xHMjIzRnR1NFZBcUxSVkEzMzMz?=
 =?utf-8?B?bXB0YjBSY0pqOGhMOStwWS9nQ3RzWHhrU0hodkpxMW1JTjRzS3JaazNuNGN6?=
 =?utf-8?B?ZFZ1RzU0NFlSeTdQYmZ3UFpzS2s0UncrY1h3L0pGMFF0bkJOZVFLamFGU01N?=
 =?utf-8?B?Z2VsY2lvWXpuYXFEU0pxY3pORW5tMS8vYVhUQlJwQktIWEZGSmdkZlFhclVy?=
 =?utf-8?B?UTRNQmRVYy9tT01ra3lmQUpOTUM2ZWt3dk82MlJWTHFFNVVUOTRRMUdQdTEz?=
 =?utf-8?B?OWMwSjVaRG1KcGNEeG84ZVIxK3FxbjBGaEpmeEU5Qk5qUFdxWm1kWW5wYzRD?=
 =?utf-8?B?TlNuUldRaFQzeXRTalBxTFV4VjdkTjBIMDVPOU93bHVWKzJxV2s2SVhxZkJk?=
 =?utf-8?B?T25SOXZXUXlGeWdaSDBRSm1DQmhiWC85VTRWazJjMGtBaEJZcEZXdEhPVHJt?=
 =?utf-8?B?TjhSUCttMHBrMGNuV3pZaXE1SDBJWGlScURMVXgzVmRJcHh3elgvSDJ6RFBq?=
 =?utf-8?B?K0t1OEczNGdYU0JsdlNpWkZsaTluT2FHUVdsbktDUGFnTXNPTGhUUmxjWGpl?=
 =?utf-8?B?VndtN2ZjK0RuNmRLR3BMaWFqMEJDL0wwRWg3WFBHcEl6bEdVMEwzQmt5cU92?=
 =?utf-8?B?UVhsZ1FJVkdHL2RrSXoyTVhjcnNKZmQrekl1TTNmOUJjQWFXd2R2OWxiSmdI?=
 =?utf-8?B?SW1CcjRKMWpVUUUrWHFoUGxyallaOWhZajUxNFF1dGRzZnJTdGZiS2YxdzR5?=
 =?utf-8?B?YmJmM3NEcitJeE5ETHhIdTRxWkt5VzhWczdEaG9SdTkvMzduTGl1MmJLMENC?=
 =?utf-8?B?N3E5dnNWK0pKbHAydnBYZUYwVDNLc0ZwaVZjcEJmTVd4YWpZUmE5OGFDUEZ1?=
 =?utf-8?B?aU55WXNGWko2RmRGdFNYUVV2SDQzbjZiR1dsZkNWMk9oLzlaUDNnNGhaSWov?=
 =?utf-8?B?UVc1d1FSOTlLVjVwRGFJbkR5bk9IQndZTE9SZnhJTzBZdDhta2tvMUZXMkZO?=
 =?utf-8?B?Qk5rN2FFNmw1RkJwRkRoVnlaWld1QjZGallVRi90RjVPa0ZRTGErb09SRkdJ?=
 =?utf-8?B?ZzVHaUFJY2twRnVMU0lFbjVBcWZ2cFZKUEM2NVdYQitQOUhFT0VudW5QRFky?=
 =?utf-8?B?NTRhOVQ4Y3JPL01xdFFmaTlxcmN0a0JWWFpXZlYzSGFWaVpQNU85bkRteE8y?=
 =?utf-8?B?V2VyWUZKQXE2TUtJVy9LeTdIUmxMazd4OUU1OG90UEx5bTJKbUlEdzg0RUlS?=
 =?utf-8?B?bXRzS0NhbS9zbUJBR0FXVzFhaHdMVFgxbTFoZ2hyOCtCQjIzZE5DR1VEdWNP?=
 =?utf-8?B?ZTBzYWFiZHVObWtPc1U4L21ZWlRlbHBPcnMvZnowY040RWxvcGw3Z0JVWGl1?=
 =?utf-8?B?TmcyMThobGdYakZjVEpqRTUxVTg2Zm1XVlVaekRacENxdlE5cll1NENNeFd0?=
 =?utf-8?B?L0EwenI3U0llMlZmekE3QlE0Mk9KRXRZU0JMcnFYLzNqdDJSV2Zhc3NqTEZo?=
 =?utf-8?B?K1hWU3crbkNKSm9TTTl2M0xVWmFrWnczSVNMcXc1WndqZ1VMVjlheFpDTlNi?=
 =?utf-8?B?dzZoamRBaXF5UTVEaXJsNUZob28xaUNrVHp1NXNKSExibDhDWjFta2VXdWJR?=
 =?utf-8?B?OXl5VXFzbDhPSG9iZHhsblpSL0VIbklQaVdpa2VBV0VnaVVtcHVKcG1wUnFQ?=
 =?utf-8?B?M2kzdGc0L0ZMeFZncHFXanVhVkVTVDFsbE0yU2VpVDBOMlFzYVNMS3o3bXhj?=
 =?utf-8?B?VklBeUFDMURNRzZFK3p3azAvM2xKZ1I2bGFCQWdRdC9FUkNReFdtK3JET2Za?=
 =?utf-8?B?WFRVNGdFUnNHempKQXYrbjdCVGlxeGxGVWpXZkRsY1BKRnRnNllOcDI1dXM5?=
 =?utf-8?B?d1hlNHNYUkFLOHFzdkN5bVFoV003Y1dPbkZVV2FKVlBUaU1MNGthY1BYclBP?=
 =?utf-8?B?VlhjV0gvSXpPa05iTUZSQXlBK1h3Ris2RTFCQ3JkKzBXdkJNWmNITEJkelc1?=
 =?utf-8?B?V2M3MnozTndNRDZVaHllSDk2NHBXZjZBcCt2U3UrRi9pc3JhM0g4aXJVVzJ6?=
 =?utf-8?B?aHdKRE5vWUxqaXNPREdMKzNobXRsZHpoV0Q1SzhJSTRsd0JjQ2M5QW5Uak91?=
 =?utf-8?B?MVNNbnBTdnZwSEdMTGZkRWlOcDFjTUFub3JrUWtoVDdRQ292cFE4amVXQTNm?=
 =?utf-8?B?NUVQSWE0RnN0MXJuNTZsM2phc0lBWTZNcTFtbGxvdnNLSHRLVTN1VlRuUjRV?=
 =?utf-8?Q?lBD5zh9oEq6JNbV2s4qSlEF8iVLcZT0dbwpUoXgYUtoJk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: jxRLUkvkNaTELVcAIFtjfoddys3ZnzNW+VAD4eP9Kb2tp03N4ZxXBknFwHxphj1RAejV/Sbnf5pB85yr4bMd/xHaKo9Ab4qmXnBsyddZm9EL1XawvtQTKCzDtSRKHREYSHBwhBaYlDE7s6VJsRqGRdHFm+1YTZ1prX/nfuugQDEWt1b63QyjFLcEOpTu5BybMxrJzWTZYnsJnkCLWYDaBdDlxiRr7TxdKuucz5DW89aYgE395Q2KTIQ/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71382c8-a5f5-4dea-8729-08dbdfe6abd4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:10:02.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOrPVwLWrBdgGibc5ZVKru25iResNf7qVJwFa4avaDgxflczKz/0CwrpJr0BssO0P15N251XVfYWfh3mbBF5qajgXrQF9m7o2k7z6X/S7J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: F6lsT5xpG88aXfqNGpfe5b-DJNewMqX3
X-Proofpoint-GUID: F6lsT5xpG88aXfqNGpfe5b-DJNewMqX3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well be --
for most workloads the scheduler does not have an interminable supply
of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

The cond_resched() calls here are all kinds. Those from set-1
or set-2 are quite straight-forward to handle.

There are quite a few from set-3, where as noted above, we
use cond_resched() as if it were a amulent. Which I supppose
it is, in that it wards off softlockup or RCU splats.

Those are now cond_resched_stall(), but in most cases, given
that the timeouts are in milliseconds, they could be easily
timed waits.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Oded Gabbay <ogabbay@kernel.org> 
Cc: Miguel Ojeda <ojeda@kernel.org> 
Cc: Jens Axboe <axboe@kernel.dk> 
Cc: Minchan Kim <minchan@kernel.org> 
Cc: Sergey Senozhatsky <senozhatsky@chromium.org> 
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com> 
Cc: "Theodore Ts'o" <tytso@mit.edu> 
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com> 
Cc: Amit Shah <amit@kernel.org> 
Cc: Gonglei <arei.gonglei@huawei.com> 
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: Jason Wang <jasowang@redhat.com> 
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: Davidlohr Bueso <dave@stgolabs.net> 
Cc: Jonathan Cameron <jonathan.cameron@huawei.com> 
Cc: Dave Jiang <dave.jiang@intel.com> 
Cc: Alison Schofield <alison.schofield@intel.com> 
Cc: Vishal Verma <vishal.l.verma@intel.com> 
Cc: Ira Weiny <ira.weiny@intel.com> 
Cc: Dan Williams <dan.j.williams@intel.com> 
Cc: Sumit Semwal <sumit.semwal@linaro.org> 
Cc: "Christian König" <christian.koenig@amd.com> 
Cc: Andi Shyti <andi.shyti@kernel.org> 
Cc: Ray Jui <rjui@broadcom.com> 
Cc: Scott Branden <sbranden@broadcom.com> 
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz> 
Cc: Shawn Guo <shawnguo@kernel.org> 
Cc: Sascha Hauer <s.hauer@pengutronix.de> 
Cc: Junxian Huang <huangjunxian6@hisilicon.com> 
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com> 
Cc: Will Deacon <will@kernel.org> 
Cc: Joerg Roedel <joro@8bytes.org> 
Cc: Mauro Carvalho Chehab <mchehab@kernel.org> 
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> 
Cc: Hans de Goede <hdegoede@redhat.com> 
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com> 
Cc: Mark Gross <markgross@kernel.org> 
Cc: Finn Thain <fthain@linux-m68k.org> 
Cc: Michael Schmitz <schmitzmic@gmail.com> 
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com> 
Cc: "Martin K. Petersen" <martin.petersen@oracle.com> 
Cc: Kashyap Desai <kashyap.desai@broadcom.com> 
Cc: Sumit Saxena <sumit.saxena@broadcom.com> 
Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com> 
Cc: Mark Brown <broonie@kernel.org> 
Cc: Neil Armstrong <neil.armstrong@linaro.org> 
Cc: Jens Wiklander <jens.wiklander@linaro.org> 
Cc: Alex Williamson <alex.williamson@redhat.com> 
Cc: Helge Deller <deller@gmx.de> 
Cc: David Hildenbrand <david@redhat.com> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/accel/ivpu/ivpu_drv.c                      |  2 --
 drivers/accel/ivpu/ivpu_gem.c                      |  1 -
 drivers/accel/ivpu/ivpu_pm.c                       |  8 ++++++--
 drivers/accel/qaic/qaic_data.c                     |  2 --
 drivers/auxdisplay/charlcd.c                       | 11 -----------
 drivers/base/power/domain.c                        |  1 -
 drivers/block/aoe/aoecmd.c                         |  3 +--
 drivers/block/brd.c                                |  1 -
 drivers/block/drbd/drbd_bitmap.c                   |  4 ----
 drivers/block/drbd/drbd_debugfs.c                  |  1 -
 drivers/block/loop.c                               |  3 ---
 drivers/block/xen-blkback/blkback.c                |  3 ---
 drivers/block/zram/zram_drv.c                      |  2 --
 drivers/bluetooth/virtio_bt.c                      |  1 -
 drivers/char/hw_random/arm_smccc_trng.c            |  1 -
 drivers/char/lp.c                                  |  2 --
 drivers/char/mem.c                                 |  4 ----
 drivers/char/mwave/3780i.c                         |  4 +---
 drivers/char/ppdev.c                               |  4 ----
 drivers/char/random.c                              |  2 --
 drivers/char/virtio_console.c                      |  1 -
 drivers/crypto/virtio/virtio_crypto_core.c         |  1 -
 drivers/cxl/pci.c                                  |  1 -
 drivers/dma-buf/selftest.c                         |  1 -
 drivers/dma-buf/st-dma-fence-chain.c               |  1 -
 drivers/fsi/fsi-sbefifo.c                          | 14 ++++++++++++--
 drivers/i2c/busses/i2c-bcm-iproc.c                 |  9 +++++++--
 drivers/i2c/busses/i2c-highlander.c                |  9 +++++++--
 drivers/i2c/busses/i2c-ibm_iic.c                   | 11 +++++++----
 drivers/i2c/busses/i2c-mpc.c                       |  2 +-
 drivers/i2c/busses/i2c-mxs.c                       |  9 ++++++++-
 drivers/i2c/busses/scx200_acb.c                    |  9 +++++++--
 drivers/infiniband/core/umem.c                     |  1 -
 drivers/infiniband/hw/hfi1/driver.c                |  1 -
 drivers/infiniband/hw/hfi1/firmware.c              |  2 +-
 drivers/infiniband/hw/hfi1/init.c                  |  1 -
 drivers/infiniband/hw/hfi1/ruc.c                   |  1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  5 ++++-
 drivers/infiniband/hw/qib/qib_init.c               |  1 -
 drivers/infiniband/sw/rxe/rxe_qp.c                 |  3 +--
 drivers/infiniband/sw/rxe/rxe_task.c               |  4 ++--
 drivers/input/evdev.c                              |  1 -
 drivers/input/keyboard/clps711x-keypad.c           |  2 +-
 drivers/input/misc/uinput.c                        |  1 -
 drivers/input/mousedev.c                           |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  2 --
 drivers/media/i2c/vpx3220.c                        |  3 ---
 drivers/media/pci/cobalt/cobalt-i2c.c              |  4 ++--
 drivers/misc/bcm-vk/bcm_vk_dev.c                   |  3 +--
 drivers/misc/bcm-vk/bcm_vk_msg.c                   |  3 +--
 drivers/misc/genwqe/card_base.c                    |  3 +--
 drivers/misc/genwqe/card_ddcb.c                    |  6 ------
 drivers/misc/genwqe/card_dev.c                     |  2 --
 drivers/misc/vmw_balloon.c                         |  4 ----
 drivers/mmc/host/mmc_spi.c                         |  3 ---
 drivers/nvdimm/btt.c                               |  2 --
 drivers/nvme/target/zns.c                          |  2 --
 drivers/parport/parport_ip32.c                     |  1 -
 drivers/parport/parport_pc.c                       |  4 ----
 drivers/pci/pci-sysfs.c                            |  1 -
 drivers/pci/proc.c                                 |  1 -
 .../x86/intel/speed_select_if/isst_if_mbox_pci.c   |  4 ++--
 drivers/s390/cio/css.c                             |  8 --------
 drivers/scsi/NCR5380.c                             |  2 --
 drivers/scsi/megaraid.c                            |  1 -
 drivers/scsi/qedi/qedi_main.c                      |  1 -
 drivers/scsi/qla2xxx/qla_nx.c                      |  2 --
 drivers/scsi/qla2xxx/qla_sup.c                     |  5 -----
 drivers/scsi/qla4xxx/ql4_nx.c                      |  1 -
 drivers/scsi/xen-scsifront.c                       |  2 +-
 drivers/spi/spi-lantiq-ssc.c                       |  3 +--
 drivers/spi/spi-meson-spifc.c                      |  2 +-
 drivers/spi/spi.c                                  |  2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |  2 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |  2 --
 drivers/tee/optee/ffa_abi.c                        |  1 -
 drivers/tee/optee/smc_abi.c                        |  1 -
 drivers/tty/hvc/hvc_console.c                      |  6 ++----
 drivers/tty/tty_buffer.c                           |  3 ---
 drivers/tty/tty_io.c                               |  1 -
 drivers/usb/gadget/udc/max3420_udc.c               |  1 -
 drivers/usb/host/max3421-hcd.c                     |  2 +-
 drivers/usb/host/xen-hcd.c                         |  2 +-
 drivers/vfio/vfio_iommu_spapr_tce.c                |  2 --
 drivers/vfio/vfio_iommu_type1.c                    |  7 -------
 drivers/vhost/vhost.c                              |  1 -
 drivers/video/console/vgacon.c                     |  4 ----
 drivers/virtio/virtio_mem.c                        |  8 --------
 88 files changed, 82 insertions(+), 190 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 7e9359611d69..479801a1d961 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -314,8 +314,6 @@ static int ivpu_wait_for_ready(struct ivpu_device *vdev)
 		ret = ivpu_ipc_receive(vdev, &cons, &ipc_hdr, NULL, 0);
 		if (ret != -ETIMEDOUT || time_after_eq(jiffies, timeout))
 			break;
-
-		cond_resched();
 	}
 
 	ivpu_ipc_consumer_del(vdev, &cons);
diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
index d09f13b35902..06e4c1eceae8 100644
--- a/drivers/accel/ivpu/ivpu_gem.c
+++ b/drivers/accel/ivpu/ivpu_gem.c
@@ -156,7 +156,6 @@ static int __must_check internal_alloc_pages_locked(struct ivpu_bo *bo)
 			ret = -ENOMEM;
 			goto err_free_pages;
 		}
-		cond_resched();
 	}
 
 	bo->pages = pages;
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index ffff2496e8e8..aa9cc4a1903c 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -105,7 +105,7 @@ static void ivpu_pm_recovery_work(struct work_struct *work)
 retry:
 	ret = pci_try_reset_function(to_pci_dev(vdev->drm.dev));
 	if (ret == -EAGAIN && !drm_dev_is_unplugged(&vdev->drm)) {
-		cond_resched();
+		cond_resched_stall();
 		goto retry;
 	}
 
@@ -146,7 +146,11 @@ int ivpu_pm_suspend_cb(struct device *dev)
 
 	timeout = jiffies + msecs_to_jiffies(vdev->timeout.tdr);
 	while (!ivpu_hw_is_idle(vdev)) {
-		cond_resched();
+
+		/* The timeout is in thousands of msecs. Maybe this should be a
+		 * timed wait instead?
+		 */
+		cond_resched_stall();
 		if (time_after_eq(jiffies, timeout)) {
 			ivpu_err(vdev, "Failed to enter idle on system suspend\n");
 			return -EBUSY;
diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index f4b06792c6f1..d06fd9d765f2 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -1516,7 +1516,6 @@ void irq_polling_work(struct work_struct *work)
 			return;
 		}
 
-		cond_resched();
 		usleep_range(datapath_poll_interval_us, 2 * datapath_poll_interval_us);
 	}
 }
@@ -1547,7 +1546,6 @@ irqreturn_t dbc_irq_threaded_fn(int irq, void *data)
 
 	if (!event_count) {
 		event_count = NUM_EVENTS;
-		cond_resched();
 	}
 
 	/*
diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 6d309e4971b6..cb1213e292f4 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -470,14 +470,6 @@ static ssize_t charlcd_write(struct file *file, const char __user *buf,
 	char c;
 
 	for (; count-- > 0; (*ppos)++, tmp++) {
-		if (((count + 1) & 0x1f) == 0) {
-			/*
-			 * charlcd_write() is invoked as a VFS->write() callback
-			 * and as such it is always invoked from preemptible
-			 * context and may sleep.
-			 */
-			cond_resched();
-		}
 
 		if (get_user(c, tmp))
 			return -EFAULT;
@@ -539,9 +531,6 @@ static void charlcd_puts(struct charlcd *lcd, const char *s)
 	int count = strlen(s);
 
 	for (; count-- > 0; tmp++) {
-		if (((count + 1) & 0x1f) == 0)
-			cond_resched();
-
 		charlcd_write_char(lcd, *tmp);
 	}
 }
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5cb2023581d4..6b77bdfe1de9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2696,7 +2696,6 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 			break;
 
 		mdelay(i);
-		cond_resched();
 	}
 
 	if (ret < 0) {
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index d7317425be51..d212b0df661f 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1235,8 +1235,7 @@ kthread(void *vp)
 		if (!more) {
 			schedule();
 			remove_wait_queue(k->waitq, &wait);
-		} else
-			cond_resched();
+		}
 	} while (!kthread_should_stop());
 	complete(&k->rendez);	/* tell spawner we're stopping */
 	return 0;
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 970bd6ff38c4..be1577cd4d4b 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -111,7 +111,6 @@ static void brd_free_pages(struct brd_device *brd)
 
 	xa_for_each(&brd->brd_pages, idx, page) {
 		__free_page(page);
-		cond_resched();
 	}
 
 	xa_destroy(&brd->brd_pages);
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 85ca000a0564..f12de044c540 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -563,7 +563,6 @@ static unsigned long bm_count_bits(struct drbd_bitmap *b)
 		p_addr = __bm_map_pidx(b, idx);
 		bits += bitmap_weight(p_addr, BITS_PER_PAGE);
 		__bm_unmap(p_addr);
-		cond_resched();
 	}
 	/* last (or only) page */
 	last_word = ((b->bm_bits - 1) & BITS_PER_PAGE_MASK) >> LN2_BPL;
@@ -1118,7 +1117,6 @@ static int bm_rw(struct drbd_device *device, const unsigned int flags, unsigned
 			atomic_inc(&ctx->in_flight);
 			bm_page_io_async(ctx, i);
 			++count;
-			cond_resched();
 		}
 	} else if (flags & BM_AIO_WRITE_HINTED) {
 		/* ASSERT: BM_AIO_WRITE_ALL_PAGES is not set. */
@@ -1158,7 +1156,6 @@ static int bm_rw(struct drbd_device *device, const unsigned int flags, unsigned
 			atomic_inc(&ctx->in_flight);
 			bm_page_io_async(ctx, i);
 			++count;
-			cond_resched();
 		}
 	}
 
@@ -1545,7 +1542,6 @@ void _drbd_bm_set_bits(struct drbd_device *device, const unsigned long s, const
 	for (page_nr = first_page; page_nr < last_page; page_nr++) {
 		bm_set_full_words_within_one_page(device->bitmap, page_nr, first_word, last_word);
 		spin_unlock_irq(&b->bm_lock);
-		cond_resched();
 		first_word = 0;
 		spin_lock_irq(&b->bm_lock);
 	}
diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 12460b584bcb..48a85882dfc4 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -318,7 +318,6 @@ static void seq_print_resource_transfer_log_summary(struct seq_file *m,
 			struct drbd_request *req_next;
 			kref_get(&req->kref);
 			spin_unlock_irq(&resource->req_lock);
-			cond_resched();
 			spin_lock_irq(&resource->req_lock);
 			req_next = list_next_entry(req, tl_requests);
 			if (kref_put(&req->kref, drbd_req_destroy))
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f2d412fc560..0ea0d37b2f28 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -271,7 +271,6 @@ static int lo_write_simple(struct loop_device *lo, struct request *rq,
 		ret = lo_write_bvec(lo->lo_backing_file, &bvec, &pos);
 		if (ret < 0)
 			break;
-		cond_resched();
 	}
 
 	return ret;
@@ -300,7 +299,6 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 				zero_fill_bio(bio);
 			break;
 		}
-		cond_resched();
 	}
 
 	return 0;
@@ -1948,7 +1946,6 @@ static void loop_process_work(struct loop_worker *worker,
 		spin_unlock_irq(&lo->lo_work_lock);
 
 		loop_handle_cmd(cmd);
-		cond_resched();
 
 		spin_lock_irq(&lo->lo_work_lock);
 	}
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index c362f4ad80ab..9bcef880df30 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1259,9 +1259,6 @@ __do_block_io_op(struct xen_blkif_ring *ring, unsigned int *eoi_flags)
 				goto done;
 			break;
 		}
-
-		/* Yield point for this unbounded loop. */
-		cond_resched();
 	}
 done:
 	return more_to_do;
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 06673c6ca255..b1f9312e7905 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1819,8 +1819,6 @@ static ssize_t recompress_store(struct device *dev,
 			ret = err;
 			break;
 		}
-
-		cond_resched();
 	}
 
 	__free_page(page);
diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 2ac70b560c46..c570c45d1480 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -79,7 +79,6 @@ static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
 
 		while ((skb = virtqueue_detach_unused_buf(vq)))
 			kfree_skb(skb);
-		cond_resched();
 	}
 
 	return 0;
diff --git a/drivers/char/hw_random/arm_smccc_trng.c b/drivers/char/hw_random/arm_smccc_trng.c
index 7e954341b09f..f60d101920e4 100644
--- a/drivers/char/hw_random/arm_smccc_trng.c
+++ b/drivers/char/hw_random/arm_smccc_trng.c
@@ -84,7 +84,6 @@ static int smccc_trng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 			tries++;
 			if (tries >= SMCCC_TRNG_MAX_TRIES)
 				return copied;
-			cond_resched();
 			break;
 		default:
 			return -EIO;
diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 2f171d14b9b5..1d58105112b5 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -478,8 +478,6 @@ static ssize_t lp_read(struct file *file, char __user *buf,
 			retval = -ERESTARTSYS;
 			break;
 		}
-
-		cond_resched();
 	}
 	parport_negotiate(lp_table[minor].dev->port, IEEE1284_MODE_COMPAT);
  out:
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 1052b0f2d4cf..6f97ab7004d9 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -92,8 +92,6 @@ static inline int range_is_allowed(unsigned long pfn, unsigned long size)
 
 static inline bool should_stop_iteration(void)
 {
-	if (need_resched())
-		cond_resched();
 	return signal_pending(current);
 }
 
@@ -497,7 +495,6 @@ static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter)
 			continue;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			return written ? written : -EAGAIN;
-		cond_resched();
 	}
 	return written;
 }
@@ -523,7 +520,6 @@ static ssize_t read_zero(struct file *file, char __user *buf,
 
 		if (signal_pending(current))
 			break;
-		cond_resched();
 	}
 
 	return cleared;
diff --git a/drivers/char/mwave/3780i.c b/drivers/char/mwave/3780i.c
index 4a8937f80570..927a1cca1168 100644
--- a/drivers/char/mwave/3780i.c
+++ b/drivers/char/mwave/3780i.c
@@ -51,7 +51,7 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/bitops.h>
-#include <linux/sched.h>	/* cond_resched() */
+#include <linux/sched.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -64,9 +64,7 @@ static DEFINE_SPINLOCK(dsp_lock);
 
 static void PaceMsaAccess(unsigned short usDspBaseIO)
 {
-	cond_resched();
 	udelay(100);
-	cond_resched();
 }
 
 unsigned short dsp3780I_ReadMsaCfg(unsigned short usDspBaseIO,
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 4c188e9e477c..7463228ba9bf 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -176,8 +176,6 @@ static ssize_t pp_read(struct file *file, char __user *buf, size_t count,
 			bytes_read = -ERESTARTSYS;
 			break;
 		}
-
-		cond_resched();
 	}
 
 	parport_set_timeout(pp->pdev, pp->default_inactivity);
@@ -256,8 +254,6 @@ static ssize_t pp_write(struct file *file, const char __user *buf,
 
 		if (signal_pending(current))
 			break;
-
-		cond_resched();
 	}
 
 	parport_set_timeout(pp->pdev, pp->default_inactivity);
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3cb37760dfec..9e25f3a5c83d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -457,7 +457,6 @@ static ssize_t get_random_bytes_user(struct iov_iter *iter)
 		if (ret % PAGE_SIZE == 0) {
 			if (signal_pending(current))
 				break;
-			cond_resched();
 		}
 	}
 
@@ -1417,7 +1416,6 @@ static ssize_t write_pool_user(struct iov_iter *iter)
 		if (ret % PAGE_SIZE == 0) {
 			if (signal_pending(current))
 				break;
-			cond_resched();
 		}
 	}
 
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 680d1ef2a217..1f8da0a71ce9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1936,7 +1936,6 @@ static void remove_vqs(struct ports_device *portdev)
 		flush_bufs(vq, true);
 		while ((buf = virtqueue_detach_unused_buf(vq)))
 			free_buf(buf, true);
-		cond_resched();
 	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
 	kfree(portdev->in_vqs);
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 43a0838d31ff..3842915ea743 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -490,7 +490,6 @@ static void virtcrypto_free_unused_reqs(struct virtio_crypto *vcrypto)
 			kfree(vc_req->req_data);
 			kfree(vc_req->sgs);
 		}
-		cond_resched();
 	}
 }
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 44a21ab7add5..2c7e670d9a91 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -634,7 +634,6 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
 		if (!status)
 			break;
 		cxl_mem_get_event_records(mds, status);
-		cond_resched();
 	} while (status);
 
 	return IRQ_HANDLED;
diff --git a/drivers/dma-buf/selftest.c b/drivers/dma-buf/selftest.c
index c60b6944b4bd..ddf94da3d412 100644
--- a/drivers/dma-buf/selftest.c
+++ b/drivers/dma-buf/selftest.c
@@ -93,7 +93,6 @@ __subtests(const char *caller, const struct subtest *st, int count, void *data)
 	int err;
 
 	for (; count--; st++) {
-		cond_resched();
 		if (signal_pending(current))
 			return -EINTR;
 
diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
index c0979c8049b5..cde69fadb4f4 100644
--- a/drivers/dma-buf/st-dma-fence-chain.c
+++ b/drivers/dma-buf/st-dma-fence-chain.c
@@ -431,7 +431,6 @@ static int __find_race(void *arg)
 signal:
 		seqno = get_random_u32_below(data->fc.chain_length - 1);
 		dma_fence_signal(data->fc.fences[seqno]);
-		cond_resched();
 	}
 
 	if (atomic_dec_and_test(&data->children))
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 0a98517f3959..0e58ebae0130 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -372,7 +372,13 @@ static int sbefifo_request_reset(struct sbefifo *sbefifo)
 			return 0;
 		}
 
-		cond_resched();
+		/*
+		 * Use cond_resched_stall() to avoid spinning in a
+		 * tight loop.
+		 * Though, given that the timeout is in milliseconds,
+		 * maybe this should be a timed or event wait?
+		 */
+		cond_resched_stall();
 	}
 	dev_err(dev, "FIFO reset timed out\n");
 
@@ -462,7 +468,11 @@ static int sbefifo_wait(struct sbefifo *sbefifo, bool up,
 
 	end_time = jiffies + timeout;
 	while (!time_after(jiffies, end_time)) {
-		cond_resched();
+		/*
+		 * As above, maybe this should be a timed or event wait?
+		 */
+		cond_resched_stall();
+
 		rc = sbefifo_regr(sbefifo, addr, &sts);
 		if (rc < 0) {
 			dev_err(dev, "FSI error %d reading status register\n", rc);
diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 51aab662050b..6efe6d18d859 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -788,8 +788,13 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
 				break;
 			}
 
-			cpu_relax();
-			cond_resched();
+			/*
+			 * Use cond_resched_stall() to avoid spinning in a
+			 * tight loop.
+			 * Though, given that the timeout is in milliseconds,
+			 * maybe this should be a timed or event wait?
+			 */
+			cond_resched_stall();
 		} while (!iproc_i2c->xfer_is_done);
 	}
 
diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index 7922bc917c33..06eed7e1c4f3 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -187,8 +187,13 @@ static void highlander_i2c_poll(struct highlander_i2c_dev *dev)
 		if (time_after(jiffies, timeout))
 			break;
 
-		cpu_relax();
-		cond_resched();
+		/*
+		 * Use cond_resched_stall() to avoid spinning in a
+		 * tight loop.
+		 * Though, given that the timeout is in milliseconds,
+		 * maybe this should be a timed or event wait?
+		 */
+		cond_resched_stall();
 	}
 
 	dev_err(dev->dev, "polling timed out\n");
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 408820319ec4..b486d8b9636b 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -207,9 +207,6 @@ static void iic_dev_reset(struct ibm_iic_private* dev)
 			udelay(10);
 			dc ^= DIRCNTL_SCC;
 			out_8(&iic->directcntl, dc);
-
-			/* be nice */
-			cond_resched();
 		}
 	}
 
@@ -231,7 +228,13 @@ static int iic_dc_wait(volatile struct iic_regs __iomem *iic, u8 mask)
 	while ((in_8(&iic->directcntl) & mask) != mask){
 		if (unlikely(time_after(jiffies, x)))
 			return -1;
-		cond_resched();
+		/*
+		 * Use cond_resched_stall() to avoid spinning in a
+		 * tight loop.
+		 * Though, given that the timeout is in milliseconds,
+		 * maybe this should be a timed or event wait?
+		 */
+		cond_resched_stall();
 	}
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index e4e4995ab224..82d24523c6a7 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -712,7 +712,7 @@ static int mpc_i2c_execute_msg(struct mpc_i2c *i2c)
 			}
 			return -EIO;
 		}
-		cond_resched();
+		cond_resched_stall();
 	}
 
 	return i2c->rc;
diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 36def0a9c95c..d4d69cd7ef46 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -310,7 +310,14 @@ static int mxs_i2c_pio_wait_xfer_end(struct mxs_i2c_dev *i2c)
 			return -ENXIO;
 		if (time_after(jiffies, timeout))
 			return -ETIMEDOUT;
-		cond_resched();
+
+		/*
+		 * Use cond_resched_stall() to avoid spinning in a
+		 * tight loop.
+		 * Though, given that the timeout is in milliseconds,
+		 * maybe this should be a timed or event wait?
+		 */
+		cond_resched_stall();
 	}
 
 	return 0;
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 83c1db610f54..5646130c003f 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -232,8 +232,13 @@ static void scx200_acb_poll(struct scx200_acb_iface *iface)
 		}
 		if (time_after(jiffies, timeout))
 			break;
-		cpu_relax();
-		cond_resched();
+		/*
+		 * Use cond_resched_stall() to avoid spinning in a
+		 * tight loop.
+		 * Though, given that the timeout is in milliseconds,
+		 * maybe this should timeout or event wait?
+		 */
+		cond_resched_stall();
 	}
 
 	dev_err(&iface->adapter.dev, "timeout in state %s\n",
diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index f9ab671c8eda..6b4d3d3193a2 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -215,7 +215,6 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 		gup_flags |= FOLL_WRITE;
 
 	while (npages) {
-		cond_resched();
 		pinned = pin_user_pages_fast(cur_base,
 					  min_t(unsigned long, npages,
 						PAGE_SIZE /
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index f4492fa407e0..b390eb169a60 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -668,7 +668,6 @@ static noinline int max_packet_exceeded(struct hfi1_packet *packet, int thread)
 		if ((packet->numpkt & (MAX_PKT_RECV_THREAD - 1)) == 0)
 			/* allow defered processing */
 			process_rcv_qp_work(packet);
-		cond_resched();
 		return RCV_PKT_OK;
 	} else {
 		this_cpu_inc(*packet->rcd->dd->rcv_limit);
diff --git a/drivers/infiniband/hw/hfi1/firmware.c b/drivers/infiniband/hw/hfi1/firmware.c
index 0c0cef5b1e0e..717ccb0e69b4 100644
--- a/drivers/infiniband/hw/hfi1/firmware.c
+++ b/drivers/infiniband/hw/hfi1/firmware.c
@@ -560,7 +560,7 @@ static void __obtain_firmware(struct hfi1_devdata *dd)
 		 * something that holds for 30 seconds.  If we do that twice
 		 * in a row it triggers task blocked warning.
 		 */
-		cond_resched();
+		cond_resched_stall();
 		if (fw_8051_load)
 			dispose_one_firmware(&fw_8051);
 		if (fw_fabric_serdes_load)
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 6de37c5d7d27..3b5abcd72660 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1958,7 +1958,6 @@ int hfi1_setup_eagerbufs(struct hfi1_ctxtdata *rcd)
 	for (idx = 0; idx < rcd->egrbufs.alloced; idx++) {
 		hfi1_put_tid(dd, rcd->eager_base + idx, PT_EAGER,
 			     rcd->egrbufs.rcvtids[idx].dma, order);
-		cond_resched();
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/hfi1/ruc.c b/drivers/infiniband/hw/hfi1/ruc.c
index b0151b7293f5..35fa25211351 100644
--- a/drivers/infiniband/hw/hfi1/ruc.c
+++ b/drivers/infiniband/hw/hfi1/ruc.c
@@ -459,7 +459,6 @@ bool hfi1_schedule_send_yield(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 			return true;
 		}
 
-		cond_resched();
 		this_cpu_inc(*ps->ppd->dd->send_schedule);
 		ps->timeout = jiffies + ps->timeout_int;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d82daff2d9bd..c76610422255 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2985,7 +2985,10 @@ static int v2_wait_mbox_complete(struct hns_roce_dev *hr_dev, u32 timeout,
 			return -ETIMEDOUT;
 		}
 
-		cond_resched();
+		/* The timeout is in hundreds of msecs. Maybe this should be a
+		 * timed wait instead?
+		 */
+		cond_resched_stall();
 		ret = -EBUSY;
 	}
 
diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
index 33667becd52b..0d8e0abb5090 100644
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -1674,7 +1674,6 @@ int qib_setup_eagerbufs(struct qib_ctxtdata *rcd)
 					  RCVHQ_RCV_TYPE_EAGER, pa);
 			pa += egrsize;
 		}
-		cond_resched(); /* don't hog the cpu */
 	}
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 28e379c108bc..b0fb5a993bae 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -778,12 +778,11 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
 	rxe_av_to_attr(&qp->alt_av, &attr->alt_ah_attr);
 
 	/* Applications that get this state typically spin on it.
-	 * Yield the processor
+	 * Giving up the spinlock will reschedule if needed.
 	 */
 	spin_lock_irqsave(&qp->state_lock, flags);
 	if (qp->attr.sq_draining) {
 		spin_unlock_irqrestore(&qp->state_lock, flags);
-		cond_resched();
 	} else {
 		spin_unlock_irqrestore(&qp->state_lock, flags);
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 1501120d4f52..692f57fdfdc9 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -227,7 +227,7 @@ void rxe_cleanup_task(struct rxe_task *task)
 	 * for the previously scheduled tasks to finish.
 	 */
 	while (!is_done(task))
-		cond_resched();
+		cond_resched_stall();
 
 	spin_lock_irqsave(&task->lock, flags);
 	task->state = TASK_STATE_INVALID;
@@ -289,7 +289,7 @@ void rxe_disable_task(struct rxe_task *task)
 	spin_unlock_irqrestore(&task->lock, flags);
 
 	while (!is_done(task))
-		cond_resched();
+		cond_resched_stall();
 
 	spin_lock_irqsave(&task->lock, flags);
 	task->state = TASK_STATE_DRAINED;
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 95f90699d2b1..effbc991be41 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -529,7 +529,6 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 
 		input_inject_event(&evdev->handle,
 				   event.type, event.code, event.value);
-		cond_resched();
 	}
 
  out:
diff --git a/drivers/input/keyboard/clps711x-keypad.c b/drivers/input/keyboard/clps711x-keypad.c
index 4c1a3e611edd..e02f6d35ed51 100644
--- a/drivers/input/keyboard/clps711x-keypad.c
+++ b/drivers/input/keyboard/clps711x-keypad.c
@@ -52,7 +52,7 @@ static void clps711x_keypad_poll(struct input_dev *input)
 			/* Read twice for protection against fluctuations */
 			do {
 				state = gpiod_get_value_cansleep(data->desc);
-				cond_resched();
+				cond_resched_stall();
 				state1 = gpiod_get_value_cansleep(data->desc);
 			} while (state != state1);
 
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index d98212d55108..a6c95916ac7e 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -624,7 +624,6 @@ static ssize_t uinput_inject_events(struct uinput_device *udev,
 
 		input_event(udev->dev, ev.type, ev.code, ev.value);
 		bytes += input_event_size();
-		cond_resched();
 	}
 
 	return bytes;
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 505c562a5daa..7ce9ffca6d12 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -704,7 +704,6 @@ static ssize_t mousedev_write(struct file *file, const char __user *buffer,
 		mousedev_generate_response(client, c);
 
 		spin_unlock_irq(&client->packet_lock);
-		cond_resched();
 	}
 
 	kill_fasync(&client->fasync, SIGIO, POLL_IN);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bd0a596f9863..8f517a80a831 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1582,8 +1582,6 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 			for (i = 0; i < ARRAY_SIZE(evt); ++i)
 				dev_info(smmu->dev, "\t0x%016llx\n",
 					 (unsigned long long)evt[i]);
-
-			cond_resched();
 		}
 
 		/*
diff --git a/drivers/media/i2c/vpx3220.c b/drivers/media/i2c/vpx3220.c
index 1eaae886f217..c673dba9a592 100644
--- a/drivers/media/i2c/vpx3220.c
+++ b/drivers/media/i2c/vpx3220.c
@@ -81,9 +81,6 @@ static int vpx3220_fp_status(struct v4l2_subdev *sd)
 			return 0;
 
 		udelay(10);
-
-		if (need_resched())
-			cond_resched();
 	}
 
 	return -1;
diff --git a/drivers/media/pci/cobalt/cobalt-i2c.c b/drivers/media/pci/cobalt/cobalt-i2c.c
index 10c9ee33f73e..2a11dd49559a 100644
--- a/drivers/media/pci/cobalt/cobalt-i2c.c
+++ b/drivers/media/pci/cobalt/cobalt-i2c.c
@@ -140,7 +140,7 @@ static int cobalt_tx_bytes(struct cobalt_i2c_regs __iomem *regs,
 		while (status & M00018_SR_BITMAP_TIP_MSK) {
 			if (time_after(jiffies, start_time + adap->timeout))
 				return -ETIMEDOUT;
-			cond_resched();
+			cond_resched_stall();
 			status = ioread8(&regs->cr_sr);
 		}
 
@@ -199,7 +199,7 @@ static int cobalt_rx_bytes(struct cobalt_i2c_regs __iomem *regs,
 		while (status & M00018_SR_BITMAP_TIP_MSK) {
 			if (time_after(jiffies, start_time + adap->timeout))
 				return -ETIMEDOUT;
-			cond_resched();
+			cond_resched_stall();
 			status = ioread8(&regs->cr_sr);
 		}
 
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index d4a96137728d..d262e4c5b4e3 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -364,8 +364,7 @@ static inline int bcm_vk_wait(struct bcm_vk *vk, enum pci_barno bar,
 		if (time_after(jiffies, timeout))
 			return -ETIMEDOUT;
 
-		cpu_relax();
-		cond_resched();
+		cond_resched_stall();
 	} while ((rd_val & mask) != value);
 
 	return 0;
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index e17d81231ea6..1b5a71382e76 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -1295,8 +1295,7 @@ int bcm_vk_release(struct inode *inode, struct file *p_file)
 			break;
 		}
 		dma_cnt = atomic_read(&ctx->dma_cnt);
-		cpu_relax();
-		cond_resched();
+		cond_resched_stall();
 	} while (dma_cnt);
 	dev_dbg(dev, "Draining for [fd-%d] pid %d - delay %d ms\n",
 		ctx->idx, pid, jiffies_to_msecs(jiffies - start_time));
diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 224a7e97cbea..03ed8a426d49 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -1004,7 +1004,6 @@ static int genwqe_health_thread(void *data)
 		}
 
 		cd->last_gfir = gfir;
-		cond_resched();
 	}
 
 	return 0;
@@ -1041,7 +1040,7 @@ static int genwqe_health_thread(void *data)
 
 	/* genwqe_bus_reset failed(). Now wait for genwqe_remove(). */
 	while (!kthread_should_stop())
-		cond_resched();
+		cond_resched_stall();
 
 	return -EIO;
 }
diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
index 500b1feaf1f6..793faf4bdc06 100644
--- a/drivers/misc/genwqe/card_ddcb.c
+++ b/drivers/misc/genwqe/card_ddcb.c
@@ -1207,12 +1207,6 @@ static int genwqe_card_thread(void *data)
 		}
 		if (should_stop)
 			break;
-
-		/*
-		 * Avoid soft lockups on heavy loads; we do not want
-		 * to disable our interrupts.
-		 */
-		cond_resched();
 	}
 	return 0;
 }
diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 55fc5b80e649..ec1112dc7d5a 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -1322,7 +1322,6 @@ static int genwqe_inform_and_stop_processes(struct genwqe_dev *cd)
 			     genwqe_open_files(cd); i++) {
 			dev_info(&pci_dev->dev, "  %d sec ...", i);
 
-			cond_resched();
 			msleep(1000);
 		}
 
@@ -1340,7 +1339,6 @@ static int genwqe_inform_and_stop_processes(struct genwqe_dev *cd)
 				     genwqe_open_files(cd); i++) {
 				dev_warn(&pci_dev->dev, "  %d sec ...", i);
 
-				cond_resched();
 				msleep(1000);
 			}
 		}
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 9ce9b9e0e9b6..7cf977e70935 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1158,8 +1158,6 @@ static void vmballoon_inflate(struct vmballoon *b)
 			vmballoon_split_refused_pages(&ctl);
 			ctl.page_size--;
 		}
-
-		cond_resched();
 	}
 
 	/*
@@ -1282,8 +1280,6 @@ static unsigned long vmballoon_deflate(struct vmballoon *b, uint64_t n_frames,
 				break;
 			ctl.page_size++;
 		}
-
-		cond_resched();
 	}
 
 	return deflated_frames;
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index cc333ad67cac..e05d99437547 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -192,9 +192,6 @@ static int mmc_spi_skip(struct mmc_spi_host *host, unsigned long timeout,
 			if (cp[i] != byte)
 				return cp[i];
 		}
-
-		/* If we need long timeouts, we may release the CPU */
-		cond_resched();
 	} while (time_is_after_jiffies(start + timeout));
 	return -ETIMEDOUT;
 }
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index d5593b0dc700..5e97555db441 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -435,7 +435,6 @@ static int btt_map_init(struct arena_info *arena)
 
 		offset += size;
 		mapsize -= size;
-		cond_resched();
 	}
 
  free:
@@ -479,7 +478,6 @@ static int btt_log_init(struct arena_info *arena)
 
 		offset += size;
 		logsize -= size;
-		cond_resched();
 	}
 
 	for (i = 0; i < arena->nfree; i++) {
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 5b5c1e481722..12eee9a87e42 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -432,8 +432,6 @@ static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
 				zsa_req_op(req->cmd->zms.zsa) | REQ_SYNC,
 				GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
-			/* This may take a while, so be nice to others */
-			cond_resched();
 		}
 		sector += bdev_zone_sectors(bdev);
 	}
diff --git a/drivers/parport/parport_ip32.c b/drivers/parport/parport_ip32.c
index 0919ed99ba94..8c52008bbb7c 100644
--- a/drivers/parport/parport_ip32.c
+++ b/drivers/parport/parport_ip32.c
@@ -1238,7 +1238,6 @@ static size_t parport_ip32_epp_write_addr(struct parport *p, const void *buf,
 static unsigned int parport_ip32_fifo_wait_break(struct parport *p,
 						 unsigned long expire)
 {
-	cond_resched();
 	if (time_after(jiffies, expire)) {
 		pr_debug1(PPIP32 "%s: FIFO write timed out\n", p->name);
 		return 1;
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 1f236aaf7867..a482b5b835ec 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -663,8 +663,6 @@ static size_t parport_pc_fifo_write_block_dma(struct parport *port,
 		}
 		/* Is serviceIntr set? */
 		if (!(inb(ECONTROL(port)) & (1<<2))) {
-			cond_resched();
-
 			goto false_alarm;
 		}
 
@@ -674,8 +672,6 @@ static size_t parport_pc_fifo_write_block_dma(struct parport *port,
 		count = get_dma_residue(port->dma);
 		release_dma_lock(dmaflag);
 
-		cond_resched(); /* Can't yield the port. */
-
 		/* Anyone else waiting for the port? */
 		if (port->waithead) {
 			printk(KERN_DEBUG "Somebody wants the port\n");
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d9eede2dbc0e..e7bb03c3c148 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -719,7 +719,6 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 		data[off - init_off + 3] = (val >> 24) & 0xff;
 		off += 4;
 		size -= 4;
-		cond_resched();
 	}
 
 	if (size >= 2) {
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index f967709082d6..7d3cd2201e64 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -83,7 +83,6 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 		buf += 4;
 		pos += 4;
 		cnt -= 4;
-		cond_resched();
 	}
 
 	if (cnt >= 2) {
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_pci.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_pci.c
index df1fc6c719f3..c202ae0d0656 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_pci.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_pci.c
@@ -56,7 +56,7 @@ static int isst_if_mbox_cmd(struct pci_dev *pdev,
 			ret = -EBUSY;
 			tm_delta = ktime_us_delta(ktime_get(), tm);
 			if (tm_delta > OS_MAILBOX_TIMEOUT_AVG_US)
-				cond_resched();
+				cond_resched_stall();
 			continue;
 		}
 		ret = 0;
@@ -95,7 +95,7 @@ static int isst_if_mbox_cmd(struct pci_dev *pdev,
 			ret = -EBUSY;
 			tm_delta = ktime_us_delta(ktime_get(), tm);
 			if (tm_delta > OS_MAILBOX_TIMEOUT_AVG_US)
-				cond_resched();
+				cond_resched_stall();
 			continue;
 		}
 
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 3ff46fc694f8..6122a4a057fa 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -659,11 +659,6 @@ static int slow_eval_known_fn(struct subchannel *sch, void *data)
 		rc = css_evaluate_known_subchannel(sch, 1);
 		if (rc == -EAGAIN)
 			css_schedule_eval(sch->schid);
-		/*
-		 * The loop might take long time for platforms with lots of
-		 * known devices. Allow scheduling here.
-		 */
-		cond_resched();
 	}
 	return 0;
 }
@@ -695,9 +690,6 @@ static int slow_eval_unknown_fn(struct subchannel_id schid, void *data)
 		default:
 			rc = 0;
 		}
-		/* Allow scheduling here since the containing loop might
-		 * take a while.  */
-		cond_resched();
 	}
 	return rc;
 }
diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index cea3a79d538e..40e66afd77cf 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -738,8 +738,6 @@ static void NCR5380_main(struct work_struct *work)
 			maybe_release_dma_irq(instance);
 		}
 		spin_unlock_irq(&hostdata->lock);
-		if (!done)
-			cond_resched();
 	} while (!done);
 }
 
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index e92f1a73cc9b..675504f8149a 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -1696,7 +1696,6 @@ __mega_busywait_mbox (adapter_t *adapter)
 		if (!mbox->m_in.busy)
 			return 0;
 		udelay(100);
-		cond_resched();
 	}
 	return -1;		/* give up after 1 second */
 }
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index cd0180b1f5b9..9e2596199458 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1943,7 +1943,6 @@ static int qedi_percpu_io_thread(void *arg)
 				if (!work->is_solicited)
 					kfree(work);
 			}
-			cond_resched();
 			spin_lock_irqsave(&p->p_work_lock, flags);
 		}
 		set_current_state(TASK_INTERRUPTIBLE);
diff --git a/drivers/scsi/qla2xxx/qla_nx.c b/drivers/scsi/qla2xxx/qla_nx.c
index 6dfb70edb9a6..e1a5c2dbe134 100644
--- a/drivers/scsi/qla2xxx/qla_nx.c
+++ b/drivers/scsi/qla2xxx/qla_nx.c
@@ -972,7 +972,6 @@ qla82xx_flash_wait_write_finish(struct qla_hw_data *ha)
 		if (ret < 0 || (val & 1) == 0)
 			return ret;
 		udelay(10);
-		cond_resched();
 	}
 	ql_log(ql_log_warn, vha, 0xb00d,
 	       "Timeout reached waiting for write finish.\n");
@@ -1037,7 +1036,6 @@ ql82xx_rom_lock_d(struct qla_hw_data *ha)
 
 	while ((qla82xx_rom_lock(ha) != 0) && (loops < 50000)) {
 		udelay(100);
-		cond_resched();
 		loops++;
 	}
 	if (loops >= 50000) {
diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_sup.c
index c092a6b1ced4..40fc521ba89f 100644
--- a/drivers/scsi/qla2xxx/qla_sup.c
+++ b/drivers/scsi/qla2xxx/qla_sup.c
@@ -463,7 +463,6 @@ qla24xx_read_flash_dword(struct qla_hw_data *ha, uint32_t addr, uint32_t *data)
 			return QLA_SUCCESS;
 		}
 		udelay(10);
-		cond_resched();
 	}
 
 	ql_log(ql_log_warn, pci_get_drvdata(ha->pdev), 0x7090,
@@ -505,7 +504,6 @@ qla24xx_write_flash_dword(struct qla_hw_data *ha, uint32_t addr, uint32_t data)
 		if (!(rd_reg_dword(&reg->flash_addr) & FARX_DATA_FLAG))
 			return QLA_SUCCESS;
 		udelay(10);
-		cond_resched();
 	}
 
 	ql_log(ql_log_warn, pci_get_drvdata(ha->pdev), 0x7090,
@@ -2151,7 +2149,6 @@ qla2x00_poll_flash(struct qla_hw_data *ha, uint32_t addr, uint8_t poll_data,
 		}
 		udelay(10);
 		barrier();
-		cond_resched();
 	}
 	return status;
 }
@@ -2301,7 +2298,6 @@ qla2x00_read_flash_data(struct qla_hw_data *ha, uint8_t *tmp_buf,
 		if (saddr % 100)
 			udelay(10);
 		*tmp_buf = data;
-		cond_resched();
 	}
 }
 
@@ -2589,7 +2585,6 @@ qla2x00_write_optrom_data(struct scsi_qla_host *vha, void *buf,
 				rval = QLA_FUNCTION_FAILED;
 				break;
 			}
-			cond_resched();
 		}
 	} while (0);
 	qla2x00_flash_disable(ha);
diff --git a/drivers/scsi/qla4xxx/ql4_nx.c b/drivers/scsi/qla4xxx/ql4_nx.c
index 47adff9f0506..e40a525a2202 100644
--- a/drivers/scsi/qla4xxx/ql4_nx.c
+++ b/drivers/scsi/qla4xxx/ql4_nx.c
@@ -3643,7 +3643,6 @@ qla4_82xx_read_flash_data(struct scsi_qla_host *ha, uint32_t *dwptr,
 	int loops = 0;
 	while ((qla4_82xx_rom_lock(ha) != 0) && (loops < 50000)) {
 		udelay(100);
-		cond_resched();
 		loops++;
 	}
 	if (loops >= 50000) {
diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 9ec55ddc1204..6f8e0c69f832 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -442,7 +442,7 @@ static irqreturn_t scsifront_irq_fn(int irq, void *dev_id)
 
 	while (scsifront_cmd_done(info, &eoiflag))
 		/* Yield point for this unbounded loop. */
-		cond_resched();
+		cond_resched_stall();
 
 	xen_irq_lateeoi(irq, eoiflag);
 
diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 938e9e577e4f..151b381fc098 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -775,8 +775,7 @@ static void lantiq_ssc_bussy_work(struct work_struct *work)
 			spi_finalize_current_transfer(spi->host);
 			return;
 		}
-
-		cond_resched();
+		cond_resched_stall();
 	} while (!time_after_eq(jiffies, end));
 
 	if (spi->host->cur_msg)
diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 06626f406f68..ff3550ebb22b 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -100,7 +100,7 @@ static int meson_spifc_wait_ready(struct meson_spifc *spifc)
 		regmap_read(spifc->regmap, REG_SLAVE, &data);
 		if (data & SLAVE_TRST_DONE)
 			return 0;
-		cond_resched();
+		cond_resched_stall();
 	} while (!time_after(jiffies, deadline));
 
 	return -ETIMEDOUT;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8d6304cb061e..3ddbfa9babdc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1808,7 +1808,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 
 	/* Prod the scheduler in case transfer_one() was busy waiting */
 	if (!ret)
-		cond_resched();
+		cond_resched_stall();
 	return;
 
 out_unlock:
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 985683767a40..2a2ebdf12a45 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3775,7 +3775,7 @@ unsigned int send_beacon(struct adapter *padapter)
 		issue_beacon(padapter, 100);
 		issue++;
 		do {
-			cond_resched();
+			cond_resched_stall();
 			rtw_hal_get_hwreg(padapter, HW_VAR_BCN_VALID, (u8 *)(&bxmitok));
 			poll++;
 		} while ((poll%10) != 0 && false == bxmitok && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index a392d5b4caf2..c263fbc71201 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -576,8 +576,6 @@ void LPS_Leave_check(struct adapter *padapter)
 	bReady = false;
 	start_time = jiffies;
 
-	cond_resched();
-
 	while (1) {
 		mutex_lock(&pwrpriv->lock);
 
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 0828240f27e6..49f55c051d71 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -581,7 +581,6 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
 		 * filled in by ffa_mem_ops->sync_send_receive() returning
 		 * above.
 		 */
-		cond_resched();
 		optee_handle_ffa_rpc(ctx, optee, data->data1, rpc_arg);
 		cmd = OPTEE_FFA_YIELDING_CALL_RESUME;
 		data->data0 = cmd;
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index d5b28fd35d66..86e01454422c 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -943,7 +943,6 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 			 */
 			optee_cq_wait_for_completion(&optee->call_queue, &w);
 		} else if (OPTEE_SMC_RETURN_IS_RPC(res.a0)) {
-			cond_resched();
 			param.a0 = res.a0;
 			param.a1 = res.a1;
 			param.a2 = res.a2;
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 959fae54ca39..11bb4204b78d 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -538,7 +538,6 @@ static ssize_t hvc_write(struct tty_struct *tty, const u8 *buf, size_t count)
 		if (count) {
 			if (hp->n_outbuf > 0)
 				hvc_flush(hp);
-			cond_resched();
 		}
 	}
 
@@ -653,7 +652,7 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 
 	if (may_sleep) {
 		spin_unlock_irqrestore(&hp->lock, flags);
-		cond_resched();
+
 		spin_lock_irqsave(&hp->lock, flags);
 	}
 
@@ -725,7 +724,7 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 	if (may_sleep) {
 		/* Keep going until the flip is full */
 		spin_unlock_irqrestore(&hp->lock, flags);
-		cond_resched();
+
 		spin_lock_irqsave(&hp->lock, flags);
 		goto read_again;
 	} else if (read_total < HVC_ATOMIC_READ_MAX) {
@@ -802,7 +801,6 @@ static int khvcd(void *unused)
 			mutex_lock(&hvc_structs_mutex);
 			list_for_each_entry(hp, &hvc_structs, next) {
 				poll_mask |= __hvc_poll(hp, true);
-				cond_resched();
 			}
 			mutex_unlock(&hvc_structs_mutex);
 		} else
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 5f6d0cf67571..c70d695ed69d 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -498,9 +498,6 @@ static void flush_to_ldisc(struct work_struct *work)
 			lookahead_bufs(port, head);
 		if (!rcvd)
 			break;
-
-		if (need_resched())
-			cond_resched();
 	}
 
 	mutex_unlock(&buf->lock);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8a94e5a43c6d..0221ff17a4bf 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1032,7 +1032,6 @@ static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
 		ret = -ERESTARTSYS;
 		if (signal_pending(current))
 			break;
-		cond_resched();
 	}
 	if (written) {
 		tty_update_time(tty, true);
diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 2d57786d3db7..b9051c341b10 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -451,7 +451,6 @@ static void __max3420_start(struct max3420_udc *udc)
 		val = spi_rd8(udc, MAX3420_REG_USBIRQ);
 		if (val & OSCOKIRQ)
 			break;
-		cond_resched();
 	}
 
 	/* Enable PULL-UP only when Vbus detected */
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index d152d72de126..64f12f5113a2 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1294,7 +1294,7 @@ max3421_reset_hcd(struct usb_hcd *hcd)
 				"timed out waiting for oscillator OK signal");
 			return 1;
 		}
-		cond_resched();
+		cond_resched_stall();
 	}
 
 	/*
diff --git a/drivers/usb/host/xen-hcd.c b/drivers/usb/host/xen-hcd.c
index 46fdab940092..0b78f371c30a 100644
--- a/drivers/usb/host/xen-hcd.c
+++ b/drivers/usb/host/xen-hcd.c
@@ -1086,7 +1086,7 @@ static irqreturn_t xenhcd_int(int irq, void *dev_id)
 	while (xenhcd_urb_request_done(info, &eoiflag) |
 	       xenhcd_conn_notify(info, &eoiflag))
 		/* Yield point for this unbounded loop. */
-		cond_resched();
+		cond_resched_stall();
 
 	xen_irq_lateeoi(irq, eoiflag);
 	return IRQ_HANDLED;
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index a94ec6225d31..523c6685818d 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -457,8 +457,6 @@ static int tce_iommu_clear(struct tce_container *container,
 			}
 		}
 
-		cond_resched();
-
 		direction = DMA_NONE;
 		oldhpa = 0;
 		ret = iommu_tce_xchg_no_kill(container->mm, tbl, entry, &oldhpa,
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index eacd6ec04de5..afc9724051ce 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -962,8 +962,6 @@ static long vfio_sync_unpin(struct vfio_dma *dma, struct vfio_domain *domain,
 		kfree(entry);
 	}
 
-	cond_resched();
-
 	return unlocked;
 }
 
@@ -1029,7 +1027,6 @@ static size_t unmap_unpin_slow(struct vfio_domain *domain,
 						     unmapped >> PAGE_SHIFT,
 						     false);
 		*iova += unmapped;
-		cond_resched();
 	}
 	return unmapped;
 }
@@ -1062,7 +1059,6 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 
 	list_for_each_entry_continue(d, &iommu->domain_list, next) {
 		iommu_unmap(d->domain, dma->iova, dma->size);
-		cond_resched();
 	}
 
 	iommu_iotlb_gather_init(&iotlb_gather);
@@ -1439,8 +1435,6 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 				GFP_KERNEL);
 		if (ret)
 			goto unwind;
-
-		cond_resched();
 	}
 
 	return 0;
@@ -1448,7 +1442,6 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 unwind:
 	list_for_each_entry_continue_reverse(d, &iommu->domain_list, next) {
 		iommu_unmap(d->domain, iova, npage << PAGE_SHIFT);
-		cond_resched();
 	}
 
 	return ret;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index e0c181ad17e3..8939be49c47d 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -410,7 +410,6 @@ static bool vhost_worker(void *data)
 			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
-			cond_resched();
 		}
 	}
 
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 7ad047bcae17..e17e7937e11d 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -870,12 +870,10 @@ static int vgacon_do_font_op(struct vgastate *state, char *arg, int set,
 		if (set)
 			for (i = 0; i < cmapsz; i++) {
 				vga_writeb(arg[i], charmap + i);
-				cond_resched();
 			}
 		else
 			for (i = 0; i < cmapsz; i++) {
 				arg[i] = vga_readb(charmap + i);
-				cond_resched();
 			}
 
 		/*
@@ -889,12 +887,10 @@ static int vgacon_do_font_op(struct vgastate *state, char *arg, int set,
 			if (set)
 				for (i = 0; i < cmapsz; i++) {
 					vga_writeb(arg[i], charmap + i);
-					cond_resched();
 				}
 			else
 				for (i = 0; i < cmapsz; i++) {
 					arg[i] = vga_readb(charmap + i);
-					cond_resched();
 				}
 		}
 	}
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index fa5226c198cc..c9c66aac49ca 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1754,7 +1754,6 @@ static int virtio_mem_sbm_plug_request(struct virtio_mem *vm, uint64_t diff)
 			rc = virtio_mem_sbm_plug_any_sb(vm, mb_id, &nb_sb);
 			if (rc || !nb_sb)
 				goto out_unlock;
-			cond_resched();
 		}
 	}
 
@@ -1772,7 +1771,6 @@ static int virtio_mem_sbm_plug_request(struct virtio_mem *vm, uint64_t diff)
 		rc = virtio_mem_sbm_plug_and_add_mb(vm, mb_id, &nb_sb);
 		if (rc || !nb_sb)
 			return rc;
-		cond_resched();
 	}
 
 	/* Try to prepare, plug and add new blocks */
@@ -1786,7 +1784,6 @@ static int virtio_mem_sbm_plug_request(struct virtio_mem *vm, uint64_t diff)
 		rc = virtio_mem_sbm_plug_and_add_mb(vm, mb_id, &nb_sb);
 		if (rc)
 			return rc;
-		cond_resched();
 	}
 
 	return 0;
@@ -1869,7 +1866,6 @@ static int virtio_mem_bbm_plug_request(struct virtio_mem *vm, uint64_t diff)
 			nb_bb--;
 		if (rc || !nb_bb)
 			return rc;
-		cond_resched();
 	}
 
 	/* Try to prepare, plug and add new big blocks */
@@ -1885,7 +1881,6 @@ static int virtio_mem_bbm_plug_request(struct virtio_mem *vm, uint64_t diff)
 			nb_bb--;
 		if (rc)
 			return rc;
-		cond_resched();
 	}
 
 	return 0;
@@ -2107,7 +2102,6 @@ static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 			if (rc || !nb_sb)
 				goto out_unlock;
 			mutex_unlock(&vm->hotplug_mutex);
-			cond_resched();
 			mutex_lock(&vm->hotplug_mutex);
 		}
 		if (!unplug_online && i == 1) {
@@ -2250,8 +2244,6 @@ static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	 */
 	for (i = 0; i < 3; i++) {
 		virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
-			cond_resched();
-
 			/*
 			 * As we're holding no locks, these checks are racy,
 			 * but we don't care.
-- 
2.31.1

