Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C5F7DBB5C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjJ3OGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjJ3OGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:06:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08408122
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:05:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDpSNY010973;
        Mon, 30 Oct 2023 14:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mJvV5b6h5mtD3maS3/93cCsKuV9QWFskFU4HsmjLrJ0=;
 b=B/jwdMSGbQmLMlDtcFXEw6oAGwfFxy/nL87NOpBtHYMxTCKGv08waFRMugVE4GQCkr96
 z1jygKTBCu0/DcTzZjQMNyxRc3BF1XAPp3EX0R800lWHKkgVLg68kXeuQY2t+y1JkZJH
 IPIocOk+4hOQqvAsQpI6wgeYD1WaSFD/AsLpvboYse5Lll2gLIDdiHbePKrXgGy+dFTw
 3qqrMXb1vFRUrpZXiauqXo+a7nAzk2++aWGb5MhG/B4Up24QrCxVyeEuhXzmblaNu8Q3
 QjFYmOQ5+2Tqmml3JCg6jEirMtArNorKTeceZX3V1SbHSZ2g4pnA/5uPjRAx0eMorANs kA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7btug8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:05:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UE3QJG009195;
        Mon, 30 Oct 2023 14:05:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x46594-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 14:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVIKVhWCZuCrQT8O16N4o/WfaWWTj4weiXQg2w24lT9QQNxu4ymID0OnI5wumbjk/gM81PyHZcGaJZdTlK3JlyVxuSvwMXBMC70jungjK/nw7Elb3lFRG+RLp50wmNU3LM4LIjYiyHcHeEH/siBApYAcS4X43sYblGTgGr1MvqNbwlggo6hI/COtewC6djbMqdOvUAluykEMFBAs3Fi1RxcNzfv3hF+lBfB5YJ6GuzJmuAx+n7yA81Omxq4wCQPoyYU5QTG5TmXi+S+GeCal32LjqLWfG7ib0OwwsB8qMbZtmvW9kbF4OH7LgvpNzRuLmxjlxVLPXHjqKxX+r00inA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJvV5b6h5mtD3maS3/93cCsKuV9QWFskFU4HsmjLrJ0=;
 b=Ae7m5idSatFF1m2NuDi2K+EPvNtdr+KmkJi2uDNgmyuKZvX55rXo72mDLzcoX4qPduKbvND7qRZ86dUE+1A20B+rVhOjTHWjRzAmAEtzm+WgcVS8cM+jJ+pKpvqIYbwuGWlKomJRZ3q5+wPQi3WOSp1U3VQNiK6glOT+MbTrSWKiNh+79Gkrf0Y5tVqcTM9T4KJO6+ljHk5dFD3CyrqV59tu+bp4zuoMSNJ/tJhWfOIJeb90xon/G8EkNGYLuZWawrGEinu/gh5lUSdBK6XpuLV98I6mvaBlftOUawWSkk/fmdJImXuc632oK9mTii7EuX81EmfqVKB0lD3LDyM3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJvV5b6h5mtD3maS3/93cCsKuV9QWFskFU4HsmjLrJ0=;
 b=eoGNjFP5grqeadWkOtRY08cUuT7XKp6FhCcJgDsQ+2FQ37vfoG20GLBMOzFynlDM/B0XdYPajwIOj/uELvDvW7UoZ0/CTFsS1VU47RMhvMNFbUnN8fn3I0Yc3RP5zCPf1DQwJGQa6bB5hRqp00r/RklsEu5t/zmNntXFtKecA8I=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ2PR10MB7013.namprd10.prod.outlook.com (2603:10b6:a03:4c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 30 Oct
 2023 14:05:42 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6933.022; Mon, 30 Oct 2023
 14:05:42 +0000
Message-ID: <de5e15c0-0dcb-4cf1-bd4b-bd48c3c59c80@oracle.com>
Date:   Mon, 30 Oct 2023 10:05:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] vdpa/mlx5: preserve CVQ vringh index
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEuO6o3Ys9NcHJpa9w5EiS-ugsiaBbBKEHKHpPSrKBKJow@mail.gmail.com>
Content-Language: en-US
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuO6o3Ys9NcHJpa9w5EiS-ugsiaBbBKEHKHpPSrKBKJow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ2PR10MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f313f4-a4d7-4042-700d-08dbd9514dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1Y3pSMCDlbgg+ts2w7CR8KeFOGvwFqvhXbmwkvKzhZyetv+VDZjwglJVVEHGFmbwkORl4r8fMwxb8JdhAqU9miH3GhAX0KoNlTSd4T3csggt215VhtBMOFBWaQXoIaVFS6hefRBBeOk89E1Wu+2ArNa8B6b8nq8eAmcfcMLAz+coyPuqM9i5vppRvDImwQ7xOKH5R/6XNPJe0Iu4bvWJp78eUa0othHxla43yHpwbtPfxq/f5iuywqAlEEqHsjI+BXDygUat/zbLYdN4hKwsJ6D4Js2zWBPFJp1jNErlq5Y16op28rjZrJ/k2b0LapN0u08OaBt6Fct2iXa2IO9W53KZOcwPBEMoZ0wEUZDGX++01TyAFHKVjeMDO+s6SAh8382KCYSTJwKSb5YO1BxvD4FlrK9oQXPltukg1LTtZLEtHJVOAa20TugwZTUBzim3wjjVf8eKYmu7zX2LLd086U5iP0F+KEiRbHWaNg87ydEdIh0OtMyJgo3/BsEhDhkPrlLhFxvtqEW1Hr11D6UvUklF8hzAqMlDd0e8A9aSWPPDaACjEQuaLqLEvDUqV0WYBVdvXDT+DJoGy/jd4cXMB4/OrDsLHFTpgBcH+tAxxhpxYSEQk6w7GQ+G0bZ+EyBEo2rQlmKEzlr2S9j/wfmZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6506007)(66476007)(66556008)(86362001)(2906002)(36756003)(66946007)(54906003)(6666004)(478600001)(316002)(6916009)(2616005)(53546011)(8936002)(6486002)(5660300002)(38100700002)(44832011)(41300700001)(83380400001)(31696002)(36916002)(8676002)(4326008)(26005)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vld2SnZoelBlMUNPQ1hqNVpERXVXc1RiL0Jidkk1SThoeW5na0tSY1FseWJ6?=
 =?utf-8?B?WnRiMWUwWng3NGlES0Y0SEFUcjFEd1RMR21xVFczY0xnOGdBY1EwQUVqbmJI?=
 =?utf-8?B?UHcva3NOeTlEaFlsQlJuMGQvdVpWbVo4cWJCR1paMnhGNXlJRnJRNHRvblJm?=
 =?utf-8?B?TGJ5eGZ4MmlXZTA4ZkFLRDVTMlN1dGlwSU5GVFdvQlhTcVY3Sll2clozZXQ5?=
 =?utf-8?B?K0hBUnMxTnViZHd4Ky81d0J6ZVIzcWttVTVSdTNrd1RCRGhZK2Y4Zmk3aEV1?=
 =?utf-8?B?YU0vSndMNDUyby9KYmpKWDFKT3kyellpNVJweVBRcWlMb0V1NWQ0RDV0TVlT?=
 =?utf-8?B?aXhMV0p2RWlQdU81SE9rb3l4aGZIdkdZaFpPMndETlVDUWdTZ3pBK0NvaDZX?=
 =?utf-8?B?c2FRcU1lQThKOTNvSFd4MXZsYzZqbGpnWEZuek96bXZNZVFXYXk0bW91OEZs?=
 =?utf-8?B?TEhIU3VVR3RIM2NCQWszaU5IZU9jWFFTTU95MHZ1cmJVMUowQmRoeWJIZk5V?=
 =?utf-8?B?d09JdGNaODFvZU45TEd2V2cwUlVtVFZGWFpDek9KdnVGdkRzRnFMNVROOUFN?=
 =?utf-8?B?aUxiVXZ1RDR0QXlENC9aaXR0aVdyZ1BMdFZGSVQ4S3pQWmovWFBKdnRtVXB0?=
 =?utf-8?B?M1Y0OFBFNnY2d1dOUktPaHZ0MEhwSVlyU3E1Y3lMaGRxeFFYSWtYUmFmenV4?=
 =?utf-8?B?RnAzeTZzQTk0QkIyMEdzeFVqMCt5Y25GZk95WTk3bVovQTM4NU1teDRCSlJZ?=
 =?utf-8?B?ZzhnZUVTTE5qVkpHOTI1ZEhodjNuejkxaThWNStXQVV0c0tPUXpBTGgvL2xt?=
 =?utf-8?B?MXlJVUtkWVA4UkJzalcvOFN1Qnd0ZWRYSEFlSUZPdkd5czJjc2lDQjBDclRr?=
 =?utf-8?B?WWljTjVPK09iUFB6MWZMV2xwUjZ1dC8zbEltSjAvOHBmcFJud0FuQVBrVC94?=
 =?utf-8?B?N3lTdDdEZEd2eE0rb2NWZXdCeDcxckhTWEszNUlHOWM1cmpZQmhOMC9zb3N4?=
 =?utf-8?B?bVlONDdWakxWcHVaUXJOelh6SGlLRzcyMmpObCtuaFNNRFNuUDcvOVU0Q25r?=
 =?utf-8?B?d1QveVVLc2VsWElsMnpIVGY5elJiNVMvSXBLVDZWWWFCTkRscnMyY2pjTS80?=
 =?utf-8?B?ZEJKODFrSDJBWUFkTEhZbUV5Uys3ZUhDY1lCeEpKTERETjV3L0lQUDl1aTBI?=
 =?utf-8?B?U2haS0I3bjU3a3dHVkFoRHpRMlRFNTdnMXVHMWhnSjV4NHZEL3c0ZGxzQjVE?=
 =?utf-8?B?RjIveXBOcy9IVHFQQ1VleEwrTklkVGdRdTRjK0cycUwyOTR3cnVCeXpDOVA1?=
 =?utf-8?B?QWNKOTVEektlR1BLQ0lKU3M1V0RONC80UVVGVytrUzd0Y2I1KzQwSDllTUQ1?=
 =?utf-8?B?UFNiSGFjVC8xQUoxL3BJUHI5L1FQUVZVZkQ2WjJ2OWxYYW9aMlNKcnhRWnk5?=
 =?utf-8?B?TDBLWWtaY01keXFYNDBTZVVuY1hQNURxbDFqN1lvU3pYRlgrTDdjSFF2bDha?=
 =?utf-8?B?Z1l5QjByWmFDQWZVcWxCcllRdWlPcTFvaUU1WDJETklHc1Z5bDRxc0lzLzVu?=
 =?utf-8?B?aTU2d0xJOTNkNFNVVmR4cWJwQnVhVEF5QTN4bTAzNGZtRGVnc25TNGJYditU?=
 =?utf-8?B?Y1BEbXRSbkgySUQ5SVFPVi9wM2haR0sxWTNWSU1yVVlCQzlPeElxMkJZQWVl?=
 =?utf-8?B?NC8zSmppSTJNQ0tQTzNvRXlKeERJM3hlOUdmVXFKQlZxSG9SUFZ3Vk5oSDZ1?=
 =?utf-8?B?RGlVV2VVa3BQSXhYWkVTNWQ1NERqVFF3QkdrQWF5eG1rb2RIdVNTVmNaQ2Jq?=
 =?utf-8?B?aTdxMkMwTXkyeXBWVkRRY2lQWHg0dVNFVHRoQzZIb1E1ZFhzQ3VpWFhVb3l6?=
 =?utf-8?B?K2pvOUFhMmpMZTVza3p0OCtSdm1SdjVsb1JnaWtDcHFHaHJKdlArdE1KSnc4?=
 =?utf-8?B?Z2MwSHVZdURpY3Uxenp0b3JhT3g2WUxzeXgvbnFHaUZ6UldnZjdNcVZxV0M5?=
 =?utf-8?B?UGtJRzFBZ2hlYTR4NEVUdkNBci96YWZBOWZqWkh6SFBqcWNnV3FHVVdYYitR?=
 =?utf-8?B?TVJTb1crZmlIZnRqTnNXVnFlRFdsbm4wMVZEeUI3RnI5N1FBV3BNS3BEakhw?=
 =?utf-8?B?QzBTMlNwalp0bVZpSWVHNzBFT1NkV2E0aGlyQXhrWWdSTDBYRkxoajk5MUpO?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z2VDd1lQUGJndjk0RE5sbWw1SlFFaGJlb09hV2kwK01kNk9PNmlBejRVUGhT?=
 =?utf-8?B?QThGNmEyT0ZnMkVwZGY4alFHMlZHSUZzY1BlWXhFMHJ3NUFNWjN5Tk9UVkdt?=
 =?utf-8?B?eEw4M1dydWZGTEdpUjNEL0V1YVBFT2tJVFJhdUp0TUt4SlZ0SzV1NUdQTGEr?=
 =?utf-8?B?VHQrYVJXMTBLRjJnbDA1OFZMVmhjUjl1UTE4dFRNazZsM05vVUJPeGZMZnhu?=
 =?utf-8?B?YnJjT1dYSUl5YXBVSGo3WFh3aGdrMHNMR0luR3Y2WGNGSXl0dG9VQ1F3S0hH?=
 =?utf-8?B?WUQrR2t1TWtMYnhhak9CR1dYTk43SUxZUWQ2NWw0ay9hT2tHOWd5SGZXTkF4?=
 =?utf-8?B?ZGdmOC9QTnVwYk9rSTlhbDRtT0RkNER2Q3ZvUmg0L1NIQTRBdzB1dEYzRWd2?=
 =?utf-8?B?bEIzSDhMYnpQdHppZ1FOaEZGZ1hEOHRNWlNvdkprSysxa1Jqa2ViZWZNQUo5?=
 =?utf-8?B?UHYzeTVRUVl2VGVXbEhuR1A4clNVKzFMZGpSeCtCR2pJcTExZFBpcHlGWjkv?=
 =?utf-8?B?eFU0YjFxQndyTDBJZGpscWJvYldleVNEcHZHY3V0dlJrbUJMbm9reUpyVk1F?=
 =?utf-8?B?TDRRVStCQnhCV2pzbzRrcjV1TVovSFd2Q0hPQ2lMQ29VTTZVbVNoS1EzOEdj?=
 =?utf-8?B?ZVY4YVlDeVdrdndnM2dxYit6MFV0T2lVZTdTVUV5WXQ3MnI1ZVR3ZnRrRXZw?=
 =?utf-8?B?c0pUOWp2UzBQUEdZZEFnU3J3eUwydDRLYnJoQ3J2WndLYXJLL2xTR3h4VVBa?=
 =?utf-8?B?cXhldENrWDRnREtVTlRBSCtTUVByR2lYRHJCbTJLdHlsbTNQUER3cStoekJt?=
 =?utf-8?B?bTdPT2VCdXpOd3RBeEtMdjRIaWJ4ektNZXdqZ05QTkdFV0k1UkdhN2JQNVBy?=
 =?utf-8?B?RkZBSHJtRHlOUnBZU1pON3AxbE0zOHJlalViWnpJTGpmMW5adktzdmpIbVM1?=
 =?utf-8?B?eVFhdHZTZFVmM1RjRUN4NWFrWmN3QlpvUmRFeEtXNjNoWkRoQnN2WjJGUnFM?=
 =?utf-8?B?RE1VT2pVcVJCbXNQSmUxRnpjZ2hwRjMxb3ZzQy9LaEhCM1dHb281emtQVHJF?=
 =?utf-8?B?MUtWOW1lTVVEZVN0ZGtlMTkwUTZDWWZjc0F1NzFoUUM1OTJDb2ZqRis0RHFr?=
 =?utf-8?B?V3NSeEhnakZDUk93ZzIzeTlRYlNaWENhVHRuakV4LzQwcld0M2h1UnAweTNN?=
 =?utf-8?B?Si9zbWp0YTdGMkh0QmZOM29zYmY2b2hmR1g1VkZncElYNjRxWkYvR2JXTzUw?=
 =?utf-8?Q?COD9nUZ4uZrOjGR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f313f4-a4d7-4042-700d-08dbd9514dd4
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:05:42.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klSR3k7P/BY9xhTQZymYv3nrm8zdP6oAZTfYEtFthz91oZpiUx6q1OkSnvn/C7YxSGXgzqtI6JZWzPaAyrOGUNmW2IWm86F7OSAMrsYfQ54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300107
X-Proofpoint-GUID: 8j_Nm4Gy1uRHeGRckaZai463SC-wB-1W
X-Proofpoint-ORIG-GUID: 8j_Nm4Gy1uRHeGRckaZai463SC-wB-1W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/2023 2:31 AM, Jason Wang wrote:
> On Fri, Oct 27, 2023 at 4:07 AM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> mlx5_vdpa does not preserve userland's view of vring base for the control
>> queue in the following sequence:
>>
>> ioctl VHOST_SET_VRING_BASE
>> ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
>>   mlx5_vdpa_set_status()
>>     setup_cvq_vring()
>>       vringh_init_iotlb()
>>         vringh_init_kern()
>>           vrh->last_avail_idx = 0;
>> ioctl VHOST_GET_VRING_BASE
>>
>> To fix, restore the value of cvq->vring.last_avail_idx after calling
>> vringh_init_iotlb.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 ++++++-
>>  drivers/vhost/vringh.c            | 30 ++++++++++++++++++++++++++++++
>>  include/linux/vringh.h            |  2 ++
>>  3 files changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 946488b8989f..f64758143115 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
>>         struct mlx5_control_vq *cvq = &mvdev->cvq;
>>         int err = 0;
>>
>> -       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
>> +       if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
>> +               u16 last_avail_idx = cvq->vring.last_avail_idx;
>> +
>>                 err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
>>                                         MLX5_CVQ_MAX_ENT, false,
>>                                         (struct vring_desc *)(uintptr_t)cvq->desc_addr,
>>                                         (struct vring_avail *)(uintptr_t)cvq->driver_addr,
>>                                         (struct vring_used *)(uintptr_t)cvq->device_addr);
>>
>> +               if (!err)
>> +                       vringh_set_base_iotlb(&cvq->vring, last_avail_idx);
> 
> Btw, vringh_set_base_iotlb() deserves an independent patch and it
> seems it is not specific to IOTLB, 

Agreed on both.  I initially submitted the smallest change needed to show the problem.

so we probably need an indirection
> to have vringh_set_base() first.

Not sure what you mean.  I have defined:

    static inline int __vringh_set_base() ...

    int vringh_set_base_iotlb()
        return __vringh_set_base(vrh, idx, putu16_iotlb);

to which I would add:

    int vringh_set_base_user()
        return __vringh_set_base(vrh, idx, putu16_user);

    int vringh_set_base_kern()
        return __vringh_set_base(vrh, idx, putu16_kern;

all in the same patch.

The call site in mlx5_vnet.c would be a 2nd patch.

- Steve

> Or I wonder if it's better to just introduce a new parameter to
> vringh_init_iotlb()...

I considered that, but IMO the parameter list there is already large, and it would
be strange to add a parameter for the initial value of avail, but not for used, and
no one needs the latter.

- Steve

>> +       }
>>         return err;
>>  }
>>
>> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
>> index 7b8fd977f71c..799762c83007 100644
>> --- a/drivers/vhost/vringh.c
>> +++ b/drivers/vhost/vringh.c
>> @@ -595,6 +595,24 @@ static inline void __vringh_notify_disable(struct vringh *vrh,
>>         }
>>  }
>>
>> +static inline int __vringh_set_base(struct vringh *vrh, u16 idx,
>> +                           int (*putu16)(const struct vringh *vrh,
>> +                               __virtio16 *p, u16 val))
>> +{
>> +    int ret;
>> +
>> +    ret = putu16(vrh, &vrh->vring.avail->idx, idx);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = putu16(vrh, &vrh->vring.used->idx, idx);
>> +    if (ret)
>> +        return ret;
>> +
>> +    vrh->last_avail_idx = vrh->last_used_idx = idx;
>> +    return 0;
>> +}
>> +
>>  /* Userspace access helpers: in this case, addresses are really userspace. */
>>  static inline int getu16_user(const struct vringh *vrh, u16 *val, const __virtio16 *p)
>>  {
>> @@ -1456,6 +1474,18 @@ void vringh_set_iotlb(struct vringh *vrh, struct vhost_iotlb *iotlb,
>>  }
>>  EXPORT_SYMBOL(vringh_set_iotlb);
>>
>> +/**
>> + * vringh_set_base_iotlb - set avail_idx and used_idx
>> + * @vrh: the vring
>> + * @idx: the value to set
>> + */
>> +int vringh_set_base_iotlb(struct vringh *vrh, u16 idx)
>> +{
>> +    return __vringh_set_base(vrh, idx, putu16_iotlb);
>> +}
>> +EXPORT_SYMBOL(vringh_set_base_iotlb);
>> +
>> +
>>  /**
>>   * vringh_getdesc_iotlb - get next available descriptor from ring with
>>   * IOTLB.
>> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
>> index c3a8117dabe8..e9b8af4e6a5e 100644
>> --- a/include/linux/vringh.h
>> +++ b/include/linux/vringh.h
>> @@ -306,6 +306,8 @@ int vringh_init_iotlb_va(struct vringh *vrh, u64 features,
>>                          struct vring_avail *avail,
>>                          struct vring_used *used);
>>
>> +int vringh_set_base_iotlb(struct vringh *vrh, u16 idx);
>> +
>>  int vringh_getdesc_iotlb(struct vringh *vrh,
>>                          struct vringh_kiov *riov,
>>                          struct vringh_kiov *wiov,
>> --
>> 2.39.3
>>
> 
