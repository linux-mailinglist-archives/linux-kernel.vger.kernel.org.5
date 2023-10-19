Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D367CF058
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344754AbjJSGrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjJSGrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:47:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE0211D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:46:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J3TuVF022581;
        Thu, 19 Oct 2023 06:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kEWFKnHJ4JeJj1gnMEQnam9SE5eTp9C2iRP8xKn+f8A=;
 b=tesgqGp3XnlQ1mra7ZZ2tAZu8u5kw0OuiCiDXGM7UqSpN5EcIU+PrS7jQPD+OEWSOsJI
 0I+pSeQH/wwRZxh0aseFgJ1iVKoIL/SrO2HJYWwbCVZH/ZBLhrhUnydcZcxFHJH4cp9Q
 qZTQIhH8x2RlD9J797iDug3q67tIyH+Cb/RkpxbQJmqbyXypEqzh73i/cjbdo4/ktYcX
 +huWsc9s2z8Bhyqhy0sm5/3b4w1tXrxxoCUMqYhND+fhaEIBNpFY5XqAXCFkpIJOcZcw
 WuJSmg3GGnAwsz1Y/Atv7ByFlAYPB/m3Za4ii/Lf1T2OQ1sq+Brz9MV1drOjrOSMP2Mm KQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28spqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 06:46:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J4XZmo010606;
        Thu, 19 Oct 2023 06:46:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0q9ujm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 06:46:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0UwAk6TtVk7peA65l+zXZlPNuEDVPaisPjOR6lUJcMh25xooHKu6krJuQo3AA+E0qrKuaXOnrMUReysXn7iC4KR+etPXaQeXnn8Z9U/i9qyWD3D23PiE8Jxx5SF7/oD9j2uY6CMRl56cp5LsK5Pa4NvM6IKxZMSTvUdbuFxjZQoq/S9ckjtUQcWJKHAgpsBP1gSUW/I77QeY7ceMNEnNuEE3gM0K2XuCg1WYTW9iC9Gjbynq3ydg+WLcYMU0VWhJJNpunRwNSsY20Xh08X9CjWmimfXoqNcUgB3BNB+XXdbI7TvXz10t+DCQIStw9+9G5C5Sih6nODKqsg92BXqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEWFKnHJ4JeJj1gnMEQnam9SE5eTp9C2iRP8xKn+f8A=;
 b=PkLKR9OfHyTmA610sWdWavxNpt8low02zmdS1pvJuWerJqTmZelQSx9X8X01rU0lF4wTENP2ItdC2H8HMv9OD6RqmDiJ2HxG+frGdFXYQBheMiAz9d0Jvqtd+z6xiq8vceZ7grKnOgUvnf4mYRLALrqI/rNbyBOvoxRcCp9ZZuzQv/V7bk71dK4dPv+qjy9lSuE260+mb7cLwhgIBYTQdQWJFkzrT8tFqrVCybR1hdDr+L2sJCQ6V79ROUZu/fqblvkjL73JFLQXSSqrvp01dFPjTS4IDg7h3CNPj/eWYO2ulf7Ud4KpbSh9J+YN+FXu2CGOzqtAWYFVSBmr9G/CYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEWFKnHJ4JeJj1gnMEQnam9SE5eTp9C2iRP8xKn+f8A=;
 b=zK7hJjMNRt/3QGCs54pE/Xl1+FAoJ5w3lkObjnFuDqsoODkBZBljGsq/jodemQbyx36YF2CMw02h7qT6JxiKBRzd7r43IcSKOBKFBHViWoW9OoEODuka+j0wh1TXdIvrAQFlQZCPrVK+Q7hM9fOvq/tEeV7aJDsHiP2gJH8s0yE=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BLAPR10MB5330.namprd10.prod.outlook.com (2603:10b6:208:333::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 06:46:40 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 06:46:39 +0000
Message-ID: <4ba8b63f-61e8-44cf-8e01-e467bd27ed5b@oracle.com>
Date:   Wed, 18 Oct 2023 23:46:35 -0700
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
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
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
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvebhMo5dfcyq2MFhBvFVNbwrqVofJXaBe9Vmn1O4qVjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BLAPR10MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffc1611-f0b1-44ea-165c-08dbd06f2556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88bWHIAMp3T1P8chAN4dr9opIbjaDC9pdtbrgEAZ3hjykrz4XY2LLaXxorQ0qV9xInLELQlCXh7VZbpdpaoT97jvP5EdhQAa3BI9ZbO0LTmk2NahIsRcBcWf8CxGq86SDFpLSf9IehIUBqerUHn5a0HBHXlJqLsOdCbe280LV38OdzvdbN4kUdNeRuhAlG755IrpdOGqhwc2d2ShHy8RbpMvDtjBoe1i4B3g35/oNkWuvY47hy3dAVwcd5Ndj3XSzDL4NyC5+d6u9cX76VyuJ4wVEuaqGhVsadAZKlIFkiU4LvK/v5APhCVl7xgeyt2bADgXcU6Ob7+QshDGjYChm+mIp9T07qKriH8/xtIiX0oyTMBjooKjtRKhuUr7DfnXNugqTUnTsFitNyk7JnjQxt991caFRn2phA70h9KFMaqFG0DW0X4ubUmtTecvn4ThTj0XjubMSHqrP9i3Usq6xAyk+EG8NJNqoCHreG4iyOokwRU1IQ0zEmx0Je7zdY7fc4ABcHLBBb1YZ32RD5vsjdpUOOyJM9bV5SCRtEST74o7wl0Ayv7FRobF+yqXNAbiXeMcAA3CPKA3vq6QmlawrDDserUnLGvc/MqWyljdnsIF+IU6a16+5kPNyOfLq97sHRxIlebC2gCx7mLUf+uzLMxR7Ei4F+vLeP/FXHyiHQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66899024)(2616005)(2906002)(4326008)(41300700001)(26005)(31696002)(86362001)(36756003)(53546011)(38100700002)(478600001)(6486002)(966005)(6512007)(36916002)(6506007)(6666004)(6916009)(316002)(8676002)(8936002)(5660300002)(66946007)(66556008)(66476007)(83380400001)(31686004)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0tiMHhzaElpUVFqUU9ZWFJLSjJNeWRTM3hBdE1aRkUremFEN2lOY2Jic0Zy?=
 =?utf-8?B?c2VmRDRYZjB6SnAvemxCQ2JtdjBZeFlBSzIxOW5mWUFsYmRxSlhXT0JXcC9T?=
 =?utf-8?B?UFpKOThRbTR1a00yN2pYQzNyZnZQVWZMSXRYMWVPV2cvS01ySW5scHBRNjdV?=
 =?utf-8?B?WFRCbzhTellFRTNqalNyZVpsYzM5VTVQRzVJSU00bTRqQ0dNTm1SOXVhdDNU?=
 =?utf-8?B?ZVdjdjRhZDBOTXIrOXc5T1p5eFBNdkdLVEtmanAzVjNFT0U1NlV2TDBNYWtU?=
 =?utf-8?B?MExXQUVJVENORzlDUVNtclNZZjA3RStWODRBbzFUUnFJNVNvT2xpQUtoRElU?=
 =?utf-8?B?dVY4ZVZWTUpUNFFZdlR5dnNFVVBJUWpWbWtBWWx3S1NVN1daSWI2ZXBLQnZE?=
 =?utf-8?B?bkd4QVpSMFdkQWErN1YxODl3aEIwdGRRRUJmUDZqc1hud09jMkZ5dmVvM1lr?=
 =?utf-8?B?aHdkSjQxRUNlYzMvbGZBUU0wLzNlY3ZFWC8xa2NTMCtIeSt5bS8raVJsMlFx?=
 =?utf-8?B?N0l0VlRsNkMrQlpYRDVyVSt2bmpMelpZWTVhRUhyNU50Y0dic0pLN05OOGRJ?=
 =?utf-8?B?YnlFTGlJaGFTQktaS3c1N25ZNGlkbFlzR1Ivak5zRk85eEc5Y1pUTkFRRXNw?=
 =?utf-8?B?SlEyU2ZYUjk2S1NrT0RxY1ZTYzh2bFdyL3BsckswV2tQY2QxbmJ4dEwxZmxN?=
 =?utf-8?B?emwweUthWkk0N25MOHNIZ0s4N2orOCtycjhCKzVCZEpkWGhpTjIrdmduaW83?=
 =?utf-8?B?aTNYSnl6RWxoRXRPTWExV2V5RS9WM21qeFVZUkNaRXpDTmthZk1GSUk3Rnc2?=
 =?utf-8?B?OWFiWnZxS2VweDQ2d1R1VmNWb0IrYWNOTWRIL1crRUNMMzhCbmR4SFA1bjBU?=
 =?utf-8?B?dlJWZVU2akhSbVdCTmh4cnNiY0FudnU5WGNpalRBUEMrSWlyOEo2NVBLeFNX?=
 =?utf-8?B?ZjA5OElJQlRpOWloY1plUGxNTFpIazk4ZGt0MCtRaFNUNWorSkpTdmxicDlT?=
 =?utf-8?B?YzFSQ1FBRy95akFEQUZvdDdFQ2I3VUdyNXVRWm9td08rL0RvTkd2NTJVK0RP?=
 =?utf-8?B?VG5udTVkUDVnc2xRY2pmRTkzUVpYSjhSb20rQ24xN3luQnNnYVYxOGhpVlRa?=
 =?utf-8?B?S0dZYTlvZkpZL1ZmNTlhWllMOHdwcmJ4VE9yUnNWYnY0Qk1hTE1QMGdzNWxh?=
 =?utf-8?B?a2hxcmk3RGdldUxMdjBLVFNQcGh4RU8rNzh4SU54dkpQS28rNS9mK2dsOTVN?=
 =?utf-8?B?V2RsN29FcDdFT09rYy9TNFlqY3BBSHFmbmZNZCtVS25hK3ZNeHdEZ1ZQeVVm?=
 =?utf-8?B?bi9xZjE4dDF6TVVQTzhWOTM5MUZaTlFtM1lES211NFV5aXVkVjJjY0ZBV29i?=
 =?utf-8?B?bHo3T0lzL1Zzd2ZJdGg1dHYyUThvQWdPYlVRekx3SG9yekZReFUzSHNqWHZu?=
 =?utf-8?B?bm50SVFkYTlaY0N6bm1sVExVUTExVk9GRmE3QkFKM2d4cVZPVVZhaHd5WDhi?=
 =?utf-8?B?bGQxQ294RXBTQjRpYzFjUjF6RG1CbU01YjNKU2RzVWhaOWFHcFJJcWdUNnha?=
 =?utf-8?B?dFpyWW9YT283WTRPWXVRMC9UcjU2WnkrS2hwSTN1WThTaEFHcGdzVTNCNS81?=
 =?utf-8?B?UTUzTEVRTHAwcDR0K3FJaStaZ3VjNDJaNnZEM2hKU0Z4Q0NjMXI5Ukp1NTRS?=
 =?utf-8?B?bStNRTJKMWFaeDlqeEJIN29pRWNBUHlLQlp1bE9OUmwzdUpVdk93NUdncG4y?=
 =?utf-8?B?TWQzQ3N0ZHNGbXVsNCtiaXpiNU0zZEM2V3dpMnpMczU3WGZtT2MxU1IzdHlr?=
 =?utf-8?B?NEdTOVprd3RVdVZFMzdXK05vdGFBdytjbldEekpNcE5tU01GaEF4UE1McUdz?=
 =?utf-8?B?RUUrVjdlVS9CL29rVEdiSzQ3b3g2cWxOVEROcEpWQzdpc0RVVmxNRFZmSlNw?=
 =?utf-8?B?QTY1UERvekFjd0lDNm1MdzBQUDhZd1Uzamk2eDVsMnZWLzJkNU1BSnhpMnVF?=
 =?utf-8?B?dEJDUGRkNlVUUFQyaHhwc0JyUURDQzBPSm94TWRaRWIvbnBQV2hNcFlSM1pp?=
 =?utf-8?B?d0MwRVlBMzlzWk8zTFBHRUNyazdxUDc1Q28yS21wYWtZbWxpdVhUM3JGUU5t?=
 =?utf-8?Q?XPGz6SZYfjW8jBKyg8cbNWsR/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NFZjajJmN3k2dnBQejFTSG1aYytmZS84bVpPTGNYQVpRR3l5WHVMZUs0VlUv?=
 =?utf-8?B?UUFNZVNIV1c5L0o4SEl4MnBEV0RyWkYxU1lPaERMU2d4dURrUVoxOEVRRG4z?=
 =?utf-8?B?Uy9kRVJPaVovSXNSYW4ybFZDbWVrTFQwSTRuVUtrckJrMGQvaGk4QlIxZnM3?=
 =?utf-8?B?Nzl4T1AwbjJxczZSakRpaVFORlNhcHMwUWNTU1lidDlhOGxHUG1SUWF2VzFt?=
 =?utf-8?B?cTVxcUFwbzM1RzY5TWt3UHZTSkZKOHdWdDFhY1hNd0FPeHV6aFFQaUdBS2tV?=
 =?utf-8?B?b0RiYjRsQ3lLcGE2QkxBZmY4b2hyWGdWUmlseURUcTgvL2k2cUQvSFBuN05O?=
 =?utf-8?B?RXVCL3pOOHZzYlNFZmIyVVZoUk56cnpKdkY0RWVvNDBYNDg1dWpTNXpvTzho?=
 =?utf-8?B?NHArL3dvQ1U2MytkL013QzlsbjgwN1BNUVYxZ3VNQndjU1JFbHNmQ0p5NWV5?=
 =?utf-8?B?ajBsNHdoU1JoVFpMTkQ0cDNEK2xVVXp0Q1piT2V1ejBSSFphMmxFbXJVRFdU?=
 =?utf-8?B?L2JEZ3ZFODlBMkpRdnVvUTZzdkdBKzVvUnNaMkswYUExOHdTTU81NDFyOFE1?=
 =?utf-8?B?cTBvTEJ0VmcvRkxMNlRpWlJNOTA2SWtiWFJqMVhkai81QzRRRm9QSytNNGtK?=
 =?utf-8?B?VTV6aFN3elFTQURhZDM4UnFnbU9WdlVZdlFNckwrK2NySnNRSldTeWJMbkJS?=
 =?utf-8?B?cy9OSjZIQUJMOUZCQ21SaFp1K2hkTTFGTDJ3djFRTUtXWjh4Z3ZWTFp6YjE2?=
 =?utf-8?B?eVVmb04rUDdwRUdiRWlKb3cyaE5EZ094WGtUK0VUV3k5amF1Y2VucU1BQmxx?=
 =?utf-8?B?TDArUGFGNFN0WlVHV2gyY2ZVNS95QjNXbkhDN0RERHdoeERtbWNxVW42bmgr?=
 =?utf-8?B?RWJidDlzL0ZTYVZtNnJnZUgzN0UvU0JZL1dEZzEyN0hSa0Fyeno3dEg5N0hP?=
 =?utf-8?B?elRGT2d2bExmQ1psVlhvREgveWN3UmdyRlZxTUNGRzdYNFpBN2NQaVlqSHU0?=
 =?utf-8?B?Vmx1Y0VqV1BFUXh6MVU3STJiS2JOODBoc2JJQ3FNaW9LejZNVHplZFY1RWFZ?=
 =?utf-8?B?UXJZZTBWOFgrWFU0aVpSRU5ld3Z2bWpqallLK0VoZXRFUXpvZ3VHTzdzTm9w?=
 =?utf-8?B?S21zRjRhWnBiMDdYQzZLemlvRWhKeDBzR3Rqbkxidzcwem83T2RhOUQzbmt0?=
 =?utf-8?B?WnBjekJzZFI3UHJIVHoxR3FRMjNHM2gyczU0OVlqa21QRDBiMU1rZHZ2K0FI?=
 =?utf-8?Q?c8VNupd3IfXzYAs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffc1611-f0b1-44ea-165c-08dbd06f2556
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:46:39.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRgm2LWBZitss6xTmTfGmXDMniTEJCE2+nSXCBQJykR3XKPy36YBQJYx2xlbEaL3r2dK4BIazNXP84x8+RO+sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_05,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190057
X-Proofpoint-ORIG-GUID: 5lVNoExy9np3SmB_pMQ4eNEBVdIESCqr
X-Proofpoint-GUID: 5lVNoExy9np3SmB_pMQ4eNEBVdIESCqr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/2023 7:53 PM, Jason Wang wrote:
> On Wed, Oct 18, 2023 at 4:49 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 10/18/2023 12:00 AM, Jason Wang wrote:
>>>> Unfortunately, it's a must to stick to ABI. I agree it's a mess but we
>>>> don't have a better choice. Or we can fail the probe if userspace
>>>> doesn't ack this feature.
>>> Antoher idea we can just do the following in vhost_vdpa reset?
>>>
>>> config->reset()
>>> if (IOTLB_PERSIST is not set) {
>>>       config->reset_map()
>>> }
>>>
>>> Then we don't have the burden to maintain them in the parent?
>>>
>>> Thanks
>> Please see my earlier response in the other email, thanks.
>>
>> ----------------%<----------------%<----------------
>>
>> First, the ideal fix would be to leave this reset_vendor_mappings()
>> emulation code on the individual driver itself, which already has the
>> broken behavior.
> So the point is, not about whether the existing behavior is "broken"
> or not.
Hold on, I thought earlier we all agreed upon that the existing behavior 
of vendor driver self-clearing maps during .reset violates the vhost 
iotlb abstraction and also breaks the .set_map/.dma_map API. This is 
100% buggy driver implementation itself that we should discourage or 
eliminate as much as possible (that's part of the goal for this series), 
but here you seem to go existentialism and suggests the very opposite 
that every .set_map/.dma_map driver implementation, regardless being the 
current or the new/upcoming, should unconditionally try to emulate the 
broken reset behavior for the sake of not breaking older userspace. Set 
aside the criteria and definition for how userspace can be broken, can 
we step back to the original question why we think it's broken, and what 
we can do to promote good driver implementation instead of discuss the 
implementation details? Reading the below response I found my major 
points are not heard even if written for quite a few times. It's not 
that I don't understand the importance of not breaking old userspace, I 
appreciate your questions and extra patience, however I do feel the 
"broken" part is very relevant to our discussion here.

If it's broken (in the sense of vhost IOTLB API) that you agree, I think 
we should at least allow good driver implementations; and when you think 
about the possibility of those valid good driver cases 
(.set_map/.dma_map implementations that do not clear maps in .reset),  
you might be able to see why it's coded the way as it is now.

>   It's about whether we could stick to the old behaviour without
> too much cost. And I believe we could.
>
> And just to clarify here, reset_vendor_mappings() = config->reset_map()
>
>> But today there's no backend feature negotiation
>> between vhost-vdpa and the parent driver. Do we want to send down the
>> acked_backend_features to parent drivers?
> There's no need to do that with the above code, or anything I missed here?
>
> config->reset()
> if (IOTLB_PERSIST is not set) {
>        config->reset_map()
> }
Implementation issue: this implies reset_map() has to be there for every 
.set_map implementations, but vendor driver implementation for custom 
IOMMU could well implement DMA ops by itself instead of .reset_map. This 
won't work for every set_map driver (think about the vduse case).

But this is not the the point I was making. I think if you agree this is 
purely buggy driver implementation of its own, we should try to isolate 
this buggy behavior to individual driver rather than overload vhost-vdpa 
or vdpa core's role to help implement the emulation of broken driver 
behavior. I don't get why .reset is special here, the abuse of .reset to 
manipulate mapping could also happen in other IOMMU unrelated driver 
entries like in .suspend, or in queue_reset. If someday userspace is 
found coded around similar buggy driver implementation in other driver 
ops, do we want to follow and duplicate the same emulation in vdpa core 
as the precedent is already set here around .reset?
The buggy driver can fail in a lot of other ways indefinitely during 
reset, if there's a buggy driver that's already broken the way as how it 
is and happens to survive with all userspace apps, we just don't care 
and let it be. There's no way we can enumerate all those buggy behaviors 
in .reset_map itself, it's overloading that driver API too much.
>> Second, IOTLB_PERSIST is needed but not sufficient. Due to lack of
>> backend feature negotiation in parent driver, if vhost-vdpa has to
>> provide the old-behaviour emulation for compatibility on driver's
>> behalf, it needs to be done per-driver basis. There could be good
>> on-chip or vendor IOMMU implementation which doesn't clear the IOTLB in
>> .reset, and vendor specific IOMMU doesn't have to provide .reset_map,
> Then we just don't offer IOTLB_PRESIST, isn't this by design?
Think about the vduse case, it can work with DMA ops directly so doesn't 
have to implement .reset_map, unless for some specific good reason. 
Because it's a conforming and valid/good driver implementation, we may 
still allow it to advertise IOTLB_PERSIST to userspace. Which belongs to 
the 3rd bullet below:

https://lore.kernel.org/virtualization/1696928580-7520-4-git-send-email-si-wei.liu@oracle.com/

There are 3 cases that backend may claim this feature bit on:

- parent device that has to work with platform IOMMU
- parent device with on-chip IOMMU that has the expected
   .reset_map support in driver
- parent device with vendor specific IOMMU implementation
   that explicitly declares the specific backend feature

>
>> we
>> should allow these good driver implementations rather than
>> unconditionally stick to some specific problematic behavior for every
>> other good driver.
> Then you can force reset_map() with set_map() that is what I suggest
> in another thread, no?
This is exactly what I was afraid of that broken behavior emulation may 
become a dangerous slippery slope - in principle we should encourage 
good driver implementation, as they can work totally fine with older 
userspace. Why do they have to bother emulating broken behavior just 
because some other driver's misbehaving? And what's the boundary for 
this hack, do drivers backed by platform IOMMU even have to emulate (if 
not why not, and is there substantial difference in between)? After 
getting through all of this, do you still believe everything is just as 
easy and simple as what thought to be?

Btw, I thought I was expecting but still haven't got the clear answers 
to what was the goal to do all this, we spent a lot of time trying to 
unbreak userspace, but looks to me as if we were trying every possible 
way to break userspace or try to approximate to the same brokenness 
mlx5_vdpa may have caused to the userspace. What we will get eventually 
from these lengthy discussions? On the other hand, if you think it from 
vhost-vdpa user perspective, you'll clearly see there's just a couple of 
ways to unbreak userspace from the internal broken map which is out of 
sync with vhost-vdpa iotlb after device reset. If this brokenness was 
something universally done from the vhost-vdpa layer itself, I'd feel 
it's more of a shared problem, but this is not the case I see it here. 
While the long standing mlx5_vdpa/vdpa_sim issue is 100% misuse of 
.reset op in a wrong way per IOMMU API definition. Why leaving this 
discrepancy to the individual driver is not even an option, I'm still 
not sure?


Thanks,
-Siwei

>
>> Then we need a set of device flags (backend_features
>> bit again?) to indicate the specific driver needs upper layer's help on
>> old-behaviour emulation.
>>
>> Last but not least, I'm not sure how to properly emulate
>> reset_vendor_mappings() from vhost-vdpa layer. If a vendor driver has no
>> .reset_map op implemented, or if .reset_map has a slightly different
>> implementation than what it used to reset the iotlb in the .reset op,
> See above, for reset_vendor_mappings() I meant config->reset_map() exactly.
>
> Thanks
>
>> then this either becomes effectively dead code if no one ends up using,
>> or the vhost-vdpa emulation is helpless and limited in scope, unable to
>> cover all the cases.
>>
>> ----------------%<----------------%<----------------
>>

