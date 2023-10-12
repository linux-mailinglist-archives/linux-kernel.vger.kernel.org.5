Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330EB7C654D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377358AbjJLGTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377344AbjJLGTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:19:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F89BD3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:19:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BKTZj8031167;
        Thu, 12 Oct 2023 06:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0cfRdV+Q83k4vmFK+1aCbyF+WI4YUW/wE2pewNADpu0=;
 b=OvAtjjCAAt0KtyQDLOTs6INQBjQNNNrLvsd390mr0bbXR0FAkYcV+gmMfey/P1ph69iU
 NeS9UgbSdBetwKUOvH3WkfZD7qhh4HPyaJT+Voldriywpu8WBbKdqCkNoB9RNziDXYHm
 NhDy6uvy0MVTUrAclYhQzlRnBqYHRvFasX9lo7RHEsDRl5ZNbHjVW+fD+Tu6O4f9Bxpi
 0YNNVvRPgN0UlHFi9G2qN4aQ4T+Jx4L2iefGM+DshfnSFaH5SivNW9ofrSaaKOEZx+QR
 tIVO3FLw2HZv6plazeNJhARo/+SB1G3Jb2QnVBwVLegj94z0w3XINviG7BcJnTZ9qJ7u JQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh90y9ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 06:18:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39C51hxc020140;
        Thu, 12 Oct 2023 06:18:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tmfhsxag9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 06:18:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fygFY+Gu4enVL2FW4LnYA3aeUP3uEmEfPPqymId7DQzfE4x0H2Mol00fR53zv6jwMGMSHElHEmUmMjOvNGa/JBYlrwp2/cbLqhTliaB60VPf+IW9vFcpFG0vgtFGH6OKHj0Pzgm+kM6n3F10AzESu2PT9N10B0fSpGUSyemRh/TDXq7AH8cUE0SY6icjmJJVUzMxblHR7FWFBfViey6tt9AlWSOpvJF0BRy+6hg0/QgM9ZsGp+NexbM+qfM1+HP/P4pRWg0LIMUCCwBsbRnfyuGKXQ8eh68Gfwk+Gnfm+Vb5iJpFHcbB2+AmvZnF6tYPv5iLSJ5976Z0Q/co2L0KEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cfRdV+Q83k4vmFK+1aCbyF+WI4YUW/wE2pewNADpu0=;
 b=jAnBRYzerh1ifEeOBWd30zUctyEy59xEgoDZxF44dUdiPdhCNrkcdfVj41LDFAA+Y35wneOR/f/LzrsE42WovD6SaTWtnxLmjRDyyYZ1rmEXsctzviQgVvMCV5UpAo6hkEcJBfFGe5zuijFzr11MJ+EUC9h+NRF9mse2QGNt6tMhyriJXMkcPplLIOAae8oFDS8GUpsYF/4W+MOUHGmo4ZTRvlgrvAvWbz1wrriOIldY3gMDnoWpLItLpidQpbCPV0Ro2CDEW+9aTCieY/e6PF7zcrFyNGL/ecrXdzuRlU5fTz2x5ybDiH/IG28qa3P43YFnkfdfw5Q4tNQqaWcJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cfRdV+Q83k4vmFK+1aCbyF+WI4YUW/wE2pewNADpu0=;
 b=0CXK1Nlvez/5Zr4LKPaXGcf1e5ty+vI6ChpMRmJ6EYLrX1eEw8nNcnhILqaNrLMYqSwsXcp41WrxTtVdPBodrm5YCI1hVXlxd+H33LPEBr3/s2JyCnCGz3x7pt7D+Nv8UYr8mPx0rtTltTA5geFPhOUJ1VYvzRWOoeygxM7GuD4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SJ0PR10MB5717.namprd10.prod.outlook.com (2603:10b6:a03:3ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 06:18:49 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 06:18:48 +0000
Message-ID: <f16baa51-d545-48a4-a46c-88b152339d85@oracle.com>
Date:   Wed, 11 Oct 2023 23:18:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CAJaqyWe=RwotkcNKFuStvX=HxQh6sdtfsH23jhf994eXi3-2Og@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWe=RwotkcNKFuStvX=HxQh6sdtfsH23jhf994eXi3-2Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0156.namprd05.prod.outlook.com
 (2603:10b6:a03:339::11) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SJ0PR10MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: b9479592-ed2f-449e-e641-08dbcaeb1896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRzxyFRnBa3X23oaASGjsmnqlEsJP/ol52KOBbQusnuU1r4ZHXIfClm0LiE031dvK1ZCHWbpFcjPBjF/6jc7Pb7Tj9ThL1zKQUlRXnHyKrnEaaIWg+SIFk7SRt8uOMm1/l7yZzpEXBl3hin6yyj1xhU3r9hC+ae/0YpTET3LZC/iFSZBbBfsemUnt1BEFocSFMCEoJ3/zkZ3iSrn/nYGbxYo7cGM8t5F2kYRVlNWlal5DMDpWaYu3I2PTplkigESvBUtzMLC/ogVZByoHo6JPEozUTXfKoRnbrXBkrQaBnrsCuT8kik8UBnXxFMeVxpGfY1viEPKMvt9c8z54FHsQqHYQ4RPTa4n300xotsgrDHxGyT8DJAvR7AIqplu9IHlYuS/ylD48YhltTXmQ8RJi4c191h/dOEt+Ryot3gVZjZFDjboDCafsBbBUCfJLNumNXiTmsUbo+17oQ/EpXKjm/EVs3RGgl/gSN9NI8DfSlpFMqjvau8GRKvcn9tsKepE9nNN6qiCxZ0DJvS1JTVn6QNm82Sts6GkzGMDm0haf5m+gXDQc4QT5xxnU/C2gjtutotCdO2n92frnTtwbb202yD1o6E7OGHA9y7jzl8QLPiec3rsRZSIi1xDd04Aea72zw/H8DvqDRrkttX1lcSQpx85BDmW/x3t14SoAzMvuGwTsrzGTwUyqobshxskEuMs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(86362001)(6486002)(2906002)(8936002)(31696002)(8676002)(5660300002)(478600001)(4326008)(36756003)(83380400001)(26005)(31686004)(41300700001)(6512007)(316002)(6916009)(6506007)(36916002)(53546011)(66946007)(66556008)(66476007)(2616005)(6666004)(38100700002)(66899024)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGNjY3RuZHR4NHlJNVFSWUhnVzk1bEZXQjk0dWRxYTlHbm5raG13dThWMnFG?=
 =?utf-8?B?VElHZ0xycFJjd1JHdnhXanJvaEp0Y2VSRkFneldFRStFMmgrNi8yTk5RcGxL?=
 =?utf-8?B?M1QwU09acmxuWEpFRndHVmM2Rk9GVUVQSTg0cDhQWHF2RnpYNUsvY2hQUEpO?=
 =?utf-8?B?T3Y3SnZYNFdWRmZRMWd0aWZkRllSTlVCVFAvZUxxMW9hZ254TTQzQmlmemRq?=
 =?utf-8?B?L0xaYVQ3dmdPRFp3RTJXRjFEck9iNjNTclRWcmQ2R2tNYkpKVFdGVkpGZkVL?=
 =?utf-8?B?d1BvQUloTGdDMU1ibnVmb2swM3dIcGdFby9mM0pkS3BVQVNkMWNQNm5MSm5n?=
 =?utf-8?B?ZUl4Mm84cGV2NWd3c3hsVEE3UmJOVnZ4M29QVitZVmF1OFFQTjVTakY5T0xp?=
 =?utf-8?B?QnA5LzRzeUFnNXBGcytYb3dtYkRYb3l0S1RhTVRMaHlYb2o1eTN6Wnd0TmlD?=
 =?utf-8?B?bmM2V2RvcjFKOENvTjhXMmtiOEpCQ0FlSlNWcjRyVlFQQ3NrdWtJbHdlQUIz?=
 =?utf-8?B?cWJKN2lTdzYxMDAxOHdpcVFjd1UzcHh1bmI5S2lWVkpuOVBNM3F0dW5ybUky?=
 =?utf-8?B?aEFRSGVJS1NkVmJiVVdhQ3liV0ZZcUtNRkF6WDFnaktXSVh5dHY1WmV1UFlP?=
 =?utf-8?B?MkhJNytkbjdyZVZ6NlF5dGx6Y1ZWYmZJaVBVUVpQeDB5MDd4SDk5TmFtc3FK?=
 =?utf-8?B?ZDcrNWVJdzljV3ptNjZoOTlsVllBR2ZOTkNvM2FYT1Q4eitTWUcvMzZ0Ty9H?=
 =?utf-8?B?RHBLa2QwclRsQ3o0L3UzbyttbjNZbG04MTV1cFFLVWhOdS9jMGhJWjBBQ1Rw?=
 =?utf-8?B?aFZhb3F0OW1BcG85YUJCUkF4cDBDcDNQMldwa3hMTmdKZlRCSC9FWGVFZ050?=
 =?utf-8?B?cnYvUzR3Nkl6ZTB2c2RkdnJTWTZzRFlBSUxEdnQ5cm5Lc1p5WXl6c0lCdi9i?=
 =?utf-8?B?Z00rbFJOekdoU1daa0M4azRGVHBMYlpwbnc5SVRYcEN1cG5hL0lsaE1relh5?=
 =?utf-8?B?SHpmTi9FYUZhcHdJR1hLYm1ueTR6RmFJQVRGM0J5c20yanRpb3JZbUg0RHYr?=
 =?utf-8?B?RlhmQUdPQTJxN1RvZkNkZXROZUR6ZndNN2UvWFg1WGNkMHBwRmd2RmFCRzdR?=
 =?utf-8?B?RlBDTkJaUHFzVFpPSGxVZVBucjFKeWN0VDY4Snd2MyswQVp1RTViSkZvYmYw?=
 =?utf-8?B?NTBzOG5aRlNiRERmZFNTblFiRG1MdUMyL2hmT3dnQmF5SzNrVk90OENWcmJv?=
 =?utf-8?B?M1VqMktaSDJ4cFdBV0kvZjBWaXpNYmNpQytQUlhqN1lZS3R6WjdFTVlYV3hq?=
 =?utf-8?B?S1o0WTFuRDdGc3R4K2laMXJPM1FHRmpHZ0pUUjlDamxsZ1hUaEhITjJKcncr?=
 =?utf-8?B?T0VzV0QrVVhlbm41emp0ZEc1RCthbTVHRktLNUx1cEFNWm1kNUxmeDdPNks1?=
 =?utf-8?B?NUlWZzNEN0pCeGxsSWo0NWtHWVlDd0tFS0xBcm93cUF5TnpPZ2tSekdaTzhF?=
 =?utf-8?B?RDkyNTNlZVFjZ25haXp4S2hZL2JObS80VDF6TmFjMnBYVEhYQnJTU0xwODdC?=
 =?utf-8?B?cGIxcmtxckN4NURVenkrd1NhZTF0Mjl3SDBqeGd3MVpkRWF2TnFoNUFwVU5a?=
 =?utf-8?B?Q3NseE1pcE1MbjNUaktUVTJFRWk5TERuWjgvUUljcHB0NzluNDRyOVhJQjlO?=
 =?utf-8?B?eTU5ZWp5VXFTSzBTMjJ4U1QzeFRxSWR0c2N2TFhpZldvRzZ5UTlHT1hGWWxz?=
 =?utf-8?B?UjRsY1Jzd3Ara0w0LzB2UWppdTRWKzkvVUZwcXNXSC9MNUQ1SWJjZGJtNG1B?=
 =?utf-8?B?SEdiczFndURSVzdLMHUvUm5IT0hwdWpYNjgrNHp0dE13cFYwcjdxbFJrdXpn?=
 =?utf-8?B?K280d1piMkNxL0VOTmVHLzhRVVN6ZkNQTDR3TmtSajB6QUxMdlQrb21BUEJX?=
 =?utf-8?B?dWVyNlRxUDdqZVlPT3dQRTcza0lYYVF4WWNtN0dzV2tCbitkMm9RTjhmWnhi?=
 =?utf-8?B?a1FtNDZrS3dmR05tM0YvTjdBNWpMdFF1UEJzSlRkUDFSL2FES1k0MWZNS2ZS?=
 =?utf-8?B?bGVmTENpYlZHTmN6Z3grNDlIekUwY1N3S25zOEw0RUFLbnZ0Q2ZnOXowTUJI?=
 =?utf-8?Q?1JqMo+Cy718DIydFe2ZG5Vx2Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TXN1eWI5SGlDcnFSQkNPL2ZoTUpOTjFkcTBXU1FhRUhFbUxBVGxnSFJzOXBm?=
 =?utf-8?B?dVZybStxVU50RnE0T093WTF1bFJIZTFqZ0NiczJIUUJwNVp1WEtKQjg1RnJY?=
 =?utf-8?B?cEZURjFHa1NoRy94YmExZzdaOElST1lYSnhPcWN3MzVZdjc2MnFPeExLc0Zt?=
 =?utf-8?B?SFB5ZnY3ZXB2b1FNUVRUTGs1cm52OEc4V2N0RnVqUFJwWC94L3NHcE0wb1Vw?=
 =?utf-8?B?RGhsSXNlZjdTNkx5Q3FXalZrWG9NTUNPVHE0eG5kRGlYV1hxSjRpazBLQktR?=
 =?utf-8?B?Y3hGanJpRjliaTlyY2ZGZ0Q3RFYwTHZSQkdZUXRCeUVFcElQR1Z1bUNlNzBN?=
 =?utf-8?B?QXVDc0xQamwxa2FxUUg0T3N1bDV6QW5jN3hTQU91VklwSW15bEhuTTJyMngw?=
 =?utf-8?B?dGdLWTRLWS95ZnZ6RE9OUy9jempaNDZSWGpXd3VvanpyNnpmalRZelVWOWxm?=
 =?utf-8?B?UUNmSE1ZQWFIRkoxWkovZ1Y1bTVwb2tUQWZqZWVIOHhlQ2JRMDYyV3JwWHln?=
 =?utf-8?B?eWRrSkpzYTlSVWVlSkViWlI1a2dOTnZ0Z1p6VGllaU1ySTRFbUtZQ08xOG9I?=
 =?utf-8?B?VXkxbG00RGs2Y051UGdNWXhSbHJoUlRQdldPQi9pQ2FFWnBSSzJpZUZNM25S?=
 =?utf-8?B?LzFJWFdqRE81Y05pV2tLeTlvSVc3WDhsZkpldmNiS3Z4UVNFc2FtMHBjT001?=
 =?utf-8?B?Z1BiTmR4K3VZU2x1L044NVlzc29FVENXWFlCTlZMVDFPTld1dVN2bkFBQTN4?=
 =?utf-8?B?QUNPanBuWVA0dVB4RmxCT3pyMkRLdFhnL3MydWpvMi9hUVlkQWg4WEpNbHBq?=
 =?utf-8?B?Nk1yN0RxZjdvUDlCQVRCSkNRTk93bEhiN2hnWjdnZlNFeGtTTlh4SEtrVGF0?=
 =?utf-8?B?ZlgwdlVSdWszcGNpdS8wMExzVkNlcS9VdFpmS2p0RS81czFZNEIrd3kvRExC?=
 =?utf-8?B?THIvSjV0cmFkdU9jeVdGTlFsdStTNDBkTW1JU1FGL0NNRDNxaTFZbE55Ym1M?=
 =?utf-8?B?WGxiS3ZYSWZKYTJMM0dVbzhUeXVzVktNWDNtaFlablVTbVcwaHdBQzV0eFJx?=
 =?utf-8?B?Kyt1VmQyT2s0SGpDWndjUDRITDBGczNHZzRZVjN4MkRxcFVwVGdzYzh0TzAr?=
 =?utf-8?B?SnpoQS9ob3h4blVFQldWRkxuVWVyY1VMeDBsRGtSUk96Ty9XNDJqbzZKTUhU?=
 =?utf-8?B?eU5tNkppZTkyTlFUejhpTVJHRk5sNmd3Nnl5bG1lKzJsRnZEUUozdW8ya1J5?=
 =?utf-8?Q?OL+hZmaYFuEAjGV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9479592-ed2f-449e-e641-08dbcaeb1896
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 06:18:48.3459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WIk/pwXDMZCYvxQRQekpTlPNmLI22fIg2gCbzSEaFPJ0MrqR14GVgGDGoggTAFoExERwE+TBZgeWl7mke3h+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_02,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120054
X-Proofpoint-GUID: DuuqGvZwp97mgX1S6ju3_eUDdl3iWm3m
X-Proofpoint-ORIG-GUID: DuuqGvZwp97mgX1S6ju3_eUDdl3iWm3m
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2023 4:21 AM, Eugenio Perez Martin wrote:
> On Tue, Oct 10, 2023 at 11:05 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Devices with on-chip IOMMU or vendor specific IOTLB implementation
>> may need to restore iotlb mapping to the initial or default state
>> using the .reset_map op, as it's desirable for some parent devices
>> to solely manipulate mappings by its own, independent of virtio device
>> state. For instance, device reset does not cause mapping go away on
>> such IOTLB model in need of persistent mapping. Before vhost-vdpa
>> is going away, give them a chance to reset iotlb back to the initial
>> state in vhost_vdpa_cleanup().
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vhost/vdpa.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index 851535f..a3f8160 100644
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
>> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>
>>          hlist_del(&as->hash_link);
>>          vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
> Now I'm wondering, does this call to vhost_vdpa_iotlb_unmap sets a
> different map (via .set_map) per element of the vhost_iotlb_itree?
Yes and no, effectively this vhost_vdpa_iotlb_unmap call will pass an 
empty iotlb with zero map entry down to the driver via .set_map, so for 
.set_map interface it's always a different map no matter what. As for 
this special case, the internal implementation of mlx5_vdpa .set_map may 
choose to either destroy MR and recreate a new one, or remove all 
mappings on the existing MR (currently it uses destroy+recreate for 
simplicity without have to special case). But .reset_map is different - 
the 1:1 DMA MR has to be recreated explicitly after destroying the 
regular MR, so you see this is driver/device implementation specifics.

>   Not
> a big deal since we're in the cleanup path, but it could be a nice
> optimization on top as we're going to reset the map of the asid
> anyway.
You mean wrap up what's done in vhost_vdpa_iotlb_unmap and 
vhost_vdpa_reset_map to a new call, say vhost_vdpa_iotlb_reset? Yes this 
is possible, but be noted that the vhost_vdpa_iotlb_unmap also takes 
charge of pinning accounting other than mapping, and it has to also 
maintain it's own vhost_iotlb copy in sync. There's no such much code 
that can be consolidated or generalized at this point, as 
vhost_vdpa_reset_map() is very specific to some device implementation, 
and I don't see common need to optimize this further up in the map/unmap 
hot path rather than this cleanup slow path, just as you alluded to.

Regards,
-Siwei
>
>> +       /*
>> +        * Devices with vendor specific IOMMU may need to restore
>> +        * iotlb to the initial or default state which is not done
>> +        * through device reset, as the IOTLB mapping manipulation
>> +        * could be decoupled from the virtio device life cycle.
>> +        */
>> +       vhost_vdpa_reset_map(v, asid);
>>          kfree(as);
>>
>>          return 0;
>> --
>> 1.8.3.1
>>

