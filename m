Return-Path: <linux-kernel+bounces-111056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D30488676F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CA41F249D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4977112E4E;
	Fri, 22 Mar 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPBpSAhB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA761118C;
	Fri, 22 Mar 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092208; cv=none; b=V07E8Y4lpfj0vInZ8klsXOks3g8X8NcE5um3R6qWy5YgHi1/ELjZvLaoNUm7itEcG2h9gwILLfpitxnsSLo71Kog23cO1ZTrYBpJ8qTfn+XvFlWyNRdJ9ZuoxGB6PUvL07MNW2t6dZYNUniuIsUR8Lwr5RkY03xv0mOF11ItPa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092208; c=relaxed/simple;
	bh=Q/3MvluITXi2QV4z0UOfR1lTHTBrYJAoBMKg7YnHWxE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fiu26G44m+etpXGYR754YQigBeRcfEMEdf50pYdi9U4UI3OmXW7sWv0ks6KxjUUHa4BG1u2sZZzD/XKt9brgBXGEcPJfhrX8M7GVxl6pL3IXk93Bgd/WTSFlLp89RxaOHoCyyX+uOLTsHADLhA4HFOzYRzNg6XHRBKb9KYki4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPBpSAhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2491DC43390;
	Fri, 22 Mar 2024 07:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711092208;
	bh=Q/3MvluITXi2QV4z0UOfR1lTHTBrYJAoBMKg7YnHWxE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=cPBpSAhB2s9Juunw7Dv2n291i/USA+u8olKNPlEHF24Jl3tW7QNNGbHycX5i6AQWS
	 UoRB/JXvi0JC6bcR9/0me+CCkahhtui7zmkFGICMS2qjlhRXyzj2AT7mRVK8B4P0HZ
	 WaHOLsg30WfUFMkFe6NBSL8fZnT682gY4Km8LjUBQphIPz1n9i1mHIGCTZaG8yrktI
	 oKXAzTSx+anqn7dnSWrir9AxLfsqDQRIVIN9N2OIxep/BBKYtch18GJnO/sJE1QYvd
	 BmtO/PGcNdYUkfE5pw10cjXtl08d2pIBIks/gSt2WSIvUwb/2ODXUQc6/MekJtIV1e
	 HH1W8j8BIFfGg==
From: Kalle Valo <kvalo@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as mwifiex driver reviewer
References: <20240321163420.11158-1-francesco@dolcini.it>
	<87y1ab8r13.fsf@kernel.org> <20240321173648.GA12994@francesco-nb>
Date: Fri, 22 Mar 2024 09:23:25 +0200
In-Reply-To: <20240321173648.GA12994@francesco-nb> (Francesco Dolcini's
	message of "Thu, 21 Mar 2024 18:36:48 +0100")
Message-ID: <871q823f2q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Francesco Dolcini <francesco@dolcini.it> writes:

> Hello Kalle,
>
> On Thu, Mar 21, 2024 at 06:54:00PM +0200, Kalle Valo wrote:
>> Francesco Dolcini <francesco@dolcini.it> writes:
>> 
>> > As discussed on the mailing list [1], add myself as mwifiex driver reviewer.
>> >
>> > [1] https://lore.kernel.org/all/20240318112830.GA9565@francesco-nb/
>> 
>> I'm nitpicking but the preferred way is to use the Link tag. I can fix
>> that.
>
> I can also send a new version with that fixed, whatever is the best for you
> works for me.

Thanks but no need to resend. I implemented an edit command to my
patchwork script just for cases like this :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

