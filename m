Return-Path: <linux-kernel+bounces-128640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C49895D54
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E1FB281BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4D15D5A5;
	Tue,  2 Apr 2024 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b="i/dRZnKz"
Received: from mail.wantyapps.xyz (mail.wantyapps.xyz [66.135.5.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54B15CD6D;
	Tue,  2 Apr 2024 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.135.5.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088623; cv=none; b=PfQQGBzi1mBtrsqfySHraXwkn8KGe68TEwi4bmRCk/SUoFLt9DpyJNE5vQnwIuZAwYbGOSpI1KIcc3xqeHh47iUm7lKf4hIncwt2zosft1m2phUaoFIh5xF6rdcIiDnFz61qyiPth3JnU1img88g3xs4zeFr0QNpIuFVnHKOwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088623; c=relaxed/simple;
	bh=NWFs8ZjoAcKvlavjcHgWQwIvtp4RzrF6ag2SedTaudg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9igQ+o8yThYxSjqV4wa5WuukqemHFfhelgmAL54lxMtjNmnWD+s0ml+Obp9KEL+CzyzNcWOKxfVqC8yXW1EAAVbRt3cOGJVlH2F5NNHnX+nXc7Oz0pj9VlSJjnMXq6d/bmd4FPDhKC+Yzvxvwnp0cClSNRBpdHGBaUmA8QhTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz; spf=pass smtp.mailfrom=wantyapps.xyz; dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b=i/dRZnKz; arc=none smtp.client-ip=66.135.5.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantyapps.xyz
Received: from multivac (unknown [147.235.205.62])
	by mail.wantyapps.xyz (Postfix) with ESMTPSA id 7DD4393CF5;
	Tue,  2 Apr 2024 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
	s=mail; t=1712088620;
	bh=NWFs8ZjoAcKvlavjcHgWQwIvtp4RzrF6ag2SedTaudg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=i/dRZnKzWnzc/DfE0zEIALy0kt5zdPJnqxFsW/cU6E6AIo6QAtpMYXr/Yd94/NegN
	 1jLY0hEA2V5w930+y2guwfs40Up2eKqVQv9dFofBJ1ZNoWn56QMZFVR3nLpT3FAJvP
	 7NRCFN70VVUrYE6NPLNGb+7y0GZtt4C2eObkILKcDgaBpvK4RDwJtOZjzaVQD9Yi71
	 rsFpStXX2qJZO3R0nL1/HmTr9xkYmJEstErocawOXmGQu5mkZWL4SUgPa3OnPr7R3q
	 0l4nOpCkXbYB6JrfEWcdXFVYJfDtTztHa0Be5XTf4n252pSZxjPlETz+lsaIk6S8Ls
	 HICUfdWMn4AUQ==
Date: Tue, 2 Apr 2024 23:10:16 +0300
From: Uri Arev <me@wantyapps.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_intel: Fix multiple issues reported by
 checkpatch.pl
Message-ID: <nip5vnycbq6vbtwx553yaym6mtnz5f3qzkfzpduidf7qrky7ux@7hufve7ptxwi>
References: <20240402183751.107948-1-me@wantyapps.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402183751.107948-1-me@wantyapps.xyz>

Hey, it seems that the CheckSmatch test has failed for this revision (v2)
and the first version of this patch as well. I checked lore.kernel.org
and patchwork.kernel.org and it seems that the test has failed multiple
times for multiple unrelated patches. Is this a problem that can safely
be ignored?

                 Uri Arev

