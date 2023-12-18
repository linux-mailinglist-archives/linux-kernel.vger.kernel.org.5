Return-Path: <linux-kernel+bounces-4346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 340E7817BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AFB1C21645
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F3B7207B;
	Mon, 18 Dec 2023 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jyqDQJ9K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B12748784;
	Mon, 18 Dec 2023 20:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A722C433C8;
	Mon, 18 Dec 2023 20:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702931205;
	bh=WuoEVPVLN9oOBFfH8vfaebbZ9s3fmmcnT85DcEkwSQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyqDQJ9Km8w2/+M3lrtuEz0/KoOFqhtl6QdHT17dV/lV9B895W9NJZZ8wanEL37Fq
	 wBqR91lJUUP6ygqUW5DABUS/z4CaBpioCsQzXjjWvKLG/ejArX34tBiQD2KX4+59v3
	 R9BarTNNazmdq18Fp76qaMTiDFkBy5KE+kXXfV+s=
Date: Mon, 18 Dec 2023 21:26:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: tanzirh@google.com
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
Message-ID: <2023121813-slate-humped-024b@gregkh>
References: <20231218-libstringheader-v3-0-500bd58f0f75@google.com>
 <20231218-libstringheader-v3-1-500bd58f0f75@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218-libstringheader-v3-1-500bd58f0f75@google.com>

On Mon, Dec 18, 2023 at 06:44:47PM +0000, tanzirh@google.com wrote:
> This patch creates wordpart.h and includes it in asm/word-at-a-time.h
> for the all architectures. WORD_AT_A_TIME_CONSTANTS depends on kernel.h
> because of REPEAT_BYTE. Moving this to another header and including it
> where necessary allows us to not include the bloated kernel.h. Making
> this implicit dependancy on REPEAT_BYTE explicit allows for later
> improvements in the lib/string.c inclusion list.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>

Note, your email name is not set so this will not work properly when it
is committed to the tree :(

thanks,

greg k-h

