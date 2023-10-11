Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E090A7C45F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344306AbjJKARm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbjJKARk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:17:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BB099
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:17:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJiYjZ025821;
        Wed, 11 Oct 2023 00:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=veS8WWQQIIyFt/NwY9nBdPgY9oemdqUei3lnB6jRM2g=;
 b=ZzdTVGwksCuEUlxmObwCtfQs5LdWCy9H57KNTLat6+dMt2mjgFJUsoju560Tt25oJC6r
 4BTKzzfi9mu8QFnDXK4nMVbzYmP3p20zgG+6yePUebqKm2UIma+plVh/IaP6s2vTBVec
 4H3cKr7BXdAZu2yrBBBOt0xI7jfvGuw8M8kSFl2uqRf1p8Fis+lPYXzNC2xuUqhucQkS
 Pkl7e/n3xup2ZlchSxCWmqhwteOCtoydDfrCjWPVw/mucltio9GzqnF0pFqvdubdd988
 PdaD5OsGjU8BU8uUi7wb363+gqn8TFR6Iwq6+HAISypb1hrj/xZ7U7l4H8xu0yfsVha+ mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh89v25x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 00:17:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39AMRlNP014888;
        Wed, 11 Oct 2023 00:17:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws7rwsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 00:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW5hoUMouK6LOSXGUO8RDnIHeZ/3FZwTXpz3rPT/vGJAnRZqjxB8n452fvNYEazFpKanHTh5LXxypeFtZrh2aNNh2Gc3QQaa3toAxF3AmIRDGKf7K6woN2qapMTyHSwRvI/B0fyba/Rhie3b6ZviBj4WIW7MDFwz2kRSad2hVawQaUQZa8pJe4cKoUEE8/Z1g+9KsJjhpyhtcQE6Kv4jTj1rIbBDfOBPwcyGKGlbH9lffQ3zAEyaXnYFx09A/83bLPPCMiSMSgEsUXGvFcHVHx9OrGCMKTuwhKmYGBugG8vUA1FRReeXkU0KLhocn4d3bhTC9RpAXAnDaMwRhVI7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veS8WWQQIIyFt/NwY9nBdPgY9oemdqUei3lnB6jRM2g=;
 b=Gf5eW4oToD3MNZfdR0+EI9Y0oEj5GKOS3ZAP0TZw+BbGLLMpYF/sE2O5YSRA6br5wiDDg0152ewkXIppk0pk7+FFTdsSZ8tk3KZcxbySxdR0FC+v9a7FSmYawP7qLX7iiOAsXn8Nx4YyOEPqIG4THupj0B4iaIqpK8AkNCBeWBE44AuCAZuTUE6AySpr7h/OKqoM7uhByMpzZBcNSlR2t26xaQxBUpAP8fCA1wA+51odGTNp0D4Hp62PV2ges/OiXZpMyl6/hJrxY/n7hzfOfWzYiCcenZSI+q0vVEuAgL8E7FtQ+jNrRot/+C9le0Ke5UwDU0+OO2yxHqFE/0J5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veS8WWQQIIyFt/NwY9nBdPgY9oemdqUei3lnB6jRM2g=;
 b=E8EACuYFWvB7PmzpwffzIWVU++hw+2qyUB+6+FzhHGxIWElFzLpea0fqBy0bEm5/Im+Z+I5h8r1CYTUhGs2z2qoK5PWMLiDVZ/A9HM3PyIPUqk2HK+BLGgmhE/PK0Fn5LkUeeOP7SAZVx3UZHXFSg8ZI6TZMGiVG4Beaqe/r7LY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BLAPR10MB5203.namprd10.prod.outlook.com (2603:10b6:208:30d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40; Wed, 11 Oct
 2023 00:17:09 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e391:f2a1:a9d:967d]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e391:f2a1:a9d:967d%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:17:09 +0000
Message-ID: <205f093a-8b43-5b3b-7e87-2dcbe434f519@oracle.com>
Date:   Tue, 10 Oct 2023 17:17:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] maple_tree: use preallocations in mas_store_gfp()
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org
References: <20231009201639.920512-1-sidhartha.kumar@oracle.com>
 <20231009201639.920512-3-sidhartha.kumar@oracle.com>
 <d6182b74-5879-4e5a-8605-abd55542215d@bytedance.com>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <d6182b74-5879-4e5a-8605-abd55542215d@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0109.namprd05.prod.outlook.com
 (2603:10b6:a03:334::24) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BLAPR10MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5c6b10-95a9-45da-1a59-08dbc9ef68a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysI4t/fYQv+Fyk3pl6nMGWj9hkbMEcqA6TQqf4TeCl3Tb9CkdR1GDPM/24twN8BYvE6fJhaULLJDE91qRB27wKf8Eii1qqV9gDcEEm1TeRIjP0uWPKPWopj/f9bbS+scW6/jDdndFjDFhnovHu1A+v1nOCvCl4ySY0g7ekwjgM4Yjzifc6as9g0TG0y2cJBU7atyRIfvQ6GVM78OXG2XYvGiVowak6wIfG1ZGzetSeVZFgVQTx5BWRgDZbsQI1i1oUadBfc9M1bwOuWPElkt/wIQqqppYR+SJa9luwQnkWVGTQQUhc9Sixtb0ibCYcI4P9eeldDVbQwXd9KNTC8IuonI1CV37EGvFWOVLo+QF+5lexeBiNN7ZJqoTEBU7oJyQN6MCxkmvpG4m7KM5cucQ4lCQC9iACXJ+ebKNx169ZY9Y9q5/Var2PSo0Ub6EGAsRgAoVngTLxZv8R9Lq7CnhQIgA8QQQxHP0sxBDAhnm9ur9SwVjmzkklWMqfWOfveWtYMZRWd0peQ7Q/FEgy986roaKcZHg+wWiMRJ4yIVWv4TjiYpz/r7J1zPMh8IDBU1ks1sx5CI1d7YtfmaQwHVXqXnKuKPBjDxI+76PJgBMsLC0BnlN3SpUKqaVG5o4pBA3iAg0VHC9Fc/Ypb5WGaMfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(5660300002)(8936002)(41300700001)(8676002)(4326008)(44832011)(86362001)(31696002)(2906002)(6512007)(53546011)(6506007)(478600001)(83380400001)(31686004)(36756003)(6666004)(2616005)(6916009)(316002)(66946007)(66476007)(66556008)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnRuZkVKd3dpQUNtK2pYRk1wK3oxa1hvWTVYUWYxWXZTVEVkVkVpWk13TFNY?=
 =?utf-8?B?anNJNzVRQ21PaE5VYW1peEFaUWZoa0VrZU50N3pLZUd0d2tOWDRTQVhJYzc5?=
 =?utf-8?B?dGc4MHcwcnhoZUdGVzhaVHlmaHVnTUpBQUhqQm1xai9lazFaa05uMERMQ1R3?=
 =?utf-8?B?RmhmYWRIbTkvVzI0cENMeHVoODg2VkZKbTFOUG80TFBtc2dJKzRwNmwwMm1k?=
 =?utf-8?B?MUtoOFFweS8wUHRzTU4rdml0UVYrU1crWmZWMkZ4djdmTnJhYzNMbEpXWUZ1?=
 =?utf-8?B?V0xRcXhtak9jeEV5cFArT1VCbGdYN1Rrc25XUGpMUHptZlMwK3pqaEc2NW9M?=
 =?utf-8?B?UGVmb3NJaStSdU5vL2VvbGlBc25mUGNraWFtNmJxTFNTZmwxM0dNUnNhNUNi?=
 =?utf-8?B?V0ZrNnMvZ2tGaElDR3lCdzdINkZDayt1aFZmbG5ZTXVRenhxUGM2SmFyTEVp?=
 =?utf-8?B?VWxzUW1WUnAxRWlvUERVZGRxWTN6ajZDb01yUktRZkpMK1JOTEhoYVBseERx?=
 =?utf-8?B?QWdZekd3UlVGdEtxR2hrY0diN2grNERsZEpxMytHVm5ZK1hYcGVONldFd2t0?=
 =?utf-8?B?NkE5cUZ0MStVRzYvRno5RWdWVlg0c05MdE05ZHMvN0dPM1JDazBFZ3N4ZkU2?=
 =?utf-8?B?V2NTdS9kY1k0YXBnNG5IZXplVE5aUGxkQVhwTnN1MVl5amV6akNOOUZ6ZjZP?=
 =?utf-8?B?MEVNakF6RWc2WEQzaXl2OFhyZCtVSHQ1NGQwQ3FJd3RuVitPcU41RGkvUStQ?=
 =?utf-8?B?QWRWbHcwellTQ0dIVnJJM0llZHpSVUI4ckduRTdDbENMRkhaYTczV1ZsOEVt?=
 =?utf-8?B?ejVzeDk1amRhTkUrR2lzUHRxOXIwa2JLcWF3ZjhDMEFUSDQ4TDNNL29ObllL?=
 =?utf-8?B?V0k4aVl1UEJoQXRybTdlMm9zd29hRDhEb1pKcCs5dzZVVnNEZVJRVGliYXYx?=
 =?utf-8?B?bitYVzhJL1dQV0hTbWxRbHV0Wnp4NGJaNDBFbkRVTHNMbmNjcWM4UzJTamx6?=
 =?utf-8?B?SFRFL3F3ZEYxd2lnT3d5a1EzdHAzQlpsbktaUS9STC9CQ1E4VXU3Z2hYTWdW?=
 =?utf-8?B?QTk1SVVKVms4ZEM3V3V3VlRERGF2SFVRaGdFcm5xN0VjemZtT3hJYlZBV3NI?=
 =?utf-8?B?ZUFOZjZDc2tyTHFuZTdsVWpXRlhReHVKdTdJUG1RWjZ4UWxuZkVGM3phMzZO?=
 =?utf-8?B?NG9kZDdrLzlvUXBPcVNWTmNoZzB5MldwNzExM2VoblZHN0xYbXJFVUNldHJW?=
 =?utf-8?B?eWkxam5ERnBJOU8waHFOeUdpQ2J6NHlSNHZEMTAySGZsUXN1UXlVNlV0M3Vs?=
 =?utf-8?B?TE95bjZOZ2ROdWd1YVBFQzdDbU1WbFNNc1BDZDRYNHF3VjNKNk5obU0vMS85?=
 =?utf-8?B?ZmZaeklaL2pQMllBa2VERXpJbGJ4TkpRSFF6OHUzMmxWRWVMaFVRd3VIdGx3?=
 =?utf-8?B?TFZNYXRTNGU2OVpScFZ2NVFSNVBSbzJpNmVEOHk0d1ZidFNmd3JQaDRQeE1V?=
 =?utf-8?B?VnZzVVRxbGVabGhWSmVvTFdsWStYb1YwL2ZnYm1NaENKQUhzNk5LQjFFQk5P?=
 =?utf-8?B?a3Y2WXlzV0QrQ0NNSlRZb3hmb2JRb2VUejdZYkpUTndNOGV6by9mYXdnaVZY?=
 =?utf-8?B?ZGNqYlNNTlNPS1NHbXJrVU1jZEVTQ3VQVkQzRGdVanBPWU9mOUR1QmcxQmNq?=
 =?utf-8?B?bWs0UWdKTUpWVTU0TWhTbE1ISzFJbHo0MkFCNzNiS2NpKzJ3T3p0TnVxeFVH?=
 =?utf-8?B?VE5ERlBaVFJ1cys3TWI3c09KRnNpOGxyM0xIVVdtTlM1M3JjZTdvaTVIN2o4?=
 =?utf-8?B?THR6N0RlYm5hOXVJaSsxMDNnSEdkeG1zUnR2UUxhbjQ4bmN6ZmkyOC9yZXBh?=
 =?utf-8?B?eUhqdDI4Z3VBRTZONnM3b1gwbjdzZzAwUFBQVWwwQkM4QUxhakhNVyswa0Vo?=
 =?utf-8?B?UTJ3c1hCMjA2NmRudFZmTlBPWWN6VTdaM0l4NXVibDVkL0hHUXQ1ZVg4c25G?=
 =?utf-8?B?c3d2OGJYRG90L1RUYjliZTVKakRVUnRLWG0wdEJMMy9LcHV0bVAzaHQ1ZDVM?=
 =?utf-8?B?MW9kNlJ6aE9UWWlwbW40UzBJQ2tiU1BYUE8rV1RSenZlNkFJeVRNWG95aENv?=
 =?utf-8?B?ZmNLakp1eUh0d1VDVTFJQWV0U3ZobVVjRWhuMjBqSUU0aHpXaU5wNzRlWmg4?=
 =?utf-8?Q?Kr7YYMVMlQqOeE9pXXaqAzc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WU5xWGNYVkJKYy9UZHYvb1lGTGhndVNPQWxqWVFrR1VKRmxSRXdLSGt5Z0h5?=
 =?utf-8?B?T3ZiYURQbzJrQVBTNG51MDFsRVRnVzF1cVRKRllnNW1pZzRVVTF5aU42eWky?=
 =?utf-8?B?V09rT3gwWGZOY09kOGFvanBOdHd6NFA2V0o3MDNtUGxXek52SmtrNktRWjc2?=
 =?utf-8?B?c2dmZlFLWU1sV2pzYUJGUWFXc3RHSWFmSzRkaElOTzJHc1BhNHVOZXFRN2xC?=
 =?utf-8?B?TVFyc2x6T2RZbEJHNURPTjAvaFM2YkpZaUhURjl2NWxYZnd6YVV6RHhRUmg2?=
 =?utf-8?B?VFhQMUJqV1lrcUpZSUx4V1dtRzF2Z21kWE1xSkRVR1JZWDhOOFBtVGo0RHZ5?=
 =?utf-8?B?cEo2OXlSYWlLcVphaHZYNjlOYkQybGNadXU3bEVKN25HTDRKMTZxVm56M2J6?=
 =?utf-8?B?MzN4a2dkd2NYUkZRYllMc2x4Z0pFaGNwRUF1UnpBcmcyWkJqVHlqZnkwdWxt?=
 =?utf-8?B?Rll3czNpOVBKcjlrc2tnRm02NWpyZGNvaTV4dVFQa09xb2taTExuaElrekFH?=
 =?utf-8?B?d2dnWWFNRm5NTHpBbGVjSzdiMDhGV1Npa2ZDMWdGcmRqeTlMYU1rMllJY2k0?=
 =?utf-8?B?ZG1sejRzekhXU1l6clFqalByWURnWHhMMkh4SWhxUnFBeE5OZlJaZVlrSWNP?=
 =?utf-8?B?dEs3cWpwbUFCa29SODFKTDROSmM0cTNyOW4rakNIdkxndE5hNjhuOStvMFJU?=
 =?utf-8?B?d0I0L1lLdVBzRzd3NzF5MDJkMEozWVVieTdvTjNEcHlUR0V3MThxZWNORnA5?=
 =?utf-8?B?bHNTcWZMMnFZanRWV2RLbG43UlNCLzVhK0YrbXNESE0xOFlUeGxYN2NDWXls?=
 =?utf-8?B?dVpOUFlqUzFqUm5DWDV4RjM0UEVNMCtNM3ZSdC9INWlwN1M3d3h5VW1OckNm?=
 =?utf-8?B?amx5Q1NjMHVsa01ZWXFSTzZCVXlIM04xS0FVbmN1V25vcFRGc3p0a0ZNOGRq?=
 =?utf-8?B?ckxQazl2QStDZ0dPL0xOVTQ0YzRKL0NBdkpzOWpRNjNuSUU2R0ViMkNKQ1JD?=
 =?utf-8?B?c09BK1cyWWxobUlwNjlER0ZBUUdJaVR2MWdwRnJzVHl5SkRVbk05NCtFMHZl?=
 =?utf-8?B?TVFSZHViSktyTUpBZjZrbFg2K0ZnMEp3QTZaRHpKdFBGQXhyTTRjZlUvWEx3?=
 =?utf-8?B?Ky9xTkNraW9tSXVWUndWWU81T3c1WG1pUlBRbS9vQWR4TlU1d2c0UVRHdXgz?=
 =?utf-8?B?MSttQ0Q1QklSRWV1dHNYNWc0bFdNQklSOFMrd1NqRm1sTGVjUVhUNm5SdkEx?=
 =?utf-8?B?QUxabWtDaE85TEdNMDNCRE81UTR4c3RxZXVTU1h3aHo2cS9uSkRWOTFZaFgr?=
 =?utf-8?Q?feygznA0xtqBM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5c6b10-95a9-45da-1a59-08dbc9ef68a9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:17:09.5336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJIEF/HGRwhGgZBMRT/op2jpR3PzAyrPQ7aPI8yNgkp9CfDGQqA5C5YyV8QCEHyck9hFySiWMwiW2pUl1B3g7ONpEn/5IFdld1pznpVjp0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_19,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110000
X-Proofpoint-GUID: DX5JrnyhNEhftY_82RI_cVUNdiECU0fp
X-Proofpoint-ORIG-GUID: DX5JrnyhNEhftY_82RI_cVUNdiECU0fp
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 8:03 PM, Peng Zhang wrote:
> Hi,
> 
> 在 2023/10/10 04:16, Sidhartha Kumar 写道:
>> Preallocate maple nodes before call to mas_wr_store_entry(). If a new
>> node is not needed, go directly to mas_wr_store_entry(), otherwise
>> allocate the needed nodes and set the MA_STATE_PREALLOC flag.
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   lib/maple_tree.c | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index e239197a57fc..25ae66e585f4 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -5478,17 +5478,33 @@ int mas_prealloc_calc(struct ma_wr_state *wr_mas)
>>   int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
>>   {
>>       MA_WR_STATE(wr_mas, mas, entry);
>> +    int request;
>>       mas_wr_store_setup(&wr_mas);
>> -    trace_ma_write(__func__, mas, 0, entry);
>> -retry:
>> +    wr_mas.content = mas_start(mas);
>> +
>> +    request = mas_prealloc_calc(&wr_mas);
> mas_wr_store_entry() does something similar to mas_prealloc_calc().
> Now, making it do it twice would incur additional overhead.
> We encountered this issue while optimizing preallocation, but it
> hasn't been resolved yet. Previously, this problem only occurred
> when using mas_preallocate(). Now, this change would bring this
> impact to all write operations on maple tree. What do you think
> about it?
> 

After talking to Liam, I will have to implement the store type enum 
feature on the Maple Tree Work list so that mas_prealloc_calc() can 
start a partial walk and write that information to the enum. 
mas_wr_store_entry() can then read that enum to continue the walk that 
was already started rather than having to redo the whole walk. This 
could also be used in mas_preallocate(). Do you have any suggestions for 
the implementation of this enum?

Thanks,
Sid

> Thanks,
> Peng
>> +    if (!request)
>> +        goto store_entry;
>> +
>> +    mas_node_count_gfp(mas, request, gfp);
>> +    if (unlikely(mas_is_err(mas))) {
>> +        mas_set_alloc_req(mas, 0);
>> +        mas_destroy(mas);
>> +        mas_reset(mas);
>> +        return xa_err(mas->node);
>> +    }
>> +    mas->mas_flags |= MA_STATE_PREALLOC;
>> +
>> +store_entry:
>>       mas_wr_store_entry(&wr_mas);
>>       if (unlikely(mas_nomem(mas, gfp)))
>> -        goto retry;
>> +        goto store_entry;
>>       if (unlikely(mas_is_err(mas)))
>>           return xa_err(mas->node);
>> +    trace_ma_write(__func__, mas, 0, entry);
>>       return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(mas_store_gfp);
> 

