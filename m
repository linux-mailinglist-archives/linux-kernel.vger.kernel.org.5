Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E117E03DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376439AbjKCNnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCNnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:43:15 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2064.outbound.protection.outlook.com [40.92.58.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AF31A8;
        Fri,  3 Nov 2023 06:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtkGPikIBz9e4jaBpEjx5FxhTRE64cbtont9BM9AVkXSICpOWhOKj0kLKcPJSZ/x70yxORDFEJh6o2hEYj/o9QyRaZ5T2K38EcKK/0V+q7/a0doU7MRvIA+O+X2amJiahyuKdCbO3YVuiWEqMg5YNoKyA2kTfjh5sYw3C96sNRWFmU8HQTH1JSpZ34VvDT4RvFSlxYa4njS+4YBOgLXL5Pt//0gfiAx3HjNO7N9o7VG+3NNlVIl2xkvQWsqBnoPCiIrB2Aw8hhKan/maVBBC3kQuVQFTZVgPWu5FanyF1+V1xrB4yxL9AxprvAb92zMaBfrgcPgYDrBS/ofDXQy5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPsVOIHID35hRcUojOO6766waM0yw6oxof43PYpSfcI=;
 b=AV72krs1kaBvPogI1LM8WFTWBt6sN6X2/UVjMJz6wHxwxlwQaPpViWL2SPyiHWjmXwP2lPqbqiKpMQWWoWwXJKICfkBi7RLJmgLmhK7y8aNipxM1cyQq2HOGE38bEesUBwnHCEWIbduErpweYUP6lLpVDhPZL2nT/asP01E89HjPjp5+cJ4GlfRcyIkX1exH40ILEQQnpd/qEaxplrFa7Avq/SK+wTNbt8SroJz9Maq7MNGXo3qZRNifHMr5jws8ZRVWpa2A5M0MGMhOU+AkEYwwn4nfmMSkjDEfFPBQ1aDpBXXDck7Mtj0nAPdoM+KqLO6Mqa6rsQYhzA4d6DktnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPsVOIHID35hRcUojOO6766waM0yw6oxof43PYpSfcI=;
 b=Idr7FRmYj2UJofZDW0ZtSUPSHdafUToi7Saz2q9BcFS+3Vt+2nifb1MrMbvY+WctDFAFQ9xvlLoS+jXEpgS8Y4hJ8m8AvuT8w5mq9Eg/uWaxzIr/Ncidvi4POIrTmufkaj4tOfNLLZUsqDRx1+e8YKtHftpaSFYZ6XMzcp60spL//H2Rt2yp6iDu1G1OGsCwrmdqJEO0uLz0pRFpSPdSA6syzmh38ooxnTZW2LajFI7DKxtKCOqLCCPlIM6ngIEMA4IHkKudL1sW/wdG+cJHTLtOf4l+xyaqhxGna1T6NT41kUMawVkLAzlwA8rVHHS3vgfpMIFFYepv3S3XdYBY5Q==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AM7PR10MB3876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:175::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:43:11 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 13:43:10 +0000
Date:   Fri, 3 Nov 2023 19:12:57 +0530
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        florian.fainelli@broadcom.com, linux-kernel@vger.kernel.org,
        justin.chen@broadcom.com, edumazet@google.com,
        bcm-kernel-feedback-list@broadcom.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Prevent out-of-bounds read/write in bcmasp_netfilt_rd
 and bcmasp_netfilt_wr
Message-ID: <DB3PR10MB68352DF6CB458CCF97C416ECE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
References: <DB3PR10MB6835E073F668AD24F57AE64AE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <2023110301-purist-reputable-fab7@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023110301-purist-reputable-fab7@gregkh>
X-TMN:  [eSc+gEx1CmvjjVMBKhf6Xwx/G31TUnDs]
X-ClientProxiedBy: JN3P275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::13)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231103134257.GA1618360@nmj-network>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AM7PR10MB3876:EE_
X-MS-Office365-Filtering-Correlation-Id: 071a78ca-998e-4736-94bf-08dbdc72d1ae
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taaZlKXULBVnl0N5LRqaRG7/SnQHM+I0lW78LodA84iQJmD+v6t98+jqaViAM93QOVx7PnTdgbs3up2okkOM9aCj6jC6hm7DulIW2lCWLERpfMSJKLmTk8QJrRSuIfr8Kaqc4htMy+veAO786X22oYxhl4nsz0JCRjGz+bTYNyTbM8q+P6l2jahz1e21HhB/wNqV0UO2Elnnkv0jO8J8bSlK04QZ75yMwV7rroQyRfGAO1b/BVZMcwIrnwUnddAQhr/8xv8K+vjnOGWuE1Fwl9KWSyAmuKzsveS3NqlFRhZQV7MoV7es92kbkXZHcnSDGshLXT6hQwdgg8rUAd9PBqOsdXJMEx9D04VprjDX7B1cnTnHl0zahY58G646eX29BGHwu01gtSSjBD3NUt3gQ/hz5m5gI/oNI403a8M7X7XjZ+0KuI0uqRf1sAprWgrONqpbgOPR7MNTetMATwGRLpuQsAffqN46tqYw+MB/1Bvsbpt0voN2vfk7Iacul4NPbtlqg21RhVlB7hVubeADgHzzYWia/fXbWMpj6jgXAadtfpH7wdwQCpOhG8x3AfIP
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8YaI9JifLYhhVft+b+g6EIQXkRZoXdopaNN79tYWQ09oW4WD4KrO2oP3sm1B?=
 =?us-ascii?Q?BKDkAdKZXzIxNq493Nmj8pzMXDsPUMPGeWRcjOPwI13VmlTVytByTCFz7Oh+?=
 =?us-ascii?Q?+18iX59khvgM0B1tfNDx+6Q35HnNiJAG8QGnmV//zC2UIdl0Cra9CiAfL+d0?=
 =?us-ascii?Q?whmYuV+/xrUZC2on690xGF2cZef0tvfFuqdA6/SE5t42mfuKKYoEiSkXzYpF?=
 =?us-ascii?Q?qla3io2h192XwysCtDMcIi0FPZ1ja2L328tCKDX04vp2r4XzCHD2r/XYZk6q?=
 =?us-ascii?Q?O/SjFQDjWFb1n+AKjDqM6Lsxjc+MiK6l72i3ACXiaF+QerGgaHI8vK6MbHoz?=
 =?us-ascii?Q?1C3uW4SAcr0BF0hoT/qeyGzRqgdow3RjG+SfwR8tsNwhFqh+3S3W7lIuAOVn?=
 =?us-ascii?Q?ss21XJ+sOGuWq86wNSe1M2jSqazwoIZsUz3Otvit7iU7ZWO5dBa0EcA7xLf0?=
 =?us-ascii?Q?sWZia4ay8WR33asz2e2RuzjyMypEliUSJiDd2UVy21ij37CoSYl5qCI5J71p?=
 =?us-ascii?Q?Nw0VgTTBnjKOhM96VydB15W+3LHHFwnDjx7wiDhqCXEPgs0knWaDjrPQnnS0?=
 =?us-ascii?Q?OnG8MqGt8vWp3gLlS9WeSoc38pg7QlLGgwLrJuQfzXyDbbUBTJ70NW5twL70?=
 =?us-ascii?Q?AQwKF/EpNL+hEFGsxH7l5lW//Hywooc1jHZnROmnBwTMGQi0jo4dZ7jpKCKN?=
 =?us-ascii?Q?Kt3H8L3bOvqxP+JkVgBZKD/UCaKLnb2lyKDQZURuUwD7nrRP1kXSxBhbJYpD?=
 =?us-ascii?Q?MZBX9iYd04TdRlYjeBk60DNr7s8nYGoPPyvnuVCs9c/BzXpwv4BRays7+4EF?=
 =?us-ascii?Q?UNk3pVn2/DehplZVP/L7ErhV0SANyJxdtRwbXsCtthXtS8+LhqUGprDDdz/v?=
 =?us-ascii?Q?ufIY4SksodD2SrPN9UxwDV40qtbBVx0kiSrLYRrzoCf8Zb+TnA3PquyVAhzn?=
 =?us-ascii?Q?6QWHkwiKF3xBEO7BsSgtd04zqRIP80u0ZH/XVSmUpKQYlRt4tmmNkD2EpdEw?=
 =?us-ascii?Q?6ZfETBScY4mlzkEQy6HOk2eZx2pav8sJcQsU1vSQf09nkL0GkO0DPQBOURzy?=
 =?us-ascii?Q?fxGF7JDsg/xfFfd2fJSlzcAXCbd0tjg6fOgig7oUMCOpxqsy/nNDkRqsHBSR?=
 =?us-ascii?Q?+WyWDvoA4dXm6Sd4nBo+t3Gwy9G6mpykCfNuNiy2I8q98zUKjBk62/ucslVR?=
 =?us-ascii?Q?AyEALU0+u8kA2LNweYZnGwVc+p+0mOx1YRYsG+BCGQCaYhUjtpTPvBPVrLI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 071a78ca-998e-4736-94bf-08dbdc72d1ae
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:43:10.9058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,
On Fri, Nov 03, 2023 at 01:57:13PM +0100, Greg KH wrote:
> >  	reg_offset = bcmasp_netfilt_get_reg_offset(priv, nfilt, reg_type,
> >  						   offset);
> > +	if (reg_offset < 0)
> > +		return 0;
> 
> Shouldn't you return an error here?

Yes, I think that makes sense. I might just return `reg_offset`
since it is bound to be -EINVAL when bcmasp_netfilt_get_reg_offset
fails.

But that now makes me wonder whether the previous check in that
function which currently returns 0, shouldn't be returning `-EINVAL`
instead.

```
static u32 bcmasp_netfilt_rd(struct bcmasp_priv *priv,
...
{
	if (!IS_ALIGNED(offset, 4) || offset > MAX_WAKE_FILTER_SIZE)
		return 0;   <----- Should this one be -EINVAL?
}
```

Thank you for the feedback.

Yuran
