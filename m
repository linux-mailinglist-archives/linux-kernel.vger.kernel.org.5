Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3032A792F13
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbjIETi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjIETi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:38:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F747B0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:38:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385JZUDe009295;
        Tue, 5 Sep 2023 19:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=r0XRXH1744yL8PfNtgiQyl79/3+vRNSrR5TV1MIfpjg=;
 b=MKAEEr3LCYG/Lr5IBYZroodqa51lm4aFDztVH4RIHv7cv9v7ONh7uYHyBzRB1xvzos/M
 m6CA/orN/BHRwHPdLraYLmIiwKz111ku/UpG820867BUG/wC2cCO2LFtz97WAjSvlW8h
 ul7KYZNUTizP+jJMpyz+xujaELFmoXiMO+oKiOG9gV9uHBShXGYJ7anPEAyecja8r/5k
 en5NG056VMXATU2na3R+e81U+6pojHWGRRKNVRl95UQtFTVvsCkgV9gYFb8S8xX9pFaI
 VGraAQcsLmrG8ZmLTDb1lRF5Ffh/M2wdFJLr70FQyOF2UjxcbvqkMlPknxDZ0ic6vqao Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxam1r01a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 19:36:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385HgeAI010395;
        Tue, 5 Sep 2023 19:36:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugbfacq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 19:36:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9ucmDi1e3NzHnReX2oSkrGs+QMhKwJxEpXrRaYu1opWsUoxHn9MQMkX0e0zFFEWROfvz/O+CqDWYR/13xu6WBP6A7LoMZxwjUfHMxcWhvbAbDBg+TfHwPBASo3e2x9agF7MNi7ug9Xt/9YIqh6c1BMEZIYtchXd8xkZL1B+zoBis5I9WVFo2es7XjxRgSBplpZW5Chnw32urg+UfspTtIj/4Gsu43iZPs2fV0OB+DBGp6nCwdIi8wH7IhkmZkEoSUQafAtsf6lNf6kxSgJpZ0W8Il6MA5XayloRrxCXZDB9fQJwiRcmG1MQ4zszSx3hby9+xCUZegpSuGuzWnR2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0XRXH1744yL8PfNtgiQyl79/3+vRNSrR5TV1MIfpjg=;
 b=dYjJ6429sSIBIA2XgklevONCAa3tItpGXkAOJPTlu2MWAWUo+N/yH26cjd5+Ki8YTTvfoIzIER62Ob2P9ry/8gp/TWLI7ynDBaPacUdBYthRZDYgWgaWk1OJEJg4bqY7W8J6mFVJ4S7Tn+63731lc3MEAbcPgcBpvgdcJoOe9uY71B5n/G/39SmO/vySSblQq0UyoohjEM4tTA+C3GejKB46GC2kHHnNBkGeYaXS6MbyqMoVC4npSr3wFav/vZ36ULM0oBKmQx60Lj7BTCPwMcowE+To/IHRCBne7aIHI9tcaSA4nCqvD+OTnH31J7yZf47Q52q5ikrTmTSfW4UtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0XRXH1744yL8PfNtgiQyl79/3+vRNSrR5TV1MIfpjg=;
 b=gFiMd9IGH70bkrQ4yOwPqBT7o8kSdEUhBOx0DymgevHPz75mCytWvukSx1SHGLIfkNPF5FGvMwZfFN3ShOvUKtB4+aD0FBl5ugKUJv0ODUdj7AauLqfAR4/Rj3KEAKnbCYd2Pevhb+7zCeOe5Xrop0zgB0GM3OrULNkhFwwXuPU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7501.namprd10.prod.outlook.com (2603:10b6:610:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 19:36:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 19:36:11 +0000
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <2b79ab3b-56e7-926f-49f0-4c2584f6a72b@amd.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 0/9] x86/clear_huge_page: multi-page clearing
In-reply-to: <2b79ab3b-56e7-926f-49f0-4c2584f6a72b@amd.com>
Date:   Tue, 05 Sep 2023 12:36:09 -0700
Message-ID: <87o7igct06.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f8302d-5788-40cb-69b9-08dbae475bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qKBjj/cPmy5g6C05KXtfJXjlUKMQvqRfvn0K3tu+NTCNfcughNZIICWENPJ8S6k2yOy+3Q4Ljrn1oPZSpJfLCFJjsV7Fe5HsrTisvNvcPOyRUzsTqDyK/pk2QsPlrs/qowSvaCuSBKkb1JFqbQLbLL2nDx1FiDxw21bwNXrplZqmYblh078A19o4YnGEvn7n77KM8pnXFoh1KyLQQc92Qc2WrzZZMsIwfeKyRNW5Ts8nCoT9W+yR05vmIxeUsH14aEA1hbmXFzMfi//dugNqD7RWrgP99YFSZle8SR9irBGSyeWA7xWmAg71KP+mAjZv1NE+94BHc4KCJV+Nc8vDUJfzDjY5DvELhsoYVNAZI0pJSBPVpy6dS3bT/v2gnyL8xoJae6dD/c4uFNyhhg8LTG9VDh7GbGUN+RoHqIQ55WWmmnDuTuKJra5aOd6RKCPfH3jGCYyQitOIfvySYxR1RhYirNENBGo7e3dOt43EtTjY8MirTJx54FlNBEtWM6qUUgjGbNLrrqj7GezqTqmf3qwoozK9Nd2nGXNTZ7SC99jSrZiH7CCY3nOJKv/5vpKUUxXdK7oBvM+qI01slJwIGJmia+65fOIZkwABhSIl8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(1800799009)(451199024)(186009)(38100700002)(19627235002)(41300700001)(6916009)(316002)(66946007)(66476007)(66556008)(2616005)(107886003)(6512007)(6506007)(53546011)(478600001)(6486002)(5660300002)(8676002)(8936002)(4326008)(2906002)(86362001)(26005)(7416002)(36756003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pIHX+/rf2dOz4B6khfvaXVZ2s8xjKVxRBAxSeJ2UJYozQ7gHIXLBRlrzDWia?=
 =?us-ascii?Q?H0QwyMUA7VWEMU6mKNBRtsCIJBufO+4Xcka0OyaKbK6eSUUy4j4dVtXrxxJo?=
 =?us-ascii?Q?REYNy8iDw+jfB8Xrg08W2WWFw0ASwZFhnDAHDPmQdLB0K7B/vcfjg6IXjnOE?=
 =?us-ascii?Q?K5DagDyhWvEf9hoXi1uM6QADgfxX22Y2IdvEjw9wmWjDw+OEb64vjx8aKpz5?=
 =?us-ascii?Q?E9zD9tEk7aWwoRfNDpU/7GPQfU+lhrmL5vKI7WEz5170UiXb6l88v0DRZYXn?=
 =?us-ascii?Q?CRmqfbqlRzEy7efFx7P9y2L9CTisCuNHuG1Qnii6/ArUdzCbC/kpMW959RiE?=
 =?us-ascii?Q?1DCCGZeK0MoHG6k3rCmSDQnuBsBiIbr/xA+BqQvXsALhi/XEOrrop8RWeLPw?=
 =?us-ascii?Q?9WeOlA47NwyKwKBVvLc1HrxUxQJIgPcaiPIaKBW+umo2Xzao0QrcGJ2L5yH9?=
 =?us-ascii?Q?yLtxcFXYoN/dW+KqpcgpXYEcT6GuC38LcW1a9Swg1G7Gbpsxd/ADwTsYr7Qr?=
 =?us-ascii?Q?b4J5iH8m/jpgqmwiEEFkuAJ7lPXzf4ZE97GdagNb6XPZyHju0xNVD+Uf907n?=
 =?us-ascii?Q?5FIQusRXYLhlfJYVzO/qQiurQIUTaPy2wG52hHE/7iMEf6IqEBgeWDP82IQV?=
 =?us-ascii?Q?aPe8AapZYxWWJmfPjYDx09FeSLfeXjyTIIHMP3ThCY0wemgk5yywbR3a/hR8?=
 =?us-ascii?Q?5CnZZL1vOlK9T81B9NGH+sTF43VYGJbWj5bmIZjDfpo47jlO3/zqDccgRsQT?=
 =?us-ascii?Q?MpLIjX0WcEuat8ADpI+mF5ahXDAk7mRszpiaUBc/qjcKGTF6pMzcMbFVz40F?=
 =?us-ascii?Q?9nxb//7nV5hkTsbt1rz+4Y1emymgkCtvEiQAUjXvib11k+Vb0yM5sbNHTjwr?=
 =?us-ascii?Q?5+uU04pykEnMww7vSOEkaQgafuo450HLw6H1lwexUdwzPKDBLJip47BuEOt2?=
 =?us-ascii?Q?39dU08VaYKoBB2u621enKbRGryw1VxDT1yJD1SLDnSSR9j7XJYzpBufDUTyI?=
 =?us-ascii?Q?+WpnBAdaEEYU5QdIN1ZFK4ab0ZB97zPgzY9oLwh2EG02612jHTDcxdsk7cAp?=
 =?us-ascii?Q?RuYqzXw4Qqnwg09u+MhspnKHRdeC1eWMj9++BLnHZflwC1Hr/RXZerfCaOH1?=
 =?us-ascii?Q?6AvzL9P0Cmids9xIenRYpxTVzmY50mfocfg6/6QNKTpohqNDhFM6BzCwxTXH?=
 =?us-ascii?Q?SzVfSZQxaI02yd0N0bdZjbiR9TrM5v0N71LFWVjO7O/4/3bKv3d04w6Q4zFZ?=
 =?us-ascii?Q?QRjH4D0FAx8uKldjNgUJKaCzBfUtQZTPD4DkC+3z5wFOTI/hKi2qm8BSsACe?=
 =?us-ascii?Q?4Z8QiRk/CIntewtQb2geKoZjapJO6SxgzhQwAzTDeIyHrhQWAacFuvB/caCt?=
 =?us-ascii?Q?iIR7YS0ypN0Oa11tWNHZSPtCVrrfVyt9w9lnIeeIYG7geHnXCouAtdo9Uc7z?=
 =?us-ascii?Q?8/whgTWeXSXv4VJ5dU1ZhX8fgEu+ZBSj1ixlD8EIqdKMpS88fn2O8Zn+Brn8?=
 =?us-ascii?Q?fb4yk2q0qah2b+g1cdPxolUUBykspm4TiySUyDpPmHzmXql0k21+bUxecl93?=
 =?us-ascii?Q?gzJR+aCVLye15B1W2rQ5hAtc9pORaV4zxp+d8+4DHUsBfX8fup99PLr7Kj0H?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?gpbkR8iKMpVYVg+aFt6wukxSisYTVzBEJKNCNxQqVMwGsvzJB5N8h5Xa6Xp1?=
 =?us-ascii?Q?V7HI6OWii38qebF4tBYruSnCPfXs2G3M1AR8BLMYBkPOD08V//k8E6mCi7DB?=
 =?us-ascii?Q?qoh2Z/jWtBlZhW9xm0lGi7sqD4rFGdmhZ8jztm9HT9hNXIUWm+60UXc5BcPB?=
 =?us-ascii?Q?kBQ+FadLMC/L5o+TI4QVL6Hc4+NLMowRfPk/YpW+APgn1Yxd6kYFWSqsbsX0?=
 =?us-ascii?Q?S3+luZdj42sfqkCNZunPFH8lBUb2EfdUENYKF33EovQWJyGr9p0OwgoUZe+1?=
 =?us-ascii?Q?ImHmfGPK2N3fk5JAyLNvL+ZcyXs22wrZajeDHSaJOskVKWCVN/dQRXFMoaoK?=
 =?us-ascii?Q?FHTXhIxMSq+AScnA4M/9EOk0fmln8AWnilptcXlCDFKXmAatlGAjTyHFUEcg?=
 =?us-ascii?Q?r0kV4fCRQUpNKelmnVA8K4+qZ434nz74TcEnAIzlQHksyPAfp5lcjyvhnRId?=
 =?us-ascii?Q?fLsCWm/BcnNfxIuiYBAq5MddWybPBXK5riRw4ytogjh5dgD1B+qrukBWSQ4j?=
 =?us-ascii?Q?sa28WxQ9+1U9xPzO9h1Pn2cmtGqHlLNUk6i3f4lcfG1r6avNzxY4p9R95zCr?=
 =?us-ascii?Q?I0CMET122lLwZRc+XZdSwR0K3hlvX/IsQgy2hggrFllERjpf3KzRX3TP7gI0?=
 =?us-ascii?Q?AwTOsxuZUosVakPBiB1N4KhBWksaHnE2axxE/P42FdbYJ+xno4ioBABOVyp7?=
 =?us-ascii?Q?i5Cc9VZk612vKqYacJ3WWfygXTOhEQHk9c4pyU3ZCpTB3bjqHoajbMtl9Jz3?=
 =?us-ascii?Q?ofqM5U/ij5GXCRJ4QFzzLZ+CGGnSpVkJD0p+0LTMMxnHgXFlkPilEuRW9t+j?=
 =?us-ascii?Q?qUBzbJNt7/ov/yZ2/2Sm+MN7pd00l78DJSe+vXyGjGgiX+EDuCVVwiDEeo1t?=
 =?us-ascii?Q?yDNWW4daytHqIllnu88p1jIB87qxvPZr5eOQqBiN87oH7lrJHU6v1QzfJq79?=
 =?us-ascii?Q?iR9ty7csovQneTCDQoP5NRx1KxQOoSTsFz4hxLbJZD3E/E4zWbOXIl83+w0/?=
 =?us-ascii?Q?EJffvf8JSmZ4h36wj/WF9E37EL3KMl+/wdwovamsSrDqsBH2VkGLVLTdbs0P?=
 =?us-ascii?Q?EP/hAYBSymo+cPZGGU4GTB1Dz4Pr2fi7PFQxf1n5IYS/uJ7yQI41+4FsjQJP?=
 =?us-ascii?Q?xgj8KMTwmjgPwBiojEi7d9P3brUy9LA+VyX8CAGdMsxvwIYZwsAZaXo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f8302d-5788-40cb-69b9-08dbae475bf3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 19:36:11.3609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eo8ztyjCPzuWyq3mPuz3bgRECyW8Kx3HiWfQSPmV66cpoJcMD5jZf73apGuNglhWS3PIJOdQA56w/t0pjeOJOef0ayrzJPjy3MXtD9mzzDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050171
X-Proofpoint-ORIG-GUID: QZ98iYxFW6YVTPid07Fy4EODpQ8tZsJy
X-Proofpoint-GUID: QZ98iYxFW6YVTPid07Fy4EODpQ8tZsJy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Raghavendra K T <raghavendra.kt@amd.com> writes:

> On 8/31/2023 12:19 AM, Ankur Arora wrote:
>> This series adds a multi-page clearing primitive, clear_pages(),
>> which enables more effective use of x86 string instructions by
>> advertising the real region-size to be cleared.
>> Region-size can be used as a hint by uarchs to optimize the
>> clearing.
>> Also add allow_resched() which marks a code-section as allowing
>> rescheduling in the irqentry_exit path. This allows clear_pages()
>> to get by without having to call cond_sched() periodically.
>> (preempt_model_full() already handles this via
>> irqentry_exit_cond_resched(), so we handle this similarly for
>> preempt_model_none() and preempt_model_voluntary().)
>>
>
> Hello Ankur,
> Thansk for the patches.
>
> I tried the patches, Improvements look similar to V1 (even without
> circuitous chunk optimizations.)

Thanks for testing Raghu.

> STill we see similar 50-60% improvement for 1G and 2M page sizes.
>
> SUT: Bergamo
>     CPU family:          25
>     Model:               160
>     Thread(s) per core:  2
>     Core(s) per socket:  128
>     Socket(s):           2
>
> NUMA:
>   NUMA node(s):          2
>   NUMA node0 CPU(s):     0-127,256-383
>   NUMA node1 CPU(s):     128-255,384-511
>
> Test:  Use mmap(MAP_HUGETLB) to demand a fault on 64GB region (NUMA node0), for
> both base-hugepage-size=2M and 1GB
> Current result is with thp = always, but madv also did not make much difference.
> perf stat -r 10 -d -d  numactl -m 0 -N 0 <test>
>
> time in seconds elapsed (average of 10 runs) (lower = better)
>
> Result:
> base: mm/clear_huge_page
> patched: x86/clear_huge_page
>
> page-size  base       patched     Improvement %
> 2M         5.0779     2.50623     50.64
> 1G         2.50623    1.012439    59.60

Seems like Bergamo improves over Milan for both 4K BW, and also
for extent=2MB/extent=1GB.

> Please feel free to carry:
>
> Tested-by: Raghavendra K T <raghavendra.kt@amd.com>
> for any minor changes.

Thank you. Will add.

--
ankur
