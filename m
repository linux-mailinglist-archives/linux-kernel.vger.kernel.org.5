Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CB07E4B41
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjKGV7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKGV73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4510D0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:27 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJmSr000897;
        Tue, 7 Nov 2023 21:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=77+FBkBUzVWyDU8YjIAJVQ5OkN6O8nF00abGUXbnSB0=;
 b=ipt9p2RP/bj4dLIt8tlb7rC+gbAdegH+9BfhPXV3IfgFPSH0Pnuexp9M8WmOkoPeCaM0
 cESXDzj0o/5agnr2uE3R7qwKruY8VxfZ8Z355lkqz95yQBLnUSgjhSv5LqF0U0QkFeCU
 jFL+2/LjfMm01NZvBBJ3XZN2Yc7RWLtiWQ9I572vVTKfXH3WyqMLzxE5gj3D4Ovc5zQg
 P6SK1LVmtQMV3ErM6OTZ2MKfGHhw6Dz9a1FNSEgcmLqYa4wCX+k55omysymdXLLxCKP3
 GPrYdEaT3jcAlBIeRM4vxRBSrDruN72ZVCWee+M+BVnzcjmYdmswEtzL9F6lj6ZfJ+Al Vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIrDQ003912;
        Tue, 7 Nov 2023 21:58:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vsh7b-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGAsJfsn1PpO+ucsOg4vxuLLx9U1PA5gcvqqQWlq2lu2gpsTFXLodpi0IS5UbjSKUPu7wYpFoUtoOee4U7SL5tBwCCzbXUGeIPLpF4RdcM7Zyqy7NMJsgAlDlGbfEs5RZ0ZJ2IInCuNu95JtetRz2EyPNhjxW8l0nlVoB3n5keoh8pEYMyHVKT2U/j7FLZ5IP7y0w9ehdxwutc9Zyuu4SHUwr2tT/Muq0SmuJHIDlt0a6SounwIjYT8VkzWOlv9JX7EV9g7BOA7cT/uCs9aFzcw5JRLWoRzTvnNoHFw07S9c1AjJSY3OUHGe49yxuLSl4bNqCAwhWp9+0Eg0p0KpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77+FBkBUzVWyDU8YjIAJVQ5OkN6O8nF00abGUXbnSB0=;
 b=HWuF0y8e7vqIeDWWyhYQg1uIvfkwI+IRCGOwsKBcoVf4COmb3TF2WFAKN8nzhpFILonY+HJSWMz8h0zUHOaXB4fyG18bTamMVMHA84R+lQdqtwIXnwThoddO7vMVF/3ptlkNCOX2qJFC+2HFtrFT+LVgtpGwbdeoIsJ3DJxzxuzkSfXz32WpMAAKn+2VV2Tsf05+fYfzySwsPTztpELN+mI9KjLhWZAjp/Vd1D+2m0w+M9geQwdVerL2i2uRqOVwaYlePzvl3fk+7Z/wtPBzncxJyLqjjbNM0N0Prf859+QQsqDmNXNT7w6T+ecT4Hb/H4K3ZDbLfeKy5XkglnnWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77+FBkBUzVWyDU8YjIAJVQ5OkN6O8nF00abGUXbnSB0=;
 b=X1Vu+anKQeuVEqHTB52YirP/BUQjC5DhanTb5wU2yC8nhFxmI+wnY/fKcZEOjToooQkgVO2e/K0tS0/XpIGen4iiWmF6m4i3qEywW/+zS/gBIFSD+b0FfjchbfNPwUdcgnIkO6RJQL3eIBlI+B2EOoE3StoezxJD/M0xaPMng4A=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 7 Nov
 2023 21:58:16 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:15 +0000
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
Subject: [RFC PATCH 11/86] Revert "sched/preempt: Simplify irqentry_exit_cond_resched() callers"
Date:   Tue,  7 Nov 2023 13:56:57 -0800
Message-Id: <20231107215742.363031-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:303:2a::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: a60f8f50-ff73-431a-e8a9-08dbdfdca500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBg3kSVTYjt6TBbKcsuoz1RUASbC9wSHhpZHcUzK6cMzmZCTs+mz9iuXKYL/SrD8CkNmS74uf8K1+AKamzEbywQFXlW+06DedlaV8jLLycjOQezf6O8pPxU3jrYWjmH4h++uZSkdbe2jwDNNON7xNtvVsn7zGzBggm8vZpdkGyAhjmZcaKIIIKrUl1OOhVCie9KCg4YGmvdnoFEnzVdO3unRH/HgCgFcZTztvbtGv8fCwi48gv5BoSOPoOyULlCgFNAS6ESuNuqnaKjPjX6VrBwMcSvaqusIJuc8TQBrS9UxT2TpW2Ib/DsQ/f2w9xdvZwxu3opjeu+mryaNWr30FHd1P9GGLkRX7Y39pA7Jw5Zel2z2610+2CgWe+TWTSt5zMkDUg83eM/DIBoNwdDfspcF3cNRB1wyAb2uxhZmVw2PWAhOiDm08PBOjSC1VxGOx4IyMieqBD6ht4KSpfioHEkngL1tTPNnYD6HVGjmW7TdhQzG47Har53WXmdLwhB0nbS0D07NZOpZTV44ErfmB1ayh2qm2dmTxyrjhsX9FC69UV3xr/nu6p4Le0kDgc2A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6916009)(41300700001)(66556008)(66946007)(83380400001)(7406005)(7416002)(66476007)(316002)(478600001)(8676002)(6486002)(2906002)(6666004)(5660300002)(4326008)(8936002)(6506007)(6512007)(26005)(1076003)(38100700002)(2616005)(107886003)(86362001)(103116003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/hNybEJi/4S8nIwQ/jm3sVaNhUw2a0E9HXgHp25tUbGqvThSSqcY89TjQYQn?=
 =?us-ascii?Q?NecEo4fNhFV5elkRXIYWAkzhj3LSzZiaH72IFNjp6lfU+pZO2LFnWacFcyZ7?=
 =?us-ascii?Q?pq0y+hb7GQq9H4C8//88It/G+0SEpNS8Ujp8ud3W6w08zhXJxoPzkyy6xIGg?=
 =?us-ascii?Q?wGVUIitaNetLM52YnhTmblTyGTcACfNC8zVYxLhV7W/SHRYXs38hWg/Ujray?=
 =?us-ascii?Q?+MeXC76VrkX4WusjJK0k9RzpzJixE+Tfab6A/Bt7K6O5i+nG2ItcA5K32FqJ?=
 =?us-ascii?Q?rDPQOrUpLzv9WCkOj1xRT/OrEFLSGng2jVFRAXHvE8OX++Ab0LJ2mMKSw6Lu?=
 =?us-ascii?Q?p9UQca7uRwIhHgKJ+mew2SSXiJB6Tts54tzyD1WELzIU5XcfWNWGZ/tbJoBO?=
 =?us-ascii?Q?TEVwMrcXz0favNbdAaDL/8z7WpacH2gkfwMIK2zOCG0ZwvVfKpaI/ikgcIa0?=
 =?us-ascii?Q?lkOLFmYw+jQeB7r9I9cQ4554Tu38kxj9jJw/nDZyzRTKuftvCRwN1HpKZXRJ?=
 =?us-ascii?Q?+cMlobwzpJYj/vp0EOlFgqF2/Oj0VIlJzCuq87JQnzQ9Zmm4a7nyn20ufyxi?=
 =?us-ascii?Q?y3hivwU75YmZzFNLeU/4eqNciDHihykIHgW8HmmG0CPogwBqFlVO6yPTQMlq?=
 =?us-ascii?Q?WfAu6sI21udcRhtR0MoDznmNrv5uFynDMLYVW7ODEJHjE+oVw5eUbM3vf+uY?=
 =?us-ascii?Q?efAhU6ObS61Eg1xDsqFVtqvbe20HerVHuWlWO7eq77JuCyIPMQZU3bylWlNc?=
 =?us-ascii?Q?v01R5hjS7/OcQE4rKW4BwRkL86QB4/ekzSjrhkcjcz3qo2EmUF3K7P+nYAYF?=
 =?us-ascii?Q?bx24FpStPn+fWC0bUbYtg5JgfA7qDeqba02jkIxV6OLzLZPaavZj+Kbj+xh8?=
 =?us-ascii?Q?dupq/jBVTihnlTOrznsKLuGkxO3+QH5+gFmQbFbB2aQBnfZe4Npyu0VmVVUN?=
 =?us-ascii?Q?yNRc61aS1koXr/8ktFHrqgivDDF7wOpB13aRrKQVpem5YKCipEhi1vgE3IV1?=
 =?us-ascii?Q?TNmjHn5Opv7Qsn4aangjgfn64IRlQ+6sainUk2R/nR7KGcKi7cgGCjdm9JbU?=
 =?us-ascii?Q?QrOHFJC5C//f3xm0OdEJTew9lWfJJbt3YlXagwInKpEC4CwCKHdgAdLXdoD+?=
 =?us-ascii?Q?LqqoZyHxWdeoSZ8KTv4hTjyEE93FMV/6jb93zBwr7MlsMT0uEFIrn8f2Ycb/?=
 =?us-ascii?Q?CNu2qbSn6C4GI9jUHDhs7gnu96jy7cqFXdCMBJzEpps5nqQmXDNB9/POIHlv?=
 =?us-ascii?Q?iN4aphWzwq2uLT1299mk26uE90Qew7B41BcZ5vf00rIbOVpTvv+2UuvDvm7C?=
 =?us-ascii?Q?yBEmLAZgoQh5OUOjTfCWuXM14s8aguz0ohwOJij+YKLiNHFugZp2RK91NuFS?=
 =?us-ascii?Q?+ukgsRsyub+tigW6NUPQi8CYnNPtcB4IrV8BOU76CgafXH1VX+2aJrCW9jtS?=
 =?us-ascii?Q?4suxFxnx44TfTQ2imcMj3HIQsCDMJCih6dbF0sv545JpsJAXgepl7/nuIYqO?=
 =?us-ascii?Q?tYpr3N7+S8xvSAg8NcI4e1+NpNpAkW34vdTCx+OEiND7oALxL1UTjbBCc/nH?=
 =?us-ascii?Q?5oqyYhJil68vp9iIyJ5geSQuBjZlytyOq/mMDQh+cv/j6El8KwzivDPqesIo?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/RBqNFH1XrUKEUtqyXSyh34ULP3tGBclnLskzpoF2fqOUCQopa9Isxiaxrzz?=
 =?us-ascii?Q?0HQbSGexdcnBEnlZQ3U2XsIk06/Zg3pSDNaCKQgRbUKL/n02p4NNIeuN7aiJ?=
 =?us-ascii?Q?wHDb2ZruOCdV2cipWjJO/wL0zSNif+uDaanHuCKxBf9y/PX15Ied1vxHmfVQ?=
 =?us-ascii?Q?6WtLoQyQJyWeEjmjZTZZjITZrva3m6ZUWWnLDqloC/UpunmxAN1nG7M186hh?=
 =?us-ascii?Q?u3caNUcOrwX3icB+4KY/yOi2k1ObOzaz08/JCS8avX7MI1aVRxni2bcKMyT1?=
 =?us-ascii?Q?5/tJy9A2PTMuMGpRfPKoW9pKqzJ5UVxI0KmdG7sSdkriYrNLO5/XenfQzdjV?=
 =?us-ascii?Q?9v9yzj1tzjsOcN5YrnUwFBIvDklg+4A1XC2N44l+SKuaQfWYmc4yyuk0QSyZ?=
 =?us-ascii?Q?Upyv9IsnhxJriFs45Wcdj8lODkTEWDZQ5QZECVWTMEZ/M38P4ahlkBa9lXwX?=
 =?us-ascii?Q?0S9gmQDkuTCDLbxOQ7FVSqY3M1dhZ579vftUo28EnmvF2JZhq/QXen8NobC2?=
 =?us-ascii?Q?UpvV8AH+unP6eMGIL/YmghD2tTn9R5mnGrn8/4/uPz1/ao7qS3C9SIxSQp5f?=
 =?us-ascii?Q?HDUmtv9oMur3EJg42dN6MouUyCXYK0Oaqvklj9qycFk+VvKidJWhVWoTqoQS?=
 =?us-ascii?Q?3seb74Ci4zZfjt9Q6wZ8ev3Zu2w+CkPfBHiz3m62pq2NdDGz5GnJQfaC8dPt?=
 =?us-ascii?Q?FN9lZdpDbV5dVv+75l4bCICA6Iydq1iy4rLhbmAi3+yvqlaQOmtj/h1IyLAJ?=
 =?us-ascii?Q?j3iJKY1TgjL3xj3JmDfUx1BO5lLmCNhSewQ8BW9lLH8T5dCJAYBe4BCENz1h?=
 =?us-ascii?Q?gVAIjxG7QttIBdeiOaSXGhHuY5n+XN70vfHgygVu/E9UOeuVEYMzo7TpPoan?=
 =?us-ascii?Q?UNYsCrbpGeagpaECYu2oQkDfx8vWMQLttPG4+RWZU+0MbX5vVfChjLLQVWJF?=
 =?us-ascii?Q?KmxriU6DLuWrTCgoqbOHz3Y0geLDLust4qWIfaksVp853eF5bYWOPnUnBaWN?=
 =?us-ascii?Q?FkKcSGxlVhGanIJ/HviwMQIFvIqBaMYrioqhI+b+CndwOcDsQelxn5ate5ku?=
 =?us-ascii?Q?HozTaYwCFzJx4nO38MPyI8B85ydWNwfVqb6maA8LApAGV+liVDjX2CuD+Hze?=
 =?us-ascii?Q?NlUUDy/TdL6/qbyDO7vVG0PuOrE8Jc+a8iuCIm14SyQ4m1YYWOpFvRvIl0SE?=
 =?us-ascii?Q?+vK42stWhqhud4k5QL2l7hsZUTbpAwdo9xNMPkMGlNZIkBI/FYecHmUKjv14?=
 =?us-ascii?Q?JHDAv9eQwQ5dpI4fjY5QCxpjFmXiSfFcTf9Zn8SFnxVMJ7dM3yWJecYGH2wI?=
 =?us-ascii?Q?KlSm53YIgsCfAfFfUkdn99n+gBOIisrjZUuU+mZaJ9VPzth+VBIO+eo5f2Vz?=
 =?us-ascii?Q?1/+mubaopXxMfLYy5Xt1zVYb5LxC76SLBX4aIUfjBjXxbWMo2flh1AJ1sZPh?=
 =?us-ascii?Q?sTy9JgY2sYjQkAoOxAASC2kv0appSVSh/KaJDfjuNZx690Z3ShJjLs9r6Txj?=
 =?us-ascii?Q?28esJcM4v137QBCX/t54wWz4SQl2cSJG78243yd7liA1OExpyhQlJv4v0A?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60f8f50-ff73-431a-e8a9-08dbdfdca500
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:15.9016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Akvo/+2Ak/oL7dEBLHJz/yNcmsSPecmefS0pI7S50R6SqoQpFf4d8PeSFwRYPpsPpabfP4SQ3cKH7RMgP2lzqxyjJuyu3Qyb2Q+bTh8LqPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=871 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: VCxrgEeSUzfhKW41DeMbYxvg38-oY1_x
X-Proofpoint-GUID: VCxrgEeSUzfhKW41DeMbYxvg38-oY1_x
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 4624a14f4daa8ab4578d274555fd8847254ce339.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/entry-common.h |  9 +++------
 kernel/entry/common.c        | 12 ++++++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index a382716ea7b2..6567e99e079e 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -414,14 +414,11 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  *
  * Conditional reschedule with additional sanity checks.
  */
-void raw_irqentry_exit_cond_resched(void);
+void irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
+#define irqentry_exit_cond_resched_dynamic_enabled	irqentry_exit_cond_resched
 #define irqentry_exit_cond_resched_dynamic_disabled	NULL
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
-#define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
-#else
-#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
 #endif
 
 /**
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 38593049c40c..b0b7be0705e0 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -377,7 +377,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	return ret;
 }
 
-void raw_irqentry_exit_cond_resched(void)
+void irqentry_exit_cond_resched(void)
 {
 	if (!preempt_count()) {
 		/* Sanity check RCU and thread stack */
@@ -389,7 +389,7 @@ void raw_irqentry_exit_cond_resched(void)
 	}
 }
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
+DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
 #endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
@@ -417,9 +417,13 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		}
 
 		instrumentation_begin();
-		if (IS_ENABLED(CONFIG_PREEMPTION))
+		if (IS_ENABLED(CONFIG_PREEMPTION)) {
+#ifdef CONFIG_PREEMPT_DYNAMIC
+			static_call(irqentry_exit_cond_resched)();
+#else
 			irqentry_exit_cond_resched();
-
+#endif
+		}
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
-- 
2.31.1

