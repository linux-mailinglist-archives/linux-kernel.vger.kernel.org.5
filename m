Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D717D898B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbjJZUOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjJZUOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:14:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8C0129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:14:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QJsVqE003943;
        Thu, 26 Oct 2023 20:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6biP2bghA5AFh546xtxksb9gcEX6sM33FZRoVMzQ+Tg=;
 b=SDK2eQ9AwgntdeKN73Ge2GErF6yRYvASmsaoojWA34qyhuFg4o48yJng7Cn2+HG0nYDA
 Sym8IxM2mP99DlPLVe55d+mwVRTw5eugRm68v6VZVOYHNvw93W2aRABwwGWfpBw8pVn3
 61q0xupgEx3KGjSTfeI8M6crtB3LdKEAydXgNar0Gxa8Wjz6RAbXz7+gypio16OPsCXm
 rvOEg925GT7RpqzOc5VQB3OMIxwlq8QJ5OVA/6hzxOx5MWBPQiYloTrz6CoxTuc4IO6X
 UtVDy+c7AmrRS3EgT4UkAjzPQ+ERqqh31BZVurwsdxT5FJrSBHa7rGfhN+us1xk0/ytx Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx4tg3en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 20:13:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39QImm9f022955;
        Thu, 26 Oct 2023 20:13:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqhk1da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 20:13:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTm9Ikb211IelUae9kNs+MviHHdlHt7GlCWrgrqMo/J9uTbuT2ZNjUGpCHtG0NvwhxCQDJdD+L2DW6ZoItw4pZ4b466du9saYHo3lxy3g/Qjc/r15TEjGTzCPgHaImGFOtdujFDPkEVJczLGy1+kS0BXX7V4fmWZ3stk+ZDTxH5+wmutIgsXzx3YgvttSiVPlZsrsgq9nwLWLBqZC/QZMECopMB8PJoRsZAmRWLvdDLaDBrSLd8S5pcaZQ0L+36RaDe4eZRAhj/Sqk0tZp1z7nsLc+lipYQhV+wvfMECMyw8ESO9zowQpA0O13PRRxQABfpj/nn393q6vJqYhr3+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6biP2bghA5AFh546xtxksb9gcEX6sM33FZRoVMzQ+Tg=;
 b=UEHPNaTP28E0XmTnjaA3TR1myQpVOmu6+wVZS3Y1ridKgvv43YbRVOEkoHtALFBar2UY99PQIzgQKrmAU4ICYUAKvRHrtmo2eBSIVV+nEs89cY8HsbDAsX/OFXd4SYfiAjQpxawuV+dVYTklHjObqFjIax+qXcqaYJr1OyHrTbsHh7oOv6SVvl413HA4FZpU2ADhDSXO3z+q8928oEbY+dmb3WbuPhPsHWWqb5eMw5u9YxmF2iU+XZ+qdS7Hix2ROOoHqm2PdzoN9/8pqvQCcbldMBLVEAj/Wr8eVzDZco3XX5foEITsZ7D53nX/kS2j4rIspBot3/y8Sc/sJU+QJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6biP2bghA5AFh546xtxksb9gcEX6sM33FZRoVMzQ+Tg=;
 b=CBBn1LvjSfAqq2wv9bRDlhCGAE2yC8cpe1o1gMxrptRkXHIr8aaHDAB0re5U8nXp7iHUS+gJwi9E1SzdhXo223Hk5S2bqnL/xvaQGy3n6xvHMrpvjX1676PNnSItL0xFd2Oj6LrFkB66jJh7sp4huBksjfIA0zo2L2iOF+LoYZg=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB6016.namprd10.prod.outlook.com (2603:10b6:8:ab::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.31; Thu, 26 Oct 2023 20:13:55 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 20:13:55 +0000
Message-ID: <389942ac-962f-4198-b87a-14bd6dd3e188@oracle.com>
Date:   Thu, 26 Oct 2023 16:13:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] vdpa/mlx5: preserve CVQ vringh index
Content-Language: en-US
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1698351075-415989-1-git-send-email-steven.sistare@oracle.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1698351075-415989-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::34) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6f3289-020d-4c4e-5b0f-08dbd660147e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVzH32x0mbjUxUh9jYkPj3HlEsKO0qEdVKqExnuXBOWGA1YmQrp70tLLlGcoGT/4tzAQCSJC5V+HRbwEo4HbOn/krsVo9P+LrEMQp1E47aJdTC6y2qZW2eGtHqAWJmWHGqFp9wg6l9aYNqEIRjnNRwhN6I5WtZmoGCCdq6RUA2HHB4Wdn8q/2rDDp5TRBC3X8pHFeXgwMpz2sO5JptDkmKwwGyjcbNp0q7rjksQGXeFYsvX5Fac1Q9ML1rrkFgPOiSWq1SPSbLO1vr232PTDxeoPw6N2Ib7+db4o3Qy/nz0FAhdXyGBNYw/qjpXtukYO7rUHb/j9xfpur4ljjKg2oeVj1oDtJe0lfNGASDzT3yko05inLCYROICA7mmG7aeBjgX8FaGexpjYXHbKTJQL5xHK0/Iaod2t/nBOyaHaElAqinLW9vj4gdPiFDZvtYBtcoCfwvGSDnCL9YwvXht2mCCfifWgPJrxXOrbntpKF8JgOO1KECn/ybMWomDSWo8+ZauxuakGYa/hrMbjqgG8cWIlI9n9FH6p2frZtONpjvVBXtH2c0MrE+D4dqioZNgz7Ry1TXDjf1zj0FHJmQwq18Pk//dqKReRbSJXv/p08a7Ag4tk0h56mCP1OGpqHJospeorHtmYwX/pMXWUQlstkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(66946007)(2906002)(38100700002)(44832011)(2616005)(66476007)(66556008)(41300700001)(6506007)(36916002)(316002)(6512007)(53546011)(6666004)(6486002)(478600001)(83380400001)(54906003)(4326008)(36756003)(5660300002)(31696002)(8676002)(8936002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFViZS9DYkJLYnI3UTdzcVVsY2ZyY05DUmk1UmdVT3FobGdRRHpiMWZxNE5Q?=
 =?utf-8?B?dy9ZbmlyYW9MbHpkRk92MkVCMjJmQ0VWR3dqWTZZSjFqSXVIYUhERm94UGRS?=
 =?utf-8?B?UmxveWdkMytDY2FDT0Y1c2l4b3JlbFhxUWo5T0FRS1JTZ0dqK2xuanI1MkEy?=
 =?utf-8?B?TzVDMnk2eEVSL2RnaUY1TkdmNTlkSGU2Z0xNVEIwbk1TMXkxTmxIUGVzaGJy?=
 =?utf-8?B?UXh1cXp5U202V0t6cWpnSlZIWVNsQlFWdHpiOElvRTlGVjByVCt2YWYwSUxO?=
 =?utf-8?B?R3ZBNFRYMHBkUVZEMlpDaWlBbHZyNkQxSlFFaitYeVFVRDA3czNSZU9MMHdP?=
 =?utf-8?B?V0E2dWhJbFYzajJVSkVLUklDK2VMNUlsc2pCdkF1NHBtTHpFelNrQm1rNm9D?=
 =?utf-8?B?c3NLMXZxNzk3d21yWGttZkQ5KzI2bWhYNTVSNlc5WTZ1djVWS25GUGRDQm96?=
 =?utf-8?B?bnJXd0lKTHhBVW5mK3ZaVlU5dkVGcituOHJhc1E3cGgzZ0ZCa280YTZBTzFj?=
 =?utf-8?B?YzRVVC9QUmRZWWlJMTdzMnAyWFI3MWFBblY5WFFGSFR3YjdTM3lBUmlKejFJ?=
 =?utf-8?B?Nk00dG1HOWtMZDFULy9IREU1NnlkZW93WlkyTUdnbXJjNW15RllaNm9SYldT?=
 =?utf-8?B?N09ydFgrOGdTcDdQdTdWQTlJQnJBRlFkQ0xoU0lMaCtQTkgyNUlMWVNjM0Qy?=
 =?utf-8?B?bWdQbEc5dFZ2UTd3NFdvVGhhOWNzZm45ZXRaWEgvL2ZUZnd0dTZRa3FMcyt0?=
 =?utf-8?B?ak5meFZvQjdmUEw1NW50MlRoQzNhbGRUckZJTGRmNThPd1dEc2loRVBoZXg3?=
 =?utf-8?B?bWd0dThFdTd1cS9JM00xdUt0dllPanpiVzlNZkgwVnRsbS94Vk40OUx5Z3hw?=
 =?utf-8?B?TEJha0xueXRTNFF2OVdqZXBDanh5UG9QM0hyMk9GZjdjMUFzOE9VU3ZtTFZ5?=
 =?utf-8?B?SlVxVlh3di91enI1QXBQcExoQUowYlFWUnhyNzUxb1JFYjV2a2pkc0ZieWhD?=
 =?utf-8?B?Tm1pWndoRjR0c2w0S3lCQkwyb21nbzdnbE9XV2NsTTdtenNIbnFXTkxtbElU?=
 =?utf-8?B?dWtTTU82elowUkh3MjhraG45VTBUVDIyc25HeERkdjZ2WHZuRjNBVWJHVENv?=
 =?utf-8?B?WWR6ZWgyMkExTDJEZ2tyMG0xc0h0akd6Z1U5am53MzI5ZGF2MTEvYVk1Z2Zl?=
 =?utf-8?B?WVVlQmJtRXRIdkVvb2VXcklWVmtPcUl3bjFVNWlxVHZBcEJ0UG5hckdmYXhx?=
 =?utf-8?B?SmJML3A0UHFDTDhhZmFJbkd2eER3RmlwSzdwS3ppUGpGMEVUYTI0M1VVZS9k?=
 =?utf-8?B?YkJVSzAzMXROdS83ZklsaktPeEEvNzJJQzZ3OFlqdTZrWVBkQzQ0ZjkwaXA4?=
 =?utf-8?B?azF2MEhURUVMQWttQ2Vad3l4Ymw0TElqaHV1VUc3eVczbTMreld2d3MwUlE1?=
 =?utf-8?B?ekQ2RzBUWVpiSmR3aVpwOUR5V2hSdEdmZjJ1V29wamtqTDArb012S1ptckRF?=
 =?utf-8?B?bGRHMCtKejJrQW1CblFaTmpsb3NuT05pYmRjbWJ2VEdMMnFranZ0K2U0aUY1?=
 =?utf-8?B?Q3NOQlRtNzdqN1ozdFdkWXUwOXVnakFBUkZBSUhHZlZRUmlBYmlGd3I4NUoz?=
 =?utf-8?B?SXdFVk0rQ3RqbW1pZlYyVExqQ29WK3VoUS9vOUJmWGFHTVB2RkRkREMwLzdq?=
 =?utf-8?B?dDdONmhWYkwrMllkMHh1Q3VOSGhyNlc2bFFiSEQxQ1dFdk04eFpuZ1NLZVEz?=
 =?utf-8?B?OW9JcVRUem0yRlVVay9UN0dxVURaRkJqMjhVOHNJanJRRCtwRFh0ZkUzV3V4?=
 =?utf-8?B?YXQrZmNUbUQ3TUxBWGpwaWNVZ0ZqM05Rd3ZqRm54cEVGT2xnUnQ0MFk4ZHp4?=
 =?utf-8?B?UThuZWZaakRndlFuazhXRitiTWVmSi9PU0MxZFpJaGwxTDJJUGZuZkNiYVY0?=
 =?utf-8?B?NEZwenJHaXZpRnNoRnpOZVRTNjMvMkJkN1VEYzhxaXdGWHN2c2ZGNjdEL292?=
 =?utf-8?B?dWlLQWFvTnptQUY3MDRicWVSVnFJdHVyK1ViYmlFclNCNHJzMmN2Z0NCSXpF?=
 =?utf-8?B?bW9XbVE4elgxaGlDcTVSSmhRL2hYdFRXRTVNL0IvRXNYbUJyRWlyT1lSZXhV?=
 =?utf-8?B?dFdhYTRDTWNobWxUck1VNEk2K0cwUllCY214L0dMeXFhMHdNT1h3RXhaZUhL?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ejVlS3dRV1hxbkdFTW5WZE4zdWh6c05kSXYvUkhWNk5IYWJSQVJRa1RpOWR1?=
 =?utf-8?B?M3QzVUJBVGUwbEZXdmNGN29DdEVZL3kzbG0vRjNEeWJWeURBb041M09BOWtL?=
 =?utf-8?B?dFdzOXhaNjg4dXhSVzhWZ1lROGNheng3aDFYNmlmYXd3VEZLTWxYTGpYZ09M?=
 =?utf-8?B?WStCV3o5NDVLVWdJaXdQNFU4NXVPaXZ6Qkl6V3l6Mk1OajlKSW0yRVp2Sm15?=
 =?utf-8?B?MHRQelFaRlk3SkV4YklMWEhydnkvaVpoR2hmV0VXLytmbjE3cGVaN24vQ05n?=
 =?utf-8?B?T2I1SlhnOVYvTE4wYk5tQXdRNUIwQm5rcldxVzRZdk11NlZtMWRjUHdWNTk0?=
 =?utf-8?B?UW8ra1RCSHZJcVd2VnlKNVZJS1MwYzl4NUNRcStFOGwwMVBYQXZJemV6eXU2?=
 =?utf-8?B?ellPY3JTNS9MTjU2dVp4c0hwRHJVYVIxZVhZclhoWXY1UUVzTHVuS2svVGVp?=
 =?utf-8?B?ekRxdW5PSDhTeHNWNnV6aXZWdmZ6aTk0TkU3K1NhNm9xU2UxQUxrS3hIaTUw?=
 =?utf-8?B?bnZ5RGp3YkFJVDhlUVIvaCtQUThPdm5qV0htMVBwZFV6TE1JMGZSN05ZQyt0?=
 =?utf-8?B?d2plZmFiYjJhVVZ4Z2JjRjd0TmI2cUkxaFBBbkd2clFZRVBtWHQ2cFIzZFY0?=
 =?utf-8?B?Z2hobTJBRGN2aGx2SFRzTWpVOFNoTTRlcVA0YjlQU3hpOGhRU1hFZDlLbEt1?=
 =?utf-8?B?aHRIWG9nRUhYVWVyTWxiYTBjVHJFWHBHYzZxRTBnSjFtRGxoK2hLbUx3Q0JC?=
 =?utf-8?B?MDVEOWxiMFlxazA0UzNoTU9MeHpZWkRKTkxha3FicWtuS3dyM05aOFdRVkVW?=
 =?utf-8?B?c2g2dyszL3lQdVd5UUtDVEJRVFB2bHVYUk55Z0c4YVlEVjFwZGVBK2YxWVpI?=
 =?utf-8?B?cmlNQ1hPZmwrcEJLUnRLNHVNNmw4MC9ZWUpxU0srWWlJWjg2UlduK3ByeGxo?=
 =?utf-8?B?SnorenJudGg3MmlhU3RxaG1VR0ZSYjNrRENNTHVlQ1dFS0EwVFlUM0twRzk4?=
 =?utf-8?B?U2s0bGxkZEZiZ3ZpL2FRY3MzNFdnVTNTUmxqUGV1eUZrcW9PZzk3WW50WU9L?=
 =?utf-8?B?RTk3aFIrQUxuVHlSQTZ3eFg0dU84WUkrNmt0TjY5SzVJT1NFY2JRQTBURXZB?=
 =?utf-8?B?UGFGeGtvVTBhYllDSkNlUE5qMWpFZVZLK3Fna0VzaFhkRWVIajJqUHpsYkNm?=
 =?utf-8?B?eGMvRGlHU28zUFRkMldHYkNQNWoreFp4Q2I5SGwxdXBhVm1CR2pYRml2R3ZL?=
 =?utf-8?Q?6iFJU5sz3CcWumc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6f3289-020d-4c4e-5b0f-08dbd660147e
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 20:13:55.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2it8zo3KOXQdiruZeipUsR7Envi617enVFiaDHT9lkfCV3lSamoPQBkxBHOrxzx6Fl+wb0VHnWvIeXXIeXeUHUWQ5v/HymBBs4Ok/arx8z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_19,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310260175
X-Proofpoint-GUID: SPkEtEctOZL1EBZJvvH9RKP5qEjKyS9Z
X-Proofpoint-ORIG-GUID: SPkEtEctOZL1EBZJvvH9RKP5qEjKyS9Z
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/2023 4:11 PM, Steve Sistare wrote:
> mlx5_vdpa does not preserve userland's view of vring base for the control
> queue in the following sequence:
> 
> ioctl VHOST_SET_VRING_BASE
> ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
>   mlx5_vdpa_set_status()
>     setup_cvq_vring()
>       vringh_init_iotlb()
>         vringh_init_kern()
>           vrh->last_avail_idx = 0;
> ioctl VHOST_GET_VRING_BASE
> 
> To fix, restore the value of cvq->vring.last_avail_idx after calling
> vringh_init_iotlb.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

This is a resend, I forgot to cc myself the first time.

I don't know if we expect vring_base to be preserved after reset, because the
uapi comments say nothing about it.  mlx5 *does* preserve base across reset
for the the data vq's, but perhaps that is an accident of the implementation.

I posted this patch to perhaps avoid future problems. The bug(?) bit me while
developing with an older version of qemu, and I can work around it in qemu
code.  Further, the latest version of qemu always enables svq for the cvq
and is not affected by this behavior AFAICT.

- Steve
