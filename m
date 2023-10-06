Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F897BBCC8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjJFQc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjJFQcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:32:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E75ECA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:32:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396CcC16025434;
        Fri, 6 Oct 2023 16:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=hNDGk3wpKmYUiTREz/ODSg3XH/Mbvo6oX9jxcvJbwBk=;
 b=lNVOE81OynQG2PXASjYYH3ZDkZl3kKGYSa1Q4JpkuA/pg1I/cBf/CUqnUajicexiEbP8
 Nc/S3Wct1JjjDzhUoJr+jwFGdjo8l2X3KHdDsieBe70E6Fgnw/SWKlRtyU/5O3CvdtDM
 pbx616ZfogCBA2TH1my/++Kqca9GhI4fHcpfYzyDhybdikv/cSwA7mtd7WMtBeOoJLE/
 H0sRKjSEEZKE2eRmbFGtPpt52oV686V0P4LDsI8/zX05a+yjsfL3iPFvc5h91GRC3F34
 QAjyTWsn3GljkSY0x8SY1Fuyy8NvcLhkdy1wsCem9/WwNk1G20IYi75grHxdMwt04fu5 4g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf4cb6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 16:31:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 396Fjs6D005994;
        Fri, 6 Oct 2023 16:31:55 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4axnk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 16:31:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOzFlbnuiTt9cnxUNCEAZ6VGsUc3xVbphr6wyPvDwMNsZeUI4sFNPyT7JIh38Ax/qPl8eXc0vbvw61xlMAfvpMp50v4DP4XsQgwsqnF4iooCWp5fbQD11zZWbrUCh3VN+PYihmgi5AY0hXgrWZK9biuEsq47DYjJ6GFoeBIrZHCyoTYpc90A7w5OP/ds+rMqDPp7BK3ZovxMXiabSFpO7MT4JO++wANV1ORw+VHvhq9rX76GEq7Tck1AEEwcMBggwFKVR2Wm45WBGhL+01XlJPId2M702uBvvHc6IsEru+Oz25Lq2o9NYnidJrm1z6omGXgLygkL8nO7r/KYG2A0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNDGk3wpKmYUiTREz/ODSg3XH/Mbvo6oX9jxcvJbwBk=;
 b=hGXeWH7fPcpbz5YYBlSaBJM1cQoSN7jpnJeomeixEMgjLrvp3nkH/Yk041bCQT4V/Gu052vNJQr6qM6P2WffNbDmGYai9uj2n/T4OM90YmZEzpZdbbi791K2Otj8gkNC4BwyPebqssnBOifLe8nqG7SqrHWitJU3DgQ4b/mj6w0KWnh4qo8uKAkjKAkNrv+hEXovHVPPmQAlpKrv3707iLYf/z/crxW2/+jm2VT7AyWZRZ26M0oFcsfUvML3pTynrU5LQx9Ug0OxupmXY0wuQrG9qolVQU9JEbFLoTtJamApA2t0b2mvhZ3BYDEYERwPagXv+K6QvsXpTb9pxNToXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNDGk3wpKmYUiTREz/ODSg3XH/Mbvo6oX9jxcvJbwBk=;
 b=XbD9H5nxSJkOCjm7NqSgQV4vAZju5r1HOBiRkBTZcTieDyrhsqkdi6y3+wq0WCSWWs6t9QLf8PPrWcOFJCirbB6U4tFWV5SUY/JBg/WnBoX3IFGyovoKcJJY88PjAccYD4cjs9f7aTlLKDOjzA1sZ2EIuf3bWCLKLQcxCEm8ahQ=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by DS7PR10MB7156.namprd10.prod.outlook.com (2603:10b6:8:e0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.35; Fri, 6 Oct 2023 16:31:51 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48%4]) with mapi id 15.20.6792.026; Fri, 6 Oct 2023
 16:31:51 +0000
Date:   Fri, 6 Oct 2023 12:31:46 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     peterz@infradead.org, bristot@redhat.com, bsegall@google.com,
        chris.hyser@oracle.com, corbet@lwn.net, dietmar.eggemann@arm.com,
        efault@gmx.de, joel@joelfernandes.org, joshdon@google.com,
        juri.lelli@redhat.com, kprateek.nayak@amd.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        patrick.bellasi@matbug.net, pavel@ucw.cz, pjt@google.com,
        qperret@google.com, qyousef@layalina.io, rostedt@goodmis.org,
        tglx@linutronix.de, tim.c.chen@linux.intel.com, timj@gnu.org,
        vincent.guittot@linaro.org, youssefesmat@chromium.org,
        yu.chen.surf@gmail.com
Subject: Re: [PATCH v2] sched/fair: Preserve PLACE_DEADLINE_INITIAL deadline
Message-ID: <dqrnrq4atsbfu2ftgnw563ovrg7p4i2t3vpjerqs5xezhy3omj@ixdkxq3y66ss>
References: <20231004011737.188682-1-daniel.m.jordan@oracle.com>
 <20231004130908.238992-1-daniel.m.jordan@oracle.com>
 <ZR2IzepAXhxnsqLp@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR2IzepAXhxnsqLp@chenyu5-mobl2.ccr.corp.intel.com>
X-ClientProxiedBy: BLAP220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::10) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|DS7PR10MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: f02a2cca-7bd9-426f-477e-08dbc689bec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkTN9zEEIBaLxcqPBbEG/2io/tTHH9SZhE6uHFuku3hwzz42T/AV06jG2EKMvvTJHmCTREh7ALFExjiPyDCSkbU8a4daDAD03O8UrHddC0sJNYIUvdhT5s7GVLiOee1p1QtdvWfxbZKQWPXYUrm2TSH/nrarQC6SUVprXnc1RLQEslnG231AS7DyTzhuv13vdIkChphf1AH58UFqyhPkvKTpsup/dvA8i+pTd4NcqXNIialeuasA+2A3V9gXR2qZZZv12AfT/qOv+4EWp38V6teTxFW0YSUZ7PKH/6srtm1Lwb+6X30V3fPSvZ7SxO1tUHtTQ6quSXRXAUv4z8e7BHfKeE9lzFVhqGoSM7jK6eCnKRSjG32lxU6em1yV7sSCxkLb1XUs6mn0jGOQwWo6BbgeTZKB+Or7kbwxuLDBB2nVr/4KtUsL1kJATOdpSpIlpQmRwd4Gi6CReGtZYF5NMw+O9gSIX5/aGscq5EUcki5BNkiMxw9Iq8fpnCT3zWFF+SAfi4t48NkuTvMe6WWgKQQ+IOGGBbQxkrM8CBx4Ow1KfIgPa7ep+Wie+GysjQaU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(366004)(346002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(6512007)(6666004)(478600001)(6506007)(83380400001)(26005)(66946007)(9686003)(7416002)(33716001)(316002)(8936002)(4326008)(5660300002)(66556008)(41300700001)(66476007)(8676002)(6916009)(53546011)(38100700002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+gPogVZSU6LF48sIYWEmV966eHp/rjWhpFQKpoxHew4YwQETk6aXtPaLOp5?=
 =?us-ascii?Q?WjobXw7pC0M/KgHxM+Xq8PEhOQfhBlmV8O67pjz2OCVPJ5rkCOkbbkGG442d?=
 =?us-ascii?Q?qRg120XGW4NTsWaFlEm4rEYNGEq92aV2a/gOJ5UeLPvAjDMa1bfHn5N+1L5i?=
 =?us-ascii?Q?cdzmo0ZNHfw9iggHeswm9TcSeBdi2+sw/toDFkVzCIhRC+/84HZ3Wu7uwBiB?=
 =?us-ascii?Q?xgoccQTPrTL9a6DQZMIMm9bsKmhhTpuGjPJh+uWL8Zowxmzge3AE8gGutNGe?=
 =?us-ascii?Q?niJg6h3Z5nA7tVSbOpexWK27GnYQLS0b+2LY9c/+js7bSfkrDHS8KWxtX5hW?=
 =?us-ascii?Q?SC1zFNK8KNxCGOKpQgQXrDexNssWsjpP57gd6t+tQVrTO8pwZld6vQ56dmFx?=
 =?us-ascii?Q?CvntYapapdAKp6aM29n20EJSVZwCdZVyXh1Dbgv6WoSx22fcdK/YCDR4wbZD?=
 =?us-ascii?Q?2rwm2Hveb8tJYnsT/qjS177DLubBIb3OTTpJrVpm5t0OWX8n1sX/8phBISGH?=
 =?us-ascii?Q?7dMkKqsRgHO4oi0hTPP7EQk8oVIqqrQUMBEzxayqilUWdmFBuD2ED++jrlP3?=
 =?us-ascii?Q?NxmoSk4of3jVKimlfJ6Y/iNXRUoC1yke9z+5uca4mrDpPK0AamGjsNFQgmsw?=
 =?us-ascii?Q?hVB7HWRoXOtAFsMa7TGxoJ5d7A6aCLUjFZPIpnrUIteMd+ewtBXumBvANXQx?=
 =?us-ascii?Q?EPYS31NU81h6Q6SPhcgWQ1P+DsVEyIliGc9aTRj1veYOjNeVarHaGe/Tlaom?=
 =?us-ascii?Q?P125rqi2psFeKzQV/z1svjtnFpWGrlKgiHb73tveTs7nxG9fg162FO3FNf+i?=
 =?us-ascii?Q?i3sSZk1BxNMGXcNFU1V7hHBaVl+QI1tv0Ea4HrfxG+FVG9x8KG6v88WgZM5F?=
 =?us-ascii?Q?dmn0wn78F7KxTvBmGk+VG0/GAcYWZahOCqbr8ieR4yOPX4woNj6NMeuSO/qa?=
 =?us-ascii?Q?fq8kj66btWWSI7WQEqy38hTu4lEJVFPszVWb1lLKw7qcY/5Kq93uR9ACbCE5?=
 =?us-ascii?Q?Ex3bJUCG6kh6aJYdkBCSivCJsd4bAGXRr3B+n7YD37Cyq+3vakPqbyvFl5Zk?=
 =?us-ascii?Q?mvsGj2KbQl1KeFt5TbQZS6rJQql6J5u2Z4L7sTrVDg2XveQlClypBh6gGB7t?=
 =?us-ascii?Q?QW8zV9/7MuuRz218/5m9ecoLkZ9MUC+zhpny3x0ThgYnrgVbW7nfT9jr+SVr?=
 =?us-ascii?Q?oxnKigrF+Kvo9t7j10VvV8mfqPIuVZDql7Qp/uOjDl5Hck3ppl2SxOGksG+5?=
 =?us-ascii?Q?JIDgsQ3waKolZ/akA2U1s16PS/4/JazkEiN6dSjv68adFLnyrb248DDHs0gB?=
 =?us-ascii?Q?l7iVolSTmRpOBQlrEvxK7esH/DXWwNy6BvO48mJuAVixFqzxq8cKVjZpPL0X?=
 =?us-ascii?Q?RNLkuMJdvtlPxWc3qwgx87nbOX7oVQmUseUmZKzT1z+C2BdkX+HPPWG4oz2b?=
 =?us-ascii?Q?cF56Fb9uDIRlaVl4AkhOIPOCv/+PgCFKEUaHlqGJDpOsRnGrqbqzZmSxts8p?=
 =?us-ascii?Q?3DpUkCHYFx/hMyjX7EVdX5+8j5vTqlGAGKQwwCNrXD6Dm5MX992LM3elis8s?=
 =?us-ascii?Q?MFOWRNNevRclze9jQU+WMDBM0uylKlfqK7g2BYTyiMkU0wegY/yfIpog0Tts?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lZvooZ7J0cEN5LO8mvWcimoRf38fROfLSZLRmgYYkNn55XUvfEOElgbAqYC3?=
 =?us-ascii?Q?xOQaHXZ7SfU+d4GBHGB/mWPJS7X41LKWGotxKDmTYLFgDmFdUPBo37HpU4ee?=
 =?us-ascii?Q?FgCdijvebXeVugbIg6lPkvCR4u5BMysFhpZSgfcN3KO4k9NBvwPU556AZdjf?=
 =?us-ascii?Q?gc+siDymF6fvFw15LxAsbstVbLWYMrtJ2VE9vBtdvGOtndu7Zt2mdxkeA6/2?=
 =?us-ascii?Q?tm8suhyqK5Fnkoc6RE+zKsaaIFI4uCaBF7ff75psZ4P/z1tjnYPolXjpmZl/?=
 =?us-ascii?Q?BLEJuTnfzfIicDmZWSKnxqjUsKVR6MylCS6tky63cgzLRsAqF4UqmYZ9No8M?=
 =?us-ascii?Q?dZRReoJuqY7hiibe8ZTvAHWiu//D5TzyTYDhCQPeaMsTS43jNWUoW9fIGO8B?=
 =?us-ascii?Q?sfGMu07HjYWwzF7O6BDwUQSham9PBLig8dhxRWmlgjdjzxXJjLX1tvUq7rgB?=
 =?us-ascii?Q?YRPUwCS7DEqgqygP3Za4O/sG2f0XeVQdp3iO3fIK3gS5E6Yho/qYHP8C+fZX?=
 =?us-ascii?Q?3qVQRE9hByrgL36PrfCNiSEEyLHA/Wmkz3iGbSrLaNL+bnKyA3qZr6SM93xp?=
 =?us-ascii?Q?sHHiFadP+lqamnqGwOv8VKK1grdjEPU4YVOQrA3wm3F1IgcLV8yiXJZZYok0?=
 =?us-ascii?Q?wTbLfUbqpPG0aZJxQq4AwmzfMW8vDRUeb9Qfsd+o2qjWFjnK6yvJqEENONf1?=
 =?us-ascii?Q?JKvC4kJY4kSA0BCMuYoA6j8tqSSM4Du+cncE/QGhWMvICvi3zh4IF2JcI2pJ?=
 =?us-ascii?Q?3+MGX2Nbq3o3ofaxWV8RYMjcURCCe6YJUMAjbvCvFPSU/sg2c5/tPR7FNSyx?=
 =?us-ascii?Q?g98oyj5URQQfWGeC3achB3HTUpu6hurp/RcgDX6v8v/up2HkdpH7R4bJwLED?=
 =?us-ascii?Q?KH7D9+zulCwMWtFOgmDYJnvuFz/DmqLu8qRxsoVNp4yBJ4+LnMnZl4Y61g1S?=
 =?us-ascii?Q?oK4WELT3nMst7efZg/+qiaagRG6FiOuUEJlsyzKMnFfBH1/T8kUoebbgdEbX?=
 =?us-ascii?Q?Q4S8ZY7qfmFwTuBMU4whVU2e6RGUM7k2Oz1tJmTPw6ihi1NXz6QilQ0SMrUw?=
 =?us-ascii?Q?Xk7DyKNAuOLQ+YeB3y9gIT+oGKdNMo+rwiwhQYDp3e/TDO5bytiE8xm2bXk0?=
 =?us-ascii?Q?U5+aZ4R3yX8Ruh7eqbrBMRS73sxk/dUutTleFJcAae6lo5yZuS/2KdigIfqu?=
 =?us-ascii?Q?FSpl6wCg0hd4devPytiR0mTK/CPERGVavH6nSAO3qwZzV+11y2odgX97T1c6?=
 =?us-ascii?Q?0HgtJvGFWaRwyD5COhdW3qP0Sypmf51vLIJxLP3tBfR0CWvGB3zW30nkfYmR?=
 =?us-ascii?Q?LoITma3p5klj7NTlB9adTsbQyxBfGnJcdRs8g0C/5OR2GrD9Gq0UzRklY/y0?=
 =?us-ascii?Q?4n/v5zg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02a2cca-7bd9-426f-477e-08dbc689bec4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 16:31:51.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBorplrTibabQJwrj36byVWQw4kaHZpu0erCgrdhGlmuPBQ6ywtuNCzouBqb6jRFz44UV/GHZaknCNig0crFNltdga0IBIJQeCpvNBcJiVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060124
X-Proofpoint-GUID: H21-uJDPRjhm4KTvDEsRryoDM33C0EH_
X-Proofpoint-ORIG-GUID: H21-uJDPRjhm4KTvDEsRryoDM33C0EH_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chenyu,

On Wed, Oct 04, 2023 at 11:46:21PM +0800, Chen Yu wrote:
> Hi Daniel,
> 
> On 2023-10-04 at 09:09:08 -0400, Daniel Jordan wrote:
> > An entity is supposed to get an earlier deadline with
> > PLACE_DEADLINE_INITIAL when it's forked, but the deadline gets
> > overwritten soon after in enqueue_entity() the first time a forked
> > entity is woken so that PLACE_DEADLINE_INITIAL is effectively a no-op.
> > 
> > Placing in task_fork_fair() seems unnecessary since none of the values
> > that get set (slice, vruntime, deadline) are used before they're set
> > again at enqueue time, so get rid of that (and with it all of
> > task_fork_fair()) and just pass ENQUEUE_INITIAL to enqueue_entity() via
> > wake_up_new_task().
> > 
> > Fixes: e8f331bcc270 ("sched/smp: Use lag to simplify cross-runqueue placement")
> > Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> > ---
> > 
> > v2
> >  - place_entity() seems like the only reason for task_fork_fair() to exist
> >    after the recent removal of sysctl_sched_child_runs_first, so take out
> >    the whole function.
> 
> At first glance I thought if we remove task_fork_fair(), do we lose one chance to
> update the parent task's statistic in update_curr()?  We might get out-of-date
> parent task's deadline and make preemption decision based on the stale data in
> wake_up_new_task() -> wakeup_preempt() -> pick_eevdf(). But after a second thought,
> I found that wake_up_new_task() -> enqueue_entity() itself would invoke update_curr(),
> so this should not be a problem.
>
> Then I was wondering why can't we just skip place_entity() in enqueue_entity()
> if ENQUEUE_WAKEUP is not set, just like the code before e8f331bcc270? In this
> way the new fork task's deadline will not be overwritten by wake_up_new_task()->
> enqueue_entity(). Then I realized that, after e8f331bcc270, the task's vruntime
> and deadline are all calculated by place_entity() rather than being renormalised
> to cfs_rq->min_vruntime in enqueue_entity(), so we can not simply skip place_entity()
> in enqueue_entity().

This all made me wonder if the order of update_curr() for the parent and
place_entity() for the child matters.  And it does, since placing uses
avg_vruntime(), which wants an up-to-date vruntime for current and
min_vruntime for cfs_rq.  Good that 'curr' in enqueue_entity() is false
on fork so that the parent's vruntime is up to date, but it seems
placing should always happen after update_curr().

> Per my understanding, this patch looks good,
> 
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>

Thanks!

Daniel
