Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2C7C4392
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjJJWOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjJJWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:14:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0465DB8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:14:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJiNCb005190;
        Tue, 10 Oct 2023 22:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=44Qv7Pbr0T958j2r3Vo9MbIGyflnWvyFpOQ+nqXsmiU=;
 b=NBkcdEyrKqlMgYM5ld+k2xQbZqBCqeytk3Zrb9OUZT8PxjVLVtmZp1aRi241QX5DDNMy
 mARsqoe3X9iSb9U5C8QDPeZXQgBdY+BYWXGRfWDngB8teRivH2eyVRtV7ffyh+4kyZ9V
 LhdknJpM1eQPArZZ/YXH4Al8mE/xZwe1aTKR6o6LUZANerWEHZWhQzk8yHB49kHiFnPh
 Xv3SwIblULX/yNwCLcg8jSO4gALr3+rfIqv8osoOZXIPhDu9/mkKJkkqMrbu2ApcByyP
 IjZ4Nl+3p5S5cCMzXAE1DEG6P9mI7QFfw111p9dqVvNFwR48abirp7H6sYaYMUB4ojiG xQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxu6gvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 22:13:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKY6ao014888;
        Tue, 10 Oct 2023 22:13:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws7mtvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 22:13:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imRHpCTzpJugk5XZDxCOM6kWSwqdEbj9JPz3NHpWCDrpyiTq8YNU2fLNH0kM45yYxNXBQj220wNka36BMp0Fqukf1EXsV3fYTakwnz84ubQ2J/iqmHFZmIpItC38AHq+2H3dAxInLTNiEhXxeauwRGArg6wFlysQR6X7xHLCpNdBKGTNroKQq8pUORNkXeAro/qbZCYU+Y0vHNIdBGZ5F2TkPQY3FnDdE0Ad1owh0X+RQlVBm2pU5Yf8Fo7lL+8mpA4P70rfubAkJOmFiCm3x4Th4aBYkJB0EhuYZZO2oUDWhrPlCsONnYodsJ3/ZEhFqlbLXf1Ov3eyXL+qO9KHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44Qv7Pbr0T958j2r3Vo9MbIGyflnWvyFpOQ+nqXsmiU=;
 b=PFhhUNPtHdn0rl6UwxUVNIBM4/E26fKWeFqfVfueWoXSH8RiiqxxiUmZLht8rwbxFBSapp7QJz9tdYqRMi+oRR+KdY+U8Wbs3wdm0G8VMxdbkP/nxHQTciRL+0aqJsqyGVGunDWPNn0StZ2+zaj6fMurGBxf5SCEd/U8rhj8qRZM+Avt3Xrfa+6hiKfbidgfj4pShwkU/xohqjbbxGxuGPhN4WHjbXlhIRkYuhCXrwIJo/1+LoVg68qMcuNpWlKlWZE5FTya7jP7fsB9cZuq0KpYRnY/FSUAZXHkYd1g4KKLULUdoEAtinDDx8hww1QTOIVBY/qlksC9jryq8BD1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44Qv7Pbr0T958j2r3Vo9MbIGyflnWvyFpOQ+nqXsmiU=;
 b=roogaDPxGSPf+RaV9yCPWk4wQdlDdxbkipW9YlEgth9oduaR/waKhqN3to/9fWQdqBuko/ecuLFv3t/yAEfmHVaFaj5HAq6Eaa5qIRE6FWkncibTn5itcaMUPGxCysw1KnYF3ZlMfOGtzDTjA//jlqRVVxpA8+ggHRjAKS+TNKU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 22:13:16 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e391:f2a1:a9d:967d]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e391:f2a1:a9d:967d%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 22:13:16 +0000
Message-ID: <9085d7dd-72b6-840a-86ee-86aaa9e77902@oracle.com>
Date:   Tue, 10 Oct 2023 15:13:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] maple_tree: introduce mas_prealloc_calc()
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
        willy@infradead.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com
References: <20231009201639.920512-2-sidhartha.kumar@oracle.com>
 <202310100603.qsn3ruBx-lkp@intel.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <202310100603.qsn3ruBx-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: cba3315f-02bd-49c3-5b33-08dbc9de19f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTW+Ug29vr0E7+3lfQFrFbWNr9dMNtu27+sW2Wd6Li5uRorcUuoDkARgwujtS7+JrnBykwMdopFqKhmizXt/u9ZSfa+NeBga6TcxF21N0QDb3jJfU7jfzXwWbNU3zhox4z0w5YEqnYubj5vA0XWYgxXmBIPSL57ktdKron4xtGjvcEb08zu3tN7jVsobY+3MECrjdI3ENkAFhLm7TkhYqp3RkF8WlzdmnM8xWxCEad37PHRUBk966QDW0E/g5r0ltNG9HOPfxk7HyUE0jJ8U3IybHxR22OX+p/DT4S6qDAgQ2XDyriPDtCRYzkgmRNFkGQx0Wdy7EEf/nC5Kmzl/GbNK/A5RoY+zre5ciMb085oi+hlMzYJjiPoTyKGxKqb8ZI87E/D8opKcH2vinj/ifxqXQmu/fPusKHJgFi3goPXGN8697auFhMNusSncVZ9Q2VJ+1J3juZ1S8hOEjscbLBNPWXOqmx+nUm/xxllteCmAxa01VFSUdJWx7noO9OX3gEBiLVWJ2IgN0Uen+W0nRVdHf011/O6scwi5UmEiSIeunSQdKRM3OI8V614eIACN5xb3xFclGL9unpa2X+Mg3DxyKvBmaHbExV/wmKS5877FZypTduQI/CywyFiGdVFDZoMfLQ5eqcTwQcdKBWe0X9pscMfZMB8Cl4NrAOAxBv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31696002)(86362001)(38100700002)(36756003)(31686004)(2906002)(6486002)(478600001)(966005)(44832011)(8936002)(8676002)(6512007)(41300700001)(4326008)(5660300002)(6666004)(6506007)(2616005)(53546011)(316002)(66946007)(66556008)(83380400001)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVQrcWw3WnFiS2x5eFJya24yeUVRWFNMMG1xMXc1T1cxSU9GUFhsRGd2S1U5?=
 =?utf-8?B?blVSYTFpNG1HaFlYT2ZrOVh5cnVHN1dwZHFCekc0TERFbnl1TmI5RVEwb3Zt?=
 =?utf-8?B?Rm5DcHZLMXZKdVZVOWFLd0RUMWJZeGVHcEpOcjRiQ3lOUlA3Y2pBZnZtaDkz?=
 =?utf-8?B?c0wydlNjVzEwMTRsV2JhVzZoVnN3OXNCK0FBMGJFNCtxbzc3cXF4Uy9KNmpE?=
 =?utf-8?B?SDlCdTJDS0VZUmYrZGNCdlpuNUlUajFObHltZUJ6ZGdveWwveE80cWxyRjFz?=
 =?utf-8?B?UThNZXhSRnFEZWpHOXEybkVlWlU5cjFGVDFLOGQ3VVdDTkgyL0Fic0RvN3A1?=
 =?utf-8?B?L2JPbjhVeXMzc2NWUzFFRXFDbitER01vNTVhdmw1Z2dqZk03UnZCT3RxUmVH?=
 =?utf-8?B?K3dXdVQ5Q2JiVmFLRk93eHloTGFKUC85cFo4WEtDRjFRRndGdmxvUkxvTlB1?=
 =?utf-8?B?bWNycmhLSk91UGhzT3JZS2RxNXZPZU9TL2UvUEpabFBTdGc2eHhRQ2VHc3d5?=
 =?utf-8?B?S0JLKzZHSTYyS3pmeDZmZW5rek5rZE0zNFljZG9OTGVkb0NSanA1TlRCTkN6?=
 =?utf-8?B?N0dUeEZ2dnRWTGcrVVdLK29TTWRFYUxYU1IzU3EvZmFNOURCaWpJdVRJZk9m?=
 =?utf-8?B?UGczOXdXTFZTSEhGOGtyNG45T3FQeElqR0NWTS9saEVTZFMvaDlneFVNRmZU?=
 =?utf-8?B?dGZvRnlRZjluYzZnd0dDNjdWK3hiVnc5LzdDbkoyakc1NDFDWlJHR3Y2YTBo?=
 =?utf-8?B?YVAwTkI2eThGTWN1MWlPRzh3TkxXaDVXbDFEUnpIWFVZbFV0eUtKZktxWWJt?=
 =?utf-8?B?aFRGdlVzYjc0RE1BRy9YSEFtN2xVWGcwaWFSanBtOUtJYlBna2hRQUxLR3h3?=
 =?utf-8?B?THhVUk1teW01cS9Vc3pISGsrSFJ3Uk9YK3JQdEQ0YTdRL05uK3QwWFBDRlN6?=
 =?utf-8?B?RlI5cGdwZExFdFNENlAzemNqNXRvc1dqUDlMVVBNSklyRHBCTGx3a2gvaWJ6?=
 =?utf-8?B?ZTZuWjAwdnV6cVBoeSt5N3czbzZaZ01xUlk1NGxuR29hYzU5SjhyWG95K0ZG?=
 =?utf-8?B?MlVGVTVKR3BYMDhub2FSbnFFeHM4WXpKcVJEbHh2dms0QlZibThRZDNwVi80?=
 =?utf-8?B?ZHpnZ1RFVzlZR1NQNHl5WXdyRnhpejQvR2lpV0sxOUl3amhHR2pabmNVakRy?=
 =?utf-8?B?ZFdNNDl4Y3NpZW5DRjJxVFAvTHd1MUlXMlVqRHNJNElpUS92a3hZL0tkTUY2?=
 =?utf-8?B?R0w1WmpON3FqZTdVWjQzbTl1UFR6NkJ1NWU2aWt2ZytNL1k3eC9uWFhYdUJj?=
 =?utf-8?B?NjdCNkdDZW9XUkNoZmJ5SzhNdFRYS2hIdTBnUDBqN2djSnVLOUFQbytKa2ph?=
 =?utf-8?B?Y0t1aVZ6REpLZTZlRURZcGc3dkROVmVEMnNudFRPcHZQY2FjbHZ4dmpMWmdk?=
 =?utf-8?B?aExuZnEycnRUZStUTGJnbzUvSFNhQ055RUlGbWFFVFY4U000ZytCYWJDT1VY?=
 =?utf-8?B?ZWxmMkZvU1ZzU0FtdGw4Qy9WRzFMeEIxcUFqWitXWlJnbjNIKzVyYVVyMVhP?=
 =?utf-8?B?bVl6N3VUZGZpb3J1OE9NeENQY2JKUE9xSVhXQXRRTWV0RTFSOHd1b09QOU9M?=
 =?utf-8?B?d1l4MFFxRjFDQmhtdENQYTJnekhjVmpsd0ZtOEdSSjV1SU1xZFNLQzVuVUJ0?=
 =?utf-8?B?a3RVbU9WT0Q2NHU1ejVxeGR6Vmh4Znc3NFA4Z1FlUDZFSmxnTjJLalhxMHRK?=
 =?utf-8?B?V2R4WnBodGJCN3dhVndYYlBzc1Q0SzJCTzBOMU5pUHN3TEFkL002UE5aakhZ?=
 =?utf-8?B?SlozY3pmRHlSK3FxUmx4a1BRc2lvWXhIU2IxQy8zdUxUaHZHNEFqeEpOTTNt?=
 =?utf-8?B?SkpRUnM1a0hkZ1hXbC9JU1FuRjVGdlJkUmlFaVh2U1c3MTlkekdXb0ZzaWE4?=
 =?utf-8?B?cTlLNVg5NTR3UVFQVDJNbVc0V3lYUmIwZEhnb0F1OVhWelVadTltSzFuWUY2?=
 =?utf-8?B?endIa3dtS3R2anNrZW1sbVVsSzdXWm4rR0VjMkNvVEk1aFlubVdNZ0NLTW51?=
 =?utf-8?B?M3E2UUpjZk43b3d2OXNaTVVSdC9EM2JjLzl4S056WUtXWFFmSXVNeTlTUUZh?=
 =?utf-8?B?M2pSUk11aC90bEJYVkIwNmdFS01LQ2VZWW0vb3N5N3ZTN3hmSExJZkFzQ0NZ?=
 =?utf-8?Q?zfKmkEAo89IlbE/I0kr85ac=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dlVSTEJWSmxVWDhvc2FxSmxTbEovaWo0ait4TE5qSktoUDhnb1Zua2ZDNHJQ?=
 =?utf-8?B?YXRtSHB4Yzlwa1ZRalEvSGUrMEJJTmg5cHc3SDBWb0U3UHdPalVTVFZxVkF3?=
 =?utf-8?B?S0JTaHVSKzFZQnRhMWU0OWY5VGNOYzczZTk2dGV4UWpyaG0waHVBY1g1NDlM?=
 =?utf-8?B?TTNRcmpKZC9VaDVrMjJXdzRyZVozVUo5ZU1USkQ3NXc2WEpDajlCd0FnYXpP?=
 =?utf-8?B?TEQxanlPNWJMbE1JNUJaemk3RXBnMzhCVnNPaGRJei9MQ1MxUWFFcURsTytk?=
 =?utf-8?B?OHVKbmdKeUxBZ1RQeGpWS2xxRzZOZlpneDVFWW1vaWl2VVp2Zi80UGFlbVRu?=
 =?utf-8?B?c2FtY3ZPT1ZtL2YyejJFUGR2T1E4Vk5jK05XbTZTNDJoUFlsckV4S3llRlkz?=
 =?utf-8?B?VXhWS2YvT2RJelRQNVRCbVhacEE5aFcvQVFWdUhubDJSYjNNQ29JZ2hCOG5O?=
 =?utf-8?B?UlM3QmFmN3N0YVBLWE8rY1RoWkxDMU9XSENCNkxaR2gvNGoyWTVoL1FPSTJH?=
 =?utf-8?B?M3lqTkZGQUJEOTBPeUhkazl6cG94a0UxNEhpQVZZaE1XbmZ1bHhuci81Nmwz?=
 =?utf-8?B?Z1RFTzZ6d1dVZUVEbWRVZTB6cXY1YmFvdnFlQmlRS0tyTGNmNXhPV3kxK2tS?=
 =?utf-8?B?RGRFNHdHa1Iydlp5N0lLQS9VVGc4TGE3Y3k2Rm1qZHJpVTdHck16Y2tuckVy?=
 =?utf-8?B?Q2MzTlptMFIwN0UrOTYvRXpKR05kR0k4TmpjYjZkeTREK3J0OCtVWW1Ta0lh?=
 =?utf-8?B?ZXpJRlViS3JJdlAyVHpNT0VHU28vcG0rMVRVb290MnJzZGxsWm1Wd2tFOTdN?=
 =?utf-8?B?UFFwWXFwZmtURVNyOFV1U0tZVGtzZ3RDNTY0blhsNG9UdjM1NmsrTXpCV3Rk?=
 =?utf-8?B?Q2FwbEI5cVZ3ell0YmlWcWF5ZXNyRDkvR0VkWWpQOTJab3FOeGhNVFdxaWl0?=
 =?utf-8?B?aS85aG13b1pTNGY3bWtyNmUraktjd043Ti84SWVLYmx4TGZpQzFLOFBpSjBq?=
 =?utf-8?B?aHZVQk1mcWlFbTg1SFhENHFxUnZXVDMvb2VZYXhxNnhmam9WYTY1S1A1dyt2?=
 =?utf-8?B?TmJJTmRKemVHeVFrRmhCUG4vWlFjZG9vUXFzSTJ6d1NOYWNhNG9IdmlVcm1V?=
 =?utf-8?B?TkdJSDhUUGtJQ2txL2ZObGxnYmp4S0daZDBjMFp5aXdrcm16M0ZTUjhHQ3E5?=
 =?utf-8?B?Njl0N3NIaU5Vb3FtUk13S1ByWlJjYmNmOVpqeU9lc1Z4YkFNRTgxdVlPbjBa?=
 =?utf-8?B?L0JUeDRnNjNVVWl6VVdZNlhYSm0xWVZjRHUwcFlMVW96cERIdExhOTExUlJk?=
 =?utf-8?B?c2FaSTJWU0JvSjRFRFN5L0JWTVUrVjRvNXEybXM2TWxUQ2ZXOHpMOGdtRjhn?=
 =?utf-8?Q?xP/j8hnzGfUMTpQW2V2Z9TSc/bhV4TnQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba3315f-02bd-49c3-5b33-08dbc9de19f6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 22:13:16.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILx6MRyEi6xKD9l67HuccNO8VcA6wDevfe4LcG08Z1W77LoHgJRKwavoJCgdjF+qhfZUGS/2k/Pbk8VqN+00vapkQP3RVij5uJHX9eW1H9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_18,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100171
X-Proofpoint-GUID: PUv-GuTM9x1J2J0ZhvgkTmXPalFuH_V6
X-Proofpoint-ORIG-GUID: PUv-GuTM9x1J2J0ZhvgkTmXPalFuH_V6
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 3:25 PM, kernel test robot wrote:
> Hi Sidhartha,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v6.6-rc5 next-20231009]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sidhartha-Kumar/maple_tree-introduce-mas_prealloc_calc/20231010-041859
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20231009201639.920512-2-sidhartha.kumar%40oracle.com
> patch subject: [PATCH 1/3] maple_tree: introduce mas_prealloc_calc()
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231010/202310100603.qsn3ruBx-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100603.qsn3ruBx-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310100603.qsn3ruBx-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> lib/maple_tree.c:5428:5: warning: no previous prototype for 'mas_prealloc_calc' [-Wmissing-prototypes]
>      5428 | int mas_prealloc_calc(struct ma_wr_state *wr_mas)
>           |     ^~~~~~~~~~~~~~~~~
> 
> 
> vim +/mas_prealloc_calc +5428 lib/maple_tree.c
> 
>    5420	
>    5421	/**
>    5422	 * mas_prealloc_calc() - Calculate number of nodes needed for a
>    5423	 * store operation.
>    5424	 * @wr_mas: The maple write state
>    5425	 *
>    5426	 * Return: Number of nodes required for preallocation.
>    5427	 */
>> 5428	int mas_prealloc_calc(struct ma_wr_state *wr_mas)

Adding static inline should fix this compilation error.

>    5429	{
>    5430		struct ma_state *mas = wr_mas->mas;
>    5431		unsigned char node_size;
>    5432	
>    5433		if (unlikely(!mas->index && mas->last == ULONG_MAX))
>    5434			return 1;
>    5435	
>    5436		/* Root expand */
>    5437		if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
>    5438			return 1;
>    5439	
>    5440		if (unlikely(!mas_wr_walk(wr_mas))) {
>    5441			/* Spanning store, use worst case for now */
>    5442			return 1 + mas_mt_height(mas) * 3;
>    5443		}
>    5444	
>    5445		/* At this point, we are at the leaf node that needs to be altered. */
>    5446		/* Exact fit, no nodes needed. */
>    5447		if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last)
>    5448			return 0;
>    5449	
>    5450		mas_wr_end_piv(wr_mas);
>    5451		node_size = mas_wr_new_end(wr_mas);
>    5452		if (node_size >= mt_slots[wr_mas->type]) {
>    5453			/* Split, worst case for now. */
>    5454			return 1 + mas_mt_height(mas) * 2;
>    5455		}
>    5456	
>    5457		/* New root needs a singe node */
>    5458		if (unlikely(mte_is_root(mas->node)))
>    5459			return 1;
>    5460	
>    5461		/* Potential spanning rebalance collapsing a node, use worst-case */
>    5462		if (node_size  - 1 <= mt_min_slots[wr_mas->type])
>    5463			return mas_mt_height(mas) * 2 - 1;
>    5464	
>    5465		/* node store, slot store needs one node */
>    5466		return 1;
>    5467	}
>    5468	
> 

