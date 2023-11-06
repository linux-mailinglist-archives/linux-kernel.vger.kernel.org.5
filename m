Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823FD7E1E1F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjKFKSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjKFKSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:18:52 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4F293;
        Mon,  6 Nov 2023 02:18:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7B897D+HZbzbUfadhTL8xHSpMsAFMVWxYmlTF6osnssYJuf8pJFjIxbvNv8BdWVYP2xaLJD6smFL9HG2joGZSYygIWYsogBhrgJFF/qtvr2G2aRia4ssYlIYAFDaBtVyAV/dDeldLcC/EuMbMDwUmyfSdovowtYcvSoK7fUlz9zbXBWtvydwO9OxV031ddz5kQKvl7EX63kuPPtv1Ix9qV4DlpRlONboVHt7BSokn3R8vHbJZV2qe33UtCFZya8iFuT/4d2daxSN1sMpAKZHWpLFGeR4vA3MioIDhrjpEQ5WHn6G0ZXqdssn63lLLV7xanhbF9dym6J7wDPxMBRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VTIp1es4CBGQQ/HlVICl86Dws+rkxfTJXCFRbWeoqI=;
 b=ah5tRJmX48L3oa2BWihJD3h+uGwPH5ojJWAJJkWRU+utKBdaRuLJ9tkjY6v+cTj9jcu/rkqrRwjZ/L38PwTjnc+ewlESoG88UQJTrcmAducrs21llHHuFfAbEwRxvhPL+HfoyJX2Bzq6qTZ1YRjN7LnPH05KFvSAFqqZbSDOG/C9Shf+K814X/zZz+UJiDb7gySmn8mX6rldEkJ88fmk+jthlRQ4Tp3aF+qmrTp41se0FjAmNPLLGirEVPpyUzi1Bf6mG4DnOpwTQ0NjRD8fwxKNyrQcPadMzI9RuDAgdjv/t9a68NAku8rUd4smdt3GHoRb0Lnc9A2WREF2e+ZeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VTIp1es4CBGQQ/HlVICl86Dws+rkxfTJXCFRbWeoqI=;
 b=ZxKW73ObCidPurfeLtAVPHtoZaAVzYhUqjyEJ1F00mvlF0SVCf5J9R2f9e8hjvQt2FOXsztKGFjGlAQ9ibpd5m3qcdu/4y4AkODOKX7J9a5EFuRMNk3vQNwAGiuoeVk1RhaedwkiZkIDNfKENEIz+cf77aHkfoc85XMAIi9g8//qRVWIA2WtqzR6HxGV4rmZDN0vdF3BRAxwQAUZYAQZZBjfh0fPiYP5cjLFhwXSqbF7TfHiyuOnm/fo4r02WWDuv2Ycdus0qRr+7wHPo3Kt5fBwf50J6BlyblWUpSZVNtHSI47+e8tdsNRpk/SyD8CUvcA5O7TAL2HckYG3UU4/pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by PA4PR04MB9343.eurprd04.prod.outlook.com (2603:10a6:102:2a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Mon, 6 Nov
 2023 10:18:46 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%6]) with mapi id 15.20.6977.013; Mon, 6 Nov 2023
 10:18:46 +0000
Message-ID: <80af8b7a-c543-4386-bb0c-a356189581a0@suse.com>
Date:   Mon, 6 Nov 2023 11:18:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usbnet: Fix potential NULL pointer dereference
To:     Ren Mingshuai <renmingshuai@huawei.com>, kuba@kernel.org,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc:     caowangbao@huawei.com, davem@davemloft.net, khlebnikov@openvz.org,
        liaichun@huawei.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oneukum@suse.com, yanan@huawei.com
References: <20231101213832.77bd657b@kernel.org>
 <20231102090630.938759-1-renmingshuai@huawei.com>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20231102090630.938759-1-renmingshuai@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::13) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|PA4PR04MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba64dc4-08ea-4a9b-a684-08dbdeb1c17f
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSq6EJR1XFEkZWiqldnP0lSehoADi/sgkSLVNsbiLZVZNxZ0VE80tFAJcYYgFIVU/jclNiMP5m1jOaIkn6AAabovCkO54fpAgBxFB/lcT/31ZnVfSesgclQwVo5aJL5jwlYhq4OxuXjDYkmi/Lh9S8hSQ0Y022eJ6vv/pAeh2pfAkxvN8p1DQNjFxHpgW0iDK8vdnK1pVNY0jTyiaUfSs0dP9ykrw9jSMo1Q66EFDobmMTLGF5lxjlkjt4I/JdxDcp/8ixiS7MIefX0OdJ/J8KptvObCcivdWj8PRRfVrRZrMRX43b3+6w7kysDBOCJR9nTjKWjIH0s7LxwoYIQen5HrnqJ3/D+PiFq7rYmE015ufV6+bNVmwkIW+qCTEZgzcg/4jOk005xMU8xplgk98UP5pnnY4WaApqptgMwIfku8b6kYUASt86ppesuc2QYHxxgUdkNYdhM+AxA7FFYbm5hlTCKILhoxnBBciDpmaPdJuSBDQyael2faG7ZbqvruJZsBm3SQ9DeLQ5j7By17r46XTan6zBZuHgr+/7p0b7bAb0V/UvOmlY5z51FKh8NdzPCnhXR1pNhxP6dQnhTxIWWLOmnkyCy+6uMofE1FrnqSMEFIsBU+uEuFXxEdjkBHIiExKzuTw3PAf+4WiXXNog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2616005)(6512007)(478600001)(6486002)(8936002)(5660300002)(31696002)(36756003)(4326008)(8676002)(41300700001)(86362001)(7416002)(2906002)(66476007)(66556008)(66946007)(316002)(110136005)(53546011)(6666004)(6506007)(38100700002)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1h0ampCNTFoQ3hnbENnbkZVS3BkZ2VZRmRhUUhVUWIyWGd3YjdUNE4yWjFI?=
 =?utf-8?B?azNaV2JzSDFJbzRRVSsvQklGS3hBVjdhekhXQ203U3FRRVp0RFJ0ZkhRQTBO?=
 =?utf-8?B?MEV3d0dxZ2thZlVMcVNCTm52SnhlU2hHUXc0cmdVbGQ3S1p3S1ArYkYxeHNR?=
 =?utf-8?B?am9pcDg1UmFrRjVvbGduZWRUWnYvYnFlVGJZd1NYbnpoNDZDZXJPSmRDK0lq?=
 =?utf-8?B?SENPdDZHR3JuR1RHTVlEYnVsYU1YV0E5SmdJQ0Q2NkgrVUdpMEhWQ0ZrWkRj?=
 =?utf-8?B?Y3hESVphbmxUTUFtdDZ6aXpDOGZDQ2J0KzAwTGZleFVqL1UyRWxTNmFzMTJC?=
 =?utf-8?B?ZkR0SjdiclJuTWJsdGFPSkpzbU5ldjR3ZlBhRmRIendoZSsrWm1lTDduU2ox?=
 =?utf-8?B?Yk9UUEZ3ZVJZWFJrM0lYcWNRWGNMWXhkdUhoT0Jlc2FWVEF2VlNpVmIxbGRI?=
 =?utf-8?B?Z0FwQkdHVWJyK0dNdElpem9zNUVwclZPdWFrS1pLbkZLQ3pxemtDVlZ0WUcx?=
 =?utf-8?B?WWJPaXZ3WWdnMzZiMVQ3V3VEekZHMzBza01JallrT2Z0YlJjSE8vTWlvS21y?=
 =?utf-8?B?czdwb3UydEdkOEw3RWpsUHE3TjhNbEY2dll2N2RxOTgvUTVKYVE5dTFjVUF6?=
 =?utf-8?B?ZStzQ0J3SSt6SzllSFo5d3kwK3dTMHNpOXNQaHI2ZEFhK0ZhS3piaDRRQmRX?=
 =?utf-8?B?Mk1CZ3dCUjNGVFFXc2ZqaTlYdHc2WTFBazd0MUtLQVhxejJTZzMyc3JvL2VT?=
 =?utf-8?B?STRTMkpXaFdVYzZGLzJ6QXowWHZZaC9WWnNqVkdETnl1THY0SDJjNmdTY0Fo?=
 =?utf-8?B?OFdGYVdTVXlRbk00VFV0eXU4a2tkeVpURU0xWVByeVQvT09hc09iU29mV1dJ?=
 =?utf-8?B?alYwZEVFS3dDN2FtcG1BL05YckdJNHFveE5BNXB2THhJUStBNUV4MWR3dXJu?=
 =?utf-8?B?K0x4VFJjLzZZNm1JajhnT0JjV1BsNjZoYURVckllOElnVGtham5ESXd5OU1t?=
 =?utf-8?B?V3lwYWkyWnZ1VmpVQnFGei9rOGFWUVY2Z1IzWFdxbEc3YmVYVlUvWHFqZ2Jm?=
 =?utf-8?B?ZmxUSVFlSUlRRzVWYVJoSTVKZDVMSXJJZ2pVdW5RbFllOGNJblBPS3h5TDRH?=
 =?utf-8?B?SHNxQlAxTjRLbUcwR05RZW5wM0pvV0xqWEdZZTU4MXNZSUZJcjhPTFpHcy9K?=
 =?utf-8?B?V2tGcjRZWGhxeXc0cEM3RlNrS2tRWVdhS0pqNjZMb1NwSHFhQWRDdytRa2tM?=
 =?utf-8?B?OEFHYU5Gc3kxc2JheVJ3dGQ3YmdBSjVqbmUvTEltbWhsc21FZW5TRzhKQkRT?=
 =?utf-8?B?UEF5ZDd3VDZhd3RXZTBLQnBOM1U5YmM1RXpNZVJ3TDUvcUk4STFRODVWVi9s?=
 =?utf-8?B?aWdsSkQ5TmJWbjBpV251UklGV2paSy9vRzBaYlhoU3lQREw1bFM2eHFlUGNh?=
 =?utf-8?B?VldKR0lwWlRLRDhFUFJpRGxkS2FyWGNMV0xWNHBDa05xKzBOcU1MeUNQRC9H?=
 =?utf-8?B?eHAzaUUxZ3krd0xBWjhrY2QrcFVCZXQ5a2FoQnQ3QkUvT2JSRThZN3IxWmxy?=
 =?utf-8?B?Rmpjd2dwRTgyQW90cCs1OUV1OHl0VW03QnlVWVJsbEMvcHdpYnh6a3ZHZXdx?=
 =?utf-8?B?eWlxNFdaUGxHUm56di9ScDBQRWVJOWlKV1JIUmxBbHRNTW1WT1FwK0FzcDMx?=
 =?utf-8?B?OXlBbm5ZZXNRdlBHb0xFcHFYL1ZZQlFVNk5ZSXo4eUdxRHk2ZTNRbDNnMHQy?=
 =?utf-8?B?aDRka2JvTVh5U1g5cytkZlJWa1FJaFNwSDRNbElwcFg4Ni93ejNFUzMwSTJ5?=
 =?utf-8?B?WEpYK1YwK25RbzA0UHQ1OFNIQ2Qyazk2ZHNhWXRVNEMwaE5CUktHWkZuNEpa?=
 =?utf-8?B?TG5wK3pNVEFFNmhEbmI3TGVwaGNPdGs3bitIQnVsRHZNSEV0eGpYblY0S2lV?=
 =?utf-8?B?MnFkQk9CcGNSNzBkVjA4QUxoTjlwSWFkN1IwaElPM0tPU0s2Y0JDUS8rbGRJ?=
 =?utf-8?B?aGJQRjJPTG5CWGJvMG5qVkRJU1JMZlNkK0RhNWR0Vnd4NlNwZzN6NGtVRmNz?=
 =?utf-8?B?b2hJV3FNaWVoZW9VYzBiVzhWWURXRlFQSE03ZkgraU5zWGZuZDZzUUNWN3d1?=
 =?utf-8?B?YlZ0SVJiRG5hZTlRbDJUNmZlaTNjN05oUGlIMC81Z1BRU3JZc3ZoaDA1aW1G?=
 =?utf-8?Q?BaLGhyj6JS30/FFBDVLVhZKqV9tLj4nH1i2T+k87iyav?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba64dc4-08ea-4a9b-a684-08dbdeb1c17f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 10:18:45.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+JOEIZtavlPiUsYMqOEf75PtuY+78O5sDCAtxyQhmvpXErBAuNntNF5uR1DXl+wP4yvMBjs+W948m7r4jWVbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.11.23 10:06, Ren Mingshuai wrote:
>>>> 23ba07991dad said SKB can be NULL without describing the triggering
>>>> scenario. Always Check it before dereference to void potential NULL
>>>> pointer dereference.
>>> I've tried to find out the scenarios where SKB is NULL, but failed.
>>> It seems impossible for SKB to be NULL. If SKB can be NULL, please
>>> tell me the reason and I'd be very grateful.
>>
>> What do you mean? Grepping the function name shows call sites with NULL getting passed as skb.
> 
> Yes And I just learned that during the cdc_ncm_driver.probe, it is possible to pass a NULL SKB to usbnet_start_xmit().

Hi,

yes it looks like NCM does funky things, but what does that mean?

ndp_to_end_store()

         /* flush pending data before changing flag */
         netif_tx_lock_bh(dev->net);
         usbnet_start_xmit(NULL, dev->net);
         spin_lock_bh(&ctx->mtx);
         if (enable)

expects some odd semantics from it. The proposed patch simply
increases the drop counter, which is by itself questionable, as
we drop nothing.

But it definitely does no IO, so we flush nothing.
That is, we clearly have bug(s) but the patch only papers over
them.
And frankly, the basic question needs to be answered:
Are you allowed to call ndo_start_xmit() with a NULL skb?

My understanding until now was that you must not.

	Regards
		Oliver


