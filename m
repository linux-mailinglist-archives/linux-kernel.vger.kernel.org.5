Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1312C757B80
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGRMKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGRMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:10:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B05F170A;
        Tue, 18 Jul 2023 05:10:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IBiTkf005488;
        Tue, 18 Jul 2023 12:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type : date :
 message-id : cc : subject : from : to : references : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=FwiV42LbTmAuTq56ezSOzCRd2IOscrQgt2N8A9BuX5I=;
 b=XQuS82X/3V76RcKS/oaP0tEXzltEqk1kP8jUnmIx7tGbMCjYVvTcTP83rXDxyQEGDtUO
 XgIvdNjNx103ZjgVT3zuMWodNeSq/QKNgQOQ+5NVfcX7/xKDkRYKlPl3k6+060lFxm/q
 TsGHYIYiONISLkkwqgP1KmdnmZVt0r8iNz+BXIEjqzxBVrarmVtDNxVpgnw83029lTHn
 hwQ9xOH3VBHTFgFoubr0G4XqbraFl9WFRge1k1t7xvBF8Bm+yWsjV7Gv3KtHN3sEsgNc
 MoTiVth0vxGOHWBun/2uGBfulKghLGppjLehuuZn7GPmvua5e4p4eKQTMhz8kWGRfMmk iQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a4xce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 12:08:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36IAN8aB019311;
        Tue, 18 Jul 2023 12:08:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw5gb2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 12:08:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa1fNBl7rrr5Gm7aUvykRlpN0ZJzcG/gQaGpz9WwJ4EZsh8foz3ohjz4z0KK7f/DAM204YBrfJFEQa3scjeok4TeRiGFPUZ73LCqGEE34O8SN8oCCA4y7owqaLparKDghONvjZNVg1UETNPFax+xvf2hU0KEj82ZU/21g7YH3hQhOQ87oHbScwUErU9aoOJzpA8cql0VzwAV5ejOJTWI7hk0qSB4r7I+jtKXIUurSk1cefh/1tmQGsCri3T+076XZN6OfUA28r2eJtGugSKgjAjoycPI0GDezen8rtTjt405H8FJBDvCkJ61AOuy3KnozP/y5TNvAkYtLcE+A4fYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwiV42LbTmAuTq56ezSOzCRd2IOscrQgt2N8A9BuX5I=;
 b=CsehfE+oh/7kO9pGYrOU9qCOKLGW+ccVzUewV+orkaFu5U4JfRmnopXgDQ+xwUzzpyjOl9p5zK+F57Yni2QNnsSxcVo/fzhvYKUfa3QpEAZ43VRrqWvppU0x7tbeOhcmTdWtN+wrRU4jJ+gcOBWCiqm4zsXsPNMj1avWNCFrtMxvoPDpTbW5E8ORd7Ygbn4rkB9//HSWAT5BXkia/J9JvQZomSoXhwHkVc/O5HEB/mhdcI+YJj9TZPgQdEGy0PikvFZFZtB1DnB/YSz2hW4lysFOlOm6A3qjHrkof2bOYztBQTkd9fbCBVo1Xt+9Sg3BN2HWk/zbyfoZ7OiCx7M9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwiV42LbTmAuTq56ezSOzCRd2IOscrQgt2N8A9BuX5I=;
 b=B4XGgbfSN4L0CEbiVZI82h858C5RtnXh7m9elNDrnEaNmQoAq5z7EH9bOsPMVsp9B3UXupqsCzlsFa+CTwai9bZMCPSp7jtg6jet1x+crLEBVU1YpLMJhto472LQCElumHE4N2ZcRJsq5WrJuHDM1MH/9dSYJDu2Y6REgR9yB8w=
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com (2603:10b6:4:2c::27)
 by SA2PR10MB4460.namprd10.prod.outlook.com (2603:10b6:806:118::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 12:08:12 +0000
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::85c6:774b:b72f:eb9]) by DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::85c6:774b:b72f:eb9%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 12:08:12 +0000
Content-Type: multipart/signed;
 boundary=c9af01b7a49647a0639ccf78634d57dd1614fc36953bb35c5f5e05ac207f;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date:   Tue, 18 Jul 2023 14:08:07 +0200
Message-Id: <CU5AB77A9U99.1G4IRUW6DZPJP@imme>
Cc:     "Christoph Lameter" <cl@linux.com>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>, <linux-mm@kvack.org>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Kees Cook" <keescook@chromium.org>,
        "Rafael Aquini" <aquini@redhat.com>
Subject: Re: [PATCH v2] mm/slub: disable slab merging in the default
 configuration
From:   "Julian Pidancet" <julian.pidancet@oracle.com>
To:     "David Rientjes" <rientjes@google.com>
X-Mailer: aerc 0.15.2-74-gdfabb5232875
References: <20230629221910.359711-1-julian.pidancet@oracle.com>
 <38083ed2-333b-e245-44e4-2f355e4f9249@google.com>
 <CTSGWINSM18Q.3HQ1DN27GNA1R@imme>
 <8813897d-4a52-37a0-fe44-a9157716be9b@google.com>
 <17349901-df3a-494e-fa71-2584d92526b5@google.com>
 <3bcfa538-4474-09b7-1812-b4260b09256a@google.com>
 <7b6b07b3-d8a1-b24f-1df2-bf6080bc5516@google.com>
In-Reply-To: <7b6b07b3-d8a1-b24f-1df2-bf6080bc5516@google.com>
X-ClientProxiedBy: LO4P265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::9) To DM5PR1001MB2153.namprd10.prod.outlook.com
 (2603:10b6:4:2c::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2153:EE_|SA2PR10MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e2474b-e6aa-4247-747a-08db8787a802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iFXtt+6JJYBwZdHUPzj7nx+MciFIQnzSQvBQIsVybVEHyN4EMKtP2ZWupMn1pyyqVh8QI93t7NoMca40enB3wZx+8sDEDOWJS5SCWFnd1yVA2Y10YT2QVTHro5X+LXVY/Ax4uXNhBjg17AuZc/k+R1C4PjPMhhXXdsx4HtsZd1uf1dtogJ5yyaOzt2LIIEnG7p+bd7ktmoOQrnO+1ze7mG1iwN00fQ030EaGMx3DfIf60OZQ4/cVDuycpRz7yFOv2rDRCo6l7ITcxWzlwGf1KZ6dnQe3jXV2oqiY/TsryI6mEW/MBPwl9A7Ml+0EAfshsXZCKzwe27wxGTexw/jE8P+7ra10EU+eKKLKBw/Ngiojzp0p/0XXyFSYgL3kaJ2BJemTCErTsff48UsgyYrv7mzsTpa8d3zGPAXtQMfzu9UvIhoOuwXshSq9SWt+OZEKm6WyOo23tWQwh+EfLdlCHBZ555n5ZxSnt8myYxHnwBJ/rReEzxyAOeqbe/0wdh6cQp9OQMXWjGWOgouo9+OcMtY9M8R4OqhbmqYz670vaBaM/UOibC9w0mZqROYJOBW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2153.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(6486002)(33964004)(54906003)(6666004)(478600001)(83380400001)(33656002)(86362001)(33716001)(2906002)(186003)(6506007)(21480400003)(6512007)(9686003)(38100700002)(66476007)(66946007)(66556008)(41300700001)(4326008)(316002)(6916009)(7416002)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXZFbkw3UEs3ZU51anh6TE16KzdTYW5heUxtaDdUdVhuQVIvRVlmREdiMmpD?=
 =?utf-8?B?bG5RdUZLM1VnTEdWVFhzbVNJRTFzS0E0eXFGR0s3bUdsMHRZcFloZWNWUnJF?=
 =?utf-8?B?N3NHaVU0NVdTNzVaOEx2eHFIUnRoQXpNRHRVMVRVS0cvb2Zka1RUc0Izbi9q?=
 =?utf-8?B?L1VNdWVvdHZEVUN2Njg4UVZDc051VW1iYytOenV1QXZIY3E4dVY5TGFaZ1k0?=
 =?utf-8?B?Mk9IM2lZZXlyZWFJZFRWVy9xeU9OcStkQkRXNDBkU0xuQTZHd2s4aG5lVlQy?=
 =?utf-8?B?OXlKWVVrc09Gc2lnbVIzdWlzVm96N2R6MFltQXNaaERjZDNselVwNm13aHc0?=
 =?utf-8?B?MFJRbEw1WFcrd3FienFxVmlKRkxiMmtPYks2SzVsay9nQ3JMZmpWUEJzbisx?=
 =?utf-8?B?eHhtd2NLaTQrSEtnejRvQlFLR1BReTV6cGlzQ2VFQWE0OVpUWHVLTFZBb1I0?=
 =?utf-8?B?N0g0R2p1VHl6US9xMXFUcy9TQVhnVDZJcWxPRmNEL3RRbkZDaHdjejJRTGl6?=
 =?utf-8?B?aXlWT1lVbk5WRWFJOExlSzRIU0IxdkRValpHeFh3M05BdHlFVzU2bEtjcnNB?=
 =?utf-8?B?K3RMNzJWQWdNcGVUZUJKc05zSFpBbjIxUkt2WnQ0NitEZkpBa1lpQVMrMTNn?=
 =?utf-8?B?Mk1xOWZLTU9KS1M4MDVMWVcvYlpHdU9ENzVlbkEwR2pPR0F2MVN3WDg4RDdT?=
 =?utf-8?B?UmFLRFJMVmlIT2tCU2QycGJZT1ZKWmdsUTg3RlNzeFBrNnFzK3QxcUZvNkJu?=
 =?utf-8?B?dU9pSUpyTk1DdmdHaVdsc3M5N0NBVkZkRmYxaXVhWmw0Q3hHNzlQT3gxVElN?=
 =?utf-8?B?cXczdGo0OFZVMVpJV1NIMGdpVlBWSmFMbWNucW1CdXBwWGxPRFhncktDTzNN?=
 =?utf-8?B?Vk9WdnlDZnc0SENiY2c1aWNka1EzcVpXUTRFQzlHZ1JHcDFPMDhqbTNrWVpr?=
 =?utf-8?B?WjlkN3B1M1R1OStBakc1UFQxeTdCbkI3bmtSVUZRdXNTSmFMVEg0Yzh3Ymhp?=
 =?utf-8?B?bGUySk5IbUpOOXAxWTVvWWxyRmdKcFd1WWYycll3a1REditOYVdXam1xbFpE?=
 =?utf-8?B?bGRrTGx2K0MwY3NRVmRuZlBJU3NsNE1QaDVFWGRJNlRINUZCN2pRckRLcHVG?=
 =?utf-8?B?NllIVHQ0LzFRNEYrZWF2Qkd1N0puVXFmcDg4NkJtcEV3WFZtQ0gyc3JxQVF0?=
 =?utf-8?B?WGVrM1RZaDJmRS82VGN3RzhycGNxRjlZUFZwZGFOOUVHTUV0aGdoL0h6TXJw?=
 =?utf-8?B?QjhhempxcmF4S0NWQkpCWEtuazg3ZDYxb2FHRE1xa25ycmRHR00rNFA1dHFl?=
 =?utf-8?B?cy9zUVZzdmwrWUx2ZDBVeENtRmJleUJJelhwUEpFZFlOUC8rSjJXZ0xvV1gr?=
 =?utf-8?B?bUdBK2Q4b0NxZ0FLcEtZbERabHpFbTZ5ZTRjODhrcEVwdEhSYlZmdGc5VWF1?=
 =?utf-8?B?OXF1YkNNTWJ5ZE9RdVRxYW0xWFptajlYNlhCdU9qUTlkUWZNQU5uREpmeHcr?=
 =?utf-8?B?cTJibFdtdmo2YjBLSnBoandDM2Y5VEdhc1g3L1l6VmpMSWVtV2wwRmhoeDh0?=
 =?utf-8?B?aXNWanEybm5DYUdQRUhFakVxSStZVk9lWXdKaWRRbVFlZXpUV0RrRUZHeWk4?=
 =?utf-8?B?a0J4YTg2NG12c2JzaVlMS0pvYU1tZ2FvbytNSnNCTkJnelJoL3d1ek54WCt4?=
 =?utf-8?B?ZUFzRDRncmF2bUVNSjFNcTRnU05sS2FiYXB5WVppdlpRbUtmZEl6VEtJWTV1?=
 =?utf-8?B?UlNMSllTaS9KWVpBeTlicnpoSzVkdDlhc0ttTFpjeitxdFhNT0l5REp1T05v?=
 =?utf-8?B?UUs1QkFVMERmL00rTUw5MlduRVUwajdsbUlkYXJ1Ny9WL0pWVVZiUnN4UExH?=
 =?utf-8?B?RTBOSDdrejYxdjExaHJBT1lYaUl1SXBHYVVBMW9yZlVRSU05SGpHMnRueWdT?=
 =?utf-8?B?SUhyNjdxNkFyOTJlN09hWWNKRGdzRUFDRCswdEpzcmpvUW9rL0tHSW5ZLzVj?=
 =?utf-8?B?Y2srWjFaRWtvbWs1N3JXUkVFdUY4RWJsRDdGVUtuUXYyODR2b1B6MXVhS2E2?=
 =?utf-8?B?a0N5KzBNNVFydDVKbHZoT0JjYzZmMGR1eG01ZkQzbExscHJrblVWRkpSa2po?=
 =?utf-8?B?cm9KVDgvejJPYndlZTkwOUJFbDBDajVqSy9GMzhxa294aW92dzBZNkxra2hX?=
 =?utf-8?Q?AAvhOvL0zhT/mH2wFfabjD0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Y29VZWpFKzgwajErZ1o1YW44Y0ZzR3o3QUdBb25oc0xQQnduVDNYWlhZQTh6?=
 =?utf-8?B?dEVDTDN4V3pwMmhWZm0rQlY4TzRCV3VLSWdVUmM0bzNVeUlMaGpwc3NzVkp2?=
 =?utf-8?B?dUloQ1gwMkhyb1dIaVoxVEZyZGNjMkZxY0prMW9PSmJqQ1lONzZDNkVRQzNO?=
 =?utf-8?B?cm84RmZwbEVJV1dFT0taQzU1Zjl3d3NyMnR2a01SOTQ3L1FkWjhvNVBDRGVs?=
 =?utf-8?B?ZEwrOWJSSlJiQmU5bW1jTSs2VXVyYXU2TTBodjNKbEU1Y3Q1cTJvU1BldTBG?=
 =?utf-8?B?T0pyZmM0NUoxR3dPc3V2Y2dkcGs3eTBWcHcrOFNKb0F6VEEwSGU5L1lIYzNY?=
 =?utf-8?B?ZFYvZWRMdHRYNHVTemFjaFlaQ3RPeFd5K2xRYWl3Mlh2UDdmYWltQjF5Zko5?=
 =?utf-8?B?Mjk1WDhFNGkrU1VES01rV1poQVhqYVBXMm9pV1krQmw5RVZhbm04WTk4V0Vq?=
 =?utf-8?B?MHRtanNEUUwzamEzdGs3TWUxQm1xNW5HbElLRGZKN3l1QVN6RzI5Q1dQSkJF?=
 =?utf-8?B?cnp5TkVpSyswSzNja2xoZEp0NzgzRTVXckFkKzVzTkxaZytXWUFSM1Q3Nlgz?=
 =?utf-8?B?S21JSER4OVhFYUY5RUt4RnhFL3FQUnU5MFNBOE5PbHNFTGFRMGxQb3BDbGlV?=
 =?utf-8?B?M09ZY2QzV3VZTWN0SnU0M3EyRnJlbjRJdG9qYU1OZzd0MUtwZEh0QnhZdHc5?=
 =?utf-8?B?SXlKN3NiaFZFVnA3bFlBcEt2S1E3V3NrQm45ZkFVZi9pSVU4QlZMYzVhME9y?=
 =?utf-8?B?Zzd0SmVyNkJ5OHFUKytNZDRxOCtlYTUxdXl4SzdvU28rM2p6RlhUWUhIQjNC?=
 =?utf-8?B?dk0wY1owemdITFo1MHcyd0ZRbUhSMG80RnRJcDN4MlRMZTlHVmVCOUZQeHZo?=
 =?utf-8?B?R0Exc0ZjT1ZkUk1ITjFNdmI0YlBSLzZOdlA5aHdLeWRKa1VWNU53emRDenZQ?=
 =?utf-8?B?ZXEvSmF2b3BkVVpod2E3cWIyVVZLUFZnWkVUdDhzWnNOYTNINHVqQlZtQzFH?=
 =?utf-8?B?NUV5VE9sczMyL1lsQ0t4NE1EUmZNcG1Sa21Ubmx6Z05DNXBKbDdPTFh6cjJn?=
 =?utf-8?B?bmJudE9WVFAvMzBTbGV0OGJER0toQldCUGZNZ0IveG1Kc3J3TFlaank2L2o5?=
 =?utf-8?B?UnZ4b3hrZ0FETmVrVnU5ZmViNUNVK1VuZVgrZFhrUFJsaHpsVjM0UEdRK0pV?=
 =?utf-8?B?ZW9OOFVuWVk1NW4zTFM5RVVYYTB1T0FVcy9Yb08wYytnV0F3RmlObWszZmFX?=
 =?utf-8?B?UkUyek55VUJOZ0Q0ejAxTzl0R01ZS1NZMjlMajQzZFBxVWw1MEhEaTBCVEIv?=
 =?utf-8?B?NXpxQmVSL2JOT1Jkdy9hdVUrVUk2dGZNKzlzRTJrbUROTDQ3bTVWWHVsNVZ5?=
 =?utf-8?B?MGJZbVRMZVNJc2dBKzlqMEtzb0tCU25HY1QxMUNaMkk2OEhCNmxYZzZEaEp6?=
 =?utf-8?B?TUM5NFcyWTdvNUtyd3Z3MUpweUpnemhXQWZub25PeXdqRXR2cXhWSTFBZ1FN?=
 =?utf-8?B?MWpSekM3WDlpWEsyNDVXM2hDTFBTbmtwSUxhSDFPYzl5OXZCYjd2dmtCQkpH?=
 =?utf-8?B?dERMZVlPWXpvWnNDcWdOUGI3ZXQ3VGhrVUZCTmplQ1IraGpmeWFvUjhUMzgr?=
 =?utf-8?B?YkQ2WWpWeFJSYTBQaW51MlEzY0s2N3c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e2474b-e6aa-4247-747a-08db8787a802
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2153.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 12:08:11.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwn+ZQ37fMhOqv26X4z1/cEMsAC43fw3/c44ZFmICDwuuqPJLS1m3DElr9R2o1v3yXmvKJWWwJpKcuoxUs+6OBynbjU+ZYB3yBdBwclBMkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_09,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=908 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180111
X-Proofpoint-ORIG-GUID: 2wqg8X_PBKaj0QFSzKFOgKCpNG1_3o2_
X-Proofpoint-GUID: 2wqg8X_PBKaj0QFSzKFOgKCpNG1_3o2_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--c9af01b7a49647a0639ccf78634d57dd1614fc36953bb35c5f5e05ac207f
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Jul 10, 2023 at 04:40, David Rientjes wrote:
> On Sun, 9 Jul 2023, David Rientjes wrote:
>
> > There are some substantial performance degradations, most notably=20
> > context_switch1_per_thread_ops which regressed ~21%.  I'll need to repe=
at
> > that test to confirm it and can also try on cascadelake if it reproduce=
s.
> >=20
>
> So the regression on skylake for will-it-scale appears to be real:
>
>                LABEL              | COUNT |    MIN     |    MAX     |    =
MEAN    |   MEDIAN   | STDDEV | DIRECTION =20
> ----------------------------------+-------+------------+------------+----=
--------+------------+--------+------------
>   context_switch1_per_thread_ops  |       |            |            |    =
        |            |        |           =20
>   (A) v6.1.30                     | 1     | 314507.000 | 314507.000 | 314=
507.000 | 314507.000 | 0      |           =20
>   (B) v6.1.30 slab_nomerge        | 1     | 257403.000 | 257403.000 | 257=
403.000 | 257403.000 | 0      |           =20
>     !! REGRESSED !!               |       | -18.16%    | -18.16%    | -18=
.16%    | -18.16%    | ---    | + is good =20
>
> but I can't reproduce this on cascadelake:
>
>                LABEL              | COUNT |    MIN     |    MAX     |    =
MEAN    |   MEDIAN   | STDDEV | DIRECTION =20
> ----------------------------------+-------+------------+------------+----=
--------+------------+--------+------------
>   context_switch1_per_thread_ops  |       |            |            |    =
        |            |        |           =20
>   (A) v6.1.30                     | 1     | 301128.000 | 301128.000 | 301=
128.000 | 301128.000 | 0      |           =20
>   (B) v6.1.30 slab_nomerge        | 1     | 301282.000 | 301282.000 | 301=
282.000 | 301282.000 | 0      |           =20
>                                   |       | +0.05%     | +0.05%     | +0.=
05%     | +0.05%     | ---    | + is good =20
>
> So I'm a bit baffled at the moment.
>
> I'll try to dig deeper and see what slab caches this benchmark exercises
> that apparently no other benchmarks do.  (I'm really hoping that the only
> way to recover this performance is by something like
> kmem_cache_create(SLAB_MERGE).)

Hi David,

Many thanks for running all these tests. The amount of attention you've
given this change is simply amazing. I wish I could have been able to
assist you by doing more tests, but I've been lacking the necessary
resources to do so.

I'm as surprised as you are regarding the skylake regression. 20% is
quite a large number, but perhaps it's less worrying than it looks given
that benchmarks are usually very different from real-world workloads?

As Kees Cook was suggesting in his own reply, have you given a thought
about including this change in -next and see if there are regressions
showing up in CI performance tests results?

Regards,

--=20
Julian

--c9af01b7a49647a0639ccf78634d57dd1614fc36953bb35c5f5e05ac207f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQTd3Z6iZzTygRNy7F4XFh3U+bgUcgUCZLaApxscanVsaWFuLnBp
ZGFuY2V0QG9yYWNsZS5jb20ACgkQFxYd1Pm4FHJQhgEAiG65cJxUVmZgBR2yHpHr
oU59Ty1lD9P/kF2mkXMWg/EBAK5f6/bzINn0o8V/FrubWSnFfyQII9S7tb2QoK/L
alkA
=E0sH
-----END PGP SIGNATURE-----

--c9af01b7a49647a0639ccf78634d57dd1614fc36953bb35c5f5e05ac207f--
