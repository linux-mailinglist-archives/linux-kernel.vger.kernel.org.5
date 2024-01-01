Return-Path: <linux-kernel+bounces-13851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A1182137E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 11:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB721C2185D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 10:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AE223DB;
	Mon,  1 Jan 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WiM0X3mz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34B46A2;
	Mon,  1 Jan 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704104570; x=1704709370; i=markus.elfring@web.de;
	bh=3rrWVUyzD81jNe2M5aQcv76/ryCSUnodIUw9mv/60B4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=WiM0X3mznBGwtXK7cJpC6ZqVOg8EqKq7RpkvepXQqkNlrgjR2xOA9lXB7aZoWFvq
	 xaQMkQfdIM27de3EMrgUgEWynRvbZb/3XYBdMF9UY6K/9pNG8XgGqSSp9XT0y2Yi8
	 uQ7kqAfCMl8kLavchpuedNVijOWkrA8P4r797dVLxzKHnsqZsRbzk1Kkxr2yahHFv
	 d6l5yWuD5WzMcdIMYAe7Mn8r1HfRvdbbosG2QIEDLFiv0tN5WxCAVzM5gxs8SlgMk
	 DL2Ay32Q0boRrWgnDi/i5uc84Sj8VSA1ATggoDCNSlDJ3rsvXNWaaPhintsv3S3mp
	 WpApVpGD0lYovxchbQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7gbW-1r6Rfk0isk-014vzN; Mon, 01
 Jan 2024 11:22:50 +0100
Message-ID: <d2827643-2859-46c9-8f71-723108329cd4@web.de>
Date: Mon, 1 Jan 2024 11:22:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_2/4=5D_netlink=3A_Move_an_assignment_for_t?=
 =?UTF-8?B?aGUgdmFyaWFibGUg4oCcc2vigJ0gaW4gX19uZXRsaW5rX2tlcm5lbF9jcmVhdGUo?=
 =?UTF-8?Q?=29?=
Content-Language: en-GB
To: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
References: <223a61e9-f826-4f37-b514-ca6ed53b1269@web.de>
 <202401010855.4iU6im1B-lkp@intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202401010855.4iU6im1B-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:le4yLfZi8Cs2gMwuf2Hysqz4ZSz92zNU0xB1QJCz351Eox8ntp1
 qxMxLKc90/JXAXCcGMNXkWt46JiBtAYnwmppjy8qHnlw9YO+21L+gzI79rBO1EKOoHABIgu
 tRXct3mS+fztw+sb+hUNlyYWyvXsC2okwO5ko8hspkoUrQoVauofO5+0lfZofn0hRA93YwN
 QpEt+h3jE6/mDCBtR6Krw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KQZj8+oppFU=;i8hCbyZJqYcyBg6ffq0UGk++7gU
 lFLtdhKHhLGqPLvg5RBapmBLxEquen9apRsNZhYr+P2RRRT+VFf9d5VRFLbO557peJhdy7axP
 4Hslz/yGOTDTt36G9zeirMrPq+Pke2nUJJSGI/oy4XvxQlcyuLcz6M+0/0qFfn6TDubSCsaEN
 2EAFjuOTSkt2FlAGVd55Uo6Tk3mAQPp2TpNBnf0DrrElLf/989DC42aHUY3cuETKQU0ZB4fFo
 3ij6v6m6HbJCN3P4QFmKgm/QhOdDlhs/wYmdM2oWLk6KfNMdRr4l9AitQ0ZFHuu64xNXEUg4f
 Xk6dpPgw18tYS1A+kj3NsUni5q2MJR/5pgYZnu8sdvdkAyBHH9ffJMzKllS9IcA1ql14VMJL9
 xCShHd1Dp05Jx7tmEf3lxMRVqx9cEKCvS/nndUQQbnNCJm7adTn0UyRGszncno/JNer3/d5DE
 j3QnH1NZXlDaR01CRgR99a6rBvUyB/rtjAMc6ZhZqCi55jkfwaM00fpfxZZMJ0hv96oP0WGN0
 5OrIkHZ9GYcbL37DtZElw/kUnlozHk+GvD6VyiMHlM1GqkWb7oIyRwpx1Nf4ZFtmiXoxY6RTk
 RCSvq0xjjy9vwmxdBburAusgG8SYHxVETUHzSFtLGpzPWlam0pg+/I/Ind4Q+rppTw4Js+zB2
 vlrdeLLzha/7/pvwez/5YOitkTmn5gLYjX9xQncpvS57k/K6S3Zd2cYzmXMTcWHbypglUhf68
 gtdSfLrcxl4RGGDr2izjzohcxktsF+LLgbmDmXUKcJpcio3HOXCm8CO7hDU37bUT+YiRH4ZPs
 6IHzdlGpJqsx8VxjWgwsND6LlUB4yX57m+pqlsH6m5tej6/sn914e1Zlufs+ShwBtLLDJXP8I
 1de8vIMH5U5h/7RJoQ6elmJUx9b0i9DIMFLYTls80XtbVPqa3xP8HNTqVLW3eyjec0h1d8WYd
 6X+kXVTpLjB+w/+Vyry59Nl96Qc=

=E2=80=A6
> url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/ne=
tlink-Improve-exception-handling-in-__netlink_kernel_create/20240101-01502=
5
=E2=80=A6
> patch link:    https://lore.kernel.org/r/223a61e9-f826-4f37-b514-ca6ed53=
b1269%40web.de
=E2=80=A6
> All warnings (new ones prefixed by >>):
>
>>> net/netlink/af_netlink.c:2044:6: warning: variable 'sk' is used uninit=
ialized whenever 'if' condition is true [-Wsometimes-uninitialized]
=E2=80=A6
>
=E2=80=A6
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2016  struct sock *
> 9f00d9776bc5be Pablo Neira Ayuso 2012-09-08  2017  __netlink_kernel_crea=
te(struct net *net, int unit, struct module *module,
> a31f2d17b331db Pablo Neira Ayuso 2012-06-29  2018  			struct netlink_ker=
nel_cfg *cfg)
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2019  {
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2020  	struct socket *sock;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2021  	struct sock *sk;
=E2=80=A6
> 5c398dc8f5a58b Eric Dumazet      2010-10-24  2023  	struct listeners *li=
steners =3D NULL;
=E2=80=A6
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2032  	if (sock_create_lite=
(PF_NETLINK, SOCK_DGRAM, unit, &sock))
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2033  		return NULL;
=E2=80=A6
> 5c398dc8f5a58b Eric Dumazet      2010-10-24  2043  	listeners =3D kzallo=
c(sizeof(*listeners) + NLGRPSZ(groups), GFP_KERNEL);
> 4277a083ecd2c8 Patrick McHardy   2006-03-20 @2044  	if (!listeners)
> 90ae404765d263 Markus Elfring    2023-12-31  2045  		goto out_netlink_re=
lease_sock;
> 4277a083ecd2c8 Patrick McHardy   2006-03-20  2046
> e547df909ec09d Markus Elfring    2023-12-31  2047  	sk =3D sock->sk;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2048  	sk->sk_data_ready =
=3D netlink_data_ready;
=E2=80=A6
> 4fdb3bb723db46 Harald Welte      2005-08-09  2075  	netlink_table_ungrab=
();
> 77247bbb309424 Patrick McHardy   2005-08-14  2076  	return sk;
> 77247bbb309424 Patrick McHardy   2005-08-14  2077
> 4fdb3bb723db46 Harald Welte      2005-08-09  2078  out_sock_release:
> 4277a083ecd2c8 Patrick McHardy   2006-03-20  2079  	kfree(listeners);
> 90ae404765d263 Markus Elfring    2023-12-31  2080  out_netlink_release_s=
ock:
> 9dfbec1fb2bedf Denis V. Lunev    2008-02-29  2081  	netlink_kernel_relea=
se(sk);
> 23fe18669e7fda Pavel Emelyanov   2008-01-30  2082  	return NULL;

How do you think about to use the function call =E2=80=9Cnetlink_kernel_re=
lease(sock->sk)=E2=80=9D?

Regards,
Markus

