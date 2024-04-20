Return-Path: <linux-kernel+bounces-152325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6668ABC69
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF53281C56
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9486D39FEF;
	Sat, 20 Apr 2024 16:22:57 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE733232
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713630177; cv=none; b=aqGeoJipSbGP/aYc4ZB6LvXzfvGDLLxGYvVi5/3s+k/bWML9YgeAqzetGaQ/Sxq7nwIUsbGXY2h3QqjM0hgCQXBk6ylko0jqK1oUcQLpz74C68rD7QhGGuWHoVhQyYb1P3+/rEZccYcOzeOaxWCFN8Jc6zzMUsKRQoz7cMfFZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713630177; c=relaxed/simple;
	bh=mPJ5a/6IaTujloeMJRg46JNhkjnIdZj2QgX4yR7EqZQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PSz5Iryepgv6uJ5qb7Mml0zKZeevWHidp8IOcScMNIEhgHM+I4ykyuKn44VcvGaBKRfvtdB++KtKbpVV1juVNMBx+zAoEq7HtO9534dp7KuI2EdbraEkFUXeAcZEYwt1gK+9zJOewbbQ6+LenneJQ8MPVwZdIhoc9CTZakkrRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 729B4802D5;
	Sat, 20 Apr 2024 16:22:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 4EF8617;
	Sat, 20 Apr 2024 16:22:46 +0000 (UTC)
Message-ID: <22344b13affea741ee41b0acb3c62884aac3e1bb.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add "Reported-and-tested-by:" tag
From: Joe Perches <joe@perches.com>
To: Nam Cao <namcao@linutronix.de>, apw@canonical.com,
 dwaipayanray1@gmail.com,  lukas.bulwahn@gmail.com,
 linux-kernel@vger.kernel.org
Date: Sat, 20 Apr 2024 09:22:45 -0700
In-Reply-To: <20240419222818.50719-1-namcao@linutronix.de>
References: <20240419222818.50719-1-namcao@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4EF8617
X-Rspamd-Server: rspamout08
X-Stat-Signature: p9menhuooc53e9he58jbpquhsbiqdmhg
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19F+L/Egwy91RlNRIn18ZKmRahtg8bu90E=
X-HE-Tag: 1713630166-134124
X-HE-Meta: U2FsdGVkX1/3zCoG6WS8xxfglEOPapA7IV7VBwNyu/LBUt47n1aeMHiYvTKuWWPswRHL1d3lMhF5yeMTfFrQkVSwOxTIgIdNf/b4pS8kOvd4lB04Y//ONU0ZWKXu+C/8QA93lynhHyDrG9jNfJ/JtwUPuL+9SiUYyG74gGZbecSvv1+yOE+FU5PKedlWGALULAG5jjknPunLuhzj6ZsuVSZFWeYCD7it3Qvj4/AGOVvE5GSr5KIG38S2RUkPb6WMtRuUkEMW6DN4vtlwoZFGVWRXFpcZvT0YOoEUcvLfG96znzK19nP4YuDZkxbyTHvz

On Sat, 2024-04-20 at 00:28 +0200, Nam Cao wrote:
> The tag "Reported-and-tested-by:" is used all the time. Add this tag.

General nack:

I think that combined tags should be avoided

see:

Documentation/process/maintainer-tip.rst:Please do not use combined tags, e=
g. ``Reported-and-tested-by``, as
Documentation/process/maintainer-tip.rst-they just complicate automated ext=
raction of tags.


