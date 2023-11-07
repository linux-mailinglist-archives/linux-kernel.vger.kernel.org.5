Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D383B7E4B74
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbjKGWFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbjKGWE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:04:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877F35BE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:01:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJQ9J014468;
        Tue, 7 Nov 2023 22:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0hUBRwRW2iGU3GXAGJqaK60bN8ITrJKzrcDmJVHmBag=;
 b=lskhLGUffWpfgK1lx21kL1sxLfeOhBEyURzxBK6+qKMBkFZ7uRKkRZ3yQHFmz60yitq5
 uG1wU8O1zHOqd1lLMNlrnxaL3rYWe9h8IEBiHHv/Ju2OkDU0ZHWaJb7Mgz/YHBpWofpt
 lXpT9QcUnaFdaLDVMd9KzGYpLpAxUruKKOk2eSWIV8VDg3dhmtudTLQxtuELDOXDdXBB
 pLXBS0uUVhZ8ogQlUft2GNKDBvstPJU0wLZTkkrSG8k0QaxFwGb+rVINvaqn9zGAsFjl
 Oqdb11gXDQNT27HPv/R86mUk4CbQmNxC9dpW5FnNT6ftYRjS3hexkR9EDrtGZtNKWTS8 zA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26r2fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIgB9011048;
        Tue, 7 Nov 2023 22:00:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tsmn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luy5NM+gB9htA2S51dLXsSyOxxUWRY5ZdEfNDbusTiYQWspMjwSfOJApUZ95om2AiZETrRI4Gu0TJQB59Ny1kGodoo5bzphB0b01YggubBaCvWijB65c6eLHCatghM8CjtPQM+9q2srT72JyxKbpN/Yblta7wLRAhQd1wMl+3auVYx9YQHv6flzvrB7k9/M3HEWWvlKi0Bgr96krKyVj/aoB4krS8c4dyd0uitOwW9BubY1I1qDMU2Cp3T3zMgSedjQdSaRq747oBkSIZXopLAofAvvwvGCtRc3p7UuxAuzTrjKwsY0e0sI3fQewhwzBVoER7mzbABqCLwftgMFecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hUBRwRW2iGU3GXAGJqaK60bN8ITrJKzrcDmJVHmBag=;
 b=kw1jTD7WceO/x4/Nf6uHeUYXtvrT6gsalNr2Qade/ThRoC6MkzIQDGwCqYxGz0miL4zG2Petc1OKuyszEHgrwflEszbsFsmNtw0mbDhDZTYyKWOLYUvgd44KvilIlBVIdZ/a69eiJ5QCiCKQ5L/Qceoxb/oZV5SoCZ/VgtwtjyISD1mrXwoXwR7m96qUIQaJWtmOdXWwdkeHGQRW+eOUI3ouHIfCwkWjCVixmKix1U+jNFFrw42N8AsbtD6F21jVZpUwQm6yVQ90Pdmwq1LYsrPNZgpN2Ky3LywONqt2mEDxL2qk09ts6uNKvOWaFAI0E5oYaf/eD9wfyvAzOj0l/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hUBRwRW2iGU3GXAGJqaK60bN8ITrJKzrcDmJVHmBag=;
 b=B/5uxxSeefrsdnNIrPm9b0CJpepWUvxBcMCHZsf4tHNOl8jbrnUin4cT5BfxpHoH9hHqzikUxQUHLu+yBx2nb195O8UgHcacQozmqP+s/g8SwFU4j4orGtfQj74pZs4cLZ4M0Ueu7qHn7iyfFLTiqpGQilDNAiVQ+hmkYRg6UNI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5318.namprd10.prod.outlook.com (2603:10b6:408:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 22:00:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:00:31 +0000
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
Subject: [RFC PATCH 55/86] xarray: add cond_resched_xas_rcu() and cond_resched_xas_lock_irq()
Date:   Tue,  7 Nov 2023 13:57:41 -0800
Message-Id: <20231107215742.363031-56-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d657a6-dc4e-47df-e6dc-08dbdfdcf59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rrj5u4u/rvceF3TXWpQV311c6GzQug7CuQc3kCuB+3uaUDvUEomtGM5p0GJvc8NGZ6UjjmgVPk6DSW6FFlelDJyqf8Hvk9+ggRmtd/pzjwa6cuD75CVlDoWp2rkdFHw5B6VUE9cjhXkFdFKG2y2kEiG9RjskxVvEcS6k4Pg5xvv3ryixYHY8uMXkJsNw+8EUfyz7LClJrbm5iBb1cYK1S+WBatIbprhohQQQBfEjgT7hwR8H5cYbvqGQn67MlOhdaD1OvhHoj0bcYzYT3LbEkcd58klV6GUVrEH+BSO6WcaLfcG6/EVEooEUhSQ3/V5WU2PBp9yQBJqMiOGpZ34liGkrV8YId3fNmWov8jQrfHkT8gsmC7sYw8eupygE3DjfGzv7luQWW+27Y6gNz7ajR1zPn8l7kTjs9VoiqmAf/SWO4pyZgy3IN9Miv9IjUJjrc/2OrsTfoPCCjhud4ilxktorYznj71M1AMDixEZekdshNbl7gnJq7JIvVDToqGLO8gLWuA83e7Lj+sd2gydyqcFhaufo0+qUyKMCh0c/p9pMiPwIPgfn5maT7c+uHOG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(1076003)(26005)(38100700002)(83380400001)(5660300002)(107886003)(2616005)(6486002)(6506007)(478600001)(6666004)(6512007)(36756003)(316002)(6916009)(66946007)(66556008)(66476007)(8676002)(8936002)(4326008)(7416002)(86362001)(7406005)(2906002)(103116003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YivaP7HeGSVQ4muUSS20d8fnljFdshr9WQhHIUfWRLT/Wbapn49BPn3JQ182?=
 =?us-ascii?Q?5/nKER5oKrugjARhJd1YC043xp4aDluOlHO7s8ntCyL1IF9YpOIgOMwbS3ID?=
 =?us-ascii?Q?pQ637l6VttwiswfUSynEUlcJyAC25l/GMkMX9cHgncR+/Q7eVE2xck04/znM?=
 =?us-ascii?Q?TO5br/eqGiSGkIUSNAXfhkokXZwHhHg+sd+y82cITN+yr+Zvxci2aFE8e6Zh?=
 =?us-ascii?Q?ZrzYbD4kY3szSeiHfgj73LCpkb9+3J2LbAomDV3Pj//woTjrj3ii8J5mTJxV?=
 =?us-ascii?Q?RBiRT+i/u6x7djdY/mJSoVDVkj5LGZp20x5pajnMQkUbE/48Hh3Wa9Bfdtcp?=
 =?us-ascii?Q?42g9eC8z4cXJaNn8Xs44db06/DA88H9jeL6tUTQQsi1IFqhaTWOwWYAcN8FV?=
 =?us-ascii?Q?y4in0qf31VjGHf3c6MaVAsfC6W44L84kS4xvxA3ducnTua2xZWFXPpdtHF8K?=
 =?us-ascii?Q?zVYG3jc08X5pF6vdQfcR4BwC2zrQoqOP8ONEEl7qH1XDHnjKdopG/7YkqXsp?=
 =?us-ascii?Q?ed9KxHi0ibvJfyqSB88bevChyYULCOXawLlWlf3pCNe2vICR3Oo0DuoLk+oq?=
 =?us-ascii?Q?lyhhjwc/JSON25aNVfYlUygJvNR7jXAX2pFceUAYlhYZMJtTuuO5CbquzR0e?=
 =?us-ascii?Q?MDrn36/K81JerdGMSKzUny4Z5AhmTnYuzVa+3NGSuqVu83fSPXh0uTGG1/vw?=
 =?us-ascii?Q?ioTkJyXCYR83kdsZj4bv45pKJqbzRaLoRMBCiA72GRxhGihljNuMi7zP/CZD?=
 =?us-ascii?Q?BAmHPJDDWIwi2k1O07oLJKxQxC2h7BlWQvfxLl7eDcHG9XAAt92W/eVFop47?=
 =?us-ascii?Q?GNMfB5YMkvphNzOLkKnSBKUY1KX2jG19ObEH9y9m8FAhV4f8gzocHd+yv7b8?=
 =?us-ascii?Q?LbRz+lUkYOvQqZ1T+iJlbHukTJGsfXCjC1YuCBMQd9tDvTIavTWABudB4SNo?=
 =?us-ascii?Q?0RwoWp0k2t1kCVF3LeuXbFzmlIHFYCGAr9L3aaOCOIxeGYZ6OD1635cgiy8U?=
 =?us-ascii?Q?LeQRMgVuxfNCxrk5G4tc9wjcDwyBqOBj1xBTJCw8AcK71bfKvpqj0wpCWT+i?=
 =?us-ascii?Q?byjAFZKPu72I3qXWkTkeN3Ay5/DSuujmUNBNroScjZNbvpb/Skj024zgJMd5?=
 =?us-ascii?Q?rFSMr1OQvtSVGwUjuBJ4dmKUWuo2fXL0Sg1tgJhh3pbqjXwkJlMSa7t9Yrxa?=
 =?us-ascii?Q?A0JjxfOOh/ciPKpIKIkPz7IBfe2TL75OYBz6gYJC2W2mX6jRvw36PnmKCViM?=
 =?us-ascii?Q?iW/TxJAXmcPr5xcV8rH7JtlGydODklUwZcnfyB5hJ6sLIPgL0AQIPeG7k1tC?=
 =?us-ascii?Q?uHbY1XgvAl1/c1MooQ7lXjd2SAniC0X6wfid9qaLj5/j2xOIntt+WN2J64Ra?=
 =?us-ascii?Q?nV8vRegVheYcueTAlEvy+XL0oqsyfNSuue4eOdgWbFETlXEggBDTfkEmj7AR?=
 =?us-ascii?Q?ZMVJjpoyYEGf/oBGFUd5/z8RRwxvcm4Yg52fWGAwcsGiWre5sdH5eojJpz0q?=
 =?us-ascii?Q?EQqni6tAzxgZcjyzHzuz3hLLilIxJlbSRCdvUtnWzkW7D2jmqF+sJIKeyrj+?=
 =?us-ascii?Q?+fAKkZTLa2mZGgyKjJiG2ej2IxroteCSX+GeDjxj9UwXQpw7dB9h/31v9pxZ?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nMUxiEEecSICxI5sqD8B2ptg9SAYM/hEviWjQZgsCS8tT4MCagPbZsLSZWEP?=
 =?us-ascii?Q?V1jQfyU0o4AwgAVkyPZXw+9mM96abvuc0VXgcteaBZ5pTudoklGSd6bXfbyV?=
 =?us-ascii?Q?IoZqdNN2hp6O/RvcBmQ/HtKOmF3GWAhkqEC4ImvByAB2Ba4Ka6nQ+ZHNm8TU?=
 =?us-ascii?Q?uxKY7spAYchv3wjbeRAZXJG8jCed2fgXDHQ++PqR2AmcWwoAca9DxSwgyqPa?=
 =?us-ascii?Q?sE6sUwJTyDPG7DQDlNEItKd4YAQXp7w5Hww/KdTYu0k7OwZ0In4lnTHmoydT?=
 =?us-ascii?Q?Tbo467HIe/70vZQHTExF0qbif3MlmrjJhWQV7ZXEWOOpsHTDviqb0FRGkpXs?=
 =?us-ascii?Q?dfowHYwU+p/ATeWWgqJdZZYVm8MUjZ63oeTw1/EHRz2hLbJxvL+xtBcSJP1B?=
 =?us-ascii?Q?XERQ+0IcARQx1SOjAdhsZcMKNvO9ivpkUMh6x0q9syQDgssBquiw98E7c331?=
 =?us-ascii?Q?yVnj2xMzCU5xyWXmzs9Ul75vUQWSaiu2qK/BgsbFAnieyYIHBugX4M+g0/wl?=
 =?us-ascii?Q?hqx/Lgj3Fk/ECnEEuBnbuHtUW2baBn45ck6TGBFc8INPuV7eBG2PRwozP/E5?=
 =?us-ascii?Q?83q/OOcBY5ICgFevG24RTvvIvkFtD3/3vB5xKXu9lLx9Y08QoqGl3eCApKL/?=
 =?us-ascii?Q?w8y0zejuZU6PereSILp6OCbUq+yh8rh/aSIHmA86h2sO1dLSjeFZ/iM0RliI?=
 =?us-ascii?Q?W/R+Ghm7xGiL+8+NivVOOq/LZKclLhl4VcgBXjl5/9oTnQGmTcoMwE1Exf5J?=
 =?us-ascii?Q?dYmMuy3EBfaLwkrxfOLZHUyWkK4Ih3IiW43VxTiyWY9moL9t9avixzJRam0e?=
 =?us-ascii?Q?L5XyDPm88QXDtZZJwjuEhwdtLObzz96fLVt1LiJ9ImNNDMR07YBp7ACnegbU?=
 =?us-ascii?Q?KDXu145fzSJ/8oOIUlfbIyaS+KR0PsX1Na/9qKfkZekcyvNiLG0Fsc16k+Zk?=
 =?us-ascii?Q?b7/fK1f5DE3cykK9wy+WP/DYzZgZew6KmFQYZUXHay6AePLbAsx5WFC/ar4F?=
 =?us-ascii?Q?0MOLs/vMKG+sOzTCr/zwNqmWi2E6oG7dI3fMBwtqqb6tdmACA5FCpQCZuiwu?=
 =?us-ascii?Q?lo3m589F6+g6MwAlUvs8DERQOG1Hh19dcSVOIWS9k9h6UmTmP6S6iii/RwBq?=
 =?us-ascii?Q?TdFisCOUXiGwVP4k7sEZ/uq36So+m7i9674sriPFTpHfHkVpC70JwxCeNrnQ?=
 =?us-ascii?Q?+hdPZWAZoBTvd4INgKJ09WNrBqgxJTDC2ABZeYgiGfBF9jDfIi+OEPyP8fhX?=
 =?us-ascii?Q?jLAtPrtd3XNmokc3fYsjVyfppjFzM6CLgQ1WwiLvYAMW4d6M1EcBYc+KPAYt?=
 =?us-ascii?Q?vux/O/0/yGg37PAdnqRJM13PYjBSV2YIyzzfNPeDApSJYa422+jghoo0106Z?=
 =?us-ascii?Q?fN5itrQPy8wivR0skf7sEE1J9Wat80YZhqAeVhYVwXccBeNZ6TA8nD3BmQKg?=
 =?us-ascii?Q?QSkHQR99gJhWYLxUp/u19GyQKK3cnbhwpZJ1Rlj3aucEicNvl2/F2RuOWFOq?=
 =?us-ascii?Q?sO9C6SbYH2tOu/HGfTxx0XvpX7NZHFzPnR+URlPImVlfNuzyqHoqbar3rg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d657a6-dc4e-47df-e6dc-08dbdfdcf59f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:00:31.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIfvH/0+LFB591xhEdpfMCALNE8/oNj6kl3Xy8MjC7DvPuben1k3rn+vIG6dxZAbcFGZpTEdUDtb/nmj5ruBt9pS4CxFiXf2xqNutMgolfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=956 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: pkkAQ8TpHc89A5zkhfNzngKdZPF-XpGk
X-Proofpoint-ORIG-GUID: pkkAQ8TpHc89A5zkhfNzngKdZPF-XpGk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xarray code has a common open-coded pattern where we do a flush,
release a lock and/or irq (allowing rescheduling to happen) and
reacquire the resource.

Add helpers to do that. Also remove the cond_resched() call which,
with always-on CONFIG_PREEMPTION, is not needed anymore.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/xarray.h | 14 ++++++++++++++
 kernel/sched/core.c    | 17 +++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b1..30b1181219a3 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1883,4 +1883,18 @@ static inline void *xas_next(struct xa_state *xas)
 	return xa_entry(xas->xa, node, xas->xa_offset);
 }
 
+/**
+ * xas_cond_resched_rcu - if a reschedule is needed, allow RCU to
+ * end this read-side critical section, potentially rescheduling,
+ * and begin another.
+ */
+static inline void cond_resched_xas_rcu(struct xa_state *xas)
+{
+	if (need_resched()) {
+		xas_pause(xas);
+		cond_resched_rcu();
+	}
+}
+extern void cond_resched_xas_lock_irq(struct xa_state *xas);
+
 #endif /* _LINUX_XARRAY_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ea00e8489ebb..3467a3a7d4bf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8664,6 +8664,23 @@ int __cond_resched_stall(void)
 }
 EXPORT_SYMBOL(__cond_resched_stall);
 
+/**
+ * xas_cond_resched_lock_irq - safely drop the xarray lock, enable IRQs
+ * (which might cause a reschedule), and reacquire the lock.
+ */
+void cond_resched_xas_lock_irq(struct xa_state *xas)
+{
+	lockdep_assert_irqs_disabled();
+
+	xas_pause(xas);
+	xas_unlock_irq(xas);
+
+	__might_resched(__FILE__, __LINE__, 0);
+
+	xas_lock_irq(xas);
+}
+EXPORT_SYMBOL(cond_resched_xas_lock_irq);
+
 /**
  * yield - yield the current processor to other threads.
  *
-- 
2.31.1

