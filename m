Return-Path: <linux-kernel+bounces-158130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2473F8B1BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7DE1F21E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FFC6D1A7;
	Thu, 25 Apr 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VwRq2FIJ"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD433A268;
	Thu, 25 Apr 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030385; cv=none; b=gmdLxEUVVbx9C5yOo+3NoxE2K6i+NFzcBm/CpuPuotjCwDjN5JuaRJu6yPylQgiHo5SUNS8HNXhD5BA6AoNwQ2FQntvqb0P2mQ3CItwGemge+MFsWquCif5uFkV0Aaql0pppTH+iuo8hLvExF4B+glHG7AYHHc8eupF6sPXdbJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030385; c=relaxed/simple;
	bh=EnEiQRFJoJpZqIEia4zGx+kZs4v4yYeavFjjY/vEY8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIVppWkC+262zIEve99Pw3Um46EBWJJyiqe+s93csQuq7ggt0F04LCvp14Tq7uWhd1Mkxzq95RTzKVUdgFndHPbB8VmamDZ9dYzLpnFe/aKmrZC6TwMFbFAN5QQ0erOLRBXkkUDD0YhrKQ1R4vWJt7QX+/vq7rDdc3JCSnAz5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VwRq2FIJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id AD1941380130;
	Thu, 25 Apr 2024 03:33:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 25 Apr 2024 03:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714030382; x=1714116782; bh=SLXYBozdGuze8fwEhSYkE2RdoqPW
	Tdv6MrJs350+i6I=; b=VwRq2FIJYnOWzzcbNm9ISw77YEfS0U5O1dGEVXOlC7DK
	iQJroVwQeFxiTMLbtwquAyzPH43vTkpyIW/nJt7+ufRHxNdWY89m3JUngdPNyi1f
	0opldTLAqVK+z96J9NqeacHdOh4XMm8DMMeLnSkD6HtwDIOXDhTicbroJfR/q8S4
	K7k4x3N0gKHZFtUXVgNK9lYdmC1We+jdeux6DwpNwqlMFeiXadvnIOt8x5AMFYiE
	LdUtszFBWzQGQHXYnO6EEecJ9DvmQPvD+GPnezxJID7QBdCcmI8Iyn8A2MPt3pxW
	aorn09OcynIPIZsbvlTfJHqDCfmuxIWsR+4fLh4yEQ==
X-ME-Sender: <xms:LgcqZteMGf2qI0ToSP05ohFSS7bJC_v7ibz-GbiRVbqdUelyAbDGmw>
    <xme:LgcqZrM9lEjRhprFSWn2NBWrLIaKeM1S5D4UoRj9kKhY86BbO2tBC5qErphzWEdZ1
    vL3CnPV2UiXrUw>
X-ME-Received: <xmr:LgcqZmhv8Sgt6-F0AFxWIMEVvVubUZTx44b6eC3bndAbZc3ose2Jh1ZmOrDf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeliedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeej
    geeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:LgcqZm9Lp4GLpknzHZa8hI0-1PcBATL5uCWDgWxsf8BnqGeXNutU9g>
    <xmx:LgcqZpucmIqMdrd-Rka75lmhHFpf5BAz0hKO7sOU8g2WVF828c8gLg>
    <xmx:LgcqZlGMeGk3cEdToSspE0QZxjpTQUwU9kvW28NsmU-4r_vFuvi7Yw>
    <xmx:LgcqZgMWrkHR7Ga_D5aSjZj8gywknfKvg-9CcN4GdqmnIaAsG82Nxw>
    <xmx:LgcqZlFV_uu0sxxmzD7j5G5iOP1LlYSmfwiubwCJNJWiRmzuDnP77h8d>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 03:33:01 -0400 (EDT)
Date: Thu, 25 Apr 2024 10:32:54 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	horms@kernel.org, i.maximets@ovn.org,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/8] net: psample: add user cookie
Message-ID: <ZioHJtWPNbb3bcqT@shredder>
References: <20240424135109.3524355-1-amorenoz@redhat.com>
 <20240424135109.3524355-4-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424135109.3524355-4-amorenoz@redhat.com>

On Wed, Apr 24, 2024 at 03:50:50PM +0200, Adrian Moreno wrote:
> @@ -579,6 +580,15 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>  			goto error;
>  	}
>  #endif
> +	if (md->user_cookie && md->user_cookie_len) {
> +		int nla_len = nla_total_size(md->user_cookie_len);
> +		struct nlattr *nla;
> +
> +		nla = skb_put(nl_skb, nla_len);
> +		nla->nla_type = PSAMPLE_ATTR_USER_COOKIE;
> +		nla->nla_len = nla_attr_size(md->user_cookie_len);
> +		memcpy(nla_data(nla), md->user_cookie, md->user_cookie_len);
> +	}

Did you consider using nla_put() instead?

diff --git a/net/psample/psample.c b/net/psample/psample.c
index 92db8ffa2ba2..ea59ca46b119 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -589,15 +589,10 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
                        goto error;
        }
 #endif
-       if (md->user_cookie && md->user_cookie_len) {
-               int nla_len = nla_total_size(md->user_cookie_len);
-               struct nlattr *nla;
-
-               nla = skb_put(nl_skb, nla_len);
-               nla->nla_type = PSAMPLE_ATTR_USER_COOKIE;
-               nla->nla_len = nla_attr_size(md->user_cookie_len);
-               memcpy(nla_data(nla), md->user_cookie, md->user_cookie_len);
-       }
+       if (md->user_cookie && md->user_cookie_len &&
+           nla_put(nl_skb, PSAMPLE_ATTR_USER_COOKIE, md->user_cookie_len,
+                   md->user_cookie))
+               goto error;
 
        genlmsg_end(nl_skb, data);
        psample_nl_obj_desc_init(&desc, group->group_num);

