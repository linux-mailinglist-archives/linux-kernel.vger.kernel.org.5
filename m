Return-Path: <linux-kernel+bounces-20800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C765882855F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688701F24ACD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E473638DFB;
	Tue,  9 Jan 2024 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QA0hOQoZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3138DE0;
	Tue,  9 Jan 2024 11:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC48CC433C7;
	Tue,  9 Jan 2024 11:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704800699;
	bh=ZHek6cnUD/06G1ff9DHO+IrMfmDIWNNJ3OElbgXKZgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QA0hOQoZdvG+WySnNIvWkgT88AHPzZr7yQU3E1sn49Tk+Qsvq3qJN4RpQYU+no2rN
	 ZlsayES1RLtYXz0X2zQaiphsEuOhr0UAVwx2iRNrfNHwvlJ/8aprhL2YQygSNMMUTb
	 0ejbhQHt85PRQsgNTm64r5KQ9qrJY9pGGGFVGWL0=
Date: Tue, 9 Jan 2024 12:44:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= <stanley_chang@realtek.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
	Alan Stern <stern@rowland.harvard.edu>, Roy Luo <royluo@google.com>,
	Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>,
	Flavio Suligoi <f.suligoi@asem.it>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] usb: core: add phy notify connect and disconnect
Message-ID: <2024010925-splendid-thorn-3221@gregkh>
References: <20231213031203.4911-1-stanley_chang@realtek.com>
 <20231213031203.4911-4-stanley_chang@realtek.com>
 <bdb2c10798124e228b8562576d73b881@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdb2c10798124e228b8562576d73b881@realtek.com>

On Tue, Jan 09, 2024 at 02:08:57AM +0000, Stanley Chang[昌育德] wrote:
> Hi Greg,
> 
> Please help review these series of patches.

I was hoping that someone else would review these, which didn't seem to
happen at all, which is odd for something that I thought many others
wanted to see merged.

It will have to wait until after 6.8-rc1 is out.  To also help this out,
please help review other changes that are submitted to the lists as that
will reduce the maintainer load here.

And again, if anyone else cares to see these merged, please help review
them, the Cc: list here is very long...

thanks,

greg k-h

