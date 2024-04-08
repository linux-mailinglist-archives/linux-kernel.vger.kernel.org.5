Return-Path: <linux-kernel+bounces-135814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557E289CBB2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F41B1C21CDC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3215C1448E5;
	Mon,  8 Apr 2024 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdE6xMQ/"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B058A25753;
	Mon,  8 Apr 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600876; cv=none; b=YjN54RFcLi7qAGv9UPhfKtMUTaRJoCTbjVscYrvjf0nfVlSPnu3CYeCKhYNESgSkFrp2k5LxxdPGy0WBGm1dzBLiggXOVs8d8nhaBo4izzJy9txfHQTHZFT0JQjistEF/fz2/yItqZg/yTcALrTTLhBrVhxn6nYK10sfjIQXNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600876; c=relaxed/simple;
	bh=SNEAHwiZ2/SqBEx1r4aC42w+KK919cWs3IE6VdePVaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDlyZVtqUejAolJIeVlOn037aru0QG6FbtKuP7MH5Y/drICCeiyCwwT8Fa9vpBOiyTvCWjpq0Y7M+jKUjYHlrhBrJV1P0HnJ0ELxlEMrUiBW7n20qvkSzXCR6btbXTJD/8HZ3NFIoLsQT4iFzAAiYymL3h/tqBfAbP+WbXSDj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdE6xMQ/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so5322805a12.3;
        Mon, 08 Apr 2024 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712600873; x=1713205673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H87O+ieoRLaVWCX2hAH7EWkWIZKVrjyzCm9L1MBqBu8=;
        b=JdE6xMQ/vpNJ1b1ewQrwcOdJbM2zq3X07LGlaN9PGAczxyjjAuANAWuliKEF6SLVTW
         SuPKnLZlSETi200wdMdKjJC1Y8N2ahqtcNOVhrYlRigDCdG2ASqDedAfwPVtuPOPFQ0+
         Ze0SqQJfmE5X+6CBifYU5jqUlsIDoZUOTBDwAjgpG9al4cyvZJ2IqjwzyrLsowf1R9gJ
         9w3NvPuxtssH5Ce/+tJN8NESOhmg8cE7i6fFTE+JnVdgn3iHhaSMJAS4H5gNPVFMIfd6
         Vx/mo24mMvRrl55XjgkmxOkykqJ/4SodK3XaIV88h0m/hBjYJHBHyQFnMR+Ep3g6aBAM
         R9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712600873; x=1713205673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H87O+ieoRLaVWCX2hAH7EWkWIZKVrjyzCm9L1MBqBu8=;
        b=wmq1K6CIJ/0NNbgWwfFBs9vGafpKUAgxc8HxbXlXuruxrqGoCfmPlpSaCUzd+K3MOF
         2QhUXLAWg/MR6crowLVsYVuT8qprKGSrkyEZDxGU+cY2kfsG6fEg8/BmkJHhcpDIbmgY
         PCKvmwqQfrk+B4ZyXqUdHYugZwCL/kG+Tkt++hNmSFd+5ACafZrHptsX+9kW3TTBaRj0
         a9SM5oGfagWWJewBViWSJ8keBW+xQaOe6wfWXqP1Kks/n3NgwAZuWBDB/t/OwG1IQb/2
         KLEh0JHqjgtOwlvYvYxfEJA7bBjrRJMs4/SFec5TkpRSxtmiKCzwG7PZ4/bxtsPJ++3u
         IEnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaEyROTanVElH9/nledmLSljciCEixSXTteBOJVOD6XBJ/wBqUruv9kUSIDVWK/FWMknveCKlET1PAMiiwFLPfNASmgrGOwxHDCf18MJ/f9GQSt075PZtxjIfHtYJ1JsaHQufOkQYt+Y7deQOokTA=
X-Gm-Message-State: AOJu0YzaZR4U+BOILzi4rSEPO4nb179LqEpFBsQhokgEtcHQcTIzmTgL
	h6TTs8NzpE8T/gJfXxzE4JwyzFSL9sAFV88ifNbjVHPUouBVulN+
X-Google-Smtp-Source: AGHT+IF/A3Mn10U1WHg8e0iglxnCMNrW0sQqf3XHbJswJ+zUr3CpfOdD/50CyuCyAfJCYN68RFynGQ==
X-Received: by 2002:a50:9e48:0:b0:56e:2464:7c4b with SMTP id z66-20020a509e48000000b0056e24647c4bmr6270548ede.10.1712600872491;
        Mon, 08 Apr 2024 11:27:52 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id i2-20020a50fc02000000b0056e22be831dsm4326912edr.42.2024.04.08.11.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 11:27:51 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Apr 2024 20:27:49 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/boot] x86/boot: Move kernel cmdline setup earlier in
 the boot process (again)
Message-ID: <ZhQ3JSXT05Kv/RpM@gmail.com>
References: <171169867308.10875.15117897441999380027.tip-bot2@tip-bot2>
 <20240408181732.GCZhQ0vGSfP3Gf8tDW@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408181732.GCZhQ0vGSfP3Gf8tDW@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Mar 29, 2024 at 07:51:13AM -0000, tip-bot2 for Julian Stecklina wrote:
> > The following commit has been merged into the x86/boot branch of tip:
> > 
> > Commit-ID:     4faa0e5d6d79fc4c6e1943e8b62a65744d8439a0
> > Gitweb:        https://git.kernel.org/tip/4faa0e5d6d79fc4c6e1943e8b62a65744d8439a0
> > Author:        Julian Stecklina <julian.stecklina@cyberus-technology.de>
> > AuthorDate:    Thu, 28 Mar 2024 16:42:12 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Fri, 29 Mar 2024 08:19:12 +01:00
> > 
> > x86/boot: Move kernel cmdline setup earlier in the boot process (again)
> 
> ...
> 
> > The order is now:
> > 
> > 	setup_arch():
> > 	  -> Assemble final command line:
> > 	     boot_command_line = builtin_cmdline + boot_cmdline
> > 
> > 	  -> early_cpu_init()
> > 	    -> early_identify_cpu()
> > 	      -> sld_setup()
> > 		-> sld_state_setup()
> > 		  -> Looks for split_lock_detect in boot_command_line
> > 
> > 	  -> e820__memory_setup()
> > 
> > 	  -> parse_early_param()
> 
> So that thing. Should we do something like the silly thing below so that 
> it catches potential issues with parsing builtin cmdline stuff too early?

Yep, that's a good idea.

Acked-by: Ingo Molnar <mingo@kernel.org>

	Ingo

