Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF144757885
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjGRJym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjGRJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:54:08 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B6810E0;
        Tue, 18 Jul 2023 02:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JshX6IzKK8It2qus1OZ9pu6NvoLXgF88mvgsp1/YZj/xbOxCKImamZ+ElKT8gSCIZZtmJWk4WrdW6uIkmzh1lTfJP2UTeH1aKFsX1TAMBwAkkz+e2WhXqojTj3O3sUQUNzKAD7elH+rdJKuusK8BYQupBVC6wNNMsERpvNlFzy8002UUS1XiyMM0HyBEYZEqAGaYX7AdFhqxcM/myM1NKyzIFxw7HwZJT3J51XVAHZs0dxu14x7i4tsoMjASJUPZ1GjuFUOeMCnyUYDcutyJW/KDwBbjq8AvRCYPmnY0x1H9poN385zeziwqTxnHmfsCRhBsI15htY1AFymm1rJQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0D3KvU1Vgdt9kbEaP42kKnqlCcBPvhehoE6DJD5NIM=;
 b=k1BEMbahf61BWQAZrXv5a0tEl/mRxHeZ1mAPPJ8k6fJi/gGvdez0BDxaFQq77QuyWYsHcWvaS48/+l5U9I3PRWuy6SK/xfBCRxHLzx/GsqRMmDZTcabDAPxjG3xzWOfKRUAmWLnHLpNoPAXX3oyI/a1dHop10wr6nIJFCtUBVPN94pu5rpJw4ldgDLgEkKsEsfZ/BQoeZQQf7hMKkTgIrvUPQDL19hRNHdLArkUMHDdUN1E7Eq40ZUWAuCjLFGdXVRbeU8zBX0OitdkPkDJB9LoA4eAEVrOYkQzORRMieDcp3LZ26x5OFhRWMSX/J3D//GKq/fyjRUauAOGeEueZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=quicinc.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0D3KvU1Vgdt9kbEaP42kKnqlCcBPvhehoE6DJD5NIM=;
 b=OO/R9XQ20PxbqqO+7cN6Pk4jHUPbyoASA4QqTTu+/ithiprriBxKn9WxLwNlfz7rVzJSmsV5xCMTHNnJdqmhTI4Gi0KrcAyVFv6b5dDOl4AGAGbWcJpTc+QiduCETxJZJS1EqBYJkK/9IA34/Gadz4UBIx6ZoxLu1GY4G0PkX/QQKmqTJ/F2EZjXbn41j2No1/7XfXgaeJ/TYZM8LCu8qfgPbgal8qoKM2MuXp9b8hwyhDaZfsQ49Ob3Qn8dESBhu95drYikyrSoz916aCt2/En7Xl0k/zkQ8Ngf5HU2ynHjOyUwPovRzqnT7u1JkpTTmsfhIfZC9xRNMWdPosTWHg==
Received: from BN9PR03CA0330.namprd03.prod.outlook.com (2603:10b6:408:112::35)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 09:52:55 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::78) by BN9PR03CA0330.outlook.office365.com
 (2603:10b6:408:112::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 09:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 09:52:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Jul 2023
 02:52:46 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 18 Jul
 2023 02:52:45 -0700
Date:   Tue, 18 Jul 2023 12:52:42 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Ilia Lin <quic_ilial@quicinc.com>
CC:     <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ilia Lin <ilia.lin@kernel.org>
Subject: Re: [PATCH] xfrm: Allow ESP over UDP in packet offload mode
Message-ID: <20230718095242.GC8808@unreal>
References: <20230718092405.4124345-1-quic_ilial@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230718092405.4124345-1-quic_ilial@quicinc.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ba5525-55f1-41e3-16a8-08db8774c27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4UkP1VBp1wFmaEyx+axnDxOdEX6SigJWJlaPpoBghTG9GWgH3mv86GNSQ5YYdiiE2gwDPpcgP+D4MT+aYHqrY7ldrul6jq3cKonAEi6RAfOM0ctgSwUNFOHxp5uoSeS6ooCql+uVyL4KTjtiEF3b0IS+DkwBOdagjZJq4R4JKqDbuBbXOh9DdeKKylUnimhY/87/6RL2pn+1FWn9d6e8IiUMcsjyxp8u987/xY8ZVQk5G0bWLXJMPY515gYAXb1nB9M7A4gva8Ypn/U9qVASICqQj+izrH5oUFr40eXmI0FqEBZAUvJ1G0/n2QqSEBbHgFeZeMJwbGpWeYk+wNRpbz7ZitBDJ4ioaKPbjIt15vjcNCb7O8KTcHnkRXFXxBmRktzgWeoZ10RFloV3lzKfgUFvznM+kqZUNgr6PPYayKk4xPCzdbFDd6JaThsImvynXmpsfuR5+4U4XloQdrHjHxOLvvLkO+RK3sJrf3ffrPBfcOEMGirLfu6u3FR2v5iogWFfE9KlIWCTDvB5k/FubIYN25N2iVZ/BffjX8+GerZVMw9YczL+XBaAEwXhZ6t/LHyag2BjaH9zQMgTYfL0/GTbE8GIk1qzkWWgPcu/QfZLHf+UycYYEY7K2GmEYlPZDi3+/xul/D5/PaeX+8GNWmYANRcF/pwDUPe9DN+jMU3WV94esRt5uQ/cjiqlcMQ4At2uqura8eJ+XUbaeOz0t21vln2D/Z8yT8rNivbw3QqW9H7eU5y+nDrfQbJqzGebj74vUU9Eqp3/7qPUIi55Jzrc3xpgVmEAqJFTkLx6KrQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(346002)(136003)(39860400002)(376002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(33716001)(2906002)(478600001)(54906003)(6666004)(8676002)(8936002)(7416002)(41300700001)(70206006)(316002)(4326008)(70586007)(6916009)(82740400003)(83380400001)(426003)(336012)(47076005)(86362001)(7636003)(356005)(9686003)(966005)(40460700003)(5660300002)(36860700001)(1076003)(16526019)(26005)(186003)(33656002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:52:54.9984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ba5525-55f1-41e3-16a8-08db8774c27b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 12:24:05PM +0300, Ilia Lin wrote:
> The ESP encapsulation is not supported only in crypto mode.
> In packet offload mode, the RX is bypassing the XFRM,
> so we can enable the encapsulation.

It is not accurate. RX is bypassed after XFRM validated packet to ensure
that it was really handled by HW.

However, this patch should come with relevant driver code which should
support ESP over UDP. You can see it here:

https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=xfrm-next
 xfrm: Support UDP encapsulation in packet offload mode
 net/mlx5e: Support IPsec NAT-T functionality
 net/mlx5e: Check for IPsec NAT-T support
 net/mlx5: Add relevant capabilities bits to support NAT-T

Thanks

> 
> Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
> ---
>  net/xfrm/xfrm_device.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 4aff76c6f12e0..3018468d97662 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -246,8 +246,10 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
>  		return -EINVAL;
>  	}
>  
> -	/* We don't yet support UDP encapsulation and TFC padding. */
> -	if (x->encap || x->tfcpad) {
> +	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
> +
> +	/* We don't yet support UDP encapsulation except full mode and TFC padding. */
> +	if ((!is_packet_offload && x->encap) || x->tfcpad) {
>  		NL_SET_ERR_MSG(extack, "Encapsulation and TFC padding can't be offloaded");
>  		return -EINVAL;
>  	}
> @@ -258,7 +260,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
>  		return -EINVAL;
>  	}
>  
> -	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
>  	dev = dev_get_by_index(net, xuo->ifindex);
>  	if (!dev) {
>  		if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
> -- 
> 
> 
