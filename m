Return-Path: <linux-kernel+bounces-90676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF4B87032F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAC21C21D3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43BC3FB02;
	Mon,  4 Mar 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7oxjHHT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDC3EA73;
	Mon,  4 Mar 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560018; cv=none; b=RjOANlMMgc3W5b8PbuZsCzUvXtKK65QmEGbWhRXAdX9fAJ/rdcn47f3ZfsCvydZqroE1g2GvCiLpj5RwGRcqydqUpxZeQu7AIUlgAfXQQjrs9aDgI6SehQEMZrGaMvvivruU+2Cx+cwMytS1oI9FkX61o2nWQasOuHaxtGMO9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560018; c=relaxed/simple;
	bh=yFBwC5/sksPQ9ymeW8V7bys/1cfugBaMwQ2j7y4e7ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1McnP3cxHXbMtVEDKtYNUElzVsEfdUE5yze+3FIqWY0AxUiPbrhY1gJVxf17VyPLDiGQZThOBkSXtUHsa+IGV/YcwYMxpYfY9qTQSsD2bMXEf+LDmJpBLQ2e+A2PTj2m7cE+3hhpyprVAFQRrX3XQThaWRXe3Fbe+PwxbWQRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7oxjHHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90710C433C7;
	Mon,  4 Mar 2024 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709560017;
	bh=yFBwC5/sksPQ9ymeW8V7bys/1cfugBaMwQ2j7y4e7ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7oxjHHTg+A4+P1XacVV/zgozW0iv5PMdG9cftGboomQPo1YIj6GKGh4/h2ptKC6k
	 OCjbgsGsN5Ih77f9WceVMuXZVaolzxr2VXagSUfJcRTkmWGjY82/hW3zkFwWp4moab
	 5yJ/rRF5wAemWtqa/MO0OP+nb9P2czB4oqB5UUnjokrXYFpiQFHkTHj7z4wQrMBk9W
	 zfoNwS97M1u23f3FoUqGk6X3dOf0cSNSPpv63Ov1CBrN0K2MWsxuiGnBWmxuRFowgY
	 Ymwv+iBf1pRyd/TcP0WdTEjlLV3toexgJlqSP6ImqlcXD1LuApdQP67SlYO7BinUKq
	 kIx3adM6gt0Vw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rh8eo-000000000ZF-15wE;
	Mon, 04 Mar 2024 14:47:06 +0100
Date: Mon, 4 Mar 2024 14:47:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] USB: serial: ftdi_sio: Remove redundant assignment
 to variable cflag
Message-ID: <ZeXQ2rTMwuIOpFpo@hovoldconsulting.com>
References: <20240207104936.2441424-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207104936.2441424-1-colin.i.king@gmail.com>

On Wed, Feb 07, 2024 at 10:49:36AM +0000, Colin Ian King wrote:
> The variable cflag is being assigned a value that is not being read
> afterwards, it is being re-assigned later on. The assignment is
> redundant and can be removed.
> 
> Cleans up clang scan warning:
> drivers/usb/serial/ftdi_sio.c:2613:15: warning: Value stored to 'cflag'
> during its initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thanks.

Johan

