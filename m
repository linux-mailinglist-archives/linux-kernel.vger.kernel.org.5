Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426C377D685
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbjHOXKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240540AbjHOXKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:10:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855FDBC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:10:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FMlwU0001011;
        Tue, 15 Aug 2023 23:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8/23uyOJjF3ya8vBOv9xhvR16W44aB4YO0qRLq2aZik=;
 b=iEADdVlCSR5vu1DtRrW8LAs0qgBI1fnkoMKi1RRGHGJ0c1Dqs3zT+8G3jcOTWf3Y/Bgu
 WJ3L3elf082HYHYSoL8cv9L/RYjhrlE8X+GKpbwC827sJNpmnObUPX+sg1cL6TYEZWra
 LGijbnZhaVUnQ0DDTCBbr5NTJDP0efleUXcyWnKfWNakx1W49hsltX9nhcBvBBBjb2Ps
 3/6BNd5bvdP/1HGXOukcF68dcpRPx0EKdnh2qwbP5xsBr92nFMElFyIumd+CjBQ3CrB8
 F2+qYPashov2WvSpkH5tmw3/3F9XgXiOcxstUjv/lte3D+z+tArH026jxpNLSLvuXKfU sQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfntbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 23:10:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FLl6Fx003700;
        Tue, 15 Aug 2023 23:10:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexyjed4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 23:10:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=er75XkAuGjJiRDz2+00GldU6ihILqI3iYNdoTL33UtUQOwzoVWvCPssgAdwInG5mmgFCknlQOT6jOOsCfw9P3hdIkstCMcbT/MBBqGDdOecdStUqTqCleEYIbSvFcwMIYErBiBEIUpyCCBFw5XmP46quCFcGj8MsUknZStXb9a2xdKBWK6//Dn2sDub55NCs/+M7bm+fFukDJcbjxOezIM6ublhO0dbMiQL88GnEKRWTAV3/UlcPNckrGPpax0Gu7ow9Zn/ACsTm/6Fj7M2tF4Apu603CMzNfO3LGNERvEo8H2xsq+x2phrsFg5FX1xs30rtod/mDblYvJ+MTopDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/23uyOJjF3ya8vBOv9xhvR16W44aB4YO0qRLq2aZik=;
 b=B6Uu2gRKMlaTn7v0MdyP2+qWn+QCZYD4oWoOSSqTBRYlA2Urb3ZwnVO1IB2ivI90BeXZMf2ffZyDYTgOQK6n02owf8PSHHJ3+nfKM3NFQeWlZXJjxjkHQ1O3tiDFp/QUOf37BoJW6LWiDdBs6iaICkI1Bi8XvJmww0fZdPXNhFb3ov/L379o/p/cVgIJITIl5JRJC86Ah0qrQKHuKrnSxHlN+6F+uYfnk9v4bVPrmLSvSGzaVEtBwWJCHeMGF0leZnfuh0SpT3E3EelU+8WwtYTSuQ32V82YbHMW1fLPQFVEE1tnkZEwaoKSn+6QHspm3Tu66kq4W18juDVy0CY4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/23uyOJjF3ya8vBOv9xhvR16W44aB4YO0qRLq2aZik=;
 b=wPWrcEeBksM8ipQjPx/5Um1yz/yoQXccibrBSyUVmdJPP3xaLQW8riVpWJb2VFEo8ZcsfH/bK/vVHDwJk+ObFS5vFIWZDhDUN8CQCFkMXpDQBu4CdG16pyv+0TgODPXaDE9ilLPfAczixKS6QgJo3e2ARORWpdOH0/bQt45RrdE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH7PR10MB6602.namprd10.prod.outlook.com (2603:10b6:510:206::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 23:09:58 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 23:09:58 +0000
Message-ID: <19466c8d-7e61-c95d-4ecc-130bd9920483@oracle.com>
Date:   Tue, 15 Aug 2023 16:09:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 3/4] vhost-vdpa: should restore 1:1 dma mapping before
 detaching driver
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvrg0qA6=E-5WJL79XAdO3SpSr=rumsyYMW4a-7tZkD8Q@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvrg0qA6=E-5WJL79XAdO3SpSr=rumsyYMW4a-7tZkD8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0064.namprd17.prod.outlook.com
 (2603:10b6:a03:167::41) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH7PR10MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 5addcbaa-014a-49f7-64f1-08db9de4be79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0YdqtRz5yEfYqPByhzU8okSAX8FB7rexS3wr7rCIyGG2IsZ712wo7NW8IsDVdvZmeNE0kfMcHzwf8O7Kau50S41yCvy1KEzClkRzoU4RRmZuYW8AUEw8xW4puVhdMINdwKIfU/BjCPMfSwTSZqyX1jj9WHN3FH6tvrR68Wl+qKE+kW8b2GDPAZZnqI+88Fwi871jrMcVfir583IOaxkm9TQJnnKtfzBNr8xsXsGyKwWO2wO8Q6mNU0XQxYiRk7Lv8y4Kp64whpI+5yqE4XiwNXduk80JlEMuTLiVjuAxu3O9KG4RGd2ypy4HVrciv1LCGNVhXeMiUIuLqD1tzTpi72V5iouDOqRIbN3qed5QmEAyc+9mXn4rRJJLpSSYtn4Itc5TAUwQBjrA6dtRKn0wFprKBS4Iwp00FkrBXjW9sD1xsqvyFxLON5VQr3mHsF3r7b1AV2FMGdfPG9NP8kd/BACuyrrGiju78+Xdkcom7d5Ez/QtawbWwuBtTGwdxaPN6OejYvO95YSXvV5BJYiksWR58R/ILImfb4jxh9TRCh5axATrHsivTnZdHYbLK5jXybFoMlu3uIVvi1pezVxxIS6d/PHmuox0gM+X451eYJRm+8r6O/bb5UudJXz6VBdAcP+R+vDBowVYgMf6Y9N1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(186009)(1800799009)(478600001)(86362001)(6486002)(2616005)(36756003)(31686004)(31696002)(6506007)(66476007)(5660300002)(66556008)(66946007)(316002)(41300700001)(6916009)(53546011)(26005)(6666004)(38100700002)(36916002)(83380400001)(4326008)(2906002)(8936002)(8676002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWUxa2k1dFVNd0U4YU0yZmJwdzZOT3VtNndGYm11cTRwcnhaL1BsU09yNGYw?=
 =?utf-8?B?aVNzR0pQb3VsdEF3eXN5WWsyMFM3T2gwdjg0dVNuVk9vTllldU5CS1ZDUUxL?=
 =?utf-8?B?N1lYZUdGRStyRFdYb24wQkNwLzJCY1dVVm1lM1NmOGVlYlNRdXV5dTNWWkZU?=
 =?utf-8?B?R2dKbkxLWGpCSFIrSStqdmZsMTN2VlBuMDk4dU4wVkFxczExWTFFdERSOGs5?=
 =?utf-8?B?c2M3S25UWk9rKzR4OXhFNzNnNEc3NGNyNDI0OUsyNy9iTXd2N3ZKNVhGMm9E?=
 =?utf-8?B?YUwwZDBqaUNkdjJ6VEwrN2tKamR2dXJocDdscHNMcjkwSlp6OWV3ZkIxd1Z1?=
 =?utf-8?B?S0xkUVhjeU1obmlmVzI5bjhTalZvVmlwVVFTMEdaeTBMOVhRL0pIVTdQYW5U?=
 =?utf-8?B?NWI0cTloYThyOVBpcml3STk4d1pjVGNWenNKK1g0WTVnMzJUbXJZYWJSSW04?=
 =?utf-8?B?WC9Uc3JkQXRLQ3hwMnRDZzVRSXBvVCtnN2lNOGlyWWhSNmhsc0tFd014NHM1?=
 =?utf-8?B?ZzRLM0c3YXNobVVqVjNOd25PaWU0VHhYSCtYemF6WEp0cXBqZ1VnTi9pNnF6?=
 =?utf-8?B?T0wwczM3b1ZtdGFDS0lwajdHamdCR2hHeUo0TFBJRWFCWXNGQytlV1gxaW5K?=
 =?utf-8?B?bE9tbjZ4Q1c4cTE0Ky9xeTFwTDZrYjQyT1ZmUGlqbC9WYXpteUV3cm5uUEg0?=
 =?utf-8?B?bGk4ai9SemJIU2x2TlMvTU1NNmQyV2ZsaU45OVJxMHNaT3pWZm5RT3lYaTZp?=
 =?utf-8?B?Qmt0dWRxY0t1ZFJuNjZCN1hab0c3L3E5QnV1NUh6RHpCTzBGV2FrUFlrT1cz?=
 =?utf-8?B?dGVBTHYxaGFWY0Vvd1MydlQ3SFBJUWZCMytIR3Bsc1FLYjBqMVRseVIzenZW?=
 =?utf-8?B?eXRBejFqR1NKcFJncmQxZnE5WkpRS2Y4bjF0Q2REWHVIRC9pdjhxaWRFZzBR?=
 =?utf-8?B?UWEwNWdlRUEwSzdvdnZ6dWlDQzNQVXdUaHZFWDgxTHF3MUpwZmZ1a1BRTWVG?=
 =?utf-8?B?Y1RJbmRHWHQxWUc5N3ZWSjZZanRBd1lBSzRGMU9RZlhuNWVOeXVia1NRVDRs?=
 =?utf-8?B?M015dWJQcTlVdEx4eHkyZDBSK3pQbXR6TUN5blk1UEJCUWV2ZHVBNnNaejR4?=
 =?utf-8?B?RG94a0V0Q3BrVFdNdmxkQ0IwN1dxTjlQNy9DaFJnaGU1b3hUcWs3N3o5UWRE?=
 =?utf-8?B?eXFadFZ0WGZrS1hQUHc0dkk2Ty9Ca3FqeHU4NlpzR1AvNzFUUGd0QnRLU3Bu?=
 =?utf-8?B?eCsvLzdIWEkzLytabWVEamFRU040WTgrMnYxS3ZyWStYcUQrOGxidy9VYUFX?=
 =?utf-8?B?a3AxbVFOVFNPc3QrSmtZeDhOaHZTYXJ1M282T08xRWpUQXFLZFVZckF2UFQ5?=
 =?utf-8?B?MXVxcjB3T3ZQWGFGL29FNk9naDdvdExsVGdQdDMwZ1l0RXp4TXUvQlJXSGdH?=
 =?utf-8?B?WDZWdm42alp2ZlFpdkRLa0F3VU1zZ0plVEZxR2dJbjE4U0t5SWpOUGllQy8w?=
 =?utf-8?B?RW9FeERwMmZNQUNFWXFVMUpGdkVNNEp0TXg3YXZ2U29xSGRMVkJQNldYVHBi?=
 =?utf-8?B?K3MxZis5OGJaT3lXZ3B2bkI0b0s3cCs4ci9NN1hrNDFTTzJ3WCtTRXdJbHZR?=
 =?utf-8?B?dC81dW02OVdKdEhWODY5OFlVeXVzS2wzN1lkelhWV2lZUkFubFBYT0N2aWpK?=
 =?utf-8?B?a0M0N1VjeTlRSi9sb2E1Vlp0TS9OSHFwcXNXOUJjS05Ia2ZKRXI5Ymw4Vm0r?=
 =?utf-8?B?NkpoREdXQlNEUmFGbEcvQ256elhTSDZkVXZxOVNleWhkN2ZlTEhXMnRGdTd4?=
 =?utf-8?B?UmtJRS8rbE9kSlF6UGMzQ2UxZTM5YjYzTjdiMVNUUUtkd25SRExROXJTT2Jo?=
 =?utf-8?B?TEM3N3hSQ01xejRsaGMraU5ud1dQSEZMQksxK3NGL2hBeWRtejl5Wm5DYUps?=
 =?utf-8?B?MGNsTVM2LzR5NHY5ckpoc2Rpd0FuMmQyUFNHK2VyWm9TdnZ6eHBpeHc1Yng1?=
 =?utf-8?B?R05BZktDcG5wNmlsaXpQMHRqNXhReEdoRG5tdFZKTElhR0x5SXQxbVBXRzZq?=
 =?utf-8?B?V01XZVJRbU9sQzZDcUwxbnI5R2Q0RHRpTjgzN1BoWWs3bHJpSkpKL1V3K0xi?=
 =?utf-8?Q?1Wjz4w/j5LGwDEcjxBNFXevJN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NDgvVGhRQmpuMXBtZXVpeVF1Z0RJZTVURGhxZ1p2VWNXWEdBc1UwMGFIYXZZ?=
 =?utf-8?B?emFudlBsZjkxZ3BremtXVm9YQXY1dmNlTWFaSjFFOGYvanhXS0pTcXQ5aHkv?=
 =?utf-8?B?QWlJcWIrRzJpd2l2NGdMaVM1cFk2WlNHVHlVSFpxQnBscnZxZ3dNa2piZG5k?=
 =?utf-8?B?WmQvd1NFbHR6TG9HcmN4VjV5V2lPMEFxNFBDMGJxR3owM3ExVmx5SEtjcVBR?=
 =?utf-8?B?dy8wcXZHUnZKK2VZSGlsZG9DNzBzZ0NibW5LMHlYWkJOZ09nbWFqa2NJRVl0?=
 =?utf-8?B?NTFqRGtGcFVWVnRYZ1RnK25qRXU1SThtLzdlckJqZkJCZHcxeWtxam11ckN1?=
 =?utf-8?B?aHJiU3oyZ0FqZGhkeGRZSkVTTE1HenNlQWthYVZrQ1MwajRpcitkb1VPeG11?=
 =?utf-8?B?c3Z5RGpPQTZWNFRWZldrODVZOExveU5tbzZYVVFVUVlZZjZ1UnM4Sk9JaFpP?=
 =?utf-8?B?YnhRRlJKL0xRODZEY1R3WXpzaTBBUGRnY3dXU2I1YlE1MTMybFR4b0hvS0Zi?=
 =?utf-8?B?R1RjbVdMUFdkR0RNTCtOVVFpcXZqaXhOdnp4ZnQ1VWJRUkRja0lyUmY3OEY1?=
 =?utf-8?B?MVVQMGo3eDJFTW9TUno4T1JqZUZwYlh2RUszQzVWdzhCU1dXZGZXZWJpMmxz?=
 =?utf-8?B?cmJTdmM3UXd3TFNoMXZoZFlVOEhsdzFkb0RHd3c3dXNlODlkUVRUeWFFckxT?=
 =?utf-8?B?Y2x5Y2crRU8zaHY4ekVNY3EzYzJDUXJpV3JVdW1YS3FlK3RHZ25QV0NwdW1F?=
 =?utf-8?B?alpHRVpBREU0RGEyTE5QeVZBSmpIMVBBdHJvQW1IRjlHRC9KeUpCOFpmRGpa?=
 =?utf-8?B?RFNFdUs2cVhYeFZucmlRUDJETTd1N2VhQmJGRktCY0ZZb096SG9BUHVqcC9F?=
 =?utf-8?B?cHM3SGRpRWJNVjFqSmg1MURhTXFPeGx3YnRZckszQkRIcm1vNEFIdVJHTVZl?=
 =?utf-8?B?Z3hsSE9kTGVCcUpRcUE3SDd6eXRtR0Q0TVlqR0NoTnlETnd5cnhnN2JJUlFI?=
 =?utf-8?B?OEtLdDNuMFFCUjJ2YnlWSzhBN05lRExrWUFDRG9Ba2hoNVp2TjVOTWx1bmJm?=
 =?utf-8?B?eWhQVll4Z2J0TTgwYTQ4NjBmQXFYbERmTkdMaUV0Q1poM1BQV0dINnU0TkQz?=
 =?utf-8?B?MEhlUEQ3YldGci9NVTNCKzQ4UXZPaHlURU5wSnRxT3lQQUxIRWpJVldmeXpE?=
 =?utf-8?B?N0dYVTErcDRwRVBPUko2UXhiOGtDVnJmblFxREZMV3FwTXdIbnJPTUcrNGhV?=
 =?utf-8?Q?IAUA3pU+EWU5yDa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5addcbaa-014a-49f7-64f1-08db9de4be79
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 23:09:57.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRDTRvxydGve7Ydgla6i5hdNvY1d8kEp6UiZHk7xKj0WkbTrF4POshF1sHNW4YMVlZJQ1PIV9tN28QUG8N1HPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150209
X-Proofpoint-ORIG-GUID: CmfDYp40ojgSZ20FRJeyYRBpGkDGCYD-
X-Proofpoint-GUID: CmfDYp40ojgSZ20FRJeyYRBpGkDGCYD-
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/2023 7:32 PM, Jason Wang wrote:
> On Tue, Aug 15, 2023 at 9:45 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vhost/vdpa.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index b43e868..62b0a01 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_alloc_as(struct vhost_vdpa *v,
>>          return vhost_vdpa_alloc_as(v, asid);
>>   }
>>
>> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
>> +{
>> +       struct vdpa_device *vdpa = v->vdpa;
>> +       const struct vdpa_config_ops *ops = vdpa->config;
>> +
>> +       if (ops->reset_map)
>> +               ops->reset_map(vdpa, asid);
>> +}
>> +
>>   static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>   {
>>          struct vhost_vdpa_as *as = asid_to_as(v, asid);
>> @@ -140,6 +149,14 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>
>>          hlist_del(&as->hash_link);
>>          vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
>> +       /*
>> +        * Devices with on-chip IOMMU need to restore iotlb
>> +        * to 1:1 identity mapping before vhost-vdpa is going
>> +        * to be removed and detached from the device. Give
>> +        * them a chance to do so, as this cannot be done
>> +        * efficiently via the whole-range unmap call above.
>> +        */
> Same question as before, if 1:1 is restored and the userspace doesn't
> do any IOTLB updating. It looks like a security issue? (Assuming IOVA
> is PA)
This is already flawed independent of this series. It was introduced 
from the two commits I referenced earlier in the other thread. Today 
userspace is already able to do so with device reset and don't do any 
IOTLB update. This series don't get it worse nor make it better.

FWIW as said earlier, to address this security issue properly we 
probably should set up 1:1 DMA mapping in virtio_vdpa_probe() on demand, 
and tears it down at virtio_vdpa_release_dev(). Question is, was 
virtio-vdpa the only vdpa bus user that needs 1:1 DMA mapping, or it's 
the other way around that vhost-vdpa is the only exception among all 
vdpa bus drivers that don't want to start with 1:1 by default. This 
would help parent vdpa implementation for what kind of mapping it should 
start with upon creation.

Regards,
-Siwei



>
> Thanks
>
>> +       vhost_vdpa_reset_map(v, asid);
>>          kfree(as);
>>
>>          return 0;
>> --
>> 1.8.3.1
>>

