Return-Path: <linux-kernel+bounces-45492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8432784316D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215371F23F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF8179959;
	Tue, 30 Jan 2024 23:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ivpu/CkG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01C37708;
	Tue, 30 Jan 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706658058; cv=none; b=A9IA5kFRAw2BT1OofokKUCZ5Y6QIT+AG3h7vnl3GxnTFV5Qn5NTFu6VF9L9/iBl53FYAw92N9kMVclZ5Ua1XpMy+NRG0J4em/sP4KF79ypaiZLR+GgjSIc1T/7FzeBBZwd2XoUC3cJw3u+rgWs+n5G+5d8S6daCuzmoNXEzWVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706658058; c=relaxed/simple;
	bh=Nx0CiS6ywPNVMOvWJqQQzTBmYRvePR93fgFNjSqYYgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE+C9mFb8kooy/SaMipJ7kyQ3MTPjmf0yNSIXe5QQXamt03MBkM7hknlHplmbSOTKtFNsCB0/U6dtn521+2+dpSrjKDBkYnbmSA6cO/YOwj2FIjE5reRjNR+9VUN2EMYH43MMsxmgRRDtPAhZgNLZtPVZDL4K46DyhuD1LlBp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ivpu/CkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369D7C433C7;
	Tue, 30 Jan 2024 23:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706658057;
	bh=Nx0CiS6ywPNVMOvWJqQQzTBmYRvePR93fgFNjSqYYgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivpu/CkGkLqC39CsG3MjaC2hHG7pbDn8WkrZYJK3iaqvehvw8Gm5VAVTKaIaZFb5I
	 0E+P/oJ4c77I+2CT9J0bwZSeGwWidTWCt0dZa96DXbPSscdQhAikOvShiH/cfNXRn5
	 NJe+DCa81BZcly21+sC4j1T45DI70NyfVGvxp6Fk=
Date: Tue, 30 Jan 2024 15:40:56 -0800
From: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>
To: "Corona, Ernesto" <ernesto.corona@intel.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"'oleksandrs@mellanox.com'" <oleksandrs@mellanox.com>,
	"'jiri@nvidia.com'" <jiri@nvidia.com>,
	"Castro, Omar Eduardo" <omar.eduardo.castro@intel.com>,
	"'omar.eduardo.castro@linux.intel.com'" <omar.eduardo.castro@linux.intel.com>,
	"'pombredanne@nexb.com'" <pombredanne@nexb.com>,
	"'arnd@arndb.de'" <arnd@arndb.de>,
	"'bbrezillon@kernel.org'" <bbrezillon@kernel.org>,
	"'rdunlap@infradead.org'" <rdunlap@infradead.org>,
	"'johan@kernel.org'" <johan@kernel.org>,
	"'axboe@kernel.dk'" <axboe@kernel.dk>,
	"'joel@jms.id.au'" <joel@jms.id.au>,
	"'palmer@sifive.com'" <palmer@sifive.com>,
	"'keescook@chromium.org'" <keescook@chromium.org>,
	"'vilhelm.gray@gmail.com'" <vilhelm.gray@gmail.com>,
	"'federico.vaga@cern.ch'" <federico.vaga@cern.ch>,
	"'Jonathan.Cameron@huawei.com'" <Jonathan.Cameron@huawei.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	"'christian.gromm@microchip.com'" <christian.gromm@microchip.com>,
	"'linus.walleij@linaro.org'" <linus.walleij@linaro.org>,
	"'zzyiwei@google.com'" <zzyiwei@google.com>,
	"'rubini@gnudd.com'" <rubini@gnudd.com>,
	"'viresh.kumar@linaro.org'" <viresh.kumar@linaro.org>,
	"'mika.westerberg@linux.intel.com'" <mika.westerberg@linux.intel.com>,
	"Filary, Steven A" <steven.a.filary@intel.com>,
	"'vadimp@mellanox.com'" <vadimp@mellanox.com>,
	"'amithash@fb.com'" <amithash@fb.com>,
	"'patrickw3@fb.com'" <patrickw3@fb.com>,
	"Chen, Luke" <luke_chen@aspeedtech.com>,
	"'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
	"'rgrs@protonmail.com'" <rgrs@protonmail.com>
Subject: Re: [PATCH 30 1/7] Add JTAG core driver
Message-ID: <2024013050-humped-tibia-50a9@gregkh>
References: <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>

On Tue, Jan 30, 2024 at 11:26:19PM +0000, Corona, Ernesto wrote:
> JTAG class driver provide infrastructure to support hardware/software JTAG platform drivers. It provide user layer API interface for flashing and debugging external devices which equipped with JTAG interface using standard transactions.

Again, properly wrap your changelog please.

And your patch series isn't even threaded, how did you send this?  Just
use 'git send-email' please.

> 
> Driver exposes set of IOCTL to user space for:
> - XFER:
>   SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
>   SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
> - GIOCSTATUS read the current TAPC state of the JTAG controller
> - SIOCSTATE Forces the JTAG TAPC to go into a particular state.
> - SIOCFREQ/GIOCFREQ for setting and reading JTAG frequency.
> - IOCBITBANG for low level control of JTAG signals.
> 
> Driver core provides set of internal APIs for allocation and
> registration:
> - jtag_register;
> - jtag_unregister;
> - jtag_alloc;
> - jtag_free;
> 
> Platform driver on registration with jtag-core creates the next
> entry in dev folder:
> /dev/jtagX

That's a lot for a single patch to do, please break this up into
reviewable chunks.

thanks,

greg k-h

