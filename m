Return-Path: <linux-kernel+bounces-91751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BB871611
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB651F217D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F767B3CA;
	Tue,  5 Mar 2024 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnCeYb3C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249401EA6F;
	Tue,  5 Mar 2024 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621542; cv=none; b=j/bYlCasPg4H8fKnUUYOP/q8itY/HmFF3WHZ+TOvLEu/rUxvOyvVGFVYYVwkpJsal7hBzphBOCtgLasSjh4gH3aoMjLjSMeIaiiKucAvOx/M8Z45JYmrxuo5TAPLIkPzbkA4GiGdrAg1XU4uThRQ9WtmPOKqZxcMZ1IhQYn27KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621542; c=relaxed/simple;
	bh=+Gq84Sdlfj32pUUHZBRxkvmZBTDQkBdK7lw3dj9WE5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy6qEGdd3YOqtlSLke734YQotH/kM1ZckU3vC1CEPCubYIWhu4BB/EF3v29h9/bO4OM8hzEm2r0tv7VwQpP0qi+EFp6B9DEIkX6+X49k6JZtBKytT6NIo8dIwR8qsUGp04XqlLzQztIF/PsUo1PrvSmc9eYOr5T10OEWngkA0Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnCeYb3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91940C433F1;
	Tue,  5 Mar 2024 06:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709621541;
	bh=+Gq84Sdlfj32pUUHZBRxkvmZBTDQkBdK7lw3dj9WE5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rnCeYb3Cp6AtOvMUzOJQz+wMpj+stTg0OGsmieQ9z3XC/0eVSwMQPKyZ6eb2rsoEX
	 UQ9IH7+QFkXD3VL6D5HGTFlaBzPjPK9W7yghiErZcNJRVwKwW0kELzmUYAN9HdQqMV
	 QhaVMPuuol2uixZATBjdmlOGzt9Q0uCwRuwg/A0ffufrwLc2ItV979stat/g4UoPZ5
	 WfLW3pBEPaxJEAuI4ee10g88F+AkxKCwcmSVW+61zdlpf4WAgdF7cacewJlO/8NEnB
	 u9rQNl1pGT9Dh8YRR5pieebDqcqN7zkW109Fx0HviFGYtI5Zqj9xZs5VOPM2mvtsNm
	 CJMKM36yLGGsQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rhOf5-000000002BV-3iIA;
	Tue, 05 Mar 2024 07:52:27 +0100
Date: Tue, 5 Mar 2024 07:52:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Toru Katagiri <Toru.Katagiri@tdk.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: add pid/vid for TDK NC0110013M and
 MM0110113M
Message-ID: <ZebBK7v36zWRpKsd@hovoldconsulting.com>
References: <20240304234614.3811-1-Toru.Katagiri@tdk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304234614.3811-1-Toru.Katagiri@tdk.com>

On Tue, Mar 05, 2024 at 08:46:14AM +0900, Toru Katagiri wrote:
> TDK NC0110013M and MM0110113M have custom USB IDs for CP210x,
> so we need to add them to the driver.
> 
> Signed-off-by: Toru Katagiri <Toru.Katagiri@tdk.com>

Applied, thanks.

Johan

