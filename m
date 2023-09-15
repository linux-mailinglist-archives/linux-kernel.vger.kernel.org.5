Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCF67A28D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbjIOU6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbjIOU5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:57:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817AA3C35;
        Fri, 15 Sep 2023 13:55:45 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FIf2xY018262;
        Fri, 15 Sep 2023 20:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+obZE1CkbmmqQGNq8pXlFR9LWdPlQ5//56SPa+berfU=;
 b=f1U1+D3y9vx8wqj4yiqxZz+p7nZ1DYqwB5HatrXhCoLqpTeFxkzhnD4hu4OEY+NE1KIv
 g2e6iO7TTxx4dBw0mZLfSj0/DLPyHbHVJDo3VB2lXHnfHHZ+dgVnX/vK/fwtYZSd9+A4
 wlir7ntiyf0VOGk9lFf6lYlMtczTKr0aq0b6jyLF2HpoJA4/tYvNwvnbwNJw49MPnuyp
 nBeKZBnXt/sruhY5Hf6b8LCjqFPURfYcanj0YIhOfa5e2NRatMx0AmDtL05J7uugVMlI
 reWNlW39vr/7wD2i4gLiIGvw68sSrwE+0G0tiDOecYBjT2eIRxDjkh/XlSrIADCVETh3 fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y9m0ju2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 20:55:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FKWF07028148;
        Fri, 15 Sep 2023 20:55:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5gw85b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 20:55:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oT/S1dcxL2F+QqzMtICeaeY56G1XDAlf57Z/hCu1fNJWPjmjWQ0LH5dsir3p7yjgeQy5gGE6Rr4TA5IQgAnRi9/gmm30qpb/hQyFq2909b9Y20PCboi6HVOBym4VkCd1vxW0wkPLRBu0LVCUVMoDf6Q5lQOmZsPI93Byc3fDj9v/zwr21DgCCtBB7EBHXTsl9Kbp15cNbwKXICCSnhj1XQxOVnUzuADvr2l0kOXhicIUYCNOFmBhGnuLGsd1WRlAabdzMi5/XxIfLzc1VZTDGK4auhcxnGkBKILBJ8xq2ifjVPw6e69YRPGemtsDAW/Ur8+KOqwj8FE50S2lJ9pBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+obZE1CkbmmqQGNq8pXlFR9LWdPlQ5//56SPa+berfU=;
 b=DH4QR1+SssPbsBgJM8ipKA5IUmi8GNE9/mG2hF3hVGg3vSTOoglJ1LF1MMBcSdj72ajfysNHRKiKTLPL7g/reffgGjH7/vxoO5Gu8zRdh+nGaHOwaOqxjKccuSDhPbjheJLhbDtLm4eprKt9X+/jwsYe7vMtB09BqVVyMzdw0urf7lsboWrPSNBGhOGXeA5LPVlfRcm26j/VT4SW3ZY2tOoXhjMQVVky2W5t4DuUVOyQNDFTRAoAQPfKsyyPw/L1TbWJ0IM2PhPY9qI8ZlE3RdrRBESAcLgScoVCSWhPuf0taIF4CHXlcC3GJeKuXt4vHVBjFpGmXqTE9eG9Fs4keQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+obZE1CkbmmqQGNq8pXlFR9LWdPlQ5//56SPa+berfU=;
 b=GNLpX+U7GMqw4haXN3/hKcojH2R+GgTfBw25CHVL5Ndv82ybA5sIWjBNFS/gJ1OYrWfFqIT6aoXIDdbYeh0Q6ZB713/++nSeuWNNbXpnBZpyXforl1aEsIepDLXLsaA1P7I9PNu96VpzpUt3V/8yz6QOAbZBNy/DXi9WAmqky4I=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by LV8PR10MB7845.namprd10.prod.outlook.com (2603:10b6:408:1e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 20:55:08 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a%4]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 20:55:08 +0000
Message-ID: <ac3eb485-18be-4fcd-b0d4-8370aa64f38a@oracle.com>
Date:   Fri, 15 Sep 2023 15:55:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: iscsi_tcp: restrict to TCP sockets
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
References: <20230915171111.4057930-1-edumazet@google.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230915171111.4057930-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:5:15b::32) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|LV8PR10MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 844f9102-a49c-4b98-dd26-08dbb62e0ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEaKDf4jlsfFxn5s40N+VujpjlHabMVppxElX4EqzaGAF4OD2Xax8+hYoEWwH6C6Qw8OyYoHYSlJEb18BYD0ijVclxiPP+HlGHwXG7RAYqs7DyYpftrR0EmYTx1u9Avj9ry2SsbLyODW6t8QfnWrA06ooeXMHdRpuBdAc/9oSMadySA2Ur1bcdN1YHsvsuko52xa3EmYCEJnHdCitlTTbHRcFVikUdVXs5cQeBPJ72O9bJYKFQJK6LZ/6JrYpbHQlC22g7tXtqITQXqksAINdwm63yAlObyl/JXvWNe9SUe5nOjD6l5bGLdctHMBAsOg/EPfOoWrr7Hp1J0r5X89/ylH0WgePqGsk3lifz7I71TwcW+DZQSg4M+MN43lGR/HIrByGjK48bsDKHMGnJrFIx7ZIde1YLynnhBbbzXdXsVt3/KoGl+Q/wHHnvKrx9SQhZrmeMe1PcelDy+MIP8AnGL+O/wn/5OhVYgGs7/Ajay1WGp1Eysr42RGRZ3z9eW+IPRpLIhZlSIYPsNULj6o8GQvoVrzRil9oDbY6708lhImzZnvJ+D0zTEdx91lH/1Tz0BCn0kpWUlJPk0Wp1hpjnAds5ZV0GTEXYPPta6+fuzmqfBafTPH2AXmuc0+Lsf+KUSYSMNHp4xTA0kgupKNlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(186009)(451199024)(1800799009)(38100700002)(558084003)(86362001)(31696002)(36756003)(2906002)(6506007)(53546011)(110136005)(478600001)(4326008)(8936002)(41300700001)(66476007)(31686004)(5660300002)(66946007)(316002)(6486002)(66556008)(54906003)(8676002)(6512007)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE5KWVlKY2tXbkM5REEwYjdDbGo2cmxaNUpMOUJYaXZvZ09GTDBpZjBuMWVj?=
 =?utf-8?B?cUd6NnhReDFZOGNlZ1ZvU3prdmNHeWE4MEdNM3NhWWh1aGxGb1prdmFCbzBU?=
 =?utf-8?B?VXlvcWdOK1psZEdkYkVWcVdvM010NFBwdEljWGc1b0czbFBlV2kzMmI4OEFv?=
 =?utf-8?B?ZEczdzEwSyt0dm9wMlY1b0pJK1BQeE9PWERCdThIS0dVMzhDcnhCOUVIOGIw?=
 =?utf-8?B?UDNEb0Y3Yjduc2VEYmJWK0EvR0FjV2o4YzFQYklxaEtkbnRrejNjUkFtazZ2?=
 =?utf-8?B?R0FRL2x2WTR4M2kzZGl6YXZyNm52ZXduRTBsZ2dsZGVkdjF1dHh1K3QyWUJ5?=
 =?utf-8?B?R2p6dFNjWlRVTDdPOE5iTWpKZGVWMzMzcmYxR2tac3pJMWV2eVp3R2NTeGtu?=
 =?utf-8?B?ZUVFYUZodHE1TWVWdnAvRnUyUUFDN0VCTE9QbWFyOGgwTUMxODNMd3YrNGFr?=
 =?utf-8?B?T1pCbXF0d0tLOFAyU2FQM2wzV1RGTW9uMlJLV2hjcjZvQlVDUkYzRUUzcWFv?=
 =?utf-8?B?Rk5jQ2tlRG1BVE9ucFBVS0U2bGdVVEVOV0xmdU9hZUxaOElDZWY2dnl4MXd3?=
 =?utf-8?B?bnBJRUZXWVlaMjI5RjVTU1R2Rks4d3FmZEhvbjQyUHJWdSs0aEwwOTB6ZU4v?=
 =?utf-8?B?OHJYMzBsVERtNFBoc2tMbWExUnNYUTcxRzZUSk5Xbk9yUkpENXlyekVKWlZQ?=
 =?utf-8?B?M2NTcUhFSnhmbythaUE3Mzh1TUV2ZDFRZzBYaGpMMUhreWNsVFR3S1d2T3I4?=
 =?utf-8?B?VTZtb0dPYVZmczZ4V1NGaDQrcjVCemRRaGhJbnBPZ1NST3NXZ1lXSVhTZW5w?=
 =?utf-8?B?TFNoVFFmVm9SQ2paMTZoMzlFaitXajJyVzRKWk1kQzdJcE1WdE9jRmtRYWk4?=
 =?utf-8?B?S2tCblBlRGR2bklwNG9RNUVBSE9NYkFRVjE5TTltMW01NkU3dzNCUkVxeGZ2?=
 =?utf-8?B?MWFqbmNacnFudFVCNlJ2UlV1ZzhOeW5tVUI0ZW5Sd1dZaysyVnlvZFU2MG1X?=
 =?utf-8?B?bTlhSUEvQlBUcDg4VWxNV1FZaGorQWRaYUVCRzNjSmtSbkUzNFF4aHM3WWRI?=
 =?utf-8?B?cGhjb0hiNFNXZUt2cklFMXVtZ1RocGZZbTh4ckt6U1ZYUWtwUlo5ZTFyLzdm?=
 =?utf-8?B?TW4zUTNlSWVTUlI5enlrZVpFcDdqcUE5cld0WFlzVktoUWdBNlFUS3piem16?=
 =?utf-8?B?bGliaGtWVm81SU9WT2NvMmxzbXF4V003eXVSZ2owejEvVEFwVC9DZFEwOFIz?=
 =?utf-8?B?QTFjbDVZditJZEJQMUM4aFdyRGM2L3pZRGZGMlppNE9teDNwZ045Y2tnS0FJ?=
 =?utf-8?B?ZmpqdjVvTFdjOFZGU3lOWFhMaXFtY2FuQU1NenZaN1JTQTZHSEdRVFhXVFJO?=
 =?utf-8?B?NmdpWXlPMTFJL1Q3NDhJT3RjREFZUHhJaElwRXZMbjRlS2FxeHREVDkveTZq?=
 =?utf-8?B?aUZUTERaMXljV2R1MVZsR2ZHNi9KTWY1U3VNSlBkNXIwUnptMTZ2NHdqQ202?=
 =?utf-8?B?cUFSZEtyVTVSeDZhMGFUZm0rdWUzbkUvd1ZwZTVBNHduNFl2ZDNWVVg4Qmtu?=
 =?utf-8?B?L1NXODlCTDhoQ0NIb1ZZTkdKLzRmYTlucmN1QnN5Q2R6d0FZS01qRWFvdUZ1?=
 =?utf-8?B?aDBIZ2JOVGJBUkNYREJQKzdhNnE2ZlJaMjVNSlNaWjBRdk9OWWF1NEkyS1dO?=
 =?utf-8?B?VlZUbmZKUWxLRnlCY05vdjJmcUNCclJSeFVpdEM1eFZiZzZGZElQZ1dVYjZs?=
 =?utf-8?B?dzVUTTg4anJISk16ZFpwOHppUVF5ekZWYUVyTEh1aTgvOWQ0bmZranVIYkVt?=
 =?utf-8?B?VXdvY2JJRFZxdnUwQklIK2JiR3VlOVJnU1I3Q2E3ZG80RHhtdW9TWUxuRmIv?=
 =?utf-8?B?bWJ4RkRrQmtBUmdYOEVLdDhKY2Zxb01VUUhBWEdTL3B1cHQzLzQ2SDNKTXRU?=
 =?utf-8?B?Q3R1Ky80bHQwQVBaMFF0SXBDRDhyVlMrWXQ4MFQza084UmhyV3NvaEtCUHBX?=
 =?utf-8?B?NHY3UGtOQkhMcVo1UTZma1IrRHZDK0gxMXMvWUFWNVo4WE1hNDNOdzl3ajVS?=
 =?utf-8?B?dm9Oc0JlWkdTbW8wV096VFlBTWYxVUI1OVcwN01Fb1ZMWXlKQWc5aFFCYVc4?=
 =?utf-8?B?Wi9qcWdiRkJqaUF2YTBMRlV5QmtnTG0yOTAvTnI0YzFxb0ROekp6ZGsyeXdC?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M21xcnA5UEhSdUQ1L0R6WjVKazVxRTFsSHhxWWZibWdOVVQ1TVdsc2lrL09W?=
 =?utf-8?B?SG1JUEFDVnFBdDRZRTF5QytkWWw1ZDFOM2ZjVVN5L05ibGVWdlZwemtUaUt6?=
 =?utf-8?B?UXFJRjhIQjBObnFNQ1pzY1VrUGlmOVhBNU1SRU1ERWRoNWhuRTJuLzlManhu?=
 =?utf-8?B?cVBEK0RjM1l3blB6WVBpcHFkeHJZbXQxeGRtUW9vTGg4a0FXS3ZZRC9KVXVa?=
 =?utf-8?B?K0hDeG03MnFJeVlYVzVhR0oweDJVRnlqdDZUWnExQnJxbEsxdUJYYkFyN0Zx?=
 =?utf-8?B?YTlEYlBBV0RMaCtxY3VpaVQwY1JrelRrSUNGYTZiNUZ1OUhNOHhZaGpwa2tB?=
 =?utf-8?B?TDlZNHdxcERVZDEwNS9vR3FzcXMwLzhHZzhVZCt3NFJJSGJyNmM0S3g5akwr?=
 =?utf-8?B?cEEvZkYzV2p3L2RrWWJmMWRoVHlQaWN6MG1MYVpsUzlFVEZ1V1lyVFFjOFFa?=
 =?utf-8?B?TXFaZmZONUF1cWxEZkI1dkNxZVBydmNoaEtYTEhzZVZ1SERqdnV1ak10dVhO?=
 =?utf-8?B?MElLR09ycWkvRmx3Zk51citUMHRpemwzOVJsL1VTblJNV3hjZnVpamhGZHJ1?=
 =?utf-8?B?SkZjUm5kbDROakpuSmVUU0VuZGdtYmZNWnd4QVJleWdWQ1E2WExTa1d6b0tn?=
 =?utf-8?B?blNQZkRlVGVjSzE0OU14MHRhcjN5dkVENkRqblJYNit0Ymd1b2lOVSt3UXdv?=
 =?utf-8?B?ZUdFMFp1b0lFVzhkZ1NFSExjTFdFTnA1WkNzMXF6MUVBNk5ZdDFqTGQxZ1RF?=
 =?utf-8?B?MTUrdUF5OGU0dmRRZnB3aWUycGwzYWJLdUt6c044eXBWMVd4SjZIS1JDVFF4?=
 =?utf-8?B?R0Rvc3FRYkdua042VVZMb0c5ZTNWLzBTcXAwMHEwc25WcHI4MktpdzdtZjNZ?=
 =?utf-8?B?REZlNWtQMzBrVlV0R0Rjalh2S1cvWDlZa0MwRExaSWJHamZlRml5VkRMbGJD?=
 =?utf-8?B?SGowUTdHQjltdFdUVkZCQk9KaVFHT0E4UjBxVkhMTGZReE1RN3Y4eWlobE9s?=
 =?utf-8?B?MWhyYU1sWjlMMEpsekwvT2dyRFZDTWxiWVB3RU5BbUg4b1hERHVLbFBGRFNm?=
 =?utf-8?B?emIwWjZoU2xRTExsdGZDcGtvUDFQZ1ZBcDFEdlErNVVPZDZwNE9ydng5V1hh?=
 =?utf-8?B?Vk5HdUlaUndnN0pwVG1icDN6VEdYbzE2N1RpMjlqWStJZWJUbXdoT1RUYmEx?=
 =?utf-8?B?UVNraGg0QkFBbTFoMjdFTDRYR1V0LzExU3FoYzVhR3YwUVJtRy9zZTZnTGdj?=
 =?utf-8?B?RUFDUW9IL212blNHK1hXZmpKVjRPNHZXa3BRaTF6Q0QwSjVYQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844f9102-a49c-4b98-dd26-08dbb62e0ba2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 20:55:08.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uv/c7XNTCDNc4dMvv2R4U1o4uRX/fy+dt/nA00Ak4Qr9axJ+oA/ZyXYQCtx5vPB+TrnoWw4J3B1wSE4+0xkNoVAHXquWudC+wMzat6pCdPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_17,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150187
X-Proofpoint-GUID: 6KUJq2CcFeifZdbNjvCEQJdZjoWGIR9J
X-Proofpoint-ORIG-GUID: 6KUJq2CcFeifZdbNjvCEQJdZjoWGIR9J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 12:11 PM, Eric Dumazet wrote:
> Nothing prevents iscsi_sw_tcp_conn_bind() to receive file descriptor
> pointing to non TCP socket (af_unix for example).
> 
> Return -EINVAL if this is attempted, instead of crashing the kernel.
> 

Reviewed-by: Mike Christie <michael.christie@oracle.com>

