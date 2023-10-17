Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E007CBF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343523AbjJQJ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343505AbjJQJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:27:01 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EABED;
        Tue, 17 Oct 2023 02:26:57 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H5e2MV026123;
        Tue, 17 Oct 2023 02:26:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=message-id:date:subject:to:references:from:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=KgqNRs0JEmfBXYmeW9XWvbelTwlgzz+3eCvAN6kkMig=; b=
        HfOXixj0e7kNChQLLX7xNkSgeq5zAS2SdJBf8LRkUKm+SnDhZ/T0LUsBosNhAZnp
        43/Gz3dkj4vLVlxx4UpO5Q4t8QV2NbuGagwaDINfmWNofTvXdhpk8A6+LebaNG/3
        +TC2JgYyVeUK/x/I9riRczMDG2+nuP6XDbFtVf76E+46eG347YlI0IUDc8UAfu5c
        MlubV4/WK3ViXDfhwaIOeLJETv8wvtB9sLw3uRBvXLsxsIvcMfOeMl3933u/88hD
        4l7yvNt65rVrxTuOOjRG3KrIPenT4GRUBeDqW0waMAOu7qUwhYKU+1YWIt/Da9M8
        or+SZULYghkWTidGZRewhQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tqp90tq04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 02:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB5Eyj1QUHAhNIPGagyJfO2kdQCDc9tPYlZfPlBrJD9FgGPKFMa2THqJGn97Gg6ugcB8TXE3Wq/mZEB+Spb5Z0BMfjPcypLJCwlG85aGxSU9la5N3qzhXE3JjTGHwTzhGL2ZNsAmBQCGUOekoV0eS9kmFJ5F5YfTEEVE9bDUL61hiyWazc0/o5qKclkxz4bIHSAymN9Mb8IE/qmXtGjEKKUCTaVK8G6gK7BRjzRhuZayAGKRjqgpzHkRIAp9frQ1Ru5FUtMj0DJb25+wurceku6vCVyX+BfhCJ8KswmHqqGH8tZH7U26eFZlcpuwY4ZE+q8W7rM6rGXXI7I87BoGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgqNRs0JEmfBXYmeW9XWvbelTwlgzz+3eCvAN6kkMig=;
 b=jlLsvAVCLC8SAHcuoui2sZY40lSlDyF85LMg2emNs0tne95Tb2EZzVmr4Oh0sjYoDGUdFhLIyCWXYlYyUfwtvKculLXZgVroNN3fsjp3tQ7eD6zWYc3cbuaIf0EmWG88/ndCHguEmFuCxGYLO869dDidMJVDQ0psGq8T9BgxVHhJ3GE+Bw3XIP3Pzd+aH/ljKchT/9/5mM6uwTsf7YXW7K8UjHY2jxzMpRC7lyXTntEkr+xFPbK0VCoA4U4po6mNMm/abphorendhu+dm9xakciJPJ1jtQLrQioWhwSx4gYPcgcuj6rxRTELTTw8a9lVL7aKq2aReP3r2/Sbz6ck5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3595.namprd11.prod.outlook.com (2603:10b6:5:142::16)
 by MW3PR11MB4698.namprd11.prod.outlook.com (2603:10b6:303:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 09:26:42 +0000
Received: from DM6PR11MB3595.namprd11.prod.outlook.com
 ([fe80::5c57:e5a2:6ea8:9a9c]) by DM6PR11MB3595.namprd11.prod.outlook.com
 ([fe80::5c57:e5a2:6ea8:9a9c%6]) with mapi id 15.20.6863.032; Tue, 17 Oct 2023
 09:26:42 +0000
Message-ID: <3039396d-1dea-8b77-453a-7beebf5c6348@windriver.com>
Date:   Tue, 17 Oct 2023 17:26:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] block: fix ioctl return error with GENHD_FL_NO_PART
Content-Language: en-US
To:     Li Lingfeng <lilingfeng3@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231017080900.842241-1-li.wang@windriver.com>
 <907c4906-3595-aa6d-8cba-5daa7133b17f@huawei.com>
From:   "Wang, Li" <li.wang@windriver.com>
In-Reply-To: <907c4906-3595-aa6d-8cba-5daa7133b17f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To DM6PR11MB3595.namprd11.prod.outlook.com
 (2603:10b6:5:142::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3595:EE_|MW3PR11MB4698:EE_
X-MS-Office365-Filtering-Correlation-Id: b9728444-733a-4273-7388-08dbcef32c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6y3sfG/HdVvsIAXakVh3tPw2g8iQRFhRia2LcG/h/SqsMppV5ssVxd1MC36dYrltJofv5SYoN9TRqHS7NpDMNaSXAjrkgArobuaOr5EJSR3rwj6sk6UaOifx1nEoeBAB8Yw81eRhGjNFl7ueEtUH7i6P/dJFdv7zrDUVw3nzKb1Yq3ngTVRRiayfH4/m5zdbYg8zo00SkZCZGiwpETargg0gZlJkkUWW8rUofolhch9WerSkxsSDz5VBcTJBCPcSWtKdfrIaN8ZXoykFjjkqS1FSoxK9JGV585eNQhs3oxTgrLWb0949bIuTF964OC/vl40TyDWLYN+AOamqKPlaGIqE3kDxmhb7mEHalO8ZwCr0TCaI+AoyMms46dge53kvwuRFYShCl1RPBp2uYE0/CzCVwGgocIpU57azk4xyH6/8+WgBHDgbiSNcoZJxFKCeV1zdF2Dv626VjXZWHIrnOiGZ9tlGzGTLS5U+429jhHM5ooUHPGXuEMwiuWLekCWjapVLVzPjlk92VYBF1bX5Mi9CHjynRmNcjIhMDS2J9of3C6k/k10wFLU/hZmcAQCYQ9LFycDgEKNbleO/x/CZpncGOqx+U2DDFcYtKpjIL//XrlJc6hotobyjl0m0Kn4K+8tDFflTGfCHuSk02RC2Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3595.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6506007)(53546011)(5660300002)(6666004)(2906002)(83380400001)(36756003)(26005)(2616005)(38100700002)(86362001)(31696002)(6512007)(6486002)(31686004)(41300700001)(316002)(66946007)(66476007)(66556008)(8936002)(8676002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2tZRDVRV3hTTDNwT1pmTkdqTXRLZ3lUYnN4TTZyQ216ZFZTZ2IvMjlMMG5S?=
 =?utf-8?B?UTBnRHBtNmNxdCtKcUpQbGVFcktYR3hrWTV0NzBHQUUwZUg5NnRIZXFBUUh5?=
 =?utf-8?B?bW5BaFhrSHVuLzgvWUpxeENhVVVyY2dhT1BGa2JNSmpGMDF6OHFSMFVDTmVC?=
 =?utf-8?B?UGtoTWJTR0RnZnY1ZVFrencxZDE4clYxNmVwbmtPOUl4NU9qV2pVRHBlV0dx?=
 =?utf-8?B?OTBTNTJ3aW0yL2EwSHAwN2lrejdyeUYyWXJ2NktNY29kVnpEb1ZiSERseDJq?=
 =?utf-8?B?YTNvdXAzdTNNdG9YeU1nRmJudnpYcC9RUGhnNVo2aGJ1cmN1dkNGdFgvNmJM?=
 =?utf-8?B?dS9IM0lvNDJ4bFNFTFc1ZGpwWkFyV0xhbW1lcVI4U3FBNWFCQzdpZmYySVEy?=
 =?utf-8?B?NEdkQUZ3dUlJZ2xIbDhTWmtmWXNtUk9ZQWorQnVNZ2l4MHBJdHpEMk5JUkY0?=
 =?utf-8?B?UHdxTXBxbXpyc2d5VWEyT0ZRcFFZUy9rS0hQTm1HQlRYai9IejB5b0tVdkVt?=
 =?utf-8?B?RnV4azYxc3VUY1JsK2NJY2xEMkZQVnk1dUxKR01KODd0a0QvRjJXL0ZmQ09E?=
 =?utf-8?B?d3pMaFJZVlhWMnFjT2F3dE5LckE3czZnS2VlOUxLRjVtQ09XT2R2QzZUSkl1?=
 =?utf-8?B?aTh0NHpIdVFwQnZiZHVVajNJVFhWcnJRWk81U1AwTkkzODdsaXBBc04yWHU4?=
 =?utf-8?B?RlZHMnBHM0VXM0lSTkhtQzJ0SGEvMlY5VnJSajNldENaaEdGVUxMZlA3NC8y?=
 =?utf-8?B?a2c3MEZFOENaQmdHMkFVR0Qvdm9VSGdaS0hieDZjOVNraDJSZi9ZeTNiaHZo?=
 =?utf-8?B?RkZTUDJLeEtaZXZxVHU2VTliN1l4QmY1L0F4WEMzN0VweC9SQmxLNnJ2cVU1?=
 =?utf-8?B?R2JualpldHh3QlVwcmtvNWp1MzdDcXlHNjl5ZVM0VVdKLzQ1UjNnVFhDNjlk?=
 =?utf-8?B?K1Z2aHUrSG52dkpEbGZ4QzdJM1FIekpycmU4RDBEYTIwRXoxMlpXUmduSEc1?=
 =?utf-8?B?bnVBcVlsMkliVnI5MXJxekJEdlNLLzg2S3dnbWM3ZE5kN3hPZTUwUFN0akFR?=
 =?utf-8?B?UWlWT0FUTHhGWFZjdUNzUkR3MWU1QWNuei9VTDd5ZWtNQ0lnZnU5WGFZZjJB?=
 =?utf-8?B?bWJiR3lhbzdFZmwzTllUTlArNUtIVGVsRytFM0dDNll1RS9EdWpXSEQyS3cy?=
 =?utf-8?B?R2xSZmlFclhzVWYrSXNOMEZrdmJHQjJGcnV6MWo0WUV1Tlh6Zlg5ZFRwOFho?=
 =?utf-8?B?ckpjMWgrdTY3VVlGQmNzRUhEMnNiOHJaODRGNlI4Z2Q1U1JZZGRMaVJ5WTJx?=
 =?utf-8?B?ZW1nd2h6V1lJUSsrMUNHZXg1eW96bHVpVWFlYlFDTXZlNDZLdzZhMlJWL3dQ?=
 =?utf-8?B?NmZiVlNSWDZ3cVp2WkdxbUs4eHdheGp3ek9XenNVam5TaEpYMFh3dTdtQ1N4?=
 =?utf-8?B?S20wdWlyWkV1SWtrY0IwTnlGb005Si9QdE82OGsySThHMWQyNVg0QkZUbDB3?=
 =?utf-8?B?Nm1EN1J1azF6czdzTVUzNDVXb2diTWFFMFB2WkY5UXM2SjBkSXFLcmptOVBN?=
 =?utf-8?B?ZkVqU045QlVzYmdvbTkyZjFwVVpKYi9HbnpkZy9Nc0RXK3VKbWwyVWxGeVNK?=
 =?utf-8?B?UE13WTYzeXJ1QlNWL0VGcFZ3ZTh5MXROOFJJYWthY2lhbTIxbXJGZDhrMk1j?=
 =?utf-8?B?VitOTXdKVHlhY1k1N0k2UEhDbW91N0ozWXhSdk5GZzRCRm4zSzFyck9rUEFw?=
 =?utf-8?B?QjRiQzllVy94by90dmdmNmFBK2JXaVIyYVlzUDhzYmkwWFRPblBLUTgvZEF6?=
 =?utf-8?B?aGd4UGU5YlhKUVNJZXdobXh3NTBrSlVndkF5SFdWa1dRNWg5OVVOcmhOZ1hJ?=
 =?utf-8?B?dG52bnFySlhZTlBkQUpvMnp1SEFkZXpteVVnZFlId0c5NmZKcFpZaE53ZjE2?=
 =?utf-8?B?Yko2SVVlbmY4YmFUZlc2eVNtK0sxUWNPMFVuTGMyOXM4ZmJoWlNkSURkci90?=
 =?utf-8?B?UElpRlpuc0JGcTBVSFRCNm5aVkZub1pDT3dDREVPM3JuVDZoK2VBZXJYaEdt?=
 =?utf-8?B?dDZkVmRIL2VmdUVrT0NDWDhUSlpvTllubDRvQ1l1UE9sbUdqY1pjTWtWQjZp?=
 =?utf-8?Q?Bs9MwqrtEK9u4TDfnsj33ObR9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9728444-733a-4273-7388-08dbcef32c26
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3595.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 09:26:41.9170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVB8OSIraHIeEpm/zpFKvXF9B3fy7lnMQSfGZ1p0Mp6OIUdjl1jsuH8VlQky2/qrYpFyLbnk6dDJ3zucxd0S7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4698
X-Proofpoint-GUID: Rj3nDt5dXc4hH3NHoxin9fnEtfLCRV38
X-Proofpoint-ORIG-GUID: Rj3nDt5dXc4hH3NHoxin9fnEtfLCRV38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310170078
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refer to previous codes without GENHD_FL_NO_PART, bdev_del_partition() 
return -ENXIO:

Thanks.

vim block/ioctl.c +35

static int blkpg_do_ioctl(struct block_device *bdev,
                           struct blkpg_partition __user *upart, int op)
{
...
         if (disk->flags & GENHD_FL_NO_PART)
                 return -EINVAL;
...
         if (op == BLKPG_DEL_PARTITION)
                 return bdev_del_partition(disk, p.pno);

block/partitions/core.c:479

int bdev_del_partition(struct gendisk *disk, int partno)
{
         struct block_device *part = NULL;
         int ret = -ENXIO;

         mutex_lock(&disk->open_mutex);
         part = xa_load(&disk->part_tbl, partno);
         if (!part)
                 goto out_unlock;

         ret = -EBUSY;
         if (part->bd_openers)
                 goto out_unlock;

         delete_partition(part);
         ret = 0;
out_unlock:
         mutex_unlock(&disk->open_mutex);
         return ret;
}

On 10/17/2023 16:58, Li Lingfeng wrote:
> I don't think so.
>
> GENHD_FL_NO_PART means "partition support is disabled". If users try 
> to add or resize partition on the disk with this flag, kernel should 
> remind them that the parameter of device is wrong.
> So I think it's appropriate to return -EINVAL.
>
> Thanks.
>
> 在 2023/10/17 16:09, Li Wang 写道:
>> GENHD_FL_NO_PART means no device(-ENXIO), not parameter error(-EINVAL).
>>
>> test case with parted command:
>> @dd if=/dev/zero of=./blk-file bs=1M count=200
>> @losetup /dev/loop0 ./blk-file
>> @parted -s /dev/loop0 mklabel MSDOS
>> Error: Partition(s) 1, ..., 64 on /dev/loop0 have been written,
>> but we have been unable to inform the kernel of the change,
>> probably because it/they are in use. As a result,
>> the old partition(s) will remain in use. You should reboot now
>> before making further changes.
>> @echo $?
>> 1
>>
>> Fixes: 1a721de8489f ("block: don't add or resize partition on the 
>> disk with GENHD_FL_NO_PART")
>> Signed-off-by: Li Wang <li.wang@windriver.com>
>> ---
>>   block/ioctl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index d5f5cd61efd7..701c64cd67e8 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -21,7 +21,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>>       long long start, length;
>>         if (disk->flags & GENHD_FL_NO_PART)
>> -        return -EINVAL;
>> +        return -ENXIO;
>>       if (!capable(CAP_SYS_ADMIN))
>>           return -EACCES;
>>       if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
