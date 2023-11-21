Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A847F29C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjKUKF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjKUKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:05:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8039810E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:05:46 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALA59FQ017935;
        Tue, 21 Nov 2023 10:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oM/XsXf1D4eVnnuOvaPqtN2Fun2yRhoowVm5JdAXvo4=;
 b=ZDLfJuMS414P8/iUhds87xlHUjJuCyATdTYj+EYuGJpswmAc6elNZEpMwOPqXI6oIAMP
 14gFZKxuPx3Xg+R9EN+KVQgCzzR+hGYSkHTsxje8sP71nzHpKUtZaFAggqyDSwi+IF96
 BTRRY7iLKq6OBmapVpnNqPBYshsj8G0ene7UP3bAIv/z/RoACXmVUdCjE0BSuBteTAyY
 j0Q+7wgInd4lxbDFDhdc5yXa10Hy/q/lDz3zPSCPdEjzsNg4UKmIfi0ylJCIpoCKEuzV
 qscga3kobG3tcK90Ba9GWLecIjo9IQuyYE81+4N6KQ1YC0RVPMcsz+/0jwyyVUOmnoRT DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uentvcpe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 10:05:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL9QORf022682;
        Tue, 21 Nov 2023 10:05:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6gfm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 10:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeHw0kJ7LRrSHDIMQzVcWRAuFTItyZNImv5GklfO0VYKaD9G3e3ZFz2GPY0/q1VTUE1jBP2q5es00+4mIfeu3wghSAWJUuJC3GRbJRehFuGMVXTX/CTTosKNEm6LVN1gJaqwDEcfW60aklQj4Htq47j6/Hgj7SdebLPsx3AGgyMRFCIj26yS+s1PDJK8PfqgUT81qQQtTb0PyEGaEohP6k0XL7FV8sycnqWNMmhZ8rvCC6SRdKIM0Xxsku8g+eb8kEhXH9vgexcmrjBH5cwDcVsDmT2L0h46bdQQBSUljKAJ5IYh38/YCjewcPGCdgyIqdWiqf19vwFHkTDkhRj4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM/XsXf1D4eVnnuOvaPqtN2Fun2yRhoowVm5JdAXvo4=;
 b=g6fZlNcTPvnZ4fXyyONqzMUCyusumCQkdlnZbjZWSrZqIcUyiJyBZtsy4s1V7oQxAS5n8EcBeGP8Rm72aBAvtW8BbUXW8RzFciQrcwQVAmEbFvT0pNKDRM/44pAd4JM+DiXMA9XvweSP+v+b2VuDBK736BaDnfLDaotwtSLiyTB84BXJ0+TqdVIMF0U+t4Il5kCkyIbcwhpNQ9pai909itSa2Zibt4CmpM7Uk/YMyH18UfOUFAbgQUPWi67N3eYZ5c6P1LVSXsjcLlFDigrPcGqEYNuWOdGhw7lXJI9veBOIc2de5kEfQij/BKvWJEGeYgVgq+uU5/v0V/aVpxNseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM/XsXf1D4eVnnuOvaPqtN2Fun2yRhoowVm5JdAXvo4=;
 b=mRn/u9KtLJrE7gHLo2rvl21Tm2nyDntHMWfO6aUs0orG8YtyMke2cPWz9J4yTkyMSQlNesderMv8OJH5WrFVT/LWvcK2pZEbGpfTN3GnVVkfFaQAbzr7q+aWbY9B/4LDNxqNSEoTXhUE/AZcwtjcpgs5QXIblBqYZAV0pYpMtT8=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DS7PR10MB5976.namprd10.prod.outlook.com (2603:10b6:8:9c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.26; Tue, 21 Nov 2023 10:05:09 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 10:05:09 +0000
Message-ID: <5014f1bf-ee2f-4ea4-a6a1-ea9b0656e157@oracle.com>
Date:   Tue, 21 Nov 2023 10:05:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Set variable intel_dirty_ops to static
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com
Cc:     kunwu.chan@hotmail.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231120101025.1103404-1-chentao@kylinos.cn>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231120101025.1103404-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0034.eurprd03.prod.outlook.com
 (2603:10a6:208:14::47) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DS7PR10MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3861f905-cc1f-4d8b-0cfa-08dbea795804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMsZsyKt1ce0+j5/NLXo3yREq3PeV2GxIG5I/yyksORi9eBAoh3mYb99nW0ddzFzMnu2LlI0JkbSNFCqbiyTQSkMN8wELlQzJyCNn1pxsIDhwdhXeP5Cqt5VE3bAermNsOxJx8ql2g+CXUhCMVJQL28LkhLXRLW/hr3Xz6O3qsoffiVpm8UlG18X4Tv8Yew7kwEwnmbNIguce22El5KH4N6dnArbv1J02855hwfx1j3TFiW9wQdPILX1wBp5/MAibUq2wI9Qnu2z8mY3gbz8mSOyODfQ/W58non1OKPXt8OuL4QWKdaXYnvhDKz+tKfHJQcCGeFqQy/L1lOz6jq0N0i45fxqWyd4tRHNv+dD1fM+J5fPLJu9AWUl0rbR9fF9ux6LsV3M9YXpJswKoZbxTmWh1hAeFejaACTEEAWy6vnFlWIfVTDZkkyu9xKA/ky7IeTNKUgNGZg8qMycsFJQV15tiMWLCoLRFDxMuuGbg5OluGaRss8AWZigrlo4o6uimWWXJrYUk0qCccqZfOwkRYQIYxVqHawc5RDWJ89TR3peb8D/0nr+JevBU8XRBdpUALOEmzzyGKf+RspuIZtUHgwkt5f4ZMNnVR4938iunqRUcLoWqKmmn1cq8SN0m+03m6D2C0dRzQ0QoRUgy64i/gvWO0dGvrR2GLWXTIYXebYk2XmIDR+pmvubVgrgeCMomewGJHm7GmAq7ylntxfvuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(31686004)(2906002)(8676002)(4326008)(8936002)(41300700001)(66476007)(316002)(66556008)(66946007)(86362001)(26005)(6486002)(478600001)(6512007)(36756003)(6666004)(53546011)(6506007)(2616005)(83380400001)(31696002)(38100700002)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDh6cE1qcDBGd0VUa244QUhxc0E5K3BUcUplMnk3NHBEYnZ4ZFM1WnJJbmtG?=
 =?utf-8?B?cmgydDNXMGpkRFF4T3FyOEY1WEFFOTBPUWtFZkFhbkdGbEVRMmJ2TGl3WGlz?=
 =?utf-8?B?OHVBanJwTzlMMVZoRkl6eVMraitZdXJFL0E3UGR6eWxhWkJkZ3V3VzZGTDlD?=
 =?utf-8?B?bHlVeXo4OXFpbDBQdG14d1pxbHJucTJJelVVSGRVckxKRmthTEZqcmFBVytZ?=
 =?utf-8?B?di91elNEYWc1NldvYWJwcWxnbmROUUZKMXRNaDJuTHE0VGtJT1lOUjVOQVBu?=
 =?utf-8?B?VnI5bFJhdHZsTWVNempMYzlOZWFLNS93QnpQU1pQTmVvOU5XbDkyRDdtclF1?=
 =?utf-8?B?WlNuOGNwSHVaelorWlNWQjN4Z3NhV1hudnBJT014UkdZWGpTeEtzZWZHKzFH?=
 =?utf-8?B?ODVQNFJvZzVEWFpNSWR2R0wxQkVBVXZlSW81MURaVVpTOXVNMzg4bytjd3Ar?=
 =?utf-8?B?RzlVRzZHTUQ2UEtNZmxHTHFKMy9JZWh0RFh0NVlGdnFoWEZ0N2JFTERVcGpX?=
 =?utf-8?B?a1Q3QzF5OWdSR0NDcHV6bUNHS29XWkxjUUQxQXhMS3djR0o0OElZSmkrOTNR?=
 =?utf-8?B?dmx5RGU2YnlCUkFrekZjTnJlSnF6aTZrcDE0Wmp2Ni83bFdkbHRHTGhnWE5y?=
 =?utf-8?B?Z2NJV25qNHR1bVV5QWp5MHNWdEUrQ1Y5L3ZldlB3QmhsNXA5b3lyZHB1NGVT?=
 =?utf-8?B?Nm9GMVRiSHBYSVY5OXA3TmRuNnorZTdJaHRoZ1pwTE9nNjhvb1pZNEFDK0pr?=
 =?utf-8?B?dFFLYWNJNWp0WjZyT0pPcU5oSk5GVEcyTjBtcXB3MUJCc05LODJEOXNNamI0?=
 =?utf-8?B?N2FGMmk1dFhocWdneC95RGMxMVdvMHBaUEtJSHR1RlplZURPNzJ3d2c1ajI4?=
 =?utf-8?B?S0ozb01qWEFLbU00OTkwTEYzdXJhWXhwbkhjSERla3dUdnBncTBrUnVTcytG?=
 =?utf-8?B?cGFYUjRHS0NiOGJYbGczSjhwTlE1ZzdoWmkxb3RubGR0MmZycG04OXgxaHlx?=
 =?utf-8?B?VlVzWFZVbDJYT0RDTVdCRXZlVi9RMDlYTHBqUU8xd3JYRjFKZURHdnFSRVR0?=
 =?utf-8?B?V2xOQW1WdExENmhkQXpYQWwraWQycm9qaGZ3dHpicmUwWGh3SUtyQnROZTFq?=
 =?utf-8?B?TXJWaXZyWktyTHdYZEUxMTRTRi9Pczk2K0o2bXFnRXJQLzhnS0xGbTBiU21l?=
 =?utf-8?B?M3NTRXRvRThUaWVEUWdVanovTlBHTURmQ091YnkwNkVwV3k3ZXNmNkswc1E0?=
 =?utf-8?B?MXNHdmRwZndoZXRUV0lYdTdhMTRwazNDbEhtcWdZZzdqOWJVZ1l3NkNIWjN5?=
 =?utf-8?B?UkZMVFFYanJMZGdqK3NhRDk3b1lnMFNCcDhIc0pvOVlBTCtYMDh4aFlJNVZV?=
 =?utf-8?B?b1d4Y3BWOWRVd2NheHg1NkEwRld5R1pRaEVuM3NXQXUwS3hTQnhoMFp2L0JU?=
 =?utf-8?B?NXZpbDRRL0ozcEVNNXdmRnl4QW14b3hCNFVWalFjbE0zQVdrZk1zY2JZRjg1?=
 =?utf-8?B?Q3dwRTVLRlVjYjFFazBJaXhFL1RkSHQ5LzZNNERsNDJoU3FucE9SZ2xwSndB?=
 =?utf-8?B?aU95UEMrVjJ3VGV6aTNnSFhJbXBSYVhrbVovRzR0SjNSR2xsaWNUZU1Sb0JT?=
 =?utf-8?B?WjRtSDFKMGJyY0Mrc25ZRHJtSCt0Ym9jSmxiN2hlYzhBbE5GcTBjakpWUm9q?=
 =?utf-8?B?OFBab3VUVjBSUXl5a3NUMUFld0M2TkZ0RXptSTBjTkZUMHVmQk5Ic3Y3eE1P?=
 =?utf-8?B?MjNDWi91bm9MY2oxUVU1UVljM1hMQ0hLZ1htNnoyVU9xS3ExYndCeHVkbEhD?=
 =?utf-8?B?NHFIWTR3SUVTY3FnY01uZmJCbkFDcHJ1bjh5YUpZeHp6L0FZbTUvYndIb2RY?=
 =?utf-8?B?M1hyTGVsR2lMU2JrVFNsMmZiUXI3R204R3p5ZjhrSGhLS3FqNEg4QmdBVVd4?=
 =?utf-8?B?Q3lBT0dFWkJHcGRsQk5LcDZGckdma293MDJTYUtaYlovbXlML3l6VStiUDhh?=
 =?utf-8?B?SnlDVHNscVBUU0hMQTZyaTZBOVNrbk12dGhvTEpJVTBNdlE3ZVpLbCtrWGc1?=
 =?utf-8?B?NlZRUXJHMmgzY0JBZC9rellFQjBPYmZvR21GMU9GYXY4dEdRWXp6SDVkUVNY?=
 =?utf-8?B?TkNTQlJQZGtLTjgrZTBzc1ZlU09aWExmb0FkYTVkT2ZycW93WWIraDFZTXdv?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bE1hdDI0UzB2ZVhFV1lFbFJnOWdiYlRTNzlaVkxMMmQ5d2gzVnpZSHF2WTlv?=
 =?utf-8?B?cGNtV3JvdjBrVDk2d21KUzAwVUZLS3U2dkwvd0UrcWg0OHdnOHFzL3ZNTGpJ?=
 =?utf-8?B?MkFMTS9pYno3dWJNYW11M25XNnRjQ0JiTURzMElVTW1Fd2gweEYwOE0zbTFV?=
 =?utf-8?B?Yzk0SjRuWktPTXdWRFpNczNBMU5aZDhmWFVHWkhQdkdVMTA4ek9qOFQ5SWd2?=
 =?utf-8?B?SGFaNE16TzFRNjhyRXNKZzh3b0FFWm0zbVd5S3ZtV3luaXpKbUFFcFBlc0o2?=
 =?utf-8?B?NDl0TEV0Z2NjNVBaWDB2RmRCNkx6UmxzK2xZelBOcU9aYmEwZlNSWkJNT3JE?=
 =?utf-8?B?RXppTWxTUHlhUlJPSkhieWFCRkJIREZJNkxSVTVCMmRpaVpsbGo1Q0pzRkoz?=
 =?utf-8?B?STRtUk9MQzBrenN4eWI1bldkODl6YlZZdUFxTDkweVNYcitLNTAxV0ZoTXpk?=
 =?utf-8?B?L3BRZ0ZPUFVlRG5TSDNzcmVPUHJRL3I4TTZXM1RKeFhGKzhBYVUxS08zT0JX?=
 =?utf-8?B?SW9WYmlhU0VUZEJ2aEtSTFdoOU0xemJrcWVBSjRJZ1h0TjRJOTNSNXhEcklY?=
 =?utf-8?B?RlNvanY1cG5NbUVIOFpEMXdqbVlOWlZndXE1VjZBaE1WZGhwY3N0Tmk0L25E?=
 =?utf-8?B?bmtKa0pwQVpvSFhzdGcrQmQ0M2lhdGR1cTI3L0xmZWRTK25DUFMxRDl0b3NJ?=
 =?utf-8?B?ZzdTTUdieW9JdW5ZcER4bjQzcU9tendHTVFhWE11bFlZaTY1S3V2czJwWU5O?=
 =?utf-8?B?UWQxV2hDUW4wYkVuaVRlMGtQaS93VTVYSEtXR1VJOFo2RDJKOHFqMllqVnM3?=
 =?utf-8?B?YXNMdWVnSzEwRGZ1V21jdS9lMVJPaVM4OU1FdS9Gb0t6bkpKYUtlQU9oeDRu?=
 =?utf-8?B?YXZxNCtieWlrSnJ2ZEdwQU5QSElPdU1XSVhxWXRRUzU2YTUxTmRJc1pYMDJ4?=
 =?utf-8?B?ZFh5NXhQWkVtMFJFNHNsaUhXMWxRNS9UOWQ1UzRyQk9EbjcvUUtzT05FTUMw?=
 =?utf-8?B?K1ZsbTBOOEJYOHIxUW9idCtDTXFZcXFJL1RyV2NiQUFXTXJaR3IzN2ZXZ0Ew?=
 =?utf-8?B?K01jckJHVVMwWFBCZ29yc2U4eXM1b0lHa1RxMmFkQ0liOEZndW4zeEg5UDNs?=
 =?utf-8?B?TU13K1E1eXdBL2t0dWFGN2REVFlFRElOVkpmRVFqZEFVVEkvZm1VVTFIRW04?=
 =?utf-8?B?YzlUaVZOTXZod3piQ3g1U09YOW45TVdST3E4dStzeU1NZ3F2MFJVZ1IxM1oz?=
 =?utf-8?B?QXlhbFJYYlo0OXp5ZkVMQldVRXVWMHlES0FqOXFiTEo2Ryt0OVBzR1lzczJl?=
 =?utf-8?B?akNPbndqVnA0S2VJSXBWRENLKzRtWkRpMGl5RWpOQ0owR3hBU2EwNnVtQVRj?=
 =?utf-8?B?QVJmQ0dlMFNsQ1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3861f905-cc1f-4d8b-0cfa-08dbea795804
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 10:05:09.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPifC1/zvQKFqqhN4u87xuVZdHospMsbhn0wUGvwr/KQtQ4wleIPuLgY9FNZTbxI1BdQRaz4cbhK+P8f0o75bLIzcEKwbfi8CXMVxhDjY6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210078
X-Proofpoint-ORIG-GUID: R8rBgCrfwsqU942pjchzzn6JFgE7UP-Y
X-Proofpoint-GUID: R8rBgCrfwsqU942pjchzzn6JFgE7UP-Y
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 10:10, Kunwu Chan wrote:
> Fix the followng warning:
> drivers/iommu/intel/iommu.c:302:30: warning: symbol
>  'intel_dirty_ops' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  drivers/iommu/intel/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 3531b956556c..68e4d4006300 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -299,7 +299,7 @@ static int iommu_skip_te_disable;
>  #define IDENTMAP_AZALIA		4
>  
>  const struct iommu_ops intel_iommu_ops;
> -const struct iommu_dirty_ops intel_dirty_ops;
> +static const struct iommu_dirty_ops intel_dirty_ops;
>  
>  static bool translation_pre_enabled(struct intel_iommu *iommu)
>  {
> @@ -4925,7 +4925,7 @@ static int intel_iommu_read_and_clear_dirty(struct iommu_domain *domain,
>  	return 0;
>  }
>  
> -const struct iommu_dirty_ops intel_dirty_ops = {
> +static const struct iommu_dirty_ops intel_dirty_ops = {
>  	.set_dirty_tracking = intel_iommu_set_dirty_tracking,
>  	.read_and_clear_dirty = intel_iommu_read_and_clear_dirty,
>  };

