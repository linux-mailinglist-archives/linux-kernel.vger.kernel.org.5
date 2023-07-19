Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3D875A29E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGSXFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGSXE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:04:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1F9171E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdmuUCZnkJum/kms0XquuU7l3WJKjb1M7uhd0AYKI1ts8hHC4f+X8srOeo3Dlvb4H8/015b3ew7VFw5VGrjz6404ThkFa9W1j7+7OdT5fUEWAGlKAiVx4YGGj8mbx9cOxa7EbRKrM46PH17psixUxhXUTOA4hKTW3Kgm1yKBWK2zO/ZaJgfkimKIFaj1m1FjGolMqEtBJLiX6x62lBai0surgZNxNz0/vTNK2cF67DRKFZPgfIT8H7OX5m+SPHitjsKQJSSDPDxBB8uKM+owWYwPifupJW6KXEL2acCjm0gufR6tokPcSXos+LmNCAp4Ws78PkTJE97v8dvfdxe0Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZfMN7YPajL1jwR5JCs7N6iUAdl552Hxzzjs/Jfm4L4=;
 b=LUTXnS67Np1HOV7TtlG3CMTEotXJk2SADJfE9uiPSWhCN1Xyjrs+SoDIrH79+QQTJYvcOsSdRiwTaaEgj/UL622Z2BVGuUuyIB55ykofIJvt09XnPq5PRWJV3JQVyfPIK8ZevnJMlr3O3TWjHlZnHI0kysEr1mwWn/h/ha9J4B6uM0ny2Nq5J7kABQfRSebdlojtmhjchr5ENsKn63ZR0duf49P5S9gg750ostlVyBTk1/sJIzQusCyYUAS5ZS6kM4MmFBLf4B+f50WNcmeBOs/gY0iFncYkPjP4e3OxthX1kLhx2qBLygFk3Gu0JflktnL0mJFyVipMlA+4sqiuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZfMN7YPajL1jwR5JCs7N6iUAdl552Hxzzjs/Jfm4L4=;
 b=gQMIiUUJMkdU2+ugG1p+vydZbRWAXxEYNh0xCQ9aOkUCuvufEaHAd0TIspUkWT89k2j+BcAU5w+7YOdk18rOVo/7ra5sP6Ge6U4ibI8ASUfOl/Rkphb7iheH/9Tj7xpRrpTuxAAOvly8tA2zkaJSW5bC/FK5PHd0rvTpSyj0eiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.24; Wed, 19 Jul 2023 23:04:51 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 23:04:50 +0000
Message-ID: <0a714a16-c5f1-1ef9-587a-c0871366ad74@amd.com>
Date:   Wed, 19 Jul 2023 16:04:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] vpda: pds: fix building without debugfs
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230719194058.1606869-1-arnd@kernel.org>
From:   Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <20230719194058.1606869-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 25be83e4-182e-4b79-1f7c-08db88ac8dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vk95eqQ5PzW7o1SGWDHY1pcb7b74P/7aGdDw2td4IqhZIzhoT79fxtVF6w09379bXLuxLtNH8K6WEVJgd7szdVJCJhNq4cOAzILb81hRe16RO5WkLT+RN6ohf3uvPBTCh2fZOEzOuz6DnOatvwJphtG7QaA3i1RYnSTF1XJkXkKTvWDDCUHPNvdUn/+Sr3azn+HiqWYCZ6WiKTTHMKiEZFlXZloTt8qjBEckLu1YTGFhAfeoVUCf7fEZU0fVllE3+BggKrrgsI7sftYCZpsocPeBtZyPRqtdn+HabfWFSAzot24gx8ZnJsSeC01/BOVnawEf1gkdCV0td/miz9KVemD5G3+jwV5B/IjOyN9DrhphcG/J2kQ88tIZYBOXdYi5MHqHVWYHwBbK1lapnO4Ti3CHL2HL3kfdIOeuQmHFHqad/veHBrsqEhLjyPqI9VBVFnHSGxQN4KpbHUSrEPuh3DcFK7DO4WtHYzadPKsqBaskXLylaNKQk2RSy8hGYL0UuWsSy5nQ4HZrgHRK45CEQ3hjxmR5D25x8+A3VsHPob1HViBy9LyJBIMAIenr5QBpDUAJCA9bR87TATgdCEidVBpH+FzMfTH7bCb8sRHzcs7iHzTVtDv/o8W2MYbCj+kyXT9G3L9O6W/sMyKQebAHXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(316002)(2906002)(8936002)(5660300002)(8676002)(44832011)(41300700001)(36756003)(31696002)(86362001)(31686004)(6666004)(2616005)(6486002)(54906003)(110136005)(478600001)(186003)(26005)(6506007)(53546011)(966005)(6512007)(38100700002)(66946007)(66476007)(66556008)(4326008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T05wQW5Ga2NUWVhHVmtsYmFGQTgvcW9sSzVmZ3BUajJic2xnYWpGZ3hkb3ZU?=
 =?utf-8?B?TG9RMXkxRExoY0dsWTJ1RFRxTWliR1QrdmhrRGhwYUp3TVJ3R2N2T0JsOU1q?=
 =?utf-8?B?TXhYSEMrRk05b1lKOWlxLy91dGNFbFB4WEM5Njl6MmNWMlhjY3hHQktiOSt3?=
 =?utf-8?B?a0FTUUFBV3R2OXpDM0JEeTNXK3JHTGQ3QTBKcTlYVDN6UGx1UzUxdWx4Unlm?=
 =?utf-8?B?NXJYVEt1Q2NjZnF0S1JKV3hPV1p6YWdUc2xyWTZlcGlONFFsZ09EV2xBbE56?=
 =?utf-8?B?RDZWVkN1U1ZRWlRjRUs3Q2pMeGZTRjJnQmZzYzZzakhXTmIrUzAyWG1YYUlB?=
 =?utf-8?B?WXdnMDJpVGUwU1E2TzQyd3Z6RlFyaERQMVU3WUtxSHNOM1BsZ3VkUFBsY2w1?=
 =?utf-8?B?S3paQTVBcXEzbTlxekpmOUNaL1dPalJOY2l2dFRJWldlYWZ4OXl1bzhaUFJD?=
 =?utf-8?B?MkpXR0NyZnVzY09Sb0FFMUcyZ3lyRmVGTTF5OHdXVldkbVV5WDZDdXVWYkZk?=
 =?utf-8?B?c0NMMXNhVmUrK25KT0pYRFJFeS81ZWtoMHpVeHBuR1I5RklCb2FKWUZBc1JQ?=
 =?utf-8?B?UlplRDViQ3JnblJvNW1VTnYwMFRZaHRxNGZTd29PdnN1UjJpcWVFUXhJdkw5?=
 =?utf-8?B?RWhYMmQ0eDBLYVdKaTNydzI4V2cvektiMzhRU3BxcDhKdFZvR1I3VmxQUXJI?=
 =?utf-8?B?NG5obkhMNStCWVEvUDhpbmVDZlZYakVMTDQ4Qzdkb2ZXc1loTGM3Vk1EOEVD?=
 =?utf-8?B?Z0p4NTVPandaWWx6S21vUXVrb2FBaEpvLzh1NTIrU0VRL3o3dDZBYkdLcEI0?=
 =?utf-8?B?NDlSNTRiVGQwSVVSU290QTdFb0xNWkZicmJjcnJJSTg5V1MrUXM5NEppZkc4?=
 =?utf-8?B?M1VDaDRkT1RqaGR1SHVFdTJGemw0L0VzM2VLR1J6T0FIOWUxZFZqZUpWK0h3?=
 =?utf-8?B?SFNMQ0dDOSsrelRkdTZRakl2eFphc2dRUzcwcjhvZU14RkxoWjQ4eXptTXNh?=
 =?utf-8?B?cVBZb0FOQ3hFUy9xS29odTZ4ampCZmttMnRxeDlwNnJNcis2cW9sNzZkUk0x?=
 =?utf-8?B?WEhXVmFXNWpkNTBhT3RQdVp3K3djaTZiTFd1T0JQOE1KaXlGbFBodmF0ckRV?=
 =?utf-8?B?dkN4OXpBUDE3MU9hdWRSNlFDTnVGcFMwQy9LS1JPclZVZGpxb3VJcVVtRFFB?=
 =?utf-8?B?Nk5QMDV3bmkzM1hTQTd4cENkZUN2a0xZME9jdUovQkdUUHFQMU1Ba1NUTmRj?=
 =?utf-8?B?eTlqQVdTY0I2Yk5qOUtNSkVaOXlUVFA5WjFlaE1Dc2UrSnlxS21HWVY3RE5q?=
 =?utf-8?B?c1JLM0VySzdISVYvYXpialdsdE1hbzZqdk8wUE9FeEJhOUJxdDVKd0dsb2N4?=
 =?utf-8?B?Q04zUHFpUEJBRDJUeEd5RlR1RGtMaUhEZkp4U1J4NitrOFlXdHZDR09DUDNi?=
 =?utf-8?B?SDVodWo3VlZwUGRlendCR2RuUDVZdzBTaTdlSjZWbElhWUd0SnRBd0p4Y3NV?=
 =?utf-8?B?YVpRUzBySkFxL3pRRk5CV0NzRk1oR0pMcVdIV3RZWitOWUtMSXZoaFBVVjNy?=
 =?utf-8?B?M3lIb3Qwb0FIUHhyWmFVMEQzZlI3b3JleVhQR1VoSlk1N3dUWDkwelRhS29P?=
 =?utf-8?B?akpBdUpLMzBXTXpNNGNCRnN5RDVxL05NSTRZSVBXVEUrdEtLZDBlS3FON1dI?=
 =?utf-8?B?V2VRYkFhZkFpMDY2N1ArZkhTZTN3NEcxMUc0KzJKMDg4OVA4cUppcUV0WG1B?=
 =?utf-8?B?dVFORGZxL3FmMlFsZE1SOUFRRnFlZ25WcHpMVFhsYURxc3RkM0UzZ3NxdHdp?=
 =?utf-8?B?ZU1HdkFHek9vN1VhNVNOeERuVWsvclNEY1hXd05uU0RwbjRHWmtOZFJ6MTh6?=
 =?utf-8?B?d2VMYWJjTTh0Y3pQUzNGSEZSR0pEQVFXWU5iZ25OVTZPRFhmbHVLanhxMU5X?=
 =?utf-8?B?M2FNT3V6WHd1VVVWTXp5RjIwa2hlWFFPQk1JZzBYNWpXb0NhTzlxSU80dVN3?=
 =?utf-8?B?RFRGVmh3TzJ2ZU8wWmladjl3bVo0c2hDa1VwRGhRREV0RzJvTmtSWTNLU2Fk?=
 =?utf-8?B?bEhVekprNkhmcXpkZ2FXYTBUUS9YMkh4QXg3MG9NeDNQeUFiWFdXaWptTFpS?=
 =?utf-8?Q?wvPhQUDTtiA5x4byWAIk5tyqT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25be83e4-182e-4b79-1f7c-08db88ac8dee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 23:04:50.1716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0y+cpToec/25F+zge5EbNWvINmFgThiNQUKeJIZM3hkymA3OW9nNT26HC5NXdwSbAf5ikrfvRVkGjg/D1Mtyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 12:40 PM, Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new debugfs code still gets called when debugfs is disabled, resulting
> in a link failure:
> 
> ERROR: modpost: "pds_vdpa_debugfs_del_vdpadev" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
> ERROR: modpost: "pds_vdpa_debugfs_add_vdpadev" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
> ERROR: modpost: "pds_vdpa_debugfs_reset_vdpadev" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
> ERROR: modpost: "pds_vdpa_debugfs_create" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
> ERROR: modpost: "pds_vdpa_debugfs_add_ident" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
> ERROR: modpost: "pds_vdpa_debugfs_destroy" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
> ERROR: modpost: "pds_vdpa_debugfs_add_pcidev" [drivers/vdpa/pds/pds_vdpa.ko] undefined!
> 
> Add the usual #if/#else block around the declarations to supply empty stubs
> for the broken case.
> 
> Fixes: 151cc834f3dda ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, Arnd.  There is a patch already intended to address this:
https://lore.kernel.org/netdev/20230706231718.54198-1-shannon.nelson@amd.com/

Maybe it needs to get pulled in through a different tree to show up quicker?

sln


> ---
>   drivers/vdpa/pds/debugfs.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/vdpa/pds/debugfs.h b/drivers/vdpa/pds/debugfs.h
> index c088a4e8f1e92..6fbd64ace13a3 100644
> --- a/drivers/vdpa/pds/debugfs.h
> +++ b/drivers/vdpa/pds/debugfs.h
> @@ -6,6 +6,7 @@
> 
>   #include <linux/debugfs.h>
> 
> +#ifdef CONFIG_DEBUG_FS
>   void pds_vdpa_debugfs_create(void);
>   void pds_vdpa_debugfs_destroy(void);
>   void pds_vdpa_debugfs_add_pcidev(struct pds_vdpa_aux *vdpa_aux);
> @@ -13,5 +14,14 @@ void pds_vdpa_debugfs_add_ident(struct pds_vdpa_aux *vdpa_aux);
>   void pds_vdpa_debugfs_add_vdpadev(struct pds_vdpa_aux *vdpa_aux);
>   void pds_vdpa_debugfs_del_vdpadev(struct pds_vdpa_aux *vdpa_aux);
>   void pds_vdpa_debugfs_reset_vdpadev(struct pds_vdpa_aux *vdpa_aux);
> +#else
> +static inline void pds_vdpa_debugfs_create(void) { }
> +static inline void pds_vdpa_debugfs_destroy(void) { }
> +static inline void pds_vdpa_debugfs_add_pcidev(struct pds_vdpa_aux *vdpa_aux) { }
> +static inline void pds_vdpa_debugfs_add_ident(struct pds_vdpa_aux *vdpa_aux) { }
> +static inline void pds_vdpa_debugfs_add_vdpadev(struct pds_vdpa_aux *vdpa_aux) { }
> +static inline void pds_vdpa_debugfs_del_vdpadev(struct pds_vdpa_aux *vdpa_aux) { }
> +static inline void pds_vdpa_debugfs_reset_vdpadev(struct pds_vdpa_aux *vdpa_aux) { }
> +#endif
> 
>   #endif /* _PDS_VDPA_DEBUGFS_H_ */
> --
> 2.39.2
> 
