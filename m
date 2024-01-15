Return-Path: <linux-kernel+bounces-26493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF2A82E20E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890DF283A45
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8049E1B26E;
	Mon, 15 Jan 2024 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NF6eOHXF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C11B263;
	Mon, 15 Jan 2024 20:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAC6C433F1;
	Mon, 15 Jan 2024 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705352366;
	bh=Eg/cuXDf5YeywAvQy/2fhowQLmusCXNSruyp654JP0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NF6eOHXF476O0WXrnL3TqP9EJxGNayQImGnM1x8O0bmh9B1xdFF2NMuSNB0FGj+Q5
	 dE0B0iLFpQx9BPSjYW6U9cmUzpV4CqT5l/KQYH+8SIDQ2wKpF9RChq/KhQ3Y8H2k6x
	 tOMLI7/7b1JhTDstGPkPAtGxYAg0TH/vOQ7mQ/eY=
Date: Mon, 15 Jan 2024 21:59:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, x86@kernel.org,
	Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH stable] x86/microcode: do not cache microcode if it will
 not be used
Message-ID: <2024011543-dropout-alienable-a9e9@gregkh>
References: <20240115102202.1321115-1-pbonzini@redhat.com>
 <2024011502-shoptalk-gurgling-61f5@gregkh>
 <CABgObfZ0gpw2-n2d5vyEjuCefOp+3TPyUuMvjScAbae2GKfO0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZ0gpw2-n2d5vyEjuCefOp+3TPyUuMvjScAbae2GKfO0A@mail.gmail.com>

On Mon, Jan 15, 2024 at 07:54:59PM +0100, Paolo Bonzini wrote:
> On Mon, Jan 15, 2024 at 7:35 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jan 15, 2024 at 11:22:02AM +0100, Paolo Bonzini wrote:
> > > [ Upstream commit a7939f01672034a58ad3fdbce69bb6c665ce0024 ]
> >
> > This really isn't this commit id, sorry.
> 
> True, that's the point of the mainline kernel where the logic most
> closely resembles the patch. stable-kernel-rules.rst does not quite
> say what to do in this case.

Ok, then just say, "this is not upstream" and the rest of your changelog
is good.  I'll edit it up tomorrow and apply it, thanks.

greg k-h

