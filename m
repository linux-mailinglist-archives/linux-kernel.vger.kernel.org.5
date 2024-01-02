Return-Path: <linux-kernel+bounces-14854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C2A82233A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0541F23154
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A3168B1;
	Tue,  2 Jan 2024 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="g7KAkPF0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5A168A2;
	Tue,  2 Jan 2024 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jEUidlbRkh+sRXZoW4h6WobGnL5gbYzACItvfn2hM+U=; b=g7KAkPF0qoG7mLFbqBmO2qi8CY
	XpyiPHFPcaiIiXMIViLFIM+WNYJHmwua303AS7aMg1KHF4DMdYXD6xESS3N4ATwfEPu1PRnZj6+fN
	SnM4ymPxRALtu1lCSvsW6fgA8xCvv7GudddxcUDqp7vr4quYnB60M+Tgeo5FBGOmTQg7woxqDsRy7
	sDy0DM3Wf4lKYEo67R6NrCY5EtIdoZQXJswZ636VHtt5OqUHmyWQtwA6dTq/SnMZf0vKuQo7Yy4LM
	PTpFe6T5h2ses5bisb3e0rXOWUG7m6/zhDvxbPh70CXCaNXZHiqFZMI83l3ppVfpf4ORZ2Vuo0XXz
	pTXkFU0A==;
Received: from lfbn-idf3-1-20-89.w81-249.abo.wanadoo.fr ([81.249.147.89]:54622 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rKmFY-00062a-7h by authid <merlins.org> with srv_auth_plain; Tue, 02 Jan 2024 13:24:36 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1rKmFW-0063xS-18;
	Tue, 02 Jan 2024 13:24:34 -0800
Date: Tue, 2 Jan 2024 13:24:34 -0800
From: Marc MERLIN <marc@merlins.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: sof-audio-pci-intel-tgl/soundwire 6.6.8 kernel outputs no sound
 on speakers but works on headphones => missing alsa-ucm-conf
Message-ID: <ZZR_Et3vvv-bmQ0H@merlins.org>
References: <20231223234430.GA11359@merlins.org>
 <alpine.DEB.2.22.394.2401021117370.14041@eliteleevi.tm.intel.com>
 <ZZRP8RqT83cE-S5m@merlins.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZRP8RqT83cE-S5m@merlins.org>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 81.249.147.89
X-SA-Exim-Mail-From: marc@merlins.org

On Tue, Jan 02, 2024 at 10:03:29AM -0800, Marc MERLIN wrote:
> 1) for sure, debian package alsa-ucm-conf should be required, not
> recommended. It's not big, people who can't keep track of everything
> that changes all the time, have no idea that they need it, and really
> need it installed by default if their hardware requires it.
> I've filed a couple of bugs with them, including on the package
> description that gives little clue that the package can be so essential

Done:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1059871
alsa-ucm-conf should be a required package by libasound2-data, it's essential on some sound hardware

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1059872
alsa-ucm-conf should be a required package, it's essential on some sound hardware

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

