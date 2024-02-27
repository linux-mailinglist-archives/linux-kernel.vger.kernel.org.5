Return-Path: <linux-kernel+bounces-82902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB9A868B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53C5284408
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1CE135A7E;
	Tue, 27 Feb 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbXmdz5C"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021DC55784;
	Tue, 27 Feb 2024 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024597; cv=none; b=ZBFf9PGn0C49Vv6xrMUen5lMJSwbd71Mj+xw1/dUE/iL/wQ6V7eOwsAlazvntayU9tye6AU6slcpXJ5Vhp/LetaoHi53Xrc9sHiHS1RR/fjvuXt8+KB2N6Qi7osDEnPHnQ3B+ypq/fCvHdgaztdk1qOvVMoLROe1LqrdTxGplBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024597; c=relaxed/simple;
	bh=fU2iYIGjJMhLEH28pQAAHT8Nd31ZjfK3UFkPzSvJrqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuTlzr01duXbd96LxcORcofxeqf1ri0CRduM5/0RUAPoW0tiWz3CB/XrM7OCavusCfLoVN/bl6xcHQrx1F8Q6B0HC5HxQSbeC0gy0uKdB9uAPlVNaThuEVBYbTHNw3QdasFJtXtghdeumQj9Mh4xJ0TOxLNYpc6rlcnLURYYSUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbXmdz5C; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d153254b7so3088055f8f.0;
        Tue, 27 Feb 2024 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709024594; x=1709629394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yDl/9Z8vdDqaR6iL8wu9PpxbAcWBuGSKPAcKXxs4mQ=;
        b=fbXmdz5CHRCQaQwmsi1vk9S5XjtwGS/1K9ZTJSkUgRuDpImuikLjNodWcnEtGaqito
         /GCaMIImlUqMBUEKUqhVV4mySDjRwvSQw1q8pn9o1BmD24zNxWZnpNUbpkl/hflGkBZY
         LXj60KE5seqJbG3UMAS54ZoQsh4xiJvL9Q/UALVeTBg7tEvBQh9oGCCeBb+5JfE6fGCy
         wyzEE+Hr98Pub1ISKv/Lc8CtVSYqlK6augzbSr8TisLvwtKcF9WbdLVunayfLcisMX08
         skbkbnsYYBivOMG7dr0VIEsw8PuCivGYIlrIXFnlqoKFsk5GaAVPH+awYmK0bETn1zZ8
         Th+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024594; x=1709629394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/yDl/9Z8vdDqaR6iL8wu9PpxbAcWBuGSKPAcKXxs4mQ=;
        b=O6OrTY6tcg8lbDQ+koXpYHOI+oN0OWt7ftr+MhlMv8ji4zULaeDsrKbbdDsCexIM2d
         JyLU/muRdPV3+V5nM7jGIbCYwEnnDL24mSeGVfYJD0/F0YOUb6GrBkz17AjyLhWopsfW
         8VTSx6oKaF7OIOGMYPBNp/9z9qc9sk+dNvfsmiiKV2NKP4wg1N4ksssSCyjh3PlT54qz
         ShZIN0fofGcaQ9hsjkj2jN8W4bq39XYEF/WnNa5E5ULFHMYBoiHZeCoA0sBIgYk7WiCw
         Lf584q+Kizd+iYnT0HrIy6AYvL6i7ZbUM3TJAvAxYWHoHLwMnEQY6BkxCJpKK7jOtEX6
         ETbg==
X-Forwarded-Encrypted: i=1; AJvYcCVYpQEdDifIluCak9olWhJIPLHbfeliaf0jrj01ChC2n7sziSSmb+qGXvls4y9anzXBbVkAQ/kIFA6CawNsmYsMCOpjjqeaFgGi2ou/g68GkR+aX8CkzhYKy0PzIcUCt5BtuBPw
X-Gm-Message-State: AOJu0Yy5rEJX7/eF4PxsEMyYJyJb1JuIDYGDL9DmpU71cGqN94cyk9Zg
	HDdO0q6/Rr4xWrtuFnqboREy8Y4uda3ajnVjTYMKmtj/89pzJ5OD
X-Google-Smtp-Source: AGHT+IFCQC28ggruhQycoMEQOPpIPfsMAl/IBFWeXrj8CG0KE1k9m7shkoRTh/ChNwd11Aks0a0Mfg==
X-Received: by 2002:a5d:58d1:0:b0:33d:2d07:bb2c with SMTP id o17-20020a5d58d1000000b0033d2d07bb2cmr5935411wrf.28.1709024594081;
        Tue, 27 Feb 2024 01:03:14 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id w2-20020adfcd02000000b003392206c808sm10603745wrm.105.2024.02.27.01.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 01:03:13 -0800 (PST)
Message-ID: <aa5f1c11-4528-4d53-91f3-5ce8c02363ac@gmail.com>
Date: Tue, 27 Feb 2024 10:02:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] net: geneve: enable local address bind for
 geneve sockets
To: Eyal Birger <eyal.birger@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
 amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com, b.galvani@gmail.com,
 bpoirier@nvidia.com, gavinl@nvidia.com, martin.lau@kernel.org,
 daniel@iogearbox.net, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <df300a49-7811-4126-a56a-a77100c8841b@gmail.com>
 <79a8ba83-86bf-4c22-845c-8f285c2d1396@gmail.com>
 <CAHsH6GvX7zYSoA7JVemRtunWWSaew1S11Y996WAGt6B9d8=cOA@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CAHsH6GvX7zYSoA7JVemRtunWWSaew1S11Y996WAGt6B9d8=cOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Eyal Birger wrote:
> Hi,
> 
> On Thu, Feb 22, 2024 at 12:54 PM Richard Gobert
> <richardbgobert@gmail.com> wrote:
>>
>> This patch adds support for binding to a local address in geneve sockets.
> 
> Thanks for adding this.
> 
>> It achieves this by adding a geneve_addr union to represent local address
>> to bind to, and copying it to udp_port_cfg in geneve_create_sock.
> 
> AFICT in geneve_sock_add(), geneve_socket_create() is only called if there's
> no existing open socket with the GENEVE destination port. As such, wouldn't
> this bind work only for the first socket in the namespace?
> 
> If that is the case, then perhaps binding the socket isn't the right
> approach, and instead geneve_lookup() should search for the tunnel based on
> both the source and destination IPs.
> 
> Am I missing something?
> 
> Eyal

You are right, I missed it.
Binding the socket is the main reason for the patch, to prevent exposing
the geneve port on all interfaces.
I think it should be searched in geneve{6}_lookup and in geneve_find_sock:

static struct geneve_sock *geneve_find_sock(struct geneve_net *gn,
					    sa_family_t family,
					    union geneve_addr *saddr)
 {
 	struct geneve_sock *gs;

 	list_for_each_entry(gs, &gn->sock_list, list) {
		struct inet_sock *inet = inet_sk(gs->sock->sk);

		if (inet->inet_sport == dst_port && geneve_get_sk_family(gs) == family) {
			if (family == AF_INET && inet->inet_rcv_saddr == saddr->sin.sin_addr.s_addr)
				return gs;
        ...

This is also true for VXLAN
What do you think?
Thanks


