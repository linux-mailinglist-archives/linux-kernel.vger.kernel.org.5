Return-Path: <linux-kernel+bounces-157138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FE98B0D80
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2511F22D70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6F015EFD9;
	Wed, 24 Apr 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WJk2+Uh9"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69615ECCB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970461; cv=none; b=Eq96YQjmCizhooIMt+z98tH6tggZjcE2r+Q6/R0osJmmmsQ7GC44zhAJKgefZcsjte9UrA5zBfzWZK6JLSJP4GyZjui5HMQA10B4qixYOTVQxdWb4L2x9a89SmJTAbbnK3whu7/I4eswHUG7Iut2R0y+Xemey58hvRVLHzsIR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970461; c=relaxed/simple;
	bh=lL6HMoPGq9Z8cnulXZqadp1IF3BotmV6W7JozM/cgLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGhhcm9hrh1YSENGws8ERc2UOJTho6L1WxeQSwwh+4Ldy2duNifC4emvQKWShv1w9C7QI5on6anV3dZ1C7Z9SUENgB/QpIRCBTUrSn5sQND04GEFCkZx0byNrHB+3JaOeqzTiXt4XLFuREkLJ0k5Fp4kKd49J/+FTVTF+p6fP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WJk2+Uh9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572250b7704so1754555a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713970458; x=1714575258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8o5wk9BVe4zRZIS+SUZnTsxDgL6wret0YGcxGXqZpA=;
        b=WJk2+Uh9w0P1dcnclFjxa85fpBcCoWs0cVsSawTTyzynnEDhp+ynEWLxRvl6vv1bjo
         k0NIabGBsZ1xoRrpkMEEXz4xPBr3WeNAtYjvHu0wftKHaf0TSB8I6viiYTJ6reB543Ds
         QjltKfa0ASoODPnx1OwV4eMWfN/dx7y4MS5SE1mNmGheoTfrz0kuAglBZW5O9TH42hm7
         Zst/VOAuDUnmAMcd1xnRTpgwt3yCb3Q+oIVRhnwhzyu23J2yJj2ogslKZ7EnOyHkPXqz
         YsMYA6zDoRer4l26fq2dt1Kxi3UZqO8S9S81Z/a5Wm5ZNy5eS9nSwla6BCRAwx5aMBat
         S4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970458; x=1714575258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8o5wk9BVe4zRZIS+SUZnTsxDgL6wret0YGcxGXqZpA=;
        b=NSt3+icndhRs+biTgsWhzjIDQg2QYFM4U+oU64aR8qPylSCVRzrDWwy2K9heG4Bjf7
         ZHluArD6xFqUStFkzdpCvmE/Alt/xh08V1sWFhnLcmXE6PlG977WvI5Y3MMzWkqmyo4E
         MdNkahdeIsbe5RYHr9ykWrINFvbhicH0PXCVZHLSuylcGrUfeA6yknyFh21axPQLtkIQ
         2gbVDYYteTIuBByv4mVNske3YOztPt9NdFNQqnPbSUn+GAIuJI+vmoJ7MhGTRRuWVuh3
         NVUqKJ3TdsggT/Ck9PXiBBEWTBmTdDwh2fZVbisyViXBFRaNmlkc7hiTE0TcmwHUbQ9A
         Krgg==
X-Forwarded-Encrypted: i=1; AJvYcCU13Hh+l43Sw9IM2XlBeCg3kEbluot4HQLeadrAia3mQWvISRO9MpTAFaM1RPCyCsVVj20KkAGu7bigLLAQFK0f8ufxj6T1FxLcwI6A
X-Gm-Message-State: AOJu0Yw5YdxQNq5/lhxY+D326spxIwWdNvEzCVG0duQDwx/cEv6tqz7y
	eOJaupGLcLjNARKNZU5/wIP8I5xm9PSHRk4/vFhx6RW1skNZhUgWk2p3I9Aa+yQ=
X-Google-Smtp-Source: AGHT+IH9DPWrD5PoK9Rg6II3v+jSLz5i0i9V0Lqwz9MmeqPCadI969CTIW+TCgeCuAZIFlg3XC+MIA==
X-Received: by 2002:a50:8ac7:0:b0:56e:2a7a:27e4 with SMTP id k7-20020a508ac7000000b0056e2a7a27e4mr1819177edk.39.1713970457829;
        Wed, 24 Apr 2024 07:54:17 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id h2-20020a056402094200b0056e44b681a6sm7922436edz.57.2024.04.24.07.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:54:17 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:54:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	horms@kernel.org, i.maximets@ovn.org,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/8] net: psample: add multicast filtering on
 group_id
Message-ID: <ZikdFbmAbT5bWNxa@nanopsycho>
References: <20240424135109.3524355-1-amorenoz@redhat.com>
 <20240424135109.3524355-3-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424135109.3524355-3-amorenoz@redhat.com>

Wed, Apr 24, 2024 at 03:50:49PM CEST, amorenoz@redhat.com wrote:
>Packet samples can come from several places (e.g: different tc sample
>actions), typically using the sample group (PSAMPLE_ATTR_SAMPLE_GROUP)
>to differentiate them.
>
>Likewise, sample consumers that listen on the multicast group may only
>be interested on a single group. However, they are currently forced to
>receive all samples and discard the ones that are not relevant, causing
>unnecessary overhead.
>
>Allow users to filter on the desired group_id by adding a new command
>PSAMPLE_SET_FILTER that can be used to pass the desired group id.
>Store this filter on the per-socket private pointer and use it for
>filtering multicasted samples.
>
>Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>---
> include/uapi/linux/psample.h |   1 +
> net/psample/psample.c        | 110 +++++++++++++++++++++++++++++++++--
> 2 files changed, 105 insertions(+), 6 deletions(-)
>
>diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
>index e585db5bf2d2..9d62983af0a4 100644
>--- a/include/uapi/linux/psample.h
>+++ b/include/uapi/linux/psample.h
>@@ -28,6 +28,7 @@ enum psample_command {
> 	PSAMPLE_CMD_GET_GROUP,
> 	PSAMPLE_CMD_NEW_GROUP,
> 	PSAMPLE_CMD_DEL_GROUP,
>+	PSAMPLE_CMD_SET_FILTER,
> };
> 
> enum psample_tunnel_key_attr {
>diff --git a/net/psample/psample.c b/net/psample/psample.c
>index a5d9b8446f77..f5f77515b969 100644
>--- a/net/psample/psample.c
>+++ b/net/psample/psample.c
>@@ -98,13 +98,77 @@ static int psample_nl_cmd_get_group_dumpit(struct sk_buff *msg,
> 	return msg->len;
> }
> 
>-static const struct genl_small_ops psample_nl_ops[] = {
>+struct psample_obj_desc {
>+	struct rcu_head rcu;
>+	u32 group_num;
>+};
>+
>+struct psample_nl_sock_priv {
>+	struct psample_obj_desc __rcu *filter;
>+	spinlock_t filter_lock; /* Protects filter. */
>+};
>+
>+static void psample_nl_sock_priv_init(void *priv)
>+{
>+	struct psample_nl_sock_priv *sk_priv = priv;
>+
>+	spin_lock_init(&sk_priv->filter_lock);
>+}
>+
>+static void psample_nl_sock_priv_destroy(void *priv)
>+{
>+	struct psample_nl_sock_priv *sk_priv = priv;
>+	struct psample_obj_desc *filter;
>+
>+	filter = rcu_dereference_protected(sk_priv->filter, true);
>+	kfree_rcu(filter, rcu);
>+}
>+
>+static int psample_nl_set_filter_doit(struct sk_buff *skb,
>+				      struct genl_info *info)
>+{
>+	struct psample_obj_desc *filter = NULL;
>+	struct psample_nl_sock_priv *sk_priv;
>+	struct nlattr **attrs = info->attrs;
>+
>+	if (attrs[PSAMPLE_ATTR_SAMPLE_GROUP]) {
>+		filter = kzalloc(sizeof(*filter), GFP_KERNEL);
>+		filter->group_num =
>+			nla_get_u32(attrs[PSAMPLE_ATTR_SAMPLE_GROUP]);
>+	}
>+
>+	sk_priv = genl_sk_priv_get(&psample_nl_family, NETLINK_CB(skb).sk);
>+	if (IS_ERR(sk_priv)) {
>+		kfree(filter);
>+		return PTR_ERR(sk_priv);
>+	}
>+
>+	spin_lock(&sk_priv->filter_lock);
>+	filter = rcu_replace_pointer(sk_priv->filter, filter,
>+				     lockdep_is_held(&sk_priv->filter_lock));
>+	spin_unlock(&sk_priv->filter_lock);
>+	kfree_rcu(filter, rcu);
>+	return 0;
>+}
>+
>+static const struct nla_policy
>+psample_set_filter_policy[PSAMPLE_ATTR_SAMPLE_GROUP + 1] = {
>+	[PSAMPLE_ATTR_SAMPLE_GROUP] = { .type = NLA_U32, },
>+};
>+
>+static const struct genl_ops psample_nl_ops[] = {
> 	{
> 		.cmd = PSAMPLE_CMD_GET_GROUP,
> 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> 		.dumpit = psample_nl_cmd_get_group_dumpit,
> 		/* can be retrieved by unprivileged users */
>-	}
>+	},
>+	{
>+		.cmd		= PSAMPLE_CMD_SET_FILTER,
>+		.doit		= psample_nl_set_filter_doit,
>+		.policy		= psample_set_filter_policy,
>+		.flags		= 0,
>+	},

Sidenote:
Did you think about converting psample to split ops and to introcude
ynl spec file for it?


> };
> 
> static struct genl_family psample_nl_family __ro_after_init = {
>@@ -114,10 +178,13 @@ static struct genl_family psample_nl_family __ro_after_init = {
> 	.netnsok	= true,
> 	.module		= THIS_MODULE,
> 	.mcgrps		= psample_nl_mcgrps,
>-	.small_ops	= psample_nl_ops,
>-	.n_small_ops	= ARRAY_SIZE(psample_nl_ops),
>+	.ops		= psample_nl_ops,
>+	.n_ops		= ARRAY_SIZE(psample_nl_ops),
> 	.resv_start_op	= PSAMPLE_CMD_GET_GROUP + 1,
> 	.n_mcgrps	= ARRAY_SIZE(psample_nl_mcgrps),
>+	.sock_priv_size		= sizeof(struct psample_nl_sock_priv),
>+	.sock_priv_init		= psample_nl_sock_priv_init,
>+	.sock_priv_destroy	= psample_nl_sock_priv_destroy,
> };
> 
> static void psample_group_notify(struct psample_group *group,
>@@ -360,6 +427,32 @@ static int psample_tunnel_meta_len(struct ip_tunnel_info *tun_info)
> }
> #endif
> 
>+static inline void psample_nl_obj_desc_init(struct psample_obj_desc *desc,
>+					    u32 group_num)
>+{
>+	memset(desc, 0, sizeof(*desc));
>+	desc->group_num = group_num;
>+}
>+
>+static int psample_nl_sample_filter(struct sock *dsk, struct sk_buff *skb,
>+				    void *data)
>+{
>+	struct psample_obj_desc *desc = data;
>+	struct psample_nl_sock_priv *sk_priv;
>+	struct psample_obj_desc *filter;
>+	int ret = 0;
>+
>+	rcu_read_lock();
>+	sk_priv = __genl_sk_priv_get(&psample_nl_family, dsk);
>+	if (!IS_ERR_OR_NULL(sk_priv)) {
>+		filter = rcu_dereference(sk_priv->filter);
>+		if (filter && desc)
>+			ret = (filter->group_num != desc->group_num);
>+	}
>+	rcu_read_unlock();
>+	return ret;
>+}
>+
> void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
> 			   u32 sample_rate, const struct psample_metadata *md)
> {
>@@ -370,6 +463,7 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
> #ifdef CONFIG_INET
> 	struct ip_tunnel_info *tun_info;
> #endif
>+	struct psample_obj_desc desc;
> 	struct sk_buff *nl_skb;
> 	int data_len;
> 	int meta_len;
>@@ -487,8 +581,12 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
> #endif
> 
> 	genlmsg_end(nl_skb, data);
>-	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
>-				PSAMPLE_NL_MCGRP_SAMPLE, GFP_ATOMIC);
>+	psample_nl_obj_desc_init(&desc, group->group_num);
>+	genlmsg_multicast_netns_filtered(&psample_nl_family,
>+					 group->net, nl_skb, 0,
>+					 PSAMPLE_NL_MCGRP_SAMPLE,
>+					 GFP_ATOMIC, psample_nl_sample_filter,
>+					 &desc);
> 
> 	return;
> error:
>-- 
>2.44.0
>
>

