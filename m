Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF87D0800
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376282AbjJTF6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbjJTF6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:58:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891EBD41
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:57:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39K49bB4028986;
        Fri, 20 Oct 2023 05:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2HM7Jjev0y8gjqlu0ueyJQcYUEh6+lbMTdQKhnf4odU=;
 b=AMB7FXFa1yFIGshQqcF7FrmsaWysWqxNWHBg80z9J5bk+aMm1nPmyG69r/zDiIaGWx3X
 KhpIKp4fpnf4+2uU+Sv+XQIKbXIzA4aM700CorapUKd/bdGsYU+3zQ0KvtsCMHs/nqAc
 zy9wR88lahLyLlok6aaicHOnHeTQWWk8uQNfhgUaATaVOD+BZNMxt8UPMxQ/wsfp+EJ1
 PsCI/3qo9BSG7sNtKzKRMjtt3O7gcqYUNJPSjqkX7shhltYBwpR9IqvWMzR48bvlRdPc
 VusYKlHzGcdC8CZZ9faX0DM27AaOMyA0IitR//ySKKeF5tfxqQsGDLaiqJrT4vnqUgC0 8w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwcgh8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 05:57:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39K32wfc025711;
        Fri, 20 Oct 2023 05:57:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tubwcvqxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Oct 2023 05:57:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crGZSJkFtX66AoWoswjgK2IwBPQj8E+vQlrVodbn7qFVUy5Mml9r237oq0t6l2lHtWoZoYN4BSjgM/9STOHF84MEEvZOVfHu/wutEDUB5Sv985/MXYVi9BpQfJ6TGgQfzWY5wVder80VBpapKituNktvBExTFG8WQs7CmbqJwQJE+G+jHd2ogxIl8xAqk/OxmatNSaeKG3xpP6VsHNyWw5N6k3iofXoMw5Qjf3FXmxvk10wxibsh4L/JMRPk4WCZB8qTBV5Si/RmN7d5rlt3T3H+hnSvScQVnTQkWRktlzmSACVmxLKXMI39mOcnv4ZdvFI3oeCRphlHTKthQd4UFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HM7Jjev0y8gjqlu0ueyJQcYUEh6+lbMTdQKhnf4odU=;
 b=b7DVswB7pXGUSRzwc9HTp+l/9h+Ld0eILz5tXXe2rINDLQ7KYK1APRZQOzBXTfvOyizMTySoR2Sckw/xB7FR+lsfwggXW3pIhc3+JG6TD2qyhxiMZTb5zWC1Ullo7K2CdscHJJSxT20MTtL/F8tTzHHftyy/+zcsLxB0XXK2f/drMRZD9MiD7g9s0u1/sZ5pubp702cyG08V1Ycd8aV7LNqFjfKBBy26FFSKwmqxLhiHJ4sgc8SKoYNQQ1A22mIaV8xfcUwTOQfG43FKIqxUERkoYOp1mvW4ZE/ASmte8uPmd49GXPqKchpDFwseGecWmeOgCESw6/YY8jXr8AIDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HM7Jjev0y8gjqlu0ueyJQcYUEh6+lbMTdQKhnf4odU=;
 b=mVpOQ8x/55uGNTU7dogSL1NVqo/OdDNDhAoWxV/z/hWqUH05LiS8FlQ4TMvVu1eJapQKrHdmWJsacGux2b3A8GeFpBDWYHjNsSfdoDUWzHHDB4aKBPiPkbRJd6M/o4wSyBoT5KIGc8c8YYZVEXEqoYpcVvy+hPIVEuuBY3QJqyA=
Received: from SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8)
 by CH3PR10MB7629.namprd10.prod.outlook.com (2603:10b6:610:167::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 05:57:36 +0000
Received: from SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::77bd:3721:8a42:ecab]) by SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::77bd:3721:8a42:ecab%5]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 05:57:36 +0000
Message-ID: <b83ad43c-2b5a-4288-aa8e-71ebdeb420eb@oracle.com>
Date:   Thu, 19 Oct 2023 22:57:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
 <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com>
 <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
 <CACGkMEtZ_oEydqsvJh0-eaDh4q_KHq9fLPg1uy-W1m7K_g+1-w@mail.gmail.com>
 <d2b52f01-3d00-46ad-b58e-e23fd8a49e87@oracle.com>
 <CACGkMEvebhMo5dfcyq2MFhBvFVNbwrqVofJXaBe9Vmn1O4qVjA@mail.gmail.com>
 <4ba8b63f-61e8-44cf-8e01-e467bd27ed5b@oracle.com>
 <CACGkMEuTchn+QU1QFh98E3YfUJaUM6Vnm0ECtRbqMsA-uCR2uQ@mail.gmail.com>
 <CAJaqyWdMPVUd_zjd0nkQKvDmG2HPe5DBS-w5=mx4qSPCqtDJwg@mail.gmail.com>
 <07174d80-afad-4017-9088-02f2133e64b5@oracle.com>
 <CACGkMEsQb62oWLx8tLOk9B4UUTp1ErPLyiU1xf1kJwa1YvPZ-g@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsQb62oWLx8tLOk9B4UUTp1ErPLyiU1xf1kJwa1YvPZ-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::21) To SA1PR10MB6519.namprd10.prod.outlook.com
 (2603:10b6:806:2b1::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6519:EE_|CH3PR10MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d41a17-bd2d-4999-35f4-08dbd13175cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDT8LcMZ7IFBWyVtDPFjIL997ruJytzmAJwk6LPgv7jp8z5fSyve6mAil5pPgQncp7LacyeDoRghZW8GiVZdecT1W1dO1f7JXJHSNnxQBpM/6wMsd14WlZ9DS2h1K4i3PqfKYpRsl7pxO/dCRhGdlJdRU5NI69vqr12yp1mIhOIa9l7LS2xJ/jC+8XR3yG5PLeth3UgizhxvXQtXrTpp8zhJ0oJjpDtNHEd+aqCw/4d0NkGcrSdHDEo+4TAgJAICloKstQw2OLTrB9A/6wLO/PTOybNeQTzRQvgzrm2FUP59UiSRc2dV2qRpM2kiZLatThHaPBaWf/URrsTEtG1FZu58SRzeGPH4fip3c+d+PCyxCsHdosnu1sd2oTve8sKGhR7nOSUdclmQ5Lej1Ev50qqO8PKORVxE5z1jBaR4kA/y1b2JA9w2vO35gcyPKEXU/PiT7UwMhf6N7rMoeEFIU2uGULI5DKKa9NM12t15yErZQ/n08dDSOhOdrk5YKUXhnXFoXELoQKE5BWEeFmhPUo6pRNb5vVRK9g9m8NoKQTMmyEJl9IUeKSjJnDYazOMkKWbijtJVbX6OGXAAXAx+g+Qa5qJSN6+wyLFlmn6yh1m6NuR3uVD0a1j5z8BaVpgpC/UJilLv3CiHCl1HurZExfPLWnbt/NX4Dg8uAlZm4Tw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6519.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31686004)(66899024)(6512007)(8676002)(36756003)(5660300002)(8936002)(4326008)(38100700002)(30864003)(83380400001)(26005)(36916002)(53546011)(2616005)(6506007)(6666004)(31696002)(2906002)(86362001)(478600001)(41300700001)(66946007)(6486002)(66476007)(66556008)(966005)(316002)(6916009)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTRLcTk3MVovb1IvQ0ZaeGMrNTZXai9rYTEvdFo5dGZKS2VDZW9RN3dSQ1Vp?=
 =?utf-8?B?aFBpbHpCK2JzZDJTalIwZUc4MUNMWVBZSzhIejN6UzZsZ1ZkYVpnWEl6Ukwr?=
 =?utf-8?B?V0dscnlFWDMxdFVZaUs1Sm5PYm1hNzlGaElmUU5kWitpU1J2Z1JtSStWRDFX?=
 =?utf-8?B?Y3lsSjcvTDZIMmhtS2NxYUNENGVIK0VHQUhJV3RoWVJrRVBabHNqYm5EeVd6?=
 =?utf-8?B?REwwWkxIRTVrU1ZnQ1ROalU4SERDRFBJVnpUM0RvaXVYZ1YySGNSMjJBRzBR?=
 =?utf-8?B?OGJyWjlhNklVY25EQVZOMzZLVEhZVmF2Zll6dS9wTmJEZmJiMzZJdkdzeWIr?=
 =?utf-8?B?V1ZmUERLYktMeTdWd0IwbUVsSlM5YTZpWGRJUFRQSEdPZVVURUd4dDVJeDdl?=
 =?utf-8?B?M3dOb0Q1MlJXMmhRTm82TVJqQUhmT253UFRLd2R5N2ZuNVRoZmFTb0ZvMnRQ?=
 =?utf-8?B?MzlxTUhrQVlIUVFPYWc0dTRmTUtWVEV3OGFqWlVLbnpLaURwa0djNkRXbWp4?=
 =?utf-8?B?MVl3cVhnUVhwb1IwK0lLdmUzUEErTXZXQS9YTjBvSUliWWtJWjd4SnF2YjAx?=
 =?utf-8?B?ZUxTcXlYd2p3eGRaMU8wR0RkenZuWHdyWDRQZXZnVFZDdW5uWWgrckxiVUFM?=
 =?utf-8?B?UWxBS3dQclNhRmExMnJZcXBYbnlIQ0MwOFBJY3JKTURSanYzcCt3cXc1TFlC?=
 =?utf-8?B?azI3VnFObWZXemJDYTA2VGR4V0RFcFZYcWJQK0hmbzI0eXMydkxkVW9RUVlQ?=
 =?utf-8?B?VUZxN0JGTzhteE1vdjBLMk81UDJUa2Rxd1d2cW1heUxvZkF2VFhRNmhvMlZH?=
 =?utf-8?B?Uk9GUWZSMTNYOUI5R0FobGlXUDhyUURXQXdlL2tKT1ZlbEJCZEwzL2FOMy9p?=
 =?utf-8?B?TTkrRmE3S3ZMVlN2UUFCaWxaMlg5WG82MlRvVXkzNXM3WGQvWUMyNGtTNHFi?=
 =?utf-8?B?SE4xWWhjOHBINGpwR1NMWkRwVmpuNzhEZS95R2hJNDNSNURCVExhRi9TRjR2?=
 =?utf-8?B?Mk9qcWJUNkJiMUFDR09KMG45MzNlTWlkTjErL3FxT3pBTHkrNVZlRzkwd25l?=
 =?utf-8?B?MlVBVVNDMDZNUlQyRVJzYmdTWFlXdElWaGxFMDMvNUxTamUzbHlDVS90MEh5?=
 =?utf-8?B?cFVoVUJWVDZGVXg1TisxOTJVdjlSN2tSQkxvRE5qeGxXRThZdk05Z2lXbVA3?=
 =?utf-8?B?d2F6bExHVXdSbTdmVGs3SkFaZVpBbDFVZ0IxOWtiUnEyemEzQ2JFaEZHNnBF?=
 =?utf-8?B?ZHpMMUQzRzlIaTl0RDEyaU5iZTZkekxvS1JSNERlcGYzenN6SVhrRFZwQ1pz?=
 =?utf-8?B?WG5nTEpzbEc4ZXBKU3M5N01jT1doZ1pka1U5QkVESUF5K1ZQMlBNRWVkb25I?=
 =?utf-8?B?bjk2Q1hmMVFwU0txektjd0c2WStUN2ovbXJxaDdhUVl2NzBoaGdraks3OGhJ?=
 =?utf-8?B?Qk83cCtOOEpnRFpxRUttc1dJTktoS2FpcE9QOEhWbG9WZC9ZYkVINGg4VXpH?=
 =?utf-8?B?VTlOc3RtMU82Um53dmpFUFFQaGVOd0ZHamg0dHhHZEZUbHRtcE9uSWRRaUVY?=
 =?utf-8?B?bU5KZFhqdk8wVEFCSDYwcWNzcTMxaFp5SmVSemU0aUJETFQ1OWJDdmpSSm1v?=
 =?utf-8?B?M1RkTXF1NHlWbDc1WU5wMFdMVTNmaWtmekVNaWlTOVUwN1RRSS9vM0VvNnBi?=
 =?utf-8?B?TURFSUN5Q2lGWnVUUU5CbHVESG5yOFhCYTgybEVESEMzL0tIaTIrbTV4ZVJU?=
 =?utf-8?B?aWtPRk1qVjU3UWtVZzFRa1FGOHhyL0gxUkJudmwxRXBleXliOHFienEvLzRM?=
 =?utf-8?B?bjhIYXpjVS9vTUZnbi83bzNQOWlqOEdqMzhsd0xRcUxkUHd3NWI3WkppSlJh?=
 =?utf-8?B?dUgxVndGU1FKUmsyb2FrcmtOMDNUdnNKWTBXenhqSzJ2V2RDMWQ2Q1k5Tytn?=
 =?utf-8?B?VnZYd2pMMWpPQS9hR3FtanZkdGduYnVlRTlveFFVWkxxWjVpNjhDaUM5ODJN?=
 =?utf-8?B?dWhqUVpNUGhvb1QvSzZVaGMzTTJlRmIvd1A2WnpjdnZYbHF6TDlyVElTWWt0?=
 =?utf-8?B?UzlJSUdKMWpteStqMHUyMkRmOHVwQXZnS3N6bGQvVDkvOWFFRVY4dHhlOC96?=
 =?utf-8?Q?6oODCrRhiTzGZpmhZqsiaF2W7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MGc1V24xZnpBR2IyRGlqSXQzWjBWTXBLWk0wWjlYYlNKLzNha0tkOWlrSnRJ?=
 =?utf-8?B?djVNaUFNOXBDb0ZQbS82NUQ3enpPeUMvTWxXZHVsWjY0aTJWVUw3dEIwWEg1?=
 =?utf-8?B?cm9DcnVORFkwSzlKa1NPWlBvRVgzc2hyYS95aWFzaHJJU1ROMDBiSUhvREcy?=
 =?utf-8?B?U1k1Y29TZW82TVhaaW9jdkgzUUwzS05iVW5NcXVSMGpPWkRQSjI0RzdCY1pa?=
 =?utf-8?B?dnFHR3JQaU93TjlGY0dvK2E2ZVBSb3lKTTZVNnIxYTZZQmdiQkFrWHRRQkNY?=
 =?utf-8?B?TExiOFJyR29LUXUwdzRGZkxwQ2M2Q3dkeTVyK3FzRlA4dkFENnFVeDNFdU11?=
 =?utf-8?B?SnRmdGJDajloN2pTNTRCRnQ1ZzlWczlQRmJuRkRmOHVGRGdxSGN1RDZJVkhp?=
 =?utf-8?B?aWNaRENPbTVnajJEVlR6OS9yYTFGdk5kSHhNekxhdllTT0ZQbVNOMHpncThU?=
 =?utf-8?B?MnVicVlHUE9QVjJVUUJiWXBoaDBRRWZxdzhKdUg4WWdnS2xrTkhTMTFLcjBk?=
 =?utf-8?B?bWJCaktWazc1ck1TdFZURVY5eStMaThpdDBoUktYbUVnREE2TTkzQUtzcHFv?=
 =?utf-8?B?TFR1RVJSUG53bnhWbFpyYzBOQ3JDeEVGYWZqbDVhTENMeGhaSEtLK2I5QXkw?=
 =?utf-8?B?bDYxblQwOXJWYlZLWWx5SjlWNkN2WkxSb1pJTUFNR2hXT25sNXpySHlqY1lC?=
 =?utf-8?B?NXArdkIrTE42bEV2MnE4a012ZUhtNis0cThLTHhtK1VUUVA3UXpmNEdldHlI?=
 =?utf-8?B?YkFOYng5djh0VU1RWjg1QUhOTmJlZUFOZjFabE9xZUlkQ0pReHZZVGZBdjJE?=
 =?utf-8?B?L25qWVp5T1BiWGJON2xxRTNJQzMxTTVBVVQ5aVJMMHgwaytJcnV5Q2d2TE5u?=
 =?utf-8?B?aisvcFc4Ykp0bE8zY2VpY0o3TzlyTEpkdHFRT0Q1bHU2OGkwTDFobC94YmNp?=
 =?utf-8?B?VGRkQUEyMDFxa2hqNUNkMWRHQWdVdVFQU1RVS212UkhicFphd3BXanRDU1E5?=
 =?utf-8?B?bElqUHhMV3lEd1NvT3FwYlFKSGFtUVMzSmZOV0c4OHV6dXpycStHdi9MR2h1?=
 =?utf-8?B?Nmk1dFg1WGdvS0hLVVVOM0dGNmNwdEZzdzhYbnhNbWZsZFRxeVpzYkFjeGVS?=
 =?utf-8?B?R3VDZ29NUFBGa29OaU9vN3VRVUF5T0RMTytEa1NoQmQxdzRrVk0vNGVaZENQ?=
 =?utf-8?B?MkVLS3BWSVUwUGF1L2puYkVoNytQTDVzVHZGZ2NPaVVvRjZPcWZXUWtOTTl2?=
 =?utf-8?Q?rpM0fyYraRcRk0D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d41a17-bd2d-4999-35f4-08dbd13175cd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6519.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 05:57:36.5216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F587WG9tts5dl+gJkyLkvaYtaeOShsTF8wJbfaEfwTstEuAM7we3BR+e6St68b0Um5W/Pf0//fuoOCoD2XAFlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_04,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200051
X-Proofpoint-ORIG-GUID: wbsfiHfAOiveO8AdoXV8RH5TxG5ATT4H
X-Proofpoint-GUID: wbsfiHfAOiveO8AdoXV8RH5TxG5ATT4H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2023 9:11 PM, Jason Wang wrote:
> On Fri, Oct 20, 2023 at 6:28 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 10/19/2023 7:39 AM, Eugenio Perez Martin wrote:
>>> On Thu, Oct 19, 2023 at 10:27 AM Jason Wang <jasowang@redhat.com> wrote:
>>>> On Thu, Oct 19, 2023 at 2:47 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>
>>>>> On 10/18/2023 7:53 PM, Jason Wang wrote:
>>>>>> On Wed, Oct 18, 2023 at 4:49 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>> On 10/18/2023 12:00 AM, Jason Wang wrote:
>>>>>>>>> Unfortunately, it's a must to stick to ABI. I agree it's a mess but we
>>>>>>>>> don't have a better choice. Or we can fail the probe if userspace
>>>>>>>>> doesn't ack this feature.
>>>>>>>> Antoher idea we can just do the following in vhost_vdpa reset?
>>>>>>>>
>>>>>>>> config->reset()
>>>>>>>> if (IOTLB_PERSIST is not set) {
>>>>>>>>         config->reset_map()
>>>>>>>> }
>>>>>>>>
>>>>>>>> Then we don't have the burden to maintain them in the parent?
>>>>>>>>
>>>>>>>> Thanks
>>>>>>> Please see my earlier response in the other email, thanks.
>>>>>>>
>>>>>>> ----------------%<----------------%<----------------
>>>>>>>
>>>>>>> First, the ideal fix would be to leave this reset_vendor_mappings()
>>>>>>> emulation code on the individual driver itself, which already has the
>>>>>>> broken behavior.
>>>>>> So the point is, not about whether the existing behavior is "broken"
>>>>>> or not.
>>>>> Hold on, I thought earlier we all agreed upon that the existing behavior
>>>>> of vendor driver self-clearing maps during .reset violates the vhost
>>>>> iotlb abstraction and also breaks the .set_map/.dma_map API. This is
>>>>> 100% buggy driver implementation itself that we should discourage or
>>>>> eliminate as much as possible (that's part of the goal for this series),
>>>> I'm not saying it's not an issue, what I'm saying is, if the fix
>>>> breaks another userspace, it's a new bug in the kernel. See what Linus
>>>> said in [1]
>>>>
>>>> "If a change results in user programs breaking, it's a bug in the kernel."
>>>>
>>>>> but here you seem to go existentialism and suggests the very opposite
>>>>> that every .set_map/.dma_map driver implementation, regardless being the
>>>>> current or the new/upcoming, should unconditionally try to emulate the
>>>>> broken reset behavior for the sake of not breaking older userspace.
>>>> Such "emulation" is not done at the parent level. New parents just
>>>> need to implement reset_map() or not. everything could be done inside
>>>> vhost-vDPA as pseudo code that is shown above.
>>>>
>>>>> Set
>>>>> aside the criteria and definition for how userspace can be broken, can
>>>>> we step back to the original question why we think it's broken, and what
>>>>> we can do to promote good driver implementation instead of discuss the
>>>>> implementation details?
>>>> I'm not sure I get the point of this question. I'm not saying we don't
>>>> need to fix, what I am saying is that such a fix must be done in a
>>>> negotiable way. And it's better if parents won't get any burden. It
>>>> can just decide to implement reset_map() or not.
>>>>
>>>>> Reading the below response I found my major
>>>>> points are not heard even if written for quite a few times.
>>>> I try my best to not ignore any important things, but I can't promise
>>>> I will not miss any. I hope the above clarifies my points.
>>>>
>>>>> It's not
>>>>> that I don't understand the importance of not breaking old userspace, I
>>>>> appreciate your questions and extra patience, however I do feel the
>>>>> "broken" part is very relevant to our discussion here.
>>>>> If it's broken (in the sense of vhost IOTLB API) that you agree, I think
>>>>> we should at least allow good driver implementations; and when you think
>>>>> about the possibility of those valid good driver cases
>>>>> (.set_map/.dma_map implementations that do not clear maps in .reset),
>>>>> you might be able to see why it's coded the way as it is now.
>>>>>
>>>>>>     It's about whether we could stick to the old behaviour without
>>>>>> too much cost. And I believe we could.
>>>>>>
>>>>>> And just to clarify here, reset_vendor_mappings() = config->reset_map()
>>>>>>
>>>>>>> But today there's no backend feature negotiation
>>>>>>> between vhost-vdpa and the parent driver. Do we want to send down the
>>>>>>> acked_backend_features to parent drivers?
>>>>>> There's no need to do that with the above code, or anything I missed here?
>>>>>>
>>>>>> config->reset()
>>>>>> if (IOTLB_PERSIST is not set) {
>>>>>>          config->reset_map()
>>>>>> }
>>>>> Implementation issue: this implies reset_map() has to be there for every
>>>>> .set_map implementations, but vendor driver implementation for custom
>>>>> IOMMU could well implement DMA ops by itself instead of .reset_map. This
>>>>> won't work for every set_map driver (think about the vduse case).
>>>> Well let me do it once again, reset_map() is not mandated:
>>>>
>>>> config->reset()
>>>> if (IOTLB_PERSIST is not set) {
>>>>       if (config->reset_map)
>>>>             config->reset_map()
>>> To avoid new parent drivers
>> I am afraid it's not just new parent drivers, but any well behaved
>> driver today may well break userspace if go with this forced emulation
>> code, if they have to implement reset_map for some reason (e.g. restored
>> to 1:1 passthrough mapping or other default state in mapping). For new
>> userspace and user driver we can guard against it using the
>> IOTLB_PERSIST flag, but the above code would get a big chance to break
>> setup with good driver and older userspace in practice.
>>
>> And .reset_map implementation doesn't necessarily need to clear maps.
>> For e.g. IOMMU API compliant driver that only needs simple DMA model for
>> passthrough, all .reset_map has to do is toggle to 1:1 mapping mode to
>> the default/initial state without taking care of maps, as
>> vhost_vdpa_unmap(0, -1ULL) earlier should have done the map cleaning job
>> already.
> Ok, finally, it takes me a while to understand the issue :)
>
> Actually, there are two things:
>
> 1) stick the IOTLB mappings across the reset
> 2) reset the vendor specific mappings to whatever the parent think
> it's comfort (like 1:1)
Yep, maybe I need to document this expectation more clearly, but I found 
it a bit hard to describe what 2) is really about (tried to avoid the 
specifics, like 1:1, as that wording seems not so welcomed).
>
> So I think my suggestion doesn't work.
>
>>
>>>    to have this behavior if they need to
>>> implement reset_map,
>>>
>>> What if we add a new callback like "config->buggy_virtio_reset_map",
>>> different from regular reset_map callback at cleanup?
>> Right, separating out the need for old behavior emulation from
>> .reset_map is much cleaner, and this is what individual broken driver
>> has to maintain without penalizing other good drivers. Good to see what
>> I said earlier is heard.
>>
>>> Only mlx5 and
>>> vdpa_sim need to implement it, with a big warning, and new parent
>>> drivers can trust they'll never have the old bad behavior.
>> Let's see what Jason will say about it and try to converge on this
>> first, I think he seemed to imply that this is part of ABI that every
>> driver has to make compromise for. I'd better get it ack'ed before
>> proceeding to the rest.
> Thanks for your patience.
>
> I think we have some choices:
>
> (All of the below can work, but we need to choose the best)
>
> 1) module parameter: this turns out to be hard for the management as
> it requires the subtle knowledge of a specific user space which turns
> out to be hard
> 2) buggy_virtio_reset_map: seems like somehow a pollution of the
> config ops, I think we can do this only if we have other choice
> 3) set_backend_features: I understand the concern that we should not
> propagate the vhost level feature to parent, the reason is most of
> them are irrelevant to the parent. I think the right way is to
> introduce get_parent_features()/set_parent_features() then we can
> choose to map some parent feature to vhost like
> (ENALBE_AFTER_DRIVER_OK and IOTLB_PERSIST)
> 4) piggy backing whether we need to clean vendor specific IOTLB in
> config->reset(bool clean_map)
Both 3) and 4) should work with me. For 3) we already have the get_*() 
part, though I'm not sure if worth to bother introducing the set_*() 
API; today I think most parent drivers work directly with the driver 
config op, instead of backend feature flag . 4) is actually closer to 
what I had in mind (was thinking of a flag for future extension instead 
of bool). But the document has to make it very clear that the use of 
clean_map is limited to backward compatibility for old behavior, and new 
driver should not bother to implement (as it violates the 
.set_map/.dma_map IOMMU API).

Thanks,
-Siwei

>
> Siwei, Eugenio, what's your opinion here?
>
> Thanks
>
>> Thanks,
>> -Siwei
>>
>>>> }
>>>>
>>>> Did you see any issue with VDUSE in this case?
>>>>
>>>>> But this is not the the point I was making. I think if you agree this is
>>>>> purely buggy driver implementation of its own, we should try to isolate
>>>>> this buggy behavior to individual driver rather than overload vhost-vdpa
>>>>> or vdpa core's role to help implement the emulation of broken driver
>>>>> behavior.
>>>> As I pointed out, if it is not noticeable in the userspace, that's
>>>> fine but it's not.
>>>>
>>>>> I don't get why .reset is special here, the abuse of .reset to
>>>>> manipulate mapping could also happen in other IOMMU unrelated driver
>>>>> entries like in .suspend, or in queue_reset.
>>>> Who can abuse reset here? It is totally under the control of
>>>> vhost-vDPA and it's not visible to uAPI. And we can fully control the
>>>> behaviour of vhost-vDPA.
>>>>
>>>>> If someday userspace is
>>>>> found coded around similar buggy driver implementation in other driver
>>>>> ops, do we want to follow and duplicate the same emulation in vdpa core
>>>>> as the precedent is already set here around .reset?
>>>> I think so, have you seen the links I give you? If you want to go
>>>> through the one from Linus thread[1], you can see the one that unbreak
>>>> virtio-IOMMU[2]:
>>>>
>>>> 1) Someday, we spot invalidate with size 0 is a bug
>>>> 2) We fix this bug by not allowing this
>>>> 3) But virtio-IOMMU userspace find that size 0 actually clean all the
>>>> IOTLB so it depends on the behaviour
>>>> 4) So the virtio-IOMMU userspace find it can't work after 2)
>>>> 5) Then we recover the behaviour before 2) via [2]
>>>>
>>>> Another example is the IOTLB_MSG_V2, V1 suffers from in-stable ABI in
>>>> 32bit archs, most of the userspace survives since it never runs on
>>>> 32bit archs. The fix is to introduce a V2 but we will stick to V1 by
>>>> default if V2 is not acknowledged by the userspace.
>>>>
>>>> I think the above 2 examples are sufficient for us to understand the
>>>> case. If not, I can help to clarify more since I'm involved in those 2
>>>> fixes.
>>>>
>>>>> The buggy driver can fail in a lot of other ways indefinitely during
>>>>> reset, if there's a buggy driver that's already broken the way as how it
>>>>> is and happens to survive with all userspace apps, we just don't care
>>>>> and let it be.
>>>> Without IOTLB_PRESIST it doesn't break. With IOTLB_PERSIST and if the
>>>> reset_map() is done unconditionally, it can break. That's my point.
>>>>
>>>>> There's no way we can enumerate all those buggy behaviors
>>>>> in .reset_map itself, it's overloading that driver API too much.
>>>> If it is not noticeable by userspace, we can do any fix at will. But
>>>> it is not, we don't have another choice. Especially considering the
>>>> cost is rather low.
>>>>
>>>>>>> Second, IOTLB_PERSIST is needed but not sufficient. Due to lack of
>>>>>>> backend feature negotiation in parent driver, if vhost-vdpa has to
>>>>>>> provide the old-behaviour emulation for compatibility on driver's
>>>>>>> behalf, it needs to be done per-driver basis. There could be good
>>>>>>> on-chip or vendor IOMMU implementation which doesn't clear the IOTLB in
>>>>>>> .reset, and vendor specific IOMMU doesn't have to provide .reset_map,
>>>>>> Then we just don't offer IOTLB_PRESIST, isn't this by design?
>>>>> Think about the vduse case, it can work with DMA ops directly so doesn't
>>>>> have to implement .reset_map, unless for some specific good reason.
>>>>> Because it's a conforming and valid/good driver implementation, we may
>>>>> still allow it to advertise IOTLB_PERSIST to userspace.
>>>> I would like to know why this can't work in this case:
>>>>
>>>> config->reset()
>>>> if (IOTLB_PERSIST is not set) {
>>>>       if (config->reset_map)
>>>>             config->reset_map()
>>>> }
>>>>
>>>>> Which belongs to
>>>>> the 3rd bullet below:
>>>>>
>>>>> https://lore.kernel.org/virtualization/1696928580-7520-4-git-send-email-si-wei.liu@oracle.com/
>>>>>
>>>>> There are 3 cases that backend may claim this feature bit on:
>>>>>
>>>>> - parent device that has to work with platform IOMMU
>>>>> - parent device with on-chip IOMMU that has the expected
>>>>>      .reset_map support in driver
>>>>> - parent device with vendor specific IOMMU implementation
>>>>>      that explicitly declares the specific backend feature
>>>>>
>>>>>>> we
>>>>>>> should allow these good driver implementations rather than
>>>>>>> unconditionally stick to some specific problematic behavior for every
>>>>>>> other good driver.
>>>>>> Then you can force reset_map() with set_map() that is what I suggest
>>>>>> in another thread, no?
>>>>> This is exactly what I was afraid of that broken behavior emulation may
>>>>> become a dangerous slippery slope - in principle we should encourage
>>>>> good driver implementation, as they can work totally fine with older
>>>>> userspace. Why do they have to bother emulating broken behavior just
>>>>> because some other driver's misbehaving?
>>>> Please read the link [1], Linus has explained it.
>>>>
>>>>> And what's the boundary for
>>>>> this hack, do drivers backed by platform IOMMU even have to emulate (if
>>>>> not why not, and is there substantial difference in between)?
>>>> The boundary is whether the behaviour change could be noticed but
>>>> userspace. And I've shown you it's not a burden with the pseudo codes.
>>>> If not, please explain why.
>>>>
>>>>> After
>>>>> getting through all of this, do you still believe everything is just as
>>>>> easy and simple as what thought to be?
>>>> The truth is that bugs exist everywhere. We can't promise there's no
>>>> bug when developing an uAPI or subsystem. For kernel code, the bug
>>>> that touches uAPI might be fixed in a way that doesn't break existing
>>>> userspace. If you look at how downstream to maintain kABI, you will be
>>>> supersized furtherly.
>>>>
>>>>> Btw, I thought I was expecting but still haven't got the clear answers
>>>>> to what was the goal to do all this, we spent a lot of time trying to
>>>>> unbreak userspace,
>>>> The code is pretty simple. But yes, the time spent on justifying it
>>>> might take some time. That's the community. People need time to
>>>> understand each other's points.
>>>>
>>>>> but looks to me as if we were trying every possible
>>>>> way to break userspace
>>>> How could my suggestions break a userspace?
>>>>
>>>>> or try to approximate to the same brokenness
>>>>> mlx5_vdpa may have caused to the userspace. What we will get eventually
>>>>> from these lengthy discussions?
>>>> Siwei, I'd really suggest you read the link I gave you. You may get
>>>> the answer. What's more, It doesn't cost too much then we know for
>>>> sure there would not be any issue, why not choose the hard way?
>>>>
>>>>> On the other hand, if you think it from
>>>>> vhost-vdpa user perspective, you'll clearly see there's just a couple of
>>>>> ways to unbreak userspace from the internal broken map which is out of
>>>>> sync with vhost-vdpa iotlb after device reset.
>>>> Patches are more than welcomed.
>>>>
>>>>> If this brokenness was
>>>>> something universally done from the vhost-vdpa layer itself, I'd feel
>>>>> it's more of a shared problem, but this is not the case I see it here.
>>>>> While the long standing mlx5_vdpa/vdpa_sim issue is 100% misuse of
>>>>> .reset op in a wrong way per IOMMU API definition. Why leaving this
>>>>> discrepancy to the individual driver is not even an option, I'm still
>>>>> not sure?
>>>> Sorry? I start with a switch in the driver, and then I try to avoid
>>>> that. And it seems you don't want a burden on the driver as well.
>>>> Where did you see I say we can't do that in the driver? What I
>>>> disagree with is to use a module parameter.
>>>>
>>>> Even if I fail, it doesn't mean we can't do that in the driver code.
>>>> If you read the link[1] you can see the offending commit is a change
>>>> in uvcvideo driver.
>>>>
>>>> Thanks
>>>>
>>>>> Thanks,
>>>>> -Siwei
>>>>>
>>>>>>> Then we need a set of device flags (backend_features
>>>>>>> bit again?) to indicate the specific driver needs upper layer's help on
>>>>>>> old-behaviour emulation.
>>>>>>>
>>>>>>> Last but not least, I'm not sure how to properly emulate
>>>>>>> reset_vendor_mappings() from vhost-vdpa layer. If a vendor driver has no
>>>>>>> .reset_map op implemented, or if .reset_map has a slightly different
>>>>>>> implementation than what it used to reset the iotlb in the .reset op,
>>>>>> See above, for reset_vendor_mappings() I meant config->reset_map() exactly.
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>> then this either becomes effectively dead code if no one ends up using,
>>>>>>> or the vhost-vdpa emulation is helpless and limited in scope, unable to
>>>>>>> cover all the cases.
>>>>>>>
>>>>>>> ----------------%<----------------%<----------------
>>>>>>>

