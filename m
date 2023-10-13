Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFCE7C7F09
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjJMHz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjJMHzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:55:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8A2B8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:55:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D7O7Tg026008;
        Fri, 13 Oct 2023 07:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zMlKipKXUic03vHAujcIoBrt5jtjS8pCdVYiv+32mQI=;
 b=KSe1aaHUB5bXp06raHRz1G2YrjbuoOVCRgecIglTcZ1P1q5Py3k7hNGfKpriE1Bjs8h0
 6+Wp7KYvu/5sihkH38xfTX31nh/ensJlny90b7QDoWeG0vqLshTRtk5D5AR89N4zXrAK
 qBT1e94zPfLDVn19mabGC3/bjOHFyFUbvfIetvoK7UTr/vF5Nf639WLdDh0sVw/8eOkP
 5lrfWLAZASCoYt8yfnBnoUtG7Eiwfv/hl4A+XTtx6+2SkZ97hXc6n4L1qdJVStClkRKQ
 WCwp/U6Z7zi398pZ4Lbknblt39vGghEkHCGis4PAMYi6hxJI7lOa/ip3dR2g63Jz9XyN dQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43vh67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 07:55:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39D5TwTJ039139;
        Fri, 13 Oct 2023 07:55:09 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0tg7q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 07:55:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRtHnsHQsfl14S1TRUZ347GLvm3QolAKO2+YUUMlsqKbbOuc6io8b0YKEpzOJJmiihTHGBrJkDz0d2mYzd9AeGwgPSUWX/9ceVSy2ylu/LM2pfj5KLpJgFDmTw3OzapmuWFpP7Y/48wv8TtD/Tf2nfIG9ZOSheertj/8XqhPeKDvJ1KmiwVCnoMHXx5yfn+VD/+He6nwnF4a6OwJ4S3fRX/kghNsWhJlXRKefMZUH7DjDesiKI42QNK8nJ70i0AHLZFXSFVHlHOsx7dwZaDMDqnCZ65fYFH8PAXNCd7YjD6FlSxz+0OJrBOHYE+YPa+HnJsimSPU0YfryoeGr0vYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMlKipKXUic03vHAujcIoBrt5jtjS8pCdVYiv+32mQI=;
 b=YJNjM9NS7r5XO/fRSLp3PXZ0vx9ZcVCclKMC+f3P3pjXIqKlklpuJ6ttTkQsf1WJKOKQeynDMvbGo27J9AiRYqOcFf/NCAEleyxfCHAcy+tBFMCzp3xx9k4nxF7VFeES2whx2BTGVBkA3aOwXuPrGTOniiRHvI4lnXVkp31wOl/e6kB+rm+qT+rQRdsGX/yXIa2WDNdKVjt6S7VVgN1EMeLIggl9XpapricuuGMBB3w8QUU6UJd7IoReaLh5o3UayUlkZG2+Epp+D0iaL9Jt1EsS7/MkbhfFeQh1R9d/rF9Ahc3f188igDGa8GERmqS8t/xUpsF36waP7N/uJ+k/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMlKipKXUic03vHAujcIoBrt5jtjS8pCdVYiv+32mQI=;
 b=kzdvTrIs2YelStAdH5zxMkuWYpgULbDMmofPU/7UBzr8A/HGvTUcpMizyOAeR0Wj6SkikWqWN5a8dfMRz/ClB1mvXql3NdZmXGvankbK8/JLx50gozMKI5C8RlrX0htmPD7JDZvmgmhGTkOa3M+XHW/pAdqmHdE/740O4qmsA4U=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BN0PR10MB5336.namprd10.prod.outlook.com (2603:10b6:408:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Fri, 13 Oct
 2023 07:55:07 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:55:07 +0000
Message-ID: <97cd1765-a427-4981-be2f-004bd86574aa@oracle.com>
Date:   Fri, 13 Oct 2023 00:55:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] vdpa/mlx5: implement .reset_map driver op
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtCasGmTNBZxfu2gJfSMCfD1jtKGH3cb9HCPXFP7YACpQ@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtCasGmTNBZxfu2gJfSMCfD1jtKGH3cb9HCPXFP7YACpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:a03:338::18) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BN0PR10MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 66171f10-373a-4b32-c938-08dbcbc1b738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2avSB+ZjxPY5XmOux+Vw7EdHWpPH+pKhB+FLwKCZp0VLCLK777IYqOz5jpo3YkcQp4kRh5zvm4+fo+8OFDHTdlYinZgKDdCU1vjaRQfDAFD7ijfAHfNjnVFrxtPYGyyhbPJ/6PKPbPyOgyqIF7UI8nHgtx8VeYCc5/5wKPJtOhGDHKAf1E9M+qJN+eGGZLiocMaYRbvYYoemGsMdAEEqrcr2O3JzPTtjdeAsN+2yJzmjhvXkhp9TNPz8pGoF3TRzPOEJ5wBxbIOLeVz5j4uXV5WL84yQCnZP9s6uILVhsnjal09uerFR2mi068bzHmiN2+V7Y+WwHapiPzUryIa5Tv05zbeErtCTkmXnLzhmP8rJE26Tx0V8qVJeJnagxa2VQlHR6W8i/ANr79YsA+7aNnmk9ehZ6sr4O7aFjy7B7FskyPeJAcvOriUpQ+77qzvyCHNmOsyjFw2fs7OVFB3yAT2I4g11LiuowPR8/vkldo1Fjo74UJyQVow140Jud6/prIHWf2BRmoEZj+LzzaoBJTkMAiqx1CDlrevOdZ8ir+QTSgkPGB1KfJ8m9+9WabUXgARLXnLcf5IdoutMqdGotxPVWwDWFhMjmPRB5qlV+6aeBeyjaXb3I7yIczmAAWYYxpsBeJPtF642lLqZarDoYy/y0UH/298rnR8/Ipqpl1thh6Fk/nlqF0rkj/igW8t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(346002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6666004)(6506007)(6512007)(53546011)(36916002)(478600001)(6486002)(83380400001)(2616005)(26005)(2906002)(41300700001)(110136005)(66556008)(5660300002)(66476007)(66946007)(316002)(8676002)(4326008)(8936002)(31696002)(36756003)(86362001)(38100700002)(31686004)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2xtR1l6dFp1dWgvS09rOVZxekp0ZzdSY3Y0K2c5MWs5MlcvMUVJQjEvZGhm?=
 =?utf-8?B?VUFYaDFWekdTOGdOQ3pNUnpqZmtSazhHRDhLTlEvMWl6SG00a2ZyMEFuZGM1?=
 =?utf-8?B?WnU2S3pMNHVnVG5VWkpkd1VzbERoYmFRYTJYbmc3S1lWRFcvY0c0TVdnMnc1?=
 =?utf-8?B?UEZ0NVhjU2hQYitqV1Q5bzU3NGt0TWt6ZUU3dC9VT0szWFZyeVZSVGxQZTR5?=
 =?utf-8?B?UU8rLy9pbHMreWdmbWo4azVuZWF0WlJYanJheFZhalFaclZPdHdMeGlVdHcv?=
 =?utf-8?B?SXJodzhjZHYxVjZpT3NSM1o4WHpBaTZCVyt2c3djaTJ2L2hPcHhDR01Ub3VH?=
 =?utf-8?B?OE5CeDlhYThRUzlxTFF6VHI5VVNmbTA5YXZOemJKMjN4NnRnS0REZkpZL1JD?=
 =?utf-8?B?bE9OK3ZqL0x3NzVobVFCZUFzWC85VlZGNVRERzdVcnNmSlBhR3VVMElIckk1?=
 =?utf-8?B?ZE52clRIWnlrMEQrZEdSK0h1QTVIUWNHRU53Q01HbjJJVm94dmdBcjdWKzhI?=
 =?utf-8?B?bDlaWFd0R2VISzV0RWlRUHdBQlhMbVQwamgySTNVWUFaVlJ4bnordEpqUXhQ?=
 =?utf-8?B?UXczUklUTmRMS1hkbDV2czlUTzM2RkQ1SGlUc1RGcmZDZVgzQWNSTVE3U2Nx?=
 =?utf-8?B?YVRaTGNpb2hzL0xQdzYrRzAvV3ZpTE9YMlcrcUVrb0FKZHg5MndDSVNuOHd4?=
 =?utf-8?B?a2NzNjVjakxqbXZ1MDA1MTJkQjBpa1Z3Q3Vsa0MzVE02cXhkUXg4bDllaU1j?=
 =?utf-8?B?c0oyWjFMRFVEQm1JSi9KeEhwZGlYL0RINGxXM1J6OU8ra2ZmT0VjSUlQQlVR?=
 =?utf-8?B?ODZtR3hNWnBacEJlL2xpT0JXRkVIaWhDS3pmMCt4S2tDUUpSL2l1dmdLMkxm?=
 =?utf-8?B?NitLeTl4aS9Na1QrUzI0SVlzNnB1eFdEQzhsZUpFMkxpWjRucFlZTDg2UDc4?=
 =?utf-8?B?MjVLYWhwR2J4eXB4ZXRqWXdmTDJoRUJGNHNBYWxwVXpmMEx4UTJ6Nm4xUE5r?=
 =?utf-8?B?eE9VME9ybTJHV1pKZXd3RUs3YnNycnAvVXFvT2F4SmF3YVE3enIwVlkxK1Ns?=
 =?utf-8?B?NUNBUzNpa2ttSEkzVUhjVGFFNU0yVTArcHJvMHBSSU14dHRCSkVWOFBVTzZs?=
 =?utf-8?B?aStYT0d4eHRHc044OStvbTRacjRCOHpuUW5lMjBoc3RBOWF4SXQvc0NwTWpD?=
 =?utf-8?B?RWMxSVdzL3lzMUlVeXdXaGNwODYwc1Z2cXB6NXR3bnJoNUk0Y094YnZaQlM3?=
 =?utf-8?B?a1RDYlNNZXJJNTlURHk4Ym9heVhZbHlrbnJwOFpPWkJBWTI2TVF0VkVDUGky?=
 =?utf-8?B?eFBrSHFQK2dVNGdVdnZOR3BVNFc4MVdybnVuQ1ZvTjNBcG4ycjYySkUzU0RG?=
 =?utf-8?B?bUgvbVpkaHVIQm1QMS9YeW9ubEVEVWFZWG5saGsxVWVEWmJjVGN2NzRkTlkx?=
 =?utf-8?B?U3BiZHg2THAzU05sb0RBN1UxU21tdXNGY1pMc1ZoQ2kzdldnd2FwdXdQVGVv?=
 =?utf-8?B?MkQxMkQ1RWJLSUxPR0RVWWl4NDAzMnJTU2pGQWMzb2ZXM0J3UHUyRXBVV3dF?=
 =?utf-8?B?WkRLMUVKUVZvazNqRHl2eFc5WGhBaWl0WXhGemxjTWZOR255aWJuMkU5TmNN?=
 =?utf-8?B?ZDFFQ0FSaVZMS1N6VTVuM0RaTy9lYXFIZWxTTTUyNDVGaVFwUzRaSisrUk1y?=
 =?utf-8?B?MUdLeEJuNDE5QXF0YXZsb3E0SzNiTlg5M25kVU82M3drODlRTkNmWHJCR0dH?=
 =?utf-8?B?VGVteGpYcHRYbU1HOHRkS0lsTlk0a3haSUpjN1pqMUpUbWhhNjRUMTkrK0hN?=
 =?utf-8?B?enpXaUJyY2tUNlNrSTdVb1JmQmxsaVgydndXLzI4VGVaSWIwaWVjYTZjVFVk?=
 =?utf-8?B?QUZUd20xWi9tQTlxTHA0TldXb2swS2tXbWx0VFZ1SkVJNDJ6akNpZWczdEY1?=
 =?utf-8?B?a0dtZEZWTVlPMEkreWZZMlcyZ3RXWW1PakIzc2c5bnZFZnloOVVmMHNmZG10?=
 =?utf-8?B?YzNEUGI4UFpwQ3FqN0xDRUFCeUxpTVR5bEdNTEs0VXBOTHR1cjNkendUVnF5?=
 =?utf-8?B?am9RNkwyRE1Tc285VG5waUZpTFhNakIyVlFjZTBIR0RrcStpVHdNUkl3R2N6?=
 =?utf-8?Q?Dg8SY7koAiNcTAmTEuMytPvfe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VEZXRlhHeWdUSk0xbXZmbmhJazFzQ1YzL2ZVNTRKTW5IbWNEZ2dPdU9YbFVu?=
 =?utf-8?B?QkJ3ZjFaajRyLzFtV2t0WXBkTkJ6cndBVXl1RHJqVlJza0t6RHBFQXRNSXJE?=
 =?utf-8?B?ODNWa2xzTTZQb0FPYTN1dkQzNjF1Q1owalN2a2pjbm40WENscGNlQ3drc0lW?=
 =?utf-8?B?UVJ5SDBVbnJEMnAyMFA2WFZWU1YzdXVvdFRsUEk2a1NXZnRXVXlTbmRFZHBZ?=
 =?utf-8?B?RGkwMzB3QWs5SEZLUDZPQjR5bW9EZmpGSDBIMlM4UXhuZE94L2JtbmMzeUR4?=
 =?utf-8?B?ZWIwZHo1NGdYa2FhdWtrVkIvcmExamFaU3dGWFlkcUxqT0ZvY3QvbFZ2WWRY?=
 =?utf-8?B?M1lBRDVzTExtVXVzRDgvalF3Y05ORVJ5cmk0WmltV1BGaU5DaEEzS0EyR2xJ?=
 =?utf-8?B?OHlLVWZjdWFCNlZhTmFJcUZIeGxDa1FDOUt0YTBmc2E3SzNqRzUwMVk4cFd6?=
 =?utf-8?B?NUVsdERxY3lJcG9TM3Mxb085VUxQeCtuZ2FKa0RES0NtT3lPUTZRd1Y4L2RI?=
 =?utf-8?B?TnhBRWdGVStCWngzQnpmam1zNEtseVo1RE8rMU84cFF5eWhCTDc3dFE3Y0ZG?=
 =?utf-8?B?eXdadDR6V3RyVXd1VFprVkF1enEyWmkxRXp0eStqT1djUmJCTDdQaGE0UEc3?=
 =?utf-8?B?N3dUZ2VDYU5YMUc3Z0llWklld2F2QzRHbXBCMXlUWmdmekY2aU1Yc2dhZENY?=
 =?utf-8?B?RUlMQkIrODMvb3pUZDY4NTRaSFd3cjlTeCtUbmZyeW5vODgxSXV3RGxQTEY0?=
 =?utf-8?B?UERwRXFUVWRWL0hjcUxrdThQcEFCNXk2QnN4dFRvMTBySGUwWkdjd0o3cWUz?=
 =?utf-8?B?RlZ6TnJQZXlmbWoyS3B1SklHZ2p1Q2d0SUdLOVFzY1VyNEJTNXpzYXRETHRx?=
 =?utf-8?B?Vlcvd20rM2tTcHZYbXR1VGxWOGc3WHYzSXFTaktKbU9WQXJIcG1BdU5oN1B0?=
 =?utf-8?B?RmxRSGRHWGRuY01MYWZTQ3p3cUpyWHcyL0x5Q0VrZ1ZWOTBtUlhxOG56Q05K?=
 =?utf-8?B?V3BISW1mdVJHbWR3U1ZZYjZHQ3BpU0F1UGRGTUxrWEo5SEYwMUMrcGNvRWR1?=
 =?utf-8?B?dVNERS9QUkc2M3BuSFRtSkc0SWF0d1FEVHV5Y0tXdW9JeTBoVURmQnE2TFBT?=
 =?utf-8?B?M29lUmdkR2MyNFVkSnY0RTFrNHpIU3ppLzlFMkxMMStzdkVaRnpwTlZrMWJ1?=
 =?utf-8?B?a3ZWYTloYUhRYml0Uk1nQ1B1STdxdURIL3gwZklJeXhkR2ZWSWN0Z2pYN2RI?=
 =?utf-8?Q?z2giAOTOzaTkzAO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66171f10-373a-4b32-c938-08dbcbc1b738
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:55:06.7247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7yW29y70IIeTNimVZhXZ6LHd791oQiqVidE9ADZ51HgkGiadV+/wkmpmvugzAv/AiKS0vr0jsuYnoXB1bN40w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130065
X-Proofpoint-ORIG-GUID: gRaxHhWdXNyNLUCiOZFZd8FY6e8Vg30S
X-Proofpoint-GUID: gRaxHhWdXNyNLUCiOZFZd8FY6e8Vg30S
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2023 8:04 PM, Jason Wang wrote:
> On Tue, Oct 10, 2023 at 5:05 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Since commit 6f5312f80183 ("vdpa/mlx5: Add support for running with
>> virtio_vdpa"), mlx5_vdpa starts with preallocate 1:1 DMA MR at device
>> creation time. This 1:1 DMA MR will be implicitly destroyed while
>> the first .set_map call is invoked, in which case callers like
>> vhost-vdpa will start to set up custom mappings. When the .reset
>> callback is invoked, the custom mappings will be cleared and the 1:1
>> DMA MR will be re-created.
>>
>> In order to reduce excessive memory mapping cost in live migration,
>> it is desirable to decouple the vhost-vdpa IOTLB abstraction from
>> the virtio device life cycle, i.e. mappings can be kept around intact
>> across virtio device reset. Leverage the .reset_map callback, which
>> is meant to destroy the regular MR on the given ASID and recreate the
>> initial DMA mapping. That way, the device .reset op can run free from
>> having to maintain and clean up memory mappings by itself.
>>
>> The cvq mapping also needs to be cleared if is in the given ASID.
>>
>> Co-developed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> I wonder if the simulator suffers from the exact same issue.
For vdpa-sim !use_va (map using PA and with pinning) case, yes. But I'm 
not sure the situation of the vdpa-sim(-blk) use_va case, e.g. I haven't 
checked if there's dependency on today's reset behavior (coupled), and 
if QEMU vhost-vdpa backend driver is the only userspace consumer. Maybe 
Stefano knows?

I can give it a try on simulator fix but don't count me on the 
vdpa-sim(-blk) use_va part.

Regards,
-Siwei



>   If yes,
> let's fix the simulator as well?
>
> Thanks
>

