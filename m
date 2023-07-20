Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4466D75B8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGTUZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGTUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:25:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99A9E;
        Thu, 20 Jul 2023 13:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz0mpkIx6prmKS3N3UodAqIVLAccX8CkKKKIWJtlOGIYwviJ+vSJecf51Bmv2olhG+zB4+3JYjB1OyVuyf5L35r5vJzBXIy5a4ZokbgUFKTq6fEP8jHV0BfSY9Khl8kgB/SKrOtabHcnofkLnAGqlYv2Y9qo6HHwJ+yxmJGcxNA9q5KXUJolUC/KdJ+aa+/NEfTEuSppx0o4TrLxO+X/sSKvJA03NnJJoSQMMJ176FdkngkLz4df7/HYSoShHEv/+ETXaFH/96pgFEDXLXTTXbb33F56/ZLE+qeMS1bbnuEBK7iXeMgaxQvntuR/sxFoaku/lYBY52Xv754tAB7Tqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrdwRZJUfE0HWokGGKPdr2MJsuOAu4HAe7KdZbk93fk=;
 b=FOCIEyuXsIF9O2iR9dEfhHCLDPASr8n83L8SB+emxNfQm+JnOaLxr9fhmvjz5qNnNoNYmsrUuM95rDx+vDc4RsPiWMHDon5/rOnoWbWoqCpIRf09iWV+syAwRyDYLwmoTwn6VtmDiul8RoeDsCMNlrZJ27q3qnSJ5k2VIqS8PsGMDGsYm4rtiuWhqFN4H3XZiVO5CH2skR14PTf+YHakyl0kgdH35rD0uz6HUvHB0jlXkx6O8RQHtTzKP/3zU5zPCveoYvR5GhS2taeIbsCuyQWTUhGYwfwC2D5V8oalLtMP+bsfNQPtSzVDQklsz0lBDSRWGaKEkdU8J1vVKovWjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrdwRZJUfE0HWokGGKPdr2MJsuOAu4HAe7KdZbk93fk=;
 b=0Pr8fgcCncflxzdiT//hSyh0edqNXa2z2b9TDqbkowsorGLzpIJTvTS0XhWu6k/D8UqYfdhC/wVrY2lbqUYQ+GkY9a1rqeUcPA21QyjypgzYIC/W/SA4NVRSY3WbI/nTM5Fc/tTbPM7lmj6dgf1ZUk9Zuu0OZWX/T/ENpzOF+eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 20:25:08 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 20:25:07 +0000
Message-ID: <b1b577f2-717a-7361-28d8-320498667bec@amd.com>
Date:   Thu, 20 Jul 2023 13:25:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v4 1/2] virtio-net: convert rx mode setting to
 use workqueue
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        maxime.coquelin@redhat.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-2-jasowang@redhat.com>
From:   Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <20230720083839.481487-2-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ0PR12MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f4dbf8-d0fb-4b3a-cc64-08db895f68a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1OZYj5eNH72nFm7oGh1GGntyVKbtDWxJWKdoESSUWYkwwt4RRCIsUQtnJ/fPfKXgvM53xSkoitmJWtG0y8bIBEUNi3ueWPjUkE3L6XnlclR720QGnrSu+QgWZMN/SSWbLUgnrsjC5AoVP6s1ta8Elmm77mNuMPJ0y4T+9h3XhV86TAivsqaXefk6ilA7wof7XOT5UHWERS9wwzo8d8R+5n6Co651SPCxaSUOBprXsU7FKDewmuemSW7GEQbQG79R1Y/SeZsWZOzxblRQ00sfVP76ASeMQ8WCOgKfkCAtz7ehjNNye6IsI9O73rPUnUfsFtQMIfGp7m8ApJN48I204Hve4fgByTL0OGN1o/O8m9PO9qfwlK6/5Akk25ymb5hf6uCFBUYZkbU5XVtX8xKL9OpxGdaADLOayVmpMKY1+Y7mZz4K0KIiIw6MlJBv+pyV3yb8z/28dINlVoJvmuNz3Ih5v8QGltBVUezsz967oxQjpuCyxlmhc6jltcyHGuHqhg27JLlBtNyBH8mQAiBQLnIQf/4d/d9A9zjeFfffBrJFQLNcYgmvWUWEFQkdkZqJew7A/yz7Sj+9M2RC7woWZuEYwOszG4QYX6u1lP+zPnrIamWz4unGnvxZQTetwuP6D2VyUDyfr2OdBOKeKhwig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(6512007)(6666004)(41300700001)(6486002)(6506007)(966005)(44832011)(53546011)(31686004)(26005)(186003)(316002)(5660300002)(66946007)(66556008)(66476007)(4326008)(31696002)(478600001)(86362001)(7416002)(8676002)(8936002)(36756003)(2906002)(2616005)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldQNDRVanpac3dFR3NIcTVKZGJtL29BSFZubHdwOGVSVWxXVzM3QnMvWnND?=
 =?utf-8?B?T0R1amwwRlVqeUQzMEFqVzUzdmR3bmlTd2FOSHJHVXlRYitIUUc1U08yMkJa?=
 =?utf-8?B?djlpYnAvbVVQOGNxc055V3d5T0hwb3o3TmsxQkNCaGN5UWJhRk9FdWRkbHI4?=
 =?utf-8?B?M2hVZ01TSEtIQ3dwU0M0Wmd6ZzVnTDBicTRCc090bHVFVk81Zyt4aWtXaVdr?=
 =?utf-8?B?WHlhZEt0aW1RVlZ3VUdFTjlCRFNtWUo5OUV4YmxJbytxZCtDWFVvUHlJVVU1?=
 =?utf-8?B?U29SWW43WUFTRGJEdkVHcEJ5ejBSOVg4KzZ4YVovUlpEbUVLWXJJYjNBeVRH?=
 =?utf-8?B?WnlzdG1DZUdtU2ZIMGsxN3ZCdGFKNWJseW9WTmpKcDV6UUZSa1RxWjJhV3Az?=
 =?utf-8?B?ZzlmRE9aVHZrbEIxNWJTZEExYjU2dTdhVTk5VktNbHVMZXVJbjB0OHF6NW85?=
 =?utf-8?B?RVlaZ3c4SWVkTnMvNDZnT0lETnpkdVhkS290dlZaUTJFU2o2d292U2FvQ0Ex?=
 =?utf-8?B?Kzl5aDJEM1dMNzdpbmdSNG1xUGFuNjVkM2YwWk9NcFdwQ1lFeFc2SXpQTFlT?=
 =?utf-8?B?TkxTWHM4RWZXV0pTSGJGS0ltQXovb3ltRStLdXRPTzNhOXVlVzhoZlo4bzJH?=
 =?utf-8?B?aTZIY2EreVRMdVVCQUNLYnVEbUovdFI4dDRzTzYwQkpOQmJNYnJjWG9OeGhu?=
 =?utf-8?B?RThadHl0M2h4V1ptbVZvZEVxUUxndkJ3TE1aWlA1ampnckV1QjlLendVZ3BM?=
 =?utf-8?B?OWhGd2VPcHh6R29zSGVpNlZSTFVBNkI5bW9BbFp0UUVCNTBRVm0rTjBraUtU?=
 =?utf-8?B?RnEzVFdqNXkyOFJwMlo1WnJlZitCUmhtZnBqWkFvMFlMU2doUExPbXB0b2hR?=
 =?utf-8?B?NDFvckZ0MWNXNlpkZDZCa2p4dnhCTlV4ZlVnVlZ4aDBMS2l6RUpzK1ljRzZw?=
 =?utf-8?B?WEg2SWQwQWRJUFZIUjNqYUxEQlArRWh5ZlA2Y2xBM0FMeXdrY0F3MDJpc1pY?=
 =?utf-8?B?Uk9YZkJCa2pGQjd1ZXVnbENRaGhWZFExejZiaGVJNWRZMEdDb3FaQ0RCc0Jy?=
 =?utf-8?B?RkpCOVE2QkFJM1lFaXJHMWFQenBXU1ZXQzFiQm1EbkdQVUExM0VnWklTdTJi?=
 =?utf-8?B?RExZRXNUb2I3VjFJeCtZS3JhTEo0d2N2YWwzQjVYT1ZOdm9KdXk0cGo3dTBQ?=
 =?utf-8?B?SnAzRWY1S01mVDBVNE53cWc3d1BvWFF2aFBEalNwbC9hMTZPZkx2OG1jNTZ2?=
 =?utf-8?B?bGIyYy9oK2RCNXJRcUtHUHlFN1hHZXIvRjUwby9BYk01R0NUc2pKbTFCcGIy?=
 =?utf-8?B?T1RFVVN6VzM4ZFFtaWwyS2hMRDBQRllQOU1tcGhoOGlTR0hXV280NDYyY3VE?=
 =?utf-8?B?RjUzdzE2M0E0SVE1QW4wakJKODNnQ0pMSE1uNHNaUzNWS1ZPTzI1VGdVelhi?=
 =?utf-8?B?RkMyYlBPZm1QQkk5RFhieXU1L0JwL0tseGQzSG1kUW1KeUdLNForcXd5OHFG?=
 =?utf-8?B?eUw1NFRmcVR3VFpLTDYwYktlU1BlaVBjN0lDWFB0c3ZqcTNHKzZPQnJkUm1Z?=
 =?utf-8?B?NWgxWWRvdGlFNXlBREhnODJjWlByUkxUY1NQNk1kWmhnWWFrN1g1MGQ0R1VX?=
 =?utf-8?B?ZG1rbHBkQkdSdHdWL0RIOTcramVGazBFREpza2tCMjlTV29PT3lJTVVBSFdL?=
 =?utf-8?B?QmQ1eDBaZ2FRalE4SllHT1Zza0cwajRSL2JXaUdGakhUYlVLRHFpMHd6Ynph?=
 =?utf-8?B?Sk5NTkxjZWhKSU1lZUx1T2MzbzN1RVRWQmszalNUeFB4N1lwc3RIRnN3eXh5?=
 =?utf-8?B?UGY2RExyNlBvK1gwTjl2MWRLYm43WC9peFF6dmh4cXpqUms3ZlBTUHhQdEtG?=
 =?utf-8?B?RnJ1WEEwYXB4Wm9ZTEd1ZTU1bTUzK3NPV1RTb1FkY1BYVDZaUU5SeWEwSklv?=
 =?utf-8?B?MHB3dGJsY1hlcThmbmo2MStDOXVXcUVOcFFSbUpWRXpnWDZQZEI1TEZTMDR3?=
 =?utf-8?B?T1hkUUxqKzFsL1lYaVV0TGg2Q3k0ejZralhMZC9xNDhwYnR5UDZsejNBdkJP?=
 =?utf-8?B?OXRzZ3RLc3RYbVhWL0RBM090bzYxM0piY0JqRUlvRktUSkVjbisyNVhsOHoy?=
 =?utf-8?Q?hXYrbJHSurfQp/4XwTeyQStT/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f4dbf8-d0fb-4b3a-cc64-08db895f68a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:25:07.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DgcNpbEx8fGtILTO+xFC68QrqMfc5IsVrM7gJ1hlm1wv5UsUFonHj76OtwkaTl8eMN57Selg/j6/MgRhSGdJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 1:38 AM, Jason Wang wrote:
> 
> This patch convert rx mode setting to be done in a workqueue, this is
> a must for allow to sleep when waiting for the cvq command to
> response since current code is executed under addr spin lock.
> 
> Note that we need to disable and flush the workqueue during freeze,
> this means the rx mode setting is lost after resuming. This is not the
> bug of this patch as we never try to restore rx mode setting during
> resume.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
>   drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d67b36fdba0d..9f3b1d6ac33d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -274,6 +274,12 @@ struct virtnet_info {
>          /* Work struct for config space updates */
>          struct work_struct config_work;
> 
> +       /* Work struct for setting rx mode */
> +       struct work_struct rx_mode_work;
> +
> +       /* OK to queue work setting RX mode? */
> +       bool rx_mode_work_enabled;
> +
>          /* Does the affinity hint is set for virtqueues? */
>          bool affinity_hint_set;
> 
> @@ -397,6 +403,20 @@ static void disable_delayed_refill(struct virtnet_info *vi)
>          spin_unlock_bh(&vi->refill_lock);
>   }
> 
> +static void enable_rx_mode_work(struct virtnet_info *vi)
> +{
> +       rtnl_lock();
> +       vi->rx_mode_work_enabled = true;
> +       rtnl_unlock();
> +}
> +
> +static void disable_rx_mode_work(struct virtnet_info *vi)
> +{
> +       rtnl_lock();
> +       vi->rx_mode_work_enabled = false;
> +       rtnl_unlock();
> +}
> +
>   static void virtqueue_napi_schedule(struct napi_struct *napi,
>                                      struct virtqueue *vq)
>   {
> @@ -2448,9 +2468,11 @@ static int virtnet_close(struct net_device *dev)
>          return 0;
>   }
> 
> -static void virtnet_set_rx_mode(struct net_device *dev)
> +static void virtnet_rx_mode_work(struct work_struct *work)
>   {
> -       struct virtnet_info *vi = netdev_priv(dev);
> +       struct virtnet_info *vi =
> +               container_of(work, struct virtnet_info, rx_mode_work);
> +       struct net_device *dev = vi->dev;
>          struct scatterlist sg[2];
>          struct virtio_net_ctrl_mac *mac_data;
>          struct netdev_hw_addr *ha;
> @@ -2463,6 +2485,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>          if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>                  return;
> 
> +       rtnl_lock();
> +
>          vi->ctrl->promisc = ((dev->flags & IFF_PROMISC) != 0);
>          vi->ctrl->allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
> 
> @@ -2480,14 +2504,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>                  dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
>                           vi->ctrl->allmulti ? "en" : "dis");
> 
> +       netif_addr_lock_bh(dev);
> +
>          uc_count = netdev_uc_count(dev);
>          mc_count = netdev_mc_count(dev);
>          /* MAC filter - use one buffer for both lists */
>          buf = kzalloc(((uc_count + mc_count) * ETH_ALEN) +
>                        (2 * sizeof(mac_data->entries)), GFP_ATOMIC);
>          mac_data = buf;
> -       if (!buf)
> +       if (!buf) {
> +               netif_addr_unlock_bh(dev);
> +               rtnl_unlock();
>                  return;
> +       }
> 
>          sg_init_table(sg, 2);
> 
> @@ -2508,6 +2537,8 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>          netdev_for_each_mc_addr(ha, dev)
>                  memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
> 
> +       netif_addr_unlock_bh(dev);
> +
>          sg_set_buf(&sg[1], mac_data,
>                     sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
> 
> @@ -2515,9 +2546,19 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>                                    VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
>                  dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
> 
> +       rtnl_unlock();
> +
>          kfree(buf);
>   }
> 
> +static void virtnet_set_rx_mode(struct net_device *dev)
> +{
> +       struct virtnet_info *vi = netdev_priv(dev);
> +
> +       if (vi->rx_mode_work_enabled)
> +               schedule_work(&vi->rx_mode_work);
> +}
> +
>   static int virtnet_vlan_rx_add_vid(struct net_device *dev,
>                                     __be16 proto, u16 vid)
>   {
> @@ -3286,6 +3327,8 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
> 
>          /* Make sure no work handler is accessing the device */
>          flush_work(&vi->config_work);
> +       disable_rx_mode_work(vi);
> +       flush_work(&vi->rx_mode_work);
> 
>          netif_tx_lock_bh(vi->dev);
>          netif_device_detach(vi->dev);
> @@ -3308,6 +3351,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>          virtio_device_ready(vdev);
> 
>          enable_delayed_refill(vi);
> +       enable_rx_mode_work(vi);
> 
>          if (netif_running(vi->dev)) {
>                  err = virtnet_open(vi->dev);
> @@ -4121,6 +4165,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>          vdev->priv = vi;
> 
>          INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> +       INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
>          spin_lock_init(&vi->refill_lock);
> 
>          if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
> @@ -4229,6 +4274,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>          if (vi->has_rss || vi->has_rss_hash_report)
>                  virtnet_init_default_rss(vi);
> 
> +       enable_rx_mode_work(vi);
> +
>          /* serialize netdev register + virtio_device_ready() with ndo_open() */
>          rtnl_lock();
> 
> @@ -4326,6 +4373,8 @@ static void virtnet_remove(struct virtio_device *vdev)
> 
>          /* Make sure no work handler is accessing the device. */
>          flush_work(&vi->config_work);
> +       disable_rx_mode_work(vi);
> +       flush_work(&vi->rx_mode_work);
> 
>          unregister_netdev(vi->dev);
> 
> --
> 2.39.3
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
