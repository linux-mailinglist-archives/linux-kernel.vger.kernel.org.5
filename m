Return-Path: <linux-kernel+bounces-144978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E19D8A4D83
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0FA28318D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10DE5F575;
	Mon, 15 Apr 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZwKCYjm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9E41E896;
	Mon, 15 Apr 2024 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180040; cv=none; b=Te8JxHcQtE3tjQHIXYq0UDNFVwnnEmTcYFFwtJDBeiP9LmRBhKkEvrl+GCjhTRjpRHY54B7jwjMtHajBzeUj79o0vL+lwW8ER+mJSh7VqKaVoVhuUfFqutMDJvla228MDilyN/ENch5MRGmbEcuV/fOMnzMkTGL4887oudE+lyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180040; c=relaxed/simple;
	bh=JMkJX+sGRihrij1cC4kSPG1zD7tukGxRvQoNWXYOLUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSgD1woj0GAU75U1hI19dsjuWU1yKHJmeXCNxbe4pA77c7VyMHW1l2QrhBOyenmUWxQj4DnCRuLvWe9g3JwEwhbRcYSN5jCEio7fPW3KqPD/yMK6zHb75tai/TRb+45OVIOe2GnkNxiwgaaSm4M1dFCBCiF5OnDAg/cIlaTXT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZwKCYjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A22CC113CC;
	Mon, 15 Apr 2024 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713180039;
	bh=JMkJX+sGRihrij1cC4kSPG1zD7tukGxRvQoNWXYOLUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZwKCYjmv+cQCQ+ilhSYhU9weBxAa/QDvjY25cLGIrNmzN9somBBy2IZB3Fkx9SQx
	 gl5WZdPrhx+fwxhD+2x++moIeKvyPYx3iaofYWBRhDyFAVPg4mX7CnIygOYovHZvId
	 FbQai/u8rdVsYas1JOH56CTqp7Rde+/ald8joSo4Bc8H2J20rwJVeYiM+y2vBAEvZ5
	 u9MH56o1S6rjTmkbb0x6nEHUa53K17g/zRAL6Xzrci1P0PjRfrQWrEVjc4mZnwa6j2
	 8qj4183ZlaJKP4DlMxtAdZijuICE9wqzrUz0wxAOruNpMaEfBkCFfxHHeKJxFawcis
	 fQtmHEuF8XSHw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwKO4-000000006Nl-0ZtL;
	Mon, 15 Apr 2024 13:20:36 +0200
Date: Mon, 15 Apr 2024 13:20:36 +0200
From: Johan Hovold <johan@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>, luiz.dentz@gmail.com,
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	quic_mohamull@quicinc.com, quic_hbandi@quicinc.com
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
Message-ID: <Zh0NhA4GBxIAM-ZI@hovoldconsulting.com>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <171146704035.9961.13096206001570615153.git-patchwork-notify@kernel.org>
 <124a7d54-5a18-4be7-9a76-a12017f6cce5@quicinc.com>
 <ZgWLeo5KSLurLDhK@hovoldconsulting.com>
 <c03abbbd-faa5-4fdc-b7c3-5554a90c3419@quicinc.com>
 <Zg1KmcFQ3bAJa8qJ@hovoldconsulting.com>
 <b7d5c2ac-2278-4ccc-be2a-7c7d9936581a@quicinc.com>
 <f72d83fd-9576-4017-bcf9-c50ce94d85ec@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f72d83fd-9576-4017-bcf9-c50ce94d85ec@quicinc.com>

On Mon, Apr 15, 2024 at 04:22:51PM +0530, Janaki Ramaiah Thota wrote:

> Are you planing to merge your below patch ?

Yes, sorry about the delay. Was busy with other things last week.

I'll revisit and post it shortly.

Johan

