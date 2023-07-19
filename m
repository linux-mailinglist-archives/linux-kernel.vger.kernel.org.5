Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC427598DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGSOx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjGSOxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:53:22 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8F610FE;
        Wed, 19 Jul 2023 07:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCHlUu5JnWKt22XJHNqzgjpYdJ/5EHAI4Z0/IPgqw2qVFvafIZTupMyFToAsHD7H/Tch087/9hgbZzOn5djskgTkT38FTGOm1eB8jkJs001X/tkEqgvKY8avrQFLpFoAETZ3WFYVk61fhAo3pXPPO26+oafQpHcDXLnwcqkP0HOKmKXUIrKqDmD+eNu/gR2YeEfdzavR29fgdEdqiOBsSnD9jFm67cHjm4a/2Mpp4BhvYuCWS1Ncng3QWe+EZxZm/8aNYjOiX9Hzlv84agfoSVlQp+EsO9N643ugYsa5MF4E+aYjnjZv+unbegr/s+kkgkTqZWHW0woJk/jto4Qeqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyPxpPZJ701epvPzIf+cizl6BTmMtJC2gnLfWznx964=;
 b=Z5dniVZ4UGP3MvUgu+P9XkwXWNNclxiWOQfey4HN+0lnf1J1gq2siGVSkto0LbK7L/zdFBf7lVfdhPyQ24VggHH7C45EI9gixWiGC+6GDaD3qAahIOHt7XegT4NxMAr/KXpOZOvHEcjXlgv69CBH4Q3zXUwR+wi6vcfj0qTCLaqsVYUo0Q/MJgVUeCwKWxHgq40BUWuj7HiDI4o3AiB941gU8JMpf7KOWEhE5wntec5U11Qa8mDWPBHb1MRsa3RBCQDSXZW0a2WTdp8qKw/YexLLmMwBua5z6wDeCA4vrkmvlA0uJTWpavE2wrIVwGtb6UaCAruWtWhHbUKwKbxNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyPxpPZJ701epvPzIf+cizl6BTmMtJC2gnLfWznx964=;
 b=5gzdLy1bQDYldo0isjymJ9aK2NF6T5ent4J8zgsd9T1p0SzxRkWbpNwj3DDguuKhGCTEyFsuTvMkYbnMtlKSt/+OwxdLgFYl2AClgKLRVpY5O6DNWRvBj9zppp70OqgR/wSKCHDbk3CjVQOBShinMu3hbZZNuMueII5LjQy23ppNRMvs4H9eO5AngNVzacOU9Gx+z1o3GoiuspCdfiWticqy5qqXnTkPdlUNITn6JOGoFfsamPT2yV+nvPwnt3+bVNSC5QYYXnL80ZEjF/SFQfOetIFfmyQH3EP2gqEGslv2hySd/HdsWFr51ToBYHYZocB9NLawEMYLGIVrNsyPzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR04MB3098.eurprd04.prod.outlook.com (2603:10a6:7:20::28) by
 PAWPR04MB10054.eurprd04.prod.outlook.com (2603:10a6:102:38b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 14:53:18 +0000
Received: from HE1PR04MB3098.eurprd04.prod.outlook.com
 ([fe80::ede3:d5c9:4725:f1f5]) by HE1PR04MB3098.eurprd04.prod.outlook.com
 ([fe80::ede3:d5c9:4725:f1f5%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 14:53:18 +0000
Message-ID: <7483deb3-2b69-37fa-28ea-fb54aac58ff8@suse.com>
Date:   Wed, 19 Jul 2023 07:53:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYxXSBzY3NpOiBpc2NzaTogdXNlIGtm?=
 =?UTF-8?B?cmVlX3NlbnNpdGl2ZSgpIGluIGlzY3NpX3Nlc3Npb25fZnJlZSgp?=
Content-Language: en-US
To:     =?UTF-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>,
        Mike Christie <michael.christie@oracle.com>,
        Chris Leech <cleech@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:ISCSI" <open-iscsi@googlegroups.com>,
        "open list:ISCSI" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     "opensource.kernel" <opensource.kernel@vivo.com>
References: <20230717092657.9776-1-duminjie@vivo.com>
 <5bed6236-0db7-37fd-3d0a-4f51874f9c53@oracle.com>
 <SG2PR06MB5288D9E4D3124B5577ACA035AE39A@SG2PR06MB5288.apcprd06.prod.outlook.com>
From:   Lee Duncan <lduncan@suse.com>
In-Reply-To: <SG2PR06MB5288D9E4D3124B5577ACA035AE39A@SG2PR06MB5288.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::7) To HE1PR04MB3098.eurprd04.prod.outlook.com
 (2603:10a6:7:20::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR04MB3098:EE_|PAWPR04MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcc27c0-876b-4a05-ac0e-08db8867e324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqLz85oTmXaHrlR1awALtMxaSzedm+le9MKPJvIT1j6PvnG1PFuxj36eGDlVscE3S7IiUCpHsl7Tkcy/QQKMNim+enN3tBs1YF7eJA+TZRAFG2r5nyBxjNHNARVdguHqZvnhEXiqFdkK1gE7d6oRrwkt5dXf4nof43Iq4QuSMpGnP9ihwo86AlIplBuHmtdeNIFuxKz9G+8D1E1pdp6IAfTlESeyEW5AsIbyPuJtmpJakhcylQ+mxZDiYe2tBIMGsmf/H9U9oolvKxXvsb1k6vd0+x48lctqfVduyQ+KvahQMHkwztev2cKM3DM0yIkcfmO3fCYYZrfEODS+o4VVQENFTWlAu12x9LxF0VQ8fXE5OWn4Z75mOwEkG1M06Yc+C8rqeaW91ryxxM6ISvoyp9OEs4OPMXQwGL0THFZgeTpPRu/KDZMGXHfQZzDhQ0QClbicSUJFocwFm4g5msQtbIVVjooPmvoALfm3NEs2Di5D/CnNnsdNZIUe/LWGV/GGJlwlqVZkynMvD8VoYPktxaUtlWzkozeQ71Sgaf4b3xESY+QxjXd5ujdJomwFoeV42WXqAD21YFGrkknynmYAALQUR0UVqUheCAoqSOW23WbqFfPU0D8MGTPv+QKJoX50fbvO+wYTNEsGY2C3AuGwzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3098.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(478600001)(6666004)(83380400001)(31686004)(186003)(2616005)(26005)(6506007)(53546011)(6512007)(4326008)(8936002)(86362001)(41300700001)(2906002)(316002)(5660300002)(6486002)(31696002)(110136005)(38100700002)(224303003)(66946007)(66476007)(66556008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjdmZzVDYWMwNTF5WjFhUHVUNER5ZXZpT2dSWTd2K3lpOXZuRmZQRkswL3lL?=
 =?utf-8?B?a0xtRlhEbkRvUEtOUWxRZThDa2QvczRFY0pmczZHdDFqdlliUWlkb1dBYk1I?=
 =?utf-8?B?a1M1NUhNa1VzMnBSbTNRcHJtZlU0SmI5eHBiLzN0WWZ3ODhRTFVNcFVDSGEx?=
 =?utf-8?B?VjFacDZqa0FwY0hWTlE0Smw3d3ROdmVtL3hxVG5xakpUeFJYL21DbGNrVGJt?=
 =?utf-8?B?aHplbGkrWjQxTERqeUtqTlQ0bmRhS09ab1k1VWIxSUJpVDltakxmbXZBc2Fr?=
 =?utf-8?B?NWM5SGM1eGpKdlpaZzJ6WGxZTTdSYUo0RE9pTEVRWXNndVhvc3doZStDenNC?=
 =?utf-8?B?YXZKdG9MNVp5Y2U5cnVUZkVWM0liamF3d1JUMWhZL3dtMk1MWmlieUY4NkNF?=
 =?utf-8?B?dEtVZGs2TzFmcFhQbDQ2bTEwVjZqczR6VTFRekQ4ck51U3lldzRXTkwrWkFV?=
 =?utf-8?B?cDRZVUl3aHc2eWtKR3BHeVkySXlFTjlMYVBnZTU2R3U4cCswMGpMdG1xM3N6?=
 =?utf-8?B?U1JSNUwzS1JOcWRlQ3FHWEtzK0g2VzRUMEtKOTA3cTN6RHc5OENEdnBZVUtC?=
 =?utf-8?B?U0hTSzhUaVo0eWxUMVdVUkhRNTVkT2tId1czYUw2NWRqa2lXUjd5RjV0ZmJS?=
 =?utf-8?B?aURZWlFxTzNOSVBKdERWMVlUd3pVcXVOVlVoRkJvN2NJZ2lqV0tyWHlvcXNz?=
 =?utf-8?B?anV4VnRSdTVCZHdRdVdRM01kZGZ1VjA4Y3piUmJGSTlmcE5rWFZhZFdvSXJR?=
 =?utf-8?B?NUZwWEgvU1NGQkgrODdNUmgyQU1CK1R6Qk02TWptaENsZTNFTjMrQU9RN3RU?=
 =?utf-8?B?YTZQczg5WFpzbUJuajZBZkhXY05TUG1zVFEwNmJPNnJERmsweXdEcjk5M1NY?=
 =?utf-8?B?bUxrMG5vVTVPZGVxMHJtZ2hHcmhHMnM0VW1HbTU2Zjd1M2o4ZXFaeWVZcm15?=
 =?utf-8?B?dHhzWnlESG00UjV2V0FYUzN1bXZSdUNKdkhYdU5ORHExQURKUG16N2pVSk5i?=
 =?utf-8?B?eWhtbWZXbldqNEJMQ0piRFlJUUtRenhQQjJRSjN1eXVBZVpqSUMyd25qSElS?=
 =?utf-8?B?ZXM1bFA3R3ZueWkxalRjYWhJeEZnRENiR0tOSkN6SmJvOGluTmdBa0RwRllx?=
 =?utf-8?B?ems2bmNtQ1lwSDRLd3lIUStqS3MyRndUZ0hTK3NNeWJRZEdPeS9NMUxWNDN6?=
 =?utf-8?B?K0dvc3hPSFhOY24waWxBVVM5cG50azNySWYvWW8yWnRIYVVWRmY1eWtiZmlX?=
 =?utf-8?B?dnY0ZElPUEZMdnU1K2xEdlh5WG42YzdVdm5kbjIzT1dxNlFMdWZUc0ZRcGhN?=
 =?utf-8?B?UVB6RnB5aDdzeWZadW5pYnVpdmVEejNFYytqM1BWcGRPL21ZU1plQjRjZ0Nq?=
 =?utf-8?B?WnBsRUt1VmZacjhUalBweHN2aEhSeWU0QXk1Q0ZSUldnNUZOM3pIenRpK2Mz?=
 =?utf-8?B?enJjWFRPeFRVVHpSZXBrb0lEM1plTmtKQklQMU5tVUpXZ1Z0WVBwU1pBME9t?=
 =?utf-8?B?TE5wbE9KcWFIMnpDdDNJRkpqUlpkVFh5OFR0QzNwaEsrUmt6RW00eTU0L2xm?=
 =?utf-8?B?aG1YNEpORHZCM3JVWXJjalpMOUR4d3Nudmd4aVdJNWEvVUphWlF2anBOWDdW?=
 =?utf-8?B?YzlKOU5kdlZFaElqeS93K0dRSjRHdC9TTkcydVpZZFlXaHBESVc5WmE1bE1J?=
 =?utf-8?B?cGFGYm5nZGNGcnNMeFVqMFNjZkY3djJoNGRJVkZlVUpLN1BjbWFCeDhjVTNi?=
 =?utf-8?B?NHl4SlVHN3Z5bUFCTnJEb0h6VmhRejhwSzZTQ1N3WWhjMEZ0RzVwcnI4RW5n?=
 =?utf-8?B?cmErWmdyZEM1aUJUU1pxMDVrN3dsZWc0SEJRL1ZMVTF5Q3UwT0pndi8waHdR?=
 =?utf-8?B?ZkY3N09tZUhUWXF4YVhOaHRBbEx1VjZVVjFGcCtxajRuSVdQc255b1FiMGV5?=
 =?utf-8?B?bWpFZHRodHJrWG1KaXNzOGxqOGt4aVhSdlQ4a3ZDVURIZTE5NFhkYVZoTEJX?=
 =?utf-8?B?a3pYdDRPWHBndm5ORU1OaUhBOENmNzI2WHIveUtWdzhGSURSNFk2U0dxUnA2?=
 =?utf-8?B?MEZ6Z2tiSTRsT2lIMksrWUlITVpCeGRYMVJSNXZpYkJhVkxOQWV3dTB5NEFZ?=
 =?utf-8?Q?XJHxRO9Q/EjMYcZR/CRBnRHJu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcc27c0-876b-4a05-ac0e-08db8867e324
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3098.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:53:18.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdybJzy9/RnukdRkABwj1ctt/lrrzMSzXY5YGu472/SbYzeHwtEcAzo+DKJsgwR1hTfXryJKYZxrkmQWo9QUpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10054
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 19:28, 杜敏杰 wrote:
> Hi Mike!
> 
> Thank you for your reply!
> Do I need to submit a new patch to kfree_sensitive for 'password_in' and 'usernames'?
> 

Just submit a V2 version of your original patch, making the changes that 
Mike suggested. You can continue to include my Reviewed-by tag.

> 
> regards,
> Minjie
> 
> -----邮件原件-----
> 发件人: Mike Christie <michael.christie@oracle.com>
> 发送时间: 2023年7月18日 2:26
> 收件人: 杜敏杰 <duminjie@vivo.com>; Lee Duncan <lduncan@suse.com>; Chris Leech <cleech@redhat.com>; James E.J. Bottomley <jejb@linux.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>; open list:ISCSI <open-iscsi@googlegroups.com>; open list:ISCSI <linux-scsi@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> 抄送: opensource.kernel <opensource.kernel@vivo.com>
> 主题: Re: [PATCH v1] scsi: iscsi: use kfree_sensitive() in iscsi_session_free()
> 
> On 7/17/23 4:26 AM, Minjie Du wrote:
>> session might contain private part of the password, so better use
>> kfree_sensitive() to free it.
>> In iscsi_session_free() use kfree_sensitive() to free session->password.
>>
>> Signed-off-by: Minjie Du <duminjie@vivo.com>
>> ---
>>   drivers/scsi/libiscsi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c index
>> 0fda8905e..2f273229c 100644
>> --- a/drivers/scsi/libiscsi.c
>> +++ b/drivers/scsi/libiscsi.c
>> @@ -3132,7 +3132,7 @@ void iscsi_session_free(struct iscsi_cls_session *cls_session)
>>   	struct module *owner = cls_session->transport->owner;
>>   
>>   	iscsi_pool_free(&session->cmdpool);
>> -	kfree(session->password);
>> +	kfree_sensitive(session->password);
>>   	kfree(session->password_in);
> 
> You then also want kfree_sensitive for password_in.
> 
> I would also use it for the usernames then too.
> 
>>   	kfree(session->username);
>>   	kfree(session->username_in);
> 

