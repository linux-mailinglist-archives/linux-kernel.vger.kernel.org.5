Return-Path: <linux-kernel+bounces-148389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86CC8A81DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6735A1F223CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311E613C8EE;
	Wed, 17 Apr 2024 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0j42wxDD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616D13342F;
	Wed, 17 Apr 2024 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352597; cv=none; b=lDuqSThiGwyviIrVy7FLtgx/ZiQ7qvKIK4W5TS6L7zPLVoDDdgefm/MaC3a+0Tpe5DP5JfQUzo9Kw8MF36hnRH7ikNaHAMDwlCvr7s/r/5oeqvYOj7JLLYEnE0Znhe25Hq2y9q2JSY1QWEaJfiNGqWmLY2t6JEKq4Pj3KKzddB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352597; c=relaxed/simple;
	bh=J1guA/8Q1nxaOMJybVAHeAOBsi8OBvR9dKilJUEQdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNajUp1G7HPoj5vbd9JONqzGIfuuhkyjMrnaW3opq2+V7VjSMr/gzolTbFg1MapughsOWiazupdv7TLzr6sm1yyvt47t8ca31Xm8j7Uu/JGfg0tJMk8hs3SFb1Ef8EKyykbjIhAeeSBzo1EAyPlDHpwMb1fHTX06FgzMaAiOhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0j42wxDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA81C072AA;
	Wed, 17 Apr 2024 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713352597;
	bh=J1guA/8Q1nxaOMJybVAHeAOBsi8OBvR9dKilJUEQdr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0j42wxDDfmWMpzFIR9ES8LiBNZMPD6PDAIvnhkLmIX+ayKguhapQJy9cFZless0dZ
	 Xqm29qAzj8l1UkqkRz9rvDFLlvM0v3ldTp3WugpNQI+ZXup3CyS7bTU1ZznHU83kiR
	 xlHv2bOITE8BJK0KoywSD2Z1GEfbAb2p0X2qf1/I=
Date: Wed, 17 Apr 2024 13:16:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 2/8] serial: exar: remove old Connect Tech setup
Message-ID: <2024041710-composed-agenda-ed82@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
 <e85dc81f8cecfb8dc416fd845089f7f2ba3338ba.1713270624.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e85dc81f8cecfb8dc416fd845089f7f2ba3338ba.1713270624.git.pnewman@connecttech.com>

On Tue, Apr 16, 2024 at 08:55:29AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Preparatory patch removing existing Connect Tech setup code and
> CONNECT_DEVICE macro.

Preparatory for what?  You are removing support here, right?  And will
you be adding it back later?

thanks,

greg k-h

