Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91997BFF95
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjJJOtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjJJOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:49:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84F59E;
        Tue, 10 Oct 2023 07:49:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AElOJj031397;
        Tue, 10 Oct 2023 14:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ZNahRWskOf68tpHbipAclj2L+qVZxUDwB3boZ0BD1qI=;
 b=YX1h3ujKhXQklB2z4kmtohKBAbNi6UiWNz5bbyBETY8k2vpvuL7MNCWi2Ft9SdFvwxq9
 kh0QZLdE5OJS69AP65qRW3oeMB33wLywWVwv+d65TTlMvc8IL8IDNsKSheWlSCWbCbNn
 Ih5g0nx8vDgSC8Q4tq53rlzyWc99I2x/g9gpH/hJ9vmGy+SJEWB7Gwv/pOql+2+wFuoj
 BnaG2gJpKha12ucF+rjlC7I+PAevgVw4zkx6TgFFy46Ela03ej9rVOqKR5/yHwFRscPo
 /F1HuApkpZ8cv92crAHYL7YRQY5G/q/uqrd9iCdoJc5pyV/z+hPDeabxetSovlJanmKV UQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43ncd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 14:48:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39AEPK45020742;
        Tue, 10 Oct 2023 14:48:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwscmg2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 14:48:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBNAtdPr9JBwbnIsBJo1yihzQ/6FOFRvCDAo8Ht87JQJZ97U6CRi3lgR8te2R1dwKIpCsCyySj/FIBNnIxXxqQrcV8Ip+SJrStubWbJ6yoDkGuxEqlEMdvRPE1ZQYMaUAEgIVHl+0Sv4O2p6kCbXVzKpr/VjsL/8aapUTaHjWLkuOdSlsUCB/Ti9IJefSy6OT+5XZDQk8cwKrEg38u7ziAGHJbKEBuzB4whzeD5lwrYdzGrsZlMD79ktsCMGdYMzh/9jTN2vHrrMjqNwysI2UlPiFuK0XYkPXrRHIyxWtfHYZKHZk3LBMsqvB4AAzaveAIvf05lRTM7RZ/8hmAFMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNahRWskOf68tpHbipAclj2L+qVZxUDwB3boZ0BD1qI=;
 b=odJTBEqushAPmkmpVQ3Wew3U8acAn9zeUU9+irYVQ50yVLQMTd3hsGW5/kkxuBHnu8tRrtPYVQyUX48HtHZE936EwfpfZpE3ye4mKKIkLy8G48iO93gcditp6WlbS3zzVd7DMyvSng0+eymibzTT+feRdD89SdvJCPx027oNwihJ8H/ahAzstoPrwSdu825FeyA+8hq5vV/hfBAmnFYbc1UyXkTzkBlRwSiu5HT8NdQgunglK0X3piotIIicp0x9OeUwUQJIK5DX8qlvEj6A3SchRS/76vW3+ru/9MWl+pfMvlMpUE60sBqZvHF7Dz3Hjw9yvXRmbcUoQbzCMqqZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNahRWskOf68tpHbipAclj2L+qVZxUDwB3boZ0BD1qI=;
 b=Rh/9RTIG5BbNu8jkfn7/P83AnCw3WWRwBrLpeSJ1z7US6JzgsWxXwPLPt9vwZ+hptc0hTOx04bdUVqC/0I7X2Ti4K/9a1T8ZTjnyGLksz0WHM+54mtedrwX55E0WxAYZb8qngkT7SLOaBNlkOxZO7TvbY2hYWGF5EX5YwrFPfIY=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:48:43 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%4]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 14:48:43 +0000
Message-ID: <fbf8bac2-95a9-a9b5-8207-8661f8aa5ecf@oracle.com>
Date:   Tue, 10 Oct 2023 20:18:28 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 00/75] 5.15.135-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231009130111.200710898@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db971da-d62f-4f39-5189-08dbc99fffe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnTK2iTvZuJ5OmCDdQe0zE9XwNcbaviORE8tguP6VQlCEzOUDqKXGAzvbJTr1Kd6SfdYLFRYbArH1gAhs1vVPEMqAPBt6RL1XUx2K1rScozgQAKnfIIHY1/rqUQbJQH5XJMBJ7yTQ8mfoGjTaetcgr3uERv44PvOVxdjTmIuxewAlI6cB1pcZt7smQxrpShri0GteyqNVKtHgelvmN6dHCxWZv6E4mdNgVeXzXiOlv8EEWIykGiYSYvbhOQsO0eZYGFG5haxyfhm3OIBSWJS9wRzKF46N6/X6zTrAPXAZ0lTng4p007NxwpM6UYx3+6+p7pgChZZnVxXP/fNhjoQ5jVvQqB+Eq2LQd7IW6NVeeGwnXUzu9P7v59AEYi0dGh118yqMfgpdP+mEaccwUUAGfYoiJPANlU28zBc7Vit7/jmca/lMjYybU8mb+sE/9AvzS2ZDkKgmw1zhSJA3tsvaX25lkpZtoqEtMPaEfjpIBtPLTQrMH9g7o6Ei/mRxc1wVzCfMiXSqSJwAmvjtvYr4d0Ghpz65/lC2c20daHK1CpdP05lrCknyVKQYAOnGPDOKEDNaQG13liVWysYL2h9J9kA+PSp1f17QJjP5m5x+2uLlmc1zqfoJ30VCRQd6HFLnMHrrpDfTXNzCcX201tHwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(31696002)(38100700002)(36756003)(31686004)(6486002)(478600001)(966005)(4744005)(8936002)(6512007)(6666004)(5660300002)(2906002)(8676002)(53546011)(4326008)(41300700001)(6506007)(107886003)(2616005)(66476007)(66556008)(66946007)(316002)(7416002)(54906003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yi9zN05lWFNoYjRHMXlaQjFvaXNydkl4eThPcElSamo2c3RrdjlhOWhOeXo2?=
 =?utf-8?B?YUlqc0hSV2pVWHpkQXB2Y3NxWGtkbEdtZ1huS01DenY3c0FRK1dnS01GM3Bw?=
 =?utf-8?B?WmNJSmRReU0vUnE0REtwSlZPcVpoN0k3M1Y5NW93bjR3aWhScHA4YTFQWmpy?=
 =?utf-8?B?UVBJbWVPWFE5RmVaRG9idEc3RE96Y21RMzNxOGRRS2lWSDRUTm42dDh2WnhW?=
 =?utf-8?B?cTJWc2c2ZTUyYnFTN0REVFJJMzBuMUJKY1JKVG5HSEdaOVpvdkNYenVLRUV2?=
 =?utf-8?B?MC96WHBjY0IyaTU1TWJCZm5Ybk9PemFRNnBGUkk0Rm5GWHl5b2NYbFFZcHZr?=
 =?utf-8?B?UWxoR2lBMnU3bUdwYnllQVFtUGpwdzQrYkJPU3d3VzJmS0srQVZFalVLdjdo?=
 =?utf-8?B?Qnh4bnNoQVoraDYxNVlDaEp3U1I1bmNVTnhpd2dwdXQyMHZCN3pCNEZoWDVx?=
 =?utf-8?B?T2V2ZG5WOTJJVFZPclFoWTREWmRTTURRdEpteStKVFFTZ09XZVJXZEd6d1hm?=
 =?utf-8?B?aktZM2hZK1NqNXZXOWJsczIyM0NUVmplOEhGU1hUUkpiSzBtSGNrUS9TWW1V?=
 =?utf-8?B?TG5SODlVTG9rMkZkZ3p2aVBHdXozbWFaYlRzOWgwZ2daa0pDRmgzNEgvOWlv?=
 =?utf-8?B?cnRvT1FPVmRTYnpkTXRuVDZwcmRCbStMaWh6aHFmUk9wVVM0L2pmOUNWaTVX?=
 =?utf-8?B?ZkNib0daZFRRZUJ3azM1Y08rRGl4eUhJMjhkL1J1YjE0VUo2SjJEOXRJeGhv?=
 =?utf-8?B?cDc3T3h3OHl2a2pvUjlaQTRJT25yY1JkeGJSWnhlYVZpbUFxVW81VUxOK1JO?=
 =?utf-8?B?T01zVFhwYmE1MG1HOGNsb0hwY2lCVDJibUxFY1p6dzB4blk4Y2hWbmQrMkFD?=
 =?utf-8?B?SDcrbExWMnFCZk5rdnQxWUZ3bHViaU1kVXFxVEN0V0J1akhTaDlJZDNlVmQ0?=
 =?utf-8?B?Q011Wmp1eThMWHl6UmZ4ZmpuU3lweERCcnBWblJzY0gwSDFUNjNSMHQ0ZmRP?=
 =?utf-8?B?aVljMEZnQ0Y5Y29GNjAweFBLbElDZnVHSEpzc00xMVJ5aHlpdTNEWkZ5YkdO?=
 =?utf-8?B?QnFXNVBOUDUwZGgxbEdnNWJOL3BwdWl6QUF5OWc0Q29iemZJOVBYNnJFeVRW?=
 =?utf-8?B?N0NEM2piaFN4dDhEVzdOazNFRXZiVzhoYzZhMjh5VGQyVjM4dzY2M05ndzU0?=
 =?utf-8?B?aW5UcmZZcWdSam04WExSbXR1OGNpM0JBbTdBUy9NbWxzUU9EelNmckp2SEdx?=
 =?utf-8?B?eVZZck91aGlLQmxwcHJrUTlvWmFHa2o5UXFBL01MNnRxY0ZNUWQ1KzcrTExl?=
 =?utf-8?B?aUdPY04xbXIxU1dGWjFFMGJEaFNLRDNyK0xBZHNwbTZ0YStnWmhMRGNQaUo0?=
 =?utf-8?B?eHBmMmJDVTNXb0Q2VFc2aWthbEN5MnJicGdaRFVmcitjNjhDNm5UaGNEK3Zh?=
 =?utf-8?B?VjFLbEhPM3RoenN3Sld2N2J3eVZVLzI2NHdUTUhLWitnVlpCbFNzL2RwckNC?=
 =?utf-8?B?NG45REpQekpVQ2Zac2syUnhGb3dST3dyb0tvYStwemFidElZL0R3THRjUUNv?=
 =?utf-8?B?SGN6dHBqdEw1WFhOZHY3V1VoRTZadERvY0xKT0xnTGRmQStkOHh0RDZnam1V?=
 =?utf-8?B?a2g5clhNSTNkL0IrQk5MTU04bEZnVStwV256KzVYcEE4SVpjQlR4QXM3TTBB?=
 =?utf-8?B?cjdzTXBBYitTSEJ3eVdLRW11TWxibjh2dWpHdURvMzc4UjcwalBBWStOeWt4?=
 =?utf-8?B?RXFYTVhRNDFkVlNnYnkyU2Jidm1zUDlMWUd2MlJxV3ZpNk9adUdJc0Y5elA5?=
 =?utf-8?B?c29QUHprMk5BWlVENG0vZitsZ0JpTWdIRHRJbFBwWWxqQlZPS0Rab01wL3lN?=
 =?utf-8?B?Sk1BUFJPTnZ1blVDZFBTQlNnTWtpZ3RidmpsVmdtZmRTb213S3VibDFvNEJQ?=
 =?utf-8?B?ZThXQmM3T3dMTWZFcjI0V2ZXMWpyK3lMem1NeHR5Wjh3ZmF4dTB6eFhGdFZD?=
 =?utf-8?B?VDFUV1lRK0paeFREK1ptdXZTUUJTc1BwNTNvSXFURVloYUtIQXBQSThRVjl6?=
 =?utf-8?B?ZHpDek0va1diV0VtZUJuYklzUEg2a3FCWUFqM1czNUpacnI0UytEYkk3RjJP?=
 =?utf-8?B?YTNnQWxMZ21pK1hFeVpaQ2U0cWE5MEY4cXF6U3Z6VXNJN0lpNVJRMHlBd0ho?=
 =?utf-8?Q?2bcroJcUETmu8RQxgYfXJ+w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OURMZ0hPNEYrT01VVUhlWSt3RC9uT0Z1cFh5V2NZZ0VXU1FLV1Y3cUlGelJ4?=
 =?utf-8?B?U3lBRGU2QUljMUt5OFh6TkQxVGpNR3ZmOHcvMmxwL0FwSGhqN1JpUGZHbW84?=
 =?utf-8?B?cXVHM21Nb3ZKM0RBYXFkUVNoeklJMDJHOEIvU0RhWlVxN0FWN2I3REkwNWhJ?=
 =?utf-8?B?TDhLa1BxNGhSb3FUdFc0NEorMHZXTVlPdmQxRzMzcXZGc2xrOGwySzdWWlB1?=
 =?utf-8?B?YnFYNVM0b2hRNURMOHB2bVQ3V2ZVREoxL0k5UVhhbDVQRkNiMDV3UENOVG1k?=
 =?utf-8?B?RjVYbU1SVTYyR0VDVmg3NVMrc3VhQVRURFFrdGs1MWZJZDNKa1NMVlR4VXV5?=
 =?utf-8?B?YndKUVo0V2lkOWlPd1JhcDlOQTdiODZTTkg2MjVodUg0dFRBaWZqaUtVMTdy?=
 =?utf-8?B?czlYWXg5UUE4ODJDTDEwY2t5RFQ2QUJuSnNETy9VczEwaDl1aWRhTFRVYUpj?=
 =?utf-8?B?ZWdSTFllSGIxZVcyZWRYRllmaGQ2bzNRUGtwWEI2WWFVckN2Y1NmS0RoQm81?=
 =?utf-8?B?WFJXejZzaStLSFlDWDhKUEVocWtQblFRUjV4MTI2Ym1PRFMxNnkvVTRMeFQr?=
 =?utf-8?B?NkVJd3RSVmdBWXlPMWhITHhaQTNzZHR1eXc3MWg2Z1Z1ZXNYUG5LTUpZZ2dK?=
 =?utf-8?B?Nk5WSW5yaTZObHc2QjRuYURsY2pNcTBtNm1iSjY4aU0reUR5UFIrRXFpOHFG?=
 =?utf-8?B?ZGp5Tk5aMHBPV1AyeFkyT0V5V0RxOGdTakxlVXNGWnNEWEdHcVRqbExLUkE5?=
 =?utf-8?B?NEhaYWdKbU4zODU0cnBLbXZ5eUg1QjBGaVFUblNaSU4vdUw5bnNRUzVTOEZa?=
 =?utf-8?B?NnpKUWE4V3VucFd5MWx3dzhEWkNpQlpGQlQ1cWVBMHBEZjg2L3VTOVNNS2xR?=
 =?utf-8?B?NGFNR2RYUWVkWWJTRHdwTzA2dzhoL2lFVGMxclkwZ1pLRVNRN1hqUTYvajE2?=
 =?utf-8?B?Nk1vaEdUM3RtbFE4SkVncVBEMytXMU1pZzYvY2x0MldkZitrZE1Melk0bTBO?=
 =?utf-8?B?QjdRdWI3RWNFRkhUU1I2aUI1R0VQcVFQZk51eTlYNjFhMHcxRFg4SVd2Wlp0?=
 =?utf-8?B?eWgwVFVkRTcrR0NzNWtkS3Njd3M1RjZTVG9ubnkvQVBuQU16d0RydzNmYjJ2?=
 =?utf-8?B?dTAwaCsrZ2tOWWoyYzBuWW9wVHNmdHdoN2ZZWXZ3UU1nZG9ReU83bkk3ci92?=
 =?utf-8?B?OERRVlRhZ3pFSUh2cHE0RVIySVJydzlsOFV1ZHhZZEZnVml2RGI1MVRYZTB6?=
 =?utf-8?B?L3o5RGgvKzk5Z1FmSkxUTWFKaTU1ME9VL0xsVGd2WmZ2ZHRVbEwxQjBGbzI4?=
 =?utf-8?B?b1kva3FFYndOVWRtYXY5d2ZHVVAxOUJ1bGl6RkxqMjNDTjJMMS9LUHNJbFdI?=
 =?utf-8?B?WWI0Q0s2VzJKenBBN2J4WE5TaVlHS2IwaEtvOHFkcldodmVkYlJlUVdiYW84?=
 =?utf-8?B?NFdOT3A5SHY4dG1MMU5jQnFMckVtc2tnUGdrcW85MlNYYlg2Y1c2Q1VQdGFY?=
 =?utf-8?B?RXhLLzZSZ2VwdkxRZm1yaCtIVW1Lb0NqdEhINkNnQ3IxQTExSWpMTTFiWjRr?=
 =?utf-8?Q?FmCcLZ2E3Qp1uzWQNc9svVEzxNSApaR6+yI3itd/sa6PW9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db971da-d62f-4f39-5189-08dbc99fffe7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:48:43.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ore0dGO9S3VcA+TPMl1e1WUPUR8YP/9y4IsuMcAkikjL+dxJPxTs7mZkWl9sTrcB7seiQ9SrpaWO+9nbWSxPMT3hC0tGKb3H+0yqeC9ou1/cHWDSAqmCZDw7kQ1qIhJN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_10,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=978 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100108
X-Proofpoint-ORIG-GUID: NSmNFeuCV6FWdKyKdt3yKR9fRQPUabrk
X-Proofpoint-GUID: NSmNFeuCV6FWdKyKdt3yKR9fRQPUabrk
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 09/10/23 6:31 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.135 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.135-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> thanks,
> 
> greg k-h
> 
