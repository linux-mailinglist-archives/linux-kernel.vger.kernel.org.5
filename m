Return-Path: <linux-kernel+bounces-112551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EA5887B6F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDB8282383
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91F6127;
	Sun, 24 Mar 2024 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mdwqG+3F"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3006B81E;
	Sun, 24 Mar 2024 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711246706; cv=none; b=e7PS6kQO3GxgM3Bb3szbR2f2MSoBNr1tsa40CsjPBTRBLJq7SM07pGs/IA16pY+rKalYmrdeNWZ5koJKYZmFT795FBwmcm3Awa8KRyTKZeh8OnDX1Cw6q4Mm+hVkEAGqlTDuM+jJZmeMGNcjZvqUStfbMdr4K9d0W9Ly1BS6kg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711246706; c=relaxed/simple;
	bh=F7pwxm/tPBGKtUMC3ZEfCKwrCmIoRVUfDtH/CDYn3zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=VsIgaDkoaQloFmBoLLKOoR0PJzWWfLEWUj0YNZzgqiuCkpdVzSkyqkgh187Ir9zWAoAoQDFk8+qrSuD5Oiuml4F0rjxhOAAkzH+nMp/azaqMow0gVACNvpQXpgJtDMgsaOeg5CLfuHH3BhdwgFND6JLi73vK/lLgoQ7oTlxBHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=fail (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mdwqG+3F reason="signature verification failed"; arc=none smtp.client-ip=156.67.10.101; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-430ccb3d65eso25263761cf.2;
        Sat, 23 Mar 2024 19:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711246704; x=1711851504;
        h=content-transfer-encoding:content-disposition:mime-version
         :list-unsubscribe:list-subscribe:list-id:precedence:dkim-signature
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJuSN2mVtkWQkOpaD8kHP46jLo5a0+0zPP26wEDEV+I=;
        b=pDRZTC0Mq6mRdHaGobo78rxCltbGz9WLlWZz2itzB5vvbTxjpwEbPEE+Soon05IVmN
         LkpTaAIkMwQ0iDchKsSS0JqbMDhsFbyh6HzFHm+A08LVJfOI1n5lWnrcCPiBIxCaoK+1
         GOUqBsgcsRt8WigluS8VanFKciAFD+/DikNyWLKHgYaYzg1i9c6PchMoa823Y6oLq7T/
         RhsK3xZ0HDzNG4OerfuO+GIg03BaBC4FiJK2KylWOVe5CV/qnvGMq1k/WeFMG8bpSmNn
         3nSV6kC5EqwE6DzzNc+BmEdq1SMDGp099eNowVRHKlnGrpXqnmIleJNdD2YEmVt37mPd
         42LA==
X-Forwarded-Encrypted: i=1; AJvYcCVYKKErEfVU+wSld46Qka0BnAPlbm5cqWRLQZLDPMsK3PERSzG1h6cc0q/tcVQDsV4g6CNVrrO9N2wR+NhNXIIBp6UxGGjAlNwpbTzUk0DYBn2hGHo2Ma6iy4fOon+BjkigRopbAy+nRd2tpBZXTMsrnB2KejwJmu3AGcuh/Q==
X-Gm-Message-State: AOJu0YxslrTEJ/YXKkzYFKbtQeCVqdJwVoMh3c0ILUMViYC6VzjgDGKA
	GqyjcpyQUm8bLvv6OGv7WJrh/+GdanB61AHkRu0TAnvCoNdKpqn0
X-Google-Smtp-Source: AGHT+IHfae4sSWGgGhbwqfimhP9OqnVAZk5eIcBi4qMuJEqqbsNr0gM5SssOJWxb6nduPIOrhnE6og==
X-Received: by 2002:a05:622a:174b:b0:431:4e88:b8ef with SMTP id l11-20020a05622a174b00b004314e88b8efmr925159qtk.26.1711246703894;
        Sat, 23 Mar 2024 19:18:23 -0700 (PDT)
Received: from l1441l.lan0.xorvpn.com (pool-98-116-41-146.nycmny.fios.verizon.net. [98.116.41.146])
        by smtp.gmail.com with ESMTPSA id bc13-20020a05622a1ccd00b004309b22265asm1266241qtb.75.2024.03.23.19.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 19:18:23 -0700 (PDT)
From: Daniel Hodges <hodges.daniel.scott@gmail.com>
To: andrew@lunn.ch,
	Daniel Hodges <hodges.daniel.scott@gmail.com>
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	lee@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@ucw.cz
Subject: Re: [PATCH 1/3] leds: trigger: legtrig-bpf: Add ledtrig-bpf module
Date: Sat, 23 Mar 2024 22:15:02 -0400
Message-ID: <a9662071-8050-46b7-8416-d440d45bbb52@lunn.ch>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>
References: <cover.1711113657.git.hodges.daniel.scott@gmail.com> <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDF12940B; Sat, 23 Mar 2024 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version: References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject: Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding: Content-ID:Content-Description:Content-Disposition:In-Reply-To:References; bh=F33wnbx3Y36tdDg+lawZFiW4Fv7MKDor5UODN7GSPC8=; b=mdwqG+3FksuYxx7/e8MH3Wp5bU 4QoFdM3A/3u16qenQEZuOh35DPyFmWVNmeYw3kPwA7ZpH3e+kaRugfnzAmcr1fvQds7NQA4u6nSk+ rCbjDcrwOptaGm/CITDxSLalhNdDLB7TXz5MXlwt71jxo9rfjT+KeWStdOnagboJIML8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2) (envelope-from <andrew@lunn.ch>) id 1ro9hQ-00B4Rx-HJ; Sat, 23 Mar 2024 23:18:48 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

From: Andrew Lunn <andrew@lunn.ch>

On Fri, Mar 22, 2024 at 10:08:14AM -0400, Daniel Hodges wrote:
> This patch adds a led trigger that interfaces with the bpf subsystem. It
> allows for BPF programs to control LED activity through calling bpf
> kfuncs. This functionality is useful in giving users a physical
> indication that a BPF program has performed an operation such as
> handling a packet or probe point.

Don't you want a mechanism to say which LED it should blink? Say you
have a BPF IR receiver, a BPF kernel scheduler and a BPF firewall. All
sharing the same LED is probably not what you want. Each probably
wants its own LED.

      Andrew


