Return-Path: <linux-kernel+bounces-97916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE0D877197
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A166B1C20B22
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1641A42044;
	Sat,  9 Mar 2024 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JVzGrDL2"
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F71BDF4;
	Sat,  9 Mar 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709993445; cv=none; b=mjQD+QxRmCFXWqVKmn+YTXs5YtggaW0ZLQP21EK4rdxzamcUBcicbbYdNL2SCskIpNtK9eys86XeKd4ik/9/Ygj5tOKPICbLeDA1bwy3KFOjlG4rVA6qoZypa1d+dLVS5dKD1ZxNs60FLP4Meok+hNAdPbNoIYtURcdxr2kvuOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709993445; c=relaxed/simple;
	bh=maIUddBIRkixT08jMamIHlx6Ic+Z9RInYiboQrgEs6s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=M5ZW5IQu8fLVq4khRcqyTeIIg2DJH5OUnhIBzMAr28EjKv7SvJTw8LWh8EEjYqtvKkSZhfTfT5VEhQzCoKDjIN3C6ZoQUdx/9N7V6WNvF4EVo86ym7mwUj21OCNlohjt81TrD1tzflf1Jbhn6Y00wT8mHQL7MnQO4fHZvARA+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JVzGrDL2; arc=none smtp.client-ip=203.205.251.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709993133; bh=maIUddBIRkixT08jMamIHlx6Ic+Z9RInYiboQrgEs6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JVzGrDL29LVUN/yydIMy2NGYJM2EyEidTzZUQ0gLqzXXou8Q5yqxWOrqNPBKdRg88
	 B2FT+CGmxVvktX5dmAjqqDZrq8rN12bQix1RdgxW5tmLqNFN25WH9/BkxZOJ5r+dxU
	 2aLqKL4x/K9n+t0bmYsmRg4MRzILDT5IcBPkqYes=
Received: from localhost.localdomain ([58.213.8.163])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id EC3A729C; Sat, 09 Mar 2024 21:59:03 +0800
X-QQ-mid: xmsmtpt1709992743tsey328q4
Message-ID: <tencent_4E77E34FDA2F438430621DF220620A882407@qq.com>
X-QQ-XMAILINFO: NiAdzfE16ND4bolk1M35OWX6STXNtKuQPLdhDd/JkFmdm5wIJTCi649pCSKM8M
	 5uyPE9F9cX+lpf9GA+o4h+QfDkgnSsXsQrWD3WmXxTno2qDQAyxX4p4c4PqbM5ZIj6FIqwwrzNYx
	 XrwPrsCxHmZa5dPWRvDQnXlg0XYblyTTjeI0SzPbd7K/okRDzEDS93pLksKWsnewPRINUck8iTyz
	 ps7efNFJGutn7vybZyaXRmdpX73/ltUA4j2RFeEygGbobECdsB/13h78gf5vYe5eWXhx4GBp36y4
	 9DeBui7+MRVQDqjV31MykaWxSJ/8gelC4nOws1ga9zJrhVwCc9SdpiIBmJxKd16PCFyFpgOP+0j2
	 6NVlqeB9PKmR0pSFc7h0JaLZsqHgZU7Ry5IRuw49uP/qmejY5tWusbBSconD+h9bydyupHyQVAd/
	 AUzNG3JwUc0v3kLet5PfGlw+xxpAws20DHk9kcWZh0XD99UgzrbE4RNkPJmgtG7BSMs+4iw8SDoM
	 3hod25UGk+B2SqahuPz3QYj/XDBEGUc4dmZVYoA6hYLkZQNZlZfeFdAUTyIckoTNqzXuAzn8vJjC
	 uAnsrM/EX6tHqaes5olJtXuAm7kmh4KN766ygYLQN4vkrI+Vg96gUM4VJnFMznPEZaovwok8/h0N
	 tJnt6/GsVuCYTarATR3e7b2EQpaMWFGAI5bPTiEXgjA5zFVf209u3qHqpRr0xuLi64yyV9APzRQs
	 r5Cl8HH9Gm+J//3AmzfdF73DvjTgdvef/GD+SyBCTqfE52aR3tvBTayPfMKLeC85gqOUf/4x6FAL
	 6qVI3l4Tm88xGAYaZ4bk1z4f1Sl54r2AcpaZ73N5Wb3gyFSInWIx0vcqR03keRitC1NW4hHK9BWQ
	 lskAKk4rzevAtuqkugS2GsJYyA92BvHJdOz12Qi2iFZTv8tirxaLHI7WOwUw4tz7avx8GlpTBtDJ
	 eaGuVmFgbfLgkZ3guPoCh7sZjMuT0aiERUF6bm4JpQfYhBaJfNK8FDoqViI0qeA2RNQQ478e1FPQ
	 fPFZ06eg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: linke li <lilinke99@qq.com>
To: edumazet@google.com
Cc: alexander@mihalicyn.com,
	davem@davemloft.net,
	dhowells@redhat.com,
	kuba@kernel.org,
	kuniyu@amazon.com,
	leitao@debian.org,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	wuyun.abel@bytedance.com
Subject: Re: [PATCH] net: mark racy access on sk->sk_rcvbuf
Date: Sat,  9 Mar 2024 21:59:02 +0800
X-OQ-MSGID: <20240309135902.57126-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CANn89iJRXjYTojFyHN6s1Qu9Vkkk6RwxPF=bAKPjOg9zT-GupA@mail.gmail.com>
References: <CANn89iJRXjYTojFyHN6s1Qu9Vkkk6RwxPF=bAKPjOg9zT-GupA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> OK, but what about __sock_queue_rcv_skb() in the same file ?

I notice that, but I am not very sure whether there is a data race. If it
is a similar situation, then the same patch should be applied too.


