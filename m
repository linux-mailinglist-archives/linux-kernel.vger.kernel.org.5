Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4EA787A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243469AbjHXVWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243716AbjHXVWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:22:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCC01BC9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:22:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEUiS007529;
        Thu, 24 Aug 2023 21:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8IOXY/559ecw9U1jCzyYxMLUmrCdKat7AmmLCDKrkJc=;
 b=vVvTuWdtONMmE4VzQdsBIhBmhLBeUQcidurIGYRB+g60XJiykEarG7Bc70IpGddi2E2Z
 yluQWqRKQdHbXELYaHm+tnteo0dmTFvwZDP65Ul1AsXsMiUQCuDVkuO0Isyp1vrFQaXI
 nqzAYIrxXqSaUJerMgRgTtHdm3kKkBRBDTL1Sg/fVo4LFXIwkPH7S6PxFCWiumXdLYb9
 sB0NX5JKztoy640XKGPQ7Lh3Oi2L7+i5+0BRXdl50t5ITCp3k7/1m8V1XfeIcaIx1svK
 I/uzKrZU1yK4ocLLc2Rcqfd6g2y3Ac+sCp9DFFllu5wVcIm+V8Pk8A67E3BWGw/CbSH4 6w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvw403-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 21:21:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJvZ2F033219;
        Thu, 24 Aug 2023 21:21:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yx18an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 21:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H194qvcrO++Kul6lG6slHdqZu7Dg+RS+epSIGmgGNQBRVBGlbrxNpNOZM5sK3ty1oQTW1KuUMltA9zpBxUJE5DMqCDBkzTWoA8jLXkNKDmVx8W+pIKn2K81JAm8XEwT4rprxGr08HbEnN4mVvHCpiq6C7NpNrDeE+ep2+C4p4dLv2PoLqRkINkcV18OkmKKDkySrkEN/rySmwE4dj2vugbk+OCC8OOyOWasHulAjRbGhAHX2EIQWSyiQgdIdYLjuoCujfVt7S9V91Wg9VOIB+5A22g/kXOljlv21zFWmGvsQuniMyCg5s5J31HcDXfcDCuCimCJzYh1OeX3Y3lRIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IOXY/559ecw9U1jCzyYxMLUmrCdKat7AmmLCDKrkJc=;
 b=AbeL1mcSYgkCMYKr6Xr28MANlq6TJIJR6vrDalbu07tlvdKOKT7V33GQACVVMrbfLMXQW7zKO6iscjPjyfYAjxDyimhvcWRdxhDPHuTph25Fx9jU3O9lbeyUUNYVJQBL7bLW+lzjn7bN0vVzY6fThAYIp6zXtaZwlw1gv1BCn+GW4gmRIBGC9c8sC0xEuV9CBgCo/VezfoMbQethJKEXgr5s9mSYiQGkw+zVPg8dSGG4ETSOHc9bZlAp1pKcyiO3fRz2Gkhs1O7qp99OsuBIEUOTHgcWVmDfSQFbnUEF1vve8YzGT7P1Oo3uOSkqQuP8PmsoJtQ34pMPh4DxpzqBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IOXY/559ecw9U1jCzyYxMLUmrCdKat7AmmLCDKrkJc=;
 b=VEupMkrHRsmdhI7pyoAO5Yux7e0vfFNDianHmPN438OTy6fU/1M44NVFVqNDbEWboxYCPV1/ZHa8Vxr2ZwIZ5YN8tAH/Y9Lt/WUV1lTooTrahPpyWHStju/LwmF+c6dd8SRjXWgT3B5kCpNDKGWYy7dY/GjROa5yyT4aJ9A884Y=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by SN7PR10MB7001.namprd10.prod.outlook.com (2603:10b6:806:345::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:21:33 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::878c:8797:8568:4f1a]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::878c:8797:8568:4f1a%3]) with mapi id 15.20.6699.028; Thu, 24 Aug 2023
 21:21:33 +0000
Message-ID: <48676a7d-2100-c0d1-4e03-788cb6982fee@oracle.com>
Date:   Thu, 24 Aug 2023 17:21:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] xen: simplify evtchn_do_upcall() call maze
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
References: <20230824154106.14799-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20230824154106.14799-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:806:6e::7) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|SN7PR10MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: e97abc27-3d4f-4ca9-9c1a-08dba4e816ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qYojLlnQurTdZLs4noVuBvlfrkBZkStppnKh7SXX/KsK9MBsTWnB44zXWPjG3gnWq6GFXGBipKXpa3cpeLn5lF2lw05K1b9dMZhDR/Ph1QWIqsaOBbYTazU27SHJqArh2QCpeSzEY0Vqpey2V8bHqA+ga8LEGpTzbnuwILx/oMNudYiNeOZigq2gJmKmvQG5aEmC5yEYlLNoOAvD8WjdH0Gipe2Y31pterwIO6eoWOkv9p7ltwnU3QsM71PZiB1oMSf14ZLtGi5lBQAL132E/0Vk2h+vX78q64zWWve38gTY8cd4QLr1SWThp+0BdMdeayEXKyfhOVAt5SDQDsZdRxhLvQ+chcIvEUJ4L0bxVRKKXQb9j1Jhp8gG1EFQJBxy4utL7SPTq74ozCHOrnDALlWs0gX4YwhUI6D49U/Rv++/JFYoVYRYxaABWtAGvhtxpHp94+oD0KhwqidYWM/LjS4BHQq3RgKoh03ulDai+WhdaeGrkbuxJqPYd6235DCikGbzK1KFrVoTe7bHLbL3f4JbItzeBx6tH9XFikTpBg0FqdmKRMKGM+ysZpwk3jDMAlfVu3tDyqlnpedmbMk+0lQnSgJn/O/lXeYnlSUeyvAe5C4EM3vanOjoxG43k4uIwoHJaUXvInsL9BsviDbeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(186009)(1800799009)(451199024)(66946007)(26005)(6512007)(53546011)(2616005)(41300700001)(4744005)(66556008)(7416002)(66476007)(54906003)(2906002)(316002)(5660300002)(44832011)(8936002)(4326008)(8676002)(478600001)(6486002)(6506007)(6666004)(31696002)(86362001)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REIrOGIzMHpFUktrTG9nZmlxbjNvbFNqZDRvU0F5OHp3R0x1cU9NZWtBWVdn?=
 =?utf-8?B?d3kzMkdRWFYrUmhVbndWZERBQ2trUWJBdDJUb0hLTUFvc3ZWaHN1NnNKd3Yr?=
 =?utf-8?B?MWpUQTFrOFFHR3VjU3NMRGZjMXRXK2dCY2x5VkRpQU5oZlJscE5YVXVsTUlK?=
 =?utf-8?B?dWZxLy9rcFl0SWVNblVkSENqU1RVZ3RFOWFmV0hLaXpiVDFmbGlORzVFSWtS?=
 =?utf-8?B?Q3NzUjVNRlMvTkRtUFI2Yk45c0d6TXpGUUNWdkZCbzVHcXJGZUtPaWFXNnFI?=
 =?utf-8?B?akRuVmZwMCtXYmNkK3NrNWVLajlvUVNxSDRWL3ZERHRFWFFzSUI3WXhlK1lt?=
 =?utf-8?B?MlQ0S0UrTG02U0I1U0JURllFVkxoalRIbmFmQVd3aGRwdEE2aEhDMnFmS09q?=
 =?utf-8?B?WVJKb25qcm5Ya1ZkbG9wWHExbFU5ZEZyeFRpZXlQMnV4aE5nMUNSY1E5K0JG?=
 =?utf-8?B?T1hweFR3ZDZIeFh5N2RVTlpYYjVHMTllQXRrUWFoRXA5RVZ0MWlNZ01wcUlZ?=
 =?utf-8?B?UTg0YzhaZlJIMWdvZHhaU2YvYkhxc05oQWI4cHlDMXdYWDA5TlNpQ2p3bXNs?=
 =?utf-8?B?S3B2Uno1MThVZEQwSE1pR0cxZFg0RlN3emgwYkYxampjR1ZHU2V1RzVaMWFX?=
 =?utf-8?B?ci8ydjl1RWdBZWlsWWVOQnJGVjRhZ2VOVGZhb25xN1Z0UmdiSmovTDlrK3pL?=
 =?utf-8?B?c29rK3dFMDhwTGo3SGEwZFZEeEZmOGYzNnJLaFBFSGR3ZzhuendDanFmZjZG?=
 =?utf-8?B?RWhhUnZ4dUE4WGxpdUovYlBMeWdxejRLS2pETFUzYlZzSUxNeVVNbUxRVjZW?=
 =?utf-8?B?MFZ1YWNLU0h6OVZ4YkZESEhsdnpCQjNRODFKN29PN2NhbkdDZW10cmRJSUR2?=
 =?utf-8?B?aGZ6YmdXWi9PSkRyMmhUblJ5YXZYbXhIQjZBUGx3RVIzbElibXNJRTZsb1FP?=
 =?utf-8?B?TU12ZkF5Sy9zUDAxNWIwdTdMT0FQNDEvK3d5c3ZpSEE1a2U0TDlNb1hreXEy?=
 =?utf-8?B?bnQyT1dac21LTmpzSFhkV096Vk9FNHFlQ1dwb0p3SmhGc2dWdlBwc3BjVWxr?=
 =?utf-8?B?SVduaTUyV0tkV28xeWg0UmNoWlQwOS80T1NBUTh1L0Q3RG01QUxWeS9yNmda?=
 =?utf-8?B?alFGbXVYcmd3NTFLTkJUcGMxdVpYRHprZVNrUE5DYiswcy9JV0N1N0FaREpD?=
 =?utf-8?B?bkdwdEhqeTI1UTV2Yk1KeTBxaGRVUnVaNFViQktJR2p4Sjc5TkZjbWQ2UDd4?=
 =?utf-8?B?aVBNRHpScG5ORnY5a1NVaHMxMk5DbzhaNnI1WFRmdFVOaG5xcS80cndqY1JK?=
 =?utf-8?B?dG53Wk5XZ2FrSGs3dU0wUGlCSXljUkUzQ3RjcldzU3BjVGNVOHBZNm0rQmRW?=
 =?utf-8?B?WUp2UnNMSVN6MWI3UmZPQmhZYURBRXd5aHNtZ0xTQ3RMdFBsaEhvU3J5QW9p?=
 =?utf-8?B?QnloZktENSt1RksxT0dFaCtXZUJuRDdBQlhzNWI4YlZjMGp3N2dLYXc4b3h1?=
 =?utf-8?B?cjhzZ21uWUZuSWIrWHVXb0RBcXJLL1VGMXNaeXlqQndVR2N3UVM1bEFxWVBD?=
 =?utf-8?B?SWlVRDNURlJQY0JQdk01UlI4WC9RZi9UM0dkZW9Eb00zYjZGL1lNUVBVOG83?=
 =?utf-8?B?cjR3cGtuSjFLSDdMckpaUytiMURJeVNCeVc0VnA5QkVub2tCM1RpZlNvMjBI?=
 =?utf-8?B?emYwaEJWTGZLcHlOVmdTZHl5akJHU2dqbm91anBOeUFMckMrSnFMY2t6VnN3?=
 =?utf-8?B?akxVNHRSK1VjTCtlTTcyalFCMnNNVmdUT1hVZTdYT1IvSTQreTNPVU9DcVVO?=
 =?utf-8?B?VWhlYjBrUmJlNFVicCs5QUsyc2M5OTVGdElGQnJ6QmlNU0ZhK25oWURhWFlX?=
 =?utf-8?B?UytOMDJaRElPQXZGdWUwN2t2M0c3VGVKb0RYT000UTVGMm1pK3AreGVVTlNo?=
 =?utf-8?B?RnBZaEpJRHBaRDJJUWZpbVg3UTJ3UElmVXlYWXUvL0x3bC9PMU5XempBNGRP?=
 =?utf-8?B?c0hWMVd3UlUxaHlJTUl1eDAwVVA4U3Ewa2xON05Ta29Ed3E1MnR1M3o5NzBw?=
 =?utf-8?B?amJqejg5RlJ1eC80RVkvcnV3MERLTVo5alFLbVhrQU1kMmdkaytKVzNQQzhJ?=
 =?utf-8?B?WUR4RGxXOWkxRnBqL24zMkk2THcyYXhEOFB4bUViS2pjdTVPQjRyVFpvVVVB?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S0ZPUzdNWFZwM2hFV0JHdVJFeThLMncwVmlBMy80MjVJK2pHTHVRcGw0MjFJ?=
 =?utf-8?B?WkZyTDRZVG1ZemhHWkhIR3Q4SEZFQ1NtWWRua2RZYXNBRmdjVHM4VnNUNU9r?=
 =?utf-8?B?SEU1enY1RWFwd1ZPZW54K2NWNWhSN0pYZklqeDQ2Q2xiV3A3WmI3Ny8wbE5h?=
 =?utf-8?B?YXhDTnhqckZsbTVTTlJjWmRNcTdubG9ISnZDVVBBb3dLQ1NGcXNEYnFLNWpo?=
 =?utf-8?B?eEdoMkR6ZTVadjdvVlk4dDB0VDlTSk11WW9IY01wWU4rL0REbnRjUzFyUVMy?=
 =?utf-8?B?TU5hRlAxWk43YTVCRHFvRmtnY0xxMm1HSTJnUVUyK2JLY1Y3V2JRNStkWVVj?=
 =?utf-8?B?MlV3TmVaUmRURy9JS3B5L2p2MG5pODMvYzhoR0Z4bE1xazk4VE9xRXlhbXB6?=
 =?utf-8?B?Y21VSEhqSFJmUHh5UU1UVWl2STdHUXR0VTI2UEJkSXZPTnRrQm83UDRWL2p2?=
 =?utf-8?B?M0t0Y2NIRHhpSzAyRzcxNktTbTVHRmw2UWRSR2hkUWNCYWg4bmFYaHJ1R2pp?=
 =?utf-8?B?dDYwYTZrZGpUaVNySFVOQTdXZW9BeDVOZTJveFdEcGxCd1FLZkV3RWRFZ0Fu?=
 =?utf-8?B?UWxTMmFVWHR0UnhOaUxCODR5c3gwQit4Wi9maEI4MmduSVpMbEUrenNmWlgy?=
 =?utf-8?B?Y0M1SHJhNkZtTU1LbmlVSmxta3ZPVFlsRTluS1duRUZJSlZtSVppM0M2c2hJ?=
 =?utf-8?B?VVlyb09rdUU1VVhaUlQyeGFZdVp3S1NSTEJtY3RzSml6OHZqOGhnSEcrRllz?=
 =?utf-8?B?cmNFNlU5L0NRMUZaZEtPM1FDd1oveTFRcytiWFpLQXE4eTI4N1ZiVVVXWUU1?=
 =?utf-8?B?a0lLbkJVSjl4b1R0alV4Y1k1aXlIa1FNRkptYUt0M1lwVE5ZSDJhS1piTFpx?=
 =?utf-8?B?RktHSVg1SEw0Ri9teXJ3RW1rYVprekxNbGdLKzZxelI5aEd1QnNha3lPN081?=
 =?utf-8?B?Ti9BWXhLUC9DbGoyTm4wWFdiYVgvYXNUb2Z2ZmUzUXFXUjMvbWpsZnk0dWlp?=
 =?utf-8?B?Z2RscTVmVWw1OXowdDJuazJlMVJWd21xeVhSZmNoaVdRa2R2R2VYa3BZUzRL?=
 =?utf-8?B?bE5JUFRxNDdXTm5yaVRhMW5tUjJGN3ZSZkdudDU5RzdtUEoxVEM3b0ZlLzN3?=
 =?utf-8?B?MnJEOUloVDBLckZFcXpKSFR6aXZ6NExKRzdscEZIUjRGZ29PQnViZndWcWYx?=
 =?utf-8?B?QXVRTTk3SWxQa2paN0FvR3Z5OUpzVGZuZGVNV3Fzc0FMY1BNVE9kekJsZWk3?=
 =?utf-8?B?MlYzRDF4Tm1sbzlyWDZ2Q0psNlVDZFdhRlJTcjBjVlFkMGgvelpXTWhraVdL?=
 =?utf-8?B?TEFlQnlVdEZydkFBOG9IMXl2U2FYaWpCZlZQN3hTdDI3SE1La25sV1ZyM2Nv?=
 =?utf-8?B?MUp4Zmd3QWlGVmpvM1JRTUdxakkwdE0rcU94NDF3aVpPOWRINzlUU0dRUXN2?=
 =?utf-8?Q?oCCKyGP5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97abc27-3d4f-4ca9-9c1a-08dba4e816ed
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:21:32.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LG7oR1DoMERka+xPxmzD5KIlj1pHmBJEuPmfeYrKaHMRI611qM82iL5vWKP8GDf6k5qliJtnJ+wdUZcrl2yjoDNtlWMha6SzNrOC5/D2NeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_18,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240185
X-Proofpoint-ORIG-GUID: EObIrr3DLyruPIkbt_lLa0OfcTVSbU3g
X-Proofpoint-GUID: EObIrr3DLyruPIkbt_lLa0OfcTVSbU3g
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/23 11:41 AM, Juergen Gross wrote:
> There are several functions involved for performing the functionality
> of evtchn_do_upcall():
> 
> - __xen_evtchn_do_upcall() doing the real work
> - xen_hvm_evtchn_do_upcall() just being a wrapper for
>    __xen_evtchn_do_upcall(), exposed for external callers
> - xen_evtchn_do_upcall() calling __xen_evtchn_do_upcall(), too, but
>    without any user
> 
> Simplify this maze by:
> 
> - removing the unused xen_evtchn_do_upcall()
> - removing xen_hvm_evtchn_do_upcall() as the only left caller of
>    __xen_evtchn_do_upcall(), while renaming __xen_evtchn_do_upcall() to
>    xen_evtchn_do_upcall()
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
