Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107127CD3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbjJRGIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJRGIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:08:10 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BC4C6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhrKqn5Pcq9ZJwg7zeWdHIIcHdKI3V2PPeCR97jj5NR70kR5C1BP+4e5/rbIT+zm5yp0QcVaGerTsIYEqT3xait3xI6IruE1hJ/z/pW59DePX2013M5hqLXFD/QhNcHTW4s2Z0JRTdaBWEXzgUKsjlbvPUvOr1RcCGpMRaf9xbSLtXGPh2o0OtXvqLBpcxRcbeZXVRegDm8cbY/d5K24n5WPGOUMiI9srki/LC6be11Bo3kCKyd31tndBiIoVRMTEN8Y+OkSxyftcb79UVqLjdbGWDNvy/Ax9Pvc0lBzoMIofmGtr+NxBj0qaWFf6ph2whHMhBtVWu+7Clht+n8NUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcJoDYEO2Wwbq4uQbPnXSz2+G/gKbqIioP4jzlbASEA=;
 b=DXwKlZLp6WuD2njbO3SjUJCSZRLHhoAw3dPX1revs4tCbdfZKDjQ+6rizo1+q95z73CxvxZXKc5t0i+ZGA3mCUCXN4Wn+Isid5WqdvCL1+yYj3jBQDw0Z1DjkzAdGQSqxj1Z0r8M4iLot3Vsm63KBPqyN0UAZSn3BXYu3+2kb/MoSBYcQnhM+GG/oDq7+HKrUVsUL3NLbsPN1X0RqW47kM/1ezNbXD02ktreUKySUN0ycIgdwWpjcc57dt5yXJDN3IaJYbvhVI893G4hK/4aoNgDoEBVCg9g0vLnLt9HUbS6sTGwJpLNZpG/pzma4CGVbV793Xe6lBwwh2Jj1eM+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcJoDYEO2Wwbq4uQbPnXSz2+G/gKbqIioP4jzlbASEA=;
 b=I/TqQHs+D9kyWK0+/EG6GZ7Jszrf7u75x1PlFqendh0OTokT5qTFz5c0mTqApU8SuMhvb2YKdfOLKgDsZWuYv0i36aIvqb5Vyw0YZIVuY+3tsmqyx9bq4eLZGETq2Rjl5lpZa0ZYxjkpm1mOxz8Ib8ISqls6UXNvagUeJkW0IrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Wed, 18 Oct 2023 06:08:04 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98%4]) with mapi id 15.20.6886.037; Wed, 18 Oct 2023
 06:08:04 +0000
Message-ID: <2dafeead-22f4-875a-8a59-4173a387912d@amd.com>
Date:   Wed, 18 Oct 2023 11:37:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Do not flush IRTE when only updating isRun and
 destination fields
Content-Language: en-US
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     joro@8bytes.org, mlevitsk@redhat.com, seanjc@google.com,
        jon.grimm@amd.com, santosh.shukla@amd.com,
        joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com,
        boris.ostrovsky@oracle.com
References: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: d4bf7bab-54fc-4cb9-c978-08dbcfa09739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noOzDbgz8WnzpB23NSaIhYWMhGpWwRFg28j7UwSo6NvCr7TqKq3U1J9SGqLhse0HoAVWBzqYmmhtVeXgq6iPdKwOK73jbfv5sJjmfZUdiAQFTLcXvp8oFIO68JQISOWYBJDOfmgldsxmUbkV/NKIv3PHpDQmcdQMzcT4z7RYq1V6lvJ7ho2M4GBbzYn36bNPlC8qaN3TD1+oyihkQkIIgmKUknM8GRpI6rnLe5OBC/I8H8D5z68J+hUQeep6Qw/gS/SyfQJYRV9zXN/R7lb760lIpnsIiuj6f9L/WToJIByWEjKdMBJGg1YFbL6o30XfrrA+r8z7KbUuDcUZrJd0Czfth4mn2l6K4kZNM2zFwuRvOo8Y8ylcYZr3tAh8Yo8Pd3zA4j5KMYj71V+2obsdq6IUjEbpD7+v8roS66dV7af2NDSzoA5tae5jB7hmqvLaAm9D1yO6nA8NcZxCG2rtdASDjrAm2sYGa4iiikvowvuNcvBuf82aR37SZ5R1JVB8czEglX9T2ow2KCdChXQW6tiwsx76Tn4KhDQfdSMXygQx35u2gXpV9tERus6Byc8n8P3LsHPiidPvsrJPguSPIVtpNsldb3UMQYx7XC4zIZ11+f4DPBBmPWvG9zDTx7S5+4UY7h/ayivbnzGggzGZ2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2616005)(31686004)(53546011)(478600001)(66946007)(66476007)(966005)(6666004)(6486002)(66556008)(26005)(83380400001)(31696002)(86362001)(38100700002)(6512007)(316002)(5660300002)(6506007)(41300700001)(36756003)(8936002)(2906002)(44832011)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnVseTlQUVE5ekd0Rkp3ZEVzT08yVXJHVmp4WWlTeEs2SzFpejFQbUR5UmdF?=
 =?utf-8?B?TlBzamVCQXU1dGFCZjdraWtPanZ4eVZONC9pbGwvSkliNVAwTWVzWTNGM3Np?=
 =?utf-8?B?aDdKWXJ3VTRxNlFTV2ZSbEp0dWdjeXBHMXhZc0hvL0FRWEFBM0F0L1J3WjNv?=
 =?utf-8?B?ODI4bjlibCszTmphbjdJWnFyNkErQ2M2VUNscWhKaTBURFUzTjJFR21nZ3Bv?=
 =?utf-8?B?MFoyTFdRaGo0OC80ZjAvbUkvMHFHZHdYelROWVVqVGF6T2txY3I4ZUZVbHJn?=
 =?utf-8?B?ZThFaGk3VXoxbWtHWUZzS1k1Y1JBZ2FRc2xrQlpySmlFb0dBdktBUzZDM3ky?=
 =?utf-8?B?clhLeDYzY2Y5OHU4M1ZJbTR2WmpUQmx2RkZhOGRIWVFITncwVzNBN3c5SFI1?=
 =?utf-8?B?b0Q1ZWl6ME1WZ1BPQWRCcFEvY0o2TGZPQVcrbmJsK010RStFYmpVS2FJa3ho?=
 =?utf-8?B?UzBhRVBCbE9qUXRpTDVYVmlNQmFDcVE4czZIYWRIYTNGWDZIRDNYNG5XazNi?=
 =?utf-8?B?V1NabVJJOHRmZU9xa3cvT29yT0xtM1ZCa2o3eWFIZHlPSlZ6RXFnQzN0SkVP?=
 =?utf-8?B?dFlzV2VpeGZBRkpwUVZyaG9mRHd5S2dxMnd3SEgxYlB1ODJjTWhwQjArY1JY?=
 =?utf-8?B?eEhib3NWRW4xeWFmbitkaUZPaXdYVlEzQ0NPcFRSN2N5MmF2c3h6WklibHM5?=
 =?utf-8?B?MVQwQ1JRQzdzb2g4eWJpYUJTTXBNUVAxd2FIajZrakM5dzV0dkNnR1gxZjhM?=
 =?utf-8?B?TTA1Nkx2R0hBbll6azExTzAxWHdYT09RL21hL0g1LzVyblQvOG5zMjFlMG1J?=
 =?utf-8?B?bXVpbTlXNHBGMXR6eHdIYVFBdStTWjZ2V1orWHU1Z2FtYkdzSGtQanNwdnl5?=
 =?utf-8?B?TFpRN2lYOXBwcTV3Y0sxcEV4SGVwdktWTzZlWDRDWE1OQlQ2M3hBR3pQc1I5?=
 =?utf-8?B?NllwYnN0Mjh0TXBBaWo4cUYrNmp3eE1NUWtXOTFOUGZMNFBpcWw1ME41NnIx?=
 =?utf-8?B?QXR3b0VZV0QzVzQ0eHJsaTdOZFR1QXM3N2Y0VFVhUUJmekZ5Ri8rVCtPMVRM?=
 =?utf-8?B?ZUFzQmgralNpL0p1QXhEUTFXbTdsSzEraEROaUt4QlI4ZEJmaEhRYWthWVRM?=
 =?utf-8?B?OEFtdzVuSHczODJhYlk5Q0lSc3AxdXgzaXg4bUhrcmFiQU83Um1iQ0p1VHpC?=
 =?utf-8?B?VHhpRFdlNWFCZnRCYUdQZW5PMllLeXdwWGhlbW8zcDRzZHFrdVFNSnRJRjV4?=
 =?utf-8?B?bk44R2tMNVkzMkdDZFFka2lTejI2UGRGcnltQVFxL1hVdFdBdWZXMUF4NktU?=
 =?utf-8?B?T1c4S2g1NXhEaTh2bWcrQThSM1BudFZDMytMZ3h2Umg5VVFia01TZmN1RTYr?=
 =?utf-8?B?aURrUnowQTN3d1B6OUJLdFdta0QxRGpJUWlzamxuT1NJWGxsbUtUTDlEei82?=
 =?utf-8?B?aDFldm1xVFZXdWpQUG82WDdOamRGNERaUVRxYkV5ekswaDVWUmxRbzlaNm5o?=
 =?utf-8?B?UURldVNxdERlL1dVQklvWGNPMHpTME40ZHJRYWI2ckJwVUhOZXdTbnZMNnEv?=
 =?utf-8?B?aWtFZDB0K1NveUVrTFdUMy9KZFBjUmh0RExkT21YUlNEaVhFZ0lDTVJzNEVh?=
 =?utf-8?B?bGZhRlFDR1MrTnoxUXBlT0twTTNqWkRKdHVxVjFveE9CQ0VSaTBRUUdlSERx?=
 =?utf-8?B?dFZScmZFRm9lRi9vQ090OUJqTGIrRVpvN0MxUzMzVmx4OGVBMXN2MEpWb1lu?=
 =?utf-8?B?MVllVVRSV0dmVkt3S3V5bUlFRlZWOVRhTWt0d05NcmxNMjEwY200eDkyTC95?=
 =?utf-8?B?SVlSWG8ycW5ZdExyaHdPdGowUWdObFRIczhaZ25JN1pkbzdjaDNpVzZUdkRw?=
 =?utf-8?B?UHlvcEZjd1htei9vc1U5NVhlQkdLTGt4VUwxZmcwUXN4d3A3OXNUc2VldU1l?=
 =?utf-8?B?WGN0ZUdmaWgwV3JvQW1LUUo4WUVQUmZIUC9RWjRNVkdoQ285ZEtCM3VocUEz?=
 =?utf-8?B?ZmFqNFZieGpiSkdteENkRFF2dEMvTWtaMWJtUmFGK3pMUy94UmNKNTVzaHoz?=
 =?utf-8?B?dlIzdEdsQndRYVp5VjlGZlYzcTBWVUhwekZyYlowdjg5aFROS3ZrZzNETEhQ?=
 =?utf-8?Q?wlGrmg3Si6ybAh1huT8+ZadBu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bf7bab-54fc-4cb9-c978-08dbcfa09739
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 06:08:04.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GP4Lir2U7aW2BSZ5sDEe9PYKOTri0gTmogwRuKK+XvqdKEP5R82uLKxuBsJw3HR6PUpVLLNpFbfmB9zNKauOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2023 8:12 PM, Suravee Suthikulpanit wrote:
> According to the recent update in the AMD IOMMU spec [1], the IsRun and
> Destination fields of the Interrupt Remapping Table Entry (IRTE) are not
> cached by the IOMMU hardware.
> 
> Therefore, do not issue the INVALIDATE_INTERRUPT_TABLE command when
> updating IRTE[IsRun] and IRTE[Destination] when IRTE[GuestMode]=1, which
> should help improve IOMMU AVIC/x2AVIC performance.
> 
> References:
> [1] AMD IOMMU Spec Revision (Rev 3.08-PUB)
> (Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)
> 
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


> ---
>  drivers/iommu/amd/iommu.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 089886485895..d63590563d3e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2970,8 +2970,8 @@ static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
>  	return index;
>  }
>  
> -static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> -			  struct irte_ga *irte)
> +static int __modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> +			    struct irte_ga *irte)
>  {
>  	struct irq_remap_table *table;
>  	struct irte_ga *entry;
> @@ -2998,6 +2998,18 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
> +	return 0;
> +}
> +
> +static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> +			  struct irte_ga *irte)
> +{
> +	bool ret;
> +
> +	ret = __modify_irte_ga(iommu, devid, index, irte);
> +	if (ret)
> +		return ret;
> +
>  	iommu_flush_irt_and_complete(iommu, devid);
>  
>  	return 0;
> @@ -3681,8 +3693,8 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
>  	}
>  	entry->lo.fields_vapic.is_run = is_run;
>  
> -	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> -			      ir_data->irq_2_irte.index, entry);
> +	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> +				ir_data->irq_2_irte.index, entry);
>  }
>  EXPORT_SYMBOL(amd_iommu_update_ga);
>  #endif
