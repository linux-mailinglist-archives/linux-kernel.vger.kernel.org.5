Return-Path: <linux-kernel+bounces-140175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034BF8A0C65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC69E1F25CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D3C144D1B;
	Thu, 11 Apr 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP+U9tUy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253B613DDDD;
	Thu, 11 Apr 2024 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827737; cv=none; b=Zx73wKccsQbIskyKTU0plda4Ano+J69Z+6QjFDt1Z3dJJ8o05PaIY6BJtBrxzIsTt/nt9sgBKfjiUZ5ev6rVXBLdzibRnwMdxpx/VZRfNd5S+t3ukKpH7AxLQjam/ezqA1Ha3AoLVt1ghBQ7985dCgMiGOa015aoKDVTav9XtDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827737; c=relaxed/simple;
	bh=2I1/4qZuQ40nFxqyqIJAUShzzfUDscacEy2/72jyb4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOmUjGe7jMeuiIXV37j58TARFw5tt0KHNarfo65ea96vxu3oPb2AHVEinwrbsuenJN7UKO9uaKkL0/tB0qRKajSDYsjuV4GuG732FcgfKNxzubDTNRaV5mwiI2ysUt1l/oFckE5zO1xWWjYP0v52zzzDrCh6YPH0Wy+hm8r2CiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP+U9tUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32392C433C7;
	Thu, 11 Apr 2024 09:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712827736;
	bh=2I1/4qZuQ40nFxqyqIJAUShzzfUDscacEy2/72jyb4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WP+U9tUyFkgpFim5PCThH6Zs7yz+il51IuFchPawYBrBzEaUCUIfps/yhn62DS1lv
	 1MuYp1UZ5xqR8b/rWRn0vLBlgMX9TMXXq+gvCAh61ZPRnUWJ/Kqk39hh3T3P6z+xWw
	 lOCcDSPuI3GH03dwwzptgrvTt0oWz9/2FGYRSN/HzXf4sOYlQY3WFSfh8rgi+DIdd4
	 Vpyctb/OmDMeQG8IDiNvP0zXkRuc02lgzo2llSPV7WhkP7ccMTeyvUXv4nXZ+zN9Dt
	 4uM5QCPzXR9i/4euCSNFBTpZpkeccfvCwU5sHwnZG98b1Tpe9D4atHQ9nXFMFRIwlx
	 nnXWduaJa6Kjw==
Date: Thu, 11 Apr 2024 14:58:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	bard.liao@intel.com
Subject: Re: [PATCH 6/7] soundwire: debugfs: add interface to read/write
 commands
Message-ID: <ZhetVE6RQXmGQrVg@matsya>
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
 <20240326090122.1051806-7-yung-chuan.liao@linux.intel.com>
 <Zg_ka02zLnXrADGj@matsya>
 <19f21879-885c-4120-9411-7022f526426f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19f21879-885c-4120-9411-7022f526426f@linux.intel.com>

On 05-04-24, 10:12, Pierre-Louis Bossart wrote:
> On 4/5/24 06:45, Vinod Koul wrote:
> > On 26-03-24, 09:01, Bard Liao wrote:
> >> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >>
> >> We have an existing debugfs files to read standard registers
> >> (DP0/SCP/DPn).
> >>
> >> This patch provides a more generic interface to ANY set of read/write
> >> contiguous registers in a peripheral device. In follow-up patches,
> >> this interface will be extended to use BRA transfers.
> >>
> >> The sequence is to use the following files added under the existing
> >> debugsfs directory for each peripheral device:
> >>
> >> command (write 0, read 1)
> >> num_bytes
> >> start_address
> >> firmware_file (only for writes)
> >> read_buffer (only for reads)
> >>
> >> Example for a read command - this checks the 6 bytes used for
> >> enumeration.
> >>
> >> cd /sys/kernel/debug/soundwire/master-0-0/sdw\:0\:025d\:0711\:01/
> >> echo 1 > command
> >> echo 6 > num_bytes
> >> echo 0x50 > start_address
> >> echo 1 > go
> > 
> > can we have a simpler interface? i am not a big fan of this kind of
> > structure for debugging.
> > 
> > How about two files read_bytes and write_bytes where you read/write
> > bytes.
> > 
> > echo 0x50 6 > read_bytes
> > cat read_bytes
> > 
> > in this format I would like to see addr and values (not need to print
> > address /value words (regmap does that too)
> > 
> > For write
> > 
> > echo start_addr N byte0 byte 1 ... byte N > write_bytes
> 
> I think you missed the required extension where we will add a new
> 'command_type' to specify which of the regular or BTP/BRA accesses is used.
> 
> Also the bytes can come from a firmware file, it would be very odd to
> have a command line with 32k value, wouldn't it?

ofc no one should expect that... it should be written directly from the firmware file

> I share your concern about making the interface as simple as possible,
> but I don't see how it can be made simpler really. We have to specify
> - read/write
> - access type (BRA or regular)
> - start address
> - number of bytes
> - a firmware file for writes
> - a means to see the read data.
> 
> And I personally prefer one 1:1 mapping between setting and debugfs
> file, rather than a M:1 mapping that require users to think about the
> syntax and which value maps to what setting. At my age I have to define
> things that I will remember on the next Monday.

Exactly, you won't remember all the files to write to, my idea was a
simple format or addr, N and data.. a TLV kind of structure..

What would happen if you issue go, but missed writing one of the files.
Also I would expect you to do error checking of inputs...

Thanks
-- 
~Vinod

