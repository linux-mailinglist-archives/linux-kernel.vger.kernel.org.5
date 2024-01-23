Return-Path: <linux-kernel+bounces-35400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A8839064
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874D11C21A50
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA025F578;
	Tue, 23 Jan 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BVTyIB26"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9D5F542;
	Tue, 23 Jan 2024 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017560; cv=none; b=DlEV3d+BcOrSd8HgXuq2tuZS9COWGp97DfXbVzctDf8aUful8UnQqAVNwrgXY9GjCts5jL1LSrREx0AKGXHj+O7Osp/PQnosJuVe+697xM+U4i770NuqC7v3FiKHewz6uyY3PFpZSY1mClTFkmW1KT26VSecM1Dtj8/xv6HQfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017560; c=relaxed/simple;
	bh=lSTLKPXTaO/2qRTR0NkrIYLZTC33Ga49EoNFiaew6C0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KP3GM71v95p6LJOWLs5AfQU93K4dOtqooq1KnZ8FPvttdne5hj5TYr8jwWS+gCEbPCVGL1P3Ye/joWSlIWGdi4oNik8FooW+UZvhc/Tx1lCYWujgrqACVLfIpf7F9L2BIlH+De5QGh3e0wELegw0wVHqzzxh8v211YaCN122f8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BVTyIB26; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706017520; x=1706622320; i=markus.elfring@web.de;
	bh=lSTLKPXTaO/2qRTR0NkrIYLZTC33Ga49EoNFiaew6C0=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=BVTyIB26tztVz7P34PiuB1zOYXLxRRpRL9Z/SKmuP4QVU0SyUbF831lUpRBkiNII
	 i3Itw2a00rWmW8EAClHIegVGvMi3EXbkB3h/7gUOCpzHHxQydmkhO4EWeHy++TjDe
	 Fc4nhud+CRGmfF7VCBl5cs3QTfAwywdlzp2X1tZ//k5YaQSNoKzbiJyR0jQ71zj10
	 NHDqXqYETDL4BS+zPfa7xEULkVZoq+Xt4cv2l28VmScYVLYNfBJIlMoTss+HtWWOl
	 WIItvtlp9uAty7BRe+Ky3sYo1YDmosOv5ZoxMUZuWbP8Stu+OdCtSYTdWfZca33QS
	 SSRDJPGC22/ZEBEH+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8Wa-1roDmi0bBI-00MMjV; Tue, 23
 Jan 2024 14:45:20 +0100
Message-ID: <c49c716a-e070-4ad5-9a90-896537bcd1b5@web.de>
Date: Tue, 23 Jan 2024 14:45:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Westphal <fw@strlen.de>, Jakub Kicinski <kuba@kernel.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>,
 Phil Sutter <phil@nwl.cc>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] netfilter: nf_tables: Add a null pointer check in two
 functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q2yg1JxYgb6/HhGmfheXygZrpzmLncDbJLlxEQOSB0psi70e0gA
 XYDtuVR7HmDUlmjah4xWCvmqi90+SExkj3Zs1Yenh3XpKsRxl2NM/oIv4/mG1S90ymZHQHr
 oBC8aRx3pac6243pvJNhsZbbf4g5QdE6r5xs7AQd4SuFbmmnGuxipOdUCDVXRtpzaegj9Kp
 +5MJnt2cFEkIFCrz8ijkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:urrv4rpcajc=;/nHaTBh4XMqzTVirGs4oOTwcSi7
 ZIxCLy+7hJuCSuOhVg8aSGW9cJwf9yHPN21+TmX07Z/erdwvtYb/qpAQU6mGPotw2bCCj9kb2
 lxcnr74Pxs904yx/f/sIhE59WjCjx5zFH3HwdJKNk49/2vliqEweKn9eGG251M7Rt+o8iE0At
 LzCScwwIV+gvJPJObXmCzdJfzu/vIJkNNyOoQARaDAumB1KXXgi4Ov88uqwFh/ZhKXyFS75MU
 FIOzvKOEcHAObp/lj7TqFrkEYcKHITFD7cUIFKS9Z1kQOuOTjh3kHF8wiEL+Fh5NZdb1PN2Xl
 QmUDRsaV0LmU+76U4nkG8R7bi+pcRhWin6OKQejoiYq/A7r99hbi8FDcYc4Z8Hyba64CRvC/R
 fiB0N4WDHHfX1Dk31xsL/AuTne8LgZpV4KB+1Mk8FZk8mo3BHd1db8lOCL+5x6Qztn/M9eFn9
 v1OJCeX5DuR95qT5bzhcoiTfWJGDjZVEan7sK0wjbU/+oQHAh9rTJUofA5QtaAxqHWH5PycLk
 ju1YZzmimdsVbq69r8a0AWeN2XeemLAbE9vSBkej7h9vvhfozIXNPlZgLdzxXwWJGI2Xtg4Hy
 F3FwWe/foM6cjRVm1QwgIXl1xPRovRK1njOBLBYashgtubclcXgsXr6iOqxLETIx1K3spPAt+
 hsYsGaMSBFc5M9Yi4mskv7EhSnNQf+gHgq4tsVTQWZdvAg6Pc6YFmZWUO4LDOZsgdHmNNjwol
 pnEv0Uq09v4os/Bh+7cm1Dm1RjNllvkmXTr5ljqUua5qL+WrJ5aHrRJXNMiFv4qRhlNLP1fdH
 K0j/3Ln9kHwG8bmQ2ZyGyRyybo1kxcSMMd6fvA9yE2new+Cbg8RB+kvluHjhKCSw7SQdBlgwk
 NdQAoOrgI1+VMj0yTMCqOPPIb82a5lfDA37+T31k5iZL5J50EyJ9DhSnmM6nB9bwgcW/xkzoe
 S/cmXQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 Jan 2024 14:28:31 +0100

The result from a call of the function =E2=80=9Ckasprintf=E2=80=9D was pas=
sed to
a subsequent function call without checking for a null pointer before
(according to a memory allocation failure).
This issue was detected by using the Coccinelle software.

Thus add a null pointer check and a jump target in affected functions.

Fixes: 8877393029e76 ("netfilter: nf_tables: Open-code audit log call in n=
f_tables_getrule()")
Fixes: 0854db2aaef3f ("netfilter: nf_tables: use net_generic infra for tra=
nsaction data")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/netfilter/nf_tables_api.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8438a8922e4a..cb61c7a39a76 100644
=2D-- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3728,10 +3728,13 @@ static int nf_tables_getrule_reset(struct sk_buff =
*skb,
 			nla_len(nla[NFTA_RULE_TABLE]),
 			(char *)nla_data(nla[NFTA_RULE_TABLE]),
 			nft_net->base_seq);
+	if (!buf)
+		goto exit;
+
 	audit_log_nfcfg(buf, info->nfmsg->nfgen_family, 1,
 			AUDIT_NFT_OP_RULE_RESET, GFP_ATOMIC);
 	kfree(buf);
-
+exit:
 	return nfnetlink_unicast(skb2, net, portid);
 }

@@ -7917,6 +7920,8 @@ static int nf_tables_getobj(struct sk_buff *skb, con=
st struct nfnl_info *info,

 		nft_net =3D nft_pernet(net);
 		buf =3D kasprintf(GFP_ATOMIC, "%s:%u", table->name, nft_net->base_seq);
+		if (!buf)
+			goto fill_obj_info;

 		audit_log_nfcfg(buf,
 				family,
@@ -7925,7 +7930,7 @@ static int nf_tables_getobj(struct sk_buff *skb, con=
st struct nfnl_info *info,
 				GFP_ATOMIC);
 		kfree(buf);
 	}
-
+fill_obj_info:
 	err =3D nf_tables_fill_obj_info(skb2, net, NETLINK_CB(skb).portid,
 				      info->nlh->nlmsg_seq, NFT_MSG_NEWOBJ, 0,
 				      family, table, obj, reset);
=2D-
2.43.0


