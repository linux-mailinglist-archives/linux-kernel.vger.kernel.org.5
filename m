Return-Path: <linux-kernel+bounces-96998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2E87643B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720AC282B94
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85315731C;
	Fri,  8 Mar 2024 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCUsUGoA"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB1F56459;
	Fri,  8 Mar 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900674; cv=none; b=WpDB/1/sCoObVsZTaFITtxTlBc1ImEDmlFJQzcpRZbTQG09XcvOC2NnMG2awvQ5XP7d3X135HNE2SBx6aJ+JRtAvcULB0+fgwwESe71U7igBJ3LiyINsvKneklggmzZAcjSyQtuRmh02yzAM2+RFtFRYSxbwXV+SCjf1ZD3QG+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900674; c=relaxed/simple;
	bh=Ase+5+31oDbJYm8v66P+FyYugxyAlKL6wBNvXJiUHgg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=klyXZt7U/yIRlTflW2Yw5+LQhx4oGk1Kl454uBa5wkid5crGuqYxxfjbdBf9+W30BMkADouwtTd25qVVKiwsUrLvS64UY9yFpU8qh8e7E2ewpbGhrIXjGwQaxlj8APOvjpotM/ZUoG6T7kWzLqdiDbIAnCFzGy+vrZotXdZbLnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCUsUGoA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42ee23c64e3so3531591cf.2;
        Fri, 08 Mar 2024 04:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709900671; x=1710505471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyeTx4l+PfTtnxPQ3ZJbKCz/ab6s4jrqxemMSoIoEeg=;
        b=iCUsUGoA16FSWliuuRZNpav/TNoHBmok6EIRE9IeYkm8rgmty6hzJ548VzRoU6rNFK
         MTNm720wZrK9dH103DC5G5jkojLA0wNGv0I7EWuMqZWTywPdhUOCHFIBmO31jgDM/G+m
         lwF22Zk1hUSuCfpXYNm/Bs83P6Ah/vGMXSGpsF/Pi41+Zx1OXNf+/Nzp8O9pehY6haiw
         wTCSAQjoa3B1BfJATEk1JJtqnYQsrwVMsAJakcwAY5HrnNFBYC9hHVQdaIDqoLabbhCc
         ynLmZ+bdN/PKFD0lYgYL3QxGnOxjlJUXqIselBz85cNWqwhKCU+RABdqxnO/07vLTS3W
         6vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709900671; x=1710505471;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qyeTx4l+PfTtnxPQ3ZJbKCz/ab6s4jrqxemMSoIoEeg=;
        b=CCvv3wQwOjWQ9sxlneo9ywL/0H7LeoYGTmZRl2qy7XgcXOlIjlXjjRd0wCQA16DB68
         K+5JR/49nbtJgr0Pb5D7vzDw71E4cR+M2GVMnlxf32spR+rNA7rzdLxBfLkwKXoau06G
         lZdl0hVUFVcEMT4S4MxccJsN89Ge9dGgfvXnlJ6lFpxtHPwOQNfLv56Wd4bzcJAK9dKa
         8NKhucwY2UAPJ3KoS8hJTbdHWlUZa5wjIAKfgbMwlEBQmGK2sL1nF15gJBnLiH0yWVwu
         drevY/5LedpjaWzh4WKHicgLpFFz6MI031OkmXaqVYHerZlszFyHSgUx/z0AinE0QHiS
         K5jw==
X-Forwarded-Encrypted: i=1; AJvYcCU3aQQyitBaZxVZgXVomU2hujxLXBcukKETssgCQN+/25CPmVW9uMd1xQ4//dlsFIXAR1cZqqZ2QWNpaFJegR6sHUGcQxcSm5Ro5iw+
X-Gm-Message-State: AOJu0YwPSPXP7ZaW8axTVDse2KhPi1KpGsO8AouAOeZR4YHmoM+wgulj
	l3RF2qboZY9vUcFKqa4tlRpOOz5PCrkHonB/S5qOJVMd7Vzw440m
X-Google-Smtp-Source: AGHT+IH0hjodA7QR2VzGv0582KlBhi53oqM+xOWmxnX3vjKaCKuXDqcrAsNVLzbM+HuPdnJrTG93eg==
X-Received: by 2002:ac8:5748:0:b0:42e:e42d:e4a6 with SMTP id 8-20020ac85748000000b0042ee42de4a6mr10277649qtx.47.1709900671275;
        Fri, 08 Mar 2024 04:24:31 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id c12-20020ac87d8c000000b0042f068d3d8asm3420786qtd.43.2024.03.08.04.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 04:24:30 -0800 (PST)
Date: Fri, 08 Mar 2024 07:24:30 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Juntong Deng <juntong.deng@outlook.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <65eb037ebbd4a_1356ef29497@willemb.c.googlers.com.notmuch>
In-Reply-To: <AM6PR03MB58489E6E890BA4A20D429DDC99272@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848595A20BB5D958C2D9DE299272@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <65eaf9e336d07_133b25294db@willemb.c.googlers.com.notmuch>
 <AM6PR03MB58489E6E890BA4A20D429DDC99272@AM6PR03MB5848.eurprd03.prod.outlook.com>
Subject: Re: [PATCH net-next] net/packet: Add getsockopt support for
 PACKET_COPY_THRESH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Juntong Deng wrote:
> On 2024/3/8 19:43, Willem de Bruijn wrote:
> > Juntong Deng wrote:
> >> Currently getsockopt does not support PACKET_COPY_THRESH,
> >> and we are unable to get the value of PACKET_COPY_THRESH
> >> socket option through getsockopt.
> >>
> >> This patch adds getsockopt support for PACKET_COPY_THRESH.
> >>
> >> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> >> ---
> >>   net/packet/af_packet.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> >> index 0db31ca4982d..65042edd1a97 100644
> >> --- a/net/packet/af_packet.c
> >> +++ b/net/packet/af_packet.c
> >> @@ -4090,6 +4090,9 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
> >>   	case PACKET_VNET_HDR_SZ:
> >>   		val = READ_ONCE(po->vnet_hdr_sz);
> >>   		break;
> >> +	case PACKET_COPY_THRESH:
> >> +		val = pkt_sk(sk)->copy_thresh;
> >> +		break;
> > 
> > This is probably a good opportunity to use READ_ONCE/WRITE_ONCE for
> > this variable that can be modified and read concurrently.
> > 
> > Alternatively I can fix up all three locations in a follow-on patch.
> > 
> > No concerns with adding the getsockopt itself.
> > 
> >>   	case PACKET_VERSION:
> >>   		val = po->tp_version;
> >>   		break;
> >> -- 
> >> 2.39.2
> >>
> > 
> > 
> 
> Thanks for reviewing.
> 
> So, do I need to send PATCH V2 to add READ_ONCE?
> 
> Or do you want you to use a follow-on patch to fix all three locations 
> at once?

Please use READ_ONCE and convert the existing accesses to copy_thresh
in the same patch to READ_ONCE/WRITE_ONCE. That's simplest.

