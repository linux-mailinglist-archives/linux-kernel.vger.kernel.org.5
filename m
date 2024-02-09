Return-Path: <linux-kernel+bounces-59178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7FB84F2A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8731C224B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A3167C67;
	Fri,  9 Feb 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="QANRJMWb"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500C67E60
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472258; cv=none; b=K59e7jAS3Go6XACNTETP4AeXYPGJzkQ8HqueOcNBZTYz0WbxIcJh9G1jFC0m7rylhuk5ZAiZ+V9VepG/kbGoiHoZkbMP1GrQh/InL8MN9ZeRiBQfNE4Q8wqXuuQdtYTz5q6owAxb2bv8hkky0B+FD0RdA8ltuoveRR6Yf9CD1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472258; c=relaxed/simple;
	bh=9rEDpVXK4h0bj5A4xqMRthG+tOZRcJFMAHYMmuaawQg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYmDCrvczMx94QIWOurXHOuBZgbezDRJktA7UnOWA3FVAbUUAqzBt8t5ud33RzXoyU6U3/fsLzgxynDVOGmRBRu4iEReoCsjp8eEEXAf4AKruOXJbS67KWAzXRVB97DpSWA4ZeofXWLqbEWuXOtLWTVABrk9hl6zYJrLV9aHt3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=QANRJMWb; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id E3727176EC1; Fri,  9 Feb 2024 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1707472249; bh=9rEDpVXK4h0bj5A4xqMRthG+tOZRcJFMAHYMmuaawQg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=QANRJMWbFjoin9/cgI8Kudi+4fb5fLLEDhEXk2aSYgqzPmDMpWCDTniWRaCwAOFID
	 lQ6WyzKZOGKtaW8ntjrSyN+JKHO5hvU3eTrE2MKLbNYgywQAx9BM8sX3C1uJpZAPU7
	 95QBzVQq4LfyW5x1SGBrOaWE2kaxOggadj2dy33Xkr7DpyXjlfBvMz6ZI+jxggzBM3
	 GswFY83GuluZZwTJOIBE05uhZkWS/m4x4k0BP8nC0twk2Moc73Ay2j2wN5YcTdOAp/
	 qJZbzHQCGSX7hU8ZKXZcuifmuS+UL0rGLDBoOrScJEwyCnLu7udi52zl2/AJ6ZqbbU
	 WYxWm/3dWPa6A==
Date: Fri, 9 Feb 2024 09:50:49 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: add boot param to disable stack dump on panic
Message-ID: <20240209095049.GA1528371@lichtman.org>
References: <20240206213902.GA1490631@lichtman.org>
 <ZcLmjrBxE2BA_hLG@archie.me>
 <20240208081425.GA1511946@lichtman.org>
 <81f2df0b-0780-458c-b432-5d61b78e8157@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f2df0b-0780-458c-b432-5d61b78e8157@gmail.com>

On Fri, Feb 09, 2024 at 04:22:12PM +0700, Bagas Sanjaya wrote:
> On 2/8/24 15:14, Nir Lichtman wrote:
> > In a lot of cases when there is a kernel panic it obscures on the display the previous problem that caused it and the main
> > reason is that the call stack prints a lot of lines on the display - and there is no way to scroll back up.
> > What led me to make this patch is that I was working on running the kernel on my old computer and when I passed root=/dev/sda
> > to the kernel there was a panic and it could not start init, but since the call stack took almost all the space on the screen,
> > I couldn't see the available partitions the kernel does detects.
> > 
> > After this patch, I could just pass in the new boot parameter I added here and then it would not print the call stack,
> > and I saw the line in which the kernel prints the available partitions.
> > 
> 
> Please don't top-post; reply inline with appropriate context instead.
> 
> Thanks for the explanation. Now please send v2 with appropriate maintainers
> and lists Cc'ed (use scripts/get_maintainer.pl to find ones). Also read
> Documentation/process/submitting-patches.rst before sending.
> 
> Ciao!
> 
> -- 
> An old man doll... just what I always wanted! - Clara
> 

Yah I read the docs about submitting patches and ran the get_maintainer script but it didn't find anything for the
changes I made (except documentation maintainers), I guess maybe the panic.c file has no main mantainer?

Thanks,

