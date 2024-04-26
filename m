Return-Path: <linux-kernel+bounces-160564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB58B3F31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D171C235E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5850C16E888;
	Fri, 26 Apr 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="T13clV67";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1mD2BcG"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89245037;
	Fri, 26 Apr 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155806; cv=none; b=cKCJ7D4d/KgQdSR0YdIr3N8MJdhqJ+t58bX8Umk8XWX+AouavHJFj1/Nx4NnHtztFHmVlHO729vNLBe5O3jU6Rbnv8XutNzDU8JWU7HPBNsK0mo0b0htJuGiWPdZDbuMeNb4+lO0efprGfrwJoj47k0NBRv4SbKKi5SIfrFc1qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155806; c=relaxed/simple;
	bh=AdSo0Q6YNhJsuAOB1X7CHnljeCBv0U8dMhZm578k/Fs=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzo0QuYy0Z+y8QHZZ6c9Pd45n23SMKbjBpWJbsjkX+gIOouU9KVvphue5dkIP0I7ZreYOnbmhiN7V9F3C310CJ9Hs8OYWkb9Y4yb9en2v2rs/2WYkw06acRUc+qqEOzid6Lf1bDeuQpkWOYa/MYf3j8cNL6pyar6sV7a9GuzP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=T13clV67; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z1mD2BcG; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6031E1800090;
	Fri, 26 Apr 2024 14:23:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 26 Apr 2024 14:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714155801; x=1714242201; bh=F9cSC2Wo0Z
	/qlYmQgkUvvjtknFVMj+Q6laJAkMRV3y8=; b=T13clV67IZkE+Thx1FXEaP2aua
	AaiD2rDHXY4I4I/+UL53lWnjvDHiUbhzJ+AVDF+u98FQ9ZmoOzYXbJBZjZfH23sj
	G6KrPWZigCizkrc1PkJ6kXDeL6nhKE4vtRUXbpyFWtV7SCNdwWPCRQ60GNFA+KaE
	5kxoJViM2aq1MlHejKiZQD9uKv3g584ED4ZuajKH4Y27xcGRP2cLzzDtRp7iCt4j
	f8QE7yW1nH617I92ee8lOIQAtYtXyWzuQKyFjTpwL9oBax/ZjXS9L4ucUtkx2r6e
	7V/j4Ws6jyi9323U80SlPcwAJUw+0LxtD7q0MoxRHECMx/AfZCI4GfnpY/+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714155801; x=1714242201; bh=F9cSC2Wo0Z/qlYmQgkUvvjtknFVM
	j+Q6laJAkMRV3y8=; b=Z1mD2BcGYp+KiSsYc683qyA9FWTFiH2mo2NZcl2PmJ8W
	3Ra0zZtE2u/+ujEzTDTeXLqwwuhvMzWPJG31dcG/1e+yGiwnc2vDObgD0zG0cJwD
	PmYmnEJu6yldSZnh7T75p8RL9AO3ykqdzy32mzyWXKyvHpib4kz7zg0nAvY152zt
	VD8Lrk+QdS4TV+OIftukUrPcteRAVkBxgGjUsFOaDWHjyifLJY73JgiYpO/kJwSt
	J+a8ALBfmYddhNsRgW6LGl8HH1Av4I99uxisIB0PNeDKCjxajO7r97qxV2+KCa1o
	Hzvzt041iY1lZ2fNguyIKYmLnX/P2UhfbDKvumRDsA==
X-ME-Sender: <xms:GfErZraIHBDKHxc8dx6MeK8senGzDSJAu8sXYcVPJvYAbv2JxAdAgQ>
    <xme:GfErZqbVt6JaeNfiLNedsAnHSINzlX_Nws6wyU1ZW8_gBdFku2IIIuJ4hvRzxktxB
    RRgYlDiMNcN01uPygY>
X-ME-Received: <xmr:GfErZt9zoVJdMGJipF_aPrOiL8DkOz8ZreJ_o1yhdXNr8mZvS85glZq2VFbclpuifIRbEjIyR1VMw8sFm8JRXvkscDhqRO_ZSJWlXn0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelledguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnhihn
    ughonhcuufgrnhgthhgvuceolhhsrghntghhvgeslhihnhguvghnohdrtggrqeenucggtf
    frrghtthgvrhhnpeektdeuvddtfeeuueduteehtdeuhfeufedtfeduveelveeiteefheel
    geekgfelfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhsrghntghhvgeslhihnhguvghn
    ohdrtggr
X-ME-Proxy: <xmx:GfErZhocULUdE0e1CmAZLvd2Z_z6rm_V1IhHdYuhdwUODKDT7YqFGQ>
    <xmx:GfErZmoXl9wwxzKacbiljPFV7kifHSfw2BPyGvvyHo0-kwLD4ust9w>
    <xmx:GfErZnTQ_K3eccWRjDTR6FKvgfqknWNU5WlooG7Ao6uHrNELhWC5tQ>
    <xmx:GfErZuqKem2H2r4JgyS0TcNXw_QXqNt1DIv-UR62vxXl93Bx0w_M3g>
    <xmx:GfErZl13bEL85tJoqeCxtkS4mTp2jbCBvXdbfX3fATF9H4_UbUULHext>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Apr 2024 14:23:19 -0400 (EDT)
Date: Fri, 26 Apr 2024 12:23:11 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Matthew Garrett
	<mjg59@srcf.ucam.org>, Pali =?iso-8859-1?b?Um9o4XI=?= <pali@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?iso-8859-1?q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Message-Id: <N2BKCS.UBBG0H0KMCYF2@lyndeno.ca>
In-Reply-To: <13fe0f7c7da2cb6ce52ec34d4648e90e40f2fbc0.camel@linux.intel.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
	<a6009bed-aa34-4a3f-91f5-23937e915132@amd.com>
	<24c7a9ea-7755-4270-a338-4701c8e262e2@app.fastmail.com>
	<13fe0f7c7da2cb6ce52ec34d4648e90e40f2fbc0.camel@linux.intel.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Fri, Apr 26 2024 at 09:14:07 AM -07:00:00, srinivas pandruvada 
<srinivas.pandruvada@linux.intel.com> wrote:
>> Can you share output of acpidump tool to me? I want to make sure if
> there is some way the platform will bypass thermal table if you 
> changed
> to some profile.
> 
> Thanks,
> Srinivas

Hello Srinivas:

I used acpidump. For sake of completeness I ran acpidump with each of 
the thermal modes enabled. The files are too large to provide here so I 
uploaded them to a public gist:
https://gist.github.com/Lyndeno/65ade5a15f1f2cd07175256dc021f551

Please let me know if there is a more appropriate medium for sharing 
files like this, and I will remember for next time.

Thank you,

Lyndon



