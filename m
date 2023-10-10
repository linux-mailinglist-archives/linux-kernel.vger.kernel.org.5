Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35F87BFFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjJJOvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjJJOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:51:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732FCB4;
        Tue, 10 Oct 2023 07:51:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AElXmZ021683;
        Tue, 10 Oct 2023 14:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VoyzHtj6M9IUsYjMW7bPqHKV5uf3K+CHCWFzmvAYTWQ=;
 b=oO823p+u/zobq91NRpQUo8A1/sHgTXxhd3TNbpE4/tKJWiE7uCDwhClKqjKPzSXGahGV
 ObCAFcFrUGsOgVtoaTtA8WpWLlulqHEmBazjtNs5XN5IG1HZx5c2bxRDya+l6GyaZo19
 Du4ByzfWdPZoY8LN/4EIXFcKNDNb6eb3IKHynqvE3KvpDsEzJ8JAl5O0ccgW4c3yHkE8
 4E8spkAaTJkU/ACUnazH1g6QAWGWWSHQvaauDZj7CTUlhmVOQi0kf//si7tfEV+Pwo5k
 h/urukng/tekW6Zj86WziJG8VPdNyK7A0nl1VC3DDnr/QaWy9f8gYGPl1t60KVRvZEag cA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvunc05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 14:50:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ADt7dw014939;
        Tue, 10 Oct 2023 14:50:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws70r32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 14:50:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlC9yWl2fOSHpO7kQQSpkvaGAh5iLejNlu59F403FIx7fLl7RgaKwg+WzDQnLSzYLrp6UqjxKWcPhfLQYQwKg0ZAyRJaMAyxpTZ+wAVCxVUxKX6XiVLMPfo8HjnuVG07wfq97NttIqjs1RzPb/S2Rx+oaMePr3OVxPAqVw4a1ck02k1/n+nrDZSh+jxFPVfi6JgHPFNsiRy4zcXY7XDY2z8ECjFidOY4ds8EkhuvLtUqgFagZJ9w2teXJ8aTOei3Bnm+33kU5jdGDTAYuNoBdXm034rtkeFjb+8I3ECx989aR+AHFA/0/2mQpmxHXVzH4ygRxkYZocnvmLWh50ecJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoyzHtj6M9IUsYjMW7bPqHKV5uf3K+CHCWFzmvAYTWQ=;
 b=ZcuPN4YNO8n638Uuk4MzSnrDfU+6SNyg3yFZ3t37VVVeniz5W9nJ+t8fFztMWL0IBjCN9gLZ7mmkFvitIXcFSUFin7YcgN2GqLXBBD8mPWAKFPgUM3j8Zb/Gw+NRG9JouQ1zhYpRn2MsjVeBxvHjCOa6VXYESDyeYI53GyPKeUh5HCXNbdrk43ZtL8P5yPDKeNMCzGor57ODj0BX0+HxecHo81PFGBLS1H/Njmr3Dru79pYd79J2s9JzYT+nI/EP7Airerz4itLBIWQwyww9jAcu57wAe/ZXjuSeKPuvHsq1se9m2e+MZPiav2kq28S0OGQ69gMkbdW+A3vxYzRIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoyzHtj6M9IUsYjMW7bPqHKV5uf3K+CHCWFzmvAYTWQ=;
 b=B9KuB9NKiVaDtDaG00+yqdyLoLRBBRqnmGPsm2KOyQdvNJuqO7r+IPFUGtptUxnMJm7PwiKbr7h1vQKwjOt/e3F48pyNhBFB7STMnkvRvfcDItfh2jK6letccASqlV70Fph+fMck6oo46XsKju/sA8nc3PM9NGC+ZnH9UG0oHXQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:50:13 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%4]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 14:50:13 +0000
Message-ID: <c16b879d-b83a-1475-2d97-1f6ffdf098af@oracle.com>
Date:   Tue, 10 Oct 2023 20:19:59 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.4 000/131] 5.4.258-rc1 review
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
References: <20231009130116.329529591@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc42cb9-ea88-47f4-e6cc-08dbc9a035af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LBWWw+aDm3qgUYo0mw1Ygjv20RlJ5Asws2nck8nD9gJqs7Af8CoOf1fARpTXCE3OP8jKWsv6AnX2IgD8yA4o+vH0IOR23874hzK9u2RTUUQghPzZqkla7cDGddVN+KsqlwgpBS+tldPh0y32A/Ni8qnvICiTLoUY3rzavBc/cWUpI6IIXDMdVr+fwcwFr37BE3FqorRTQfYmrbkiYHqcGSlTItzO7TCSB3deIO5SO0MvRxUa5FcF1PqZG8yyFQhmdQxdl1ZpyhaqZNmGCkqNQa9LGlqU4BssKW2+APrmcSygInX2ANfgw9zEyBYHZZonwE29zZvmW1drv4edfB9QIFzCYkV53OLSgIjw+ZG9EaP375LwssNnXfPewQjWGJZ80SwgoeyZ6lScmHMb3r3BQ+vbSURglsdty2IhQEC6ctLoXoAW6aB8v8mmHFoZG+z3vF1FOG34wdNVHoQ0mzGnNHVv/e0OYbKiq8wgqt/wilpkU4RQQelRpUVzw85p/45G32mA9S4voFSDIWFBJqCaQIvFU6upeh+ejkJ7nFxCH4pZ8eWKY+mltzFcHvctJeEYq5f8U1JprXJdAnQpnxV1vzyY/ElCYKAzREVkNhA6czE/cCE79pXA1ErWf3VT7Z6Nb2YWZtqJnxOdak6vAyNRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(31696002)(38100700002)(36756003)(31686004)(6486002)(478600001)(966005)(4744005)(8936002)(6512007)(6666004)(5660300002)(2906002)(8676002)(53546011)(4326008)(41300700001)(6506007)(107886003)(2616005)(66476007)(66556008)(66946007)(316002)(7416002)(54906003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW1OeUJkLytqOCt1NTVBeTRZbm9lcGwzaFJzMUx0bzNlY3ZjTVdSaFdpaDhN?=
 =?utf-8?B?NDc0d01zQlBXWVFDaGVPWXZIQjExRmhBMm5rN0tQbGdZa1YrV0JCbU5zWisx?=
 =?utf-8?B?SjVyS0lkblY0d09iT2l0MUtTRVRuaVd3YVZyem5YeGd4cDBjaTdNc2FaclBY?=
 =?utf-8?B?dEt5Y3ZwN1VhM0tlZjFIWE5pcDhoSndKeVA5dnUwSTNuMENsTE9xMyt1NkZt?=
 =?utf-8?B?RDVTSGFONUhhaVNtQ3ZWcDM0ZS9WSFBvUFhRQ1ZCWjhobWpjUk5OdDA1TGZx?=
 =?utf-8?B?emprR1dNQXNyWlhKMGVDVlUxVCtYSHB3TWEvL1VxNlZidmRLMVBTbVpIazhJ?=
 =?utf-8?B?RWQ3dTN4NEE1L2ZrQ0dGQnVJV0J0K3lRR1dLV1lVUXlPS3BCYzJKejk3L3Z3?=
 =?utf-8?B?ZHQwSG5nQzlsQzM0bWUvYWh3NXRqaUl0enI3UlVyQ2NLOUc1RjNzREdLRnZE?=
 =?utf-8?B?a0hFYjJ3Z1UxeFR1Q3Y4Vmc5Q0l4VDdSZTFNUzJ0Vm8rcTFMWGVTN2EwRk1v?=
 =?utf-8?B?aTUwR2k3OFE1SE9VL3hhaGNGNTBUbFBDcjRVQ0ZYQnlaTUVlelJYTHVuM1VK?=
 =?utf-8?B?cFFPbkdBcmVRVmpaTXQzOFc0aVpMekdZdUpOZkZQVS9URUNKUHhzY203cGg3?=
 =?utf-8?B?MS9EQ3E0cDZ2YXowZms4U0lQcmNPS3R0a1c4UjVwbnAwQWpsbHZnMnYvKy8x?=
 =?utf-8?B?NUJPZkhLN1BNNE1oWElCbHl5NmszVTFpSDVaWUFqOXlnMnk2cVdiRnppNGpX?=
 =?utf-8?B?QVdyUkFEWTJBNk1pUGlMaWZHT1FZUHlvbDFkb0RIYjIxeW41bWZoeXJReFJa?=
 =?utf-8?B?VzZIWW55Q09FRDBTcmZkS2tPVVQ3U0FVbGpLeHZSYi9hTmlpempMQXh3ZE9V?=
 =?utf-8?B?RmVUeG9HalZaVDZ3NXFSSWJPbjl6QnVLdGp2YW5hbU1IRGhPOTJwM1dueC9O?=
 =?utf-8?B?R0wwMDlwbzE2WitwbXdQdm5udFlzQlNZMS82c1BhaHhDd3NoaGhmV2hkSkNP?=
 =?utf-8?B?VFZrbFUvNzVOcDFDZVJWMG1TU3R6SGMrd1hNelJndWZPTThqSWdZZlBBRlVM?=
 =?utf-8?B?MmVjVVI5ZUVvNmFvaEx2enBQczdHU00ycjQ5VU9XaVROOFh0RERRUjM4aFpt?=
 =?utf-8?B?Y3BpZG1Xa0dtdkh2cmx5UzBjbkV6cTlidWtoOGxSZFA0SmFteWtCdS94Y29h?=
 =?utf-8?B?WDlqMnRHZ2RBZzNjOXA4WFZoOGZjSktBV0dMbDVKdXFPc3Nud2lNTm55d1FH?=
 =?utf-8?B?UHJPek8zSE5nMS9uTmhBVUxuU2pLUlZhNm8yZ0JPMVJucjNsZmJxTzlpdG15?=
 =?utf-8?B?NFg0K2JVWHZESEpyMjZCK0lzUXpMdWlVYkJVQlNZWElUczRUMFAwcXBZZzhs?=
 =?utf-8?B?c0xqbktVaXpNbzJESFhyQVUvZzhoWHFzdVJ0dDFoRm1zeDVTZW94aEpEanRM?=
 =?utf-8?B?bmwvZWExTzQ4T2RpUEgyd0tPdUhUZkdhWTVIZjdKNFhMa01zTjJmckR1OUpn?=
 =?utf-8?B?ZjZhUlRiQ1BxVkZHNGszU0RjYU9RbkhsbWo2bFVIRURjelQwMFpvMTZENEVF?=
 =?utf-8?B?V1pTNlBCK1BFbUNtWkVqZkcyMU5mWmFFbzhOdG9QS0p3NlRrK1l1ZHhxUWMx?=
 =?utf-8?B?OGkzUlF4MlJKOS9KNVJ5Rm1tbytWQ1JtZDlUNTFIdWxFdVluNEVNR0wyeGw4?=
 =?utf-8?B?QSsyK3dpRzQ5QjB5RWgrSkc3LzBpNnltUE9kRUV0N2QwcEFnSWFJRHdnbFQ3?=
 =?utf-8?B?aFk5MWYyRDJITW8rbDlDWDEvaTFvdkV3dFdsVUxNbVp1UDZhVU44NUQxNEcw?=
 =?utf-8?B?RE1SbFhBN0sxaHU5QklHSFY4TDMvSlZqMnBZcnhxdWE4L3ZVb0xob1R4ME9Z?=
 =?utf-8?B?UkZ1ZnRiT1ZwUkVYQ2ttTk1iWlZvc1hBc3RyR3NKa1NiRjljcUYraUZZYXJT?=
 =?utf-8?B?Q2NZZDRKcUloY2FCRnNnTFVyQXZFTlA1dWY2ZXZ6czB2ZjNjMzdBVDQwVlYw?=
 =?utf-8?B?M0xTd25aeXh2VGFmQWl3aWZYRWorbVQxQS9NV0hjcXZIK2Z4dGN3SG5uVmxW?=
 =?utf-8?B?ajU4L2xnWXBPeUFUcms3ZHN2OFNjLzZRcWtuTkhMb2ZBNStOSnNPU2RSVDN3?=
 =?utf-8?B?L1RyRXh5MCtLaFNWdEdvdUd3RGwrQ2RobzNSV2RLMUhkRkEvNk9ReDQ3aUZy?=
 =?utf-8?Q?lQGf1vbKFkJRiEVXPkytf6c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eVE2dktMUGN5Z0NXcFpCTjN0ZitKQzY1QnRwNHQwNUtSRW53SzRIRnhxZmlL?=
 =?utf-8?B?bUthcUlqWC8xemFzWnBrR2FOaVE3L294T2JzOE5jVUoyYkFucUZtMXRSODgw?=
 =?utf-8?B?cnkvVDlFYUlmLytnRlBQVzg4cFl4cWF3UTQya1JWeG5EOTMyenpYV1JIQjdI?=
 =?utf-8?B?QklTajFYSmFuQ0JKMXhXN1ZGb2NTaFA2SklUQk4xRHlCVzNqTVBmblRTdFNh?=
 =?utf-8?B?dzZXOU9iaStpc3FOVGJkcSt6U0hwY1dhaWNzaE1tS3JBVEcrZ0czNCthWXBN?=
 =?utf-8?B?QnIwZlNPS3p4SEpLL0ZORWVaYnhRMWxlWmE0Z0RwN2ZrK3JwMTRlSFVFanJu?=
 =?utf-8?B?SkQxbVk5UGNYMVlMN3JHVUQxYjZRQjVZNUhsWFQ1R3QwUEUvNVJnR1lLMk5p?=
 =?utf-8?B?RmE5TmhBZjNBZyttZXBWYWplNWpKekhUQlFDQndVTkxzeDlybXRCZmxYb29a?=
 =?utf-8?B?SmNOUlhwSEhKdWhrMlhCSi95UitScWJRcm1XYm5ldjJrVXgwZXNIcGpnTEdJ?=
 =?utf-8?B?TjVOOGdtM2YvcGdXS1Q0dWgwUG9yN0JLdnpFNldDb0kraXhINFhPSUZnbjlB?=
 =?utf-8?B?Ym1KNzVaOXROcWs1MzdKMXd5RGd3NnRvN3ViTFNlZEZQd2Mra09GT1U1cGhN?=
 =?utf-8?B?aW1RZW9ZcmZncmpuZGx0TGUwaExPeWxpRzlGMElnOE9tYTNyZE5QWmV3TE1O?=
 =?utf-8?B?emlyUXovTlgrZ3JlUXEvTkZmdU12OUJLaXhhVWNMQUlsMUs4NkNZdnJsMmJ5?=
 =?utf-8?B?N3JtLzgrMytFZGgvQWZ0WWlRcTRBWUM1TjhvekorUjVQZXZzeHhKdDhpamxl?=
 =?utf-8?B?WnNRMW9waGgzaVoyK1RpT1ZRRGIxTmRZTlNmOTZnUnQ1VUdwRTkxZW5qQTBq?=
 =?utf-8?B?dWY2TWxWOU1ZT0V2d1VvVUdrUm91c3hUeEwvVVFUWEFKV0owODNFa2RJSTd1?=
 =?utf-8?B?RzBWQWFETHhCT3R1M3JPa3RSKzBGTWxlSWppMVhBTzJoVXlFRXZyVlUxTE1E?=
 =?utf-8?B?a1ZXeG1NYzAzVElJSVUrUWN0ZzJWRmFlVWJSQ21qVDlDbGJtelNvRjQ5T3NP?=
 =?utf-8?B?OG1yQTYyOEZGdFlOb2JzUFF4VmVMLzc3eFJNa01MZE13UFV1ZXVlem1aYkY1?=
 =?utf-8?B?ZVg5bU5qWkRnRmJjeUZBZ2g4U2V6RUVPUHFSZitySThmREhSY055cHhRWnRY?=
 =?utf-8?B?UzdEZ05KbmUrOHJSckRUT1MxSk9OZW1keU85R1RLZmxZeHdDMWpQY3hRZ2pC?=
 =?utf-8?B?SzNKTVp3eUVET0ZsZkdwQTIvdGZoTVlqcldqcnNSMXFUZTIvSHA0N1ZyNFJU?=
 =?utf-8?B?cW96L2dOckR3RVFpTnZlV0xPY3RwZ2VySko2YktZRnB4REtEWTd5RVVIVk9u?=
 =?utf-8?B?RUNXNVBTUlVpOXF5WVFzckJCNHlpaWU2Q2tFU2NhWlllR3pNZE1JQ29Gc1Zt?=
 =?utf-8?B?b1RudmgyT0I3WWhqWUNDdmkvS3FoeDJnbzhkbVZUWlBYQmpiS2VmcFpFZDBX?=
 =?utf-8?B?NVo1U1F2cHYyK3p3UzBBeS9LckxndjMzdUJQZ3BoSjNOL215eHpROVhLRzl4?=
 =?utf-8?Q?fTt8bdGIDMu9t7MQLwhIv/kkGRdN81385K5JwJGUkhIR9P?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc42cb9-ea88-47f4-e6cc-08dbc9a035af
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:50:13.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ptng+1mwV622s7M/kG51+iqvion2+UnkvlKlD7L1gjFcKS7OJQAIrGJ82XhqqfnvK9CmmsbvqSC5SMtDZIf2nw6Vg9Z+a3Utfx1gUrMyqSbnwyQLh0LST4QLUInc5rC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_10,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=983 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100108
X-Proofpoint-ORIG-GUID: YKk7BzBh_WBtSJl9Q6sGkGWNh8Dv5ia9
X-Proofpoint-GUID: YKk7BzBh_WBtSJl9Q6sGkGWNh8Dv5ia9
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 09/10/23 6:30 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.258 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.258-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
