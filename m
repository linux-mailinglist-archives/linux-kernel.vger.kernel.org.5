Return-Path: <linux-kernel+bounces-104532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A787CF58
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB81F214EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286133C470;
	Fri, 15 Mar 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="eFFMsEf+"
Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C736381BB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513926; cv=pass; b=u20LFN/TqqbgI1B5gdJtdful+ciPBOKCAuhBvTFr8mFKbF1pN210eA8XnsGHSuVZ2hp4AsOIDzSRvbxyqlum40LNZ+Xm3qDTdhDyfc0v5MVZmc72edKCbeH/PcBZRRs+z7eYg59JzkRDYg3LHQMoJotvggnSVngJsrM6I/Zd8NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513926; c=relaxed/simple;
	bh=UPOVduM4KWXTPI0rPFyER2ipUUmq2vfrHT/ySZHihgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW3PLezRFr4hStBpUaXoed6RrRH2SwBAVulx34kTt3zGnlzrppQY14FkgMoJx7bnnnIAVJy7EMLK5Lv65WSAGIVUtbYdzW4y/z/WsiuZr5UFsKP+lbdWwhTYP2/zirxZyFRg6nWTTgF5Z2xcyyDcvWyRXizC9EifE/KVb7qedls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=eFFMsEf+; arc=pass smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 31426101E2F;
	Fri, 15 Mar 2024 14:36:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 72A04101254;
	Fri, 15 Mar 2024 14:36:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1710513411; a=rsa-sha256;
	cv=none;
	b=JbyjpatXgTKNLtkEW0A6UGqVR1AYYKoNhwnrHYWSpRZO6+fCVToCnYvMYwDfH55IIeZpy8
	wY8czThXwztQTeRt+NjChcVhVvuBRwPMgUcHa/DLjL0A3Yn5glRF+GOf2BOXZTCI+f49Al
	raR1FtgDOYIMndvaoNsBbqcUOPVX2Cd6kzCBzDPS9SGm6ssbikBEu3N3qVBLmk/q0IEmX0
	npa/YcqPzTGLEnuwYN0zGrBQObDL+7YOwTI2jFU00Sy8oVT2Xj+rl2YWPbHzho6lMIyiV9
	3rAvwhY+CBDpMhSCU7cDLtGo7rV9sPKOMvaku38oMtB7yxqdGuj7rVoeJrbWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1710513411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UPOVduM4KWXTPI0rPFyER2ipUUmq2vfrHT/ySZHihgU=;
	b=iYay3OJibjfIpEVN8ZJtv7slcUoaWZ9cXtckU2/t82IZL/8SA+Ey05vLtehstWtNjUiNmM
	f7c9BX2XCZjZa5wrMnryLmvJZRBFvU+5ntHyZxFitFn8bwJvybxaqySeA7U3Z3dq1wwec5
	XrbZBLAXkBBwHGHj7xg/mPzaIkQOK2E6PhvzDx7mToGX44xPzt7mtxURcZ1/Z3PF/dbe4J
	LIi1I8Pzdvb1oL09pJTvKbHv1sX5h8f/GxVrMBvyg4hZCvtlsX3fTypKtOoTWM+UigriRA
	zDTA641yE9kDa7w3CJt0b3Oey22DHOz75pUmv/25uNbRwoeAZWnc6lkIvCrLSA==
ARC-Authentication-Results: i=1;
	rspamd-5f6b6bd7ff-zmxd5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Sponge-Trade: 13037ad42b6beed6_1710513411878_3166923847
X-MC-Loop-Signature: 1710513411877:3438096717
X-MC-Ingress-Time: 1710513411877
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.100.41 (trex/6.9.2);
	Fri, 15 Mar 2024 14:36:51 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4Tx6Jf5kvrz1S;
	Fri, 15 Mar 2024 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1710513411;
	bh=UPOVduM4KWXTPI0rPFyER2ipUUmq2vfrHT/ySZHihgU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=eFFMsEf+zCLCBQQCwfMIDZllHaEjAVVhef+RKDMYsx6NWsyjFuRFLDXnaShsPDP5M
	 QdiD+hvOLWoyIVbFEeyvg0hKrySq8FJ/txIQ9zHSiBoZ7UDyR2qeeG+kXPYC/QQ6cV
	 6lV9976qOLyRPFwXwwCKsb7cjZcmCjtj9ajBYfUASfwQpLaYVk3R3V/ZLooegUXddz
	 oQmK4ZotlNQ8sSzGyajr122BnIIik53laSXwTa5azp/4K7v/JOIB2jmXA3ll1g7ocy
	 8BCEKQlkRD/AqTxQ20S8hR2kz4pWsd5yIJvsKj0AiZWgOWfiGGKkztr8lLbKexCzDg
	 ZfHoQincNKN6w==
Date: Fri, 15 Mar 2024 07:36:47 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, jhubbard@nvidia.com, vbabka@suse.cz,
	mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH 3/3] mm/vmstat: simplfy extfrag_show_print with
 fragmentation_index()
Message-ID: <20240315143647.nr6hrtgoejwphh5c@offworld>
Mail-Followup-To: Luis Chamberlain <mcgrof@kernel.org>,
	akpm@linux-foundation.org, jhubbard@nvidia.com, vbabka@suse.cz,
	mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	p.raghav@samsung.com, da.gomez@samsung.com
References: <20240314005436.2962962-1-mcgrof@kernel.org>
 <20240314005436.2962962-4-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240314005436.2962962-4-mcgrof@kernel.org>
User-Agent: NeoMutt/20220429

On Wed, 13 Mar 2024, Luis Chamberlain wrote:

>fragmentation_index() already uses the stack for the struct contig_page_info,
>so just use that and enhance the documentation for fragmentation_index().
>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

