Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE5B7D72F6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjJYSIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjJYSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:08:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DBA9D;
        Wed, 25 Oct 2023 11:07:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEwX2j032214;
        Wed, 25 Oct 2023 18:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=mLtM9cCrFyqR2pTpX9e6wpUARTUQRcvkn6dLFV9pilU=;
 b=QHJ5S5AkX+Lytfvpn4tlkmWdbI2DAsY4eJsjHOd056Ntb0SSOpZfMfsWqudbHPNVSDF3
 7U5bJvH7WEj6ZSJTjZjhLrh+eZXOKDb02KWjjb8NTkeMmyZRVPDlG/vBc+gGBttg5AIA
 h1IrqW024imDlUO6dajGsZBjHjs/zUgYoslKte0GghO6y9PdT5uH16dLQ/JEXRhz17Nm
 ehOwHVDwAU+/XYDs20Ov8jQBaL5mnxbDfco/kc2I5aFJttEbjGZO5t9gKgPahVZPzxDb
 NYMA1hGhSljZ4LDFLYVtwvVvvBPSdZwX72D5ZfMWMg0r9knIfUfVAYlDQZ0lMjwpolfW 4w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6harbks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 18:07:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PHSNLO015128;
        Wed, 25 Oct 2023 18:07:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5370xm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 18:07:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScLv39NUBpDS0LvwFM++PmIxlYq00fTMR6qtnp9E0Rfxe829PbpGoExJ9IeI/vQUMJCg4Y2t0V6bu7yxXVDubQkqHczdEXij7x9TARDwHRwtFicoHVqWyrrqzAot7ujdrqBFUY/nRFvDxUJMQNgAVmliD6TfGjAfkn2EiZ4AvL5kL7uwmK0AxcZ1UHik9niYQdrBeh60gFOLBX/hjjXdfX9X5wXuyUYWi0zT8gEqWCZVCk6L1aT97lZ9imVE2cJXm6DGIL/8Zfcidqzynp/9PsxqCjxOaL+vlGfAPBpk8+FO58W8LwhieSA5E/JX+PlS3vbW5LXVpzdIrBxz7iU28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLtM9cCrFyqR2pTpX9e6wpUARTUQRcvkn6dLFV9pilU=;
 b=Tl7d+W6xncZnjvXddy5mqrYTUBW594/9GaGJtbV1eb7UaQdAQo28aODoY7CrsGEwdwPdSCmk314HCb3zPuM0HtlDQZmHHSqtGIfkqrqz4EWC5FNYCSkk6AaFyTVnlh/lLfDEUurEB4C5u82xC8q/Lgn8Auo6miHUi2To7FuBzM7g1rOxC3PYW+/WLJLOVUcxMaBlnDf3FHN3lV126oifOiRGnOxzrCxnrvkWFzyqqTQr3d6I2GrUZ4+28EdoD2HmJRF/9gHC6NKk/TKjq3OpOM0U6tT+9pWy0qoKc88yIUiK36L4P5dYjD7ihX052aKNiXH12dzXHd6DR7UWsFqAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLtM9cCrFyqR2pTpX9e6wpUARTUQRcvkn6dLFV9pilU=;
 b=eh5R95eb1ZfcdDIwkEr9y2DI+jDOuODHOLAZ6LZPTVg1CPtEzT8UzsupDtT5r8/ukrSCvSImNmx/2LSsONN5m3EETzn3MIz+DTpnShLj6uUGdEPBxiB0kYrwbyjST91qYT4UzFY3eVGFX0reN1fuwKsCDZfDDOZZBfAaTyRLN4A=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by DS7PR10MB5086.namprd10.prod.outlook.com (2603:10b6:5:3a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 18:07:21 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 18:07:21 +0000
Date:   Wed, 25 Oct 2023 14:07:18 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stone.xulei@xfusion.com
Subject: Re: [RFC/REFACT] Refactoring and significantly reducing code
 complexity
Message-ID: <pn2lkox4qj7ylx44jnqjf4kfpenaexbnw33xsebekeg4yz6yw4@y464o5qyj4f2>
References: <ZRU/EjubEH/5QLlG@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRU/EjubEH/5QLlG@fedora>
X-ClientProxiedBy: BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::7) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|DS7PR10MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: d5fa1129-74b3-4b59-1505-08dbd5853b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqrj+Z3+B2ytucmqiOL3lnXZxrRxR6JEJIkXy8fCWg94K/JJNg2LcCMzvcViwu1HJShNV8IR+v+ckNjD5pDXHJtVWD7WsYDrR0q+5E9gssntaMMKIXqtdlbk2QqmvGGlah/+viu159b0H9rviWkT97owQXqix+SDa7ci1hcgRZ9706JfE6qjUbztmHr5lMlnpff8kQqU0TMgAIuWlAGiWsSkzNoI3OprOIXulsbvqEMc1Ly9Rfw51nhoVzM8YvZFCZtBrmnL53vWzRTCORTUgrr+VcpMAg66/rkN8X6meInEZ38xcqh7ERp8853YHWyhDc0uFpYVN7dL00flc3BZB8RRhTuTaGKEUrziqHIpEyGBVgSZ8zRHfSzm62iHWnKTSaFPYC0jD9cr2BQkl8FmW8dz6+NidUZ1hFxsXtTRO8gpSydRB9y1wWgKkqWgB/XA/TtYbozeFM3NB4PpwrKBJpZpvt0J7JubyZP2ReSTZeyLCUz1RCabrv9mPhM7u4ldpNhn2+e/IWJwcFa9BmRcmEkL8GjNpC6EQVJp7vMEAxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2906002)(478600001)(316002)(86362001)(6916009)(6512007)(6666004)(66476007)(66556008)(6506007)(6486002)(66946007)(33716001)(38100700002)(9686003)(83380400001)(5660300002)(4326008)(26005)(966005)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TehdrWMutZm1Rj0Zu+v7EvvfGh9xV4NerMVKbR55BlxRG7+xZ33DzUkpHdFA?=
 =?us-ascii?Q?DLXzZJku+TnhmVzJOIsjwfjuCvDg3rRREo4XlbjwTRibspCZg/ylX3b19rme?=
 =?us-ascii?Q?WZJ/OBe8zk0KHz7Quh/owyPN8IicmVydlR8CTWShf7QTYzidN7y2xaBm3mFa?=
 =?us-ascii?Q?lmGxqFE5AHr5kE2G+FJaecI2nxc0879CVA0pPoDSNltE1iGWevP2cia/Sdtu?=
 =?us-ascii?Q?jTDb5l25hKXdxRcKkIvoFDWaJjVbJ8kFTHIz5e2npBE8O3Ob4UQdjdK+EvXB?=
 =?us-ascii?Q?Z7xflddfxj+5lmXwdpBN9h1u5E+Iag8zTIsYVCPrtEng3z8OHguO5AQGDmqO?=
 =?us-ascii?Q?DDFx0q4OW3yANRjSR/gk1i2iTJLDTJPHUKmp9c6td2EEn7lD0W0e1NHo8Nyi?=
 =?us-ascii?Q?LTIe08FLKIkHbHAle2+zczVpg1fQz9bEGs9xG9NP1KRedix+9cu6IcKPJ06I?=
 =?us-ascii?Q?bWUHXV1AY20Bj4EXx18rEeqspGOTSg/+ON5H1I1jpmJJOpUgiVCvOViqX9/P?=
 =?us-ascii?Q?tGYfhlrRlAxBWVAid1kV58Q052jIRKfmOCb9UtNdQhjwtog46fqh86V/JSY1?=
 =?us-ascii?Q?gQksoIuUBhbhiL2yg6ryCvSZJcV0on7CEJHA/MCCOYOZ/ZFJ15IK7MX7t05k?=
 =?us-ascii?Q?x9zv/dJvQN8T9Cm6PhLXMlDx0phCSYL1fkav1rrQzvf4pGj4k9R1TPNzBPJL?=
 =?us-ascii?Q?Oui4usRm592ugllSn58oerNlQ391hEkIGbSuHmkwt27WTapU4Z8rOqIeUU95?=
 =?us-ascii?Q?PEtJAX6Z4GSCxgmr+sRSI7BkMiPpyEJG1NjEcRiVd0zPfELS93m7hCzFTY4P?=
 =?us-ascii?Q?iM5HBENH+nvlcrmVu1M/IFqjvrRGUu7EKSWgg5eW4VHrTwNbL2FHrTTfws88?=
 =?us-ascii?Q?LnZW7kMAoKTg3T0Rg+T8fwNjX75ABtjkrXOapSN4ycpYT7IHjibi0G6yun51?=
 =?us-ascii?Q?dU1zM6rwhfwy26wDbIV8gkooSj9xHJDhCJF8xYwHSIgk/pfQ2CkB1EBbpt+b?=
 =?us-ascii?Q?4U5vv9xj2Fxf7QTwkYBo+J4+SzrPBPxQcIfnmcYSQUmkodf77VNQwQbTox7r?=
 =?us-ascii?Q?liYlr9+/gpK9+DwGrhMWvOWc2ph/xHaCD5gAfBQ7yfpnhCxnAX+sX8ni0oTy?=
 =?us-ascii?Q?/4sFINaf8rFeaMUJY9xGqT1mXEMDWgB6I5oZDE3BzD6xPUUc+EpFMLkXFe5b?=
 =?us-ascii?Q?vzoCpl3eEk2o6RZUrgs265bR3xS48KNSUKqbbgelPvCOTl/FQqWfM/55Blft?=
 =?us-ascii?Q?nnPNXikZemQQR/KCbEo+JbOp0fa/VotLjX+bPu2p1+m6ke+NqQ4Hcw5jS7C6?=
 =?us-ascii?Q?39CulAUy2rka2J/Kncp9KHWW73TuYc500DARX5HYzs5iKNSEnEd4J2n2RRi/?=
 =?us-ascii?Q?HF2EKnVH7JgOP0LAnSwgVAK4hDG6rqa7PwyVP2mRVaDFozbCqOiszk5AbOg0?=
 =?us-ascii?Q?F3SL4sB2M/E83d6Oy/wuWz8MnXPz4uPWihltzbX4T+5okr/uNxmdcLN8dafG?=
 =?us-ascii?Q?Zrc+TsFPhcNjQjUwX8pWhguQKvNul2mhQb3qNfL/8cWy4OQaWhEPzmsoH++9?=
 =?us-ascii?Q?tU9ckmovjw34roJZ6RiHVEhRtaGZKBUafZXz7KKbgoTbQwTFlvHkTy/3k0ZO?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kyIKZbEabjy2ukT10LP6dNL2F9ckMN0jqPEXGdqoBMmaE8wEqASRva5+rqFMFGbrj578Ty7Mh2WzNm0PXqQHpn8zXPvF7raZ7Ytb2hrHOmXMEl3aLeovyiOnQWz2Yu0LZ7dahB2koTnJNmePC+SbCLZD72jI9NC/UPrVZH+5BK9NChuDD5SOd2D1uICN5nTWYMWP9zWGSQsrwS4BbWLkXuFAcYiMRH+AArARVBlpVlDP7DvgMvHZH7cP8RpDYs2GIlHPzImMitVG2hS5z7zPjIQp7DG9HZ/L2Ht98y/tGCwx53YYLMR3zgQTHlOt0ttcabHTHwFzfiPFKYzC0lWIBLylMztXScuiM2dhT8oerJTBZgwPi/Z5XwCH6JzIcB88vhk+hGk98jNRQJ2tTtH/PP4SkAGH8plD9GQJmO2sygHWmaYGT/LZVnMnrBdVNh1eWrQKl2BfFQE4w5Ve4ktW1m+5v8rh4RYK3JuFznOVBuX23vWJ3WQaixqnNw2DCOu/ytQkJEuWAq5Af1e7qIqv+aZFKFYYfDoTZ+DAMWdhx8OPEUWx3t+ScxP7LivsAW9oVN1LYHWRSZ+ciVD7aa89WdQaFu70c01MICMoUg+5SD/zOu/ZaSvHZgZOoLiugM8W67O7oM+j2nqeLaoXbU9+8/onQpRdL2xsxq1gCYS58aQF3dWdhoIgL0Mda3V5uTE8HXX7sWrxR/bT5hIlzGCmkxiK6m+JT/wOMe/zmhUU3F62bVERfWW9rNRU9JKAK3PHrmO9kthWQCuQqH8jcGOA68F0T+r2vL4y55dN3OHeoPCEHu4wc4415KU9tHJ1UD+tEmTNmQ/ORY3DD93hHFHkog==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fa1129-74b3-4b59-1505-08dbd5853b5e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:07:20.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96vIwcLlBw26DL53YP8uc9a8iKnVcPp9n7MBezebI13P2FhDucIBdpENstkInV58Hn92sPhkamnboz97GH2XtKGwqT4oo464rZedh1juFfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_07,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250157
X-Proofpoint-GUID: Pw9MjCEE6PqEW-VcEwWYzSq5TJYtwSXz
X-Proofpoint-ORIG-GUID: Pw9MjCEE6PqEW-VcEwWYzSq5TJYtwSXz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 28, 2023 at 04:53:38PM +0800, Wang Jinchao wrote:
> This is a refactored version with the following main changes:

The RFC overall is a nice simplification, and the basic approach of using an
ordered workqueue seems to work.

> - The parallel workqueue no longer uses the WQ_UNBOUND attribute

What's the justification here?  If it improves performance, please show
numbers.  Earlier tests[0] showed a large improvement when adding this
flag.

[0] https://lore.kernel.org/linux-crypto/20190906014029.3345-1-daniel.m.jordan@oracle.com/

> - Removal of CPU-related logic, sysfs-related interfaces

I agree with Steffen that we should continue to honor the cpumasks that the
user sets.

The simplest way I see to make the parallel mask work with your refactor is to
just make the parallel workqueue unbound again, since setting workqueue
attributes is only allowed for unbound, and bring back some of the plumbing
that leads to the apply_workqueue_attrs call.

The serial mask is trickier.  Changing attributes of an ordered workqueue (the
cpumask in this case) makes the kernel throw a warning...

static int apply_workqueue_attrs_locked
        ...
        /* creating multiple pwqs breaks ordering guarantee */                   
        if (!list_empty(&wq->pwqs)) {                                            
                if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))                  
                        return -EINVAL;                                          
                                                                                 
                wq->flags &= ~__WQ_ORDERED;                                      
        }

...but I'm not sure this is a fundamental limitation.  The changelog of
0a94efb5acbb ("workqueue: implicit ordered attribute should be overridable")
says changes to "max_active and some attribute changes" are rejected, but it
might be possible to relax the warning to allow setting a cpumask while still
rejecting other changes.

> Testing was conducted using ltp's pcrypt_aead01, and the execution time
> comparison between the old and new versions is as follows:
> 
> Old Version:
> real 0m27.451s
> user 0m0.031s
> sys 0m0.260s
> 
> New Version:
> real 0m21.351s
> user 0m0.023s
> sys 0m0.260s

Great speedup.  A test that runs many requests for a long time in parallel is
also good to run, such as [0].

> @@ -986,57 +281,27 @@ struct padata_instance *padata_alloc(const char *name)
...
> +	pinst->serial_wq = alloc_ordered_workqueue ("%s_serial",
> +									WQ_MEM_RECLAIM | WQ_FREEZABLE,
> +									name);

Why add these two WQ_ flags?  Also, whitespace is kinda funky.
