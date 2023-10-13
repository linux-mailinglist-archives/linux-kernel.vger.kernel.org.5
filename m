Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F017C7EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjJMHgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMHgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:36:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA683
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:36:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D7P95a029756;
        Fri, 13 Oct 2023 07:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mEC6wFwdvcKWkSOgMS6IHsCHwnA4I6Pil56iqCdvDMY=;
 b=sal9BEGW26Bdnts8IvXoBlPJN+6CEofHJn8nHeb+Ri90EPIZhDAk9a4mN3DRblrMPCCR
 O3tXENJG2mgRr+PnGdLVSHihkL82Whm9DoY9DCV3ZyTrpes0k04I0rm5sidioLccqElE
 V4g9bzZDaXwszYwi8/ICQDW6QLGzPrXpZS/g10Up3qE0DTVNiYA4cYM751qv7ZDYFhv/
 u3CMojy7tc0kVSFwhmTGUNBjNiWuJmg430Plh5ZvbCuaVVCV7LURAqQbJjD6B5hb7rhy
 vjTsq9tMeDo6fe/7Z/omOXIalpsPCe5+8pZ4vEh4QjrKGQsZUMhF2JRedNJUB/pEacnv +w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvuvdhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 07:36:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39D5g46O039883;
        Fri, 13 Oct 2023 07:36:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0tfnse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 07:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp4x4cynClyQlwhs2lbhMFzSkkniYAC7SyVghepCO2VgmCzQuA/hHBIADfCVgcNqmP+SV7NYzRJNs2KYnwhkqS4NPm7OfEkonBQ6Y/6+vm3x4nwFxUjx69cMs9cUD1pWi0LWjpXbPzoEC1yGl4D4tTXPm5C7qU8AImeNULTSpryp5GASV3Ar7xFqFvdo6AXcGV//ZpKyRLsfkh6XgZ7Gs4zQCGs8wT2rkg7WpVzo0fUkepq+bVFkZKHbWKqTYT/2htG4oknL64K+egwiUwjb30u55GTkEZtBzPHYFHrAhppXEv9OPUoJ5pPHmEU51eaD3nQZBNGKUgV5Dq9O8sW8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEC6wFwdvcKWkSOgMS6IHsCHwnA4I6Pil56iqCdvDMY=;
 b=QZZ8QWXwt2r0+a5IhZCSB83F9IUE7Ud3QHLmWR3eeE3BiJh3lIpIB5hvjNYzw2HPqpHzhxYlr9ykq7AG9wLjnhizH+XgJl9NXU7daOB8y+4LhZmcvUXr/XUKIQHF9ub9OT3d2mfE6tpkOKiJpAMKThvDa9/3wuutZ61wvhvD6S2Wvx1qf5u0hvVCy6sXOr/g9RvEIwdAO8OxIP8qxnZ75tFQvoSwPBY8Hs6HOEWdcjhYWt9dUKhDUBTntTmjaDmu6iB2MC5KY+aO0iBU6Gh4VvbKF1PLnzeZCke3vjC4SEqgu2GvfmycaI8yO6sv15iW9IJaT5O2hCoakYMdqReuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEC6wFwdvcKWkSOgMS6IHsCHwnA4I6Pil56iqCdvDMY=;
 b=d/s1IqvNc5ZTfE9mtqga939TLpNfCpcXFMC1uSXoPwEdFl/NHiccWnZtwnmShT+ZfpujI842kVjnTIvA4poSEbLjmobn3v1dFY9RwNH1GQz1Pq+MhDFU66WPBPgqmg5VmgbWJkbSxtZnGB2oreMbz6rhDaaiYD9QAp1qXFlBx1M=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SN4PR10MB5654.namprd10.prod.outlook.com (2603:10b6:806:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 07:36:01 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:36:00 +0000
Message-ID: <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
Date:   Fri, 13 Oct 2023 00:35:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::13) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SN4PR10MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 63262923-4538-488e-bf7e-08dbcbbf0b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFLmC0Px8IqU8QtMOGrOQSj+Aw7nHxOvW+6JsMoXdgmwEQkjYyO0agkLE2W/HfS9WLiztCwecNgcWCAnZB2jKA6lc6JVdAJXK3AT4w24IXS58z3x8BPjoK3q6z4RHrkDD5QlS87VoTmaJExxnlm/pbrrXjfYq0wLScEqoEuHHgvCX/uIM/jTCq8shauNHbXUQC3DrgQNY3AH2bt3i5sy4TJiGrVcljpvfGCNnvsZPIE+lVOZFKGRDZuUgF+JTibvfJ4/y0nF78taAGiismj8JlxgvL8eXJ7/tOAQe+ABcnk/Rc4XDKnYeN8KMhCSq79iu+c4Ieg+pYNuTrvRjDgydRbUu27OTHwx8ipKjPkZihZOgPpwGRr8DxMYvyKxGKbTmY4h8Rrzp5d0MyC62pbAgNT107mJw77OuB+mnTSloX7ngvrIlLEH0rm+1iRz56fWATS0ZGKBGy2uKPXPTUnuIWEoKFd/b9uedtNIwq2McUDK7iZBt4u1PlEYX4kOz/vQt79Z/kENFsAwcFzUqHMVaEb6qdFyNb6wjK+NE70lQJJcTsVbqkeezeL4ANmCK6DCJVF8elqo68nmevt2mYnbUJtM0iMRG+c6D8amzPJ+xElHiz3LxlCULmKYCfwqs46PfVFiD8s03DdNtX+nhzYd5wK5TYl53DjgMrMJyz87O0A2AADmdHJT2ccqwnNd2MaMWyj3vLlSaep/YQzjMW7rlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(316002)(6916009)(66556008)(66946007)(966005)(6486002)(5660300002)(4326008)(41300700001)(8936002)(66476007)(8676002)(31686004)(2906002)(83380400001)(2616005)(31696002)(36916002)(6512007)(86362001)(26005)(53546011)(38100700002)(6506007)(478600001)(36756003)(6666004)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVo3czJUMGNOWlpDU1pTTDk0SU5NQXB0RW1zdktqU1k0UG5taEg2U3dheTdU?=
 =?utf-8?B?dktyYzA4RWkyWnF2NTM4WEVvUVRBVHYwT3daVTNqZ2xPK0puN1RxQWRwYW8x?=
 =?utf-8?B?aGNpZHZZTys4QXlJaWEyRWdpVGR5aUllQzZYS2lieitoclI4UHhDWWZXYXBG?=
 =?utf-8?B?TEt5ZUVjeWlmOEFqRUF0VzM2bXNIS1A3QlRIY0NvckUwS2luc3NWTXhGRThm?=
 =?utf-8?B?dnJKMCtXcXBieGdHWUhCUE1KcEhRRzdYNEloZW0vMmg2bzZGbVlnWWcxeWdH?=
 =?utf-8?B?V1lIbytiRWhqK0ZUUzk2dGpac0RXUGplVWpKeGM3UW1ub0Z2UDQ4TTQ0a3Mr?=
 =?utf-8?B?YkQ2L214L2M4aVhwVzVhczU1cGQ2VHhYVUUwSHVuZ3NtRHc5NXNCWnY4T0Mx?=
 =?utf-8?B?Mm1NRXBNcUtqamszaUhZWlpWclBkcFNMeXF6R056S3dHdzRpeElNUk5qcElv?=
 =?utf-8?B?L01IN1pIOFYyUDBaVkxRb1gvWVpiRUlTY3kveGNNYWFPMngwVkFYek9hSUlH?=
 =?utf-8?B?Y2JFOGw2S1k2RTRKdTFUclNvMXAxRGNEdDZkMVJUNlVjVDQ3d3hJSTVjOGk2?=
 =?utf-8?B?eXd1TFFtMWRuTTJEeWdrL2s2bGxROFFTUkNNaEFhVkVtQkt0bDl2UkJvN0FI?=
 =?utf-8?B?NHFxc2Z3dXNiSEpoSDZXUThQVDJadnpjRlhDL0xlNHBEaDM5OXV2QlFpKzJ4?=
 =?utf-8?B?cnkycDVhdWM2Nm9udFJubGEzWmMzbGF0WndzMmdvejRIeUtIOEhZcWJTVURD?=
 =?utf-8?B?dVY2RWhwcWNvbTZpUnRtbjBJZlR3dVBBeUNwUVEvOURNbDN6RWliQzlia0NE?=
 =?utf-8?B?RkJYTGtSajdNeHVXYXJpcFQwOWJ0L2p2TWNnZjVwQUVDS2NmT2g3NWZVeEZS?=
 =?utf-8?B?aTN2cWxYT0E4dU9PeWpiZVY1bjEzRDhWVTJkOE1kZUI4bzVMc2NSazVPS1hp?=
 =?utf-8?B?RlRTSTBBRlFoQkhUZVhhS3NuRTE0ZkxWZDRnTHd4dWdJZXJreExiNWIrWkhR?=
 =?utf-8?B?KzRwaWJmQmF0V1dUY1NMOTFuTzFjQ25IME43R3k4TFEra0lmMllvUXhtcnJW?=
 =?utf-8?B?eDJxbEhJbG8zMW92ZEMxb2pja0lzK3hjTjl4c2gzalBtZ0NuTmlUMkFhL2h5?=
 =?utf-8?B?L0ZUWHZRbnc0dGhmcnlQZ1d4dm1UNzdPUkdzVXM2cW5HWWlJNFBTQWNjMW92?=
 =?utf-8?B?UUUzVTUvRVNPeC9WcmJxSG9SR21SOWZ3THFvQkE3QjJzQXBndDFPRldRUzdm?=
 =?utf-8?B?dGNzUy9JVlpRR0RBdVZhVmtFZjE1bnRWUWdrU3ovdVZHQ0N5VXlKd3ptMW5M?=
 =?utf-8?B?ZXF2WVRyczY3TFVmdnBqNFNzRFdGam1FMnBTQ2J5KzQwenR1RG0za3JLdTVG?=
 =?utf-8?B?ZEN5VkR4dzJoYnpjMVozaHNCelZ6US9sY0FGLzJOSXJyWTVrUXlxOXZZakZD?=
 =?utf-8?B?b1IyWFlBSGpMVlk3ZFVJN1FiVGhKVjFBUmVTcU9xNi9HT2NMZEo1SzlNaXFU?=
 =?utf-8?B?UVdVZU8xTGc1Y3N6dVpFMkNPZXRVSzh6bE1BbUNpNnJ6RG01QURyMTJjbUpM?=
 =?utf-8?B?cGxpK0x0NzJidXFTeEdXYUN4eDJWMXBHc0lyV1JaZTJVbTZmODRVZVRrSE42?=
 =?utf-8?B?VjNwVk1iMHRjRStuaG5MWWhiT3ZJU2xzcUQ5aUZVbnIzMW42NERqYVVZczFP?=
 =?utf-8?B?VGpLRG8xZHNhT2ltWFFRb1BwTVgyZzRJRUJBcC9qQlVSZ0M3Mjl6SC9QSkwv?=
 =?utf-8?B?c250WE5RNWcrTTFZZGl2eG1CaVFNajFuQkNMYy9XRmlmdUVmaGkwRmtXcFBO?=
 =?utf-8?B?MXVZN1QyMENYbGkwSytvOXJKdUFyZEZud2xvUXQ3eXd0ZGZVNHRMMDV4bmJB?=
 =?utf-8?B?bnJKblhLMkVISkcyeXk3emNyYUpaZzdBVDhHRW1qZ3hBcC9NbmdKaHpyUG1T?=
 =?utf-8?B?TG1aSGt6MVFoeWcyR2NDNWd6YmpWdHdJUElDeXdoOGhDNXJCK2hYUnFBZDBX?=
 =?utf-8?B?OWpoMXhuNVZFeUF0TVFTNTNUR3duTTM0NjhUSnJZdFdlSWp0SFd5VDROQUNz?=
 =?utf-8?B?Y1JiRGVtVkg4QTAySDJpaXRwUkFRa1BhWC91Q0ExNmVqQ0NNL2ozWVdXMkRF?=
 =?utf-8?Q?2lcyL3Y57dzTc5QbkqS4I2QV0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a3p0ZXJ5TnBpWnZuTEtrQjBuZG1KWjRiNUVQdkJHTndYK3UyT0JnTUJjQWRx?=
 =?utf-8?B?cmhPT2l3bk53am5ZOU02disyYzEzNFpEWG8zS1NwTEN0dm9CYUZ2MmRXWGVT?=
 =?utf-8?B?OElTckRYMjRvNHM0YzhJUnRlSlV6T1V1ZUpjVUdPdlFmSFJZQ1YyMjBjcDUz?=
 =?utf-8?B?eVc3OEJVQytUcDk3WGxOODBnN3R0YkNnTGQ3WnNqN2JnUXlFR0ZDRlFYa1hx?=
 =?utf-8?B?N040TjhGM0J1TFVjd1o1M3RNaVVkTmt3VHFYMzNvUU1XalBwT2lzN3Fadzcr?=
 =?utf-8?B?NUgyZUxMMTdUclhlSE8xdjQrRTZDZURiRmttbnNFdEdKWFpWZHBiSUxvQXJG?=
 =?utf-8?B?YVU3N0ZPTjFOYXRwanJNc0x4ZEhUNzVPZXV0N3d1YW92UDF2QzhJY1FCRG44?=
 =?utf-8?B?eVVmd0dFMXJ6UE5TM05sV3p6Y2d5THh1QStYdUoyUGMzQjhBelc2eUdmc1RO?=
 =?utf-8?B?WlBETFJmZFhsa0FsU3hBcmRmZGlGdFZEeUpGc0ZVeHlzWE9FTWFicUc1QjND?=
 =?utf-8?B?cHRmZHpWd3ZiRmhOaUd4aVVJVjErZlpoRTVZUm5idG9CZGYxT2ZaR0JLOGxG?=
 =?utf-8?B?SndiNjlxS2hqRFNhbTVFRGhaNWJrODVib0tpRWtRdE5iVm9WWnI1eVRvYVZx?=
 =?utf-8?B?VnpPeW1OOFJMcmhEMktoK3EwY09wRHFYUTJzaWRFa0p0OHBSSEN1blNrd2ln?=
 =?utf-8?B?aDFXOTNJS0d3TUljRjN3UEc4b1BLWE45bDR3LzVKdjhwaTI2UnBWeVRlR0Fs?=
 =?utf-8?B?NzNVV2szaW9UZVVZK0h1dm9yenlzYTFNUlNQM1FzZnpvTWhzRjhtZmJrK2Fk?=
 =?utf-8?B?Ky9qWjdQcGp0NmhJQWdYb3lWSzBNcENFaEwvdUVzMVMxYzB6ZUkxQno0TXQ5?=
 =?utf-8?B?MFJhZlpscnVyUEtZaHQybmIxdlZhb0R3YVVZVEttTzNYcExLTG5tbjhmQVVP?=
 =?utf-8?B?S1dINkVnZWM0dFhVMUtvYi9nSWNGM01sRlJrUFRPZFpVZ2ExUXYvSmppSWJ4?=
 =?utf-8?B?cHMzMDVnNndrbDcwU1o2S0dCTkhIRTBNdXpGY0xlY3NiVXJ0NmkvN2d2cElS?=
 =?utf-8?B?VnBqNytacnA4MngvVVdtTW1WTU5IYXAxZXgrZTNONG1XM2Vpak12RmZONnJo?=
 =?utf-8?B?VVRtM1NpMEVybXhSZ3JONlVzUlRTazJ2cDI0cFNmZkJyT25XMVR0cnVtZVB1?=
 =?utf-8?B?b2I1Z3hoWVhsUWlLUHZXVXgyczF1NEpRdWx3Z0tQVGg5SFRnSjRBK1BJeURs?=
 =?utf-8?Q?Uzg+NL4xMte5aCN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63262923-4538-488e-bf7e-08dbcbbf0b60
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:35:59.4785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcwNt3D2TpdoOwdaGc51zU0MGRhJw1XoErdAQd7KgcL2benuGGk+OL6oatgCzvMyseGWRQhRHpYwPP0Rfa1cHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130062
X-Proofpoint-ORIG-GUID: LBvbscsEEMcAraFYj1ggEDlZ0QL_vA2H
X-Proofpoint-GUID: LBvbscsEEMcAraFYj1ggEDlZ0QL_vA2H
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2023 8:01 PM, Jason Wang wrote:
> On Tue, Oct 10, 2023 at 5:05 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
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
>> +       /*
>> +        * Devices with vendor specific IOMMU may need to restore
>> +        * iotlb to the initial or default state which is not done
>> +        * through device reset, as the IOTLB mapping manipulation
>> +        * could be decoupled from the virtio device life cycle.
>> +        */
> Should we do this according to whether IOTLB_PRESIST is set?
Well, in theory this seems like so but it's unnecessary code change 
actually, as that is the way how vDPA parent behind platform IOMMU works 
today, and userspace doesn't break as of today. :)

As explained in previous threads [1][2], when IOTLB_PERSIST is not set 
it doesn't necessarily mean the iotlb will definitely be destroyed 
across reset (think about the platform IOMMU case), so userspace today 
is already tolerating enough with either good or bad IOMMU. This code of 
not checking IOTLB_PERSIST being set is intentional, there's no point to 
emulate bad IOMMU behavior even for older userspace (with improper 
emulation to be done it would result in even worse performance). I think 
the purpose of the IOTLB_PERSIST flag is just to give userspace 100% 
certainty of persistent iotlb mapping not getting lost across vdpa reset.

Thanks,
-Siwei

[1] 
https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com/
[2] 
https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-bfe5473f1f2e@oracle.com/
>   Otherwise
> we may break old userspace.
>
> Thanks
>
>> +       vhost_vdpa_reset_map(v, asid);
>>          kfree(as);
>>
>>          return 0;
>> --
>> 1.8.3.1
>>

