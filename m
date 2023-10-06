Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4207BB561
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjJFKiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjJFKiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:38:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BE783;
        Fri,  6 Oct 2023 03:38:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3969EfkN020138;
        Fri, 6 Oct 2023 10:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8VXDKQT2UO5UnYBxNwWFi1cux+BRsFpgwsRFMfMCVY8=;
 b=hDAFFacB5zYRdExWK2yBvWdjWkQqkom37USKbi0nFYv3fDJtA3UnQWcsa7e3tL500IlY
 BvvEcToWUoBfNLiwRoLYqiFTGIJHk4GLe4VGJ1Y2L3xHJ8KHD2STPybY0Kgdnh8t2BVy
 e9gpguNYjjtw4mGkKmxRctpoL8Pl9XE5/cZRdKkUy3gf7YeHS1Om33H9IsnpJ1xwASbE
 AFDWdKN1b/cCozJgpBDv3rdWd3N3mtWfRjc/Yn7G27aG5FAbYTZ+5CXUVmukr4RGU+pZ
 Z7uLF0eUA87u0wzwm9Cy9jHuX0x797UMiNTYSZNVAxRUAhDJ4ux1uPO/UDaV7gY62ZM5 kA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3ekj4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 10:37:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3969eoH1005786;
        Fri, 6 Oct 2023 10:37:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4agasr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 10:37:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ozv2naDGd6y7DFyUL6TuOkpK0DYQI2g+4BadTVtbGpFcP7oUo8ik6xrHuWiuBLxPNKp0W0uiUxzfBAafcVskNvtID2quZZdydR5BzxMh92T0DGjTqoo3PCGrIx6brx9Xr1GevT8kLGuDSjqurnao4Hgdm+gL23vcEXPVayfrS6EDGzjTi7BJvMMWP3Z0H4NEv6SBceHKh8e/mgHrCCzy9BQJW/pN++C3Kl/EAq2mH2goDjGCys/TItR3kKs+tStyhSMoUzm/uH/9iugXFHIGIgKQOPrUkNpP76Uo6QEv8T6QjCAXvAIyfEmbxt60AdPlNx+pP7++KJ9JAStMPLuwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VXDKQT2UO5UnYBxNwWFi1cux+BRsFpgwsRFMfMCVY8=;
 b=beQoO3GKhDDfETaBUFiU/XcpisroyT8feUApnJK6tApCyLCb1K1iJ5hd3aw2HQYXgi/oFWuHoxv4Pvd6mXvFmFS9wuVJA3zq7UXiBbxW5E8OSQvc3i+tehgqeYa7N90/52gko8/i29/odcs5r7YOykw8sOyN1lQr9Jx8/puruVLalAV/AgtfN0IaVbBys0IdeXEpPSq2gREWekEb2ovhC0ie8aBim53HAo+4CwyXIF1gokn+0xjWLJe9fD1Fzu3yo/AjS59oyiF4pmNxkxVLTk84lz4qk+LiUYfhNQIywf9PSVfwVRoQWv7t0a7J99oG34THcqUvXBaWJMpvnj7kfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VXDKQT2UO5UnYBxNwWFi1cux+BRsFpgwsRFMfMCVY8=;
 b=AP3wDh2wlQmwXN6gpuMXCIWYytn6/4Hry1nxJWIaiBsR8njQob5v1iYKi6MjZWsIZUVjeKJAB5bNd8FfmaCB24boZWwSx8HowG3bM/C78dgiphxCg2gIWxRkcSzugnySjQayo2lgCNi8LQrjsq4/yX7fEYrdcQ6rcv2H1cuhrX4=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA2PR10MB4492.namprd10.prod.outlook.com (2603:10b6:806:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Fri, 6 Oct
 2023 10:37:26 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6813.027; Fri, 6 Oct 2023
 10:37:26 +0000
Message-ID: <9fec75ba-a319-027c-6cf2-b65e703d3ce7@oracle.com>
Date:   Fri, 6 Oct 2023 16:07:14 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231004175203.943277832@linuxfoundation.org>
 <ec06c2fb-6737-489f-8439-307e0d84687b@gmail.com>
 <2023100601-ending-prevalent-c8d4@gregkh>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2023100601-ending-prevalent-c8d4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0013.jpnprd01.prod.outlook.com (2603:1096:405::25)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA2PR10MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: a56cec36-c540-44d0-5387-08dbc6583b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kzf9piwK3RIcGgPpEXrj+O5C8B7ZNN2/1an1/Ka9M6/W07oHl2v8oQHPk4C5yl7PNQr/IJr9cpwXm2wk9GKmM+jeZhW6A0TUGuwyWtTSqtkpCYsjRTbo40pUMl4dqMfkYtFqydvi9Cc41vRAf0qaJNyTufGjmnKP/HDLDkKtdjjo6zwxz7VjMNY3O2urzP5GCP2lxkSkgYFX5nO2AV3ZY15ovrAS3ve75YVy4BGsUnbTqV6oKkrdTiQXRpr4fPYEMjxh2dZ1MPKc4+UgboxQhdyhoXO/8KvmPg219AF4ECOCGrjwe3onvoDZly7BIROjQGE2shQCiFx/eNQCso9Bb9ve9sAx6Y5SxLayOsi0CrUeFMsSE6OZ8+hmccmVDJw+zn6bEqIL/rURGFaOVHYqLn0oHA2L/mxpaRgxwTgnlld+K9LNWJun6i6VO3xgNYUdlQFmU2bsuEpsYX7CI0GJCI3wrLFnSBQSVp3BwJSpUyVtsuJsNNMzohkWp0LdReBwxvR6mwv858a5SjWEmsfTNH91kWy3YAowFD1MJbgfUdrV0GOHYMoT0V4Dfxuib/QQx9A0Dz5lhjKwaF+XMA1ECNBt5VX1s8wX23taxvt4OfArSV6/fdCBNd7objFKbfEW82YJ3qDuqsEWXG2xh2z4i/6ODS720ZB7SNHICxb2k7PScrxtApikRrMxwD4CSZYu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(83380400001)(7416002)(2906002)(110136005)(66946007)(66556008)(478600001)(66476007)(31696002)(86362001)(31686004)(36756003)(316002)(6512007)(8936002)(4326008)(53546011)(54906003)(5660300002)(8676002)(41300700001)(6486002)(966005)(6666004)(6506007)(107886003)(2616005)(26005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzcxVU5ZSHAyaFlqUVF2WUowaVhWdERKVFJ5cFcvNVpZekI5a1hsV01xQmxB?=
 =?utf-8?B?L3ZEZFhPbEdpazRUeGk4Skl2dWdHeE1uVWRTNTNpaU9ISXU5VzRsYkFxcDlG?=
 =?utf-8?B?TERZTG9NWkU5RDV6WWNtVjYwWWppQm9XbSthZTA1Y3RaWDV4RG80dkt6aHFS?=
 =?utf-8?B?OG1YOEZUek94NTBjRUFsVkYxUCtkRnFoVDRtajFxSldtVll4UlFxMGp3bFZl?=
 =?utf-8?B?MkVxYWxFYXYzUWsvNmlEdnRWVDlxK0NYUTVFalpNZUxFKzZmeW56RFFqTVpp?=
 =?utf-8?B?a2FZZGF0aUxla2czaER4YW9wUUdUSGx3alJlaGdwSDhHZlEvTTJMdncvNjhN?=
 =?utf-8?B?MmFUTVI2SkhyM1hUZDBoVDJiR2xCdEJJeE5OQUNUR2FQeENoMHB2bFNrNE55?=
 =?utf-8?B?b0FFVUtwUEcxdmk2THNlRzdEemM2YSs2MmY1bVhCekZJWWZRaHpvY05zYnNv?=
 =?utf-8?B?YnRldWI5WFhJL0t1K3NaL2daaTZmNS96VWJOdzFtRHhFNEZENGVVWmNhRGZz?=
 =?utf-8?B?WHU1RVNnVXZla3hJdkExOWRUSGcrMEFQdXRIaHBpRUVtai9PbG0xMDNsNith?=
 =?utf-8?B?enVmRHhaOXRJcHIzSTAxYUtPSmFsU2p1OEcwcng5eTVES0tYK0Vid01NWDJx?=
 =?utf-8?B?TkRVMHNJWmJYbzJEK1NSR2YwWDhBVlhwN1ZtQldLNUgwOHQycGp5b1RVWjdL?=
 =?utf-8?B?UnU5a3J4YmsyY0k3cU1hMWc0SVVlSEdhcEVzMzFZR1ljL0x4NExPNXhMbDVu?=
 =?utf-8?B?T0VhTFdmUGs2bGJoSUZuWllRellFcDA5anpMUXRuS2VLei9SUnFvc2RYblFz?=
 =?utf-8?B?SUtGYi9Dd2Y4cG9lcDdDL0dnU2VyZEJOdERZbTlKcTM3alF1bllNUXI5SVFT?=
 =?utf-8?B?YWZoRFJwdUVkUnNkK0dXZ0lRbjY3SlNxclBmK3c3L3dGeVdlV0FZaGxrU1No?=
 =?utf-8?B?L25QWEpkTzczZVFrcTN1bG5QRzRhbHZHeTkyZERyNE8yNmNQZ1JDRGlTSGN3?=
 =?utf-8?B?UTlUNGJVVnhDd2FuaDRWay9ETDYrZ3NvYzJleTB0U0d2OURoRzBMRzFBbGYx?=
 =?utf-8?B?blNKSzR0eXRibUVUWUE2enFvTUhzekswS0M5UjFUNncxMngrUlorVnhCMy9Q?=
 =?utf-8?B?ZkNmeGtQUWJlUzhHQ2trcEVrTEMwMVBKYno1TTk5UUJreFoxbUd6Uk9ETXVp?=
 =?utf-8?B?dVYrOHlJS2h0Y210QTE5M2hHeldCSEVOUG9NbGVCRXZ0TEVJOFpvd0o0ZmZB?=
 =?utf-8?B?amVKNFZONFJod0Ewd3pqclhVa1J6Y2duS0hXQk1KRlpkZDltamd4VlR6MjVD?=
 =?utf-8?B?Yjhra3VtTU5pMjVtbE9KUUUwU2hibkI3UnpZNmVzRE9xajFwQU9MRld1cmlD?=
 =?utf-8?B?a3FlajRxc3BMdy8wTXRmdVA1SXM3dSs5bTNOVGlQaHR6TDNpVllZMVpEaU82?=
 =?utf-8?B?WmR2LzFsVlcwaVlxMVAxUlJVc2hBL25rQXEzMU5tT055OFJLaTZHZVdVeXBU?=
 =?utf-8?B?dnJnaU1sajE0Umlhckd4SnM2VFVuN3MveXlCR2tsTERTa3E3YisrVDFHRk53?=
 =?utf-8?B?NmJFUk1vai8zMmg5MFRYN0kwK2l5enoyTEpKb3k1OEFpbWRmT3NwOTVjekE0?=
 =?utf-8?B?WU5VbWd0YmRibVcvN3pmWnlVc0YwUWdHcEdrUWRCWGhBOWJLSXEvdFZWdksz?=
 =?utf-8?B?V09ySlNSV3BPT0RqVUEyRWl5SW5DdkJ1MWZrQjJRS2JQVFdMVStQVEZBRi91?=
 =?utf-8?B?SmQvazFYTmVNZEwveGh1WkFNUWxMa2FMK1EzYkVhZjhoaCtlaGg2Ym5EdnRz?=
 =?utf-8?B?NFFlMy96bUVURytITlpkVFh6YzQrWEJuRjlNeEk5VzU2andqSDZ3WUw3alZ0?=
 =?utf-8?B?UWZ0bE1kR1RFMHhUeHp1TnV3QXVJQXBEa3dkR3Zvbmgxc2UxQW1tNFZEQldq?=
 =?utf-8?B?K3dLS0hES28vL0p6WG05SW5VWUtNUGFjWG51Nno5b0U2enN4c01UWktDYm9I?=
 =?utf-8?B?aHNpVHkrQ2kyMjM4a0hQRVE4Q1Z0dnVzdTBVVU9iR3VSTmhlZ25Fb2dEYzhy?=
 =?utf-8?B?dEt0NzV5a0E1R09mUWo5TFdLR0lWZENMVTZFeEFzSXRvVTgyN3NYbWpxdEZM?=
 =?utf-8?B?NVRzc2RsOTFkZVp3QVQyRCtYdjRDK0dIUEZ3WWdRMHVsTFRBWEJhdVBIVlVm?=
 =?utf-8?Q?u0v1+gIBtfXXTavHnAu3R2w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bHhlLzFTbXFmZVNQTEk0V2haMnVteE5GN3JrbTJsQzBZOUZSR0lxZ2VlY3BU?=
 =?utf-8?B?UmEwZzM2TVBISmExekJYV1JBRWlGMUlLYXFaSHIrdy9ZRklSR1F5VTNWc0Qr?=
 =?utf-8?B?UWpUM0ZESEJmTEY3WHZDVDdUWkViQVN5Wk4yOFFUOGE3ZE1uZ0dWL1RySnBj?=
 =?utf-8?B?VE9HYWhGT0tnbmpzVjBueWRicmxObTgzOUZSSkF3djB3a0V1c1d1a0d2THNv?=
 =?utf-8?B?Y2xSR0JncDRhS3V2ZG10K2JHelZ4TG0rcktVYjY5aTlBZHl5ZnRMbk5iZS9y?=
 =?utf-8?B?bkliY1VNekJuR3E0UWJacVFOZTNoMFk5NXVLNzRBWDVzWUt4TmFXM3BWcGJQ?=
 =?utf-8?B?TENOYzNrQThHcGdXbUZWNzl0SzFkVzFrMTd6MVh4M3BiUFBSeHVzam80R1JE?=
 =?utf-8?B?bng3Vkd0V3BlMUhQOUdHQlVkNW50VW1LankzekdGTDR4N3lEY25RZVdwZDhE?=
 =?utf-8?B?VmJNRXNNQ0tjZC9ENjQzZEFuWGhTbFduTlpsK01nOXJJeXV1RmxtSXZiejhv?=
 =?utf-8?B?NTh3eXdmZ1ducENKM1p3aG94WVU1bWpSN2hNbDVDenUvQmtQUFZCK2VvVjBU?=
 =?utf-8?B?eTg1OTArZ09BVEJNZU5sNW1ucnc2VGhnZXF5eVBPNTJoRSt5dmpxSEk2QjBM?=
 =?utf-8?B?ejRYUTZtdFZsQk1UcTZod25Tb3dxNnBqRnQ0Ti9vQUNNbXVtU1pOTGhZQkJz?=
 =?utf-8?B?WW9iNGNJN21YYW1NcXhqaFFwYm80RFZWOHRXM0t3RWhkZW8rMmJDSTNnWHdj?=
 =?utf-8?B?d0NGSm4wa21hQVN1QndwMEpZZGoweHJqdlVzT3ltV2NJdzM1TXp0UlFLcXlm?=
 =?utf-8?B?SGVLVEcrb0VxV1lqTHIyVHMwZXJoaUxaeS9PN2lCT3V4cDZRZHVyRkE5dmpt?=
 =?utf-8?B?ZnBXeTEvQVpQRC8xZHg5STZOVTFaOU9SZWNpNWYwdk9xVm93cWFNdlczd2Jo?=
 =?utf-8?B?NUpnRzR4UnN2Q1RjZjMyL2ZmRGRXbzJocm1tWHZRTVIyTlBGZ1hoSTE3Zkx5?=
 =?utf-8?B?YlNUK0dlVmo3RGhaQjJ3dGpvRUJVN3Bzd1RzM0NJZ2dzWXlZbnlaQ2QxQ2lQ?=
 =?utf-8?B?OWJ0ejZyenVubWNqL0M3YUYwN2J0YjRSNTFzaFU1SVM3eFRjUG9vOUVNYlRZ?=
 =?utf-8?B?eFI5T3JleERQV0lsNk5MVVNCZFplNlFxN2xsZTZUL216bm81OTI2RnZBdC9i?=
 =?utf-8?B?UlNJdnpSdkI1VkRvNUxLbHBWMkoxUXBnL29PNWhQZFVPZ1dBRXRRV0s0RHJB?=
 =?utf-8?B?VDhlM05QUzZ1ekpMU1Q4Vk9TVEhuWDFHTVo1WjNTeDEreTMyT1FMbFFhZVBQ?=
 =?utf-8?B?a3ZHVWJuQk0xQWkyZW9mb2xTWHVNUDEwamRRT1VVeStJSmVPRGpCd3ZGSFZm?=
 =?utf-8?B?bUR0bzNhL1VxYWlyVEhpNzh2MFR4OUtQMCtYWGQ4OWpyUG4wZUJCK1BodzAx?=
 =?utf-8?B?MlpTZGVYUEpVN1FSRUk0TzBDbnZEM0pTaXRONU1SdG9TVVZ0ZFdTaXN3eE9O?=
 =?utf-8?B?SmI2anhTT2M3OUVlRk5FWmVONDRTUGtaamdZQnZNdERSOFkrSkgrelUvZjEz?=
 =?utf-8?Q?hFgs1FLZMwhHU+87QsbNAOh08QoM5tqkE/pTkmkViJxy00?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56cec36-c540-44d0-5387-08dbc6583b3d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:37:25.8915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2vtX74OuZWVfcRHMiy6r9Ze6ezA3dnLiv5ep9gZk1WoVJlkCcK2ah/HumZCVUabPbY2ONYmlAiYUp6T6AEhgCeqhMRB1L0nTU6IgquDJm9RSsmp/2jVO93cQJ+nkWZ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_07,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060077
X-Proofpoint-ORIG-GUID: V19JDTLovtwqq9KQc2PEFjAC4-tAGOEE
X-Proofpoint-GUID: V19JDTLovtwqq9KQc2PEFjAC4-tAGOEE
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/10/23 3:55 pm, Greg Kroah-Hartman wrote:
> On Wed, Oct 04, 2023 at 11:43:46AM -0700, Florian Fainelli wrote:
>> On 10/4/23 10:53, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.15.134 release.
>>> There are 183 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.134-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> perf fails to build with:
>>
>>    CC /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/metricgroup.o
>> util/metricgroup.c: In function 'metricgroup__parse_groups':
>> util/metricgroup.c:1261:7: error: 'table' undeclared (first use in this
>> function)
>>    if (!table)
>>         ^~~~~
>> util/metricgroup.c:1261:7: note: each undeclared identifier is reported only
>> once for each function it appears in
>> make[6]: *** [/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:97: /local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/metricgroup.o]
>> Error 1
>>
>> caused by c1ef510a0f2a879bf29ddebae766ec9f0790eb8f ("perf metric: Return
>> early if no CPU PMU table exists"). Dropping this commit allows the build to
>> continue.
>>
>> I had reported in the previous cycle that 00facc760903be66 ("perf jevents:
>> Switch build to use jevents.py") was causing build failures:
>>
>> https://lore.kernel.org/all/6a577578-8adb-aa70-1bf8-b1a4573152cf@gmail.com/
>>
>> do we still want these commits to be included?
> 
> No, I'll go drop them now, thanks for the report.

Thought:
It's not the first time we see build failures in tools/perf -- would it 
make sense to add this to your own build tests to reduce the round trip 
time for these errors ?

Note: After reverting three patches in perf/ the build succeeds:

Patch 151: c1ef510a0f2a perf metric: Return early if no CPU PMU table exists
Patch 81: 40ddac4ffc75 perf build: Update build rule for generated files
Patch 80: 8df938ed8c8a perf jevents: Switch build to use jevents.py


Thanks,
Harshit

> 
> greg k-h
