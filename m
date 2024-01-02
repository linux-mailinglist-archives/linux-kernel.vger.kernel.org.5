Return-Path: <linux-kernel+bounces-14810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616648222B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554DEB2274E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21325168AC;
	Tue,  2 Jan 2024 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="T43T4vEG";
	dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="EFP/QkiJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D6168A4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1704228306; h=date : from : to : cc : subject : in-reply-to :
 message-id : references : mime-version : content-type :
 content-transfer-encoding : from;
 bh=GnZF4mIISpOEIwEtlw5zMtgawqrnFodCwR1ogQWF28w=;
 b=T43T4vEGgdzhL7UWt2vl5V3A0GYfMugfnwFF6XSCAWvIkL6cabCkovPNEPEYTC5xxKF4Q
 D+RWSUmpUhagO4zBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1704228306; h=date : from :
 to : cc : subject : in-reply-to : message-id : references :
 mime-version : content-type : content-transfer-encoding : from;
 bh=GnZF4mIISpOEIwEtlw5zMtgawqrnFodCwR1ogQWF28w=;
 b=EFP/QkiJcK14ic0W28pv62q3/LzPoMolj0RsZxQ4bbr/F9dwIHGx1Kkp45T1OYJOSeJ7C
 ml2z4+vJ145k0g8WKyLgdBqv/8GKpD6qyvdYWQ++hDI3wHDB07Fww+9KgskMcdVPhPc7GVQ
 5CBTdbTBMANulost8IgXlhjOZ/g68+VY3OPM/fDyDeSN0M7kETkNigwqO1S50N3Gqu3lRkF
 0XfkmHIbdTvR/ViIrcahvYhkRDtRLMIZmqEe+HvgRruoCLdyHa238epSZvEBZJutJhjutIL
 vSPOdcMhR1QKhCn4RtZ9XXWIeLDdEIqpjycspDJv3BaqyUKzDGVZfgfCrHPQ==
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id 652AB5FEDC;
	Tue,  2 Jan 2024 21:45:06 +0100 (CET)
Date: Tue, 2 Jan 2024 21:45:06 +0100 (CET)
From: Christian Kujau <lists@nerdbynature.de>
To: =?utf-8?Q?Luis_Mu=C3=B1oz_Fuente?= <luis.munoz.edu@juntadeandalucia.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: I can't activate term(e) and kill(i) magic SysRq key
In-Reply-To: <002cc4da-e502-4c79-97bd-0a8b6cb2630c@juntadeandalucia.es>
Message-ID: <464f7af8-d83d-d2e3-c635-772ed6a3cb54@nerdbynature.de>
References: <002cc4da-e502-4c79-97bd-0a8b6cb2630c@juntadeandalucia.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 1 Jan 2024, Luis Muñoz Fuente wrote:
> I try to activate all magic SysRq key options according to:
> https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html
> but I can't activate term(e) and kill(i) option, is this option
> disabled?

Maybe. Some distributions choose to disable certain sysrq functions. See 
the page you cited, on the very top: what does "sysctl kernel.sysrq" say? 
If it's anything but "1", certain or all sysrq functions are disabled.

HTH,
C.
-- 
BOFH excuse #264:

Your modem doesn't speak English.

