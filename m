Return-Path: <linux-kernel+bounces-146549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34A78A66F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46EB1C21B03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D108527B;
	Tue, 16 Apr 2024 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz5DZxJY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4AEEB7;
	Tue, 16 Apr 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259218; cv=none; b=DALwESeTSj9VW5nvkZynwWdSf/TJDR7TPfiujPSdfciWtTApD0r3OOwPJvyfSL/NTk4/9EL9Pmvp5yvaUNYCW/LKxk4S1jvxjZISmX3ajm5comR9ocJNPSbrQ9QvBpgtQn6mLFYyaCZhZAF2eKX7pO5UfqD+3LwSix91EfKKdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259218; c=relaxed/simple;
	bh=JdkdEMs0VGgDEoGPH/7l1eo9YTIzttLE89QjVzLRvf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUcB8G+9ebdqeWusINybPiCQMZftMwcP2GZlKUfmL4n0zLP7Z3CyjJkjWKv34OxBP0hOBb9bB2nxXlypvpjxDg2UCP8pJ1sRMrXB19AyMxUDi77lwdobpw8spkACDt9aex8MVdUOUxnJeeQAvVgQZsQAR4vihrWqHBbyi9YBHaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz5DZxJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF73DC113CE;
	Tue, 16 Apr 2024 09:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713259218;
	bh=JdkdEMs0VGgDEoGPH/7l1eo9YTIzttLE89QjVzLRvf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iz5DZxJYMjV/lqJEkIxmwYC2umpExhi9LHj3r85tw1WUdJ7ikmNGxWtGvyoehA+rl
	 BwAzPgmU67jka6mn+Vpwk8e47i/mooNw0Udz79pT5R5c/bctwBlhDMXKghwK72JlyV
	 1WoMHvIqBuNGMV0o9O+9kVa2A1b+h16cdSe3Uj+t7E8Lo4aQsJPV9SRZEZK6+cyg6Q
	 Af8HiklxwUg/nbskPkkU/wL7CVvF/ychv4a4x95Hgx9Z7k1EiWW8xTFeZUxVZ2Jr7c
	 YdnB1jRenNIqDNxz71aMxRGgrBnxyWPN9w/8ToLPcTwI+AQVRbGOKHQ5f5uUIlpaA9
	 FY80xEVQvL0RQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwezA-000000005IR-3diI;
	Tue, 16 Apr 2024 11:20:16 +0200
Date: Tue, 16 Apr 2024 11:20:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>, luiz.dentz@gmail.com,
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	quic_mohamull@quicinc.com, quic_hbandi@quicinc.com
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
Message-ID: <Zh5C0OjVoJaX-GGg@hovoldconsulting.com>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <171146704035.9961.13096206001570615153.git-patchwork-notify@kernel.org>
 <124a7d54-5a18-4be7-9a76-a12017f6cce5@quicinc.com>
 <ZgWLeo5KSLurLDhK@hovoldconsulting.com>
 <c03abbbd-faa5-4fdc-b7c3-5554a90c3419@quicinc.com>
 <Zg1KmcFQ3bAJa8qJ@hovoldconsulting.com>
 <b7d5c2ac-2278-4ccc-be2a-7c7d9936581a@quicinc.com>
 <f72d83fd-9576-4017-bcf9-c50ce94d85ec@quicinc.com>
 <Zh0NhA4GBxIAM-ZI@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh0NhA4GBxIAM-ZI@hovoldconsulting.com>

On Mon, Apr 15, 2024 at 01:20:36PM +0200, Johan Hovold wrote:
> On Mon, Apr 15, 2024 at 04:22:51PM +0530, Janaki Ramaiah Thota wrote:
> 
> > Are you planing to merge your below patch ?
> 
> Yes, sorry about the delay. Was busy with other things last week.
> 
> I'll revisit and post it shortly.

For the record, I've now posted a fix for this here:

	https://lore.kernel.org/r/20240416091509.19995-1-johan+linaro@kernel.org

Johan

