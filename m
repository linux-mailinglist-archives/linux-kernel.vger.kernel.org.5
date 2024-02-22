Return-Path: <linux-kernel+bounces-76153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6709B85F389
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C14D1F23CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3387A2C6B3;
	Thu, 22 Feb 2024 08:55:04 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360F2182CF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592103; cv=none; b=kjFglqJ2LAQP2i2T178vS59DneKfjutSF4w6AGWZ/UykC3Qa+/khQxJZkF9M6OtjVUlrFEGgqdnXI90CE7ReL/h4n0I8NdDB7aRYDZNq9PdFJJWKyKu9I705RbWlM7+SN0EIRDAgcOSbVvn7C6YZ/RRq02Kv9S3L7ctEVeBnOIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592103; c=relaxed/simple;
	bh=wTDvPl8dm66auWwd3uQfCoI7e+y7Z3KyOyRzcK3p/uQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NsEir/rbT2jAPw67o+uQQqVJGhz+JNosqiXDp4Z8JVxA7zBS8WkhnCtA72QpEu9cP89yWFsdbrW9zz7c4BIP8RVYx3mhhbopZA/+Vm+6WIcDpCcZ9giHbbvDZG7ED/AjBinpimXHLPHss+p9xl4dMz4aKA88Jo/BLMmB9xiEn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 594E11C0E74;
	Thu, 22 Feb 2024 08:54:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id EEE2E20013;
	Thu, 22 Feb 2024 08:54:52 +0000 (UTC)
Message-ID: <ffec7c7b8eb86f573e420e0582075ba1e75d0e54.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: Don't check for unified diff format in
 git sendemail headers
From: Joe Perches <joe@perches.com>
To: Saravana Kannan <saravanak@google.com>, Andy Whitcroft
 <apw@canonical.com>,  Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
Date: Thu, 22 Feb 2024 00:54:51 -0800
In-Reply-To: <20240222051539.3001988-4-saravanak@google.com>
References: <20240222051539.3001988-3-saravanak@google.com>
	 <20240222051539.3001988-4-saravanak@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: EEE2E20013
X-Stat-Signature: e4s369aym95kkztwqpmw81ew69czd4px
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/vysysgt0kGD3YajaH0s+haFydobC7xJM=
X-HE-Tag: 1708592092-415675
X-HE-Meta: U2FsdGVkX189vf7UYiSDdwy11WwOxlrXfgzvXZZMTiZFXRfd6Z1OywRV//dKlInfMI8yomtIYdQIZwfDrXX1edEDWTPyGYcUVn9nDszjF6W3+pIf2Rd44HPmJmfTcuexdIH5aTpyoS7h+v9Ou/22VAVTxHJtu93qjhFzyJlzE4oNkot5cilBI0QGfNqDmbmgBuiPL/HJKO5qm1/yaCIB/uwKaEdPFRvoBsSNOKt+Wft1lKSBcCZAlKscDAX696oFY7NeByu23R/Eaui9EpxxmN8jnTJ9IcsT3LY46odO6NTIvHJ9H1UBvNQfDfWoIate

On Wed, 2024-02-21 at 21:15 -0800, Saravana Kannan wrote:
> When checkpatch is used as a git sendemail-validate hook, it's also passe=
d
> in the email header for sanity check.

Why?

If so, why not use a front-end script to stop/remove
the file from being scanned by checkpatch?

> These headers are, as expected, not
> in unified diff format. So, don't complain about unified diff format for
> these header files.


