Return-Path: <linux-kernel+bounces-90327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CAB86FDAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0714E1F232D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B3239AF1;
	Mon,  4 Mar 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="ciIiYJ2z";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="KKFrQJ0Y";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="aE7Vbpsp"
Received: from e2i652.smtp2go.com (e2i652.smtp2go.com [103.2.142.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A911B814
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544443; cv=none; b=TR9hdzmt9v9abQr82EgcfohMd+Zm7v5fbksKWUfkLxSnXKWfYR8taK8nydpOM/tYx8ifjwGRSAvrj2fEMat7ENk+fGDswDKOIttu9lV6WSn9Z0ITXgsMD3hj7GznC9SZVtuUY+xNQwr5oqCkAzmAKr8kmgst/r2/125NnPeujTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544443; c=relaxed/simple;
	bh=JImv23jdXjLRor9Cn502GabxEt1k66f48C+3dfgfdck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=docueSIYaIXC7ReR/pqtxq6PpZ7ZXwTlOmiFLj+7R/+SmEvOIqJeb/RJJoLErZ0vSmAyrEDO33GGPKZvrHSs7vmZ9FAT4OvwG9i+wMdZNIKAb0VJIgHMDoTRoWCSUy2pRD/WiBLtYTz3b83j0zJ6qsc7yFZt1UQWXTuFf4VirFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=ciIiYJ2z; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=KKFrQJ0Y; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=aE7Vbpsp; arc=none smtp.client-ip=103.2.142.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1709545335; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe; bh=W9vOf5sHthWslbSsPMC1VRrQRgKWvxP8wBkQDQnnMYc=; b=ciIiYJ2z
	RGq4rTbV03lsTmV6Z09uYFE9+72KYxyW9Ahm+OMoQxknhkhHtg3EXkfCzQ+WXyd20trJukja+9jJX
	/6GUMy405Jna6JseeKM6/nBQKWaJtOsPbMVNRufy2lvDx2eazQoBlGkS8NPJ3xAInPZtSLoMrV2uk
	YJ/xtARcEH2c128tkrXjb3sYKCigNdVEraORP1Rjl49K9JX6TFvQNR0qMrhdPt+tkKHSK39O6ymAC
	5xA1Ezs3dAQ4c3EDSYkBicPWzJNNwapGHzFHOaGzcFEY0ZBSdZWBAP0MKq+dSsigUJBPBytnSiLlH
	sVhtmq6cJRhgm0nKu5XdqgdtEQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1709544435; h=from : subject :
 to : message-id : date;
 bh=W9vOf5sHthWslbSsPMC1VRrQRgKWvxP8wBkQDQnnMYc=;
 b=KKFrQJ0YDUdfG6cR8wp9ywh/q0aGWWK5cjrCp8rZuqC7wpa1WoPZAEAjzRp9PAz5GlnHR
 GLGLG7kEBv1qehy4/UpleZOUMLbRMrIGhHRI7KoTHr00IWAqoZdFR5m6aEyehw8/sGLiVrG
 D/RMI4o6fICt+HLsWZxkC5Bir0LzI07CDKIAY/wKZGMk0oaP8zVsf0m0oIit5stCbNu2t9H
 qVF8mIf9kZQpuFFedH0Qu9NdAga6BGnslKSNw7JnFJCGN0zFwbDOghYJQd2c4FaZ7Pi8VyM
 vtep22KXjWm3e9od4DS9Qq/62L9W6QoeblPoP85X4vSEBCu6Nr5bphIt010g==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rh4b0-qt4Kr9-18; Mon, 04 Mar 2024 09:26:54 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rh4az-4XdKoZ-2b; Mon, 04 Mar 2024 09:26:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1709544413; bh=JImv23jdXjLRor9Cn502GabxEt1k66f48C+3dfgfdck=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aE7Vbpspw/DY6C8W06WXiUA89CsdLWu68EtwKacbc+h6U073E6j+GD4yi3WovCZzm
 QWKGOuGI/g6hCNfj6v8YATT38v3qaual2cTNEN9IdjddoFLAnG0smMY8PpfWuXTMpn
 UG56Nzh4AfC9viPSJh2v38y4pYXhrS3wK6cQJjeo=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id 5B8823C312; Mon,  4 Mar 2024 10:26:53 +0100 (CET)
Date: Mon, 4 Mar 2024 10:26:53 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kconfig: use linked list in get_symbol_str() to
 iterate over menus
Message-ID: <ZeWT3Wb5AYGcBcok@fjasle.eu>
References: <20240303040035.3450914-1-masahiroy@kernel.org>
 <20240303040035.3450914-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303040035.3450914-2-masahiroy@kernel.org>
X-Smtpcorp-Track: 1rh4az4bdKoZ2P.5le-9HMTqbAcH
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sYfuv_Rthp
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Sun, Mar 03, 2024 at 01:00:34PM +0900 Masahiro Yamada wrote:
> Currently, get_symbol_str() uses a tricky approach to traverse the
> associated menus.
> 
> With relevant menus now linked to the symbol using a linked list,
> use list_for_each_entry() for iterating on the menus.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/kconfig/menu.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

