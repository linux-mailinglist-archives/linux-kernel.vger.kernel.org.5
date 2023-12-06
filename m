Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8E806DC1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378155AbjLFLTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378200AbjLFLTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:19:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2E3137;
        Wed,  6 Dec 2023 03:19:19 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6BEH3u027267;
        Wed, 6 Dec 2023 11:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3nXRChJRlCVTZG3fRP89RGbcfXLDF9DGrneAsfq0Ctg=;
 b=fQZ+AujfX5sEu0EldFk8FUGUMO8TlaBYsYOo6EnW0uXokX60pezWYyBcbAkur42qw/Ua
 akDq4mvb43+iJ437GQab5M0ekKKO/Pf05ykVvKy52PqrXO56+IXzY5Ye+8p+ZUJnzlif
 VsUayueEFRKnqRfI30cOpVvdgoXN38TeEL8huKaWffI98CB+X2czVS3USW1SkbsNsRtN
 K0UOJUksKCmOdTrUw4mkKC9P0+g0p+keRBlAWZd3ri+Dthkrn0FpC/sl2xHra2wGfK5t
 dz+Bkpljh59Dw2wprdPUawgwy8koZzU+sl1mkmRklfQHQJ92wtmH2yv/dzBeF7FXfzQ1 Gw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdc1960b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 11:18:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6A3XRK039480;
        Wed, 6 Dec 2023 11:18:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan5qp2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 11:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNlTVxRrzbYNTKvmo02OeRAF6/EC97XGcpJitUioB0k3rQsh1aWrByyeDXJWc3KvjlFVe7I2P0bAS0OpXtrsDAHJXJ+k+TVYnsfzc7Ct98qy/gNslnoNGcG0vQ7mCqy6Jkv3s0jjJ7AwsCZjTlyIYEQu7ARICXmQFXDwEJWr8wRdohRfG0CnuX8aSGKsvNiKwvsW5ZVMkn/0ru9S17jfAHNviH7vle2PkeGql/X9tjrC/T2jG1XJALgprykU3G2oUVBo3JGKFiDwL268spgNZdl/YxAJDrcBPSS5on895+YWwzT91cTBpOcxxtFsEG6gYtmSzxl/c+snEZrc7/mDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nXRChJRlCVTZG3fRP89RGbcfXLDF9DGrneAsfq0Ctg=;
 b=GrsLxXjBrRPfXos48huwL840dVRvp+DALrtTtcZDFNUG+1oZ6YyGJwYbMXHocWlDY+sssiXg2flLMx3X0xkZ/lUWFr5pwdF23c5L939GwUIzaiDH2mkU8SWH5Owbzvspq4kj+duUrhQFxCf0Ivr4kQ5Qj7CePHB+ODMcf9gCMKgOxNTC/EnizIFC9lgCBSEBIyZkdWrmgRSb9LR3KaiQbHtdAdK6QPAwBzqKbubYReUuiWDeo1ROh/Ommdcsjg5dSBmX4aWViFpqaj1OaHoYyJNMnec1yGI/STf3HJnzdTdCkKI6wzMTuAb3FL9EF7lea4XuGLrRnLJCODizF705Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nXRChJRlCVTZG3fRP89RGbcfXLDF9DGrneAsfq0Ctg=;
 b=rt4EHL8fZAoJMDgLfi2JyUbOW9hRao/3obaL5OoHmQG/Jc8LHkf+YqDQ1wda9D4i2KG0ncCIGNg1pWTDm+qvh9PrGx0HMfti654SOn/vV/PNMgvwYN2QkKeAZld0khBe8ZEhgyr9bvyv14kIunsVyzQEmQAJQkb3DbzKLxLYF7s=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 11:18:43 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 11:18:43 +0000
Message-ID: <8519d15a-4710-4e37-9683-888fda22e758@oracle.com>
Date:   Wed, 6 Dec 2023 16:48:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/90] 5.4.263-rc3 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231205183241.636315882@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231205183241.636315882@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWP286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::20) To SN7PR10MB6287.namprd10.prod.outlook.com
 (2603:10b6:806:26d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS7PR10MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be3e607-7a5d-462b-704a-08dbf64d1b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmbEtWG8uibLTIlik99aeMDacTrbDVtcyNaxPQHaysIgpgMvsih7KM6pVYjBFfY2OcHU7dABIWZsyOQWCXFO9Ek+m4f/VTxjBZaO1j4DayQfdFdQF0XtRF7dO7l7FJ4wl2CYKdkYZzfg10WNICjQ2vHQzZz3aoDMxzr3w13Rh1oGD9nY8Ml8r2CmTY3X7rq4MyRxn/mqQiCQpEuX0RjBhj2DJ8LsVB1HeMcyGPECWnaSVtcJCpa26XdoMZTOJSPOueVxNG5rctECZu/zWqg1fYxbIium5yFRXtkRML/XCFFHoiF8Sgn1rB962TMLHlvWoGUYD6LhiOuRb0wBPIkeYceH0YDr72cChu9Np0gsKHe0HVKx+3CCPKcpKcyCVNAkTL5riLkMUypFJCNH7qY432y/yQOA/UveE0MRqo7MKcUuDHW3sGe8SWK1dyfwNWoiZ6AoLWUooVT/KjJgLCAGCGuAM0MUybRMU3RzSl7ozbBjYirGkVIffUkOdjEg/DO94R+ZNw6QIpfoX3EmRS3ndfeZT1tGunb1G75UPoSKhd7excfo6sejPoBQbX21IDRIxbfJzzBhC/7cWzHLTDygcIfXPGJrVDmGBl0oG/3QZmYhI5LSoRBlugPxbY3MBe+7odj/6PfO7aDaRCjbU2s0tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31696002)(107886003)(31686004)(2616005)(4326008)(8676002)(8936002)(6512007)(6506007)(53546011)(26005)(6486002)(38100700002)(478600001)(6666004)(966005)(66946007)(66556008)(316002)(66476007)(54906003)(2906002)(41300700001)(36756003)(86362001)(7416002)(5660300002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDhGdGo5K3lTd2pZTkhDdlRiM0dNRW9TanV1NXIyL1RORXVwQW1QVnc2V1VY?=
 =?utf-8?B?RmhCVXpMNW1jVVZLRmpFRkdwVGtBa1NTVW41VnBnOThuTXRvZ0NUVnJEM2o5?=
 =?utf-8?B?QzVRQ1p2SWpSdWR3N3M1N29QVkpvbk5UWWlOQUZhRWZrampUaWhJQ2lnanpU?=
 =?utf-8?B?R25reG9CRTVMMmdpWktXQk9Bdi9jUzRLcWt4aDZpWmFiZ0pmNzBacFRKMVBI?=
 =?utf-8?B?Um1rRW1jVnlibWRIMTRRanRlSXJIcTR4dDhjN0w3TE9uL3BUaUxxYjlEQTdk?=
 =?utf-8?B?dTFMekdHTE15TmlVSitXdi9zS3FLWnI5bTRJNFhROWVjK1JrOU5tQXVxMWVP?=
 =?utf-8?B?ZmRlR0UwNytXSDlQSXBYTEp3cTRHQWYzRUFaRUZZTTVtQ1Zhc2hUcllIM2dn?=
 =?utf-8?B?NCs2NnBnemNzRnd3ckZISnJkbk0wanNRSE5pK25jMm14Y0tJQ3pxdWFPek5p?=
 =?utf-8?B?WDhBbWloZXNSeDE3ZEpwd3J4T2FySlMveVZCWkU1aW4yZUYrZHBDUnZTalhO?=
 =?utf-8?B?L0tMNlVoVmoxMHN6MDlaK044NG5zRXJZMThJZ1g0aVYvamtSRFhIUEh6ZGtn?=
 =?utf-8?B?Wmo2K0RDVmtQaHVmY2ZpRVp1V3lIeE9jZlhzSUJuT3RzVGFMZDYxbUkrZFB1?=
 =?utf-8?B?QzVKZ3N0Wi9BZDdhRlpaMXNMdTJ5VzM1REdPWHI4OUJNSDVlL1B4clNFeERY?=
 =?utf-8?B?R1pkZVMvZ2ZnbnpQZzhsd1lrQWh6Qk5MbHYwU0w0ZnVYNUJBclF4WmphYWFx?=
 =?utf-8?B?TXNkR2dyUGIwVWwwTmt4Y25yUVNXN3RDdHdUa2pBRzZoOUYyejg0VjE0QUFl?=
 =?utf-8?B?UTNLRzRzUERuQThnMmhzSHV2N1BhSVFGZUc1cnI1cHVyUDVNaXBsS1JxcFdW?=
 =?utf-8?B?VU42Y1NYQzRPdHBTVVNKbzNqMlc3RThYVDBSRHZHa3ZpWkpEWXRYWVhPTHdI?=
 =?utf-8?B?UE13U2d5Uk1IU3ZjblJrVklkdkxwV1RKb3lXc0tSSFdXbWVXcGkwa01xRmY3?=
 =?utf-8?B?TGNBUHEwdDVjYTYxdENwN2xUOTZZWldaeUlJNlRVcHlaY2R6Y21VQzR0Wktt?=
 =?utf-8?B?WWJZVG5JM253TC9GQlgrSEhRSy9hOU5rOFBLUkRnSGRTM1pINjZRdXJQSFlP?=
 =?utf-8?B?VHZ4dDk5QldaL0lMbldnK0o1cXYvWkRGZlBLNnptMUlOTGs0bG5kK1Y5czk1?=
 =?utf-8?B?NGwvZVJlZjkrMjZmQkNmcVRiMWl0Q2hSQndVQmpmVDNuQ3FscURtYkY0aHZC?=
 =?utf-8?B?QmU4SWhYdUQ3eXV1eDhORG84VHNzNHVKbk9kZ3lPV1ZUektkUjdOUGFmdDJN?=
 =?utf-8?B?M0h1U0FkNmZzL2hnTUhxS0t5Vi92TVFmSENDSzFJMTdnaGMyM0svL2xJRGov?=
 =?utf-8?B?RG1kWjMyc0FwWjZFTWpDZTJ4Z2d5cmc5SVFUTklINUxYZGQ3WVdta01kZE4y?=
 =?utf-8?B?YVZ3aGNTMEppNlhNcFlGK2g4Z24yQ2FFY0Y3UHQ2YmIrY3pOZmFMVVNhRWg0?=
 =?utf-8?B?YTBXNklydXdPc2ptaFB3QXFpbEE2enE1dWgwb3o1dHJjdm1lWVUvQTQvUEZi?=
 =?utf-8?B?eE0zU1RIQkhhS2ZxUGpldHVXRFhhSG9mK2ZJQU9Sek11VDUwS0JWMUNwajZl?=
 =?utf-8?B?WEduUStraFlqYnEraHNRQzRZcUE5NkI2SEx6S1hYK21yZUtBTDBVa0UyT1Fo?=
 =?utf-8?B?ZzM0c2poUHQvZjN6UG11VnBGVEhEQjg0dk0rK1hVTVE2cCtaRFhtdE8rYlpQ?=
 =?utf-8?B?M2Y3NFNISGxuVnk4RFJMU00xdzZVQngxVEJXelVhRmx1aVJKbmpyZ1MzSVJh?=
 =?utf-8?B?SHpNVjdzclhGRnJHV1JIVnp3emlSTnAyWDJmRWZNbDFURE4vRGhobVlJdmts?=
 =?utf-8?B?UnR2NCtvc1pQNXY2NmlaYnFodWFXOVc0YnBQbTdHd3kwSVZIQzB6Rk5TcTFV?=
 =?utf-8?B?NUxqUC9RMlpwYTY2eGNaZnkxSCs0SWpIdjdUQytiODVFMG1uS1FPV2twTU5M?=
 =?utf-8?B?RHNqRU5jbTlDazB2MVhFNEUvKzIwRFQvTmJXZ0FWWXdEOFJMV2wwdzBRNVdM?=
 =?utf-8?B?ZG03OWxtSCtZMzJLcXQwV2d3dmRoYytUWGN6M1FKTU4zUzhRc0dmZW9kNVJM?=
 =?utf-8?B?VHFQbm4rM3d0OVBxdEJzWFBSZ3RuZHZhSUtuRjNXWC91d3RITWZ6LzdvY0p1?=
 =?utf-8?Q?hnBYHQtmwlrAKuffor46SGA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dGVPMjdmNmlldVMxTDQ2YkRLSThmTjYwbTFuMFVpUU5PVHhCYVh5ay9wY21S?=
 =?utf-8?B?UWhuQ2hnY1NhNDJNSnE2eHpQcm9BVGY1UVRVMWZrZ0IxcVBYUDlubTEzTkI4?=
 =?utf-8?B?b1VNQ1lKRHhuaW9mYnpUZ25EVmtodFBRV3BSQWJNUjdxN0VkQlduSEthRzl3?=
 =?utf-8?B?RXB3UERiY2FoVjNUU0MyK1Rnamh1WVprWU1zL2xLbDV0M3JBTTk4YVVuV0s1?=
 =?utf-8?B?aWd1K3laVGpiQlZKZVlSaHhVbHo3S0FsdXRGNFVBVjc0bTM0RVlyNXRRTFlk?=
 =?utf-8?B?ckhMNDZ6Y2dTdW8wT3ZyMHFDOUgvSndSSlNEWVoyVktNaW55aUFzemRienZr?=
 =?utf-8?B?OTJQZUh4a1V4M2h1MDkwcGFmRmUrSUNvSnp3M0hNeXVYTHdYdTIyRGg2dURj?=
 =?utf-8?B?cHlOVjZFZ25MUElTZ0lKckt5VXNXOWUvTnhkL2xmbmMwN3psSjR2V1ZwSkh1?=
 =?utf-8?B?WWFxcjJmWlplZVFRYzd2b0FVTFBpZkFCdjNEdGo5RWlpLytyTFl4VEZQalJv?=
 =?utf-8?B?NXZEcG1sWlNhMURuWmpoU1l2dGdkMThJbTZsTkJsTlJSM1F0aFEyWmlHcmNj?=
 =?utf-8?B?ZllLOVJSY1REWTNlZFFZWEdYenBMNjBGNHgvVlNGaERDUUZLMmFiWUNyU1VS?=
 =?utf-8?B?ZUJuc0FpOHNsVTl4VGRra0oxb3lLb0ExdVlQeFg4a0tiTDA1OVIydDVFNVJa?=
 =?utf-8?B?Y0FxQzR6NnBUK1NIblRHZmtUSGp6R2JIUWlDbjJQQklsMStKQnJFaEN5MHJt?=
 =?utf-8?B?WEtXRjFpT3BFVkVxaU84WEJ0ZytZNzhKYWEyMHdWcnkxNW1GNXdFRzB5ejJX?=
 =?utf-8?B?K1oyalVxalFmQ2k2L3l0Qy8vVm9RZFBmeDA0UmlMMk9qaElEd2dGSUlScy9n?=
 =?utf-8?B?RXVJTXNyU2lsRDRVbnRCYWtVTDVnZnZIK1oxTGdvT2RSMEtqbXo0cFdDaXNK?=
 =?utf-8?B?SkkyOHArOEoyR0k0SFhVQmVLTVJqV0ZSaXpLRkROVms0aEd6THZZMnN3U0Jy?=
 =?utf-8?B?cjY3Z1JsWmFxM1owbktxN1pzbUlJY1lkNGNCWnR1MWZPQlJzV3lYVmVxYmFR?=
 =?utf-8?B?UUVyTVdoeW5hazB2ZTZQRUZLTkpOOFI1eUlubkxzZlJsaHdWU0pWZGIxVW5X?=
 =?utf-8?B?NGg0Ly8xdU5DTDBQNWhNRWtRbXR3MVNYZytQN3p1WEMwSlpFZHdqeW5sZm9B?=
 =?utf-8?B?U0t2RnZXdHp6dmRaUmI5MnVFK0VrMlExeWZFQ3h5aTFUM1QxdmdUd2ZrV1NR?=
 =?utf-8?B?bEM3K0NqUVNKWU9qVnVjaTdnTWxacUo3Z0Q1bG54MFZHaXpKa09SQURYVlhT?=
 =?utf-8?B?c0lkU3VIa2wxY1JKbGFQbk1oUDd1d1V2QzNra0R3bVlGS1p6ZnAzYW40c3Y2?=
 =?utf-8?B?U2hQYTVYblpVZEFLUHZpWEhTVWwvdHd2Y3Z1U2RqRm1saEFXNk95dWl1RDkz?=
 =?utf-8?B?MVFqTktxRlpTQ1ViMWN3c3g3OWZsNitCU2VBODhiN0RVbzg2OHppLzJuTnZI?=
 =?utf-8?B?QWlvSERWQkJlWEwzZHZtS3FWWHFLS1E4cmwxN3FId2N3UXNuV1U0SzJYMkc0?=
 =?utf-8?Q?ZWN/pnxry9g4/4KtxdM8sG9nQAbRTmRI1Gy8J5frL5+l4p?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be3e607-7a5d-462b-704a-08dbf64d1b12
X-MS-Exchange-CrossTenant-AuthSource: SN7PR10MB6287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 11:18:43.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idi/HTxJoiWUabM6j7D/XJbWc/3bj3mW6jARE80OXJGjreBhttZOYWLQXQ6hpZiowmCr2j8LSSfGzGWhmpYLx64BxseOThXmLY2Z+nw11qebI4s52LOULEfMo9KOtAhZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_08,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060094
X-Proofpoint-GUID: C3XLWpRRF_jImk-7jCMMR9WX_6sc_3jE
X-Proofpoint-ORIG-GUID: C3XLWpRRF_jImk-7jCMMR9WX_6sc_3jE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 06/12/23 12:52 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
