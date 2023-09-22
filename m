Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4187AA660
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjIVBIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjIVBH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:07:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F4B1A5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:07:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIsTro005965;
        Fri, 22 Sep 2023 01:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hT1wedvc8h9JuMOMIP4wy+qGqDwBaiT7W+s5+DDNBQY=;
 b=pbt00PClkoQUwuLqH7DkAo+Woyxm4wkGIiyi6nnKTsSFMztSy4VJc1r4eaU4d57cgePG
 7j1XoWxvxX4ToIzebmc72xecuxStdLqTUbBeBSyykATRsZGoQlwG8QK3l6zu1epTaATD
 zYeHsz3T0FZd3JoX8jCDdwvBLhyjOfykj5QMSIsG4BxA7qM8470f7I9+qu5950tXth6u
 GfO2/jx6oRnVekXJt+9a9QFMFE8lBm8ITV9JEOnYJ46Dax/p6IMhaislR+Gqprb5WQdP
 MISPkpaQwjCHsv/uECjeRdTfK1ss1Z13It7WIUpVsMgqZ7r8CCFwB+oEP8Wi1ArAKeGg PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsv0jx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 01:02:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LMEiF3033808;
        Fri, 22 Sep 2023 01:02:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8tt7c1ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 01:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkTDynsYsFV7oum294s5+iBcLH1rkxLxGN/7uEw/Aq00sjD9ye/ULnh8BEK4efsQ6fWoETsrYeTIQG723Ra6ybIv0+OZtMUPOzd2jEkzHKhrs/v3/kTGey1h3zCaccpvWGi3VRcXUmW/Zx1nKwENC6MEdrrag8WMnzTbX3pr29aUC6VjJNu88pBSs2uR2qBISVfg/Bs1l04mBlAVZ5iE0lOUje2G9RJx8DcTey4rRzsp3McaXSWlY56a6BxnoRa183V5dCwg/+EI2j66T2+oSXU+1FWzPQD7Sd3QyF3L1KClC1PIvvBwMJDufXOdrG6AI6wf3LnRYrkyC4oT9bomFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hT1wedvc8h9JuMOMIP4wy+qGqDwBaiT7W+s5+DDNBQY=;
 b=Q3szLKdFSwcZWefsZb7lBeH6L2Ad+ZlKBkj0ux3Al1rwY/Wyy+hg2fIyCEpQ2zwwIEMaX6VdiVSS2lTTTeilVTI5BsTC6cCuDrf2mZqgBwsrlIjOgjlAjeOfvh4deEOwTY0sdFLy2o6iG1bGKsmjOlnPCUVtvpp2jj7vDaIuP6ieqa6tpaFQw9itp2YtEqP7YOYcOiUYAybhVuJ8S0IbcjxazE2NfLYT7SeiqPBgjmhUZm6zK9piroo9QccUX/R6V4oX5fErrKP7ahFU5tvhg1AbxLs1PAoCyUbqVhCa4RtPiQJLxaj0neKcEXiWa6QY2Ot7jgz2szm98er23MhXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT1wedvc8h9JuMOMIP4wy+qGqDwBaiT7W+s5+DDNBQY=;
 b=wqFI/yC3yfm+d1sqInRf7w+0eyZGxGh3R3omdHe8qhnrETtSrLW4cfpyNTezSQl0WVR7Xn1En8uPDSMiY2YFfiEt26b3NplqfLhMhVNJRqxkRrRwoeyHcRzAmgKzVbHqB80FdOyf6qje4RcUY9Ciuec0bQsksIMuig4yFwLnj7U=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by MW4PR10MB6583.namprd10.prod.outlook.com (2603:10b6:303:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 22 Sep
 2023 01:02:41 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::cf08:500b:afd9:981c]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::cf08:500b:afd9:981c%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 01:02:41 +0000
Message-ID: <03f81c97-0c98-99a3-420f-5aa9226e96f4@oracle.com>
Date:   Thu, 21 Sep 2023 20:02:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, ebiederm@xmission.com,
        kexec@lists.infradead.org, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230921215938.2192-1-eric.devolder@oracle.com>
 <20230921172650.aeacc5de4f45d13e5671d7b2@linux-foundation.org>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20230921172650.aeacc5de4f45d13e5671d7b2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:180::28) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_|MW4PR10MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e04f0b5-8204-48aa-bf45-08dbbb079f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ix96NfFQL4rGU9lwv7V4imdmHYnuLf5NN1jj31chDVfGmEU0pMr8GF+fZDG7/kuwLZluU4aHkl613/JObb3kV1T7dgV8zgMMzdaz7cV3aVDDbMc9zQ0SB03njs7BUA4rlbEKLGErf6k1TA/b/2czk5Uf/4L+84wMEbFWSeJH0GSWpvr8etmRjdH3IfnPOT3Mfd0VgMjXRJ6kQ8JZLyyHgH1jSWZ+mMIkhoUZRcXXWnZ5rvoZou6wJI2+/oZiHI07kDxdNPfN7hVKnYsIqRZwPYMYYn4jfqP6FY/wh85b8c2DnhsytunJYn/NbrRbiEGDQYvYZb+Nz7qD2fOjAezpWBYacb3HQWjqchonN0N1lq4J/7KnvbVvWBSwpMqAPYfkNKgd0zcrrZz0pXiBiN9gnkE0HEodkoobu/sL7loxlKnxHfPPeikInxK1wGa46S1djLGYX1mwjrM6Z7BgQ0+pIkPUCzXJQ6q/3YwalGDq3itOav4Jg6lFd7VtuJHWYNhQT8+fR84VCl+vCRQxbXEDinrCAnap5nuOOgf9DBf0ycob+NDlw4GGcPfqs9CiMTJf/9PZN6kcfcN2osqo2sfSj2Ro63JxvHXE+6zAQsCUYN7DYxdSZ0uCn/1OVCSrXeDX5oUsIhqbJF3+rxyAj6CT0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199024)(186009)(1800799009)(8676002)(36756003)(4326008)(41300700001)(66556008)(8936002)(6666004)(316002)(31686004)(6916009)(6506007)(86362001)(38100700002)(478600001)(66946007)(53546011)(6486002)(6512007)(31696002)(5660300002)(2906002)(66899024)(107886003)(2616005)(66476007)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHU0Q1hTTW1JUHFreGZMZVB3bWQvU0R0V2F4YTFIYUZFYUY0NFBjdlpRZm4x?=
 =?utf-8?B?c2w5eUV0bUgrU0FGVmdmS1lVL2ZWNUhaeFVlK29Kb2lPanBaMWc3djc5R0xi?=
 =?utf-8?B?MU8vNXM0QzNDWXhZYm1QblZ4SENnT0cxRzlNaTUxNmJRWTdmRUpKTzY2SEJ2?=
 =?utf-8?B?ZC9UeWUvOEdyVHo5MmJBNUdzWkN0U0QzSzZ3TFBhOFQ5bFZucDcyRDFFQXRh?=
 =?utf-8?B?ZkpyKzc3NHZOMzRpL0pVdkRJV0hpeTNjMExNSlY3SS8rbEFsaEhWSDRiWW42?=
 =?utf-8?B?ZzNFQUZvTDRxM01uUXpPVHZRMDlOMlM5Rk05dWFkZEFIMVBlUWJXRGVKeTdY?=
 =?utf-8?B?Rzh6YUphR0pBY0JlejlhbmpZMlRpTUNJSlNmZkZXTzJmektGeHhiZWpCak9C?=
 =?utf-8?B?ZGdsNFhNUDY0dmFhcCtia1VCNE9lR29nTk8wRGhQNWJUdnJwUHVoMmNhUHlM?=
 =?utf-8?B?Q01WeWdsdFF6MS9ZSVZoelVMNjZMckJrTTA5d2VkNnF5Q21lRlpkckxPelo1?=
 =?utf-8?B?OGJYUUt5YUNxdWMydGRmREQxcGludERlTStFeWlObnFuYVNSZExnem4vZ3VO?=
 =?utf-8?B?a0ZMK2ZnVHJyUTdLL2I2Nm9PbG1uSlJLNUJNZXNtNHkwRXcxMWQ2QzN1ZWNO?=
 =?utf-8?B?WWh0MG9IaklWaGRzTWE0VTFjM2Rmbkh2VUd0aHZSVERRWFdrSmp6VlpHVzVy?=
 =?utf-8?B?ZWtHdi9qc3hzUDFCRlAvN2tOY2xHMzFDT2FqYndXREFITDZJdmkySGdubkJM?=
 =?utf-8?B?VnFQcGE0VmdrdElTWEthRmdMd2srS2lQc0JjQkRJN3pQQTJaUWxMNmhvemxK?=
 =?utf-8?B?cXpoL2lYTWoyaEdPdlRZeVluK01vaThBK1FYMzlVUnNOWERvTi9DRWFGZXZK?=
 =?utf-8?B?QXBkeGtOa1o2dmEyNHllYllPZHhrSzJnU1FIblBIcldLOUZobGIvS3oweG4r?=
 =?utf-8?B?di9aQWQxeDBNT3NZcldid0tkaVJpdklGTHpSMndnM0VJQjRPN0U5RURxc1pp?=
 =?utf-8?B?RjFqR3AyQUhpaG5JYms2c2dPcFlFa3VhRmNmeTlDbVRrd0ZvUThvU1NOU2c4?=
 =?utf-8?B?WkNqSUo5MTZ2UlUwRUpiTXVKcDk3WmhxRDFsRWRrSkxVQkpTU2IxU1R1SENR?=
 =?utf-8?B?bW02SWdtOFlGN1dSKzZOR2VmUmlJMkJVSi96ckFGcG9pZUR5eWxMTjNhTnpj?=
 =?utf-8?B?TWFvekJJY3d4RzlEbjV3MWpBWWRUZ0ZuTVJhS1VERTMrVEIvYWxvbUFSajZi?=
 =?utf-8?B?dXByRHdQVGw0em5SRnVJdUd1Zjl4dGhCZHNsd2JWQm1QK0dYaVdZQzNRYWNX?=
 =?utf-8?B?SWJiT1VXdE1ES1kwQkY4ZFpyalljdk41RzdFVjFPWjE1MHI0N1BselNzR1lC?=
 =?utf-8?B?VkRXdEw0RXZ1dmxkRkFPb1liWXhMYXQ5NUpiRVZLbnVOdVV2NVNTdFJiNU1n?=
 =?utf-8?B?Vy9OSmJNVzBlYmZkc3VIdmovN3BTTDNXTzdScDNOakpBTmp1UlhnSm9yaFRS?=
 =?utf-8?B?TW9aSy9yUG1MYXRSNWtyMzFTZTNZV2JZSjYxMHJoOVlEY2dFR3h0eUgzRlA4?=
 =?utf-8?B?dE5NVUpsUStMcFpHWHZvYitaVExDLzBDRldpZkdHVmcxdGxEQVVWNXhNQkpK?=
 =?utf-8?B?OVlKdXk1MTFEVktOM2tIYi96dnRhWE5iNk81eTlDU0Y5b1F5R3RFeXdwLzNu?=
 =?utf-8?B?Qzg5a2d1SWtudXF1dkFWTjlZTUc1TmNnL29pYlRiOUxuQ2VONkNXSXlNRXh3?=
 =?utf-8?B?TTEzRHl5Vks2U3Roc2tETG1vTVpuRXBqNENmMlExNWtPR05GbDVOS0dqMDk3?=
 =?utf-8?B?Rlk0dVl1Vysrc2RzbjU1SVhKc2dHVXdFRWNHRTlBbFBKV0IvZzEyQWtkdjFS?=
 =?utf-8?B?VnJzejd1WHJGd2RtWllFaTRYM09kYmkzWEM3cHdXUFFlLzZlQVdLQjgzMlJn?=
 =?utf-8?B?ekFkdTVxTEgxb2VORG9mZFhWN0c2eGZjT3FWWHBRYXVXZURxbFdMcFlwQVZT?=
 =?utf-8?B?V3l1OXZLeS9IL1g4VVNOMWJRay9oVm5nZkM0dEhVNEdkc3VjMHd5eTVIdCta?=
 =?utf-8?B?c3V6QUo4N0NST1Q5bzZ0U2tTNW9Cd1RwMFBwcVVtaVpidEtxNzNJMHFPUzRs?=
 =?utf-8?B?Y0ZLTHNtR21LanNhMThTOHA4ZDlTQ1hwZ1N6enFBOHdONDY1S1g2ZFc4REdH?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T1FwNnNSNWhVMFYzeU9XcVJycUxCbENxSFRPZnNUV0hwZXV2K2o0ZGJ1RkRv?=
 =?utf-8?B?WHRpSy9rQW9TeXplT3A4TzlwSTFZTS9JNWJvSG9WOWlGOU1uMlVoMDNYZHZx?=
 =?utf-8?B?RFNFWmE1ZjhWNVhRclVRb25xQkpyRk9vS0tNckZrUVBJSjM4WW1FREV5MCtQ?=
 =?utf-8?B?dmFqVHA3bWg3NHhuckRnNGJtQi8zczNETG9jYXNKSk9ZZDIwWGt0ZFBaUzg3?=
 =?utf-8?B?OFp5UWg1TlRUVlc5WWJ3bllSRVFJZ09RYXZJY0drT1k4YlF5NzF2K0Z1a3Zr?=
 =?utf-8?B?WUdqRWIyVDI5UVlRMjdQYU9jOFlrVE4vL0NDa2pVOWxVQ3BpOGRHNzdvdVZm?=
 =?utf-8?B?bFFtdWdWam9SS2dWWU5scmEybEdaWVd3Yy9Hdi9zNG1UU2xJUWFGQnc3NFQw?=
 =?utf-8?B?TTNTbWp4RzNaazlKYjIzSmIxWTlZODJXbnBRVlYvTWJTczlDU3orWnlZOW9k?=
 =?utf-8?B?Um9IWmQ2bEZwYnJ4ZFU4U04zZUlMd2o3aTRqOWtxYVVBLytMTnBoSFc3cGZj?=
 =?utf-8?B?K0k2a2NwOEhtV2owendtb2tqckhzaVdVNitRd2htNWd3bmZ4U1YvR0t3c3N4?=
 =?utf-8?B?eTlPL0ZHOVczVGppd015M29yMkQ1cjBMejNSM21LSlhHek9MdDB0dmRJeGpM?=
 =?utf-8?B?WkdzQmZYamlVMDVJNGZLcWt3SmQyU2hUbmFtTWp0R01vMU9rSWVNbjZ2UjlB?=
 =?utf-8?B?WlkwZ1BJWkdNS1pjdE1yRFZjdmpoYXlTY05jVWlJNnF4OWJBM0dyOUxEVHVG?=
 =?utf-8?B?emMyK0RTK01JbGpFeHp6NW1rMDZHdjR6RnVIbkxQdzd3K3hGNWZEK0xqL2tZ?=
 =?utf-8?B?M3NPUUdrYTMwRHgzdGhoSnM4czFQTDcxZndmbzNzeUdLS2h3MEF3UUhLZWpP?=
 =?utf-8?B?RDlzV1ZndEpRVjRWdlk2TVcraWM3bXYyWEhoSmxidG96YzJ3WGdvd3lCcmlY?=
 =?utf-8?B?YTJ1ZWhzdDFUMnlJUHZkSm42MHVOZWdvMHJrVHZSRGJVT1VpYW4vN3lYM1da?=
 =?utf-8?B?QjlJNm9KaHRXTURLVmY0ZFdLZnNZeEFNeE8xSXFuSzhZZ01qOGI0M1JMeStp?=
 =?utf-8?B?c2JTdG0wY0xxZy9WQnFScXlKcnFxdkU4Q3BWaThMWlI3TWtTaVlOelBUb24v?=
 =?utf-8?B?RFNvaXpOMFpxUzlKZGxFL29MbUdneEFoZHJ6Q2VCRzE2dnoxZkNvZmNvNlA0?=
 =?utf-8?B?dXpMYUlEa29KcnViRitQS1p5TjdwY1B5MDJOL0F4ZFVrcHEreWxkVHhtS1Ir?=
 =?utf-8?B?aXA3Q1lNOGNHUTRDKzF0MTNxTnlKWlhKeHluUEV6cHFiLytKdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e04f0b5-8204-48aa-bf45-08dbbb079f14
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 01:02:41.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVdjOkbGKJTsXzAsKHB1XS0LWnW48GNPvBobmRMFEoaEP8H9eZn1ZXGepBnNLfHl/gsII5yc+VxIHO0xu6yH6R3cBGMppx/FSO6Rb3ZbFXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_01,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220007
X-Proofpoint-ORIG-GUID: qB4osOpDfjq10VNws8SLstoZ0cw_kDXu
X-Proofpoint-GUID: qB4osOpDfjq10VNws8SLstoZ0cw_kDXu
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/23 19:26, Andrew Morton wrote:
> On Thu, 21 Sep 2023 17:59:38 -0400 Eric DeVolder <eric.devolder@oracle.com> wrote:
> 
>> Scaled up testing has revealed that the kexec_trylock()
>> implementation leads to failures within the crash hotplug
>> infrastructure due to the inability to acquire the lock,
>> specifically the message:
>>
>>   crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>>
>> When hotplug events occur, the crash hotplug infrastructure first
>> attempts to obtain the lock via the kexec_trylock(). However, the
>> implementation either acquires the lock, or fails and returns; there
>> is no waiting on the lock. Here is the comment/explanation from
>> kernel/kexec_internal.h:kexec_trylock():
>>
>>   * Whatever is used to serialize accesses to the kexec_crash_image needs to be
>>   * NMI safe, as __crash_kexec() can happen during nmi_panic(), so here we use a
>>   * "simple" atomic variable that is acquired with a cmpxchg().
>>
>> While this in theory can happen for either CPU or memory hoptlug,
>> this problem is most prone to occur for memory hotplug.
>>
>> When memory is hot plugged, the memory is converted into smaller
>> 128MiB memblocks (typically). As each memblock is processed, a
>> kernel thread and a udev event thread are created. The udev thread
>> tries for the lock via the reading of the sysfs node
>> /sys/devices/system/memory/crash_hotplug node, and the kernel
>> worker thread tries for the lock upon entering the crash hotplug
>> infrastructure.
>>
>> These threads then compete for the kexec lock.
>>
>> For example, a 1GiB DIMM is converted into 8 memblocks, each
>> spawning two threads for a total of 16 threads that create a small
>> "swarm" all trying to acquire the lock. The larger the DIMM, the
>> more the memblocks and the larger the swarm.
>>
>> At the root of the problem is the atomic lock behind kexec_trylock();
>> it works well for low lock traffic; ie loading/unloading a capture
>> kernel, things that happen basically once. But with the introduction
>> of crash hotplug, the traffic through the lock increases significantly,
>> and more importantly in bursts occurring at roughly the same time. Thus
>> there is a need to wait on the lock.
>>
>> A possible workaround is to simply retry the lock, say up to N times.
>> There is, of course, the problem of determining a value of N that works for
>> all implementations, and for all the other call sites of kexec_trylock().
>> Not ideal.
>>
>> The design decision to use the atomic lock is described in the comment
>> from kexec_internal.h, cited above. However, examining the code of
>> __crash_kexec():
>>
>>          if (kexec_trylock()) {
>>                  if (kexec_crash_image) {
>>                          ...
>>                  }
>>                  kexec_unlock();
>>          }
>>
>> reveals that the use of kexec_trylock() here is actually a "best effort"
>> due to the atomic lock.  This atomic lock, prior to crash hotplug,
>> would almost always be assured (another kexec syscall could hold the lock
>> and prevent this, but that is about it).
>>
>> So at the point where the capture kernel would be invoked, if the lock
>> is not obtained, then kdump doesn't occur.
>>
>> It is possible to instead use a mutex with proper waiting, and utilize
>> mutex_trylock() as the "best effort" in __crash_kexec(). The use of a
>> mutex then avoids all the lock acquisition problems that were revealed
>> by the crash hotplug activity.
>>
>> Convert the atomic lock to a mutex.
>>
>> ...
>>
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -47,7 +47,7 @@
>>   #include <crypto/hash.h>
>>   #include "kexec_internal.h"
>>   
>> -atomic_t __kexec_lock = ATOMIC_INIT(0);
>> +DEFINE_MUTEX(__kexec_lock);
>>   
>>   /* Flag to indicate we are going to kexec a new kernel */
>>   bool kexec_in_progress = false;
>> @@ -1057,7 +1057,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>>   	 * of memory the xchg(&kexec_crash_image) would be
>>   	 * sufficient.  But since I reuse the memory...
>>   	 */
>> -	if (kexec_trylock()) {
>> +	if (mutex_trylock(&__kexec_lock)) {
>>   		if (kexec_crash_image) {
>>   			struct pt_regs fixed_regs;
> 
> What's happening here?  If someone else held the lock we silently fail
> to run the kexec?  Shouldn't we at least alert the user to what just
> happened?
> 
> 
Yes, I believe it would silently "fail" and not run the kexec kernel.
I do not have a good feel to know if logging is going to be functional,
and reliable, at this point in time (on a panic path)...
eric
