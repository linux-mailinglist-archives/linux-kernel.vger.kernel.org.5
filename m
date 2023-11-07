Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74307E4C8C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbjKGXLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjKGXK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:10:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4791FE6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:18 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LK0GI022798;
        Tue, 7 Nov 2023 23:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ywo9nh6WsW9hCbxxtYjc7olFLiTkFOtc52nxwASZ3L8=;
 b=WAYamrx3NnHwU8SM0vNsbwYAP/mjfEzhAgTLg6L3z+AAnZjrwmTzpCz4kvXTwgBV9LA2
 Tfm/35y9FLc3Gc4Cc1cNe4k/uAX6h7cC+HT4niXFpKIvyM7Z1BHINSJ+9qYQgWZw+H1b
 l2ZIsTNDNNJuHlh9NDOVQerCl09rzsdMfp4nQUKHP3J/JgD5xi4Jg/8LywMvZOVU65tH
 RvmVV9ZpK8Abu85GvICjN2tCIhfCkFM0OLiFLoqOImnOy0Z7CJJBOmS7R9C/xhD36sEm
 Dry0nDVUn8pkDbfbixAK+qd+wfvgI00Ua/vhoKmaaYplGDm+uIPjOiFreACbpEx7rkYH 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2006fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N3fcA000640;
        Tue, 7 Nov 2023 23:09:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wvd4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB4/hJjQKnBpETV38tpHeMrQS8CbpLWKv0eO6etnde4j/LMWoHQLn2gbQFjoyhv5s19Q07921Vv/VOToUolIWVzM22cx+hCsXX69vqDuoG/jnk22M5G1CLtrDiquAKgohAWXQzjEksoQ4/CuUavZ+CKjxm5KkhpGe5eB0F/9eN0iSdGw1hu1Cu/LSUqQMmsSWwkM3LJDNMQlaa7Z6M1t9eYCIF+pq5k6nXuBEkzHQhVytNAtxl7cg4sLljHmnHjo3UrvERAD1ufP2iSRnHXg2SJ2bNvnO99UglDLPQknWxzfCUR1AaHPQTG3PSOCGBWrvfRpLOuapjEQ/1SzLafLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywo9nh6WsW9hCbxxtYjc7olFLiTkFOtc52nxwASZ3L8=;
 b=XByppUSLE2NG0KWVhZeyLOD06RTFGDFOtDnFZjzfHeKRL4dFuiEYSccF4NtorG1nMzAW0qtETxPzcs2wcjORBK6xSPgcD8h7cWPbGOpCpDunwH47uQplcP71bMwLD3BtwETaYFV104ln8pyrPBw9BUj1sIlyJUDMPrX+6kMNH2/4EJFDv2AYYVR2obD2wkn5alYuxs3knQ37VTtBLVADVGTrecmhfejM0ul+Jmd6/lddvFu35UIFIJ23FQG+lDr6s6a7mqp8YshgvfMJBY4MTIY4I2nYsGt2PYCA7ooAAm4HTrH+zNrC6qawxlXaPpeNIBul0sMWG0AT+GVfDkDDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywo9nh6WsW9hCbxxtYjc7olFLiTkFOtc52nxwASZ3L8=;
 b=gMByEzZEOfpQuXezGvEILz18NTfz1iRcqtb9Ux5d8An8aiHpvLgaMhcfjyqhK/y8Gc3mvWn6/1DIgh56OGbKNCZnHO0d89Spu4Gz95W/04IqHxGDuNmGS3Wo6Ln6s6ecbP4BNBu8OPIFI6e7woVwv+M53PHHVdcIC9DufeyRsiQ=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 PH7PR10MB7010.namprd10.prod.outlook.com (2603:10b6:510:274::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.25; Tue, 7 Nov 2023 23:08:48 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:08:48 +0000
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 64/86] treewide: printk: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:00 -0800
Message-Id: <20231107230822.371443-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::19) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|PH7PR10MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cce687-893f-4d7f-c79e-08dbdfe67fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVmPy/rx/0NajJEa9ptJE4D8AgRDTFzv4bVjjWO3hAo3T2tn46FraWzvmA0ToyIVtGrU5cZYPCXDe/k7NNCAhAjZrlTO5kes2zY7NPV7kqA5p4syXOFPWnBZMMn9ud7s0a4by8P0UR7sK6XneVnD12vLTUrT/KVY0IwsekRa/12HlETp7k5QAqQcygKxYMVAi9mAfgtimZf/8Z2tJG+FteJ4Qf7eila0Gy/qmWRO3o6QDPManGtd+zNKEqfeICbq8rUxAf/DBe7qcTJNivtEuhmZGAX2uHwckkkJ4ahiV7rFKW5YrMCUwWMd7y/aoSEjzS2D0zd/uZL+OrwMXv/mxHe43sJ/d3s4HQoKwKaY/60Etx2xyKqCYJC374Xu3/aT5EUlrciJ6bm6iPJg4Oucrb4+rLxZOM4rNf3AKURQEnhAAkkydpAwOQlVPefK6jFr6nDUf7PxI4spO6AFmPRRUa/82gx1zlQ0n+GADrxDxTpSzOGA9GRoiEuyd/Zv85c4i2rIRcj2vigevcrsykOIiUn1w4qpBhD5WnSLHmTces0wK0r9OgQtRqCaE1FlYsjeGEXkiEme1glxF/4KMa/mYHO6sUK5b3e2DMsZVq4RU638ZM/u4HzaCs3ExLi3+7v+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(7416002)(7406005)(6486002)(478600001)(6666004)(54906003)(8676002)(316002)(66556008)(6916009)(66946007)(5660300002)(66476007)(4326008)(8936002)(6506007)(2616005)(41300700001)(1076003)(26005)(83380400001)(6512007)(38100700002)(103116003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?safcAGP4t0zLWR3J37zRHtvMh4DY6l1rlU/lNWHzM5zMXpXizLDhZgGkbV2q?=
 =?us-ascii?Q?+Xxu1OPlJbuoGrKmcSpfdU69h9WdFdQLFymVYUt1XmsWjeMAkbMvJ+PbCphB?=
 =?us-ascii?Q?mRc8ropWpZOeuFho5m3EcKHHsAM2U9wqZ5MIOW1sfXC45VqCqFCeWIdMHIgh?=
 =?us-ascii?Q?806NRq8Vi9lLUw5SdpXMMFHcKlK+4FWMNVe3huHRsIo5dPHHX0S+lz30PkxU?=
 =?us-ascii?Q?uFCqcnoMJJKFLnPNaK4xfRvqG+EmVXeTYFPA37gXle2Zs59cZW62uIY+nele?=
 =?us-ascii?Q?obo+zQ4WY4N+jFF6p5v4jkvZkM+6/PlEF5ZMpbzo4nIqArQ1xqQiN6gS1dEW?=
 =?us-ascii?Q?qpuKLnRHjP7mEh2E9OUxQ3O9BGo8CWUuuLUt2AFkj36vDIFff9YthowuBx+l?=
 =?us-ascii?Q?JH11+BmXpRIZIPXCSlQGNDVb9eGiUiy8ulEX8OCdQ2GSM1DJoICT0PLTPh+h?=
 =?us-ascii?Q?hLBqt7StTJZ4hn1AmVnbwJiTBt94Cv6Dr5iHxqWMZTxOXdVlfUqj3L9bL6Yb?=
 =?us-ascii?Q?paKc3syE5fqQV52dBcqSfQkU8fXruPBKfrBvJYC2yjzdBXZaBBERIPADnA47?=
 =?us-ascii?Q?9kDuTN3P9rvWdCoCP7jxx9NgvVeJaSkjgWTVsHD2nGexeBMJX+AkZddBzLbA?=
 =?us-ascii?Q?yNwP61ssrx6HPRZDx2KfUUxUNU0A/IzDsO+BwiKGjAdtdSO5WB0+d3LBJQf3?=
 =?us-ascii?Q?4/e4DlQ8HOfDU7rwZUJEtLWvsHx0oPLSqVVN11n+uleVpW4OSwsThUXVh32v?=
 =?us-ascii?Q?90HVfoMBdFR0EnifRhYBlFh9tFz6nhDLtHJOunW6FiHpVfgk42dNcHDRbc5V?=
 =?us-ascii?Q?4OZxVl61n3G/6+nG9qSXbXP0+RExWLzP4qpdy9nYFXZsZgUehRbbVN2oqqif?=
 =?us-ascii?Q?cZ1lvTgJz+Urf7nOjSkg4aWh8deZx2xDEUF7ZnD7d4dFUkmUc7sna2p/bKpG?=
 =?us-ascii?Q?GjjnjKZvPfeqbnw6xjiObSfNP4fBVSudIn2CMqBgLyuk68Rh+72CWaTToUB8?=
 =?us-ascii?Q?lhQCL3AE4T2QM/bVjpfdxINI2urYJcfDKfXsMayWWnMDq2dVw7CJpivMWfZr?=
 =?us-ascii?Q?dotqyj14ZCD9RFCOim6nu5jzSE4KZNh6uq4y7i6tiHdk+5AjB9v/qxY7qZ/y?=
 =?us-ascii?Q?DPNe2XA6KEZ6fueNhVCMr2Iud5GFahp6juz527fLp/lh2etYraGr3z92NCqn?=
 =?us-ascii?Q?j3xCsoFe2SiqoRcHnSyky2a39MhGc2P0lSUX6dCSLdiW51Cr9GpNH5GK/Adb?=
 =?us-ascii?Q?ONbUkzec8PFljKQ2NtfUq7BmQSBEWP3/sUHwH6VQu2ZExgNx0/Vz2d11I2/X?=
 =?us-ascii?Q?RUcCqR34lRTcXxkJzjgnw+7NZMUp2/6ZAaH6ZhkRqBrXSFPUd7lJ9Gs8wPsR?=
 =?us-ascii?Q?u+iDY8swOXaq8VpaeAbc54S0BbGPVCEuCjRFGXo19IQoFJ0Soo7Dh+HVNImf?=
 =?us-ascii?Q?Y/ySwNsFBdSWlaON3Npy2BUqzRN8I1gruejUJE0NUVbTc0b/b1RHP8KuvSBp?=
 =?us-ascii?Q?MCX0v/qiZTzqQXHpO5yEH2GYImxaR3DLRHJEnK49AkrzAuZwUZH1X6sX5kma?=
 =?us-ascii?Q?pfcg99vT5rBEav173SlPmQPCGoQ4rMRgih6tVfLDM3/VzRmqURagTBCVUdSl?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VTR5qck6qhuVW8oAv1Ye00EGT5ES2RAUG43ZTuqGTnS+sOt2eVoTedw/LfcU?=
 =?us-ascii?Q?+8o5IHg20UCtUm15V9aNDBwu0dnfgodeX2/iyHzXOfOpoRkG5HtIuzLdsUqz?=
 =?us-ascii?Q?APN3+QYAwXbzJKI/sqgGX4kTA8fv+UDWQWjMF8VpBpAXd4ugW0mpbEiqpqjJ?=
 =?us-ascii?Q?3dHVsCT8XHicYISLGKtItAGirXufDHH0NwGAD8E80KkEEqvfDBwbJGEX/jtd?=
 =?us-ascii?Q?KYspO2N7hVbchpZKYF1pe73mAa3PvKl4pxnQMlLs20CmRyZ4Vdn6jm8IEfE6?=
 =?us-ascii?Q?CIm/awMlT/Q3OPNCbl8FqFbG10Kg9Yxw9dXvNBqKCzVPjp9ex9T9FOr9+cB0?=
 =?us-ascii?Q?GiiNw3qa4wederE3qVAw1TXMe7NGSizaJR25cmPRHfUD9iXY2+BegJhuPD0J?=
 =?us-ascii?Q?YDKZOZbnIfKb/mOXwzRQVAMcIpqmTrPOwElukl1qKrrEa126sfEti25IVX8i?=
 =?us-ascii?Q?eAlr4WMD8KE59zdJ4ZYdubCmN9czd+oXpVt+07C6XvxdNT5dFbMVDABji9KD?=
 =?us-ascii?Q?Hxysy5hnYxY9z5IxgUU4WwFNIsqfvfBSP0bLLyAnkGX53w2SjMz5jaqvbvQ+?=
 =?us-ascii?Q?UOGQKEpL+hDtVH+eJiGKrLgNJUz7vmgmTXAmRimQQcJBHg0QhRHZsmjwr1EK?=
 =?us-ascii?Q?39/OwicJZCtO/td82fU5P8/CyE+J46UXbHytGjlHcxcbLwk9O0/uFN2W34iL?=
 =?us-ascii?Q?k+CQNvxVm5VqblT8MudSyISmeguSBc2Ewbb1dJ7RLmcAv77s2Ehmtb+60GCJ?=
 =?us-ascii?Q?xeWAUd4yrFw+yzHXGBDh98hLXdr9BVf41KjmqYHmJL1J3cr20LDm18OVZW3U?=
 =?us-ascii?Q?6Nd2eJYyHJZSwNO+AhW3v/N6p02wGMXOgtZ2a+E1RePKJpxaRA0kSHxQxsye?=
 =?us-ascii?Q?B45cBwoC4vzupT84+hjU3dBEG/scCE4NUf3D5jYUzBKwEXh4lcUbuIzlHRkD?=
 =?us-ascii?Q?LnBY77kS40Z/pqYjm2baTZL27/Wi3yT8UpWrwOvNolNBtFBmfJOmQarGEeay?=
 =?us-ascii?Q?f1HdcEU5jvayr/5HW0ufRyUWdXCHBZkIfE+QnoiJclDPQh35muX6D8Gw8itR?=
 =?us-ascii?Q?zxaYIChTZ7PrxR2MoVb2Ebrk++dMAgW3NZ+LOsTUvoJUFf2yEqcGtonxGgPu?=
 =?us-ascii?Q?VWm6EbKUezGOsLkWCc+wLdzZbJeosTlixN7FL6SBEL/ZIPT0VNv7fI03U/BW?=
 =?us-ascii?Q?Fl7YMeMTD6fWdTE273Kx1pnUeHUmKSM4Wn6Lcd2OXNPAW8LspSXWE4lz3XJ0?=
 =?us-ascii?Q?jGbGOmLcX8soKTzGV6KUVSdQ+n+dwYoq7vhu6pYWqBkNJ/3TQdFVXa1iIfXg?=
 =?us-ascii?Q?QwQfCJVbSeGU+37+IvGeGp5uJVYa9ueFCejP4gH72oslXikpqMR5kgarXL/A?=
 =?us-ascii?Q?NXwd3bOI4NCUtUZR8taEHAUiu5gEgyIYR5y2PYEaJLHU3WgPB5sPKxqC2I+D?=
 =?us-ascii?Q?ebNyb0xtdwhjX5UKkDIe++sP6OnzsykoplyXVO3gA8gXsub9S7O+d0i6HmAr?=
 =?us-ascii?Q?K++upMOOLHKPp+BxeXlo/1Xq3mRCv0AJSo6czAlQVfCaq8AHpqfro1+2uev7?=
 =?us-ascii?Q?BiNZvnLS587EIgdIgq00SmiwUI9u8bmLnU25KXjYwHnfbn6w/bKEYT0PIS+n?=
 =?us-ascii?Q?4WZPwskKYqVgNooYkZ0HeJQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cce687-893f-4d7f-c79e-08dbdfe67fb8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:08:48.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dANcJPZiyeP8bIKr7EVXvcvAbP23YRrQc/zb0Ub+rOHXRP+KY5fNCyG5A4JuV9FF1SxkkvlrnTUMuwcNZCf9gAokLKOXljwFmOR00O9MZBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: r4XYZmFDUmzKnMOoqulRjoN3V0K593e7
X-Proofpoint-GUID: r4XYZmFDUmzKnMOoqulRjoN3V0K593e7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk code goes to great lengths to ensure that there are no
scheduling stalls which would cause softlockup/RCU splats and make
things worse.

With PREEMPT_COUNT=y and PREEMPTION=y, this should be a non-issue as
the scheduler can determine when this logic can be preempted.

So, remove cond_resched() and related code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
Cc: Petr Mladek <pmladek@suse.com> 
Cc: Steven Rostedt <rostedt@goodmis.org> 
Cc: John Ogness <john.ogness@linutronix.de> 
Cc: Sergey Senozhatsky <senozhatsky@chromium.org> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/console.h |  2 +-
 kernel/printk/printk.c  | 65 +++++++++--------------------------------
 2 files changed, 15 insertions(+), 52 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 7de11c763eb3..db418dab5674 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -347,7 +347,7 @@ extern int unregister_console(struct console *);
 extern void console_lock(void);
 extern int console_trylock(void);
 extern void console_unlock(void);
-extern void console_conditional_schedule(void);
+static inline void console_conditional_schedule(void) { }
 extern void console_unblank(void);
 extern void console_flush_on_panic(enum con_flush_mode mode);
 extern struct tty_driver *console_device(int *);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0b3af1529778..2708d9f499a3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -375,9 +375,6 @@ static int preferred_console = -1;
 int console_set_on_cmdline;
 EXPORT_SYMBOL(console_set_on_cmdline);
 
-/* Flag: console code may call schedule() */
-static int console_may_schedule;
-
 enum con_msg_format_flags {
 	MSG_FORMAT_DEFAULT	= 0,
 	MSG_FORMAT_SYSLOG	= (1 << 0),
@@ -2651,7 +2648,6 @@ void console_lock(void)
 
 	down_console_sem();
 	console_locked = 1;
-	console_may_schedule = 1;
 }
 EXPORT_SYMBOL(console_lock);
 
@@ -2671,7 +2667,6 @@ int console_trylock(void)
 	if (down_trylock_console_sem())
 		return 0;
 	console_locked = 1;
-	console_may_schedule = 0;
 	return 1;
 }
 EXPORT_SYMBOL(console_trylock);
@@ -2922,9 +2917,6 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 /*
  * Print out all remaining records to all consoles.
  *
- * @do_cond_resched is set by the caller. It can be true only in schedulable
- * context.
- *
  * @next_seq is set to the sequence number after the last available record.
  * The value is valid only when this function returns true. It means that all
  * usable consoles are completely flushed.
@@ -2942,7 +2934,7 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
  *
  * Requires the console_lock.
  */
-static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
+static bool console_flush_all(u64 *next_seq, bool *handover)
 {
 	bool any_usable = false;
 	struct console *con;
@@ -2983,9 +2975,6 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			/* Allow panic_cpu to take over the consoles safely. */
 			if (other_cpu_in_panic())
 				goto abandon;
-
-			if (do_cond_resched)
-				cond_resched();
 		}
 		console_srcu_read_unlock(cookie);
 	} while (any_progress);
@@ -3011,28 +3000,26 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
  */
 void console_unlock(void)
 {
-	bool do_cond_resched;
 	bool handover;
 	bool flushed;
 	u64 next_seq;
 
 	/*
-	 * Console drivers are called with interrupts disabled, so
-	 * @console_may_schedule should be cleared before; however, we may
+	 * Console drivers are called with interrupts disabled, so in
+	 * general we cannot schedule. There are also cases where we will
 	 * end up dumping a lot of lines, for example, if called from
-	 * console registration path, and should invoke cond_resched()
-	 * between lines if allowable.  Not doing so can cause a very long
-	 * scheduling stall on a slow console leading to RCU stall and
-	 * softlockup warnings which exacerbate the issue with more
-	 * messages practically incapacitating the system. Therefore, create
-	 * a local to use for the printing loop.
+	 * console registration path.
+	 *
+	 * Not scheduling while working on a slow console could lead to
+	 * RCU stalls and softlockup warnings which exacerbate the issue
+	 * with more messages practically incapacitating the system.
+	 *
+	 * However, most of the console code is preemptible, so the scheduler
+	 * should be able to preempt us and make forward progress.
 	 */
-	do_cond_resched = console_may_schedule;
 
 	do {
-		console_may_schedule = 0;
-
-		flushed = console_flush_all(do_cond_resched, &next_seq, &handover);
+		flushed = console_flush_all(&next_seq, &handover);
 		if (!handover)
 			__console_unlock();
 
@@ -3055,22 +3042,6 @@ void console_unlock(void)
 }
 EXPORT_SYMBOL(console_unlock);
 
-/**
- * console_conditional_schedule - yield the CPU if required
- *
- * If the console code is currently allowed to sleep, and
- * if this CPU should yield the CPU to another task, do
- * so here.
- *
- * Must be called within console_lock();.
- */
-void __sched console_conditional_schedule(void)
-{
-	if (console_may_schedule)
-		cond_resched();
-}
-EXPORT_SYMBOL(console_conditional_schedule);
-
 void console_unblank(void)
 {
 	bool found_unblank = false;
@@ -3118,7 +3089,6 @@ void console_unblank(void)
 		console_lock();
 
 	console_locked = 1;
-	console_may_schedule = 0;
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
@@ -3154,13 +3124,6 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	 *   - semaphores are not NMI-safe
 	 */
 
-	/*
-	 * If another context is holding the console lock,
-	 * @console_may_schedule might be set. Clear it so that
-	 * this context does not call cond_resched() while flushing.
-	 */
-	console_may_schedule = 0;
-
 	if (mode == CONSOLE_REPLAY_ALL) {
 		struct console *c;
 		int cookie;
@@ -3179,7 +3142,7 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		console_srcu_read_unlock(cookie);
 	}
 
-	console_flush_all(false, &next_seq, &handover);
+	console_flush_all(&next_seq, &handover);
 }
 
 /*
@@ -3364,7 +3327,7 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 			 * Flush all consoles and set the console to start at
 			 * the next unprinted sequence number.
 			 */
-			if (!console_flush_all(true, &newcon->seq, &handover)) {
+			if (!console_flush_all(&newcon->seq, &handover)) {
 				/*
 				 * Flushing failed. Just choose the lowest
 				 * sequence of the enabled boot consoles.
-- 
2.31.1

